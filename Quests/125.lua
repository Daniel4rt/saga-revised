-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM
--Spanner 7/25/08

local QuestID = 125;
local ReqClv = 8;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 120;
local RewCxp = 408;
local RewJxp = 160;
local RewWxp = 0;
local RewItem1 = 1700113;
local RewItem2 = 0;
local RewItemCount1 = 1;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 12501);
	Saga.AddStep(cid, QuestID, 12502);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
	Saga.GiveZeny(RewZeny);
	Saga.GiveExp( RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveItem(cid, RewItem2, RewItemCount2 );
	return 0;
	else
	return -1;
	end

end
function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	--Eliminate Marine Sphere;Eliminate Marine Sphere Imago

	Saga.Eliminate(cid, QuestID, 12501, 10040, 3, 1);
	Saga.Eliminate(cid, QuestID, 12501, 10041, 3, 1);
	Saga.Eliminate(cid, QuestID, 12501, 10042, 4, 2);
	Saga.Eliminate(cid, QuestID, 12501, 10043, 4, 2);

	--check if all substeps are complete
	for i = 1, 2 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12501, i) == false
	then
	return -1;
	end

	end
	Saga.StepComplete(cid, QuestID, 12501);
	return 0;
end

function QUEST_STEP_2(cid)
	--Talk with Misha Berardini

	Saga.AddWaypoint(cid, QuestID, 12502, 1, 1000);
	if ret == 1000
	then
	Saga.GeneralDialog(cid, 3936);
	Saga.SubstepComplete(cid, QuestID, 1502, 1);
	end
	end

	--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 12502, i) == false
	then
	return -1;
	end
	end
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 12502);
	Saga.QuestComplete(cid, QuestID);
	return -1;
	end

--check for completion
	local ret = Saga.GetNPCIndex(cid);

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;

	if CurStepID == 12501 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 12502 then
		ret = QUEST_STEP_2(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return ret;
end
