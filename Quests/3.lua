-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 3;
local ReqClv = 11;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 408;
local RewCxp = 929;
local RewJxp = 368;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 10;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 301);
	Saga.AddStep(cid, QuestID, 302);
	Saga.AddStep(cid, QuestID, 303);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 0 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1);
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
	-- Do nothing
	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk to mischa
	Saga.AddWaypoint(cid, QuestID, 301, 1, 1000);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1000 then
		Saga.GeneralDialog(cid, 34);
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
	return 0;
end

function QUEST_STEP_2(cid)
	Saga.Eliminate(cid, QuestID, StepID, 10061, 7, 1);

	-- Check if all substeps are completed
	for i = 1, 1 do
		 if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		 end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid)
	-- Hand over to Kaftra
	if ret == 1123 then
		Saga.StepComplete(cid, QuestID, StepID);
		Saga.QuestComplete(cid, QuestID);
		return -1;
	end
	
	return 0;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 301 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 302 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 303 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
