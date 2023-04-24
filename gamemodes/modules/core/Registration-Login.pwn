/*
    Описание: Регистрация и авторизация;
    Автор: zummore;
*/
#if defined _register_and_login_included
	#endinput
#endif
#define _register_and_logRL_included

@OnPlayerCheck(playerid);
@OnPlayerCheck(playerid)
{
	//PlayAudioStreamForPlayer(playerid, "http://files.defiant-blood.com/sound/defiant_sound.mp3");
	SPP ( playerid, 381.5655, -2043.4766, 4.8952, 180.0, playerid+50 );
	TogglePlayerControllable ( playerid, false );
	TogglePlayerSpectating ( playerid, true );
	
	InterpolateCameraPos ( playerid, 262.942687, 348.047546, 1410.336914, 262.942687, 348.047546, 1410.336914, 1000 );
	InterpolateCameraLookAt ( playerid, 264.451080, 352.803039, 1410.005126, 264.451080, 352.803039, 1410.005126, 1000 );
	
	new r;
	cache_get_row_count ( r );
	if ( !r ) 
	{
		for ( new i = 0; i < 10; i ++ )
			SendClientMessage ( playerid, -1, "" );
		
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 5 ], TranslateText ( "~y~Пароль" ) );
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 6 ], TranslateText ( "Не заполнено" ) );
		
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 7 ], TranslateText ( "~y~E-mail" ) );
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 9 ], TranslateText ( "Не заполнено" ) );
		
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 11 ], TranslateText ( "~y~Промокод" ) );
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 12 ], TranslateText ( "Не_заполнено" ) );
		
		for ( new i = 0; i < 13; i ++ )
			PlayerTextDrawShow ( playerid, regiser__menu [ playerid ] [ i ] );
		
		SelectTextDraw ( playerid, 0xA52A2AFF );
		//RegisterDialog ( playerid, "password", 0 );
	}
	else 
		LoginDialog ( playerid, 0 );
	
	return 1;
}
public OnPlayerConnect(playerid)
{
	if ( IsPlayerNPC ( playerid ) ) 
		return 1;
	
	GetPlayerName ( playerid, users [ playerid ] [ u_name ], MAX_PLAYER_NAME );
	new mysql_format_string [ (57+1)+MAX_PLAYER_NAME ];
	mysql_format ( database, mysql_format_string, sizeof ( mysql_format_string ), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1", users [ playerid ] [ u_name ] );
	mysql_tquery ( database, mysql_format_string, "@OnPlayerCheck", "i", playerid );

	#if defined RL_OnPlayerConnect
		return RL_OnPlayerConnect(playerid);
	#else
		return true;
	#endif
}
#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect RL_OnPlayerConnect

#if defined RL_OnPlayerConnect
    forward RL_OnPlayerConnect(playerid);
#endif

stock LoginDialog(playerid, value) //Авторизация
{
	switch(value)
	{
	case 0: show_dialog(playerid, d_login, DIALOG_STYLE_PASSWORD, "Авторизация", "\n{fffff0}Добро пожаловать на {ADD8E6}"FULL_NAME"\n{fffff0}Ваш аккаунт {90EE90}зарегистрирован {fffff0}на нашем сервере, для авторизации введите свой пароль.\n\n", !"Войти", !"Отмена");
	case 1:
		{
			new format_string[(212+1)];
			format(format_string, sizeof(format_string), "\n{CD5C5C}ОШИБКА: {fffff0}Введен неверный пароль, осталось попыток: {CD5C5C}%i/3\n\n{33AA33}- {fffff0}Пароль должен состоять из латинских букв, а так же цифр;\n{33AA33}- {fffff0}Длина пароля от 6-ти до 35-ти символов;\n\n", GetPVarInt(playerid, "LOGIN_PASSWORD"));
			show_dialog(playerid, d_login, DIALOG_STYLE_PASSWORD, "Авторизация", format_string, !"Войти", !"Отмена");
		}
	}
	return true;
}

Dialog:d_register_password ( params_dialog )
{
	if ( !response ) 
		return 1;
	
	for ( new i = strlen ( inputtext ); i != 0; --i )
	{
		switch ( inputtext [ i ] )
		{
			case 'А'..'Я', 'а'..'я', ' ', '=':
			{
				RegisterDialog ( playerid, "password" );
				SEM ( playerid, "Испрольуйте только латинские буквы и цифры.");
				return 1;
			}
		}
	}
	
	if ( strlen ( inputtext ) < 6 || strlen ( inputtext ) > 35 )
	{
		RegisterDialog ( playerid, "password" );
		SEM ( playerid, "Пароль должен содержать от 6 до 35 символов." );
		return 1;
	}
	
	if ( !GetPasswordLevel ( inputtext ) )
	{
		RegisterDialog ( playerid, "password" );
		SEM ( playerid, "Вы ввели слишком легкий пароль." );
		return 1;
	}
	
	format ( users_register [ playerid ] [ 0 ], 65, inputtext );
	PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 6 ], TranslateText ( "~g~Введено" ) );
	temp [ playerid ] [ temp_register ] [ 0 ] = 1;
	return 1;
}

