-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 419;
local ReqClv = 26;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1085;
local RewCxp = 4950;
local RewJxp = 1969;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 8;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 41901);
	Saga.AddStep(cid, QuestID, 41902);
	Saga.AddStep(cid, QuestID, 41903);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)Done
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
	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk with Yan
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1181);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1181 then
		Saga.GeneralDialog(cid, 3933);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Gather Entraion's Egg Shell (5)
	Saga.FindQuestItem(cid, QuestID, StepID, 10129, 4227, 8000, 5, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10130, 4227, 8000, 5, 1);
	
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
	-- Hand in to Kafra Board Mailbox
	local ret = Saga.GetActionObjectIndex(cid);
	if ret == 1123 then
		local ItemCountA = Saga.CheckUserInventory(cid, 4227);
		if ItemCountA > 4 then
			Saga.NpcTakeItem(cid, 4225, 5);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		else
			Saga.InventoryNotFound(cid);
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
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 41901 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 41902 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 41903 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
