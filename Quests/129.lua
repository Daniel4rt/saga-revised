-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 129;
local ReqClv = 9;
local ReqJlv = 0;
local NextQuest = 151;
local RewZeny = 152;
local RewCxp = 208;
local RewJxp = 0;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 2;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	Saga.GeneralDialog(cid, 3957);
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 12901);
	Saga.AddStep(cid, QuestID, 12902);
	Saga.AddStep(cid, QuestID, 12903);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end
function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	Saga.GiveItem(cid, RewItem2, RewItemCount2);
		return 0;
	else
		return -1;
	end
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	Saga.StepComplete(cid, QuestID, 12901);
	return 0;
end

function QUEST_STEP_2(cid)
	--Find a Black Stripe Tuna's Belly;Find a Be Chased Mermaid's Scale;
	
	Saga.FindQuestItem(cid, QuestID, 12902, 10052, 4069, 8000, 5, 1);
	Saga.FindQuestItem(cid, QuestID, 12902, 10053, 4069, 8000, 5, 1);
	Saga.FindQuestItem(cid, QuestID, 12902, 10034, 4073, 8000, 5, 2);
	Saga.FindQuestItem(cid, QuestID, 12902, 10035, 4073, 8000, 5, 2);

-- check if all substeps are complete
	for i = 1, 2 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12902, i) == false
	then
	return -1;
	end
	end
	Saga.StepComplete(cid, QuestID, 12902);
	return 0;
end

function QUEST_STEP_3(cid)
	--Talk with Adria
	Saga.AddWaypoint(cid, QuestID, 12903, 1, 1143);
	--check for completion
	local ret = Saga.GetNPCIndex(cid);
	local ItemCountA = Saga.CheckUserInventory(cid, 4069);
	local ItemCountB = Saga.CheckUserInventory(cid, 4073);
	if ret == 1143
	then
	Saga.GeneralDialog(cid, 3936);
	if ItemCountA > 4 and ItemCountB > 4
	then
	Saga.NpcTakeItem(cid, 4068, 5);
	Saga.NpcTakeItem(cid, 4073, 5);
	Saga.SubstepComplete(cid, QuestID, 12903, 1);
	end
	end
	--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12903, i) == false
	then
	return -1;
	end
	end
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 12903);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;

	if CurStepID == 12901 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 12902 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 12903 then
		ret = QUEST_STEP_3(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret;
end

	