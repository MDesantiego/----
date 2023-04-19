/*
    Описание: Система зомби;
    Автор: zummore;
*/
#if defined _zombies_included
	#endinput
#endif
#define _zombies_included

#include 									<FCNPC>
#include									<mapandreas>
// #include									<PathFinder>

#define MAX_ZOMBIES     					150 // Макс. кол-во зомби;

new timer_zombie;

enum zombie_info
{
	zombie_id,
	zombie_name[MAX_PLAYER_NAME],
	Float: zombie_xyz[4]
};
new zombie[MAX_ZOMBIES][zombie_info];
	// Float: zombie_distance[MAX_ZOMBIES][2];
@LoadZombie();
@LoadZombie()
{
	new time = GetTickCount(), rows;
	cache_get_row_count(rows);
	if(!rows) return print("["SQL_VER"][WARNING]: Зомби не найдены.");
	new load_zombie_xyz[65];
	for(new idx = 1; idx <= rows; idx++)
	{
		cache_get_value_name(idx-1, "zombie_xyz", load_zombie_xyz, 65);
		sscanf(load_zombie_xyz, "p<,>fff", zombie[idx-1][zombie_xyz][0], zombie[idx-1][zombie_xyz][1], zombie[idx-1][zombie_xyz][2]);
		MapAndreas_FindZ_For2DCoordEx(zombie[idx-1][zombie_xyz][0], zombie[idx-1][zombie_xyz][1], zombie[idx-1][zombie_xyz][2]);
	    format(zombie[idx-1][zombie_name], MAX_PLAYER_NAME, "_%i_", idx);
		zombie[idx-1][zombie_id] = FCNPC_Create(zombie[idx-1][zombie_name]);
  		FCNPC_Spawn(zombie[idx-1][zombie_id], 162, zombie[idx-1][zombie_xyz][0], zombie[idx-1][zombie_xyz][1], zombie[idx-1][zombie_xyz][2]+0.5);
		zombie[idx-1][zombie_xyz][3] = random(360);
		FCNPC_SetHealth(zombie[idx-1][zombie_id], 100.0);
  		FCNPC_SetAngle(zombie[idx-1][zombie_id], zombie[idx-1][zombie_xyz][3]);
		SetPlayerAttachedObject(zombie[idx-1][zombie_id], 0, 2908, 2,  0.085999, 0.062999, 0.002000,  0.700000, -178.599960, -82.100021,  1.228000, 1.277001, 1.300001);
		SetPlayerAttachedObject(zombie[idx-1][zombie_id], 1, 2907, 1,  0.070000, 0.035000, 0.006000,  93.500053, -178.499984, -87.000076,  0.903000, 0.645001, 1.214001);
		SetPlayerColor(zombie[idx-1][zombie_id], 0xFFFFFF00);
	}
	timer_zombie = SetTimer("@zombies_timer", 100, true);
	printf("["SQL_VER"][%04dМС]: Загружено зомби: %04d.", GetTickCount() - time, rows);
	return true;
}
/*public FCNPC_OnUpdate(npcid)
{
	new Float:dist, 
			pid = GetClosestPlayer(zombie[npcid][zombie_id], dist);
	if(dist < 20.0)
	{
		FCNPC_SetAngleToPlayer(zombie[npcid][zombie_id], pid);
		FCNPC_GoToPlayer(zombie[npcid][zombie_id], pid, FCNPC_MOVE_TYPE_RUN);
	}
	if(dist < 0.6)
	{
		FCNPC_Stop(zombie[npcid][zombie_id]);
		FCNPC_MeleeAttack(zombie[npcid][zombie_id], 1200);
		FCNPC_SetAngleToPlayer(zombie[npcid][zombie_id], pid);
	}
	if(dist > 0.6)
	{
		FCNPC_SetAngleToPlayer(zombie[npcid][zombie_id], pid);
		FCNPC_StopAttack(zombie[npcid][zombie_id]);
	}
	if(dist > 20.0) 
	{
  		FCNPC_SetAngle(zombie[npcid][zombie_id], zombie[npcid][zombie_xyz][3]);
		FCNPC_Stop(zombie[npcid][zombie_id]);
	}
	return true;
}*/
stock MapAndreas_FindZ_For2DCoordEx(Float:x, Float:y, &Float:z) 
{
    if(x >= 3000.0) x = 2999.0;
    if(x <= -3000.0) x = -2999.0;
    if(y >= 3000.0) y = 2999.0;
    if(y <= -3000.0) y = -2999.0;
    MapAndreas_FindZ_For2DCoord(x, y, z);
}
stock GetClosestPlayer(playerid, &Float: cdist)
{
	new cid = INVALID_PLAYER_ID;
	new Float: mx, Float: my, Float: mz;
	cdist = 65000.0;
	GetPlayerPos(playerid, mx, my, mz);
	foreach(Player, i)
	{
		if(playerid == i || IsPlayerNPC(i)) continue;
		new Float: x, Float: y, Float: z;
		GetPlayerPos(i, x, y, z);
		x -= mx;
		y -= my;
		z -= mz;
		new Float: dist = floatsqroot(x*x + y*y + z*z);
		if(dist < cdist)
		{
			cdist = dist;
			cid = i;
		}
	}
	return cid;
}
// MapAndreas_FindZ_For2DCoordEx(zombie[npcid][zombie_xyz][0], zombie[npcid][zombie_xyz][1], zombie[npcid][zombie_xyz][2]);
// MapAndreas_FindAverageZ(zomb_x, zomb_y, zomb_z);
@zombies_timer();
@zombies_timer()
{
    for(new npcid = 0; npcid < MAX_ZOMBIES; npcid++)
	{
		new Float: dist = 0.0, 
				pid = GetClosestPlayer(zombie[npcid][zombie_id], dist);
		if(dist < 20.0) FCNPC_GoToPlayer(zombie[npcid][zombie_id], pid, FCNPC_MOVE_TYPE_RUN, FCNPC_MOVE_SPEED_AUTO, FCNPC_MOVE_MODE_MAPANDREAS, FCNPC_MOVE_PATHFINDING_Z);
		if(dist > 20.0 && GetPlayerDistanceFromPoint(zombie[npcid][zombie_id], zombie[npcid][zombie_xyz][0], zombie[npcid][zombie_xyz][1], zombie[npcid][zombie_xyz][2]) > 20.0)
		{
			FCNPC_Stop(zombie[npcid][zombie_id]);
			MapAndreas_FindZ_For2DCoordEx(zombie[npcid][zombie_xyz][0], zombie[npcid][zombie_xyz][1], zombie[npcid][zombie_xyz][2]);
			FCNPC_GoTo(zombie[npcid][zombie_id], zombie[npcid][zombie_xyz][0], zombie[npcid][zombie_xyz][1], zombie[npcid][zombie_xyz][2] + 0.5, FCNPC_MOVE_TYPE_RUN, FCNPC_MOVE_SPEED_AUTO, FCNPC_MOVE_MODE_MAPANDREAS);
		}
		if(dist < 0.7)
		{
			FCNPC_Stop(zombie[npcid][zombie_id]);
			FCNPC_SetAngleToPlayer(zombie[npcid][zombie_id], pid);
			FCNPC_MeleeAttack(zombie[npcid][zombie_id], 1200);
			FCNPC_SetAngleToPlayer(zombie[npcid][zombie_id], pid);
			SetPVarInt(zombie[npcid][zombie_id], "FCNPC_DAMAGE", 1);
		}
		if(dist > 0.7 && GetPVarInt(zombie[npcid][zombie_id], "FCNPC_DAMAGE"))
		{
			FCNPC_SetAngleToPlayer(zombie[npcid][zombie_id], pid);
			FCNPC_StopAttack(zombie[npcid][zombie_id]);
			DeletePVar(zombie[npcid][zombie_id], "FCNPC_DAMAGE");
		}
		/*if(dist > 15.0 && !GetPVarInt(zombie[npcid][zombie_id], "FCNPC_GOTOPLAYER"))
		{
			new Float: distance;
	    	distance = GetPlayerDistanceFromPoint(zombie[npcid][zombie_id], zombie[npcid][zombie_xyz][0], zombie[npcid][zombie_xyz][1], zombie[npcid][zombie_xyz][2]);
			if(distance < 1.0)
			{
			    new Float: zomb_xyz[3];
			    FCNPC_GetPosition(zombie[npcid][zombie_id], zomb_xyz[0], zomb_xyz[1], zomb_xyz[2]);
			    zomb_xyz[0] += (21.0 * floatsin(-FCNPC_GetAngle(zombie[npcid][zombie_id]), degrees));
				zomb_xyz[1] += (21.0 * floatcos(-FCNPC_GetAngle(zombie[npcid][zombie_id]), degrees));
				PathFinder_FindWay(zombie[npcid][zombie_id], zombie[npcid][zombie_xyz][0], zombie[npcid][zombie_xyz][1], zomb_xyz[0], zomb_xyz[1]);
				// FCNPC_GoTo(zombie[npcid][zombie_id], zomb_xyz[0], zomb_xyz[1], zomb_xyz[2], FCNPC_MOVE_TYPE_WALK, FCNPC_MOVE_SPEED_AUTO, FCNPC_MOVE_MODE_MAPANDREAS);
			}
	    	else if(distance > 20.0)
			{
			    new Float: zomb_xyz[3];
			    FCNPC_GetPosition(zombie[npcid][zombie_id], zomb_xyz[0], zomb_xyz[1], zomb_xyz[2]);
				PathFinder_FindWay(zombie[npcid][zombie_id], zomb_xyz[0], zomb_xyz[1], zombie[npcid][zombie_xyz][0], zombie[npcid][zombie_xyz][1]);
				// FCNPC_GoTo(zombie[npcid][zombie_id], zombie[npcid][zombie_xyz][0], zombie[npcid][zombie_xyz][1], zombie[npcid][zombie_xyz][2], FCNPC_MOVE_TYPE_WALK, FCNPC_MOVE_SPEED_AUTO, FCNPC_MOVE_MODE_MAPANDREAS);
			}
		}*/
	}
	return true;
}
/*
public OnPathCalculated(routeid, success, Float:nodesX[], Float:nodesY[], Float:nodesZ[], nodesSize)
{
    if(!success) return true;
	static text[128];
	format(text, sizeof(text), "PATH: route: %d success: %d nodesSize: %d", routeid, success, nodesSize);
    SendClientMessageToAll(-1, text);
	// printf("PATH: route: %d success: %d nodesSize: %d", routeid, success, nodesSize);
    new FCNPC_MOVE_path = FCNPC_CreateMovePath();
    for(new i; i < nodesSize; i++)
    {
      	FCNPC_AddPointToMovePath(FCNPC_MOVE_path, nodesX[i], nodesY[i], nodesZ[i] + 1);
	}
    FCNPC_GoByMovePath(routeid, FCNPC_MOVE_path, 1, FCNPC_MOVE_TYPE_WALK, FCNPC_MOVE_SPEED_WALK, FCNPC_MOVE_MODE_MAPANDREAS);
    return 1;
}*/
public FCNPC_OnDeath(npcid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID && IsPlayerNPC(npcid)) 
	{ 
		users[killerid][u_kill][0]++;
		Quest(killerid, 1);
		SaveUser(killerid, "kill");
	}
	SetTimerEx("FCNPC_Hide_npc", 5*60000, false, "i", npcid);
	SetTimerEx("FCNPC_RESP", 10*60000, false, "i", npcid);
	return true;
}
void FCNPC_Hide_npc(npcid) return FCNPC_SetVirtualWorld(npcid, 1);
void FCNPC_RESP(npcid)
{
	FCNPC_Respawn(npcid);
	FCNPC_SetVirtualWorld(npcid, 0);
	FCNPC_SetHealth(npcid, 100.0);
	SetPlayerAttachedObject(npcid, 0, 2908, 2,  0.085999, 0.062999, 0.002000,  0.700000, -178.599960, -82.100021,  1.228000, 1.277001, 1.300001);
	SetPlayerAttachedObject(npcid, 1, 2907, 1,  0.070000, 0.035000, 0.006000,  93.500053, -178.499984, -87.000076,  0.903000, 0.645001, 1.214001);
	return true;
}
public FCNPC_OnTakeDamage(npcid, issuerid, Float:amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
	{
		if(bodypart == 9)
		{
			switch(weaponid)
			{
			case 22..34: FCNPC_SetHealth(npcid, 0.0); // Голова 26
			}
		}
	}
	return true;
}
/*
public FCNPC_OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart) 
{
	if(IsPlayerNPC(damagedid))
	{
		new Float:dist,
			pid = GetClosestPlayer(damagedid, dist);
		if(dist > 80.0) return true;
		static Float: xyz[3][2];
		GetPlayerPos(pid, xyz[0][0], xyz[1][0], xyz[2][0]);
		FCNPC_GetPosition(damagedid, xyz[0][1], xyz[1][1], xyz[2][1]);
		//if(xyz[2][1]+3.0 < xyz[2][0]) return true;
		FCNPC_SetAngleToPlayer(damagedid, pid);
		PathFinder_FindWay(damagedid, xyz[0][1], xyz[1][1], xyz[0][0], xyz[1][0]);
	}
	return 1; 
}*/
/*

	OnGameModeInit;

*/
public OnGameModeInit()
{	
	// MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
    MapAndreas_Init(MAP_ANDREAS_MODE_FULL, "scriptfiles/SAFull.hmap");
	// PathFinder_Init(MapAndreas_GetAddress(), 2);
	FCNPC_SetUpdateRate(30);
#if defined ZMS_OnGameModeInit
    return ZMS_OnGameModeInit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit ZMS_OnGameModeInit
#if defined   ZMS_OnGameModeInit
	forward ZMS_OnGameModeInit();
#endif 
/*

	OnGameModeExit;

*/
public OnGameModeExit()
{
	KillTimer(timer_zombie);
	for(new npcid = 0; npcid < MAX_ZOMBIES; npcid++) FCNPC_Destroy(npcid);
#if defined ZMS_OnGameModeExit
    return ZMS_OnGameModeExit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit ZMS_OnGameModeExit
#if defined   ZMS_OnGameModeExit
	forward ZMS_OnGameModeExit();
#endif 