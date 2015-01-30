-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:18 PM

local QuestID = 377;
local ReqClv = 31;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1199;
local RewCxp = 7860;
local RewJxp = 3132;
local RewWxp = 0;
local RewItem1 = 1700115;
local RewItem2 = 0;
local RewItemCount1 = 3;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 37701);
	Saga.AddStep(cid, QuestID, 37702);
	Saga.AddStep(cid, QuestID, 37703);
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
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid)
   -- Find Hammerrick's Drill Arm (8)
	Saga.FindQuestItem(cid, QuestID, StepID, 10341, 4187, 10000, 8, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10342, 4187, 10000, 8, 1);
	
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

function QUEST_STEP_3(cid)
   -- Report to Moritz Blauvelt
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1026);
	
	-- Check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1026 then
		Saga.GeneralDialog(cid, 3936);
	
		local ItemCountA = Saga.CheckUserInventory(cid, 4187);
		if ItemCountA > 7 then
			Saga.NpcTakeItem(cid, 4187, 8);
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

	if CurStepID == 37701 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 37702 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 37703 then
		ret = QUEST_STEP_3(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
