-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:17 PM

local QuestID = 284;
local ReqClv = 20;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 1010;
local RewCxp = 3640;
local RewJxp = 1456;
local RewWxp = 0;
local RewItem1 = 1700114;
local RewItem2 = 0;
local RewItemCount1 = 6;
local RewItemCount2 = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points
	
	Saga.AddStep(cid, QuestID, 28401, 1);
	Saga.AddStep(cid, QuestID, 28402, 0);
	Saga.AddStep(cid, QuestID, 28403, 0);
	Saga.AddStep(cid, QuestID, 28404, 0);
	Saga.AddStep(cid, QuestID, 28405, 0);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end

function QUEST_FINISH(cid)
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1);
	return 0;
end

function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	-- Talk with Volker Stanwood
	
	Saga.AddWaypoint(cid, QuestID, StepID, NpcID, PosX, PosY, PosZ, MapID);
	if Saga.GetNPCIndex(cid) == NpcID
		Saga.CompleteStep(cid, QuestID, StepID);
	else
		return -1;
	end
	
	Saga.ClearWaypoints(cid);
	
end

function QUEST_STEP_2(cid)
	-- Kill the Successor of Corad
	
	local MonsterID = {0, 0};
	local MonsterCount = 0;
	
	fori = 0, luaL_getn(MonsterID, 1) do
		MonsterCount + = Saga.Eleminate(cid, QuestID, StepID, MonsterID[i]);
	end
	
	if MonsterCount > RequiredCount
		Saga.CompleteStep(cid, QuestID, StepID);
	else
		return -1;
	end
	
	-- Summon Conrad
	Saga.Summon(MonsterID1, PosX, PosY, PosZ, MapID, TimeToLive);
end

function QUEST_STEP_3(cid)
	-- Kill Corad The Red Wolf
	
	local MonsterID = {0, 0};
	local MonsterCount = 0;

	fori = 0, luaL_getn(MonsterID, 1) do
		MonsterCount + = Saga.Eleminate(cid, QuestID, StepID, MonsterID[i]);
	end
	
	if MonsterCount > RequiredCount
		Saga.CompleteStep(cid, QuestID, StepID);
	else
		return -1;
	end
end

function QUEST_STEP_4(cid)
	-- Report to Volker Stanwood
	
	Saga.AddWaypoint(cid, QuestID, StepID, NpcID, PosX, PosY, PosZ, MapID);
	if Saga.GetNPCIndex(cid) == NpcID
		Saga.CompleteStep(cid, QuestID, StepID);
	else
		return -1;
	end
	
	Saga.ClearWaypoints(cid);
end

function QUEST_STEP_5(cid)
	-- Quest complete
	
	Saga.QuestComplete(cid, QuestID);
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID);
	local ret = -1;

	if CurStepID == 28401 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 28402 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 28403 then
		ret = QUEST_STEP_3(cid);
	elseif CurStepID == 28404 then
		ret = QUEST_STEP_4(cid);
	elseif CurStepID == 28405 then
		ret = QUEST_STEP_5(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid);
	end

	return -1;
end
