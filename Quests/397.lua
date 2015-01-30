-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 397;
local ReqClv = 1;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 10;
local RewCxp = 5;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 0;
local RewItem2 = 0;
local RewItemCount1 = 0;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	Saga.GeneralDialog(cid, 3957);
	return 0;
end

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points

	Saga.AddStep(cid, QuestID, 39701);
	Saga.AddStep(cid, QuestID, 39702);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end

function QUEST_FINISH(cid)
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	-- Add all waypoints
	Saga.AddWaypoint(cid, QuestID, 39701, 1, 1139);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1139 then
		Saga.NpcGiveItem(cid, 4245, 1);
		Saga.SubstepComplete(cid, QuestID, 39701, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,39701, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 39701);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Add all waypoints
	Saga.AddWaypoint(cid, QuestID, 39702, 1, 1064);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1064 then
		Saga.GeneralDialog(cid, 3936);
		if Saga.CheckUserInventory(cid, 4245) > 0 then
			Saga.NpcTakeItem(cid, 4245, 1 );
			Saga.SubstepComplete(cid, QuestID, 39702, 1);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,39702, i) == false then
			return -1;
		end
	end
	
	-- Clear waypoints
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 39702);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;

	if CurStepID == 39701 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 39702 then
		ret = QUEST_STEP_2(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret ;
end
