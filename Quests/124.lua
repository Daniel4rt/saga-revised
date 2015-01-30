-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 124;
local ReqClv = 8;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 210;
local RewCxp = 490;
local RewJxp = 192;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 5;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	
	Saga.AddStep(cid, QuestID, 12401);
	Saga.AddStep(cid, QuestID, 12402);
	Saga.AddStep(cid, QuestID, 12403);
	Saga.AddStep(cid, QuestID, 12404);
	Saga.InsertQuest(cid, QuestID, 1);
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
	--Talk with Scacciano Morrigan
	Saga.AddWaypoint(cid, QuestID, 12401, 1, 1003);
	--check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1003
	then
	Saga.GeneralDialog(cid, 3936);
	Saga.SubstepComplete(cid, QuestID, 12401, 1);
	end

	end
	--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12401, i) == false
	then
	return -1;
	end

	end
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 12401);
	return 0;
end

function QUEST_STEP_2(cid)
	--Find Marine Sphere Nucleus Parts
	--doesnt specify how many
	Saga.FindQuestItem(cid, QuestID, 12402, 10040, 2645, 6000, 4, 1);
	Saga.FindQuestItem(cid, QuestID, 12402, 10041, 2645, 6000, 4, 1);
	
	--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12402, i) == false
	then
	return -1;
	end

	end
	Saga.StepComplete(cid, QuestID, 12402);
	return 0;
end

function QUEST_STEP_3(cid)
	--Eliminate the Giant Piranha

	Saga.Eliminate(cid, QuestID, 12403, 10058, 1, 1);

	--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12403, i) == false
	then
	return -1;
	end

	end
	Saga.StepComplete(cid, QuestID, 12403);
	return 0;
end

function QUEST_STEP_4(cid)
	--Talk with Scacciano Morrigan
	Saga.AddWaypoint(cid, QuestID, 12404, 1, 1003);
	--check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1003
	then
	Saga.GeneralDialog(cid, 3936);
	Saga.SubstepComplete(cid, QuestID, 12404, 1);
	end

	end
	--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12404, i) == false
	then
	return -1;
	end

	end
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 12401);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

	
	
function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;

	if CurStepID == 12401 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 12402 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 12403 then
		ret = QUEST_STEP_3(cid);
	elseif CurStepID == 12404 then
		ret = QUEST_STEP_4(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret;
end
