/*
    Описание: Таймары;
    Автор: zummore;
*/
#if defined _timers_included
	#endinput
#endif
#define _timers_included

new 
	timer_seconds, 
	timer_minutes;

@timer_seconds();
@timer_seconds()
{
	for(new c = 0; c < MAX_CRAFT; c++)
	{
		if(craft_tool[c][craft_pila_timer])
		{
			if(craft_tool[c][craft_pila_circular_percent] < 1)
			{
				craft_tool[c][craft_pila_timer] = 0;
				craft_tool[c][craft_pila_circular_percent] = 0;
				return true;
			}
			craft_tool[c][craft_pila_timer]--;
			if(craft_tool[c][craft_pila_timer] < 1)
			{
				if(craft_tool[c][craft_pila_timber] == 0)
				{
					craft_tool[c][craft_pila_timer] = 0;
					craft_tool[c][craft_pila_progress] = 101;
					foreach(Player, i)
					{
						if(use_craft_tools_pila[i])
						{
							switch(craft_tool[use_craft_tools_pila[i]][craft_type])
							{
							case 3: UseCraftTools(i, 1);
							}
						}
					}
					return true;
				}
				craft_tool[c][craft_pila_timber]--;
				craft_tool[c][craft_pila_woords]++;
				craft_tool[c][craft_pila_circular_percent] -= 2;
				craft_tool[c][craft_pila_progress] += progress_procent(craft_tool[c][craft_pila_timber], craft_tool[c][craft_pila_woords]);
				craft_tool[c][craft_pila_timer] = 15;
				foreach(Player, i)
				{
					if(use_craft_tools_pila[i])
					{
						switch(craft_tool[use_craft_tools_pila[i]][craft_type])
						{
						case 3: UseCraftTools(i, 1);
						}
					}
				}
			}
		}
		if(craft_tool[c][craft_stol_timer])
		{
			craft_tool[c][craft_stol_timer]--;
			if(craft_tool[c][craft_stol_timer] < 1)
			{
				if(craft_tool[c][craft_stol_timer] == 0)
				{
					craft_tool[c][craft_stol_timer] = 0;
					craft_tool[c][craft_stol_progress] = 101;
					foreach(Player, i)
					{
						if(use_craft_tools_pila[i])
						{
							switch(craft_tool[use_craft_tools_pila[i]][craft_type])
							{
							case 4: UseCraftTools(i, 2);
							}
						}
					}
					return true;
				}
				craft_tool[c][craft_stol_timer]--;
				// craft_tool[c][craft_stol_progress] += progress_procent(craft_tool[c][craft_stol_one], craft_tool[c][craft_stol_two]);
				foreach(Player, i)
				{
					if(use_craft_tools_pila[i])
					{
						switch(craft_tool[use_craft_tools_pila[i]][craft_type])
						{
						case 4: UseCraftTools(i, 2);
						}
					}
				}
			}
		}
		if(craft_tool[c][craft_pech_timer])
		{
			if(craft_tool[c][craft_pech_battery_progress] < 1)
			{
				craft_tool[c][craft_pech_timer] = 0;
				craft_tool[c][craft_pech_battery_progress] = 0;
				return true;
			}
			craft_tool[c][craft_pech_timer]--;
			if(craft_tool[c][craft_pech_timer] < 1)
			{
				if(craft_tool[c][craft_pech_unwrought] == 0)
				{
					craft_tool[c][craft_pech_timer] = 0;
					craft_tool[c][craft_pech_progress] = 101;
					foreach(Player, i)
					{
						if(use_craft_tools_pila[i])
						{
							switch(craft_tool[use_craft_tools_pila[i]][craft_type])
							{
							case 5: UseCraftTools(i, 3);
							}
						}
					}
					return true;
				}
				craft_tool[c][craft_pech_unwrought]--;
				craft_tool[c][craft_pech_metal]++;
				craft_tool[c][craft_pech_battery_progress] -= random(3);
				craft_tool[c][craft_pech_progress] += progress_procent(craft_tool[c][craft_pech_unwrought], craft_tool[c][craft_pech_metal]);
				craft_tool[c][craft_pech_timer] = 15;
				foreach(Player, i)
				{
					if(use_craft_tools_pila[i])
					{
						switch(craft_tool[use_craft_tools_pila[i]][craft_type])
						{
						case 5: UseCraftTools(i, 3);
						}
					}
				}
			}
		}
	}
	return true;
}
@timer_minutes();
@timer_minutes()
{
	foreach(Player, i)
	{
		if(PlayerIsOnline(i)) continue;
		if(users[i][u_hunger]) users[i][u_hunger]--;
		if(users[i][u_thirst]) users[i][u_thirst]--;

		if ( temp [ i ] [ perk_KD ] [ 0 ] ) temp [ i ] [ perk_KD ] [ 0 ] --;
		if ( temp [ i ] [ perk_KD ] [ 1 ] ) temp [ i ] [ perk_KD ] [ 1 ] --;
		if ( users [ i ] [ u_adrenaline_otx ] ) if ( ( users [ i ] [ u_adrenaline_otx ] -- ) == 0 ) ClearAnimLoop ( i );
		if ( users [ i ] [ u_adrenaline_use ] )
		{
			if ( ( users [ i ] [ u_adrenaline_use ] -- ) == 1 ) SSM ( i, "Адреналин на вас будет действовать ещё 60 секунд." );
			if ( users [ i ] [ u_adrenaline_use ] == 0 )
			{
				SSM ( i, "Ваш персонаж начал отходить от адреналина (%i минут)", OTXODOS_MEDIK_ADR );
				users [ i ] [ u_adrenaline_otx ] = OTXODOS_MEDIK_ADR;
			}
		}

		if(GetPVarInt(i, "ANTIVIRUS_USE")) SetPVarInt(i, "ANTIVIRUS_USE", GetPVarInt(i, "ANTIVIRUS_USE") - 1);
		if(users[i][u_infected] && !GetPVarInt(i, "ANTIVIRUS_USE"))
		{
			SetPVarInt(i, "TIME_INFECTED", GetPVarInt(i, "TIME_INFECTED") + 1);
			switch(GetPVarInt(i, "TIME_INFECTED"))
			{
			case 5:
				{
					if(users[i][u_infected] > 40)
					{
						switch(random(10))
						{// 124567
						case 1:
							{
								server_error(i, "Вы заражены, у вас начался приступ.");
								OnePlayAnim(i, "GRAVEYARD", "mrnF_loop", 4.0, 0, 0, 0, 0, 0); // ОРВИ;
								SetPlayerDrunkLevel(i, 5*1000);
							}
						case 2:
							{
								server_error(i, "Вы заражены, у вас начался приступ.");
								OnePlayAnim(i, "FOOD", "EAT_Vomit_P", 4.0, 0, 0, 0, 0, 0); // Гастрит;
							}
						case 3:
							{
								server_error(i, "Вы заражены, у вас начался приступ.");
								OnePlayAnim(i, "PED", "HIT_back", 0.1, 1, 0, 0, 0, 10000); // Психическое расстройство;
							}
						case 4:
							{
								server_error(i, "Вы заражены, у вас начался приступ.");
								OnePlayAnim(i, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 15000); // Эпилепсия;
							}
						case 5:
							{
								server_error(i, "Вы заражены, у вас начался приступ."); 
								OnePlayAnim(i, "PAULNMAC", "PnM_Argue2_A", 4.0, 0, 0, 0, 0, 0); // Астма;
								SetPlayerDrunkLevel(i, 7*1000);
							}
						default: OnePlayAnim(i, "SCRATCHING", "scdrdlp", 4.0, 0, 0, 0, 0, 0); // Артрит;
						}
						if(users[i][u_infected] > 90 && !users[i][u_damage][0])
						{
							users[i][u_damage][0] = 1;
							server_error(i, "У вас открылось кровотечение из-за заражения, перевяжите раны «бинтами»");
						}
						if(!users[i][u_damage][0])
						{
							if(random(2) == 0)
							{
								users[i][u_damage][0] = 1;
								server_error(i, "У вас открылось кровотечение из-за заражения, перевяжите раны «бинтами»");
							}
						}
						RemovePlayerHealth(i, (1 + random(9)));
						if(users[i][u_infected] < 100) users[i][u_infected]++;
					}
				}
			case 10:
				{
					if(users[i][u_infected] < 100) users[i][u_infected] += 1 + random(10);
					if(users[i][u_infected] > 100) users[i][u_infected] = 100;
					SetPVarInt(i, "TIME_INFECTED", 0);
				}
			}
		}
	}
	for(new i = 1; i < MAX_VEHICLES; i++)
	{
		if(IsABycicle(i)) continue;
		if(!CarInfo[i][car_fuel]) continue;
		if(car_engine{i}) 
		{
			CarInfo[i][car_fuel] -= 1.0;
			if(CarInfo[i][car_fuel] < 0) CarInfo[i][car_fuel] = 0;
			if(!CarInfo[i][car_fuel]) ManualCar(i, "off");//SetVehicleParamsEx(i, false, lights, alarm, doors, bonnet, boot, objective);
		}
	}
	ReLootTime--;
	if(!ReLootTime)
	{
		for(new a = 0; a != MAX_LOOT; a++) 
		{
			if(LootInfo[a][LPos][0] != 0.0) 
			{
				DestroyDynamicObject(LootInfo[a][LIndexObj]);
				LootInfo[a][LPos][0] = 0.0;
				LootInfo[a][LPos][1] = 0.0;
				LootInfo[a][LPos][2] = 0.0;
				LootInfo[a][LIndexObj] = -1;
				LootInfo[a][LData] = 0; 
			} 
		}
		for(new in = 0; in != sizeof(MediksBoxData); in++) 
		{
			for(new ba = 0; ba != max_items; ba++) 
			{
				if(ba >= 31 && ba <= 37) 
				{ 
					MediksBox[in][ba] = 1+random(9); 
				}
				else MediksBox[in][ba] = 0; 
			} 
		}
		IndexLoot = 0;
		ReLootTime = TimeForReLoot;
		LoadAllLoot();
		weather_index = weather[random(sizeof(weather))];
		SetWeather(weather_index);
		server_errorToAll("[Информация] Внимание! Произошел респаун лута! Администрация желает вам приятной игры.", 0xE0E0E0FF);
		printf("["FULL_NAME"] Динамические точки спавна лута [%d] успешно перезагружены.", IndexLoot);
	}
	if(ServerRestarted != -1)
	{
		if(ServerRestarted) ServerRestarted--;
		else if(!ServerRestarted) SendRconCommand("gmx"); 
	}
	for(new fx = 0; fx < MAX_FIRE; fx++)
	{
		if(!fire[fx][fire_time]) continue;
		fire[fx][fire_time]--;
		if(!fire[fx][fire_time])
		{
			fire[fx][fire_time] = 0;
			fire[fx][fire_xyz][0] = 0.0;
			fire[fx][fire_xyz][1] = 0.0;
			fire[fx][fire_xyz][0] = 0.0;
			DestroyDynamicObject(fire[fx][fire_object][0]);
			DestroyDynamicObject(fire[fx][fire_object][1]);
			foreach(Player, i)
			{
				if(!GetPVarInt(i, "FIRE_OWNER")) continue;
				server_error(GetPVarInt(i, "FIRE_OWNER"), "Ваш костер погас!");
				DeletePVar(i, "FIRE_OWNER");
			}
			
		}
	}
	/*for(new air = 0; air < MAX_AIRDROPS; air++)
	{
		if(!airdrop[air][airdrop_time]) continue;
		airdrop[air][airdrop_time]--;
		if(!airdrop[air][airdrop_time])
		{
			airdrop[air][airdrop_time] = 0;
			airdrop[air][airdrop_slots] = 0;
			airdrop[air][airdrop_xyz][0] = 0.0;
			airdrop[air][airdrop_xyz][1] = 0.0;
			airdrop[air][airdrop_xyz][2] = 0.0;
			airdrop[air][airdrop_dropped] = false;
			DestroyDynamicObject(airdrop[air][airdrop_object][0]);
			DestroyDynamicObject(airdrop[air][airdrop_object][1]);
			DestroyDynamicObject(airdrop[air][airdrop_object][2]);
		}
	}*/
	gettime(global_hour, global_minute);
	if(global_hour == 5 && global_minute == 53) server_errorToAll("[Информация] {A52A2A}Внимание! {ffffff}Уважаемые игроки, через 5 минут произойдет {E0E0E0}Автоматический рестарт{ffffff} сервера.", 0xE0E0E0FF);
	if(global_hour == 5 && global_minute == 59)
	{
		server_errorToAll("[Информация] {A52A2A}Внимание! {ffffff}Происходит {E0E0E0}автоматический рестарт {ffffff}сервера.", 0xE0E0E0FF);
		foreach(Player, i)
		{ 
			if(!IsPlayerConnected(i)) continue;
			TKICK(i, "Сервер перезапускается...");
		}
		ServerRestarted = 2;
		SendRconCommand("hostname "FULL_NAME" | Автоматический рестарт сервера...");
		print("\n\nАвтоРестарт сервера завершен.\n\n");
	}
	return true;
}
@timer_seconds_for_player(playerid);
@timer_seconds_for_player(playerid) 
{
	if(GetPVarInt(playerid, "TIME_PLAYER_INFO"))
	{
		SetPVarInt(playerid, "TIME_PLAYER_INFO", GetPVarInt(playerid, "TIME_PLAYER_INFO") - 1);
		if(!GetPVarInt(playerid, "TIME_PLAYER_INFO")) PlayersInfo(playerid, "", false);
	}
	if(!temp[playerid][temp_login])
	{
		if(temp[playerid][LoginRegisterTime])
		{
			temp[playerid][LoginRegisterTime]--;
			switch(temp[playerid][LoginRegisterTime])
			{
			case 60: server_error(playerid, "у вас осталось 60 секунд, после вас кикнут с сервера.");
			case 30: server_error(playerid, "у вас осталось 30 секунд, после вас кикнут с сервера.");
			case 15: server_error(playerid, "у вас осталось 15 секунд, после вас кикнут с сервера.");
			case 5: server_error(playerid, "у вас осталось 5 секунд, после вас кикнут с сервера.");
			}
			if(!temp[playerid][LoginRegisterTime])
			{
				switch(GetPVarInt(playerid, "CheckRegistrationUser"))
				{
				case 1: TKICK(playerid, "Вы кикнуты за долгую авторизацию.");
				case 2: TKICK(playerid, "Вы кикнуты за долгую регистрацию.");
				}
			}
		}
	}
	if(PlayerIsOnline(playerid)) return true;
	
	if ( users [ playerid ] [ u_injured_leg ] ) users [ playerid ] [ u_injured_leg ] --;
	if(temp[playerid][TimeUsePack]) temp[playerid][TimeUsePack]--;
	
	if ( users [ playerid ] [ u_injured_time ] != 0 && users [ playerid ] [ u_injured ] != 0 )
	{
		if ( ( users [ playerid ] [ u_injured_time ] -- ) == 90 || users [ playerid ] [ u_injured_time ] == 60 || users [ playerid ] [ u_injured_time ] == 30 )
			SEM ( playerid, "Через %i секунд вы сможете %s.", users [ playerid ] [ u_injured_time ], (users [ playerid ] [ u_injured ] == 1)?("встать"):("вы сможете принять смерть") );

		if ( users [ playerid ] [ u_injured_time ] == 0 )
		{
			if ( users [ playerid ] [ u_injured ] == 1 )
			{
				users [ playerid ] [ u_injured ] = 0;
				SSM ( playerid, "Ваш персонаж встал, но он все ещё ранен, вы не можете быстро ходить ещё 55 секунд." );
				users [ playerid ] [ u_injured_leg ] = 55;
				ClearAnimLoop ( playerid );
				if ( IsValidDynamic3DTextLabel ( users_death [ playerid ] ) )
				{
					DestroyDynamic3DTextLabel ( users_death [ playerid ] );
					users_death [ playerid ] = Text3D:INVALID_3DTEXT_ID;
				}
			}
			else 
				SEM ( playerid, "Теперь вы можете принять смерть /acceptdeath" );
		}
		//SEM ( playerid, "%i", users [ playerid ] [ u_injured_time ] );
	}


	update_users_panel(playerid);
	new Float:speed = GetSpeed ( playerid );

	if ( debug_player [ playerid ] [ stamina ] == true ) 
		SEM ( playerid, "Текущаю стамина: %.2f", users [ playerid ] [ u_stamina ] );
	
	if ( speed >= 9.0 && users [ playerid ] [ u_injured_leg ] != 0 )
		ApplyAnimation ( playerid, "PED", "FALL_collapse", 4.1, 0, 1, 1, 0, 0 );
	
	if ( speed >= 6.0 && users [ playerid ] [ u_adrenaline_otx ] != 0 )
		ApplyAnimation ( playerid, "PED", "Player_Sneak", 4.1, 1, 1, 1, 1, 1 );

	if ( GetPlayerAnimationIndex ( playerid ) == 1197 )
	{
		if ( users [ playerid ] [ u_stamina ] > 0 )
			users [ playerid ] [ u_stamina ] = users [ playerid ] [ u_stamina ] - 8.0;
		else
		{
			OnePlayAnim(playerid,"FAT","IDLE_tired",4.0,0,0,1,1,0);
		}
	}
	else if ( speed > 15.0 )
	{
		if ( users [ playerid ] [ u_stamina ] > 0 )
			users [ playerid ] [ u_stamina ] = users [ playerid ] [ u_stamina ] - 15.0;
		else
		{
			OnePlayAnim(playerid,"FAT","IDLE_tired",1.0,0,0,0,0,0);
		}

		temp [ playerid ] [ tMissStamina ] = 4;
	}
	else if ( temp [ playerid ] [ tMissStamina ] )
		temp [ playerid ] [ tMissStamina ] --;
	else if ( users [ playerid ] [ u_adrenaline_use ] == 0 )
	{
		if ( users [ playerid ] [ u_stamina ] < 100.0 && users [ playerid ] [ u_perk ] != 1 )
			users [ playerid ] [ u_stamina ] += 10;
		else if ( users [ playerid ] [ u_stamina ] < MAX_STAMINA_SHTURM && users [ playerid ] [ u_perk ] == 1 )
			if ( ( users [ playerid ] [ u_stamina ] += STAMINA_SHTUMR_P ) > MAX_STAMINA_SHTURM ) users [ playerid ] [ u_stamina ] = MAX_STAMINA_SHTURM;
	}
	else
	{
		if ( users [ playerid ] [ u_stamina ] < (100.0+STAMINA_MEDIK_ADD) && users [ playerid ] [ u_perk ] != 1 )
			users [ playerid ] [ u_stamina ] += STAMINA_MEDIK_REG;
		else if ( users [ playerid ] [ u_stamina ] < (MAX_STAMINA_SHTURM+STAMINA_MEDIK_ADD) && users [ playerid ] [ u_perk ] == 1 )
			if ( ( users [ playerid ] [ u_stamina ] += STAMINA_MEDIK_REG ) > MAX_STAMINA_SHTURM ) users [ playerid ] [ u_stamina ] = MAX_STAMINA_SHTURM+STAMINA_MEDIK_ADD;
	}
	/*else if ( users [ playerid ] [ u_stamina ] < 100.0 && users [ playerid ] [ u_perk ] != 1 && users [ playerid ] [ u_adrenaline_use ] == 0 )
	{
		if ( temp [ playerid ] [ tMissStamina ] )
			temp [ playerid ] [ tMissStamina ] --;
		else 
			users [ playerid ] [ u_stamina ] += 10;
	}
	else if ( users [ playerid ] [ u_stamina ] < MAX_STAMINA_SHTURM && users [ playerid ] [ u_perk ] == 1 )
	{
		if ( temp [ playerid ] [ tMissStamina ] )
			temp [ playerid ] [ tMissStamina ] --;
		else if ( ( users [ playerid ] [ u_stamina ] += STAMINA_SHTUMR_P ) > MAX_STAMINA_SHTURM )
			users [ playerid ] [ u_stamina ] = MAX_STAMINA_SHTURM;
	}
	*/
	/* STAMINA_MEDIK_ADD */

	if(GetPVarInt(playerid, "PROGRESSBAR_TIME_S")) 
	{
		SetPVarInt(playerid, "PROGRESSBAR_TIME_E", GetPVarInt(playerid, "PROGRESSBAR_TIME_E") + 1);
		progress_bar(playerid);
	}
	if(users[playerid][u_health] > 100.0) 
	{
		if(!admin[playerid][u_a_gm] && !temp[playerid][time_infinity_health] && !temp[playerid][infinity_health])
		{
			if(admin[playerid][u_a_gm] || temp[playerid][time_infinity_health] || temp[playerid][infinity_health]) SetPlayerHealth(playerid, 0x7F800000);
			else 
			{
				users[playerid][u_health] = 100.0;
				SetPlayerHealth(playerid, users[playerid][u_health]);
			}
		}
	}
	if(temp[playerid][time_infinity_health])
	{
		temp[playerid][time_infinity_health]--;
		switch(temp[playerid][time_infinity_health])
		{
		case 0, 1: GivePlayerHealth(playerid, 100.0);
		}
	}
	if(users[playerid][u_mute])
	{
		users[playerid][u_mute]--;
		if(!users[playerid][u_mute]) return server_accept(playerid, "Ваш чат разблокирован.");
	}
	for(new gx = 0; gx < 13; gx++)
	{
		if(!GetPlayerWeaponSlot(playerid, gx)) continue;
		if(GetPlayerWeaponSlot(playerid, gx) < 22) continue;
		if(GetPlayerAmmoSlot(playerid, gx) > 0) continue;
		AddItem(playerid, GetWeaponItem(GetPlayerWeaponSlot(playerid, gx)), 1);
		RemovePlayerWeapon(playerid, GetPlayerWeaponSlot(playerid, gx));
	}
	if(users[playerid][u_vip_time]) 
	{ 
		users[playerid][u_vip_time] --; 
		if(!users[playerid][u_vip_time]) 
		{ 
			users[playerid][u_vip_time] = 0;
			SaveAccountInt(playerid, "u_vip_time", 0);
			for(new sv = 0; sv != 4; sv++) users[playerid][u_settings_vip][sv] = 0;
		}
	}
	GetZone(playerid);
	switch(GetItem(playerid, 52)) //HideMap_TD
	{
	case 0: 
		{
			GZ_ShapeHideForPlayer(playerid, GreenZone);
			GangZoneShowForPlayer(playerid, BLACKZONE, 0x000000FF);
		}
	default: 
		{
			GZ_ShapeShowForPlayer(playerid, GreenZone, 0x00FF00AA);
			GangZoneHideForPlayer(playerid, BLACKZONE);
		}
	}
	if(GetPVarInt(playerid, "BLOODSCREEN_TIME"))
	{
		SetPVarInt(playerid, "BLOODSCREEN_TIME", GetPVarInt(playerid, "BLOODSCREEN_TIME") - 1);
		if(!GetPVarInt(playerid, "BLOODSCREEN_TIME"))
		{
			TextDrawHideForPlayer(playerid, ZVision);
			DeletePVar(playerid, "BLOODSCREEN_TIME");
		}
	}
	if(!users[playerid][u_hunger]) RemovePlayerHealth(playerid, 0.1);
	if(!users[playerid][u_thirst]) RemovePlayerHealth(playerid, 0.1);
	if(GetPVarInt(playerid, "RECEIVED_DAMAGE_TIME")) 
	{
		SetPVarInt(playerid, "RECEIVED_DAMAGE_TIME", GetPVarInt(playerid, "RECEIVED_DAMAGE_TIME") - 1);
		if(!GetPVarInt(playerid, "RECEIVED_DAMAGE_TIME")) DeletePVar(playerid, "RECEIVED_DAMAGE_TIME");
	}
	if(users[playerid][u_temperature] < 25.0 || users[playerid][u_temperature] > 40.0) RemovePlayerHealth(playerid, 0.5);
	if(IsPlayerInWater(playerid)) 
	{
		if(GetItem(playerid, 45)) 
		{ 
			server_message(playerid, "Бутылка наполнена водой");
			RemoveItem(playerid, 45);
			AddItem(playerid, 125, 1);
		}
		users[playerid][u_temperature] -= 0.01; 
	}
	for(new gwa = 1; gwa < 6; gwa++)
	{
		GetPlayerWeaponData(playerid, gwa, get_weapon_player[playerid][gwa-1][0], get_weapon_player[playerid][gwa-1][1]);
		if(get_weapon_player[playerid][gwa-1][0] != GetPlayerWeapon(playerid) && get_weapon_player[playerid][gwa-1][1] > 0)
		{
			if(!IsPlayerAttachedObjectSlotUsed(playerid, gwa))
			{
				switch(gwa)
				{
				case 1: SetPlayerAttachedObject(playerid, gwa, GetWeaponModel(get_weapon_player[playerid][gwa-1][0]), 1, -0.0120, -0.1489, 0.0170, 0.0000, 87.8999, -11.5000, 1.0000, 1.0000, 1.0000);
				case 2: SetPlayerAttachedObject(playerid, gwa, GetWeaponModel(get_weapon_player[playerid][gwa-1][0]), 8, -0.0540, -0.0270, 0.1089, -85.5999, 0.0000, 0.0000, 1.0000, 1.0000, 1.0000);
				case 3: SetPlayerAttachedObject(playerid, gwa, GetWeaponModel(get_weapon_player[playerid][gwa-1][0]), 1, -0.1619, -0.1389, -0.1270, -98.0000, 17.2999, 4.5999, 1.0000, 1.0000, 1.0000);
				case 4: SetPlayerAttachedObject(playerid, gwa, GetWeaponModel(get_weapon_player[playerid][gwa-1][0]), 7, -0.0210, -0.0580, -0.1119, -79.7000, 12.0000, 3.8999, 1.0000, 1.0000, 1.0000);
				case 5: SetPlayerAttachedObject(playerid, gwa, GetWeaponModel(get_weapon_player[playerid][gwa-1][0]), 1, -0.1560, -0.1829, 0.1840, -92.0000, 12.5999, 2.3000, 1.0000, 1.0000, 1.0000);
				case 6: SetPlayerAttachedObject(playerid, gwa, GetWeaponModel(get_weapon_player[playerid][gwa-1][0]), 1, -0.1560, -0.0530, 0.1269, -176.0999, 10.3000, 14.0999, 1.0000, 1.0000, 1.0000);
				}
			}
		}
		else if(IsPlayerAttachedObjectSlotUsed(playerid, gwa)) RemovePlayerAttachedObject(playerid, gwa);
	}
	/*
		AFK System
	*/
    SetPVarInt(playerid, "AFK", GetPVarInt(playerid, "AFK")+1);
    if(GetPVarInt(playerid, "AFK") > 1)
    {
		if(GetPVarInt(playerid, "AFK") > 900)
		{
			if(admin[playerid][admin_level]) return true;
			SCMAF(COLOR_BROWN, "Игрок %s был кикнут сервером. Причина: Долгое AFK.", users[playerid][u_name]);
			TKICK(playerid, "Вас кикнула система за долгое АФК.");
		}
    }

	if(GetPVarInt(playerid, "AFK") < 2) 
	{
		users[playerid][u_lifegame]++;
		users[playerid][u_lifetime] ++;
		if(!users[playerid][u_achievement][9] && !users[playerid][u_achievement][9])
		{
			if(users[playerid][u_lifetime] > achievements[8][achievement_progress]-1) Quest(playerid, 2);
		}
	}
	
	/*if(!IsPlayerInAnyVehicle(playerid))
	{
		for(new air = 0; air < MAX_AIRDROPS; air++)
		{
			if(!airdrop[air][airdrop_time]) continue;
			if(!airdrop[air][airdrop_dropped]) continue;
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, airdrop[air][airdrop_xyz][0], airdrop[air][airdrop_xyz][1], airdrop[air][airdrop_xyz][2])) continue;
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~b~~h~~h~~h~Press ~h~~k~~CONVERSATION_NO~ ~b~~h~~h~~h~to pick", 1000, 3);
			break;
		}
	}*/
	return 1; 
}
/*

	OnGameModeInit;

*/
public OnGameModeInit()
{
	timer_seconds = SetTimer("@timer_seconds", 1000, true); // Секундный таймер;
	timer_minutes = SetTimer("@timer_minutes", (1000 * 60), true); // Минутный таймер;
#if defined TIME_OnGameModeInit
    return TIME_OnGameModeInit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit TIME_OnGameModeInit
#if defined   TIME_OnGameModeInit
	forward TIME_OnGameModeInit();
#endif 
/*

	OnGameModeExit;

*/
public OnGameModeExit()
{
	KillTimer(timer_seconds); // Секундный таймер;
	KillTimer(timer_minutes); // Минутный таймер;
#if defined TIME_OnGameModeExit
    return TIME_OnGameModeExit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit TIME_OnGameModeExit
#if defined   TIME_OnGameModeExit
	forward TIME_OnGameModeExit();
#endif 

