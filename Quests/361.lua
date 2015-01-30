-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 361;
local ReqClv = 29;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1598;
local RewCxp = 6215;
local RewJxp = 2486;
local RewWxp = 0;
local RewItem1 = 0;
local RewItem2 = 0;
local RewItemCount1 = 0;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 36101);
	Saga.AddStep(cid, QuestID, 36102);
	Saga.AddStep(cid, QuestID, 36103);
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
	-- Talk with Ireyneal
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1023);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1023 then
		Saga.GeneralDialog(cid, 3936);
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
	-- Find Polluted Soil samples (1)
	-- Find Polluted Iron Pieces (10)
	
 	Saga.FindQuestItem(cid, QuestID, StepID, 33, 4171, 10000, 1, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 34, 4172, 10000, 10, 2);

	-- (De-)Activates the Action Objectd on request
	if Saga.IsSubStepCompleted(cid, QuestID, StepID, 1) == false then
		Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 33, 0);
	else
		Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 33, 1);
	end
	
	if Saga.IsSubStepCompleted(cid, QuestID, StepID, 2) == false then
		Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 34, 0);
	else
		Saga.UserUpdateActionObjectType(cid, QuestID, StepID, 34, 1);
	end

	-- Check if all substeps are completed
	for i = 1, 2 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, 902);
	return 0;
end

function QUEST_STEP_3(cid)
	-- Talk with Ireyneal
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1023);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1023 then
		Saga.GeneralDialog(cid, 3936);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4171);
		local ItemCountB = Saga.CheckUserInventory(cid, 4172);
		if ItemCountA > 0 and ItemCountB > 9 then
			Saga.NpcTakeItem(cid, 4171, 1);
			Saga.NpcTakeItem(cid, 4172, 10);
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

	if CurStepID == 36101 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 36102 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 36103 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
