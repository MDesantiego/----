public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	// if ( temp [ playerid ] [ use_dialog ] != -1 ) return 1 ;
    if(!(_:clickedid ^ 0xFFFF))
    {
		switch(GetPVarInt(playerid, "CheckRegistrationUser"))
		{
		case 1: TKICK(playerid, "Вы отказались от авторизации.");
		case 2: TKICK(playerid, "Вы отказались от регистрации аккаунта.");
		}
		use_craft_tools_pila[playerid]						= 0;
		for(new i = 0; i != 13; i++) 
		{
			TextDrawHideForPlayer(playerid, Text: craft_pila_TD[i]);
		}
		for(new i = 0; i != 3; i++) 
		{
			PlayerTextDrawHide(playerid, PlayerText: craft_pila_PTD[playerid][i]);
		}
		for(new i = 0; i != 12; i++) 
		{
			TextDrawHideForPlayer(playerid, Text: craft_stol_TD[i]);
		}
		for(new i = 0; i != 3; i++) 
		{
			PlayerTextDrawHide(playerid, PlayerText: craft_stol_PTD[playerid][i]);
		}
		for(new i = 0; i != 14; i++) 
		{
			TextDrawHideForPlayer(playerid, Text: craft_pech_TD[i]);
		}
		for(new i = 0; i != 3; i++) 
		{
			PlayerTextDrawHide(playerid, PlayerText: craft_pech_PTD[playerid][i]);
		}
		TextDrawHideForPlayer(playerid, Text: drop_items_TD);
    }
	if(clickedid == drop_items_TD) return callcmd::drop(playerid);
	if(clickedid == craft_stol_TD[7])
	{
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] > 0) return server_error(playerid, "Ожидайте завершения крафта.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] != 0) return server_error(playerid, "Сначала нужно забрать изготовленную вещь.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 0) return InventoryStol(playerid);
		if( (users[playerid][u_slots]+1) > users[playerid][u_backpack]*10) return server_error(playerid, "Ваш инвентарь полон, выбросите что-нибудь!");
		AddItem(playerid, craft_tool[use_craft_tools_pila[playerid]][craft_stol_one], 1);
		users[playerid][u_slots] ++;
		SCMG(playerid, "%s перемещен(-а) к вам в инвентарь.", loots[craft_tool[use_craft_tools_pila[playerid]][craft_stol_one]][loot_name]);
		craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] = 0;
		UseCraftTools(playerid, 2);
		return true;
	}
	if(clickedid == craft_stol_TD[8])
	{
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] > 0) return server_error(playerid, "Ожидайте завершения крафта.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] != 0) return server_error(playerid, "Сначала нужно забрать изготовленную вещь.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 0) return InventoryStol(playerid);
		if( (users[playerid][u_slots]+1) > users[playerid][u_backpack]*10) return server_error(playerid, "Ваш инвентарь полон, выбросите что-нибудь!");
		AddItem(playerid, craft_tool[use_craft_tools_pila[playerid]][craft_stol_two], 1);
		users[playerid][u_slots] ++;
		SCMG(playerid, "%s перемещен(-а) к вам в инвентарь.", loots[craft_tool[use_craft_tools_pila[playerid]][craft_stol_two]][loot_name]);
		craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] = 0;
		UseCraftTools(playerid, 2);
		return true;
	}
	if(clickedid == craft_pech_TD[6])
	{
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] != 1)
		{
			if(GetItem(playerid, 123) < 1) return server_error(playerid, "У вас нет с собой аккумулятора.");
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Требуется набор иструментов для установки аккумулятора.");
			RemoveItem(playerid, 123);
			users[playerid][u_slots]--;
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] = 1;
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery_progress] = 100;
			UseCraftTools(playerid, 3);
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] > 0) 
			{
				craft_tool[use_craft_tools_pila[playerid]][craft_pech_timer] = 15;
				server_error(playerid, "Вы установили пилу на станок, распил бревен возобновлён.");
			}
			else server_accept(playerid, "Вы установили пилу на станок.");
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] == 1 && craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery_progress] < 1)
		{
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Требуется набор иструментов для снятия аккумулитора.");
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery_progress] = 0;
			AddItem(playerid, 124, 1);
			users[playerid][u_slots]++;
			server_accept(playerid, "Вы сняли разряженный аккумулятор.");
			UseCraftTools(playerid, 3);
			return true;
		}
		return true;
	}
	if(clickedid == craft_pech_TD[9])
	{
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] >= 100) return server_error(playerid, "Заберите переплавленный металл из печи. (Нажмите 'done')");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_timer] > 0) return server_error(playerid, "Ожидайте окончания переплавки.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] < 100 && craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] > 0) return server_error(playerid, "Ожидайте окончания переплавки.");
		InventoryPech(playerid);
		return true;
	}
	if(clickedid == craft_pila_TD[7]) // Пила "USE"
	{
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] != 1)
		{
			if(GetItem(playerid, 120) < 1) return server_error(playerid, "У вас нет с собой пилы.");
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Требуется набор иструментов для установки пилы.");
			RemoveItem(playerid, 120);
			users[playerid][u_slots]--;
			craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] = 1;
			craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular_percent] = 100;
			UseCraftTools(playerid, 1);
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] > 0) 
			{
				craft_tool[use_craft_tools_pila[playerid]][craft_pila_timer] = 15;
				server_error(playerid, "Вы установили пилу на станок, распил бревен возобновлён.");
			}
			else server_accept(playerid, "Вы установили пилу на станок.");
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] == 1 && craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular_percent] < 1)
		{
			if(GetItem(playerid, 40) < 1) return server_error(playerid, "Требуется набор иструментов для снятия пилы.");
			craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular_percent] = 0;
			AddItem(playerid, 119, 1);
			users[playerid][u_slots]++;
			server_accept(playerid, "Вы сняли сломанную пилу.");
			UseCraftTools(playerid, 1);
			return true;
		}
	}
	if(clickedid == craft_pila_TD[8])
	{
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] >= 100) return server_error(playerid, "Заберите доски.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] > 1) return server_error(playerid, "Дождитесь окончания процесса распиливания.");
		if(GetItem(playerid, 116) < 1) return server_error(playerid, "У вас нет с собой бревен.");
		RemoveItem(playerid, 116);
		users[playerid][u_slots]--;
		craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber]++;
		server_accept(playerid, "Вы установили добавили бревно в очередь на распил.");
		UseCraftTools(playerid, 1);
	}
	if(clickedid == PanelReconAdmin_TD[2]) // BACK
	{
		if(observation[playerid][observation_id] != -1)
		{
			for(new i = observation[playerid][observation_id]; i >= 0; i--)
			{
				if(PlayerIsOnline(i) || playerid == i || observation[playerid][observation_id] == i || observation[i][observation_id] != INVALID_PLAYER_ID) continue;
				observation[playerid][observation_id] = i;
				UpdateObservationStatus(playerid, observation[playerid][observation_id]);
				break;
			}
		}
		return true;
	}
	if(clickedid == PanelReconAdmin_TD[3]) // NEXT
	{
		if(observation[playerid][observation_id] != -1)
		{
			for(new i = observation[playerid][observation_id]; i < GetMaxPlayers(); i++)
			{
				if(PlayerIsOnline(i) || playerid == i || observation[playerid][observation_id] == i || observation[i][observation_id] != INVALID_PLAYER_ID) continue;
				observation[playerid][observation_id] = i;
				UpdateObservationStatus(playerid, observation[playerid][observation_id]);
				break;
			}
		}
		return true;
	}
	if(clickedid == PanelReconAdmin_TD[4])
	{
		static str[96];
		format(str, sizeof(str), "\nВведите причину для блокировки аккаунта игрока %s (%i)\n", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
		show_dialog(playerid, d_recon_ban, DIALOG_STYLE_INPUT, "Блокировка аккаунта", str, !"Блок", !"Отмена");//BAN
	}
	if(clickedid == PanelReconAdmin_TD[5])
	{
		static str[96];
		format(str, sizeof(str), "\nВведите причину для блокировки аккаунта и IP игрока %s (%i)\n", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
		show_dialog(playerid, d_recon_iban, DIALOG_STYLE_INPUT, "Блокировка аккаунта", str, !"Блок", !"Отмена");//IBAN
	}
	if(clickedid == PanelReconAdmin_TD[6])
	{
		static str[96];
		format(str, sizeof(str), "\nВведите причину для блокировки чата игрока %s (%i)\n", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
		show_dialog(playerid, d_recon_mute, DIALOG_STYLE_INPUT, "Блокировка чата", str, !"Блок", !"Отмена");//MUTE
	}
	if(clickedid == PanelReconAdmin_TD[7])
	{
		static str[96];
		format(str, sizeof(str), "\nВведите причину для кика игрока %s (%i)\n", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
		show_dialog(playerid, d_recon_kick, DIALOG_STYLE_INPUT, "Кик", str, !"Кикнуть", !"Отмена");//KICK
	}
	if(clickedid == PanelReconAdmin_TD[8]) 
	{
		ShowStats(playerid, observation[playerid][observation_id]); //STATS
	}
	if(clickedid == PanelReconAdmin_TD[9])
	{
		static str[11];
		format(str, sizeof(str), "%i", observation[playerid][observation_id]);
		callcmd::slap(playerid, str); //SLAP
	}
	if(clickedid == PanelReconAdmin_TD[13]) //UPDATE
	{
		UpdateObservationStatus(playerid, observation[playerid][observation_id]);
	}
	if(clickedid == PanelReconAdmin_TD[14]) //EXIT
	{
		callcmd::reoff(playerid);
	}
    /*if(clickedid == RegGender_TD[7])
    {
   		SetPVarInt(playerid, "RegGender", 1);
		CreateAccountEx(playerid);
  		return 1;
    }
    if(clickedid == RegGender_TD[8])
    {
   		SetPVarInt(playerid, "RegGender", 2);
		CreateAccountEx(playerid);
  		return 1;
	}*/
    return 0;
}

stock ConfirmRegister ( playerid )
{
	users_register [ playerid ] [ 2 ] [ 1 ] = 1;
	users_register [ playerid ] [ 2 ] [ 2 ] = 5;
	users_registration ( playerid );
	
	for ( new i = 0; i < 13; i ++ )
		PlayerTextDrawHide ( playerid, regiser__menu [ playerid ] [ i ] );
	
	return 1;
}


Dialog:player_skip_promo ( params_dialog )
{
	if ( !response )
		return 1;
	
	ConfirmRegister ( playerid );
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	for ( new i = 30 ; i < 60 ; i ++ )
	{
		if ( playertextid != inventory__TD [ playerid ] [ i ] )
			continue;

		new k = i-30;

		if ( temp [ playerid ] [ t_inv_new_slot ] == true )
		{
			if ( user_items [ playerid ] [ k ] [ item_id ] != 0 )
				return SEM ( playerid, "[SLOT USED] new slot != 0" );

			new old_slot = temp [ playerid ] [ t_inv_old_slot_id ];

			user_items [ playerid ] [ k ] [ item_id ] = user_items [ playerid ] [ old_slot ] [ item_id ];
			user_items [ playerid ] [ k ] [ item_value ] = user_items [ playerid ] [ old_slot ] [ item_value ];
			user_items [ playerid ] [ k ] [ item_quantity ] = user_items [ playerid ] [ old_slot ] [ item_quantity ];
			user_items [ playerid ] [ k ] [ item_use_id ] = user_items [ playerid ] [ old_slot ] [ item_use_id ];
			user_items [ playerid ] [ k ] [ item_use_value ] = user_items [ playerid ] [ old_slot ] [ item_use_value ];
			user_items [ playerid ] [ k ] [ item_use_quantity ] = user_items [ playerid ] [ old_slot ] [ item_use_quantity ];

			user_items [ playerid ] [ old_slot ] [ item_id ] =
			user_items [ playerid ] [ old_slot ] [ item_value ] =
			user_items [ playerid ] [ old_slot ] [ item_quantity ] =
			user_items [ playerid ] [ old_slot ] [ item_use_id ] =
			user_items [ playerid ] [ old_slot ] [ item_use_value ] =
			user_items [ playerid ] [ old_slot ] [ item_use_quantity ] = 0;

			temp [ playerid ] [ t_inv_new_slot ] = false;
			SEM ( playerid, "[SLOT USED] new slot equip!" );
			return 1;
		}

		if ( user_items [ playerid ] [ k ] [ item_id ] != 0 )
		{
			SEM ( playerid, "[SLOT USERD] select new slot" );
			temp [ playerid ] [ t_inv_new_slot ] = true;
			temp [ playerid ] [ t_inv_old_slot_id ] = k;		
			return 1;
		}
		

		return 1;
		/*{




			return 1;
		}*/

	}

	if ( playertextid == regiser__menu [ playerid ] [ 3 ] )
	{
		if ( temp [ playerid ] [ temp_register ] [ 0 ] != 1 || temp [ playerid ] [ temp_register ] [ 1 ] != 1 )
			return SEM ( playerid, "Заполните все поля" );
		
		if ( temp [ playerid ] [ temp_register ] [ 2 ] != 1 )
			return Dialog_Show ( playerid, player_skip_promo, DIALOG_STYLE_MSGBOX, "Регистрация | {ADD8E6}Подтверждиние", "\n{fffff0}Вы уверены что хотите {ADD8E6}пропустить ввод Промокода{FFFFF0}?\n\n", "Да", "Назад" );
		
		ConfirmRegister ( playerid );
	}
	
	if ( playertextid == regiser__menu [ playerid ] [ 6 ] )
		RegisterDialog ( playerid, "password" );
	
	if ( playertextid == regiser__menu [ playerid ] [ 9 ] )
		RegisterDialog ( playerid, "email" );
	
	if ( playertextid == regiser__menu [ playerid ] [ 12 ] )
		RegisterDialog ( playerid, "friend" );
	
	for(new i = 2; i < sizeof(Captcha); i++)
	{
		if(playertextid == Captcha[i])
		{
			new sstring[MAX_PLAYER_NAME];
			GetPVarString(playerid, "CaptchaText", sstring, sizeof(sstring));
			switch(GetPVarInt(playerid, "CaptchaStep"))
			{
			case 0: format(sstring, sizeof(sstring), "%c", TextArray[i - 2]), strcat(sstring, "----"), SetPVarString(playerid, "CaptchaText", sstring);
			case 1: format(sstring, sizeof(sstring), "%s%c", sstring, TextArray[i - 2]), strdel(sstring, 1, 5), strcat(sstring, "---"), SetPVarString(playerid, "CaptchaText", sstring);
			case 2: format(sstring, sizeof(sstring), "%s%c", sstring, TextArray[i - 2]), strdel(sstring, 2, 5), strcat(sstring, "--"), SetPVarString(playerid, "CaptchaText", sstring);
			case 3: format(sstring, sizeof(sstring), "%s%c", sstring, TextArray[i - 2]), strdel(sstring, 3, 5), strcat(sstring, "-"), SetPVarString(playerid, "CaptchaText", sstring);
			case 4:
				{
					strdel(sstring, 4, 5);
					format(sstring, sizeof(sstring), "%s%c", sstring, TextArray[i - 2]);
					PlayerTextDrawSetString(playerid, Captcha[1], sstring);
					if(!strcmp (users[playerid][u_code], "NoCode", true)){}
					else
					{
						if(strcmp (users[playerid][u_code], sstring) != 0)
						{
							AddUserLogin(playerid, 0);
							for(new z = 0; z < sizeof(Captcha); z++) PlayerTextDrawHide(playerid, Captcha[z]);
							DeletePVar(playerid, "CaptchaStep"); DeletePVar(playerid, "CaptchaText");
							TKICK(playerid, "Пин-код введен неверно.");
							return 1;
						}
      					else
						{
							for(new z = 0; z < sizeof(Captcha); z++) PlayerTextDrawHide(playerid, Captcha[z]);
							DeletePVar(playerid, "CaptchaStep"); DeletePVar(playerid, "CaptchaText");
							CancelSelectTextDraw(playerid);
							LoadPlayer(playerid);
							return true;
						}
					}
				}
			}
			SetPVarInt(playerid, "CaptchaStep", GetPVarInt(playerid, "CaptchaStep") + 1);
			//PlayerTextDrawSetString(playerid, Captcha[1], sstring);
		}
	}
	if(playertextid == PlayerText: craft_pech_PTD[playerid][1])
	{
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] != 1) return server_error(playerid, "Необходимо установить аккумулятор.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery_progress] < 1) return server_error(playerid, "Смените аккумулятор.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_timer] > 0) return server_error(playerid, "Подождите окончания процесса переплавки.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] < 100 && craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] > 0) return server_error(playerid, "Дождитесь окончания процесса.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] >= 100)
		{
			if( (users[playerid][u_slots]+craft_tool[use_craft_tools_pila[playerid]][craft_pech_metal]) > users[playerid][u_backpack]*10) return server_error(playerid, "Ваш инвентарь полон, выбросите что-нибудь!");
			users[playerid][u_slots] += craft_tool[use_craft_tools_pila[playerid]][craft_pech_metal];
			AddItem(playerid, 117, craft_tool[use_craft_tools_pila[playerid]][craft_pech_metal]);
			SCMG(playerid, "Добавлено %i шт. необработанного металла в инвентарь.", craft_tool[use_craft_tools_pila[playerid]][craft_pech_metal]);
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_metal] = 0;
			UseCraftTools(playerid, 3);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] == 0)
		{
		// if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_unwrought] < 1) return server_error(playerid, "Добавьте оружие на переплавку.");
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] != 1) return server_error(playerid, "Необходимо установить аккумулятор.");
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery] == 1 && craft_tool[use_craft_tools_pila[playerid]][craft_pech_battery_progress] < 1) return server_error(playerid, "Аккумулятор разряжен, замените аккумулятор.");
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_unwrought] < 1) return server_error(playerid, "Добавьте оружие на переплавку.");
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_timer] = 15;
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] = 0;
			server_accept(playerid, "Вы запустили процесс переплавки металла.");
			UseCraftTools(playerid, 3);
			return true;
		}
		return true;
	}
	if(playertextid == PlayerText: craft_stol_PTD[playerid][0])
	{//35, 115, 117..119, 121, 122
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] > 0 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] != 0) return server_error(playerid, "Дождитесь окончания изготовления.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 0 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 0) return server_error(playerid, "Для изготовления новых предметов, необходимо влажить в слоты предметы.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] != 0 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] >= 100)
		{
			if( (users[playerid][u_slots]+1) > users[playerid][u_backpack]*10) return server_error(playerid, "Ваш инвентарь полон, выбросите что-нибудь!");
			AddItem(playerid, craft_tool[use_craft_tools_pila[playerid]][craft_stol_item], 1);
			users[playerid][u_slots]++;
			SCMG(playerid, "Вы заборали с верстака ''%s''", loots[craft_tool[use_craft_tools_pila[playerid]][craft_stol_item]][loot_name]);
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] = 0;
			UseCraftTools(playerid, 2);
			return true;
		}
		for(new i = 0; i != sizeof(Clothing); i++)
		{
			if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == Clothing[i] && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 0 ||
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 0 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == Clothing[i])
			{
				craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 5;
				craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
				craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 122;
				UseCraftTools(playerid, 2);
				return true;
			}
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 115 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 0 || 
		craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 0 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 115) 
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 12;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 55;
			UseCraftTools(playerid, 2);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 119 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 117 || 
		craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 117 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 119) 
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 20;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 120;
			UseCraftTools(playerid, 2);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 118 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 117 || 
		craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 117 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 118) 
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 20;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 120;
			UseCraftTools(playerid, 2);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 35 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 35)
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 5;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 114;
			UseCraftTools(playerid, 2);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 31 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 31)
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 5;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 122;
			UseCraftTools(playerid, 2);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 122 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 122)
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 5;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = random(sizeof(Clothing));
			UseCraftTools(playerid, 2);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 122 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 0 || 
		craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 0 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 122) 
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 12;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 31;
			UseCraftTools(playerid, 2);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 117 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 117)
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 15;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 41;
			UseCraftTools(playerid, 2);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 122 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 117 || 
		craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 117 && craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 122) 
		{
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_timer] = 12;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_stol_item] = 121;
			UseCraftTools(playerid, 2);
			return true;
		}
		return true;
	}
	if(playertextid == PlayerText: craft_pila_PTD[playerid][0])
	{
		// if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] != 1) return server_error(playerid, "Установите пилу.");
		// if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] < 1 && ) return server_error(playerid, "Вы не установили бревна в очередь на распил.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular_percent] < 1 && craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] == 1) return server_error(playerid, "Замените пилу.");
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] > 0 && craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] < 100 && craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] > 0) return server_error(playerid, "Дождитесь окончания распиливания бревен."), UseCraftTools(playerid, 1);
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] < 100 && craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] > 0) return server_error(playerid, "Дождитесь окончания процесса.");
		// if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] != 0) return server_error(playerid, "")
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] >= 101)
		{
			if( (users[playerid][u_slots]+craft_tool[use_craft_tools_pila[playerid]][craft_pila_woords]) > users[playerid][u_backpack]*10) return server_error(playerid, "Ваш инвентарь полон, выбросите что-нибудь!");
			users[playerid][u_slots] += craft_tool[use_craft_tools_pila[playerid]][craft_pila_woords];
			AddItem(playerid, 115, craft_tool[use_craft_tools_pila[playerid]][craft_pila_woords]);
			SCMG(playerid, "%i шт. распиленных досок добавлено в инвентарь.", craft_tool[use_craft_tools_pila[playerid]][craft_pila_woords]);
			craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] = 0;
			craft_tool[use_craft_tools_pila[playerid]][craft_pila_woords] = 0;
			UseCraftTools(playerid, 1);
			return true;
		}
		if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] == 0)
		{
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] != 1) return server_error(playerid, "Необходимо установить пилу.");
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular] == 1 && craft_tool[use_craft_tools_pila[playerid]][craft_pila_circular_percent] < 1) return server_error(playerid, "Пила сломана, замените пилу в станке.");
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pila_timber] < 1) return server_error(playerid, "В циркулярный станок необходимо установить бревна.");
			craft_tool[use_craft_tools_pila[playerid]][craft_pila_timer] = 15;
			craft_tool[use_craft_tools_pila[playerid]][craft_pila_progress] = 0;
			server_accept(playerid, "Вы запустили процесс распиливания бревен.");
			UseCraftTools(playerid, 1);
			return true;
		}
	}
	return 0;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
    if(temp[playerid][gps])
	{
		server_accept(playerid, "Вы достигли места назначения.");
		DisablePlayerRaceCheckpoint(playerid);
		temp[playerid][gps] = false;
	}
    return 1;
}
@LoadClan();
@LoadClan()
{
	new time = GetTickCount(), rows;
	cache_get_row_count(rows);
	if(!rows) return print("["SQL_VER"][WARNING]: Кланы не найдены.");
	for(new idx = 1; idx <= rows; idx++)
	{
		cache_get_value_name_int(idx-1, "c_id", clan[idx][c_id]);
		cache_get_value_name(idx-1, "c_name", clan[clan[idx][c_id]][c_name], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "c_owner", clan[clan[idx][c_id]][c_owner], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "c_name_abbr", clan[clan[idx][c_id]][c_name_abbr], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "c_rank1", c_rank[clan[idx][c_id]][0], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "c_rank2", c_rank[clan[idx][c_id]][1], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "c_rank3", c_rank[clan[idx][c_id]][2], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "c_rank4", c_rank[clan[idx][c_id]][3], MAX_PLAYER_NAME);
		cache_get_value_name(idx-1, "c_rank5", c_rank[clan[idx][c_id]][4], MAX_PLAYER_NAME);
		static LoadSpawnXYZWI[65];
		cache_get_value_name(idx-1, "c_spawn_xyzfwi", LoadSpawnXYZWI);
		sscanf(LoadSpawnXYZWI, "p<,>ffffii", clan[clan[idx][c_id]][c_spawn_xyzf][0], clan[clan[idx][c_id]][c_spawn_xyzf][1], clan[clan[idx][c_id]][c_spawn_xyzf][2], clan[clan[idx][c_id]][c_spawn_xyzf][3], clan[clan[idx][c_id]][c_spawn_wi][0], clan[clan[idx][c_id]][c_spawn_wi][1]);
		cache_get_value_name_int(idx-1, "c_kills", clan[clan[idx][c_id]][c_kills]);
		cache_get_value_name_int(idx-1, "c_rank_zam", clan[clan[idx][c_id]][c_rank_zam]);
		cache_get_value_name_int(idx-1, "c_skin", clan[clan[idx][c_id]][c_skin]);
	}
	printf("["SQL_VER"][%04dМС]: Загружено кланов: %04d.", GetTickCount() - time, rows);
	return 1; 
}
@CheckPlayerBan(playerid);
@CheckPlayerBan(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
	{//INSERT INTO `users_bans` (`u_b_admin`, `u_b_name`, `u_b_reason`, `u_b_date`, `u_b_ndate`, `u_b_days`) VALUES ('Жирик', 'zummore', 'выебал рот админа', NOW() + INTERVAL 1 DAY, NOW(), '1')
		static str[128];
		static adminn[MAX_PLAYER_NAME], date_unban[20], date_ban[20], reason[64], days_ban;
		cache_get_value_name(0, "u_b_admin", adminn, MAX_PLAYER_NAME);
		cache_get_value_name(0, "u_b_date", date_unban, 20);
		cache_get_value_name(0, "u_b_ndate", date_ban, 20);
		cache_get_value_name(0, "u_b_reason", reason, 64);
		cache_get_value_name_int(0, "u_b_days", days_ban);
	
		global_string[0] = EOS;
		strcat(global_string, "\n{CD5C5C}Ваш аккаунт был заблокирован, за нарушение правил сервера.");
		strcat(global_string, "\n\n{cccccc}* {ffffff}Пожалуйста, сделайте скриншот данного окна (F8),");
		strcat(global_string, "\n  если вы не согласны с наказанием и оставьте жалобу на форуме {cccccc}"FORU_NAME".");
		format(str, sizeof(str), "\n\n{CD5C5C}* {ffffff}Ваш ник: {cccccc}%s.", users[playerid][u_name]);
		strcat(global_string, str);
		format(str, sizeof(str), "\n{CD5C5C}* {ffffff}Ник администратора: {cccccc}%s.", adminn);
		strcat(global_string, str);
		format(str, sizeof(str), "\n{CD5C5C}* {ffffff}Дата блокировки: {cccccc}%s (%i д.).", date_ban, days_ban);
		strcat(global_string, str);
		format(str, sizeof(str), "\n{CD5C5C}* {ffffff}Дата разблокировки: {cccccc}%s.", date_unban);
		strcat(global_string, str);
		format(str, sizeof(str), "\n{CD5C5C}* {ffffff}Причина: {cccccc}%s.", reason);
		strcat(global_string, str);
		strcat(global_string, "\n\n{98FB98}Вы можете разблокировать аккаунт, за плату в размере 200 рублей.");
		strcat(global_string, "\n{98FB98}Для этого вам необходимо пополнить баланс аккаунта на сейте {cccccc}"SITE_NAME"{98FB98},");
		strcat(global_string, "\n{98FB98}после пополнения нажать кнопку '{cccccc}Снять{98FB98}'.");
		show_dialog(playerid, d_ban, DIALOG_STYLE_MSGBOX, !"Информация о блокировке", global_string, !"Снять", !"Выход");
		PlayerBan[playerid] = 1;
		if(temp[playerid][temp_login])
		{
			TogglePlayerSpectating(playerid, true);
			TogglePlayerControllable(playerid, false);
			temp[playerid][temp_login] = false;
			SetPlayerCameraPos(playerid, 1133.0504, -2038.4034, 69.0935);
			SetPlayerCameraLookAt(playerid, 1133.0504,-2038.4034, 69.0935);
		}
		return true;
	}
	return true;
}
@CheckPlayerBanTable(playerid, const name[], days, const reason[]);
@CheckPlayerBanTable(playerid, const name[], days, const reason[])
{
	new rows;
	cache_get_row_count(rows);
	if(rows) return SCMASS(playerid, "Аккаунт '{cccccc}%s{ffffff}' уже заблокирован.", name);
	if(GetPlayerID(name) != INVALID_PLAYER_ID) return server_error(playerid, "Игрок на сервере! Используйте: /ban");
	static str[256];
	m_format(str, sizeof(str), "INSERT INTO "TABLE_BAN" (`u_b_admin`, `u_b_name`, `u_b_reason`, `u_b_date`, `u_b_ndate`, `u_b_days`) VALUES ('%s', '%s', '%s', NOW() + INTERVAL %i DAY, NOW(), '%i')",
	users[playerid][u_name], name, reason, days, days);
	m_query(str);
	format(str, sizeof(str), "Администратор %s забанил оффлайн игрока %s на %i дней. Причина: %s.", users[playerid][u_name], name, days, reason);
	server_errorToAll(str, COLOR_BROWN);
	
	static str_logs[196];
	format(str_logs, sizeof(str_logs), "Заблокировал оффлайн игрока %s на %i дней. Причина: %s", name, days, reason);
	logs_admin(playerid, str_logs, "/banoff");
	AntiFloodCommands(playerid, "/banoff");

	SCMG(playerid, "Аккаунт '{cccccc}%s{ffffff}' был заблокирован на {cccccc}%i{ffffff} дней", name, days);
	return true;
}
@CheckPlayerBanIP(playerid);
@CheckPlayerBanIP(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
	{	
		static str[128];
		static adminn[MAX_PLAYER_NAME], date_unban[20], date_ban[20], reason[64], days_ban;
		cache_get_value_name(0, "u_b_ip_admin", adminn, MAX_PLAYER_NAME);
		cache_get_value_name(0, "u_b_ip_date", date_unban, 20);
		cache_get_value_name(0, "u_b_ip_ndate", date_ban, 20);
		cache_get_value_name(0, "u_b_ip_reason", reason, 64);
		cache_get_value_name_int(0, "u_b_ip_days", days_ban);
	
		global_string[0] = EOS;
		strcat(global_string, "\n{CD5C5C}Ваш ip-адрес заблокирован, за нарушение правил сервера.");
		strcat(global_string, "\n\n{cccccc}* {ffffff}Пожалуйста, сделайте скриншот данного окна (F8),");
		strcat(global_string, "\n  если вы не согласны с наказанием и оставьте жалобу на форуме {cccccc}"FORU_NAME".");
		format(str, sizeof(str), "\n\n{CD5C5C}* {ffffff}IP-адрес: {cccccc}%s.", GetIp(playerid));
		strcat(global_string, str);
		format(str, sizeof(str), "\n{CD5C5C}* {ffffff}Ник администратора: {cccccc}%s.", adminn);
		strcat(global_string, str);
		format(str, sizeof(str), "\n{CD5C5C}* {ffffff}Дата блокировки: {cccccc}%s (%i д.).", date_ban, days_ban);
		strcat(global_string, str);
		format(str, sizeof(str), "\n{CD5C5C}* {ffffff}Дата разблокировки: {cccccc}%s.", date_unban);
		strcat(global_string, str);
		format(str, sizeof(str), "\n{CD5C5C}* {ffffff}Причина: {cccccc}%s.", reason);
		strcat(global_string, str);
		strcat(global_string, "\n\n{98FB98}Вы можете разблокировать ip-адрес, за плату в размере 200 рублей.");
		strcat(global_string, "\n{98FB98}Для этого вам необходимо пополнить баланс аккаунта на сейте {cccccc}"SITE_NAME"{98FB98},");
		strcat(global_string, "\n{98FB98}после пополнения нажать кнопку '{cccccc}Снять{98FB98}'.");
		show_dialog(playerid, d_ban_ip, DIALOG_STYLE_MSGBOX, !"Информация о блокировке", global_string, !"Снять", !"Выход");
		PlayerBan[playerid] = 1;
		if(temp[playerid][temp_login])
		{
			TogglePlayerSpectating(playerid, true);
			TogglePlayerControllable(playerid, false);
			temp[playerid][temp_login] = false;
			SetPlayerCameraPos(playerid, 1133.0504, -2038.4034, 69.0935);
			SetPlayerCameraLookAt(playerid, 1133.0504,-2038.4034, 69.0935);
		}
		return true;
	}
	/* else
	{
		//Проверка на регистрацию:
		static const size_str[] = "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1";
		new str_sql[sizeof(size_str)+MAX_PLAYER_NAME];
		m_format(str_sql, sizeof(str_sql), size_str, users[playerid][u_name]);
		m_tquery(str_sql, "@OnPlayerCheck", "i", playerid);
		PlayerBan[playerid] = 1;
	}*/
	return true;
}
void ClearAnimText(playerid) return ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,0,0,0);
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(admin[playerid][admin_level] < 2 || admin[playerid][u_a_dostup] != 1) return true;
	static str_name[MAX_PLAYER_NAME+6];
	format(str_name, sizeof(str_name), "%s (%i)", users[clickedplayerid][u_name], clickedplayerid);
	show_dialog(playerid, d_click_to_player, DIALOG_STYLE_LIST, str_name, "\
	{cccccc}- {ffffff}Статистика игрока\n\
	{cccccc}- {ffffff}Телепортироваться к игроку\n\
	{cccccc}- {ffffff}Телепортироваться игрока к себе", "Выбрать", "Отмена");
	admin[playerid][u_a_click_to_player] = clickedplayerid;
	return 1;
}
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	switch(response)
	{
	case EDIT_RESPONSE_FINAL: // Игрок сохранил;
		{
			/*if(GetPVarInt(playerid, "EditObjectToCar")) // Редактирование объекта на автомобиле;
			{
				new Float: car_x, Float: car_y, Float: car_z, Float: car_f;
				GetVehiclePos(GetPVarInt(playerid, "CarID"), car_x, car_y, car_z);
				GetVehicleZAngle(GetPVarInt(playerid, "CarID"), car_f);
				if(!IsPlayerInRangeOfPoint(playerid, 10.0, car_x, car_y, car_z)) 
				{
					DestroyDynamicObject(car_object[playerid]);
					DeletePVar(playerid, "CarID");
					DeletePVar(playerid, "EditObjectToCar");
					server_error(playerid, "Вы слишком далеко от автомобиля, действие отменено.");
					return true;
				}
				new chack_ = 0;
				for(new slots = 0; slots < car_slot; slots++)
				{
					if(CarInfo[GetPVarInt(playerid, "CarID")][car_protection][slots]) continue;
					chack_ = slots;
				}
				if(chack_ == 0)
				{
					DestroyDynamicObject(car_object[playerid]);
					DeletePVar(playerid, "CarID");
					DeletePVar(playerid, "ObjectToCar");
					DeletePVar(playerid, "EditObjectToCar");
					server_error(playerid, "На автомобиле уже установлено максимальное кол-во брони.");
					return true;
				}
				new Float: ofx, Float: ofy, Float: ofz, Float: ofaz, Float: finalx, Float: finaly;
				ofx = x-car_x;
				ofy = y-car_y;
				ofz = z-car_z;
				ofaz = rz-car_f;
				finalx = ofx*floatcos(car_f, degrees)+ofy*floatsin(car_f, degrees);
				finaly = -ofx*floatsin(car_f, degrees)+ofy*floatcos(car_f, degrees);

				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_object][chack_] = CreateDynamicObject(
				GetPVarInt(playerid, "SetObjectCarID"), finalx, finaly, ofz, rx, ry, ofaz);

				CarInfo[GetPVarInt(playerid, "CarID")][car_protection][chack_] = GetPVarInt(playerid, "SetObjectCarID");
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_quantity][chack_] = GetPVarInt(playerid, "SetObjectCarQuantity");
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_x][chack_] = finalx;
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_y][chack_] = finaly;
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_z][chack_] = ofz;
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_rx][chack_] = rx;
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_ry][chack_] = ry;
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_rz][chack_] = ofaz;
				SetDynamicObjectPos(CarInfo[GetPVarInt(playerid, "CarID")][car_protection_object][chack_], x, y, z);
				SetDynamicObjectRot(CarInfo[GetPVarInt(playerid, "CarID")][car_protection_object][chack_], rx, ry, rz);
				AttachDynamicObjectToVehicle(CarInfo[GetPVarInt(playerid, "CarID")][car_protection_object][chack_], GetPVarInt(playerid, "CarID"), 
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_x][chack_],
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_y][chack_],
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_z][chack_],
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_rx][chack_],
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_ry][chack_],
				CarInfo[GetPVarInt(playerid, "CarID")][car_protection_rz][chack_]);
				server_accept(playerid, "Вы успешно установили броню на автомобиль.");
				RemoveItem(playerid, GetPVarInt(playerid, "ItemObjectCarID"), GetPVarInt(playerid, "SetObjectCarQuantity"));
				users[playerid][u_slots] --;
				DeletePVar(playerid, "CarID");
				DeletePVar(playerid, "EditObjectToCar");
				DestroyDynamicObject(car_object[playerid]);
				
				return true;
			}*/
			/*static next_crated = 0;
			if(next_crated) next_crated = 0;
			for(new c = 0; c != MAX_CRAFT; c++)
			{
				if(DistancePointToPoint(craft_tool[edit_player_object[playerid]][craft_XYZ][0], craft_tool[edit_player_object[playerid]][craft_XYZ][1], craft_tool[edit_player_object[playerid]][craft_XYZ][2], 
				x, y, z) < 2.0 && (edit_player_object[playerid] == c)) continue;
				if(DistancePointToPoint(craft_tool[c][craft_XYZ][0], craft_tool[c][craft_XYZ][1], craft_tool[c][craft_XYZ][2], x, y, z) > 2.0) continue;
				next_crated = 1;
			}
			if(next_crated == 1) server_error(playerid, "В блези 2-х метров к другому нельзя ставить.");*/
			if(craft_tool[edit_player_object[playerid]][craft_owner] != users[playerid][u_id])
			{
				new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
				GetDynamicObjectPos(craft_tool[edit_player_object[playerid]][craft_object], oldX, oldY, oldZ);
				GetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], oldRotX, oldRotY, oldRotZ);
				SetDynamicObjectPos(craft_tool[edit_player_object[playerid]][craft_object], oldX, oldY, oldZ);
				SetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], oldRotX, oldRotY, oldRotZ);
				SetPlayerPos(playerid, craft_player_pos_xyz[playerid][0], craft_player_pos_xyz[playerid][1], craft_player_pos_xyz[playerid][2]);
				server_error(playerid, "Вы не владелец, редактирование отменено.");
				return true;
			}
			// if(craft_tool[edit_player_object[playerid]][craft_owner] != users[playerid][u_id]) server_error(playerid, "Вы не владелец, редактирование отменено.");
			SetDynamicObjectPos(craft_tool[edit_player_object[playerid]][craft_object], x, y, z);
			SetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], rx, ry, rz);
			SetPlayerPos(playerid, craft_player_pos_xyz[playerid][0], craft_player_pos_xyz[playerid][1], craft_player_pos_xyz[playerid][2]);
			craft_tool[edit_player_object[playerid]][craft_XYZ][0] = x;
			craft_tool[edit_player_object[playerid]][craft_XYZ][1] = y;
			craft_tool[edit_player_object[playerid]][craft_XYZ][2] = z;
			craft_tool[edit_player_object[playerid]][craft_rXrYrZ][0] = rx;
			craft_tool[edit_player_object[playerid]][craft_rXrYrZ][1] = ry;
			craft_tool[edit_player_object[playerid]][craft_rXrYrZ][2] = rz;
			static str_sql[356];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CRAFT_TOOLS" SET `craft_XYZ` = '%f,%f,%f', `craft_rXrYrZ` = '%f,%f,%f', `craft_date_use` = NOW() WHERE `craft_owner` = '%i' AND `craft_id` = '%i';",
			x, y, z, rx, ry, rz, craft_tool[edit_player_object[playerid]][craft_owner], craft_tool[edit_player_object[playerid]][craft_id]);
			m_query(str_sql);
			server_accept(playerid, "Позиция сохранена.");
		}
	case EDIT_RESPONSE_CANCEL: // Игрок отменил;
		{
			new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
			GetDynamicObjectPos(craft_tool[edit_player_object[playerid]][craft_object], oldX, oldY, oldZ);
			GetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], oldRotX, oldRotY, oldRotZ);
			SetDynamicObjectPos(craft_tool[edit_player_object[playerid]][craft_object], oldX, oldY, oldZ);
			SetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], oldRotX, oldRotY, oldRotZ);
			SetPlayerPos(playerid, craft_player_pos_xyz[playerid][0], craft_player_pos_xyz[playerid][1], craft_player_pos_xyz[playerid][2]);
			server_error(playerid, "Вы отменили редактирование.");
		}
	}
	return 1;
}
stock SaveCraftTools(idx)
{
	static str_sql[1200];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CRAFT_TOOLS" SET `craft_health` = '%i', `craft_pila_circular` = '%i', `craft_pila_circular_percent` = '%i', \
	`craft_pila_timber` = '%i', `craft_pila_progress` = '%i', `craft_pila_woords` = '%i', `craft_stol_one` = '%i', `craft_stol_two` = '%i', `craft_stol_progress` = '%i', `craft_stol_timer` = '%i', \
	`craft_stol_item` = '%i', `craft_pech_battery` = '%i', `craft_pech_battery_progress` = '%i', `craft_pech_progress` = '%i', `craft_pech_metal` = '%i', `craft_pech_unwrought` = '%i', \
	`craft_pech_timer` = '%i', `craft_date_use` = NOW() WHERE `craft_id` = '%i';", 
	craft_tool[idx][craft_health], craft_tool[idx][craft_pila_circular], craft_tool[idx][craft_pila_circular_percent], craft_tool[idx][craft_pila_timber], craft_tool[idx][craft_pila_progress], 
	craft_tool[idx][craft_pila_woords], craft_tool[idx][craft_stol_one], craft_tool[idx][craft_stol_two], craft_tool[idx][craft_stol_progress], craft_tool[idx][craft_stol_timer], 
	craft_tool[idx][craft_stol_item], craft_tool[idx][craft_pech_battery], craft_tool[idx][craft_pech_battery_progress], craft_tool[idx][craft_pech_progress], 
	craft_tool[idx][craft_pech_metal], craft_tool[idx][craft_pech_unwrought], craft_tool[idx][craft_pech_timer], craft_tool[idx][craft_id]);
	m_query(str_sql);
	return true;
}
@LoadingCraftTools();
@LoadingCraftTools()
{
	new time = GetTickCount(), rows;
	cache_get_row_count(rows);
	if(!rows) return print("["SQL_VER"][WARNING]: Ремесленные инструменты не найдены.");
	for(new idx = 1; idx <= rows; idx++)
	{
		cache_get_value_name_int(idx-1, "craft_id", craft_tool[idx][craft_id]);
		cache_get_value_name_int(idx-1, "craft_type", craft_tool[idx][craft_type]);
		cache_get_value_name_int(idx-1, "craft_owner", craft_tool[idx][craft_owner]);
		cache_get_value_name_int(idx-1, "craft_health", craft_tool[idx][craft_health]);

		switch(craft_tool[idx][craft_type])
		{
		case 1, 2: cache_get_value_name(idx-1, "craft_password", craft_tool[idx][craft_password]);
		case 3:
			{
				cache_get_value_name_int(idx-1, "craft_pila_circular", craft_tool[idx][craft_pila_circular]);
				cache_get_value_name_int(idx-1, "craft_pila_circular_percent", craft_tool[idx][craft_pila_circular_percent]);
				cache_get_value_name_int(idx-1, "craft_pila_timber", craft_tool[idx][craft_pila_timber]);
				cache_get_value_name_int(idx-1, "craft_pila_progress", craft_tool[idx][craft_pila_progress]);
				cache_get_value_name_int(idx-1, "craft_pila_woords", craft_tool[idx][craft_pila_woords]);
			}
		case 4:
			{
				cache_get_value_name_int(idx-1, "craft_stol_one", craft_tool[idx][craft_stol_one]);
				cache_get_value_name_int(idx-1, "craft_stol_two", craft_tool[idx][craft_stol_two]);
				cache_get_value_name_int(idx-1, "craft_stol_progress", craft_tool[idx][craft_stol_progress]);
				cache_get_value_name_int(idx-1, "craft_stol_timer", craft_tool[idx][craft_stol_timer]);
				cache_get_value_name_int(idx-1, "craft_stol_item", craft_tool[idx][craft_stol_item]);
			}
		case 5:
			{
				cache_get_value_name_int(idx-1, "craft_pech_battery", craft_tool[idx][craft_pech_battery]);
				cache_get_value_name_int(idx-1, "craft_pech_battery_progress", craft_tool[idx][craft_pech_battery_progress]);
				cache_get_value_name_int(idx-1, "craft_pech_progress", craft_tool[idx][craft_pech_progress]);
				cache_get_value_name_int(idx-1, "craft_pech_metal", craft_tool[idx][craft_pech_metal]);
				cache_get_value_name_int(idx-1, "craft_pech_unwrought", craft_tool[idx][craft_pech_unwrought]);
				cache_get_value_name_int(idx-1, "craft_pech_timer", craft_tool[idx][craft_pech_timer]);
			}
		}
		static coords_tool[128];
		cache_get_value_name(idx-1, "craft_XYZ", coords_tool);
		sscanf(coords_tool, "p<,>fff", craft_tool[idx][craft_XYZ][0], craft_tool[idx][craft_XYZ][1], craft_tool[idx][craft_XYZ][2]);
		
		static coords_tools[128];
		cache_get_value_name(idx-1, "craft_rXrYrZ", coords_tools);
		sscanf(coords_tools, "p<,>fff", craft_tool[idx][craft_rXrYrZ][0], craft_tool[idx][craft_rXrYrZ][1], craft_tool[idx][craft_rXrYrZ][2]);
		
		craft_tool[idx][craft_object] = CreateDynamicObject(craft_table[craft_tool[idx][craft_type]-1][craft_model], 
		craft_tool[idx][craft_XYZ][0], craft_tool[idx][craft_XYZ][1], craft_tool[idx][craft_XYZ][2],
		craft_tool[idx][craft_rXrYrZ][0], craft_tool[idx][craft_rXrYrZ][1], craft_tool[idx][craft_rXrYrZ][2]);

		switch(craft_tool[idx][craft_type])
		{
		case 1, 2: craft_tool[idx][craft_open] = 0;
		}
		
	}
	printf("["SQL_VER"][%04dМС]: Загружено ремесленных инструментов: %04d.", GetTickCount() - time, rows);
	return true;
}
@ExplosiveCraft(playerid, index_);
@ExplosiveCraft(playerid, index_)
{
	// CreateExplosion(craft_player_pos_xyz[playerid][0], craft_player_pos_xyz[playerid][1], craft_player_pos_xyz[playerid][2], 0, 5);
	CreateExplosion(craft_tool[index_][craft_XYZ][0], craft_tool[index_][craft_XYZ][1], craft_tool[index_][craft_XYZ][2], 0, 5);
	craft_tool[index_][craft_health] -= craft_table[craft_tool[index_][craft_type]-1][craft_damage];
	static str_sql[128];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CRAFT_TOOLS" SET `craft_health` = '%i' WHERE `craft_id` = '%i';", craft_tool[index_][craft_health], craft_tool[index_][craft_id]);
	m_query(str_sql);
	if(craft_tool[index_][craft_health] < 1)
	{	
		DestroyDynamicObject(craft_tool[index_][craft_object]);
		craft_tool[index_][craft_XYZ][0] = 0.0;
		craft_tool[index_][craft_XYZ][1] = 0.0;
		craft_tool[index_][craft_XYZ][2] = 0.0;
		m_format(str_sql, sizeof(str_sql), "DELETE FROM "TABLE_CRAFT_TOOLS" WHERE `craft_id` = '%i' LIMIT 1;", craft_tool[index_][craft_id]);
		m_query(str_sql);
	}
	return true;
}
stock market(playerid, status, list = 0, back = 0)
{
	switch(status)
	{
	case 0: // Покупка
		{
			static str_sql[256], str[156];
			global_string[0] = EOS;
			// if(temp[playerid][marketplace_list] > 2) list = temp[playerid][marketplace_list_id][temp[playerid][marketplace_list]-1];
			// m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MARKETPLACE" WHERE `mp_id` > '%i' AND `mp_owner` != '%i' AND `mp_status` = '1' LIMIT 15", list-1, users[playerid][u_id]);
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MARKETPLACE" WHERE `mp_id` > '%i' AND `mp_status` = '1' LIMIT 15", list-1, users[playerid][u_id]);
			new Cache:temp_sql = m_query(str_sql), r;
			cache_get_row_count(r);
			if(!r) return server_error(playerid, "На торговой площадке нет товаров.");
			// if(back != 1) temp[playerid][marketplace_list]++;
			strcat(global_string, "Предмет\tКол-во\tЦена\n");
			for(new idx = 1; idx < r+1; idx++)
			// for(new i = observation[playerid][observation_id]; i >= 0; i--)
			{
				cache_get_value_name_int(idx-1, "mp_id", marketplace[idx][mp_id]);
				// printf("%i", marketplace[idx][mp_id]);
				// if(idx == 1) temp[playerid][marketplace_lastid] = marketplace[idx][mp_id];
				// cache_get_value_name_int(idx-1, "mp_owner", marketplace[idx][mp_owner]);
				cache_get_value_name_int(idx-1, "mp_item", marketplace[idx][mp_item]);
				cache_get_value_name_int(idx-1, "mp_value", marketplace[idx][mp_value]);
				// cache_get_value_name_int(idx-1, "mp_status", marketplace[idx][mp_status]);
				cache_get_value_name_int(idx-1, "mp_price", marketplace[idx][mp_price]);
				temp[playerid][marketplace_items][idx-1] = marketplace[idx][mp_id];
				format(str, sizeof(str), "{fffff0}%s\t{cccccc}%i\t{33AA33}%i рублей\n",
				loots[marketplace[idx][mp_item]][loot_name], marketplace[idx][mp_value], marketplace[idx][mp_price]);
				strcat(global_string, str);
			}
			temp[playerid][marketplace_lastid] = marketplace[r][mp_id];
			switch(back)
			{
			case 0: 
				{
					// temp[playerid][marketplace_list_id][temp[playerid][marketplace_list]] = temp[playerid][marketplace_lastid];
					temp[playerid][marketplace_list]++;
				}
			case 1: temp[playerid][marketplace_list]--;
			}
			
			// temp[playerid][marketplace_last_list] = r;
			if(r > 14) strcat(global_string, "{cccccc}Следующая страница >>>\t \t \n");
			// if(temp[playerid][marketplace_list] > 1 && r > 14) strcat(global_string, "{cccccc}<<< Предыдущая страница\t \t ");
			// if(temp[playerid][marketplace_list] > 1) strcat(global_string, "{cccccc}<<< Предыдущая страница\t \t \n");
			format(str, sizeof(str), "Торговая площадка | {cccccc}Страница: %i", temp[playerid][marketplace_list]);
			show_dialog(playerid, d_marketplace_buy, DIALOG_STYLE_TABLIST_HEADERS, str, global_string, !"Ок", !"Назад");
			// SCMG(playerid, "Страница: %i, Запрос: %i, Запрос страницы: %i, Ласт Кнопка: %i.", temp[playerid][marketplace_list], temp[playerid][marketplace_lastid], temp[playerid][marketplace_list_id][temp[playerid][marketplace_list]-1], temp[playerid][marketplace_last_list]);
			cache_delete(temp_sql);
		}
	case 1: // Продажа
		{
			new str[96], str_name[40], item = 0, slots = 0;
			global_string[0] = EOS;
			strcat(global_string, "Кол-во\tНазвание\n");
			for(new z = 0; z < INVENTORY_USE; z++)
			{
				if(user_items[playerid][z][item_id] < 1) continue;
				if(getAmmoByItem(user_items[playerid][z][item_id]) != 0 && user_items[playerid][z][item_id] != 66)
				{
					if(getAmmoByItem(user_items[playerid][z][item_id]) > user_items[playerid][z][item_quantity]) continue;
				}
				item++;
				user_items[playerid][item-1][item_use_id] = user_items[playerid][z][item_id];
				user_items[playerid][item-1][item_use_value] = user_items[playerid][z][item_value];
				user_items[playerid][item-1][item_use_quantity] = user_items[playerid][z][item_quantity];

				if(user_items[playerid][item-1][item_use_quantity] < 1) format(str, sizeof(str), "%i\t%s\n",
					user_items[playerid][item-1][item_use_value], loots[user_items[playerid][item-1][item_use_id]][loot_name]);
				if(user_items[playerid][item-1][item_use_quantity] > 0) format(str, sizeof(str), "%i\t%s [%i]\n",
					user_items[playerid][item-1][item_use_value], loots[user_items[playerid][item-1][item_use_id]][loot_name],
					user_items[playerid][item-1][item_use_quantity]);
				strcat(global_string, str);
				slots += user_items[playerid][item-1][item_use_value];
			}
			users[playerid][u_slots] = slots;
			if(!item) return server_error(playerid, "Инвентарь пуст.");
			switch (users[playerid][u_backpack])
			{
			case 1: format(str_name, sizeof(str_name), "Очень маленький рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
			case 2: format(str_name, sizeof(str_name), "Маленький рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
			case 3: format(str_name, sizeof(str_name), "Средний рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
			case 4: format(str_name, sizeof(str_name), "Большой рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
			case 5: format(str_name, sizeof(str_name), "Очень большой рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
			}
			show_dialog(playerid, d_marketplace_to_sell, DIALOG_STYLE_TABLIST_HEADERS, "Торговая площадка | {cccccc}Продажа", global_string, !"Выбрать", !"Выход");
			/*
			new str[96], adm = 0;
			global_string[0] = EOS;
			strcat(global_string, "Название\tКол-во\n");
			for(new slot; slot < max_items; slot++) 
			{
				if (users[playerid][PlayerInv][slot] > 0 && slot != 0) 
				{
					adm ++;
					users[playerid][PlayerItem][adm-1] = slot;
					format(str, sizeof(str), "%s\t%i шт.\n", loots[slot][loot_name], users[playerid][PlayerInv][slot]);
					strcat(global_string, str);
				} 
			}
			if(!adm) return server_error(playerid, "У вас нет вещей, для выкладывания на торговую площадку необходима вещь.");
			show_dialog(playerid, d_marketplace_to_sell, DIALOG_STYLE_TABLIST_HEADERS, "Торговая площадка | {cccccc}Продажа", global_string, !"Выбрать", !"Выход");
			*/
		}
	case 2: // Мои предметы
		{
			static str_sql[256], str[156];
			global_string[0] = EOS;
			// if(temp[playerid][marketplace_list] > 2) list = temp[playerid][marketplace_list_id][temp[playerid][marketplace_list]-1];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MARKETPLACE" WHERE `mp_id` > '%i' AND `mp_owner` = '%i' AND `mp_status` = '1' LIMIT 15", list-1, users[playerid][u_id]);
			new Cache:temp_sql = m_query(str_sql), r;
			cache_get_row_count(r);
			if(!r) return server_error(playerid, "На торговой площадке у вас нет товаров.");
			// if(back != 1) temp[playerid][marketplace_list]++;
			strcat(global_string, "Предмет\tКол-во\tЦена\n");
			for(new idx = 1; idx < r+1; idx++)
			// for(new i = observation[playerid][observation_id]; i >= 0; i--)
			{
				cache_get_value_name_int(idx-1, "mp_id", marketplace[idx][mp_id]);
				// printf("%i", marketplace[idx][mp_id]);
				// if(idx == 1) temp[playerid][marketplace_lastid] = marketplace[idx][mp_id];
				// cache_get_value_name_int(idx-1, "mp_owner", marketplace[idx][mp_owner]);
				cache_get_value_name_int(idx-1, "mp_item", marketplace[idx][mp_item]);
				cache_get_value_name_int(idx-1, "mp_value", marketplace[idx][mp_value]);
				// cache_get_value_name_int(idx-1, "mp_status", marketplace[idx][mp_status]);
				cache_get_value_name_int(idx-1, "mp_price", marketplace[idx][mp_price]);
				temp[playerid][marketplace_items][idx-1] = marketplace[idx][mp_id];
				format(str, sizeof(str), "{fffff0}%s\t{cccccc}%i\t{33AA33}%i рублей\n", 
				loots[marketplace[idx][mp_item]][loot_name], marketplace[idx][mp_value], marketplace[idx][mp_price]);
				strcat(global_string, str);
			}
			temp[playerid][marketplace_lastid] = marketplace[r][mp_id];
			switch(back)
			{
			case 0: 
				{
					// temp[playerid][marketplace_list_id][temp[playerid][marketplace_list]] = temp[playerid][marketplace_lastid];
					temp[playerid][marketplace_list]++;
				}
			case 1: temp[playerid][marketplace_list]--;
			}
			
			// temp[playerid][marketplace_last_list] = r;
			if(r > 14) strcat(global_string, "{cccccc}Следующая страница >>>\t \t \n");
			// if(temp[playerid][marketplace_list] > 1 && r > 14) strcat(global_string, "{cccccc}<<< Предыдущая страница\t \t ");
			// if(temp[playerid][marketplace_list] > 1) strcat(global_string, "{cccccc}<<< Предыдущая страница\t \t \n");
			format(str, sizeof(str), "Торговая площадка | {cccccc}Страница: %i", temp[playerid][marketplace_list]);
			show_dialog(playerid, d_marketplace_myitem, DIALOG_STYLE_TABLIST_HEADERS, str, global_string, !"Ок", !"Назад");
			// SCMG(playerid, "Страница: %i, Запрос: %i, Запрос страницы: %i, Ласт Кнопка: %i.", temp[playerid][marketplace_list], temp[playerid][marketplace_lastid], temp[playerid][marketplace_list_id][temp[playerid][marketplace_list]-1], temp[playerid][marketplace_last_list]);
			cache_delete(temp_sql);
		}
	}
	return true;
}