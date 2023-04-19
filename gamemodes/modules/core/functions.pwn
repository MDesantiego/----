stock TKICK(playerid, const textkick[], code = -1)
{
	if(code != -1)
	{
		new 
			hour, minute,
			year, month, day,
			format_string[(496+1)+MAX_PLAYER_NAME+2+36+18];
		getdate(year, month, day);
		gettime(hour, minute);
		format(format_string, sizeof(format_string), "\
		{fffff0}Вы были кикнуты по подозрению в использовании чит-программ!\n\n\
		{F0E68C}* {fffff0}Пользователь: {4682B4}%s\n\
		{F0E68C}* {fffff0}Причина: {4682B4}%s\n\
		{F0E68C}* {fffff0}Код причины: {4682B4}%i\n\
		{F0E68C}* {fffff0}Дата и время: {4682B4}%0i.%02i.%i %02i:%02i\n\n\
		{FF6347}* {fffff0}Если Вы считаете это ложным киком, то сделайте скриншот данного окна (F8),\n\
		после напишите на форуме в '{cccccc}Технический раздел{fffff0}' > '{cccccc}Баги/Ошибки игрового мода{fffff0}'\n", 
		users[playerid][u_name], anticheat[code][ac_name], code, day, month, year, hour, minute);
		// static str[300];
		/*format(str, sizeof(str), "{CD5C5C}Вы бали кикнуты, за нарушение правил сервера.\
		\n\n{CD5C5C}* {ffffff}Код анти-чита: {cccccc}%i.\
			\n\n{cccccc}* {ffffff}Пожалуйста, сделайте скриншот данного окна (F8), после свяжитесь с администрацией,\n\
			если вы считаете это ложным киком с сервера.", code);
		*/
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Античит {fffff0}| {5F9EA0}Сервер", format_string, !"Понял", !"");
	}
	SendClientMessage(playerid, color_kick, textkick);
	SendClientMessage(playerid, color_kick, "Чтобы выйти, нажмите 'f6' и введите '/q'(-uit).");
	SetTimerEx("@PlayerKick", 50, false, "i", playerid);
	return true;
}
@PlayerKick(playerid);
@PlayerKick(playerid) return Kick(playerid);
stock SaveUserInt(playerid, structure[], value[])
{
	static const size_str[] = "UPDATE "TABLE_USERS" SET `%s` = '%i' WHERE `u_name` = '%s' LIMIT 1";
	new str_sql[sizeof(size_str)+96];
	m_format(str_sql, sizeof(str_sql), size_str, structure, value, users[playerid][u_name]);
	m_tquery(str_sql);
	return true;
}
stock SaveUserFloat(playerid, structure[], Float: value[])
{
	static const size_str[] = "UPDATE "TABLE_USERS" SET `%s` = '%f' WHERE `u_name` = '%s' LIMIT 1";
	new str_sql[sizeof(size_str)+96];
	m_format(str_sql, sizeof(str_sql), size_str, structure, value, users[playerid][u_name]);
	m_tquery(str_sql);
	return true;
}
stock GetIp(playerid)
{
	new ip[18];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}
stock show_dialog ( playerid, dialogid, style, caption [ ], info [ ], button1 [ ], button2 [ ] )
{
	new str_caption[96];
	strcat(str_caption, "{5F9EA0}"); // AFEEEE PaleTurquoise 5F9EA0 CadetBlue
	strcat(str_caption, caption);
	// temp [ playerid ] [ use_dialog ] = dialogid ;
	return ShowPlayerDialog ( playerid, dialogid, style, str_caption, info, button1, button2 ) ;
}
stock ResetNew(playerid)
{
	DeletePVar(playerid, "LoginPass");
	DeletePVar(playerid, "AdminLoginPass");
	inventory_clear(playerid); // Чистим инвентарь;
	/*
	DeletePVar(playerid, "PlayerBad");
	DeletePVar(playerid, "player_zone");
	DeletePVar(playerid, "PlayerUsingLoopingA");
	DeletePVar(playerid, "AFK");
	DeletePVar(playerid, "AntiFloodVehicleFunction");
	DeletePVar(playerid, "AntiFloodChat");
	DeletePVar(playerid, "Animation");
	DeletePVar(playerid, "LoadWeapon");
	DeletePVar(playerid, "CheckRegistrationUser");*/

	admin[playerid][admin_level] 							= 0;
	admin[playerid][u_a_dostup] 						= 0;
	admin[playerid][u_a_reprimand] 						= 0;
	admin[playerid][u_a_freeze] 						= 0;
	// admin[playerid][u_a_protrct_ac]						= 0;
	// object_create[playerid]									= 0;
	use_craft_tools_pila[playerid]							= 0;
	temp[playerid][player_box]								= -1;
    temp[playerid][temp_login]                            = false;
	// temp[playerid][use_dialog] 								= -1;
	observation[playerid][observation_id] 					= INVALID_PLAYER_ID;
	temp[playerid][gps]										= false;
	admin[playerid][u_a_gm]								= 0;
	users[playerid][u_score] 									= 0;
	temp[playerid][time_infinity_health] 					= 0;
	temp[playerid][infinity_health]							= 0;
	// temp[playerid][UserRegister]							= 0;
	temp[playerid][BaseGuardGate]							= 0;
	PlayerBan[playerid]										= 0;
	BaseGateOpen[playerid]									= 0;
	users[playerid][u_setname]									= 0;
	users[playerid][u_kill][0]									= 0;
	users[playerid][u_kill][1]									= 0;
	users[playerid][u_health]									= 0.0;
	users[playerid][u_armour]									= 0.0;
	users[playerid][u_helmet]									= 0;
	users[playerid][u_pack][0]									= 0;
	users[playerid][u_pack][1]									= 0;
	users[playerid][u_pack][2]									= 0;
	users[playerid][u_pack][3]									= 0;
	users[playerid][u_pack][4]									= 0;
	temp[playerid][TimeUsePack]								= 0;
	// temp[playerid][protect_loading]							= 0;
	// temp[playerid][protect_info_hunger]						= 0;
	// temp[playerid][protect_info_thirst]						= 0;
	users[playerid][u_damage][0]								= 0;
	users[playerid][u_damage][1]								= 0;
	users[playerid][u_eat_food]									= 0;
	GPS_Zone[playerid][0]									= 0;
	GPS_Zone[playerid][1]									= -1;
	users[playerid][u_money]									= 0;
	users[playerid][u_achievement][0]							= 0;
	users[playerid][u_achievement][1]							= 0;
	users[playerid][u_achievement][2]							= 0; 
	users[playerid][u_achievement][3]							= 0;
	users[playerid][u_achievement][4]							= 0;
	users[playerid][u_achievement][5]							= 0;
	users[playerid][u_achievement][6]							= 0;
	users[playerid][u_achievement][7]							= 0; 
	users[playerid][u_achievement][8]							= 0; 
	users[playerid][u_achievement][9]							= 0; 
	users[playerid][u_achievement][10]							= 0; 
	users[playerid][u_achievement][11]							= 0;
	users[playerid][u_achievement][12]							= 0;
	
	temp [ playerid ] [ temp_register ] [ 0 ] =
	temp [ playerid ] [ temp_register ] [ 1 ] =
	temp [ playerid ] [ temp_register ] [ 2 ] = 0;
	// temp[playerid][player_setname] = "NoChangeName";
	format(temp[playerid][player_setname], MAX_PLAYER_NAME, "NoChangeName");

	for(new j = 0; j != 20; j++)
	{
		LogsChat[playerid][j] = "NoChatLogsClear";
	}
    for(new i = 0; i < AC_MAX_CODES; i++) pAntiCheatLastCodeTriggerTime[playerid][i] = -1;
    pAntiCheatSettingsPage{playerid} = 0; // Присваиваем значение 0 переменной, хранящей номер страницы настроек анти-чита, на которой находится игрок
    pAntiCheatSettingsEditCodeId[playerid] = -1; // Присваиваем переменной, хранящей идентификатор (ID) кода анти-чита, который редактирует игрок, занчение -1
	AntiCheatOffAndOn(playerid, 1);
	ServerResetPlayerWeapons(playerid);
}
stock SPP(playerid, Float: x, Float: y, Float: z, Float: f, world = 0, int = 0)
{
	SetPlayerInterior ( playerid, int );
	SetPlayerVirtualWorld ( playerid, world );
	SetPlayerPos ( playerid, x, y, z );
	SetPlayerFacingAngle ( playerid, f );
    return 1;
}
stock SetPlayerNeed(playerid, type, value) // type = 0 - Вода, type = 1 - Еда;
{
	switch(type)
	{
	case 0: 
		{
			users[playerid][u_thirst] += value;
			// temp[playerid][protect_info_thirst] = 0;
			if (users[playerid][u_thirst] > 100) users[playerid][u_thirst] = 100;
		}
	case 1:
		{
			users[playerid][u_hunger] += value;
			users[playerid][u_eat_food]++;
			// temp[playerid][protect_info_hunger]	= 0;
			Quest(playerid, 3);
			if (users[playerid][u_hunger] > 100) users[playerid][u_hunger] = 100;
		}
	}
	return true;
}
stock LoadingForUser(playerid, value = 0)
{
	switch(value)
	{
	case 0:
		{
			for(new i = 0; i != 3; i++) TextDrawHideForPlayer(playerid, LoadingPlayer_TD[i]);
			TextDrawHideForPlayer(playerid, Text: drop_items_TD);
			// temp[playerid][protect_loading] = 1;
			if(GPS_Zone[playerid][0])
			{
				GPS_Zone[playerid][0] = 0;
				PlayerTextDrawSetString(playerid, GPS_PTD[playerid][0], "_");
				for(new i = 0; i != 6; i++) TextDrawHideForPlayer(playerid, Text: GPS_TD[i]);
				PlayerTextDrawHide(playerid, PlayerText: GPS_PTD[playerid][0]);
			}
			for(new td = 0; td < 31; td++)
			{
				switch(td)
				{
				case 24..29: continue;
				default: TextDrawShowForPlayer(playerid, users_panel_td[td]);
				}
			}
			for(new ptd = 0; ptd < 9; ptd++)
			{
				if(ptd == 7) continue;
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][ptd]);
			}
			new format_string[(7+1)+MAX_PLAYER_NAME+3];
			format(format_string, sizeof(format_string), "%s_(%i)", users[playerid][u_name], playerid);
			PlayerTextDrawSetString(playerid, users_panel_ptd[playerid][0], format_string);
			DeletePVar(playerid, "PROTECT_LOADING");
		}
	case 1:
		{
			if(GetPVarInt(playerid, "PROTECT_LOADING")) return true;
			TextDrawHideForPlayer(playerid, Text: drop_items_TD);
			TextDrawSetString(LoadingPlayer_TD[1], "Loading....");
			for(new i = 0; i != 2; i++) TextDrawShowForPlayer(playerid, LoadingPlayer_TD[i]);
			TextDrawHideForPlayer(playerid, Text: drop_items_TD);
			// temp[playerid][protect_loading] = 0;
			SetPVarInt(playerid, "PROTECT_LOADING", 1);
			for(new td = 0; td < 31; td++) TextDrawHideForPlayer(playerid, users_panel_td[td]);
			for(new ptd = 0; ptd < 9; ptd++) PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][ptd]);
		}
	}
	return true;
}
stock AdminChat(const string[], level = 1, color = 0xA52A2AFF)
{
	foreach(Player, i)
	{
		if(!IsPlayerConnected(i)) return true;
		if(admin[i][admin_level] >= level && admin[i][u_a_dostup]) SendClientMessage(i, color, string);
	}
	return true;
}
stock PlayersInfo(playerid, text[], bool: status = true, time = 5)
{
	if(status)
	{
		SetPVarInt(playerid, "TIME_PLAYER_INFO", time);
		TextDrawSetString(PlayersInfo_TD, text);
		TextDrawShowForPlayer(playerid, PlayersInfo_TD);
	}
	else 
	{
		DeletePVar(playerid, "TIME_PLAYER_INFO");
		TextDrawSetString(PlayersInfo_TD, "_");
		TextDrawHideForPlayer(playerid, PlayersInfo_TD);
	}
}
/*stock server_error(playerid, text[], answer = 0) 
{
	global_string[0] = EOS;
	switch(answer)
	{
	case 0: strcat(global_string, "{B22222}Сервер: {FFFFF0}%s"); //A52A2A
	case 1: strcat(global_string, "{33AA33}Сервер: {FFFFF0}%s");
	case 2: strcat(global_string, "{808080}Сервер: {FFFFF0}%s");
	}
	new str_text[256];
	format(str_text, sizeof(str_text), global_string, text);
	SendClientMessage(playerid, COLOR_WHITE, str_text);
	return true; 
}*/

