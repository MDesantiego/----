enum structure_base
{
	// База:
	b_id,
	b_owner_id,
	b_owner_name[MAX_PLAYER_NAME],
	b_lock_status, // 0 - По паролю, остальное - По клану;
	b_lock_password[MAX_PLAYER_NAME],
	b_delete_date[MAX_PLAYER_NAME],
	b_buy_date[MAX_PLAYER_NAME],
	b_price,
	// Координаты ьазы:
	Float: b_coords_gate[3],
	Float: b_coords_gate_interactions[6],
	Float: b_coords_guard[6],
	// Ворота базы:
	b_gate, 
	bool: b_gate_open,
	b_gate_status,
	b_gate_open_number
};
new base[31][structure_base],
	BaseGateOpen[MAX_PLAYERS],
	BaseMenuList[MAX_PLAYERS][31],
	base_count = 0;
/*new Float: base_owner_spawn[][3] =
{
	{1403.0500,1213.4374,11.5491,295.6363},
	{2189.1406,578.6591,10.8203,9.5604},
	{3.2211,-227.4459,8.8598,273.9928},
	{-1361.5057,17.7536,6.3359,354.5204},
	{-1848.0686,1283.2787,50.4453,315.9571},
	{990.5037,2413.6567,10.9149,71.2649},
	{1468.6276,2867.5085,12.3078,185.6327},
	{324.3612,-1495.2557,24.9219,118.2654},
	{1727.0394,1237.8734,10.8600,109.5389},
	{2117.1836,2416.7910,49.5234,92.3053},
	{-2558.7993,662.5389,14.4531,159.6726},
	{1307.8123,760.8382,10.9875,105.7786},
	{1654.1129,-1704.3351,15.6094,140.2457},
	{1274.7213,1368.7048,10.8203,234.8498},
	{2490.8931,2397.3203,4.2109,267.1234},
	{-1361.4425,-190.2168,6.3359,0.8110},
	{2224.5459,1981.8447,31.7797,233.2832},
	{-690.1580,939.4245,13.6328,310.0271},
	{2882.1685,1880.6658,12.3078,23.0112},
	{-1119.0262,-925.8524,130.7000,156.7823},
	{1002.4902,2597.3882,14.5431,244.8065},
	{41.1567,850.5988,39.2860,102.8650},
	{103.4068,1103.4926,16.5201,335.3371},
	{988.3345,2152.8042,10.8203,146.0821},
	{-13.3782,1523.3151,16.0386,51.7444}
};*/
@LoadBase();
@LoadBase()
{
	new time = GetTickCount(), rows;
	cache_get_row_count(rows);
	if(!rows) return print("["SQL_VER"][WARNING]: Базы не найдены.");
	new loading_string[96];
	for(new idx = 1; idx < rows+1; idx++)
	{
		cache_get_value_name_int(idx-1, "b_id", base[idx][b_id]);
		cache_get_value_name_int(idx-1, "b_owner_id", base[idx][b_owner_id]);
		cache_get_value_name(idx-1, "b_owner_name", base[idx][b_owner_name], MAX_PLAYER_NAME);
		cache_get_value_name_int(idx-1, "b_lock_status", base[idx][b_lock_status]);
		cache_get_value_name(idx-1, "b_lock_password", base[idx][b_lock_password], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "b_delete_date", base[idx][b_delete_date], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "b_buy_date", base[idx][b_buy_date], MAX_PLAYER_NAME);
		cache_get_value_name_int(idx-1, "b_price", base[idx][b_price]);

		cache_get_value_name(idx-1, "b_coords_gate", loading_string, sizeof(loading_string));
		sscanf(loading_string, "p<,>fff", base[idx][b_coords_gate][0], base[idx][b_coords_gate][1], base[idx][b_coords_gate][2]);
		cache_get_value_name(idx-1, "b_coords_gate_interactions", loading_string, sizeof(loading_string));
		sscanf(loading_string, "p<,>ffffff", 
		base[idx][b_coords_gate_interactions][0], base[idx][b_coords_gate_interactions][1], base[idx][b_coords_gate_interactions][2], 
		base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5]);
		cache_get_value_name(idx-1, "b_coords_guard", loading_string, sizeof(loading_string));
		sscanf(loading_string, "p<,>ffffff", 
		base[idx][b_coords_guard][0], base[idx][b_coords_guard][1], base[idx][b_coords_guard][2], 
		base[idx][b_coords_guard][3], base[idx][b_coords_guard][4], base[idx][b_coords_guard][5]);
		
		/*switch(idx)
		{
		case 1, 4, 6: base[idx][b_gate] = CreateDynamicObject(19313, base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5], 0.000000, 0.000000, 90.000000, -1, -1);
		case 2, 3, 9, 12: base[idx][b_gate] = CreateDynamicObject(19313, base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5], 0.000000, 0.000000, 0.000000, -1, -1);
		case 5: base[idx][b_gate] = CreateDynamicObject(19313, base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5],   0.00000, 0.00000, -92.94000);
		case 7: base[idx][b_gate] = CreateDynamicObject(980, base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5], 0.00000, 0.00000, -180.78012);
		case 8: base[idx][b_gate] = CreateObject(971, base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5],   0.00000, 0.00000, -35.00000);
		case 10: base[idx][b_gate] = CreateDynamicObject(971, base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5], 0.000000, 0.000000, 270.960114, -1, -1);
		case 11: base[idx][b_gate] = CreateDynamicObject(971, base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5], 0.000000, 0.000000, -0.480000, -1, -1);
		case 13: base[idx][b_gate] = CreateDynamicObject(971, base[idx][b_coords_gate_interactions][3], base[idx][b_coords_gate_interactions][4], base[idx][b_coords_gate_interactions][5], 0.000000, 0.000000, -91.019974, -1, -1);
		}*/

	
		base_count = rows+1;
		base[idx][b_gate_open_number] = -1;
	}
	base[1][b_gate] = CreateDynamicObject(19313, 1457.4343, 1220.1278, 13.1162, 0.000000, 0.000000, 90.000000, -1, -1);
	base[2][b_gate] = CreateDynamicObject(19313, 2176.211426, 622.229126, 13.132000, 0.000000, 0.000000, 0.000000, -1, -1);
	base[3][b_gate] = CreateDynamicObject(19313, -2.63730, -268.72549, 7.63630,   0.00000, 0.00000, 0.00000);
	base[4][b_gate] = CreateDynamicObject(19313, -1391.07959, -29.00000, 8.30000,   0.00000, 0.00000, 90.00000);
	base[5][b_gate] = CreateDynamicObject(19313, -1776.10889, 1292.69788, 52.70000,   0.00000, 0.00000, -92.94000);
	base[6][b_gate] = CreateDynamicObject(19313, 916.690002, 2439.870117, 13.119000, 0.000000, 0.000000, 90.000000, -1, -1);
	base[7][b_gate] = CreateDynamicObject(980, 1489.54004, 2817.98096, 12.57560, 0.00000, 0.00000, -180.78012);
	base[8][b_gate] = CreateDynamicObject(971, 283.94830, -1543.02429, 27.00000,   0.00000, 0.00000, -35.00000);
	base[9][b_gate] = CreateDynamicObject(19313, 1707.82178, 1160.33264, 11.96400,   0.00000, 0.00000, 0.00000);
	base[10][b_gate] = CreateDynamicObject(971, 2078.547363, 2375.581543, 47.473801, 0.000000, 0.000000, 270.960114, -1, -1);
	base[11][b_gate] = CreateDynamicObject(971, -2567.675537, 618.850769, 16.664631, 0.000000, 0.000000, -0.480000, -1, -1);
	base[12][b_gate] = CreateDynamicObject(980, 1277.891357, 787.819153, 12.591100, 0.000000, 0.000000, 0.000000, -1, -1);
	base[13][b_gate] = CreateDynamicObject(971, 1643.283813, -1715.723755, 15.895280, 0.000000, 0.000000, -91.019974, -1, -1);
	base[14][b_gate] = CreateDynamicObject(971, 1291.347290, 1361.513916, 12.516650, 0.000000, 0.000000, 88.139923, -1, -1);
	base[15][b_gate] = CreateDynamicObject(19313, 2497.42285, 2376.99951, 5.40000,   0.00000, 0.00000, 90.00004);
	base[16][b_gate] = CreateDynamicObject(971, -1390.68188, -239.20828, 8.28436,   0.60000, 0.12000, -89.40009);
	base[17][b_gate] = CreateDynamicObject(971, 2299.471191, 1962.780273, 34.332081, -0.720000, -0.240000, 270.479675, -1, -1);
	base[18][b_gate] = CreateDynamicObject(19313, -717.83099, 950.90631, 13.60000,   0.00000, 0.00000, 87.42000);
	base[19][b_gate] = CreateDynamicObject(19313, 2839.78027, 1971.19226, 12.40000,   0.00000, 0.00000, 50.52010);
	base[20][b_gate] = CreateDynamicObject(19313, -1155.84424, -951.81018, 131.00000,   0.00000, 0.00000, 90.00000);
	base[21][b_gate] = CreateDynamicObject(19313, 1025.33325, 2559.77417, 12.00000,   0.00000, 0.00000, -31.74000);
	base[22][b_gate] = CreateDynamicObject(19313, 64.61250, 833.37048, 39.00000,   0.00000, 0.00000, 90.00000);
	base[23][b_gate] = CreateDynamicObject(19912, 157.270996, 1096.729004, 16.0, 0.000000, 0.000000, 270.000000, -1, -1);
	base[24][b_gate] = CreateDynamicObject(19313, 997.38348, 2101.90918, 12.00000,   0.00000, 0.00000, 90.00000);
	base[25][b_gate] = CreateDynamicObject(19313, -66.101799, 1510.639648, 15.051500, 0.000000, 0.000000, 279.997986, -1, -1);
	printf("["SQL_VER"][%04dМС]: Загружено баз: %04d.", GetTickCount() - time, base_count-1);
	return 1; 
}
@base_gate(baseid);
@base_gate(baseid)
{
	base[baseid][b_gate_open_number] = -1;
	base[baseid][b_gate_open] = false;
	MoveDynamicObject(base[baseid][b_gate], base[baseid][b_coords_gate_interactions][3], base[baseid][b_coords_gate_interactions][4], base[baseid][b_coords_gate_interactions][5], 3);
	return true;
}
stock IsPlayerToCube(playerid, Float: mBASE_x, Float: mBASE_y, Float: mBASE_z, Float: max_x, Float: max_y, Float: max_z)
{
	new Float: pos_xyz[3];
	GetPlayerPos(playerid, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
	if((pos_xyz[0] <= max_x && pos_xyz[0] >= mBASE_x) && (pos_xyz[1] <= max_y && pos_xyz[1] >= mBASE_y) && (pos_xyz[2] <= max_z && pos_xyz[2] >= mBASE_z)) return true;
	return false;
}
stock IsVehicleToCube(vehicleid, Float: min_x, Float: min_y, Float: min_z, Float: max_x, Float: max_y, Float: max_z)
{
	new Float: pos_xyz[3];
	GetVehiclePos(vehicleid, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
	if((pos_xyz[0] <= max_x && pos_xyz[0] >= min_x) && (pos_xyz[1] <= max_y && pos_xyz[1] >= min_y) && (pos_xyz[2] <= max_z && pos_xyz[2] >= min_z)) return true;
	//if((pos_xyz[0] > min_x && pos_xyz[1] > min_y && pos_xyz[2] > min_z) && (pos_xyz[0] < max_x && pos_xyz[1] < max_y && pos_xyz[2] < max_z)) return true;
	return false;
}
stock IsGuardBaseVehicle(vehicleid)
{
	for(new zone = 1; zone < base_count; zone++)
	{
		if(!IsVehicleToCube(vehicleid, base[zone][b_coords_guard][0], base[zone][b_coords_guard][1], base[zone][b_coords_guard][2], 
		base[zone][b_coords_guard][3], base[zone][b_coords_guard][4], base[zone][b_coords_guard][5])) continue;
		return zone;
	}
	return 0;
}
stock IsGuardBase(playerid)
{
	for(new zone = 1; zone < base_count; zone++)
	{
		if(!IsPlayerToCube(playerid, base[zone][b_coords_guard][0], base[zone][b_coords_guard][1], base[zone][b_coords_guard][2], 
		base[zone][b_coords_guard][3], base[zone][b_coords_guard][4], base[zone][b_coords_guard][5])) continue;
		switch(base[zone][b_lock_status])
		{
		case 0: // Пароль;
			{
				if(temp[playerid][BaseGuardGate] != zone) return 1;
			}
		default: // Клан;
			{	
				if(base[zone][b_lock_status] != users[playerid][u_clan]) return 2;
			}
		}
	}
	return false;
}
stock PanelBase(playerid)
{
	new string[356], str[65], b = BaseGateOpen[playerid];
	string[0] = EOS;
	if(!users[playerid][u_clan] && base[b][b_lock_status] != 0)
	{
		static str_sql[156];
		m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BASE" SET `b_lock_status` = '0', `b_lock_password` = '1234' WHERE `b_owner_id` = '%i' AND `b_id` = '%i'", 
		users[playerid][u_id], b);
		base[b][b_lock_status] = 0;
		m_query(str_sql);
		format(base[b][b_lock_password], 24, "1234");
		server_error(playerid, "Вас выгнали или вы ушли из клана.");
		server_error(playerid, "Тип ворот базы: {cccccc}По паролю");
		server_error(playerid, "Пароль от ворот: {cccccc}1234.");
	}
	strcat(string, "Наименование раздела\tСтатус\n");
	strcat(string, "{828282}- {ffffff}Статистика базы\n");
	format(str, sizeof(str), "{828282}- {ffffff}Тип ворот базы\t%s\n", (base[b][b_lock_status])?("{AFEEEE}Для клана"):("{cccccc}По паролю"));
	strcat(string, str);
	strcat(string, "{828282}- {ffffff}Продлить базу на 30 дней\n");
	if(!base[b][b_lock_status]) strcat(string, "{828282}- {ffffff}Сменить пароль от ворот базы\n");
	format(str, sizeof(str), "База №%i", b);
	show_dialog(playerid, d_base, DIALOG_STYLE_TABLIST_HEADERS, str, string, !"Выбрать", !"Закрыть");
	return true;
}
/*

	OnGameModeInit()

*/
public OnGameModeInit()
{
	new textures_map;
	#include "modules/maps/base/1.pwn"
	#include "modules/maps/base/2.pwn"
	#include "modules/maps/base/3.pwn"
	#include "modules/maps/base/4.pwn"
	#include "modules/maps/base/5.pwn"
	#include "modules/maps/base/6.pwn"
	#include "modules/maps/base/7.pwn"
	#include "modules/maps/base/8.pwn"
	#include "modules/maps/base/9.pwn"
	#include "modules/maps/base/10.pwn"
	#include "modules/maps/base/11.pwn"
	#include "modules/maps/base/12.pwn"
	#include "modules/maps/base/13.pwn"
	#include "modules/maps/base/14.pwn"
	#include "modules/maps/base/15.pwn"
	#include "modules/maps/base/16.pwn"
	#include "modules/maps/base/17.pwn"
	#include "modules/maps/base/18.pwn"
	#include "modules/maps/base/19.pwn"
	#include "modules/maps/base/20.pwn"
	#include "modules/maps/base/21.pwn"
	#include "modules/maps/base/22.pwn"
	#include "modules/maps/base/23.pwn"
	#include "modules/maps/base/24.pwn"
	#include "modules/maps/base/25.pwn"
	#if defined BASE_OnGameModeInit
		return BASE_OnGameModeInit();
	#else
		return 1;
	#endif
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit BASE_OnGameModeInit

#if defined BASE_OnGameModeInit
    forward BASE_OnGameModeInit();
#endif