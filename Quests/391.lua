-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 391;
local ReqClv = 22;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 819;
local RewCxp = 4224;
local RewJxp = 1677;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 5;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 39101);
	Saga.AddStep(cid, QuestID, 39102);
	Saga.AddStep(cid, QuestID, 39103);
	Saga.AddStep(cid, QuestID, 39104);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk with Heinrich
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1050);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1050 then
		Saga.GeneralDialog(cid, 3936);
		Saga.SubstepComplete(cid, QuestID, StepID, 1);
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Collect Body Culvert Gutter Mouse (8)
	Saga.FindQuestItem(cid, QuestID, StepID, 10147, 4089, 8000, 8, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10148, 4089, 8000, 8, 1);
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid)
	-- Talk with Heinrich
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1050);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1050 then
		Saga.GeneralDialog(cid, 3936);
	
		local ItemCountA = Saga.CheckUserInventory(cid,4089);
		if ItemCountA > 3 then
			Saga.NpcTakeItem(cid, 4089,4);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_4(cid)
	-- Visit Regina Salisbury
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1010);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1010 then
		Saga.GeneralDialog(cid, 3936);
	
		local ItemCountA = Saga.CheckUserInventory(cid,4089);
		if ItemCountA > 3 then
			Saga.NpcTakeItem(cid, 4089,4);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		end
	end
	
	-- Check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	StepID = CurStepID;
	local ret = -1;

	if CurStepID == 39101 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 39102 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 39103 then
		ret = QUEST_STEP_3(cid);
	elseif CurStepID == 39104 then
		ret = QUEST_STEP_4(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
