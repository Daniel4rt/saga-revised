-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 365;
local ReqClv = 27;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 913;
local RewCxp = 5335;
local RewJxp = 2134;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 6;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 36501);
	Saga.AddStep(cid, QuestID, 36502);
	Saga.AddStep(cid, QuestID, 36503);
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
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid)
	-- Eliminate Blut Twitter (6)
	-- Eliminate Rusty Pinoli (6)
	Saga.Eliminate(cid, QuestID, StepID, 10322, 6, 1);
	Saga.Eliminate(cid, QuestID, StepID, 10323, 6, 1);
	Saga.Eliminate(cid, QuestID, StepID, 10324, 6, 2);
	Saga.Eliminate(cid, QuestID, StepID, 10325, 6, 2);
	
	-- Check if all substeps are completed
	for i = 1, 2 do
		if Saga.IsSubStepCompleted(cid,QuestID,StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_3(cid)
	-- Report to Ireyneal
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1023);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1023 then
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
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	StepID = CurStepID;
	local ret = -1;

	if CurStepID == 36501 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 36502 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 36503 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