stock server_error(playerid, const text[])
{
	new format_string[(18+1)+128];
	format(format_string, sizeof(format_string), "Сервер: {fffff0}%s", text);
	SendClientMessage(playerid, color_error, format_string);
	return true;
}
stock server_accept(playerid, const text[])
{
	new format_string[(18+1)+128];
	format(format_string, sizeof(format_string), "Сервер: {fffff0}%s", text);
	SendClientMessage(playerid, color_accept, format_string);
	return true;
}
stock server_message(playerid, const text[])
{
	new format_string[(18+1)+128];
	format(format_string, sizeof(format_string), "Сервер: {fffff0}%s", text);
	SendClientMessage(playerid, color_message, format_string);
	return true;
}
stock ConnectPlayer(const name[])
{
	static status[MAX_PLAYER_NAME];
	if(GetPlayerID(name) != INVALID_PLAYER_ID) status = "{33AA33}Онлайн{ffffff}";
	else status = "{A52A2A}Оффлайн{ffffff}";
	return status;
}
stock GetPlayerID(const name[]) 
{
    #if defined sscanf 
		static id; 
		sscanf(name, "r", id); 
		return id; 
    #else 
        foreach(Player, i) 
        { 
        	if(PlayerIsOnline(i)) continue; 
            if(!strcmp (users[i][u_name], name, false)) return i; 
        } 
        return INVALID_PLAYER_ID; 
    #endif 
}  
stock clan_message(number, const text[])
{
    foreach(Player, i)
    {
        if (users[i][u_clan] != number) continue;
		if(!GetItem(i, 53)) continue;
        SendClientMessage(i, 0xADD8E6FF, text);
    }
    return true;
}  
stock split(const strsrc[], strdest[][], delimiter)
{
	new i, li, aNum, len;
	while(i <= strlen(strsrc))
	{
	    if(strsrc[i]==delimiter || i==strlen(strsrc))
		{
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
stock ShowPlayer_AntiCheatEditCode(playerid, code)
{
    new dialog_header[96], dialog_string[64];
    format(dialog_header, sizeof(dialog_header), "[Код: %s] Название: %s", anticheat[code][ac_code], anticheat[code][ac_name]);
	strcat(dialog_string, "{cccccc}Отключить\n");
	strcat(dialog_string, "{FFDEAD}Сообщать администрации\n");
	strcat(dialog_string, "{A52A2A}Кикать с сервера");
    return show_dialog(playerid, d_anticheat_settings, DIALOG_STYLE_LIST, dialog_header, dialog_string, !"Выбрать", !"Назад");
}  
stock AddMessage(account, const message[])
{
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_MESSAGE" (`m_owner`, `m_message`) VALUES ('%i', '%s')", account, message);
	m_query(str_sql);
}
stock AddUserLogin(playerid, status)
{
	/*
	status:
		0 - Не вверный ввод пароля;
		1 - Авторизация удачна;
		2 - Не верный ввод пин кода;
		3 - Верный ввод пароля;
		4 - Не верный ввод гугл;
		5 - Верный ввод гугл;
	*/
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_USERS_LOGIN" (`u_i_owner`, `u_i_date`, `u_i_ip`, `u_i_status`) VALUES ('%i', NOW(), '%s', '%i')", users[playerid][u_id], GetIp(playerid), status);
	m_query(str_sql);
}
stock AntiFlood(playerid, name[], time = 1)
{
	if(!strcmp(name, "AntiFloodGoodMode", false))
	{
		if(GetPVarInt(playerid, "AntiFloodGoodMode") > gettime()) return 1;
		SetPVarInt(playerid,"AntiFloodGoodMode", gettime() + time);
	}
	/*if(!strcmp(name, "AntiFloodCommandsLoot", false))
	{
		if(GetPVarInt(playerid, "AntiFloodCommandsLoot") > gettime()) return 1;
		SetPVarInt(playerid,"AntiFloodCommandsLoot", gettime() + time);
	}*/
	if(!strcmp(name, "clear", false))
	{
		DeletePVar(playerid, "AntiFloodCommandsLoot");
		DeletePVar(playerid, "AntiFloodGoodMode");
	}
	return 0;
}
stock IsPlayerInRangeOfPlayer(Float:f_Radius, playerid, targetid)
{
	new	Float: f_playerPos[3];
	GetPlayerPos(targetid, f_playerPos[0], f_playerPos[1], f_playerPos[2]);
	if(IsPlayerInRangeOfPoint(playerid, f_Radius, f_playerPos[0], f_playerPos[1], f_playerPos[2]) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) return true;
	return false;
}
stock addbox(playerid, type, Float: x, Float: y, Float: z, Float: f)
{
 	static str_sql[256], box_idx;
	m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_BOX" (`box_owner_id`, `box_type`, `box_xyzf`, `box_create`, `box_last_use`) VALUES ('%i', '%i', '%f,%f,%f,%f', NOW(), NOW())",
	users[playerid][u_id], type, x, y, z, f);
	m_query(str_sql);
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_BOX" WHERE `box_owner_id` = '%i' AND `box_type` = '%i' ORDER BY `box_id` DESC LIMIT 1", users[playerid][u_id], type);
	new Cache:temp_sql_1 = m_query(str_sql), rows;
	cache_get_row_count(rows);
	if(rows) cache_get_value_name_int(0, "box_id", box_idx);
	cache_delete(temp_sql_1);
	box[box_idx][box_id] = box_idx;
	format(box[box_idx][box_pass], MAX_PLAYER_NAME, "NoBoxPass1234");
	box[box_idx][box_slots] = 0;
	box[box_idx][box_lock] = 0;
	box[box_idx][box_type] = type;
	box[box_idx][box_owner_id] = users[playerid][u_id];
	box[box_idx][box_xyzf][0] = x;
	box[box_idx][box_xyzf][1] = y;
	box[box_idx][box_xyzf][2] = z;
	box[box_idx][box_xyzf][3] = f;
	switch(box[box_idx][box_type])
	{
	case 0: box[box_idx][box_object] = CreateDynamicObject(2977, box[box_idx][box_xyzf][0], box[box_idx][box_xyzf][1], box[box_idx][box_xyzf][2], 0, 0, box[box_idx][box_xyzf][3]);
	case 1:
		{
			box[box_idx][box_object] = CreateDynamicObject(964, box[box_idx][box_xyzf][0], box[box_idx][box_xyzf][1], box[box_idx][box_xyzf][2], 0, 0, box[box_idx][box_xyzf][3]+180);
			SetDynamicObjectMaterial(box[box_idx][box_object], 0, 3014, "cr_boxes", "CJ_SLATEDWOOD", 0);
			SetDynamicObjectMaterial(box[box_idx][box_object], 1, 3014, "cr_boxes", "CJ_SLATEDWOOD", 0);
			SetDynamicObjectMaterial(box[box_idx][box_object], 2, 3014, "cr_boxes", "CJ_SLATEDWOOD", 0);
		}
	case 2:
		{
			box[box_idx][box_object] = CreateDynamicObject(2361, box[box_idx][box_xyzf][0], box[box_idx][box_xyzf][1], box[box_idx][box_xyzf][2], 0, 0, box[box_idx][box_xyzf][3]);
			SetDynamicObjectMaterial(box[box_idx][box_object], 1, 2925, "dyno_box", "dyno_crate", 0);
			SetDynamicObjectMaterial(box[box_idx][box_object], 0, 2925, "dyno_box", "dyno_crate", 0);
		}
	}
}
stock UpdateObservationStatus(spectatorid, spectedid) 
{ 
    if(observation[spectatorid][observation_id] == spectedid) 
    { 
		switch(GetPlayerState(spectedid))
		{
		case PLAYER_STATE_WASTED:
			{
				static str[128];
				format(str, sizeof(str), "\nИгрок %s(%i) умер нажмите на кнопку ''UPDATE''.\n", users[spectedid][u_name], spectedid);
				show_dialog(spectatorid, d_none, DIALOG_STYLE_MSGBOX, "Наблюдение", str, !"Ок", !"");
				//GameTextForPlayer(spectatorid, "~r~Player is dead!", 5000, 3);
				return true;
			}
		case PLAYER_STATE_SPECTATING:
			{
				if(observation[spectedid][observation_id] != -1)
				{
					static str[128];
					format(str, sizeof(str), "\nИгрок %s(%i) ушел в режим наблюдения.\n", users[spectedid][u_name], spectedid);
					show_dialog(spectatorid, d_none, DIALOG_STYLE_MSGBOX, "Наблюдение", str, !"Ок", !"");
					callcmd::reoff(spectatorid);
					return true;
					//GameTextForPlayer(spectatorid, "~r~Player in spectating mode!", 5000, 3);
				}
			}
		}
		if(PlayerIsOnline(spectedid))
		{
			static str[128];
			format(str, sizeof(str), "\nИгрок %s(%i) вышел/не авторизовался/не заспавнился.\n", users[spectedid][u_name], spectedid);
			show_dialog(spectatorid, d_none, DIALOG_STYLE_MSGBOX, "Наблюдение", str, !"Ок", !"");
			callcmd::reoff(spectatorid);
			return true;
		}
        SetPlayerVirtualWorld(spectatorid, GetPlayerVirtualWorld(spectedid)); 
        SetPlayerInterior(spectatorid, GetPlayerInterior(spectedid)); 
        TogglePlayerSpectating(spectatorid, 1); 
        if(IsPlayerInAnyVehicle(spectedid)) PlayerSpectateVehicle(spectatorid, GetPlayerVehicleID(spectedid)); 
        else PlayerSpectatePlayer(spectatorid, spectedid); 
    } 
    return true; 
} 
stock GetSpeed(playerid)
{
	new Float: veh_xyzf[4];
	if(IsPlayerInAnyVehicle(playerid))
	GetVehicleVelocity(GetPlayerVehicleID(playerid), veh_xyzf[0], veh_xyzf[1], veh_xyzf[2]);
	else GetPlayerVelocity(playerid, veh_xyzf[0], veh_xyzf[1], veh_xyzf[2]);
	veh_xyzf[3] = floatsqroot(floatpower(floatabs(veh_xyzf[0]), 2.0) + floatpower(floatabs(veh_xyzf[1]), 2.0) + floatpower(floatabs(veh_xyzf[2]), 2.0)) * 100.3;
	return floatround(veh_xyzf[3]);
}
stock AddChatLogs(playerid, const log[])
{
	format(LogsChat[playerid][19], 128, "%s", LogsChat[playerid][18]);
	format(LogsChat[playerid][18], 128, "%s", LogsChat[playerid][17]);
	format(LogsChat[playerid][17], 128, "%s", LogsChat[playerid][16]);
	format(LogsChat[playerid][16], 128, "%s", LogsChat[playerid][15]);
	format(LogsChat[playerid][15], 128, "%s", LogsChat[playerid][14]);
	format(LogsChat[playerid][14], 128, "%s", LogsChat[playerid][13]);
	format(LogsChat[playerid][13], 128, "%s", LogsChat[playerid][12]);
	format(LogsChat[playerid][12], 128, "%s", LogsChat[playerid][11]);
	format(LogsChat[playerid][11], 128, "%s", LogsChat[playerid][10]);
	format(LogsChat[playerid][10], 128, "%s", LogsChat[playerid][9]);
	format(LogsChat[playerid][9], 128, "%s", LogsChat[playerid][8]);
	format(LogsChat[playerid][8], 128, "%s", LogsChat[playerid][7]);
	format(LogsChat[playerid][7], 128, "%s", LogsChat[playerid][6]);
	format(LogsChat[playerid][6], 128, "%s", LogsChat[playerid][5]);
	format(LogsChat[playerid][5], 128, "%s", LogsChat[playerid][4]);
	format(LogsChat[playerid][4], 128, "%s", LogsChat[playerid][3]);
	format(LogsChat[playerid][3], 128, "%s", LogsChat[playerid][2]);
	format(LogsChat[playerid][2], 128, "%s", LogsChat[playerid][1]);
	format(LogsChat[playerid][1], 128, "%s", LogsChat[playerid][0]);
	format(LogsChat[playerid][0], 128, "%s", log);
}
stock ShowSettings(playerid)
{
	static str[356], str_two[10], name_spawn[24];
	switch (users[playerid][u_settings][2])
	{
	case 0: name_spawn = "{cccccc}Рандомно точка";
	case 1: name_spawn = "{98FB98}Клановая точка";
	case 2: name_spawn = "{FFFACD}Личная точка";
	}
	format(str_two, sizeof(str_two), "№%i", users[playerid][u_settings][1]);
	format(str, sizeof(str), "Функция\tСтатус\n\
	{cccccc}1. {ffffff}Личные сообщения\t%s\n\
	{cccccc}2. {ffffff}Волна рации\t{E6E6FA}%s\n\
	{cccccc}3. {ffffff}Место появления\t%s\n\
	{cccccc}4. {ffffff}Кровь на экране\t%s\n\
	{cccccc}5. {ffffff}Смена ника\t {cccccc}%i жетонов\n", (!users[playerid][u_settings][0])?("{33AA33}Включено"):("{A52A2A}Выключено"), (!users[playerid][u_settings][1])?("{A52A2A}Нет"):(str_two), name_spawn, 
	(!users[playerid][u_settings][3])?("{33AA33}Включено"):("{A52A2A}Выключено"), users[playerid][u_setname]);
	show_dialog(playerid, d_settings, DIALOG_STYLE_TABLIST_HEADERS, !"Личные настройки", str, !"Выбрать", !"Назад");
	return true;
}
stock ShowSecurity(playerid)
{
	// return server_error(playerid, "Временно отключено!");
	static str[500], str_email[65];
	format(str_email, sizeof(str_email), users[playerid][u_email]);
	format(str, sizeof(str), "Функция\tСтатус\n\
	{cccccc}1. {ffffff}Сменить пароль\t \n\
	{cccccc}2. {ffffff}Почта (Email)\t{33AA33}%s\n\
	{cccccc}3. {ffffff}Google Authenticator\t%s\n\
	{cccccc}4. {ffffff}Пин-код\t%s\n\
	{cccccc}Информация о входе в аккаунт\t ", (users[playerid][u_email_status])?(str_email):("{A52A2A}Отвязана"), 
	(strcmp (users[playerid][u_googleauth], "NoGoogleAuth", false))?("{33AA33}Привязан"):("{A52A2A}Отвязан"), (strcmp (users[playerid][u_code], "NoCode", false))?("{33AA33}Привязан"):("{A52A2A}Отвязан")
	);// (users[playerid][u_connect_ip])?("{33AA33}Включен"):("{A52A2A}Отключен"));
	show_dialog(playerid, d_security, DIALOG_STYLE_TABLIST_HEADERS, !"Настройка безопасности", str, !"Выбрать", !"Назад");
	return true;
}
stock me_action(playerid, action[], Float:distance = 13.0)
{
	new _t_string [ 128 ] ;
	format ( _t_string, sizeof(_t_string), "%s %s", users[playerid][u_name], action ) ;
	ProxDetector ( playerid, distance, _t_string, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA, 0xC2A2DAAA);
	format ( _t_string, sizeof(_t_string), "%s", action ) ;
	SetPlayerChatBubble ( playerid, _t_string, 0xC2A2DAAA, 13, 5000 ) ;
	return 1;
}
stock EmailMessage(playerid, const email[], const input_text[], message_status = 0, const input_text_left[] = " ")
{
	new format_string[256];
	switch(message_status)
	{
	case 0:
		{
			format(temp[playerid][temp_email_code], MAX_PLAYER_NAME, GeneratePassword(6));
			format(format_string, sizeof(format_string),"email=%s&message=%s: %s<br/><br/>- САЙТ: "SITE_NAME"<br/>- ФОРУМ: "FORU_NAME"<br/>- ГРУППА VK: "VKON_NAME"<br/><br/>С уважением, администрация проекта "FULL_NAME"", email, input_text, temp[playerid][temp_email_code]);
		}
	case 1: format(format_string, sizeof(format_string),"email=%s&message=%s: %s<br/><br/>- САЙТ: "SITE_NAME"<br/>- ФОРУМ: "FORU_NAME"<br/>- ГРУППА VK: "VKON_NAME"<br/><br/>С уважением администрация проекта "FULL_NAME"", email, input_text, input_text_left);
	}
    HTTP(playerid, HTTP_POST, ""SITE_NAME"/System/plugins/message_mail.php", format_string, "@OnPlayerReceiveMessage");
	return true;
}
@OnPlayerReceiveMessage(playerid, response_code, response_message[]);
@OnPlayerReceiveMessage(playerid, response_code, response_message[])
{
    /*if(200 != response_code) 
    {
        printf("Произошла ошибка во время отправки сообщения на электронную почут:\n\
            Код ошибки: %d\n\
            Сообщение: %s", response_code, response_message);
    }*/
    // else printf("Сообщения, игроку: %d, отправлена!", playerid);
    return 1;
} 
stock GeneratePassword(size)
{
	new
	bigletters[26][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"},
	smallletters[26][] = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"},
	numbers[10][] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"},
	password[128];
	password[0] = EOS;
	if(size > sizeof(password)) size = sizeof(password);
	for(new i = 0; i < size; i++)
	{
		switch(random(3))
		{
		case 0: strcat(password, bigletters[random(sizeof(bigletters))]);
		case 1: strcat(password, smallletters[random(sizeof(smallletters))]);
		case 2: strcat(password, numbers[random(sizeof(numbers))]);
		}
	}
	return password;
}
stock GetPasswordLevel(password[])
{
	new 
		bool: have_numbers = false, 
		bool: have_upercase = false, 
		bool: have_lowercase = false;
	for(new i = strlen(password); i != 0; --i)
	switch(password[i])
	{
	case '0'..'9': have_numbers = true;
	case 'a'..'z': have_lowercase = true;
	case 'A'..'Z': have_upercase = true;
	}
	if(have_numbers && have_lowercase && have_upercase) return 2;
	else if(have_numbers && have_lowercase || have_numbers && have_upercase || have_lowercase && have_upercase) return 1;
	else if(have_numbers || have_lowercase || have_upercase) return 0;
	return 0;
}
stock IsValidEMail(email[])
{
	new 
		bool: Good,
		bool: Succes = true;
	for(new i; i < strlen(email); i++)
	{
		if(email[i] == '@')
		{
			if(!Good) Good = true;
			else
			{
				Good = false;
				break;
			}
		}
		if(!ValidChar(email[i])) Succes = false;
	}
	if(!Good) Succes = false;
	if(!TextFind(email,".ru") && !TextFind(email,".com") && !TextFind(email,".ua") && !TextFind(email,".su") && !TextFind(email,".me") && !TextFind(email,".kz")) Succes = false;
	if(!TextFind(email,"@")) Succes = false;
	return Succes;
}
stock TextFind(text[], findtext[])
{
	return strfind(text, findtext) != -1;
}
stock ValidChar(mailchar)
{
	if((mailchar >= 'A' && mailchar <= 'Z') ||
	(mailchar >= 'a' && mailchar <= 'z') ||
	(mailchar >= '0' && mailchar <= '9') ||
	(mailchar == '-') || (mailchar == '_') ||
	(mailchar == '@') || (mailchar == '.')) return true;
	return false;
}
/*stock message_to_email(playerid, const email[])
{
	email_code[playerid] = random_ex(100000, 999999);
	new format_string[(145+1)+6];
	format(format_string, sizeof(format_string), "Ваш код подтверждения: %i\n\n- САЙТ: "SITE_NAME"\n- ФОРУМ: "FORU_NAME"\n- ГРУППА VK: "VKON_NAME"\n\nС уважением администрация проекта "FULL_NAME"", email_code[playerid]);
	SendMail(email, "admin", "Администрация "LEFT_NAME"", ""LEFT_NAME"", format_string);
	return true;
}*/
/*
stock GetPasswordLevel(pass[])
{
	static str_sql[165];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_id` = '%i' AND `c_change_spawn` = '1' AND `c_change_spawn_xyzfwi` != '0, 0, 0, 0, 0, 0' LIMIT 1", GetPVarInt(playerid, "AdminClanSpawn"));
	new Cache:temp_sql = m_query(str_sql), rows;
	cache_get_row_count(rows);
	
	cache_delete(temp_sql);
	new bool: PasswordLeveusers[4] = false,
		strong_password = 0;
	for(new i = 0; pass[i] != 0x0; i++)
	{
		switch(pass[i])
		{
		case '0'..'9': PasswordLeveusers[0] = true;
		case 'A'..'Z': PasswordLeveusers[1] = true;
		case 'a'..'z': PasswordLeveusers[2] = true;
		default: PasswordLeveusers[3] = true;
		}
	}
	if(PasswordLeveusers[0]) strong_password++;
	if(PasswordLeveusers[1]) strong_password++;
	if(PasswordLeveusers[2]) strong_password++;
	if(PasswordLeveusers[3]) strong_password++;
	if(strlen(pass) > 12) strong_password++;
	switch(strong_password)
	{
	case 1, 2: return "{F51414}Слабый";
	case 3: return "{FAD605}Средний";
	case 4, 5: return "{14F520}Сильный";
	}
	return true;
}
*/
/*
stock IsPlayerToKvadrat(playerid, Float:min_x, Float:min_y, Float:max_x, Float:max_y)
{
	new Float: x, Float: y, Float: z; 
	GetPlayerPos(playerid, x, y, z);
	if((x <= max_x && x >= min_x) && (y <= max_y && y >= min_y)) return 1;
	return 0; 
}*/
stock SaveAccountInt(playerid, const table[], int)
{
	new str_sql[156];
	m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `%s` = '%i' WHERE `u_id` = '%i';", table, int, users[playerid][u_id]);
	m_query(str_sql);
	return true;
}
stock money(playerid, const string[], value)
{
	if(!strcmp(string, "+", false))
	{
		users[playerid][u_money] += value;
		SaveUser(playerid, "money");
		return true;
	}
	if(!strcmp(string, "-", false))
	{
		if (users[playerid][u_money] < value) return server_error(playerid, "У вас недостаточно средств.");
		users[playerid][u_money] -= value;
		SaveUser(playerid, "money");
		return true;
	}
	return true;
}
stock SaveUser(playerid, const string[])
{
	new mysql_format_string[800];
	// str_sql[0] = EOS;
	if(!strcmp(string, "settings", false))
	{
		m_format(mysql_format_string, sizeof(mysql_format_string),"UPDATE "TABLE_USERS" SET `u_settings` = '%i, %i, %i, %i, %i, %i, %i, %i' WHERE `u_id` = '%i';", 
		users[playerid][u_settings][0], users[playerid][u_settings][1], users[playerid][u_settings][2], users[playerid][u_settings][3], users[playerid][u_settings][4], users[playerid][u_settings][5], users[playerid][u_settings][6], 
		users[playerid][u_settings][7], users[playerid][u_id]);
		m_query(mysql_format_string);
		return true;
	}
	if(!strcmp(string, "vip", false))
	{
		m_format(mysql_format_string, sizeof(mysql_format_string),"UPDATE "TABLE_USERS" SET `u_settings_vip` = '%i, %i, %i, %i' WHERE `u_id` = '%i';", 
		users[playerid][u_settings_vip][0], users[playerid][u_settings_vip][1], users[playerid][u_settings_vip][2], users[playerid][u_settings_vip][3], users[playerid][u_id]);
		m_query(mysql_format_string);
		return true;
	}
	if(!strcmp(string, "kill", false))
	{
		m_format(mysql_format_string, sizeof(mysql_format_string),"UPDATE "TABLE_USERS" SET `u_kill` = '%i,%i' WHERE `u_id` = '%i';", users[playerid][u_kill][0], users[playerid][u_kill][1], users[playerid][u_id]);
		m_query(mysql_format_string);
		return true;
	}
	if(!strcmp(string, "pack", false))
	{
		m_format(mysql_format_string, sizeof(mysql_format_string),"UPDATE "TABLE_USERS" SET `u_pack` = '%i,%i,%i,%i,%i,0' WHERE `u_id` = '%i';", users[playerid][u_pack][0], users[playerid][u_pack][1], users[playerid][u_pack][2], users[playerid][u_pack][3], users[playerid][u_pack][4], users[playerid][u_id]);
		m_query(mysql_format_string);
		return true;
	}
	if(!strcmp(string, "reward", false))
	{
		m_format(mysql_format_string, sizeof(mysql_format_string),"UPDATE "TABLE_USERS" SET `u_reward` = '%i,%i,%i,%i,%i,%i,%i,%i,%i,%i' WHERE `u_id` = '%i';", 
		users[playerid][u_reward][0], users[playerid][u_reward][1], users[playerid][u_reward][2], users[playerid][u_reward][3], users[playerid][u_reward][4], 
		users[playerid][u_reward][5], users[playerid][u_reward][6], users[playerid][u_reward][7], users[playerid][u_reward][8], users[playerid][u_reward][9], 
		users[playerid][u_id]);
		m_query(mysql_format_string);
		return true;
	}
	if(!strcmp(string, "achievement", false))
	{
		m_format(mysql_format_string, sizeof(mysql_format_string),"UPDATE "TABLE_USERS" SET `u_achievement` = '%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i' WHERE `u_id` = '%i';", 
		users[playerid][u_achievement][0], users[playerid][u_achievement][1], users[playerid][u_achievement][2], users[playerid][u_achievement][3], users[playerid][u_achievement][4], users[playerid][u_achievement][5], 
		users[playerid][u_achievement][6], users[playerid][u_achievement][7], users[playerid][u_achievement][8], users[playerid][u_achievement][9], users[playerid][u_achievement][10], users[playerid][u_achievement][11],
		users[playerid][u_achievement][12], users[playerid][u_id]);
		m_query(mysql_format_string);
		return true;
	}
	if(!strcmp(string, "money", false))
	{
		m_format(mysql_format_string, sizeof(mysql_format_string),"UPDATE "TABLE_USERS" SET `u_money` = '%i' WHERE `u_id` = '%i';", users[playerid][u_money], users[playerid][u_id]);
		m_query(mysql_format_string);
		return true;
	}
	if(!strcmp(string, "account", false))
	{
		if(!temp[playerid][temp_login]) return true;
		if(temp[playerid][time_infinity_health] || admin[playerid][u_a_gm] || temp[playerid][infinity_health]) users[playerid][u_health] = 100.0;
		GetPlayerHealth(playerid, users[playerid][u_health]);
		GetPlayerArmour(playerid, users[playerid][u_armour]);
		if(observation[playerid][observation_id] == INVALID_PLAYER_ID && GetPlayerVirtualWorld(playerid) < 10) 
		{
			GetPlayerPos(playerid, users[playerid][u_spawn_xyz][0], users[playerid][u_spawn_xyz][1], users[playerid][u_spawn_xyz][2]);
			GetPlayerFacingAngle(playerid, users[playerid][u_spawn_xyz][3]);
			users[playerid][u_spawn_wi][0] = GetPlayerVirtualWorld(playerid);
			users[playerid][u_spawn_wi][1] = GetPlayerInterior(playerid);
		}
		else 
		{
			users[playerid][u_spawn_xyz][0] = observation[playerid][observation_XYZF][0];
			users[playerid][u_spawn_xyz][1] = observation[playerid][observation_XYZF][1];
			users[playerid][u_spawn_xyz][2] = observation[playerid][observation_XYZF][2];
			users[playerid][u_spawn_xyz][3] = observation[playerid][observation_XYZF][3];
			users[playerid][u_spawn_wi][0] = observation[playerid][observation_WI][0];
			users[playerid][u_spawn_wi][1] = observation[playerid][observation_WI][1];
		}
		m_format(mysql_format_string, sizeof(mysql_format_string), "UPDATE "TABLE_USERS" SET `u_newgame` = '%i', `u_vip_time` = '%i', `u_health` = '%f', `u_armour` = '%f', `u_temperature` = '%f', \
		`u_thirst` = '%i', `u_hunger` = '%i', `u_backpack` = '%i', `u_spawn_xyzwi` = '%f, %f, %f, %f, %i, %i', `u_karma` = '%i', `u_lifetime` = '%i', `u_death` = '%i', `u_loot` = '%i', \
		`u_damage` = '%i,%i', `u_score` = '%i' WHERE `u_id` = '%i';", 
		users[playerid][u_newgame], users[playerid][u_vip_time], users[playerid][u_health], users[playerid][u_armour], users[playerid][u_temperature], users[playerid][u_thirst], users[playerid][u_hunger], 
		users[playerid][u_backpack], users[playerid][u_spawn_xyz][0], users[playerid][u_spawn_xyz][1], users[playerid][u_spawn_xyz][2], users[playerid][u_spawn_xyz][3], users[playerid][u_spawn_wi][0], 
		users[playerid][u_spawn_wi][1], users[playerid][u_karma], users[playerid][u_lifetime], users[playerid][u_death], users[playerid][u_loot], users[playerid][u_damage][0], users[playerid][u_damage][1],
		users[playerid][u_score], users[playerid][u_id]);
		m_query(mysql_format_string);
		m_format(mysql_format_string, sizeof(mysql_format_string), "UPDATE "TABLE_USERS" SET `u_lifegame` = '%i', `u_skin` = '%i', `u_slots` = '%i', `u_humanity` = '%i', `u_mute` = '%i', `u_clan` = '%i', \
		`u_clan_rank` = '%i', `u_eat_food` = '%i', `u_helmet` = '%i', `u_setname` = '%i', `u_infected` = '%i' WHERE `u_id` = '%i';", 
		users[playerid][u_lifegame], users[playerid][u_skin], users[playerid][u_slots], users[playerid][u_humanity], users[playerid][u_mute], users[playerid][u_clan], users[playerid][u_clan_rank], 
		users[playerid][u_eat_food], users[playerid][u_helmet], users[playerid][u_setname], users[playerid][u_infected], users[playerid][u_id]);
		m_query(mysql_format_string);

		SavePlayerWeapons(playerid);
		SavePlayerInventory(playerid);
		printf("["SQL_VER"]: Игрок %s (%i) успешно сохранен.", users[playerid][u_name], users[playerid][u_id]);
		temp[playerid][temp_login] = false;
		return true;
	}
	return true;
}
stock PointOfStatus(Slashes, Points)
{
	new SlashesAndPoints[160];
	for(new i = 0; i < Slashes; i++) strcat(SlashesAndPoints, "|");
	strcat(SlashesAndPoints, "{cccccc}");
	for(new i = 0; i < Points; i++) strcat(SlashesAndPoints, ".");
	return SlashesAndPoints;
}
stock ShowProgress(playerid)
{
	new str[356], achievement_part[4], max_achievement_status, max_achievement_part[4];
	achievement_part[0] = users[playerid][u_kill][1];
	achievement_part[1] = users[playerid][u_kill][0];
	achievement_part[2] = users[playerid][u_lifetime];
	achievement_part[3] = users[playerid][u_eat_food];
	if(achievement_part[0] > achievements[3][achievement_progress])  achievement_part[0] = achievements[3][achievement_progress];
	if(achievement_part[1] > achievements[7][achievement_progress]) achievement_part[1] = achievements[7][achievement_progress];
	if(achievement_part[2] > achievements[9][achievement_progress]) achievement_part[2] = achievements[9][achievement_progress];
	if(achievement_part[3] > achievements[12][achievement_progress]) achievement_part[3] = achievements[12][achievement_progress];
	switch(achievement_part[0])
	{
	case 0..99: max_achievement_part[0] = achievements[0][achievement_progress];
	case 100..499: max_achievement_part[0] = achievements[1][achievement_progress];
	case 500..999: max_achievement_part[0] = achievements[2][achievement_progress];
	// case 1000..5000: max_achievement_part[0] = achievements[3][achievement_progress];
	default: max_achievement_part[0] = achievements[3][achievement_progress];
	}
	switch(achievement_part[1])
	{
	case 0..99: max_achievement_part[1] = achievements[4][achievement_progress];
	case 100..499: max_achievement_part[1] = achievements[5][achievement_progress];
	case 500..999: max_achievement_part[1] = achievements[6][achievement_progress];
	// case 1000..5000: max_achievement_part[1] = achievements[7][achievement_progress];
	default: max_achievement_part[1] = achievements[7][achievement_progress];
	}
	/*switch(achievement_part[2])
	{
	case 0..86399: max_achievement_part[2] = achievements[8][achievement_progress];
	case 86400..172800: max_achievement_part[2] = achievements[9][achievement_progress];
	default:  max_achievement_part[2] = achievements[9][achievement_progress];
	}*/
	if(achievement_part[2] < 86399) max_achievement_part[2] = achievements[8][achievement_progress];
	else if(achievement_part[2] > 86400) max_achievement_part[2] = achievements[9][achievement_progress];
	switch(achievement_part[3])
	{
	case 0..99: max_achievement_part[3] = achievements[10][achievement_progress];
	case 100..499: max_achievement_part[3] = achievements[11][achievement_progress];
	// case 500..1000: max_achievement_part[3] = achievements[12][achievement_progress];
	default: max_achievement_part[3] = achievements[12][achievement_progress];
	}
	if(max_achievement_status) max_achievement_status = 0;
	for(new z = 0; z != sizeof(achievements); z++) 
	{
		if (users[playerid][u_achievement][z] == 1) max_achievement_status++;
	}
	format(str, sizeof(str), "Название\tПрогресс\n\
	{4682B4}Мои достижения\t{4682B4}%i {fffff0}/ {4682B4}%i\n\
	{fffff0}Монстр\t{4682B4}%i {fffff0}/ {4682B4}%i\n\
	{fffff0}Истинный выживший\t{4682B4}%i {fffff0}/ {4682B4}%i\n\
	{fffff0}Прожить хотя бы сутки\t{4682B4}%i {fffff0}/ {4682B4}%i\n\
	{fffff0}Ненасытный\t{4682B4}%i {fffff0}/ {4682B4}%i", max_achievement_status, sizeof(achievements), achievement_part[0], max_achievement_part[0], achievement_part[1], max_achievement_part[1], 
	achievement_part[2], max_achievement_part[2], achievement_part[3], max_achievement_part[3]);
	show_dialog(playerid, d_achievements, DIALOG_STYLE_TABLIST_HEADERS, !"Достижения", str, !"Выбрать", !"Назад");
	return true;
}
stock Quest(playerid, number)
{
	switch(number)
	{
	case 0:
		{
			if (users[playerid][u_achievement][0] != 1)
			{
				if (users[playerid][u_kill][1] >= achievements[0][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[0][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					users[playerid][u_pack][0] += 10;
					SaveUser(playerid, "pack");
					users[playerid][u_achievement][0] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[0][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[0][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if (users[playerid][u_achievement][1] != 1)
			{
				if (users[playerid][u_kill][1] >= achievements[1][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[1][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					users[playerid][u_pack][3] += 20;
					SaveUser(playerid, "pack");
					users[playerid][u_achievement][1] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[1][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[1][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if (users[playerid][u_achievement][2] != 1)
			{
				if (users[playerid][u_kill][1] >= achievements[2][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[2][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					users[playerid][u_pack][4] += 30;
					SaveUser(playerid, "pack");
					users[playerid][u_achievement][2] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[2][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[2][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if (users[playerid][u_achievement][3] != 1)
			{
				if (users[playerid][u_kill][1] >= achievements[3][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[3][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					users[playerid][u_achievement][3] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[3][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[3][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
		}
	case 1:
		{
			if (users[playerid][u_achievement][4] != 1)
			{
				if (users[playerid][u_kill][0] >= achievements[4][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[4][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					users[playerid][u_pack][0] += 30;
					SaveUser(playerid, "pack");
					users[playerid][u_achievement][4] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[4][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[4][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if (users[playerid][u_achievement][5] != 1)
			{
				if (users[playerid][u_kill][0] >= achievements[5][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[5][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					// users[playerid][u_money] += 300000;
					money(playerid, "+", 300000);
					users[playerid][u_achievement][5] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[5][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[5][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if (users[playerid][u_achievement][6] != 1)
			{
				if (users[playerid][u_kill][0] >= achievements[6][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[6][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					// users[playerid][u_money] += 700000;
					money(playerid, "+", 700000);
					users[playerid][u_achievement][6] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[6][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[6][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if (users[playerid][u_achievement][7] != 1)
			{
				if (users[playerid][u_kill][0] >= achievements[7][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[7][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					users[playerid][u_pack][4] += 30;
					SaveUser(playerid, "pack");
					users[playerid][u_achievement][7] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[7][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[7][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
		}
	case 2:
		{
			if (users[playerid][u_achievement][8] != 1)
			{
				new achiev_part = users[playerid][u_lifetime];
				if(achiev_part >= achievements[8][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[8][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					users[playerid][u_slots] += 5;
					// users[playerid][PlayerInv][108] += 5;
					AddItem(playerid, 108, 5);
					users[playerid][u_achievement][8] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[8][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[8][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if(!users[playerid][u_achievement][9])
			{
				new achiev_part = users[playerid][u_lifetime];
				if(achiev_part >= achievements[9][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[9][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					users[playerid][u_pack][3] += 50;
					SaveUser(playerid, "pack");
					users[playerid][u_achievement][9] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[9][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[9][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
		}
	case 3:
		{
			if (users[playerid][u_achievement][10] != 1)
			{
				if (users[playerid][u_eat_food] >= achievements[10][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[10][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					// users[playerid][u_money] += 50000;
					money(playerid, "+", 50000);
					users[playerid][u_achievement][10] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[10][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[10][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if (users[playerid][u_achievement][11] != 1)
			{
				if (users[playerid][u_eat_food] >= achievements[11][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[11][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					// users[playerid][u_money] += 80000;
					money(playerid, "+", 80000);
					users[playerid][u_achievement][11] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[11][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[11][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
			if (users[playerid][u_achievement][12] != 1)
			{
				if (users[playerid][u_eat_food] >= achievements[12][achievement_progress])
				{
					static str[128];
					format(str, sizeof(str), "Игрок %s выполнил достижение ''%s''.", users[playerid][u_name], achievements[12][achievement_name]);
					SendClientMessageToAll(COLOR_ALL, str);
					// users[playerid][u_money] += 100000;
					money(playerid, "+", 100000);
					users[playerid][u_achievement][12] = 1;
					SCMG(playerid, "Вы получили достижение ''{4682B4}%s{fffff0}''.", achievements[12][achievement_name]);
					SCMG(playerid, "Ваша награда: '{4682B4}%s{fffff0}.", achievements[12][achievement_about]);
					SaveUser(playerid, "achievement");
				}
			}
		}
	}
	return true;
}
stock RemovePlayerArmour(playerid, Float: armour)
{
	users[playerid][u_armour] -= armour;
	if (users[playerid][u_armour] < 1) 
	{
		users[playerid][u_armour] = 0;
		if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
	}
	// GetPlayerArmour(playerid, users[playerid][u_armour]);
	SetPlayerArmour(playerid, users[playerid][u_armour]);
	return true;
}
stock AntiCheatOffAndOn(playerid, status)
{
	switch(status)
	{
	case 0:
		{
			if(admin[playerid][admin_level] >= 2)
			{
				for(new ac = 0; ac != 10; ac++) { EnableAntiCheatForPlayer(playerid, ac, 0); }
				// for(new i = 52; i != -1; --i) EnableAntiCheatForPlayer(playerid, i, 0); 
			}
			if(FullDostup(playerid)) 
			{
				for(new ac = AC_MAX_CODES; ac != -1; --ac) { EnableAntiCheatForPlayer(playerid, ac, 0); }
				// for(new ac = 0; ac != 5; ac++) { EnableAntiCheatForPlayer(playerid, ac, 1); }
			}
		}
	case 1:
		{
			for(new i = AC_MAX_CODES; i != -1; --i) { EnableAntiCheatForPlayer(playerid, i, 1); }
		}
	}
	return true;
}
stock GetZone(playerid) 
{
	if(GPS_Zone[playerid][0])
	{
		GPS_Zone[playerid][0]--;
		if(GPS_Zone[playerid][0] < 1)
		{
			GPS_Zone[playerid][0] = 0;
			PlayerTextDrawSetString(playerid, GPS_PTD[playerid][0], "_");
   			for(new i = 0; i != 6; i++) TextDrawHideForPlayer(playerid, Text: GPS_TD[i]);
			PlayerTextDrawHide(playerid, PlayerText: GPS_PTD[playerid][0]);
		}
	}
	if(!GetItem(playerid, 52) || GPS_Zone[playerid][0] || PlayerIsOnline(playerid)) return true;
	if(GPS_Zone[playerid][1] != -1 && GetPlayerZone(playerid) != GPS_Zone[playerid][1])
	{
		GPS_Zone[playerid][1] = -1;
	}
	if(!GPS_Zone[playerid][0] && GPS_Zone[playerid][1] == -1)
	{
		new z_index = GetPlayerZone(playerid);
		if(z_index != 455)
		{
			static z_name[70]; 
			format(z_name, sizeof(z_name), "%s", zones[z_index][zone_name]);
			PlayerTextDrawSetString(playerid, GPS_PTD[playerid][0], z_name);
   			for(new i = 0; i != 6; i++) TextDrawShowForPlayer(playerid, Text: GPS_TD[i]);
			PlayerTextDrawShow(playerid, PlayerText: GPS_PTD[playerid][0]);
			GPS_Zone[playerid][1] = z_index;
			GPS_Zone[playerid][0] = 5;
		}
	}
	return true; 
}
stock GetPlayerZone(playerid) 
{
	new Float:POS[3]; 
	GetPlayerPos(playerid, POS[0], POS[1], POS[2]);
	for(new i=0; i<sizeof(zones); i++) 
	{ 
		if(POS[0] >= zones[i][zPos][0] && POS[0] <= zones[i][zPos][3] && POS[1] >= zones[i][zPos][1] && POS[1] <= zones[i][zPos][4]) return i; 
	}
	return 455;
}
stock CraftSystemTool(playerid, type)
{
	if(IsPlayerInWater(playerid)) return server_error(playerid, "Вы Не должны находиться в воде!");
	// if(IsPlayerToCube(playerid, -872.3362, 2005.8126, 45.8325, -958.0191, 2027.3754, 75.4132) || 
	// IsPlayerToCube(playerid, -2394.9941, 2541.2268, 7.6683, -2527.1462, 2474.6292, 28.1215)) return server_error(playerid, "В этом месте запрещено ставить ящики");
	if(IsPlayerInRangeOfPoint(playerid, 50.0, -912.8105, 2010.2269, 60.9141) ||
	IsPlayerInRangeOfPoint(playerid, 90.0, -2466.2231, 2502.9683, 16.6739)) return server_error(playerid, "В этом месте запрещено ставить ящики.");
	/*static next_crated = 0;
	if(next_crated) next_crated = 0;
	for(new c = 0; c != MAX_CRAFT; c++)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 2.0, craft_tool[c][craft_XYZ][0], craft_tool[c][craft_XYZ][1], craft_tool[c][craft_XYZ][2])) continue;
		next_crated = 1;
	}
	if(next_crated == 1) return server_error(playerid, "В блези 2-х метров к другому нельзя ставить.");*/
	new query[156];
	m_format(query, sizeof(query), "SELECT * FROM "TABLE_CRAFT_TOOLS" WHERE `craft_owner` = '%i' AND `craft_type` = '%i'", users[playerid][u_id], type);
	new Cache:result = m_query(query), rows;
	cache_get_row_count(rows);
	switch(type)
	{
	case 1:
		{
			switch(rows)
			{
				case 3: if(!users[playerid][u_vip_time]) return server_error(playerid, "Вы уже создали максимальное кол-во деревянных дверей, чтобы создать больше необходимо приобрести вип.");
				case 5: return server_error(playerid, "Вы уже создали максимальное кол-во деревянных дверей.");
			}
			if(GetItem(playerid, 115) < 6) return server_error(playerid, "Для создания требуется 6 досок, а также набор инструментов.");
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Для создания требуется набор инструментов.");
			// users[playerid][PlayerInv][115] -= 6;
			RemoveItem(playerid, 115, 0, 6);
			users[playerid][u_slots] -= 6;
		}
	case 2:
		{
			switch(rows)
			{
				case 3: if(!users[playerid][u_vip_time]) return server_error(playerid, "Вы уже создали максимальное кол-во железных дверей, чтобы создать больше необходимо приобрести вип.");
				case 5: return server_error(playerid, "Вы уже создали максимальное кол-во железных дверей.");
			}
			if(GetItem(playerid, 118) < 6) return server_error(playerid, "Для создания требуется 6 железных пластин, а также набор инструментов.");
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Для создания требуется набор инструментов.");
			// users[playerid][PlayerInv][118] -= 6;
			RemoveItem(playerid, 118, 0, 6);
			// RemoveItem(playerid, 118);
			users[playerid][u_slots] -= 6;
		}
	case 3:
		{
			switch(rows)
			{
				case 2: if(!users[playerid][u_vip_time]) return server_error(playerid, "Вы уже создали максимальное кол-во циркулярных станоков, чтобы создать больше необходимо приобрести вип.");
				case 4: return server_error(playerid, "Вы уже создали максимальное кол-во циркулярных станоков.");
			}
			if(GetItem(playerid, 115) < 5)
			{
				if(GetItem(playerid, 117) < 2) return server_error(playerid, "Для создания требуется 5 досок и 2 необработанного железа, а также набор инструментов.");
				else if(GetItem(playerid, 117) > 2) return server_error(playerid, "Для создания требуется 5 досок, а также набор инструментов.");
				return true;
			}
			if(GetItem(playerid, 117) < 2)
			{
				if(GetItem(playerid, 115) < 5) return server_error(playerid, "Для создания требуется 5 досок и 2 необработанного железа, а также набор инструментов.");
				else if(GetItem(playerid, 115) > 5) return server_error(playerid, "Для создания требуется 2 необработанного железа, а также набор инструментов.");
				return true;
			}
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Для создания требуется набор инструментов.");
			// users[playerid][PlayerInv][115] -= 5;
			// users[playerid][PlayerInv][117] -= 2;
			RemoveItem(playerid, 115, 0, 5);
			RemoveItem(playerid, 117, 0, 2);
			users[playerid][u_slots] -= 7;
		}
	case 4:
		{
			switch(rows)
			{
				case 2: if(!users[playerid][u_vip_time]) return server_error(playerid, "Вы уже создали максимальное кол-во верстаков, чтобы создать больше необходимо приобрести вип.");
				case 4: return server_error(playerid, "Вы уже создали максимальное кол-во верстаков.");
			}
			if(GetItem(playerid, 115) < 2)
			{
				if(GetItem(playerid, 117) < 3) return server_error(playerid, "Для создания требуется 2 доски и 3 необработанного железа, а также набор инструментов.");
				else if(GetItem(playerid, 117) > 3) return server_error(playerid, "Для создания требуется 2 доски, а также набор инструментов.");
				return true;
			}
			if(GetItem(playerid, 117) < 3)
			{
				if(GetItem(playerid, 115) < 2) return server_error(playerid, "Для создания требуется 2 досок и 3 необработанного железа, а также набор инструментов.");
				else if(GetItem(playerid, 115) > 2) return server_error(playerid, "Для создания требуется 3 необработанного железа, а также набор инструментов.");
				return true;
			}
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Для создания требуется набор инструментов.");
			// users[playerid][PlayerInv][115] -= 2;
			// users[playerid][PlayerInv][117] -= 3;
			RemoveItem(playerid, 115, 0, 2);
			RemoveItem(playerid, 117, 0, 3);
			users[playerid][u_slots] -= 5;
		}
	case 5:
		{
			switch(rows)
			{
				case 2: if(!users[playerid][u_vip_time]) return server_error(playerid, "Вы уже создали максимальное кол-во электропечей, чтобы создать больше необходимо приобрести вип.");
				case 4: return server_error(playerid, "Вы уже создали максимальное кол-во электропечей.");
			}
			if(GetItem(playerid, 117) < 8)
			{
				if(GetItem(playerid, 118) < 4) return server_error(playerid, "Для создания требуется 8 необработанного железа и 4 железных пластин, а также набор инструментов.");
				else if(GetItem(playerid, 118) > 4) return server_error(playerid, "Для создания требуется 8 необработанного железа, а также набор инструментов.");
				return true;
			}
			if(GetItem(playerid, 118) < 3)
			{
				if(GetItem(playerid, 117) < 8) return server_error(playerid, "Для создания требуется 8 необработанного железа и 4 железных пластин, а также набор инструментов.");
				else if(GetItem(playerid, 117) > 8) return server_error(playerid, "Для создания требуется 8 необработанного железа, а также набор инструментов.");
				return true;
			}
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Для создания требуется набор инструментов.");
			// users[playerid][PlayerInv][117] -= 8;
			// users[playerid][PlayerInv][118] -= 3;
			RemoveItem(playerid, 117, 0, 7);
			RemoveItem(playerid, 118, 0, 3);
			users[playerid][u_slots] -= 11;
		}
	case 6:
		{
			switch(rows)
			{
				case 3: if(!users[playerid][u_vip_time]) return server_error(playerid, "Вы уже создали максимальное кол-во генераторов, чтобы создать больше необходимо приобрести вип.");
				case 5: return server_error(playerid, "Вы уже создали максимальное кол-во генераторов.");
			}
			if(GetItem(playerid, 117) < 4)
			{
				if(GetItem(playerid, 118) < 3) return server_error(playerid, "Для создания требуется 4 необработанного железа и 3 железных пластин, а также набор инструментов.");
				else if(GetItem(playerid, 118) > 3) return server_error(playerid, "Для создания требуется 4 необработанного железа, а также набор инструментов.");
				return true;
			}
			if(GetItem(playerid, 118) < 3)
			{
				if(GetItem(playerid, 117) < 4) return server_error(playerid, "Для создания требуется 4 необработанного железа и 3 железных пластин, а также набор инструментов.");
				else if(GetItem(playerid, 117) > 4) return server_error(playerid, "Для создания требуется 4 необработанного железа, а также набор инструментов.");
				return true;
			}
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Для создания требуется набор инструментов.");
			// users[playerid][PlayerInv][117] -= 4;
			// users[playerid][PlayerInv][118] -= 3;
			RemoveItem(playerid, 117, 0, 4);
			RemoveItem(playerid, 118, 0, 3);
			users[playerid][u_slots] -= 7;
		}
	}
	cache_delete(result);
	new Float: player_pos[3];
	GetPlayerPos(playerid, player_pos[0], player_pos[1], player_pos[2]);
 	new str_sql[256];
	m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_CRAFT_TOOLS" (`craft_type`, `craft_owner`, `craft_health`, `craft_XYZ`, `craft_date`, `craft_date_use`) VALUES ('%i', '%i', '%i', '%f,%f,%f', NOW(), NOW());",
	type, users[playerid][u_id], craft_table[type-1][craft_prochnost], player_pos[0], player_pos[1]+2, player_pos[2]-0.5);
	m_query(str_sql);
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CRAFT_TOOLS" WHERE `craft_owner` = '%i' AND `craft_type` = '%i' ORDER BY `craft_id` DESC LIMIT 1", users[playerid][u_id], type);
	new Cache:temp_sql_1 = m_query(str_sql), r;
	cache_get_row_count(r);
	if(r)
	{
		SCMG(playerid, "Вы создали '%s'.", craft_table[type-1][craft_name]);
		cache_get_value_name_int(0, "craft_id", edit_player_object[playerid]);
		craft_tool[edit_player_object[playerid]][craft_id] = edit_player_object[playerid];
		craft_tool[edit_player_object[playerid]][craft_type] = type;
		format(craft_tool[edit_player_object[playerid]][craft_password], 24, "NoCraftPass321");
		craft_tool[edit_player_object[playerid]][craft_owner] = users[playerid][u_id];
		craft_tool[edit_player_object[playerid]][craft_XYZ][0] = player_pos[0];
		craft_tool[edit_player_object[playerid]][craft_XYZ][1] = player_pos[1]+2;
		craft_tool[edit_player_object[playerid]][craft_XYZ][2] = player_pos[2]-0.5;
		craft_tool[edit_player_object[playerid]][craft_rXrYrZ][0] = 0.0;
		craft_tool[edit_player_object[playerid]][craft_rXrYrZ][1] = 0.0;
		craft_tool[edit_player_object[playerid]][craft_rXrYrZ][2] = 0.0;
		craft_tool[edit_player_object[playerid]][craft_health] = craft_table[craft_tool[edit_player_object[playerid]][craft_type]-1][craft_prochnost];
		craft_tool[edit_player_object[playerid]][craft_object] = CreateDynamicObject(craft_table[craft_tool[edit_player_object[playerid]][craft_type]-1][craft_model], 
		craft_tool[edit_player_object[playerid]][craft_XYZ][0], craft_tool[edit_player_object[playerid]][craft_XYZ][1], craft_tool[edit_player_object[playerid]][craft_XYZ][2],
		craft_tool[edit_player_object[playerid]][craft_rXrYrZ][0], craft_tool[edit_player_object[playerid]][craft_rXrYrZ][1], craft_tool[edit_player_object[playerid]][craft_rXrYrZ][2]);
		GetPlayerPos(playerid, craft_player_pos_xyz[playerid][0], craft_player_pos_xyz[playerid][1], craft_player_pos_xyz[playerid][2]);
		EditDynamicObject(playerid, craft_tool[edit_player_object[playerid]][craft_object]);
	}
	cache_delete(temp_sql_1);
	return true;
}
stock ShowCraftTools(playerid, number_tools)
{
	edit_player_object[playerid] = number_tools;
	static str_sql[156];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CRAFT_TOOLS" SET `craft_date_use` = 'NOW()' WHERE `craft_id` = '%i';", craft_tool[number_tools][craft_id]);
	m_query(str_sql);
	static str[300], str_two[64];
	str[0] = EOS;
	format(str_two, sizeof(str_two), "{fffff0}Вледелец\t%s\n", getname(craft_tool[number_tools][craft_owner]));
	strcat(str, str_two);
	format(str_two, sizeof(str_two), "Прочность\t%i/%i\n", craft_tool[number_tools][craft_health], craft_table[craft_tool[number_tools][craft_type]-1][craft_prochnost]);
	strcat(str, str_two);
	switch(craft_tool[number_tools][craft_type])
	{
	case 1, 2: 
		{
			switch(craft_tool[edit_player_object[playerid]][craft_open])
			{
			case 1: strcat(str, "{ADD8E6}Закрыть дверь\n");
			default: strcat(str, "{ADD8E6}Открыть дверь\n");
			}
		}
	case 3..6: strcat(str, "{ADD8E6}Использовать\n");
	}
	if(craft_tool[number_tools][craft_owner] == users[playerid][u_id])
	{
		strcat(str, "{ADD8E6}Починить\n");
		strcat(str, "{ADD8E6}Редактировать\n");
		if(craft_tool[number_tools][craft_type] == 1 || craft_tool[number_tools][craft_type] == 2)
		{
			if(!strcmp(craft_tool[number_tools][craft_password], "NoCraftPass321"))
			{
				if(GetItem(playerid, 108) && GetItem(playerid, 40)) strcat(str, "{ADD8E6}Установить кодовый замок.\n");
			}
			else strcat(str, "{ADD8E6}Изменить код от замка\n");
		}
	}
	if(GetItem(playerid, 107)) strcat(str, "{ADD8E6}Взорвать с помощью С4");
	show_dialog(playerid, d_craft_tools_use, DIALOG_STYLE_LIST, craft_table[craft_tool[number_tools][craft_type]-1][craft_name], str, !"Выбрать", !"Закрыть");
	return true;
}
stock getname(id)
{
	new str_sql[128], name[MAX_PLAYER_NAME];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_id` = '%i' LIMIT 1", id);
	new Cache:temp_sql_1 = m_query(str_sql), r;
	cache_get_row_count(r);
	if(r) cache_get_value_name(0, "u_name", name);
	cache_delete(temp_sql_1);
	return name;
}
stock ExplosiveCraft(playerid, time = 10)
{
	if(GetItem(playerid, 107) < 1) return server_error(playerid, "У вас нет с собой С4.");
	for(new c; c != 10; c++) SendClientMessage(playerid, -1, "");
	server_accept(playerid, "Вы установили С4, отойдите подальше от точки взрыва.");
	server_error(playerid, "У вас 10 секунд, чтобы отойти.");
	// GetPlayerPos(playerid, craft_player_pos_xyz[playerid][0], craft_player_pos_xyz[playerid][1], craft_player_pos_xyz[playerid][2]);
	// users[playerid][PlayerInv][107]--;
	RemoveItem(playerid, 107);
	users[playerid][u_slots]--;
	SetTimerEx("@ExplosiveCraft", 1000*time, false, "ii", playerid, edit_player_object[playerid]);
	return true;
}
stock UseCraftTools(playerid, number)
{
	switch(number)
	{
	case 1: 
		{
			if(use_craft_tools_pila[playerid])
			{
				for(new i = 0; i != 13; i++) 
				{
					TextDrawHideForPlayer(playerid, Text: craft_pila_TD[i]);
				}
				for(new i = 0; i != 3; i++) 
				{
					PlayerTextDrawHide(playerid, PlayerText: craft_pila_PTD[playerid][i]);
				}
			}
			else use_craft_tools_pila[playerid] = edit_player_object[playerid];
			static str[96];
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] == 1)
			{
				format(str, sizeof(str), "%i%%", craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular_percent]);
				PlayerTextDrawSetString(playerid, craft_pila_PTD[playerid][1], str);
			}
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] > 0)
			{
				format(str, sizeof(str), "%i", craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber]);
				PlayerTextDrawSetString(playerid, craft_pila_PTD[playerid][2], str);
			}
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timer])
			{
				format(str, sizeof(str), "Progress: %i%%", craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress]);
				PlayerTextDrawSetString(playerid, craft_pila_PTD[playerid][0], str);
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] >= 100) PlayerTextDrawSetString(playerid, craft_pila_PTD[playerid][0], "done");
			}
			else
			{
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] > 101) craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] = 101;
				switch(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress])
				{
				case 0: PlayerTextDrawSetString(playerid, craft_pila_PTD[playerid][0], "SAW UP");
				case 1..99:
					{
						format(str, sizeof(str), "Progress: %i%%", craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress]);
						PlayerTextDrawSetString(playerid, craft_pila_PTD[playerid][0], str);
					}
				default: PlayerTextDrawSetString(playerid, craft_pila_PTD[playerid][0], "done");
				}	
			}
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular_percent] < 1 && craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] != 0)
			{
				PlayerTextDrawSetString(playerid, craft_pila_PTD[playerid][0], "resume");
			}
   			for(new i = 0; i != 13; i++) 
			{
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] != 1 && i == 11) continue;
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] == 0 && i == 12) continue;
				TextDrawShowForPlayer(playerid, Text: craft_pila_TD[i]);
			}
			for(new i = 0; i != 3; i++) 
			{
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] != 1 && i == 1) continue;
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] < 1 && i == 2) continue;
				// if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] < 1 && i == 2) continue;
				PlayerTextDrawShow(playerid, PlayerText: craft_pila_PTD[playerid][i]);
			}
			/*if(craft_tool[idx][craft_pila_circular] != 1)
			{
				TextDrawHideForPlayer(playerid, Text: craft_pila_TD[11]);
				PlayerTextDrawHide(playerid, PlayerText: craft_pila_PTD[playerid][1]);
			}*/
		}
	case 2:
		{
			if(use_craft_tools_pila[playerid])
			{
				for(new i = 0; i != 12; i++) 
				{
					TextDrawHideForPlayer(playerid, Text: craft_stol_TD[i]);
				}
				for(new i = 0; i != 3; i++) 
				{
					PlayerTextDrawHide(playerid, PlayerText: craft_stol_PTD[playerid][i]);
				}
			}
			else use_craft_tools_pila[playerid] = edit_player_object[playerid];
			// static str[96];
			if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] != 0)
			{
				// format(str, sizeof(str), "Progress: %i%%", craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress]);
				// PlayerTextDrawSetString(playerid, craft_stol_PTD[playerid][0], str);
				PlayerTextDrawSetString(playerid, craft_stol_PTD[playerid][0], "wait..");
				if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] >= 100) PlayerTextDrawSetString(playerid, craft_stol_PTD[playerid][0], "done");
			}
			else
			{
				if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] >= 100) craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 100;
				switch(craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress])
				{
				case 0: PlayerTextDrawSetString(playerid, craft_stol_PTD[playerid][0], "craft");
				case 1..99:
					{
						// format(str, sizeof(str), "Progress: %i%%", craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress]);
						// PlayerTextDrawSetString(playerid, craft_stol_PTD[playerid][0], str);
						PlayerTextDrawSetString(playerid, craft_stol_PTD[playerid][0], "wait..");
					}
				default: PlayerTextDrawSetString(playerid, craft_stol_PTD[playerid][0], "done");
				}	
			}
			PlayerTextDrawSetPreviewModel(playerid, craft_stol_PTD[playerid][1], loots[craft_tool[use_craft_tools_pila[playerid]][craft_stol_one]][loot_object]);
			PlayerTextDrawSetPreviewModel(playerid, craft_stol_PTD[playerid][2], loots[craft_tool[use_craft_tools_pila[playerid]][craft_stol_two]][loot_object]);
			PlayerTextDrawBackgroundColor(playerid, craft_stol_PTD[playerid][1], 0x00000000);
			PlayerTextDrawBackgroundColor(playerid, craft_stol_PTD[playerid][2], 0x00000000);
   			for(new i = 0; i != 12; i++) 
			{
				TextDrawShowForPlayer(playerid, Text: craft_stol_TD[i]);
			}
			for(new i = 0; i != 3; i++) 
			{
				if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 0 && i == 1 || craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] >= 100 && i == 1) continue;
				if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 0 && i == 2 || craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] >= 100 && i == 2) continue;
				PlayerTextDrawShow(playerid, PlayerText: craft_stol_PTD[playerid][i]);
			}
		}
	case 3:
		{
			if(use_craft_tools_pila[playerid])
			{
				for(new i = 0; i != 14; i++) 
				{
					TextDrawHideForPlayer(playerid, Text: craft_pech_TD[i]);
				}
				for(new i = 0; i != 3; i++) 
				{
					PlayerTextDrawHide(playerid, PlayerText: craft_pech_PTD[playerid][i]);
				}
			}
			else use_craft_tools_pila[playerid] = edit_player_object[playerid];
			static str[96];
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] == 1)
			{
				format(str, sizeof(str), "%i%%", craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery_progress]);
				PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][0], str);
			}
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_unwrought] > 0)
			{
				format(str, sizeof(str), "%i", craft_tool[use_craft_tools_pila[playerid]][craft_pech_unwrought]);
				PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][2], str);
			}
			else PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][2], "_");
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_timer])
			{
				format(str, sizeof(str), "Progress: %i%%", craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress]);
				PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][1], str);
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] >= 100) PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][1], "done");
			}
			else
			{
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] >= 100) craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] = 101;
				switch(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress])
				{
				case 0: PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][1], "MEAL");
				case 1..99:
					{
						format(str, sizeof(str), "Progress: %i%%", craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress]);
						PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][1], str);
					}
				default: PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][1], "done");
				}	
			}
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery_progress] < 1 && craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] != 0)
			{
				PlayerTextDrawSetString(playerid, craft_pech_PTD[playerid][1], "resume");
			}
   			for(new i = 0; i != 14; i++) 
			{
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] != 1 && i == 5) continue;
				// if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] == 0 && i == 12) continue;
				TextDrawShowForPlayer(playerid, Text: craft_pech_TD[i]);
			}
			for(new i = 0; i != 3; i++) 
			{
				if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] != 1 && i == 0) continue;
				// if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] < 1 && i == 2) continue;
				// if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] < 1 && i == 2) continue;
				PlayerTextDrawShow(playerid, PlayerText: craft_pech_PTD[playerid][i]);
			}
		}
	}
	SaveCraftTools(use_craft_tools_pila[playerid]);
	SelectTextDraw(playerid, 0xA6A6A6AA);
	return true;
}
// stock DistancePointToPoint(Float: x, Float: y, Float: z, Float: fx, Float:fy, Float: fz) return floatround(floatsqroot(floatpower(fx - x, 2) + floatpower(fy - y, 2) + floatpower(fz - z, 2)));
stock server_errorToAll(message[], color = COLOR_ALL)
{
	foreach(Player, i)
	{
		if(PlayerIsOnline(i)) continue;
		SendClientMessage(i, color, message);
	}
}
stock convert_time(seconds)
{
    new 
		format_string[20],
		minutes = floatround(seconds/60);
	format(format_string, sizeof(format_string), "%02d:%02d:%02d", floatround(minutes/60), (minutes - (60 * floatround(minutes/60))), (seconds - (minutes * 60)));
    return format_string;
}
new format_update_users_panel[(63+1)+96];
stock update_users_panel(playerid)
{
	if(PlayerIsOnline(playerid)) return true;
	GetPlayerHealth(playerid, users[playerid][u_health]);
	GetPlayerArmour(playerid, users[playerid][u_armour]);
	gettime(global_hour, global_minute, global_second);
	if(admin[playerid][u_a_gm] || temp[playerid][time_infinity_health] || temp[playerid][infinity_health])
	{
		switch(GetItem(playerid, 54))
		{
		case 0: format(format_update_users_panel, sizeof(format_update_users_panel), "GoodMode~n~%.0f~n~%i~n~%i~n~%0.1f~n~--:--~n~%i~n~%s~n~", users[playerid][u_armour], users[playerid][u_score], users[playerid][u_humanity], users[playerid][u_temperature], users[playerid][u_money], convert_time(users[playerid][u_lifegame]));
		default: format(format_update_users_panel, sizeof(format_update_users_panel), "GoodMode~n~%.0f~n~%i~n~%i~n~%0.1f~n~%02d:%02d:%02d~n~%i~n~%s~n~", users[playerid][u_armour], users[playerid][u_score], users[playerid][u_humanity], users[playerid][u_temperature], global_hour, global_minute, global_second, users[playerid][u_money], convert_time(users[playerid][u_lifegame]));
		}
	}
	else
	{
		switch(GetItem(playerid, 54))
		{
		case 0: format(format_update_users_panel, sizeof(format_update_users_panel), "%i~n~%.0f~n~%i~n~%i~n~%0.1f~n~--:--~n~%i~n~%s~n~", floatround(users[playerid][u_health]*120), users[playerid][u_armour], users[playerid][u_score], users[playerid][u_humanity], users[playerid][u_temperature], users[playerid][u_money], convert_time(users[playerid][u_lifegame]));
		default: format(format_update_users_panel, sizeof(format_update_users_panel), "%i~n~%.0f~n~%i~n~%i~n~%0.1f~n~%02d:%02d:%02d~n~%i~n~%s~n~", floatround(users[playerid][u_health]*120), users[playerid][u_armour], users[playerid][u_score], users[playerid][u_humanity], users[playerid][u_temperature], global_hour, global_minute, global_second, users[playerid][u_money], convert_time(users[playerid][u_lifegame]));
		}
	}
	PlayerTextDrawSetString(playerid, users_panel_ptd[playerid][1], format_update_users_panel);
	switch(users[playerid][u_hunger])
	{
		case 0..30:
		{
			if(GetPVarInt(playerid, "PROTECT_HUNGER") != 1)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][4]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][4], HUD_HARD);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][4]);
				SetPVarInt(playerid, "PROTECT_HUNGER", 1);
			}
		}
		case 31..70:
		{
			if(GetPVarInt(playerid, "PROTECT_HUNGER") != 2)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][4]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][4], HUD_MEDIUM);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][4]);
				SetPVarInt(playerid, "PROTECT_HUNGER", 2);
			}
		}
		case 71..100:
		{
			if(GetPVarInt(playerid, "PROTECT_HUNGER") != 3)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][4]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][4], HUD_NORMAL);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][4]);
				SetPVarInt(playerid, "PROTECT_HUNGER", 3);
			}
		}
	}
	switch(users[playerid][u_thirst])
	{
		case 0..30:
		{
			if(GetPVarInt(playerid, "PROTECT_THIRST") != 1)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][3]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][3], HUD_HARD);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][3]);
				SetPVarInt(playerid, "PROTECT_THIRST", 1);
			}
		}
		case 31..70:
		{
			if(GetPVarInt(playerid, "PROTECT_THIRST") != 2)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][3]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][3], HUD_MEDIUM);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][3]);
				SetPVarInt(playerid, "PROTECT_THIRST", 2);
			}
		}
		case 71..100:
		{
			if(GetPVarInt(playerid, "PROTECT_THIRST") != 3)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][3]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][3], HUD_NORMAL);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][3]);
				SetPVarInt(playerid, "PROTECT_THIRST", 3);
			}
		}
	}
	switch(users[playerid][u_infected])
	{
		case 0..30:
		{
			if(GetPVarInt(playerid, "PROTECT_INFECTED") != 1)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][8]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][8], HUD_NORMAL);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][8]);
				SetPVarInt(playerid, "PROTECT_INFECTED", 1);
			}
		}
		case 31..70:
		{
			if(GetPVarInt(playerid, "PROTECT_INFECTED") != 2)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][8]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][8], HUD_MEDIUM);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][8]);
				SetPVarInt(playerid, "PROTECT_INFECTED", 2);
			}
		}
		case 71..100:
		{
			if(GetPVarInt(playerid, "PROTECT_INFECTED") != 3)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][8]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][8], HUD_HARD);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][8]);
				SetPVarInt(playerid, "PROTECT_INFECTED", 3);
			}
		}
	}
	switch(users[playerid][u_damage][1])
	{
	case 0:
		{
			// if(GetPVarInt(playerid, "PROTECT_DAMAGE_FRACTURE"))
			PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][5]);
			PlayerTextDrawColor(playerid, users_panel_ptd[playerid][5], HUD_NORMAL);
			PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][5]);
		}
	default:
		{
			PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][5]);
			PlayerTextDrawColor(playerid, users_panel_ptd[playerid][5], HUD_HARD);
			PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][5]);
		}
	}
	switch(users[playerid][u_damage][0])
	{
	case 0:
	{
		PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][2]);
		PlayerTextDrawColor(playerid, users_panel_ptd[playerid][2], HUD_NORMAL);
		PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][2]);
	}
	case 1:
		{
			if(users[playerid][u_health] > 30 && users[playerid][u_health] < 80)
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][2]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][2], HUD_MEDIUM);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][2]);
			}
			else
			{
				PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][2]);
				PlayerTextDrawColor(playerid, users_panel_ptd[playerid][2], HUD_HARD);
				PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][2]);
			}
		}
	}
	if(GetPVarInt(playerid, "RECEIVED_DAMAGE_TIME"))
	{
		PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][6]);
		PlayerTextDrawColor(playerid, users_panel_ptd[playerid][6], HUD_HARD);
		PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][6]);
	}
	else 
	{
		PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][6]);
		PlayerTextDrawColor(playerid, users_panel_ptd[playerid][6], HUD_NORMAL);
		PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][6]);
	}
	if(GetPlayerWeapon(playerid) != 0)
	{
		SetPVarInt(playerid, "GUN_ID", GetPlayerWeapon(playerid));
		if(!GetPVarInt(playerid, "SHOW_GUN_INFO"))
		{
			SetPVarInt(playerid, "SHOW_GUN_INFO", 1);
			for(new td = 24; td < 30; td++) TextDrawShowForPlayer(playerid, users_panel_td[td]);
			PlayerTextDrawShow(playerid, PlayerText: users_panel_ptd[playerid][7]);
		}
		format(format_update_users_panel, sizeof(format_update_users_panel), "Gun:_%s~n~Ammo:_%i", WeaponNames[GetPlayerWeapon(playerid)], GetPlayerAmmo(playerid));
		PlayerTextDrawSetString(playerid, users_panel_ptd[playerid][7], format_update_users_panel);
	}
	else 
	{
		DeletePVar(playerid, "GUN_ID");
		DeletePVar(playerid, "SHOW_GUN_INFO");
		for(new td = 24; td < 30; td++) TextDrawHideForPlayer(playerid, users_panel_td[td]);
		PlayerTextDrawHide(playerid, PlayerText: users_panel_ptd[playerid][7]);
	}
	format(format_update_users_panel, sizeof(format_update_users_panel), "Reloot:_%02i:%02i", ReLootTime/60, ReLootTime-((ReLootTime/60)*60));
	TextDrawSetString(users_panel_td[30], format_update_users_panel); 
	if(observation[playerid][observation_id] != INVALID_PLAYER_ID)
	{
		format(format_update_users_panel, sizeof(format_update_users_panel), "%s_(%i)", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
		PlayerTextDrawSetString(playerid, PanelReconAdmin_PTD[playerid][1], format_update_users_panel);
		static Float: GetSatus[MAX_PLAYERS][4];
 		GetPlayerHealth(observation[playerid][observation_id], GetSatus[playerid][0]);
 		GetPlayerArmour(observation[playerid][observation_id], GetSatus[playerid][1]);
		GetVehicleHealth(GetPlayerVehicleID(observation[playerid][observation_id]), GetSatus[playerid][2]);
		format(format_update_users_panel, sizeof(format_update_users_panel), "%0.1f~n~%0.1f~n~%i~n~%0.1f~n~%i(%i)~n~", GetSatus[playerid][0], GetSatus[playerid][1], GetSpeed(observation[playerid][observation_id]), GetSatus[playerid][2], GetPlayerWeapon(observation[playerid][observation_id]), GetPlayerAmmo(observation[playerid][observation_id]));
		PlayerTextDrawSetString(playerid, PanelReconAdmin_PTD[playerid][0], format_update_users_panel);
	}
	return true;
}
stock animations(playerid, index)
{
	ClearAnimLoop(playerid);
	switch(index)
	{
	case 1: LoopingAnim(playerid, !"PED", !"KO_SHOT_STOM", 4.0, 0, 0, 0, 1, 0);
	case 2: LoopingAnim(playerid, !"ped", !"endchat_03", 4.0, 0, 0, 0, 0, 0); // ApplyAnimation(playerid, !"ON_LOOKERS", !"wave_loop", 4.1, 0, 0, 0, 0, 1, 0);
	case 3: LoopingAnim(playerid, !"PED", !"DUCK_COWER", 4.0, 0, 0, 0, 1, 0);
	case 4: LoopingAnim(playerid, !"BEACH", !"ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // ApplyAnimation(playerid, "PED", "DUCK_COWER", 5.0, 0, 0, 0, 1, 0); //
	case 5: LoopingAnim(playerid, !"MISC", !"plyr_shkhead", 4.0, 0, 0, 0, 0, 0);
	case 6: LoopingAnim(playerid, !"CAMERA", !"camstnd_cmon", 4.0, 0, 0, 0, 0, 0); // ApplyAnimation(playerid, "SWAT", "swt_go", 5.0, 0, 0, 0, 1, 0); 
	case 7: LoopingAnim(playerid, !"SHOP", !"SHP_Rob_HandsUP", 4.0, 1, 0, 0, 0, 0); //SetPlayerSpecialAction(playerid, 10);
	}
	return true;
}
stock progress_bar(playerid, animlib[] = " ", animname[] = " ", time = 4, bool: freeze = false)
{
	if(!GetPVarInt(playerid, "PROGRESSBAR_TIME_S"))
	{
		for(new td = 0; td < 2; td++) TextDrawShowForPlayer(playerid, Text: progressbar_TD[td]);
		if(!freeze) TogglePlayerControllable(playerid, false);
		SetPVarInt(playerid, "PROGRESSBAR_TIME_S", time);
		SetPVarInt(playerid, "PROGRESSBAR_TIME_E", 0);
		// if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT || !IsPlayerInWater(playerid)) ApplyAnimation(playerid, animlib, animname, 4.1, 1, 1, 1, 1, 1);
		LoopingAnim(playerid, animlib, animname, 4.1, 1, 1, 1, 1, 1);
	}
	if(GetPVarInt(playerid, "PROGRESSBAR_TIME_S"))
	{
		new Float: progressbar_f = GetPVarInt(playerid, "PROGRESSBAR_TIME_E") * floatround(86.000 / GetPVarInt(playerid, "PROGRESSBAR_TIME_S"));
		PlayerTextDrawTextSize(playerid, PlayerText: progressbar_PTD[playerid][0], progressbar_f, 15.0598); 
		PlayerTextDrawShow(playerid, PlayerText: progressbar_PTD[playerid][0]);
		if(GetPVarInt(playerid, "PROGRESSBAR_TIME_S") == GetPVarInt(playerid, "PROGRESSBAR_TIME_E"))
		{
			for(new td = 0; td < 2; td++) TextDrawHideForPlayer(playerid, Text: progressbar_TD[td]);
			PlayerTextDrawHide(playerid, PlayerText: progressbar_PTD[playerid][0]);
			TogglePlayerControllable(playerid, true);
			ClearAnimLoop(playerid);
			DeletePVar(playerid, "PROGRESSBAR_TIME_S");
			DeletePVar(playerid, "PROGRESSBAR_TIME_E");
		}
	}
	return true;
}
/*CMD:testin(playerid, params[])
{
	if(sscanf(params, "i", params[0])) return server_error(playerid, "/testin [номер]");
	progress_bar(playerid, params[0]);
	return true;
}*/
stock CreateFire(playerid)
{
	new Float: coords[3];
	GetPlayerPos(playerid, coords[0], coords[1], coords[2]);
	for(new fz = 1; fz < MAX_FIRE; fz++)
	{
		if(fire[fz][fire_time]) continue;
		fire[fz][fire_time] = 20;
		fire[fz][fire_xyz][0] = coords[0];
		fire[fz][fire_xyz][1] = coords[1] + 0.5;
		fire[fz][fire_xyz][2] = coords[2];
		fire[fz][fire_object][0] = CreateDynamicObject(1463, fire[fz][fire_xyz][0], fire[fz][fire_xyz][1], fire[fz][fire_xyz][2] - 1, 0, 0, 0);
		fire[fz][fire_object][1] = CreateDynamicObject(18690, fire[fz][fire_xyz][0], fire[fz][fire_xyz][1], fire[fz][fire_xyz][2] - 2.5, 0, 0, 0);
		SetPVarInt(playerid, "FIRE_OWNER", playerid);
		break;
	}
	return true;
}
stock reward_users(playerid)
{
	new mysql_format_string[(51+1)+MAX_PLAYER_NAME];
	m_format(mysql_format_string, sizeof(mysql_format_string), "SELECT * FROM "TABLE_USERS" WHERE `u_friend` = '%s'", users[playerid][u_name]);
	new Cache: temp_mysql = m_query(mysql_format_string), r;
	cache_get_row_count(r);
	if(r)
	{
		new 
			friend_time, z = 0, nz = 0, format_string[(24*100)];
		for(new idx = 1; idx <= r; idx++)
		{
			cache_get_value_name_int(idx-1, "u_lifetime", friend_time);
			if(friend_time >= 86400) z++;
			else nz++;
			format(format_string, sizeof(format_string), "\
			{cccccc}Приглашено: %i / Завершенных: %i / Не завершенных: %i{fffff0}\n\
			- Пригласить 2 друга\t\t%s | %s\n\
			- Пригласить 5 друзей\t\t%s | %s\n\
			- Пригласить 7 друзей\t\t%s | %s\n\
			- Пригласить 10 друзей\t%s | %s\n\
			- Пригласить 15 друзей\t%s | %s\n\
			- Пригласить 20 друзей\t%s | %s", r, z, nz, 
			(z < 2)?("{CD5C5C}Не выполнено{fffff0}"):("{90EE90}Выполнено{fffff0}"), 
			(users[playerid][u_reward][0] && z >= 2)?("{7FFFD4}Награда получена{fffff0}"):("{AFEEEE}Нажмите для получения награды{fffff0}"), 
			(z < 5)?("{CD5C5C}Не выполнено{fffff0}"):("{90EE90}Выполнено{fffff0}"), 
			(users[playerid][u_reward][1] && z >= 5)?("{7FFFD4}Награда получена{fffff0}"):("{AFEEEE}Нажмите для получения награды{fffff0}"), 
			(z < 7)?("{CD5C5C}Не выполнено{fffff0}"):("{90EE90}Выполнено{fffff0}"), 
			(users[playerid][u_reward][2] && z >= 7)?("{7FFFD4}Награда получена{fffff0}"):("{AFEEEE}Нажмите для получения награды{fffff0}"), 
			(z < 10)?("{CD5C5C}Не выполнено{fffff0}"):("{90EE90}Выполнено{fffff0}"), 
			(users[playerid][u_reward][3] && z >= 10)?("{7FFFD4}Награда получена{fffff0}"):("{AFEEEE}Нажмите для получения награды{fffff0}"), 
			(z < 15)?("{CD5C5C}Не выполнено{fffff0}"):("{90EE90}Выполнено{fffff0}"), 
			(users[playerid][u_reward][4] && z >= 15)?("{7FFFD4}Награда получена{fffff0}"):("{AFEEEE}Нажмите для получения награды{fffff0}"), 
			(z < 20)?("{CD5C5C}Не выполнено{fffff0}"):("{90EE90}Выполнено{fffff0}"), 
			(users[playerid][u_reward][5] && z >= 20)?("{7FFFD4}Награда получена{fffff0}"):("{AFEEEE}Нажмите для получения награды{fffff0}"));
		}
		show_dialog(playerid, d_reward, DIALOG_STYLE_LIST, "Награда за приглашение", format_string, !"Выбрать", !"Назад");
	}
	else
	{
		callcmd::friends(playerid);
		server_error(playerid, "Вы ещё не приглашали друзей.");
	}
	cache_delete(temp_mysql);
	return true;	
}