Dialog:d_register_email ( params_dialog )
{
	if ( !response ) 
		return 1;
	
	if ( strlen ( inputtext ) < 6 || strlen ( inputtext ) > 45 || !IsValidEMail ( inputtext ) ) 
	{
		SEM ( playerid, "Введите действительный e-mail адрес!" );
		RegisterDialog ( playerid, "email" );
		return 1;
	}		
	
	new mysql_format_string [ (85+1)+45 ];
	m_format ( mysql_format_string, sizeof ( mysql_format_string ), "SELECT * FROM "TABLE_USERS" WHERE `u_email` = '%s' AND `u_email_status` = '1' LIMIT 1", inputtext );
	
	new Cache: temp_mysql = m_query ( mysql_format_string ), 
		r;
	
	cache_get_row_count ( r );
	
	if ( !r )
	{
		format ( users_register [ playerid ] [ 1 ], 65, inputtext );
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 9 ], TranslateText ( "~g~Введено" ) );
		temp [ playerid ] [ temp_register ] [ 1 ] = 1;
	}
	else
	{
		SEM ( playerid, "Данный e-mail уже кто-то использует" );
		RegisterDialog ( playerid, "email" );
	}
	
	cache_delete ( temp_mysql );
	return 1;
}

Dialog:d_register_friend ( params_dialog )
{
	if ( !response ) 
	{
		temp [ playerid ] [ temp_register ] [ 2 ] = 1;
		format ( users_register [ playerid ] [ 3 ], MAX_PLAYER_NAME, "#SKIPPED" );
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 12 ], TranslateText ( "~g~Введено" ) );
		return 1;
	}
	
	if ( !strlen ( inputtext ) || strlen ( inputtext ) < 1 || strlen ( inputtext ) > MAX_PLAYER_NAME ) 
		return RegisterDialog ( playerid, "friend" );
	
	new mysql_format_string [ (87+1) + 45 ];
	m_format ( mysql_format_string, sizeof ( mysql_format_string ), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1", inputtext );
	
	new Cache: temp_mysql = m_query ( mysql_format_string), 
		r;
	
	cache_get_row_count ( r );
	
	if ( r )
	{
		temp [ playerid ] [ temp_register ] [ 2 ] = 1;
		format ( users_register [ playerid ] [ 3 ], MAX_PLAYER_NAME, inputtext );
		PlayerTextDrawSetString ( playerid, regiser__menu [ playerid ] [ 12 ], TranslateText ( "~g~Введено" ) );
	}
	else 
	{
		RegisterDialog ( playerid, "friend" );
		SEM ( playerid, "Промокод и/или игрок %s не найден.", inputtext );
	}
	
	cache_delete ( temp_mysql );
	return 1;
}

	/*
		
	case d_register_email_question:
		{
			if(!response) return RegisterDialog(playerid, "friend", 0);
			// message_to_email(playerid, users_register[playerid][1]);
			EmailMessage(playerid, users_register[playerid][1], "Код для подтверждения почты");
			RegisterDialog(playerid, "email", 4);
		}
	case d_register_email_confirmation:
		{
			if(!response) return RegisterDialog(playerid, "email", 0);
			if(strcmp(inputtext, temp[playerid][temp_email_code])) return RegisterDialog(playerid, "email", 5);
			// if(strval(inputtext) != email_code[playerid]) return RegisterDialog(playerid, "email", 5);
			users_register[playerid][2][0] = 1;
			RegisterDialog(playerid, "friend", 0);
			server_accept(playerid, "Вы подтвердили свой адрес электронной почты.");
		}
	*/

