-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 28;
local ReqClv = 12;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 292;
local RewCxp = 675;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 5;
local RewItemCount2 = 0;
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 2801);
	Saga.AddStep(cid, QuestID, 2802);
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
	return 0;
end

function QUEST_STEP_1(cid, StepID)
	-- find 5 sea Flatro
	Saga.FindQuestItem(cid, QuestID, StepID, 10066, 2659, 4000, 5, 1);
	Saga.FindQuestItem(cid, QuestID, StepID, 10067, 2659, 4000, 5, 1);

	--check if all substeps are completed
	for i = 1, 1 do
		if Saga.IsSubStepCompleted(cid, QuestID, StepID, i) == false then
			return -1;
		end
	end
	
	Saga.StepComplete(cid, QuestID, StepID);
	return 0;
end

function QUEST_STEP_2(cid, StepID)
	-- Deliver items to Zarko Ruzzoli
	Saga.AddWaypoint(cid, QuestID, StepID, 1, 1005);

	--check for completion
	local ret = Saga.GetNPCIndex(cid);
	local ItemCount = Saga.CheckUserInventory(cid, 2659);
	if ret == 1005 then
		Saga.GeneralDialog(cid, 3936);
		if ItemCount > 4 then
			Saga.NpcTakeItem(cid, 2659, 5);
			Saga.SubstepComplete(cid, QuestID, StepID, 1);
		end
	end

	--check if all substeps are completed
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
	
	if CurStepID == 2801 then
		ret = QUEST_STEP_1(cid, StepID);
	elseif CurStepID == 2802 then
		ret = QUEST_STEP_2(cid, StepID);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end
