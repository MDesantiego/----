public OnPlayerSpawn(playerid)
{
	if(!temp[playerid][temp_login]) return TKICK(playerid, "Вы не авторизованы.");
	
	if ( IsValidDynamic3DTextLabel ( users_death [ playerid ] ) )
	{
		DestroyDynamic3DTextLabel ( users_death [ playerid ] );
		users_death [ playerid ] = Text3D:INVALID_3DTEXT_ID;
	}

	SetPlayerHealth(playerid, 100.0);
	switch(users[playerid][u_settings][2])
	{
	case 0: 
		{
			new random_spawn = random(sizeof(random_position));
			spawn_player(playerid, random_position[random_spawn][0], random_position[random_spawn][1], random_position[random_spawn][2], random(360));
		}
	case 1:
		{
			if(users[playerid][u_clan])
			{
				if(!clan[users[playerid][u_clan]][c_spawn_xyzf][0] && !clan[users[playerid][u_clan]][c_spawn_xyzf][1])
				{
					new random_spawn = random(sizeof(random_position));
					spawn_player(playerid, random_position[random_spawn][0], random_position[random_spawn][1], random_position[random_spawn][2], random(360));
				}
				else spawn_player(playerid, clan[users[playerid][u_clan]][c_spawn_xyzf][0], clan[users[playerid][u_clan]][c_spawn_xyzf][1], clan[users[playerid][u_clan]][c_spawn_xyzf][2], clan[users[playerid][u_clan]][c_spawn_xyzf][3]);
			}
			else
			{
				new random_spawn = random(sizeof(random_position));
				spawn_player(playerid, random_position[random_spawn][0], random_position[random_spawn][1], random_position[random_spawn][2], random(360));
			}
		}
	case 2: spawn_player(playerid, users[playerid][u_donate_spawn_xyzf][0], users[playerid][u_donate_spawn_xyzf][1], users[playerid][u_donate_spawn_xyzf][2], users[playerid][u_donate_spawn_xyzf][3]);
	// case 3: 
	}
	return true;
}
stock spawn_player(playerid, Float: pos_x, Float: pos_y, Float: pos_z, Float: pos_f)
{
	SetPlayerHealth(playerid, 100.0);
	TogglePlayerControllable(playerid, false);
	if(users[playerid][u_health] < 1.0) users[playerid][u_health] = 1.0; 
	if(users[playerid][u_newgame])
	{
		users[playerid][u_spawn_xyz][0] = pos_x;
		users[playerid][u_spawn_xyz][1] = pos_y;
		users[playerid][u_spawn_xyz][2] = pos_z;
		users[playerid][u_spawn_xyz][3] = pos_f;
		users[playerid][u_spawn_wi][0] = 0;
		users[playerid][u_spawn_wi][1] = 0;
		inventory_clear(playerid); // Чистим инвентарь;
		users[playerid][u_skin] = 20030;
		switch(users[playerid][u_vip_time])
		{
		case 0:
			{
				users[playerid][u_backpack] = 1;
				if(users[playerid][u_clan] != 0) AddItem(playerid, 53, 1);
				AddItem(playerid, 31, 1);
				AddItem(playerid, 1, 1);
				AddItem(playerid, 44, 1);
			}
		default:
			{//33 морф, 31 - бинт, 52 - gps, 53 - рация, 59 - 9mm, 63 - патроны 9mm, 7 - бургер, 44 - бутылка с водой
				users[playerid][u_backpack] = 2;
				AddItem(playerid, 31, 1);
				AddItem(playerid, 33, 1);
				AddItem(playerid, 52, 1);
				AddItem(playerid, 53, 1);
				AddItem(playerid, 59, 1);
				AddItem(playerid, 63, 0);
				AddItem(playerid, 7, 2);
				AddItem(playerid, 44, 2);
			}
		}
		users[playerid][u_hunger] = 100;
		users[playerid][u_thirst] = 100;
		users[playerid][u_temperature] = 36.6;
		users[playerid][u_karma] = 0;
		users[playerid][u_slots] = 0;
		users[playerid][u_damage][0] = 0;
		users[playerid][u_damage][1] = 0;
		users[playerid][u_score] = 0;
		users[playerid][u_lifegame] = 0;
		users[playerid][u_humanity] = 2000;
		users[playerid][u_infected] = 0;
		users[playerid][u_newgame] = 0;
		users[playerid][u_health] = 100.0;
		users[playerid][u_armour] = 0.0;
		temp[playerid][time_infinity_health] = 21;
		temp[playerid][TimeUsePack] = 120;
	}
	if(observation[playerid][observation_id] != INVALID_PLAYER_ID)
	{
		// server_message(playerid, "тест 1");
		SPP(playerid, observation[playerid][observation_XYZF][0], observation[playerid][observation_XYZF][1], observation[playerid][observation_XYZF][2], observation[playerid][observation_XYZF][3], observation[playerid][observation_WI][0], observation[playerid][observation_WI][1]);
		observation[playerid][observation_id] = INVALID_PLAYER_ID;
	}
	else SPP(playerid, users[playerid][u_spawn_xyz][0], users[playerid][u_spawn_xyz][1], users[playerid][u_spawn_xyz][2] + 0.2, users[playerid][u_spawn_xyz][3], users[playerid][u_spawn_wi][0], users[playerid][u_spawn_wi][1]);
	if(users[playerid][u_clan] && clan[users[playerid][u_clan]][c_skin] != 0) SetPlayerSkin(playerid, clan[users[playerid][u_clan]][c_skin]);
	else if(users[playerid][u_donate_skin]) SetPlayerSkin(playerid, users[playerid][u_donate_skin]);
	else SetPlayerSkin(playerid, users[playerid][u_skin]);
	SetCameraBehindPlayer(playerid);
	SetPlayerHealth(playerid, users[playerid][u_health]);
	SetPlayerArmour(playerid, users[playerid][u_armour]);
	RemovePlayerAttachedObject(playerid, users[playerid][u_backpack_object]);
	switch(users[playerid][u_backpack])
	{
	case 1: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,3026,1,-0.058000,-0.110999,0.000000,0.000000,0.000000,0.000000,0.759000,0.928999,0.770000);//оч маленький
	case 2: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,3026,1,-0.158000,-0.097999,-0.010000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);//маленький
	case 3: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,371,1,0.056000,-0.116000,-0.004999,2.300001,87.000030,-0.300001,1.000000,0.733999,1.058000);//ср
	case 4: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,1310,1,-0.098999,-0.170999,0.000000,-3.200003,87.799934,2.499999,1.000000,0.741999,1.000000);//большой
	case 5: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,19559,1,0.056000,-0.096000,-0.004999,-3.200003,87.799934,2.499999,1.000000,1.046000,1.184999);//оч большой
	}
	//if(!temp[playerid][time_infinity_health]) dSetPlayerHealth(playerid, users[playerid][pBlood]);
	if(users[playerid][u_helmet])
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
		SetPlayerAttachedObject(playerid, 9, 19141, 2,  0.116999, 0.006000, 0.000000,  0.000000, 0.000000, 0.000000,  1.115001, 1.145001, 1.104000);
	}
	if(users[playerid][u_armour])
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
		SetPlayerAttachedObject(playerid, 8, 19142, 1,  0.067999, 0.062999, 0.000000,  0.000000, 0.000000, 0.000000,  1.025000, 1.543997, 1.139000);
	}
	LoadingForUser(playerid);
	// clan_syntax(playerid);
	temp[playerid][temp_spawn] = true;
	// temp[playerid][use_dialog] = -1;
	// temp[playerid][protect_info_hunger] = 0;
	// temp[playerid][protect_info_thirst] = 0;
	SetPlayerWeather(playerid, weather_index);
	if(GetPVarInt(playerid, "REGISTRATION_NEWMEMBER"))
	{
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "Информация", !"\
		{fffff0}Добро пожаловать на {cccccc}"FULL_NAME"{fffff0}, номер сервера: {cccccc}"NUMB_SERV"{fffff0}.\n\
		IP сервера: {cccccc}"IP_ADRESS"{fffff0}.\n\
		Для ознакомления наберите команду {cccccc}/help{fffff0}, чтобы посмотреть все команды наберите {cccccc}/cmd{fffff0}.\n\
		Чтобы получить ответы на вопросы по игре наберите {cccccc}/info{fffff0}.\n\
		Приятной игры на {cccccc}"FULL_NAME"{fffff0}!\n\n\
		Наш сайт: {cccccc}"SITE_NAME"{fffff0}.\n\
		Наш форум: {cccccc}"FORU_NAME"{fffff0}.\n\
		Наша группа ВК, а так же тех. поддержка: {cccccc}"VKON_NAME"{fffff0}.\
		", !"Закрыть", !"");
		DeletePVar(playerid, "REGISTRATION_NEWMEMBER");
	}
	if(temp[playerid][time_infinity_health]) GameTextForPlayer(playerid, "~w~Invulnerability 20 seconds", 5000, 3);
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MESSAGE" WHERE `m_owner` = '%i' ORDER BY `m_id` ASC", users[playerid][u_id]);
	new Cache:temp_sql = m_query(str_sql), rows;
    cache_get_row_count(rows);
	if(rows) 
	{
		global_string [ 0 ] = EOS ;
		new str[128], name[24][128], leveusers[24];
		for(new idx = 0; idx != rows; idx++)
		{
			cache_get_value_name(idx, "m_message", name[idx], 128);
			cache_get_value_name_int(idx, "m_id", leveusers[idx]);
			format(str, sizeof(str), "{cccccc}#%i: {ffffff}%s\n", idx+1, name[idx]);
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Оповещения", global_string, !"Ок", !"" ) ;
		for(new z = 0; z < rows; z++)
		{
			m_format(str_sql, sizeof(str_sql), "DELETE FROM "TABLE_MESSAGE" WHERE `m_owner` = '%i' AND `m_id` = '%i'", users[playerid][u_id], leveusers[z]);
			m_query(str_sql);
		}
	}
	cache_delete(temp_sql);
	if(users[playerid][u_clan] > 0)
	{
		m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_id` = '%i' LIMIT 1", users[playerid][u_clan]);
		new Cache:temp_sql_1 = m_query(str_sql), r;
		cache_get_row_count(r);
		if(!r) 
		{
			users[playerid][u_clan] = 0;
			users[playerid][u_clan_rank] = 0;
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan` = '0', `u_clan_rank` = '0' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_id]);
			m_query(str_sql);
			server_error(playerid, "Ваш клан был удален. Причина: 3 из 3 выговоров.");
		}
		cache_delete(temp_sql_1);
	}
	TogglePlayerControllable(playerid, true);
	SetPlayerScore(playerid, users[playerid][u_score]);
	if(users[playerid][u_damage][0] != 0) SetTimerEx("Damage", 5000, false, "i", playerid);
	foreach(Player, i) clan_syntax(i);
	return true;
}