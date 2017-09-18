-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 2;
local ReqClv = 4;
local ReqJlv = 0;
local NextQuest = 323;
local RewZeny = 60;
local RewCxp = 108;
local RewJxp = 42;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 2030001;
local RewItemCount1 = 3;
local RewItemCount2 = 1;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points
	
	Saga.AddStep(cid, QuestID, 201);
	Saga.AddStep(cid, QuestID, 202);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1);
		Saga.GiveItem(cid, RewItem2, RewItemCount2);
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- Get 2 Vadon Fry Shells
	-- Get 1 Vadon Shell
	Saga.FindQuestItem(cid, QuestID, StepID, 10015, 2643, 8000, 2, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10016, 2643, 8000, 2, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10017, 2610, 3971, 1, 2);
	Saga.FindQuestItem(cid, QuestID, StepID, 10018, 2610, 3971, 1, 2);
	
	-- Check if all substeps are completed
	for i = 1, 2 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Talk to mischa
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1000);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1000 then
		Saga.GeneralDialog(cid, 30);
		Saga.NpcTakeItem(cid, 2643, 2);
		Saga.NpcTakeItem(cid, 2610, 1);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end


function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	local StepID = CurStepID;
	
	if CurStepID == 201 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 202 then
		ret = QUEST_STEP_2(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