stock RegisterDialog ( playerid, const name[] )
{
	if ( !strcmp ( name, "password", false ) )
	{
		Dialog_Show ( playerid, d_register_password, DIALOG_STYLE_INPUT, "Регистрация | {ADD8E6}Пароль", "\n{fffff0}Добро пожаловать на {ADD8E6}"FULL_NAME"{fffff0}.\nВаш аккаунт {5F9EA0}не зарегистрирован {fffff0}на нашем сервере, для продолжения регистрации придумайте пароль\n\n{5F9EA0}- {fffff0}Пароль должен состоять из латинских букв, а так же цифр;\n{5F9EA0}- {fffff0}Пароль чуствителен к регистру;\n{5F9EA0}- {fffff0}Длина пароля от 6-ти до 35-ти символов;\n\n", "Готово", "Отмена");
	}
	
	if ( !strcmp ( name, "email", false ) )
	{
		Dialog_Show ( playerid, d_register_email, DIALOG_STYLE_INPUT, "Регистрация | {ADD8E6}Электронный адрес почты", "\n{fffff0}Введите ваш адрес электронной почты.\nПривязка своей электронной почты поможет вам в восстановлении и защитите аккаунта.\n\n{5F9EA0}Пример: {fffff0}name@gmail.com, name@yandex.ru\n\n", "Готово", "Отмена" );
	}
	
	if ( !strcmp ( name, "friend", false ) )
	{
		Dialog_Show ( playerid, d_register_friend, DIALOG_STYLE_INPUT, "Регистрация | {ADD8E6}Приглашение", "\n{fffff0}Введите ник друга пригласившего вас на сервер, или промокод для старта, иначе нажмите {ADD8E6}'Пропустить'\n\n", "Далее", "Пропустить");
	}
	/*
	users_register[playerid][2][1] = 1;
	temp [ playerid ] [ temp_register ] [ 0 ] =
	temp [ playerid ] [ temp_register ] [ 1 ] =
	temp [ playerid ] [ temp_register ] [ 2 ] = 0;
	if(!strcmp(name, "friend", false))
	{
		switch(value)
		{
		case 0: show_dialog(playerid, d_register_friend, DIALOG_STYLE_INPUT, "Регистрация | {008B8B}Приглашение", !"\n{fffff0}Введите ник друга пригласившего вас на сервер, иначе нажмите 'Пропустить'\n\n", !"Далее", !"Пропустить");
		case 1: 
			{
				new format_string[(145+1)+MAX_PLAYER_NAME];
				format(format_string, sizeof(format_string), "\n{fffff0}Аккаунт с ником '{cccccc}%s{fffff0}' не зарегистрирован!\n\nВведите ник друга пригласившего вас на сервер, иначе нажмите 'Пропустить'\n\n", string);
				show_dialog(playerid, d_register_friend, DIALOG_STYLE_INPUT, "Регистрация | {008B8B}Приглашение", format_string, !"Далее", !"Пропустить");
			}
		}
	}
	if(!strcmp(name, "floor", false)) show_dialog(playerid, d_register_floor, DIALOG_STYLE_MSGBOX, "Регистрация | {008B8B}Пол персонажа", !"{fffff0}\nКакого пола будет ваш персонаж:\n\n", !"Мужчина", !"Женщина");
	if(!strcmp(name, "info", false)) show_dialog(playerid, d_register_info, DIALOG_STYLE_LIST, "Регистрация | {008B8B}Опрос", !"{ADD8E6}Откуда вы о нас узнали?\n{33AA33}-{fffff0} Вкладка 'Hosted'\n{33AA33}-{fffff0} От друзей\n{33AA33}-{fffff0} На порталах\n{33AA33}-{fffff0} В поисковике\n{33AA33}-{fffff0} Другое", !"Выбор", !"");
	*/
	return 1;
}
stock users_registration(playerid)
{
	new mysql_format_string[(241+1)+MAX_PLAYER_NAME+(45*2)+18+20];
	m_format(mysql_format_string, sizeof(mysql_format_string), "INSERT INTO "TABLE_USERS" (`u_name`, `u_password`, `u_date_registration`, `u_ip_registration`, `u_email`, `u_email_status`, `u_friend`, `u_gender`, `u_adverting`) VALUES \
	('%s', MD5('%e'), NOW(), '%s', '%s', '%i', '%s', '%i', '%i');", 
	users[playerid][u_name], users_register[playerid][0], GetIp(playerid), users_register[playerid][1], users_register[playerid][2][0], users_register[playerid][3], users_register[playerid][2][1], users_register[playerid][2][2]);
	m_query(mysql_format_string);
	m_format(mysql_format_string, sizeof(mysql_format_string), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' AND `u_password` = MD5('%e') LIMIT 1", users[playerid][u_name], users_register[playerid][0]);
	new Cache: temp_mysql = m_query(mysql_format_string), r;
	cache_get_row_count(r);
	if(r)
	{
		SetPVarInt(playerid, "REGISTRATION_NEWMEMBER", 1);
		m_format(mysql_format_string, sizeof(mysql_format_string), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' AND `u_password` = MD5('%e') LIMIT 1", users[playerid][u_name], users_register[playerid][0]);
		m_tquery(mysql_format_string, "@users_login", "i", playerid);
	}
	else TKICK(playerid, "При окончании регистрации аккаунта произошла ошибка, попробуйте позже!");
	cache_delete(temp_mysql);
	return true;
}
@users_login(playerid);
@users_login(playerid)
{
	new r;
	cache_get_row_count(r);
	if(!r)
	{
		if(GetPVarInt(playerid, "LOGIN_PASSWORD") == 3)
		{
			DeletePVar(playerid, "LOGIN_PASSWORD");
			TKICK(playerid, "Вы кикнуты с сервера за неверный ввод пароля. Пожалуйста попробуйте позже!");
			return true;
		}
		SetPVarInt(playerid, "LOGIN_PASSWORD", GetPVarInt(playerid, "LOGIN_PASSWORD") + 1);
		LoginDialog(playerid, 1);
		return true;
	}
	DeletePVar(playerid, "LOGIN_PASSWORD");
	ClearChatForPlayer(playerid);
	static str[156];
	m_format(str, sizeof(str), "SELECT * FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW() LIMIT 1", users[playerid][u_name]);
	m_tquery(str, "@CheckPlayerBan", "i", playerid);
	cache_get_value_name_int(0, "u_id", users[playerid][u_id]);
	cache_get_value_name(0, "u_name", users[playerid][u_name], MAX_PLAYER_NAME);
	cache_get_value_name(0, "u_email", users[playerid][u_email], 45);
	cache_get_value_name_int(0, "u_email_status", users[playerid][u_email_status]);
	cache_get_value_name(0, "u_ip_registration", users[playerid][u_ip_registration], 18);
	cache_get_value_name(0, "u_date_registration", users[playerid][u_date_registration], 20);
	cache_get_value_name_int(0, "u_gender", users[playerid][u_gender]);
	cache_get_value_name(0, "u_friend", users[playerid][u_friend], MAX_PLAYER_NAME);
	cache_get_value_name_int(0, "u_adverting", users[playerid][u_adverting]);
	cache_get_value_name_int(0, "u_skin", users[playerid][u_skin]);
	cache_get_value_name_int(0, "u_newgame", users[playerid][u_newgame]);
	cache_get_value_name_int(0, "u_lifetime", users[playerid][u_lifetime]);
	cache_get_value_name_int(0, "u_lifegame", users[playerid][u_lifegame]);
	cache_get_value_name_int(0, "u_money", users[playerid][u_money]);
	cache_get_value_name_int(0, "u_vip_time", users[playerid][u_vip_time]);
	cache_get_value_name_int(0, "u_thirst", users[playerid][u_thirst]);
	cache_get_value_name_int(0, "u_hunger", users[playerid][u_hunger]);
	cache_get_value_name_int(0, "u_backpack", users[playerid][u_backpack]);
	cache_get_value_name_int(0, "u_karma", users[playerid][u_karma]);
	// cache_get_value_name_int(0, "STD", users[playerid][pSTD]);
	cache_get_value_name_int(0, "u_death", users[playerid][u_death]);
	cache_get_value_name_int(0, "u_loot", users[playerid][u_loot]);
	cache_get_value_name_int(0, "u_slots", users[playerid][u_slots]);
	cache_get_value_name_int(0, "u_mute", users[playerid][u_mute]);
	cache_get_value_name_int(0, "u_humanity", users[playerid][u_humanity]);
	cache_get_value_name_int(0, "u_clan", users[playerid][u_clan]);
	cache_get_value_name_int(0, "u_clan_rank", users[playerid][u_clan_rank]);
	cache_get_value_name_int(0, "u_language", users[playerid][u_language]);
	cache_get_value_name_int(0, "u_score", users[playerid][u_score]);
	cache_get_value_name_int(0, "u_donate_spawn", users[playerid][u_donate_spawn]);
	cache_get_value_name_int(0, "u_donate_skin", users[playerid][u_donate_skin]);
	cache_get_value_name_int(0, "u_eat_food", users[playerid][u_eat_food]);
	cache_get_value_name_int(0, "u_helmet", users[playerid][u_helmet]);
	cache_get_value_name_int(0, "u_setname", users[playerid][u_setname]);
	cache_get_value_name_int(0, "u_infected", users[playerid][u_infected]);

	cache_get_value_name_int ( 0, "user_group", users [ playerid ] [ user_group ] );

	cache_get_value_name(0, "u_googleauth", users[playerid][u_googleauth], 17);
	cache_get_value_name(0, "u_code", users[playerid][u_code], 8);

	cache_get_value_name_float(0, "u_health", users[playerid][u_health]);
	cache_get_value_name_float(0, "u_armour", users[playerid][u_armour]);
	cache_get_value_name_float(0, "u_temperature", users[playerid][u_temperature]);
	cache_get_value_name(0, "u_reward", temp[playerid][temp_text], MAX_PLAYER_NAME);
	sscanf(temp[playerid][temp_text], "p<,>iiiiiiiiii", users[playerid][u_reward][0], users[playerid][u_reward][1], users[playerid][u_reward][2], users[playerid][u_reward][3], users[playerid][u_reward][4], users[playerid][u_reward][5], users[playerid][u_reward][6], users[playerid][u_reward][7], users[playerid][u_reward][8], users[playerid][u_reward][9]);
	cache_get_value_name(0, "u_pack", temp[playerid][temp_text], MAX_PLAYER_NAME);
	sscanf(temp[playerid][temp_text], "p<,>iiiii", users[playerid][u_pack][0], users[playerid][u_pack][1], users[playerid][u_pack][2], users[playerid][u_pack][3], users[playerid][u_pack][4]);
	cache_get_value_name(0, "u_achievement", temp[playerid][temp_text], 65);
	sscanf(temp[playerid][temp_text], "p<,>iiiiiiiiiiiii", users[playerid][u_achievement][0], users[playerid][u_achievement][1], users[playerid][u_achievement][2], users[playerid][u_achievement][3], users[playerid][u_achievement][4], users[playerid][u_achievement][5], 
	users[playerid][u_achievement][6], users[playerid][u_achievement][7], users[playerid][u_achievement][8], users[playerid][u_achievement][9], users[playerid][u_achievement][10], users[playerid][u_achievement][11], users[playerid][u_achievement][12]);
	cache_get_value_name(0, "u_settings", temp[playerid][temp_text], 32);
	sscanf(temp[playerid][temp_text], "p<,>iiiiiiii", users[playerid][u_settings][0], users[playerid][u_settings][1], users[playerid][u_settings][2], users[playerid][u_settings][3], users[playerid][u_settings][4], users[playerid][u_settings][5], users[playerid][u_settings][6], users[playerid][u_settings][7]);
	cache_get_value_name(0, "u_settings_vip", temp[playerid][temp_text], 32);
	sscanf(temp[playerid][temp_text], "p<,>iiii", users[playerid][u_settings_vip][0], users[playerid][u_settings_vip][1], users[playerid][u_settings_vip][2], users[playerid][u_settings_vip][3]);
	cache_get_value_name(0, "u_damage", temp[playerid][temp_text], 11);
	sscanf(temp[playerid][temp_text], "p<,>ii", users[playerid][u_damage][0], users[playerid][u_damage][1]);
	cache_get_value_name(0, "u_kill", temp[playerid][temp_text], MAX_PLAYER_NAME);
	sscanf(temp[playerid][temp_text], "p<,>ii", users[playerid][u_kill][0], users[playerid][u_kill][1]);
	cache_get_value_name(0, "u_spawn_xyzwi", temp[playerid][temp_text], 65);
	sscanf(temp[playerid][temp_text], "p<,>ffffii", users[playerid][u_spawn_xyz][0], users[playerid][u_spawn_xyz][1], users[playerid][u_spawn_xyz][2], users[playerid][u_spawn_xyz][3], users[playerid][u_spawn_wi][0], users[playerid][u_spawn_wi][1]);
	cache_get_value_name(0, "u_donate_spawn_xyzwi", temp[playerid][temp_text], 65);
	sscanf(temp[playerid][temp_text], "p<,>ffffii", users[playerid][u_donate_spawn_xyzf][0], users[playerid][u_donate_spawn_xyzf][1], users[playerid][u_donate_spawn_xyzf][2], users[playerid][u_donate_spawn_xyzf][3], users[playerid][u_donate_spawn_wi][0], users[playerid][u_donate_spawn_wi][1]);
	if(users[playerid][u_health] < 10) users[playerid][u_health] = 10;
	LoadPlayerInventory(playerid);
	if(strcmp(users[playerid][u_googleauth], "NoGoogleAuth", false))
	{
		show_dialog(playerid, d_googleauth, DIALOG_STYLE_INPUT, !"Google Authenticator", "\n{ffffff}Для продолжения авторизации введите 6-ти значный код с {33AA33}Google Authenticator'a.\n", !"Ок", !"Отмена");
		return true;
	}
	else if(strcmp (users[playerid][u_code], "NoCode", false))
	{
		for(new i = 0, cindex = 0; i < sizeof(Captcha); i++)
		{
			if(i == 0)
			{
				Captcha[i] = CreatePlayerTextDraw(playerid, 321.0, 80.0, "PIN-CODE");
				PlayerTextDrawUseBox(playerid, Captcha[i], 1);
				PlayerTextDrawBoxColor(playerid, Captcha[i], 0xFFFFFF00);
				PlayerTextDrawTextSize(playerid, Captcha[i], 800.0, 200.0);
			}
			if(i == 1)
			{
				Captcha[i] = CreatePlayerTextDraw(playerid, 321.0, 303.0, "_");
				PlayerTextDrawUseBox(playerid, Captcha[i], 1);
				PlayerTextDrawBoxColor(playerid, Captcha[i], 0xFFFFFF00);
				PlayerTextDrawTextSize(playerid, Captcha[i], 800.0, 200.0);
			}
			if(i > 1)
			{
				new string[128];
				format(string, sizeof(string), "%c", TextArray[i - 2]);
				if(i >= 2) Captcha[i] = CreatePlayerTextDraw(playerid, 280.0 + (41.0 * cindex), 130.0, string);
				if(i == 5) cindex = 0, Captcha[i] = CreatePlayerTextDraw(playerid, 280.0 + (41.0 * cindex), 171.0, string);
				if(i > 5) Captcha[i] = CreatePlayerTextDraw(playerid, 280.0 + (41.0 * cindex), 171.0, string);
				if(i == 8) cindex = 0, Captcha[i] = CreatePlayerTextDraw(playerid, 280.0 + (41.0 * cindex), 212.0, string);
				if(i > 8) Captcha[i] = CreatePlayerTextDraw(playerid, 280.0 + (41.0 * cindex), 212.0, string);
				if(i == 11) cindex = 0, Captcha[i] = CreatePlayerTextDraw(playerid, 321.5 + (41.0 * cindex), 253.0, string);
				if(i > 11) Captcha[i] = CreatePlayerTextDraw(playerid, 321.5 + (41.0 * cindex), 253.0, string);
				PlayerTextDrawUseBox(playerid, Captcha[i], 1);
				PlayerTextDrawBoxColor(playerid, Captcha[i], 0xFFFFFF00);
				PlayerTextDrawTextSize(playerid, Captcha[i], 29.0, 29.0);
				PlayerTextDrawSetSelectable(playerid, Captcha[i], 1);
				cindex++;
			}
			PlayerTextDrawLetterSize(playerid, Captcha[i], 0.50, 2.5);
			PlayerTextDrawAlignment(playerid, Captcha[i], 2);
			PlayerTextDrawSetOutline(playerid, Captcha[i], 1);
			PlayerTextDrawShow(playerid, Captcha[i]);
			SelectTextDraw(playerid, 0xA6A6A6AA);
		}
		return true;
	}
	else LoadPlayer(playerid);
	return true;
}
stock LoadPlayer(playerid)
{
	// StopAudioStreamForPlayer(playerid); 
	new mysql_format_string[128];
	foreach(Player, i)
	{
		if(!admin[i][admin_level]) continue;
		if(!admin[i][admin_settings][0]) continue;
		format(mysql_format_string, sizeof(mysql_format_string), "[A]{AFEEEE}[CONNECT] {FFFFE0}%s(%i) авторизовался. IP: %s, R-IP: %s.", users[playerid][u_name], playerid, GetIp(playerid), users[playerid][u_ip_registration]);
		SendClientMessage(i, 0xA52A2AFF, mysql_format_string);
	}
	SSU ( playerid, "Помощь по игре {A52A2A}/help" );
	SSU ( playerid, "Приятного времяпрепровождения на нашем сервере!" );
	m_format(mysql_format_string, sizeof(mysql_format_string), "UPDATE "TABLE_USERS" SET `u_ip` = '%s', `u_date` = 'NOW()' WHERE `u_name` = '%s'", GetIp(playerid), users[playerid][u_name]);
	m_query(mysql_format_string);
	AddUserLogin(playerid, 1);
	PreloadAllAnimLibs(playerid);
	// new format_string[(29+1)+(MAX_PLAYER_NAME*2)];
	// if(!strcmp("NoNameAbbreviatur", clan[users[playerid][u_clan]][c_name_abbr]))  format(format_string, sizeof(format_string), " ", users[playerid][u_name], playerid);
	// else format(format_string, sizeof(format_string), "{AFEEEE}%s", , users[playerid][u_name], playerid);
	users_nickname[playerid] = Create3DTextLabel(clan[users[playerid][u_clan]][c_name_abbr], 0xAFEEEEFF, 0.0, 0.0, 0.0, 20.0, 0, 1);
	Attach3DTextLabelToPlayer(users_nickname[playerid], playerid, 0.0, 0.0, 0.0);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 0);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1000);
	// SetSpawnInfo(playerid, 0, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
	StopAudioStreamForPlayer(playerid);  
	TogglePlayerSpectating(playerid, false);
	TogglePlayerControllable(playerid, true);
	LoadingForUser(playerid, 1);
	temp[playerid][temp_login] = true;
	
	if ( users [ playerid ] [ user_group ] == 0 )
		return Dialog_Show ( playerid, dialog_player_group_, DIALOG_STYLE_LIST, "Регистрация | {ADD8E6}Выбор стороны", "{ADD8E6}- {fffff0}ВС РФ\n{ADD8E6}- {fffff0}ВСУ", "Далее", !"" );
	
	SpawnPlayer(playerid);
	return true;
}