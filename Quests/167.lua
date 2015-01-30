-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 167;
local ReqClv = 12;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 212;
local RewCxp = 900;
local RewJxp = 360;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 2;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 16701);
	Saga.AddStep(cid, QuestID, 16702);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk with Hena
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1152);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1152 then
		Saga.GeneralDialog(cid, 3936);
		local freeslots = Saga.FreeInventoryCount(cid, 0);
		if freeslots > 0 then
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
			Saga.NpcGiveItem(cid, 3979, 5);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Give Ripe Pumpkin to Regina Salisbury
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1010);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1010 then
		Saga.GeneralDialog(cid, 3936);
		local ItemCountA = Saga.CheckUserInventory(cid, 3979);
		if ItemCountA > 4 then
			Saga.NpcTakeItem(cid, 3979, 5);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		end
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
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	StepID = CurStepID;
	local ret = -1;

	if CurStepID == 16701 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 16702 then
		ret = QUEST_STEP_2(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
