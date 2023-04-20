public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
	if(strfind(inputtext, "%", true) != -1) return true;
	for(new idr;idr < strlen(inputtext);idr ++) {
		if(inputtext[idr] == '%') inputtext[idr] = '#';
		else if(inputtext[idr] == '{' && inputtext[idr+7] == '}') strdel(inputtext,idr,idr+8); }
	/*if ( temp [ playerid ] [ use_dialog ] != dialogid )
	{
		temp [ playerid ] [ use_dialog ] = -1 ;
		return 1;
	}
	temp [ playerid ] [ use_dialog ] = -1 ;*/
	switch ( dialogid )
	{
	case d_none: return true;
	/*case d_register:
	    {
            if(!response) return true;
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
				case '�'..'�', '�'..'�', ' ', '=':
						return server_error(playerid, "����������� ������ ��������� ����� � �����.");
			}
			if(strlen(inputtext) < 6 || strlen(inputtext) > 32) return server_error(playerid, "������ ������ ��������� �� 6 �� 32 ��������.");
            SetPVarString(playerid, "RegPassword", inputtext);
            new string[40];
			strmid(string, "--------------------------------", 0, strlen(inputtext), sizeof(string));
            PlayerTextDrawSetString(playerid, PlayerText: login_PTD[playerid][2], string);
		}*/
	case d_login:
		{
            if(!response) return TKICK(playerid, "�� ���������� �� �����������, ����������� � ����.");
			if(!strlen(inputtext)) return LoginDialog(playerid, 0);
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
			case '�'..'�', '�'..'�', ' ':
				return LoginDialog(playerid, 1);
			}
			if(strfind(inputtext, "'", true) != -1 || strfind(inputtext, ",", true) != -1) return LoginDialog(playerid, 1);
			if(strlen(inputtext) < 3 || strlen(inputtext) > 35) return LoginDialog(playerid, 1);
			new mysql_format_string[(86+1)+35+MAX_PLAYER_NAME];
			m_format(mysql_format_string, sizeof(mysql_format_string), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' AND `u_password` = MD5('%e') LIMIT 1", users[playerid][u_name], inputtext);
			m_tquery(mysql_format_string, "@users_login", "i", playerid);
		}
	case d_register_info:
		{
			if(!response) return RegisterDialog(playerid, "info");
			switch(listitem)
			{
			case 0: return RegisterDialog(playerid, "info");
			case 1: users_register[playerid][2][2] = 1;
			case 2: users_register[playerid][2][2] = 2;
			case 3: users_register[playerid][2][2] = 3;
			case 4: users_register[playerid][2][2] = 4;
			case 5: users_register[playerid][2][2] = 5;
			}
			users_registration(playerid);
		}
	case d_admin_login:
		{
			if(!response) return true;
			switch(GetPVarInt(playerid, "AdminLogin"))
			{
			case 1:
				{
					if(!CheckOfAdmin(playerid)) return server_error(playerid, "������ ���������!");
					for(new i = strlen(inputtext); i != 0; --i)
					switch(inputtext[i])
					{
						case '�'..'�', '�'..'�', ' ', '=':
								return show_dialog(playerid, d_admin_login, DIALOG_STYLE_INPUT, !"���� � ���������������� �������", !"���������� ������\n\n{33AA33}- {FFFFFF}������ ������ �������� �� ��������� ����, � ��� �� ����\n{33AA33}- {FFFFFF}����� ������ �� 6-�� �� 32-� ��������", !"�����", !"������");
					}
					if(strlen(inputtext) < 6 || strlen(inputtext) > 32) return show_dialog(playerid, d_admin_login, DIALOG_STYLE_INPUT, !"���� � ���������������� �������", !"���������� ������\n\n{33AA33}- {FFFFFF}������ ������ �������� �� ��������� ����, � ��� �� ����\n{33AA33}- {FFFFFF}����� ������ �� 6-�� �� 32-� ��������", !"�����", !"������");
					static str_sql[156];
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_password` = MD5('%e') WHERE `u_a_name` = '%s'", inputtext, users[playerid][u_name]);
					m_query(str_sql);
					server_error(playerid, "�� ������� ������������ ���������������� ������.");
					server_error(playerid, "������ ������������� � ���, ������� ������ �� ���������������� ������.");
					callcmd::alogin(playerid);
					// cache_delete(temp_sql);
				}
			case 2:
				{
					new str_sql[196], message_admin[96];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' AND `u_a_password` = MD5('%e') LIMIT 1", users[playerid][u_name], inputtext);
					new Cache:temp_sql = m_query(str_sql), r;
					cache_get_row_count(r);
					if(!r)
					{
						if(GetPVarInt(playerid, "AdminLoginPass") == 3)
						{
							DeletePVar(playerid, "AdminLoginPass");
							TKICK(playerid, "�� ������� � ������� �� �������� ���� ������.");
							return true;
						}
						SetPVarInt(playerid, "AdminLoginPass", GetPVarInt(playerid, "AdminLoginPass") + 1);
						server_error(playerid, "�� ����� �� ������ ������ �� ���������������� ������.");
						show_dialog(playerid, d_admin_login, DIALOG_STYLE_PASSWORD, !"���� � ���������������� �������", !"������� ������ �� ���������������� ������\n\n{33AA33}- {FFFFFF}������ ������ �������� �� ��������� ����, � ��� �� ����\n{33AA33}- {FFFFFF}����� ������ �� 6-�� �� 32-� ��������", !"�����", !"������");
						return true;
					}
					cache_get_value_name_int(0, "admin_level", admin[playerid][admin_level]);
					cache_get_value_name(0, "admin_settings", temp[playerid][temp_text], 30);
					sscanf(temp[playerid][temp_text], "p<,>iiiiiiiiiiiiiii", admin[playerid][admin_settings][0], admin[playerid][admin_settings][1], admin[playerid][admin_settings][2], 
					admin[playerid][admin_settings][3], admin[playerid][admin_settings][4], admin[playerid][admin_settings][5], admin[playerid][admin_settings][6], 
					admin[playerid][admin_settings][7], admin[playerid][admin_settings][8], admin[playerid][admin_settings][9], admin[playerid][admin_settings][10], 
					admin[playerid][admin_settings][11], admin[playerid][admin_settings][12], admin[playerid][admin_settings][13], admin[playerid][admin_settings][14]);

					cache_get_value_name(0, "admin_color", admin[playerid][admin_color]);
					cache_get_value_name(0, "admin_rank", admin[playerid][admin_rank]);
					cache_get_value_name_int(0, "admin_fulldostup", admin[playerid][admin_fulldostup]);
					cache_get_value_name_int(0, "admin_protection", admin[playerid][admin_protection]);
					cache_get_value_name_int(0, "u_a_reprimand", admin[playerid][u_a_reprimand]);
					cache_get_value_name_int(0, "u_a_freeze", admin[playerid][u_a_freeze]);
					if(admin[playerid][u_a_freeze] > 0 && admin[playerid][u_a_reprimand] > 2)
					{
						server_error(playerid, "� ��� 3/3 ���������, ��� ���������������� ������� �����������, �������� ����. ��������������.");
						cache_delete(temp_sql);
						admin[playerid][admin_level] = 0;
						admin[playerid][u_a_dostup] = 0;
						return true;
					}
					if(admin[playerid][u_a_freeze] > 0)
					{
						server_error(playerid, "��� ���������������� ������� �����������, �������� ����. ��������������.");
						cache_delete(temp_sql);
						admin[playerid][admin_level] = 0;
						admin[playerid][u_a_dostup] = 0;
						return true;
					}
					// cache_get_value_name_int(0, "u_a_protrct_ac", admin[playerid][u_a_protrct_ac]);
					AntiCheatOffAndOn(playerid, 0);
					admin[playerid][u_a_dostup] = 1;
					if(!HideAdmins (users[playerid][u_name]))
					{
						format(message_admin, sizeof(message_admin), "[A] %s %s ������������� � ���������������� ������.", admin_rank_name(playerid), users[playerid][u_name]);
						AdminChat(message_admin);
					}
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_last_login` = NOW() WHERE `u_a_name` = '%s'", users[playerid][u_name]);
					m_query(str_sql);
					server_accept(playerid, "�� ������� ����� � ���������������� ������.");
					if(admin[playerid][admin_level] >= 3)
					{
						new Cache:temp_sql_two = m_query("SELECT * FROM "TABLE_CLAN" WHERE `c_change_spawn` = '1' AND c_change_spawn_xyzfwi != '0, 0, 0, 0, 0, 0'"), rows_two;
						cache_get_row_count(rows_two);
						if(rows_two) 
						{
							AdminChat("[A][�����] ���� ������ �� ����� ������. �����������: /clanspawn.", 3);
						}
						cache_delete(temp_sql_two);
						new Cache:temp_sql_three = m_query("SELECT * FROM "TABLE_USERS" WHERE `u_donate_spawn` = '1' AND `u_donate_spawn_xyzwi` != '0.0, 0.0, 0.0, 0.0, 0, 0'"), rows_three;
						cache_get_row_count(rows_three);
						if(rows_three) 
						{
							AdminChat("[A][�����] ���� ������ �� ������ �����. �����������: /spawn.", 3);
						}
						cache_delete(temp_sql_three);
					}
					if(admin[playerid][admin_level] >= 4)
					{
						static index_ = 0;
						if(index_) index_ = 0;
						foreach(Player, i)
						{
							if(!IsPlayerConnected(i)) continue;
							if(!strcmp(temp[i][player_setname], "NoChangeName")) continue;
							index_++;
						}
						if(index_ > 0) AdminChat("[A][����� ����] ����� ������ �� ����� ����. �����������: /listname.", 4);
					}
					cache_delete(temp_sql);
					foreach(Player, i) clan_syntax(i);
				}
			}
		}
	/*case d_admin_login:
		{
			if(!response) return true;
			switch(GetPVarInt(playerid, "AdminLogin"))
			{
			case 1:
				{
					if(!IsAdmin(playerid)) return server_error(playerid, "������ ���������!");
					for(new i = strlen(inputtext); i != 0; --i)
					switch(inputtext[i])
					{
						case '�'..'�', '�'..'�', ' ', '=':
								return dialog_admin_login(playerid, 0);
					}
					if(strlen(inputtext) < 6 || strlen(inputtext) > 32) return dialog_admin_login(playerid, 0);
					new format_string_mysql[(79+1)+65+MAX_PLAYER_NAME];
					m_format(format_string_mysql, sizeof(format_string_mysql), "UPDATE "TABLE_ADMIN" SET `admin_password` = MD5('%e') WHERE `admin_name` = '%s'", inputtext, users[playerid][u_name]);
					m_query(format_string_mysql);
					server_message(playerid, "�� ������� ������������ ���������������� ������.");
					server_message(playerid, "������ ������������� � ���, ������� ������ �� ���������������� ������.");
					callcmd::alogin(playerid);
				}
			case 0:
				{
					new format_string_mysql[(94+1)+MAX_PLAYER_NAME+65];
					m_format(format_string_mysql, sizeof(format_string_mysql), "SELECT * FROM "TABLE_ADMIN" WHERE `admin_name` = '%s' AND `admin_password` = MD5('%e') LIMIT 1", users[playerid][u_name], inputtext);
					new Cache:temp_sql = m_query(format_string_mysql), r;
					cache_get_row_count(r);
					if(!r)
					{
						if(GetPVarInt(playerid, "ADMIN_VALID_PASSWORD") == 3)
						{
							DeletePVar(playerid, "ADMIN_VALID_PASSWORD");
							TKICK(playerid, "�� ������� � ������� �� �������� ���� ������.");
							cache_delete(temp_sql);
							return true;
						}
						SetPVarInt(playerid, "ADMIN_VALID_PASSWORD", GetPVarInt(playerid, "ADMIN_VALID_PASSWORD") + 1);
						server_error(playerid, "�� ����� �� ������ ������ �� ���������������� ������.");
						dialog_admin_login(playerid, 1);
						cache_delete(temp_sql);
						return true;
					}
					cache_get_value_name_int(0, "admin_vig", admin[playerid][admin_vig]);
					if(admin[playerid][admin_vig] == 4)
					{
						admin[playerid][admin_level] = 0;
						admin[playerid][admin_dostup] = 0;
						server_error(playerid, "���� ���������������� ������ �������������. �������: 4 �� 4 ��������.");
						cache_delete(temp_sql);
						return true;
					}
					cache_get_value_name_int(0, "admin_block", admin[playerid][admin_block]);
					if(admin[playerid][admin_block])
					{
						admin[playerid][admin_level] = 0;
						admin[playerid][admin_dostup] = 0;
						server_error(playerid, "���� ���������������� ������ �������������.");
						cache_delete(temp_sql);
						return true;
					}
					cache_get_value_name_int(0, "admin_level", admin[playerid][admin_level]);
					cache_get_value_name(0, "admin_color", admin[playerid][admin_color], 11);
					cache_get_value_name(0, "admin_rank", admin[playerid][admin_rank], 40);
					cache_get_value_name_int(0, "admin_hide", admin[playerid][admin_hide]);
					cache_get_value_name_int(0, "admin_fulldostup", admin[playerid][admin_fulldostup]);
					cache_get_value_name_int(0, "admin_protection", admin[playerid][admin_protection]);
					cache_get_value_name(0, "admin_settings", temp[playerid][temp_text], 30);
					sscanf(temp[playerid][temp_text], "p<,>iiiiiiiiiiiiiii", admin[playerid][admin_settings][0], admin[playerid][admin_settings][1], admin[playerid][admin_settings][2], 
					admin[playerid][admin_settings][3], admin[playerid][admin_settings][4], admin[playerid][admin_settings][5], admin[playerid][admin_settings][6], 
					admin[playerid][admin_settings][7], admin[playerid][admin_settings][8], admin[playerid][admin_settings][9], admin[playerid][admin_settings][10], 
					admin[playerid][admin_settings][11], admin[playerid][admin_settings][12], admin[playerid][admin_settings][13], admin[playerid][admin_settings][14]);
					cache_get_value_name(0, "admin_commands", temp[playerid][temp_text], 30);
					sscanf(temp[playerid][temp_text], "p<,>iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii", 
					admin[playerid][admin_commands][0], admin[playerid][admin_commands][1], admin[playerid][admin_commands][2], admin[playerid][admin_commands][3], 
					admin[playerid][admin_commands][4], admin[playerid][admin_commands][5], admin[playerid][admin_commands][6], admin[playerid][admin_commands][7], 
					admin[playerid][admin_commands][8], admin[playerid][admin_commands][9], admin[playerid][admin_commands][10], admin[playerid][admin_commands][11], 
					admin[playerid][admin_commands][12], admin[playerid][admin_commands][13], admin[playerid][admin_commands][14], admin[playerid][admin_commands][15], 
					admin[playerid][admin_commands][16], admin[playerid][admin_commands][17], admin[playerid][admin_commands][18], admin[playerid][admin_commands][19], 
					admin[playerid][admin_commands][20], admin[playerid][admin_commands][21], admin[playerid][admin_commands][22], admin[playerid][admin_commands][23], 
					admin[playerid][admin_commands][24], admin[playerid][admin_commands][25], admin[playerid][admin_commands][26], admin[playerid][admin_commands][27], 
					admin[playerid][admin_commands][28], admin[playerid][admin_commands][29], admin[playerid][admin_commands][30], admin[playerid][admin_commands][31], 
					admin[playerid][admin_commands][32], admin[playerid][admin_commands][33], admin[playerid][admin_commands][34], admin[playerid][admin_commands][35], 
					admin[playerid][admin_commands][36], admin[playerid][admin_commands][37], admin[playerid][admin_commands][38], admin[playerid][admin_commands][39], 
					admin[playerid][admin_commands][40], admin[playerid][admin_commands][41], admin[playerid][admin_commands][42], admin[playerid][admin_commands][43], 
					admin[playerid][admin_commands][44], admin[playerid][admin_commands][45], admin[playerid][admin_commands][46], admin[playerid][admin_commands][47], 
					admin[playerid][admin_commands][48], admin[playerid][admin_commands][49]);
					admin[playerid][admin_dostup] = 1;
					AntiCheatEnable(playerid, true);
					if(!admin[playerid][admin_hide])
					{
						format(format_string_admin, sizeof(format_string_admin), "[A] %s %s ������������� � ���������������� ������.", admin_rank_name(playerid), users[playerid][u_name]);
						admin_chat(format_string_admin);
					}
					m_format(format_string_mysql, sizeof(format_string_mysql), "UPDATE "TABLE_ADMIN" SET `admin_lastlogin` = NOW() WHERE `admin_name` = '%s'", users[playerid][u_name]);
					m_query(format_string_mysql);
					server_message(playerid, "�� ������� ����� � ���������������� ������.");
					if(admin[playerid][admin_level] >= 3)
					{
						new Cache:temp_sql_two = m_query("SELECT * FROM "TABLE_CLAN" WHERE `c_change_spawn` = '1' AND c_change_spawn_xyzfwi != '0, 0, 0, 0, 0, 0'"), rows_two;
						cache_get_row_count(rows_two);
						if(rows_two) admin_chat("[A][�����] ���� ������ �� ����� ������. �����������: /clanspawn.", 3);
						cache_delete(temp_sql_two);
						new Cache:temp_sql_three = m_query("SELECT * FROM "TABLE_USERS" WHERE `u_donate_spawn` = '1' AND `u_donate_spawn_xyzwi` != '0.0, 0.0, 0.0, 0.0, 0, 0'"), rows_three;
						cache_get_row_count(rows_three);
						if(rows_three) admin_chat("[A][�����] ���� ������ �� ������ �����. �����������: /spawn.", 3);
						cache_delete(temp_sql_three);
					}
					if(admin[playerid][admin_level] >= 4)
					{
						foreach(Player, i)
						{
							if(!IsPlayerConnected(i)) continue;
							if(!strcmp(temp[i][player_setname], "NoChangeName")) continue;
							AdminChat("[A][����� ����] ����� ������ �� ����� ����. �����������: /listname.", 4);
							break;
						}
					}
					cache_delete(temp_sql);
				}
			}
		}*/
	case d_admin_panel_cmd:
		{
			if ( ! response ) return callcmd::apanel(playerid);
			new line_string [ 128 ] ;
			global_string[0] = EOS;
			switch ( listitem )
			{
			case 0:
			    {
					AdminProtect(1);
					format(line_string, sizeof(line_string),"������� �������������: {cccccc}1 �������");
    				strcat(global_string, "\n{4682B4}/admin (/a){FFFFF0} - ����� ���.");
    				strcat(global_string, "\n{4682B4}/apanel (/ap){FFFFF0} - ���������������� ������.");
    				strcat(global_string, "\n{4682B4}/otvet (/ans){FFFFF0} - �������� ������ �� ������.");
    				strcat(global_string, "\n{4682B4}/clearchat (/cc){FFFFF0} - �������� ���� ���.");
    				strcat(global_string, "\n{4682B4}/recon (/re){FFFFF0} - ������ �� �������.");
    				strcat(global_string, "\n{4682B4}/reoff{FFFFF0} - ����� �� ������ �� �������.");
    				strcat(global_string, "\n{4682B4}/mute{FFFFF0} - ������ ��� ������.");
    				strcat(global_string, "\n{4682B4}/unmute{FFFFF0} - ����� ��� ������.");
    				strcat(global_string, "\n{4682B4}/hp{FFFFF0} - �������� ����.");
    				strcat(global_string, "\n{4682B4}/chatlog{FFFFF0} - ����������� ���-��� ������.");
        		}
			case 1:
			    {
					AdminProtect(2);
					format ( line_string, sizeof ( line_string ),"������� �������������: {cccccc}2 �������") ;
    				strcat(global_string, "\n{4682B4}/sethp{FFFFF0} - ���������� ���-�� ������ �����.");
    				strcat(global_string, "\n{4682B4}/goto{FFFFF0} - ����������������� � ������.");
    				strcat(global_string, "\n{4682B4}/agm{FFFFF0} - �������� ����������� �����.");
    				strcat(global_string, "\n{4682B4}/kick{FFFFF0} - ������� ������.");
    				strcat(global_string, "\n{4682B4}/slap{FFFFF0} - ��������� ������.");
    				strcat(global_string, "\n{4682B4}/showstats{FFFFF0} - ���������� ���������� ������.");
    				strcat(global_string, "\n{4682B4}/ooc{FFFFF0} - ��������� ���� ������� �������.");
        		}
			case 2:
			    {
					AdminProtect(3);
					format ( line_string, sizeof ( line_string ),"������� �������������: {cccccc}3 �������") ;
    				strcat(global_string, "\n{4682B4}/gethere{FFFFF0} - ��������������� ������ � ����.");
    				strcat(global_string, "\n{4682B4}/tpcar{FFFFF0} - ����������������� � ����������.");
    				strcat(global_string, "\n{4682B4}/ban{FFFFF0} - ������������� ������� ������.");
    				strcat(global_string, "\n{4682B4}/unban{FFFFF0} - �������������� ������� ������.");
    				strcat(global_string, "\n{4682B4}/skin{FFFFF0} - �������� ���� ������.");
    				strcat(global_string, "\n{4682B4}/clanspawn (/spclan){FFFFF0} - ������ ������ �� ����� ������ �����.");
    				strcat(global_string, "\n{4682B4}/changeclanspawn (/cspclan){FFFFF0} - �������� �� ������ ����� ������ �����.");
    				strcat(global_string, "\n{4682B4}/spawn{FFFFF0} - ������ ������ �� ������ ����� ������.");
    				strcat(global_string, "\n{4682B4}/changespawn{FFFFF0} - �������� �� ������ ������ ����� ������.");
        		}
			case 3:
			    {
					AdminProtect(4);
					format ( line_string, sizeof ( line_string ),"������� �������������: {cccccc}4 �������") ;
    				strcat(global_string, "\n{4682B4}/repair{FFFFF0} - �������� ����������.");
    				strcat(global_string, "\n{4682B4}/veh{FFFFF0} - ������� ����������.");
    				strcat(global_string, "\n{4682B4}/delveh{FFFFF0} - ������� ����������.");
    				strcat(global_string, "\n{4682B4}/banip{FFFFF0} - ������������� IP.");
    				strcat(global_string, "\n{4682B4}/unbanip{FFFFF0} - �������������� IP.");
    				strcat(global_string, "\n{4682B4}/offban{FFFFF0} - ������������� ������� ������� ������.");
    				strcat(global_string, "\n{4682B4}/getip{FFFFF0} - ������ IP-����� ������.");
    				strcat(global_string, "\n{4682B4}/iban{FFFFF0} - ������������� ������/ip.");
    				strcat(global_string, "\n{4682B4}/listname{FFFFF0} - ������ �� ����� ����.");
    				strcat(global_string, "\n{4682B4}/acceptname{FFFFF0} - ������� ������ �� ����� ����.");
        		}
			case 4:
			    {
					AdminProtect(5);
					format ( line_string, sizeof ( line_string ),"������� �������������: {cccccc}5 �������") ;
    				strcat(global_string, "\n{4682B4}/weather{FFFFF0} - ������� ������.");
    				strcat(global_string, "\n{4682B4}/reprimand{FFFFF0} - ������/����� ������� ��������������.");
    				strcat(global_string, "\n{4682B4}/creprimand{FFFFF0} - ������/����� ������� �����.");
    				strcat(global_string, "\n{4682B4}/tpbox{FFFFF0} - ����������������� � �������.");
        		}
			case 5:
				{
					AdminProtect(6);
					format ( line_string, sizeof ( line_string ),"������� �������������: {cccccc}6 �������") ;
    				strcat(global_string, "\n{4682B4}/restart{FFFFF0} - ������� ������� �������.");
    				strcat(global_string, "\n{4682B4}/setadmin{FFFFF0} - �������� ������ ��������������.");
    				strcat(global_string, "\n{4682B4}/asetcolor{FFFFF0} - �������� ���� ��������������.");
    				strcat(global_string, "\n{4682B4}/acolors{FFFFF0} - ������ ������.");
    				strcat(global_string, "\n{4682B4}/asetrank{FFFFF0} - �������� �������� ����� ��������������.");
    				strcat(global_string, "\n{4682B4}/afreezeoff{FFFFF0} - ����������/����������� ��������������.");
    				strcat(global_string, "\n{4682B4}/reloot{FFFFF0} - �������� ����� ������.");
				}
			case 6:
			    {
				    if(!FullDostup(playerid)) return server_error(playerid, "������ ���������.");
					format ( line_string, sizeof ( line_string ),"������� �������������: {cccccc}����������") ;
    				strcat(global_string, "\n{4682B4}/makeadmin{FFFFF0} - �������� ������ ��������������.");
    				strcat(global_string, "\n{4682B4}/givegun{FFFFF0} - ������ ������ ������.");
    				strcat(global_string, "\n{4682B4}/offadmin{FFFFF0} - ������� ��������������.");
    				strcat(global_string, "\n{4682B4}/anticheat{FFFFF0} - ��������� ��������.");
    				// strcat(global_string, "\n{4682B4}/zomb{FFFFF0} - ������� �����.");
    				// strcat(global_string, "\n{4682B4}/deletezomb{FFFFF0} - ������� �����.");
    				strcat(global_string, "\n{4682B4}/alldonate{FFFFF0} - ���������� ������.");
    				strcat(global_string, "\n{4682B4}/setworld{FFFFF0} - �������� ����������� ��� � ��������.");
    				strcat(global_string, "\n{4682B4}/getworld{FFFFF0} - ���������� � ���� ������.");
    				strcat(global_string, "\n{4682B4}/lootname{FFFFF0} - ������ ����� ���� �� �������.");
    				strcat(global_string, "\n{4682B4}/loot{FFFFF0} - ���������� ���.");
        		}
			case 7:
			    {
				    if(!FullDostup(playerid, 1)) return server_error(playerid, "������ ���������.");
					format ( line_string, sizeof ( line_string ),"������� �������������: {cccccc}�����������");
    				strcat(global_string, "\n{4682B4}/agm_player{FFFFF0} - �������� ������ ����������� �����.");
    				strcat(global_string, "\n{4682B4}/unac{FFFFF0} - ���������� ����-���� ��� ������.");
    				strcat(global_string, "\n{4682B4}/amoney{FFFFF0} - ������/������� ������ ������.");
    				strcat(global_string, "\n{4682B4}/adonat{FFFFF0} - ������/������� ������ �����.");
    				strcat(global_string, "\n{4682B4}/setclan{FFFFF0} - �������� ���� ������.");
    				strcat(global_string, "\n{4682B4}/setrank{FFFFF0} - �������� ���� ������.");
    				strcat(global_string, "\n{4682B4}/ownerbase{FFFFF0} - ������ ���������� ����.");
    				strcat(global_string, "\n{4682B4}/editbase{FFFFF0} - �������� ��������� ����.");
    				strcat(global_string, "\n{4682B4}/setcoords{FFFFF0} - ����������������� �� ����������.");
        		}
			}
			show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, line_string, global_string, !"OK", !"");
		}
	case d_cmd_back: callcmd::commands(playerid);
	case d_cmd:
		{
			if(!response) return true;
			new line_string[128];
			global_string[0] = EOS;
			switch(listitem)
			{
			case 0:
			    {
					format(line_string, sizeof(line_string),"�������: {cccccc}��������");
    				strcat(global_string, "\n{F0E68C}/help{FFFFF0} - ������ �� ��������.");
    				strcat(global_string, "\n{F0E68C}/rules{FFFFF0} - ������� �������.");
    				strcat(global_string, "\n{F0E68C}/report{FFFFF0} - ����� � ��������������.");
    				strcat(global_string, "\n{F0E68C}/menu{FFFFF0} - ������� ���� ������.");
    				strcat(global_string, "\n{F0E68C}/needs{FFFFF0} - ���������� �����������.");
    				strcat(global_string, "\n{F0E68C}/id{FFFFF0} - ����� �� ������ �� ����.");
    				strcat(global_string, "\n{F0E68C}/pay{FFFFF0} - �������� ������ ������.");
    				strcat(global_string, "\n{F0E68C}/cancel{FFFFF0} - �������� ������ �� ����� ����.");
    				strcat(global_string, "\n{F0E68C}/car{FFFFF0} - ���������� ������������ ���������.");
    				strcat(global_string, "\n{F0E68C}/history{FFFFF0} - ������� ����� �����.");
    				strcat(global_string, "\n{F0E68C}/eject{FFFFF0} - �����c��� ������ �� ����������.");
    				strcat(global_string, "\n{F0E68C}/craft{FFFFF0} - ������������ ���������.");
    				strcat(global_string, "\n{F0E68C}/vip{FFFFF0} - ���� ��� VIP �������.");
    				strcat(global_string, "\n{F0E68C}/donate{FFFFF0} - �������������� ������.");
    				strcat(global_string, "\n{F0E68C}/anim{FFFFF0} - ��������.");
    				strcat(global_string, "\n{F0E68C}/campfire{FFFFF0} - ���������� �������.");
        		}
			case 1:
			    {
					format(line_string, sizeof(line_string),"�������: {cccccc}��� ����");
    				strcat(global_string, "\n{F0E68C}/r{FFFFF0} - ��������� �� �����.");
    				strcat(global_string, "\n{F0E68C}/pm{FFFFF0} - ������ ���������.");
    				strcat(global_string, "\n{F0E68C}/s{FFFFF0} - ��������.");
    				strcat(global_string, "\n{F0E68C}/w{FFFFF0} - �������� �������.");
        		}
			case 2:
			    {
					format(line_string, sizeof(line_string),"�������: {cccccc}��� �����");
    				strcat(global_string, "\n{F0E68C}/clan{FFFFF0} - ���� �����.");
    				strcat(global_string, "\n{F0E68C}/rc{FFFFF0} - ����� �����.");
        		}
			case 3:
			    {
					format(line_string, sizeof(line_string),"�������: {cccccc}��� ����");
    				strcat(global_string, "\n{F0E68C}/pbase{FFFFF0} - ���� ����.");
    				strcat(global_string, "\n{F0E68C}/og{FFFFF0} - ������� ������ ����.");
        		}
			}
			show_dialog(playerid, d_cmd_back, DIALOG_STYLE_MSGBOX, line_string, global_string, !"�����", !"");
		}
	case d_admin_panel:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: callcmd::offadmins(playerid);
			case 1: callcmd::ahelp(playerid);
			case 2: callcmd::teleport(playerid);
			case 3:
				{
					AdminProtect(1);
					global_string [ 0 ] = EOS ;
					format(global_string, sizeof(global_string), "�������� �������\t������\n\
					{cccccc}- {ffffff}���������� � ����� �������\t%s\n\
					{cccccc}- {ffffff}�������� �� ����� �� �����\t%s\n\
					{cccccc}- {ffffff}���� �������\t%s\
					", (admin[playerid][admin_settings][0]?("{33AA33}��������"):("{A52A2A}���������")), 
					(admin[playerid][admin_settings][1]?("{33AA33}��������"):("{A52A2A}���������")), 
					(admin[playerid][admin_settings][2]?("{33AA33}��������"):("{A52A2A}���������")));
					show_dialog(playerid, d_admin_panel_settings, DIALOG_STYLE_TABLIST_HEADERS, !"���������������� ������", global_string, !"�������", !"�����");
				}
			}
		}
	case d_admin_panel_settings:
		{
			if(!response) return callcmd::apanel(playerid);
			if(admin[playerid][admin_settings][listitem]) 
			{
				if(listitem == 2) for(new i = 0; i < 5; i++) SendDeathMessageToPlayer(playerid, INVALID_PLAYER_ID, INVALID_PLAYER_ID, WEAPONSTATE_UNKNOWN);
				admin[playerid][admin_settings][listitem] = 0;
				server_accept(playerid, "�� ��������� ���������.");
			}
			else 
			{
				admin[playerid][admin_settings][listitem] = 1;
				server_accept(playerid, "�� �������� ���������.");
			}
			new mysql_format_string[144];
			format(mysql_format_string, sizeof(mysql_format_string),"UPDATE "TABLE_ADMIN" SET `admin_settings` = '%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i' WHERE `u_a_name` = '%s' LIMIT 1", 
			admin[playerid][admin_settings][0], admin[playerid][admin_settings][1], admin[playerid][admin_settings][2], 
			admin[playerid][admin_settings][3], admin[playerid][admin_settings][4], admin[playerid][admin_settings][5], admin[playerid][admin_settings][6], 
			admin[playerid][admin_settings][7], admin[playerid][admin_settings][8], admin[playerid][admin_settings][9], admin[playerid][admin_settings][10], 
			admin[playerid][admin_settings][11], admin[playerid][admin_settings][12], admin[playerid][admin_settings][13], admin[playerid][admin_settings][14], 
			users[playerid][u_name]);
			m_query(mysql_format_string);
		}
	case d_clan_money:
		{
		    if(!response) return true;
			if (users[playerid][u_money] < 2000000) return server_error(playerid, "� ��� ������������ �������� ������� ��� ����������� �����.");
			if (users[playerid][u_clan] || users[playerid][u_clan_rank]) return server_error(playerid, "�� ��� �������� � �����.");
			if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� ��������� ����!");
			show_dialog(playerid, d_clan_money_2, DIALOG_STYLE_INPUT, !"����������� �����", !"\n\
			{ffffff}���������� �������� ��� ������ �����\n\n\
			{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
			{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
			{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
			", !"�������", !"�����");
		}
	case d_clan_money_2:
		{
		    if(!response) return show_donate(playerid);
			if (users[playerid][u_money] < 2000000) return server_error(playerid, "� ��� ������������ �������� ������� ��� ����������� �����.");
			if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� ��������� ����!");
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
				case ' ', '=', '(', '_', ')', '{', '}', '[', ']', '"', ':', ';', '!', '@', '#', '$', '%', '^', 
					 '&', '?', '*', '-', '+', '/', ',', '.', '<', '>':
				{
					show_dialog(playerid, d_clan_money_2, DIALOG_STYLE_INPUT, !"����������� �����", !"\n\
					{ffffff}���������� �������� ��� ������ �����\n\n\
					{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
					{A52A2A}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"�������", !"�����");
					return true;
				}
			}
			if(strlen(inputtext) < 3 || strlen(inputtext) > 24)
			{
				show_dialog(playerid, d_clan_money_2, DIALOG_STYLE_INPUT, !"����������� �����", !"\n\
				{ffffff}���������� �������� ��� ������ �����\n\n\
				{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
				{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
				{A52A2A}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
				", !"�������", !"�����");
				return true;
			}
			for(new i = strlen(inputtext); i != 0; --i)
			{
				switch(inputtext[i])
				{
					case '�'..'�', '�'..'�', ' ', '=':
					{
						show_dialog(playerid, d_clan_money_2, DIALOG_STYLE_INPUT, !"����������� �����", !"\n\
						{ffffff}���������� �������� ��� ������ �����\n\n\
						{A52A2A}- {ffffff}�������� ����� ������ ���� ����������.\n\
						{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
						{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\n\
						{A52A2A}����� ���� ����������!", !"�������", !"�����");
						server_error(playerid, "����������� ������ ��������� �����.");
						return true;
					}
				}
			}
			new str_sql[196];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_name` = '%s' LIMIT 1", inputtext);
			new Cache:temp_sql = m_query(str_sql), r;
			cache_get_row_count(r);
			if(r) 
			{
				show_dialog(playerid, d_clan_money_2, DIALOG_STYLE_INPUT, !"����������� �����", !"\n\
				{ffffff}���������� �������� ��� ������ �����\n\n\
				{A52A2A}- {ffffff}�������� ����� ������ ���� ����������.\n\
				{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
				{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\n\
				{A52A2A}����� ���� ����������!", !"�������", !"�����");
				//cache_delete(temp_sql);
				return true;
			}
			m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_CLAN" (`c_name`, `c_owner`, `c_date`) VALUES ('%s', '%s', NOW())", inputtext, users[playerid][u_name]);
			m_query(str_sql);

			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_name` = '%s' LIMIT 1", inputtext);
			new Cache:temp_sql_1 = m_query(str_sql), rows;
			cache_get_row_count(rows);
			cache_get_value_name_int(0, "c_id", users[playerid][u_clan]);
			cache_delete(temp_sql_1);
			users[playerid][u_clan_rank] = 5;
			clan[users[playerid][u_clan]][c_skin] = 0;
			for(new rank = 0; rank != 5; rank++) format(c_rank[users[playerid][u_clan]][rank], 24, "������ %i", rank+1);
			format(clan[users[playerid][u_clan]][c_owner], 24, "%s", users[playerid][u_name]);
			format(clan[users[playerid][u_clan]][c_name], 24, "%s", inputtext);
			format(clan[users[playerid][u_clan]][c_name_abbr], 24, "NoNameAbbreviatur");
			// users[playerid][u_money] -= 2000000;
			money(playerid, "-", 2000000);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan` = '%i', `u_clan_rank` = '5' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_clan], users[playerid][u_id]);
			m_query(str_sql);
			static str[128];
			format(str, sizeof(str), "����� %s ������ ���� %s.", users[playerid][u_name], inputtext);
			server_errorToAll(str);
			server_accept(playerid, "�� ������� ������� ���� ����.");
			server_accept(playerid, "�����������: /clan - ��� ���������� ������.");
			cache_delete(temp_sql);
			return true;
		}
	case d_donate_menu:
		{
		    if(!response) return true;
			show_donate(playerid);
		}
	case d_donate:
		{
		    if ( ! response ) return true;
			switch(listitem)
			{
			case 0: show_dialog(playerid, d_donate_vip, DIALOG_STYLE_MSGBOX, !"{FFD700}������� VIP �������", !"\n\
					{FFFFFF}������� ��� ������� ��� �������(�����);(���������������)\n\
					{FFFFFF}������� ��� ������� � ����;\n\
					{FFFFFF}����������� ���������� ������ ����� ������;\n\
					{FFFFFF}���� � �������� ������� �� 10 ���������;\n\
					{FFFFFF}����������� �������� ������������ �� 15 ���������;\n\
					{FFFFFF}����������� �������� ����� �� 15 ���������;\n\
					{FFFFFF}��������� ���:\n\n\
					\t{FFFFFF} - ��������� ������;\n\
					\t{FFFFFF} - ����, ������;\n\ 
					\t{FFFFFF} - GPS, �����;\n\
					\t{FFFFFF} - �������� 9mm;\n\
					\t{FFFFFF} - ������ 9mm;\n\
					\t{FFFFFF} - ������ - 2 ��.;\n\
					\t{FFFFFF} - ������� � ����� - 2 ��.;\n\n\
					{828282}����: {33AA33}150 ������\n\
					{828282}���� ��������: {FFFFFF}360 �����\n\
					{828282}����� �������� VIP ������ �������� ������ ����� �� �������!\n", !"������", !"�����");
			case 1: 
				{
					if (users[playerid][u_clan]) return server_error(playerid, "�� ��� �������� � �����.");
					if(get_player_donate(playerid) < 200) return server_error(playerid, " � ��� ������������ ������� ��� �������� �����.");
					if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� ��������� ����!");
					show_dialog(playerid, d_donate_clan, DIALOG_STYLE_INPUT, !"�������������� ������", !"\n\
					{ffffff}���������� �������� ��� ������ �����\n\n\
					{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
					{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"�������", !"�����");
				}
			case 2: show_dialog(playerid, d_donate_konvert, DIALOG_STYLE_INPUT, !"��������� ������� ������", !"{ffffff}������� ���-�� ����� ����� ������� ������ ��������� � ������\n{499CF5}1 �����{ffffff}- {499CF5}2.500 �����\n\n{33AA33}��������: ���-�� ������� � ������!", !"���������", !"������");
			case 3: show_dialog(playerid, d_donate_items, DIALOG_STYLE_TABLIST_HEADERS, !"������������� ������ �����", "�������� ��������:\t���������:\n\
					{828282}- {ffffff}������� �����\t{33AA33}30 ������ �� 1 ��.\n\
					{828282}- {ffffff}����������� ������\t{33AA33}15 ������ �� 1 ��.", !"�������", !"�������");
			case 4:
				{
					if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� �������� ����!");
					static str[96], str_prise[24];
					// global_string[0] = EOS;
					global_string[0] = EOS;
					strcat(global_string, "�������� ����:\t���������:\n");
					for(new i = 1; i < base_count; i++)
					{
						format(str_prise, sizeof(str_prise), "{33AA33}%i ������", base[i][b_price]);
						format(str, sizeof(str), "{828282}- {ffffff}���� �%i\t%s\n", i, (!base[i][b_owner_id])?(str_prise):("{A52A2A}������"));
						strcat(global_string, str);
					}
					show_dialog(playerid, d_donate_base, DIALOG_STYLE_TABLIST_HEADERS, !"������������� ����", global_string, !"�������", !"�������");
				}
			case 5:
				{
					switch (users[playerid][u_donate_spawn])
					{
					case 0: show_dialog(playerid, d_donate_spawn, DIALOG_STYLE_MSGBOX, !"������ �����", !"\n�� ������ ���������� ������ ����� ���������?\n", !"��", !"���");
					case 1: server_error(playerid, "�� ��� ������ ������ �� ������ ����� ���������. �������� ������ �������������."), show_donate(playerid);
					case 2: show_dialog(playerid, d_donate_spawn, DIALOG_STYLE_MSGBOX, !"������ �����", !"\n{ffff00}� ��� ��� ���� ����� ���������.\n� ������ ������ ������������� �� ��������� ������� ����� ���������!!\n{ffffff}������ ���������� ����� ����� ������?\n", !"��", !"���");
					}
				}
			case 6:
				{
					switch (users[playerid][u_donate_skin])
					{
					case 0: show_dialog(playerid, d_donate_skin, DIALOG_STYLE_MSGBOX, !"������ ����", !"\n�� ������ ���������� ������ ����?\n", !"��", !"���");
					default: show_dialog(playerid, d_donate_skin, DIALOG_STYLE_MSGBOX, !"������ ����", !"\n{ffff00}� ��� ��� ���� ������ ����.\n{ffffff}������ ���������� ����� ������ ����?\n", !"��", !"���");
					}
				}
			case 7: show_dialog(playerid, d_donate_starter, DIALOG_STYLE_TABLIST_HEADERS, !"��������", "��������:\t����������\t���������:\n\
					{828282}- {ffffff}������� ���������\t{cccccc}25 ��.\t{33AA33}80 ������\n\
					{828282}- {ffffff}����������� �������\t{cccccc}25 ��.\t{33AA33}100 ������\n\
					{828282}- {ffffff}����������� �������\t{cccccc}25 ��.\t{33AA33}120 ������\n\
					{828282}- {ffffff}������� �������\t{cccccc}25 ��.\t{33AA33}140 ������\n\
					{828282}- {ffffff}����������� �������\t{cccccc}25 ��.\t{33AA33}180 ������\n\
					{cccccc}���������� � ���������", !"�������", !"�������");
			case 8:
				{
					if(get_player_donate(playerid) < 5) return server_error(playerid, "� ��� ������������ ������� ��� ������� �������.");
					users[playerid][u_setname]++;
					static str_sql[165];
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'5', `u_donate_skin` = '%i' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_donate_skin], users[playerid][u_id]);
					m_query(str_sql);
					server_accept(playerid, "�� ��������� 1 ����� ��� ����� ����.");
					show_donate(playerid);
				}
			case 9: show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
			{cccccc}1. {fffff0}������ �����\n\
			{cccccc}2. {fffff0}�������� �� �������\n\
			{cccccc}3. {fffff0}��� ������\n\
			{cccccc}4. {fffff0}��������� � �����\n\
			{cccccc}���������� � �������", !"�����", !"�����");
			/*case 10: show_dialog(playerid, d_donate_getpay, DIALOG_STYLE_LIST, "����� �������� �������", "\
					{cccccc}1. {fffff0}����� �� {ffa500}QIWI\n\
					{cccccc}2. {fffff0}����� �� {B0E0E6}WebMoney {fffff0}- {A52A2A}�������� � ����������\n\
					{CD5C5C}�������� ������� �����\n\
					{ADD8E6}������� �������", "�����", "�����");
					*/
					// show_dialog(playerid, d_conclusion, DIALOG_STAYLE_LIST, "����� �������� �������", "");
			}
		}
	case d_conclusion_choice:
		{
			if(!response) return callcmd::conclusion(playerid);
			new sting_format_mysql[128];
			m_format(sting_format_mysql, sizeof(sting_format_mysql), "SELECT * FROM "TABLE_CONCLUSION" WHERE `cn_status` = '0' AND `cn_id` = '%i' LIMIT 1", user_items[playerid][listitem][item_id]);
			new Cache:temp_sql = m_query(sting_format_mysql), rows;
			cache_get_row_count(rows);
			if(rows) 
			{
				new
					string_format[400],
					summa, 
					owner,
					number[MAX_PLAYER_NAME],
					payment;
				cache_get_value_name_int(0, "cn_owner", owner);
				cache_get_value_name_int(0, "cn_summa", summa);
				cache_get_value_name_int(0, "cn_payment", payment);
				cache_get_value_name(0, "cn_number", number, sizeof(number));
				format(string_format, sizeof(string_format), "\
				{cccccc}����������:\n\
				{fffff0}��� ������: %s\n\
				��������� �������: %s\n\
				����� ��������: {F5DEB3} %s\n\
				{fffff0}����� ������: {F5DEB3} %i\n\n\
				{FA8072}�������� ��������:\n\
				{cccccc}1 {008000}- ��������\n\
				{cccccc}2 {B22222}- ��������\n\n\
				{fffff0}������� ������ ����� ����:", getname(owner), (!payment)?("{ffa500}QIWI{fffff0}"):("{B0E0E6}WebMoney{fffff0}"), number, summa);
				show_dialog(playerid, d_conclusion_act, DIALOG_STYLE_INPUT, !"����� �� �����", string_format, !"�����", !"�����");
			}
			else server_error(playerid, "������ ������ �� ����� ��� ��� ������� ��� ��������!"), callcmd::conclusion(playerid);
			cache_delete(temp_sql);
		}
	case d_conclusion_act:
		{
			if(!response) return callcmd::conclusion(playerid);
			new sting_format_mysql[128];
			m_format(sting_format_mysql, sizeof(sting_format_mysql), "SELECT * FROM "TABLE_CONCLUSION" WHERE `cn_status` = '0' AND `cn_id` = '%i' LIMIT 1", user_items[playerid][listitem][item_id]);
			new Cache:temp_sql = m_query(sting_format_mysql), rows;
			cache_get_row_count(rows);
			if(rows) 
			{
				for(new Index = strlen(inputtext)-1; Index != -1; Index--)
				{
					switch(inputtext[Index])
					{
					case '0'..'2': continue;
					default: 
						{
							new
								string_format[500],
								summa, 
								owner,
								number[MAX_PLAYER_NAME],
								payment;
							cache_get_value_name_int(0, "cn_owner", owner);
							cache_get_value_name_int(0, "cn_summa", summa);
							cache_get_value_name_int(0, "cn_payment", payment);
							cache_get_value_name(0, "cn_number", number, sizeof(number));
							format(string_format, sizeof(string_format), "\
							{cccccc}����������:\n\
							{fffff0}��� ������: %s\n\
							��������� �������: %s\n\
							����� ��������: {F5DEB3} %s\n\
							{fffff0}����� ������: {F5DEB3} %i\n\n\
							{FA8072}�������� ��������:\n\
							{cccccc}0 {fffff0}- {FF7F50}�� ������������\n\
							{cccccc}1 {fffff0}- {008000}��������\n\
							{cccccc}2 {fffff0}- {B22222}��������\n\n\
							{fffff0}������� ������ ����� ����:", getname(owner), (!payment)?("{ffa500}QIWI{fffff0}"):("{B0E0E6}WebMoney{fffff0}"), number, summa);
							show_dialog(playerid, d_conclusion_act, DIALOG_STYLE_INPUT, !"����� �� �����", string_format, !"�����", !"�����");
							server_error(playerid, "����������� ������ �����.");
							cache_delete(temp_sql);
							return true;
						}
					}
				}
				if(strval(inputtext) == 0)
				{
					server_error(playerid, "�� �������� ������ �� �����, ������ ������ �� �������� {FF7F50}�� ������������");
					callcmd::conclusion(playerid);
				}
				else
				{
					new
						string_format[300],
						summa, 
						owner,
						number[MAX_PLAYER_NAME],
						payment;
					cache_get_value_name_int(0, "cn_owner", owner);
					cache_get_value_name_int(0, "cn_summa", summa);
					cache_get_value_name_int(0, "cn_payment", payment);
					cache_get_value_name(0, "cn_number", number, sizeof(number));
					format(string_format, sizeof(string_format), "\
					{cccccc}����������:\n\
					{fffff0}��� ������: %s\n\
					��������� �������: %s\n\
					����� ��������: {F5DEB3} %s\n\
					{fffff0}����� ������: {F5DEB3} %i\n\n\
					{FA8072}���� ��������: %s", getname(owner), (!payment)?("{ffa500}QIWI{fffff0}"):("{B0E0E6}WebMoney{fffff0}"), number, summa, (strval(inputtext) == 1)?("{008000}��������"):("{B22222}��������"));
					show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"����� �� �����", string_format, !"��", !"");
					SCMG(playerid, "�� %s ������ �� ����� �� ������ %s", (strval(inputtext) == 1)?("{008000}��������{fffff0}"):("{B22222}��������{fffff0}"), getname(owner));
			
					new string_format_mysql[196];
					m_format(string_format_mysql, sizeof(string_format_mysql),"UPDATE "TABLE_CONCLUSION" SET `cn_status` = '%i', `cn_date_accpet` = NOW() WHERE `cn_owner` = '%i' LIMIT 1", 
					strval(inputtext), users[playerid][u_id]);
					m_query(string_format_mysql);
				}
			}
			else server_error(playerid, "������ ������ �� ����� ��� ��� ������� ��� ��������!"), callcmd::conclusion(playerid);
			cache_delete(temp_sql);
		}
	case d_conclusion:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					new Cache:temp_sql = m_query("SELECT * FROM "TABLE_CONCLUSION" WHERE `cn_status` = '0'"), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						global_string[0] = EOS;
						new 
							string_format[128], 
							// status,
							id,
							owner,
							summa, 
							index_ = 0, 
							number[MAX_PLAYER_NAME], 
							date[MAX_PLAYER_NAME], 
							payment;
						strcat(global_string, "�\t���\t��������\t���� � �����\t\n");
						for(new idx = 1; idx <= rows; idx++)
						{
							index_++;
							cache_get_value_name_int(idx-1, "cn_id", id);
							user_items[playerid][index_-1][item_id] = id;
							cache_get_value_name_int(idx-1, "cn_owner", owner);
							cache_get_value_name_int(idx-1, "cn_summa", summa);
							cache_get_value_name_int(idx-1, "cn_payment", payment);
							cache_get_value_name(idx-1, "cn_date", date, sizeof(date));
							cache_get_value_name(idx-1, "cn_number", number, sizeof(number));
							// cache_get_value_name_int(idx-1, "cn_status", status);
							format(string_format, sizeof(string_format), "{cccccc}%i.{fffff0}\t%s\t%s (%s) - [%i ������]\t%s\n", 
							idx, getname(owner), (!payment)?("{ffa500}QIWI{fffff0}"):("{B0E0E6}WebMoney{fffff0}"), number, summa, date);
							strcat(global_string, string_format);
						}
						// strcat(global_string, "������� �������");
						show_dialog(playerid, d_conclusion_choice, DIALOG_STYLE_TABLIST_HEADERS, !"������� �������", global_string, !"�����", !"�����");
					}
					else server_error(playerid, "�������� �� ����� ���!"), callcmd::conclusion(playerid);
					cache_delete(temp_sql);
				}
			case 1:
				{		
					new Cache:temp_sql = m_query("SELECT * FROM "TABLE_CONCLUSION" WHERE `cn_status` != '0' AND `cn_status` != '4' LIMIT 15"), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						global_string[0] = EOS;
						new 
							string_format[128], 
							status,
							number[MAX_PLAYER_NAME], 
							date[MAX_PLAYER_NAME], 
							payment;
						strcat(global_string, "�\t��������\t\t���� � �����\t\t������\n");
						for(new idx = 1; idx <= rows; idx++)
						{
							cache_get_value_name_int(idx-1, "cn_payment", payment);
							cache_get_value_name(idx-1, "cn_date", date, sizeof(date));
							cache_get_value_name(idx-1, "cn_number", number, sizeof(number));
							cache_get_value_name_int(idx-1, "cn_status", status);
							format(string_format, sizeof(string_format), "{cccccc}%i.{fffff0}\t%s (%s)\t%s\t%s\n", 
							idx, (!payment)?("{ffa500}QIWI{fffff0}"):("{B0E0E6}WebMoney{fffff0}"), number, date, (status == 1)?("{008000}��������"):("{B22222}��������"));
							strcat(global_string, string_format);
						}
						// strcat(global_string, "������� �������");
						show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"������� �������", global_string, !"��", !"");
					}
					else server_error(playerid, "������� ������� �����");
					cache_delete(temp_sql);
				}
			}
		}
	/*case d_donate_getpay:
		{
			if(!response) return show_donate(playerid);
			switch(listitem)
			{
			case 0:
				{
					static str_sql[128];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CONCLUSION" WHERE `cn_owner` = '%i' AND `cn_status` = '0' LIMIT 1", users[playerid][u_id]);
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						server_error(playerid, "�� ��� �������� ������ �� �����, �������� ������� ������ ��� �������� �����.");
						callcmd::donate(playerid);
					}
					else
					{
						static string[156];
						format(string, sizeof(string), "\n������� ��������� �����: {cccccc}%i\n{fffff0}������� ����� ��� ������ �� {ffa500}QIWI.\n", get_player_donate(playerid));
						show_dialog(playerid, d_donate_getpay_qiwi, DIALOG_STYLE_INPUT, !"����� �������� ������� | {ffa500}QIWI", string, !"������", !"������");
					}
					cache_delete(temp_sql);
				}
			case 1: return server_error(playerid, "� ����������."), show_donate(playerid);
			case 2: 
				{
					static str_sql[128];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CONCLUSION" WHERE `cn_owner` = '%i' AND `cn_status` = '0' LIMIT 1", users[playerid][u_id]);
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						new string_format[256], variables[3], variables_name[2][MAX_PLAYER_NAME];
						cache_get_value_name(0, "cn_number", variables_name[0], MAX_PLAYER_NAME);
						cache_get_value_name(0, "cn_date", variables_name[1], MAX_PLAYER_NAME);
						cache_get_value_int(0, "cn_summa", variables[0]);
						SetPVarInt(playerid, "cn_summa", variables[0]);
						format(string_format, sizeof(string_format), "{cccccc}����������:\n{fffff0}����� ��� ������: {ADD8E6}%s\n{fffff0}����� ������: {ADD8E6}%i\n{fffff0}���� �������: {ADD8E6}%s\n\n�� ������������� ������ �������� ������ �� ����� �������� �������?", 
						variables_name[0], variables[0], variables_name[1]);
						show_dialog(playerid, d_donate_getpay_qiwi_cancel, DIALOG_STYLE_MSGBOX, !"������ ������ �������", string_format, !"��", !"���");
					}
					else server_error(playerid, "�� �� ������ ������ �� ����� �������� �������."), show_donate(playerid);
					cache_delete(temp_sql);
				}
			case 3: 
				{
					static str_sql[128];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CONCLUSION" WHERE `cn_owner` = '%i' ORDER BY `cn_id` DESC", users[playerid][u_id]);
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						global_string[0] = EOS;
						new string_format[256], variables[3], variables_name[2][MAX_PLAYER_NAME];
						for(new idx = 1; idx <= rows; idx++)
						{
							cache_get_value_name(idx-1, "cn_number", variables_name[0], MAX_PLAYER_NAME);
							cache_get_value_name(idx-1, "cn_date", variables_name[1], MAX_PLAYER_NAME);
							cache_get_value_int(idx-1, "cn_summa", variables[0]);
							cache_get_value_int(idx-1, "cn_status", variables[1]);
							switch(variables[1])
							{
							case 0: format(string_format, sizeof(string_format), "{cccccc}%i. {FF7F50}�� ������������ {ffffff}| {cccccc} �������: %s {ffffff}| {cccccc}�����: %i {ffffff}| {cccccc}����: %s\n", idx, variables_name[0], variables[0], variables_name[1]);
							case 1: format(string_format, sizeof(string_format), "{cccccc}%i. {33AA33}������� {ffffff}| {cccccc} �������: %s {ffffff}| {cccccc}�����: %i {ffffff}| {cccccc}����: %s\n", idx, variables_name[0], variables[0], variables_name[1]);
							case 2: format(string_format, sizeof(string_format), "{cccccc}%i. {A52A2A}����� {ffffff}| {cccccc} �������: %s {ffffff}| {cccccc}�����: %i {ffffff}| {cccccc}����: %s\n", idx, variables_name[0], variables[0], variables_name[1]);
							case 4: format(string_format, sizeof(string_format), "{cccccc}%i. {A52A2A}������ {ffffff}| {cccccc} �������: %s {ffffff}| {cccccc}�����: %i {ffffff}| {cccccc}����: %s\n", idx, variables_name[0], variables[0], variables_name[1]);
							}
							strcat(global_string, string_format);
						}
						show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"������� �������", global_string, !"��", !"");
					}
					else server_error(playerid, "�� ��� �� ������ �������� �� �����!"), show_donate(playerid);
					cache_delete(temp_sql);
				}
			}
		}
	case d_donate_getpay_qiwi_cancel:
		{
			if(!response)
			{
				server_error(playerid, "�� ���������� �� ������ �������.");
				show_donate(playerid);
				DeletePVar(playerid, "cn_summa");
				return true;
			}
			static str_sql[196];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CONCLUSION" SET `cn_status` = '4' WHERE `cn_owner` = '%i' LIMIT 1", users[playerid][u_id]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`+'%i' WHERE `u_id` = '%i' LIMIT 1", GetPVarInt(playerid, "cn_summa"), users[playerid][u_id]);
			m_query(str_sql);
			server_accept(playerid, "�� ������� �������� ����� �������� �������, �������� �������� ���������� �� ������ ��������.");
			DeletePVar(playerid, "cn_summa");
		}
	case d_donate_getpay_qiwi:
		{
			if(!response) return show_donate(playerid);
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						static string[156];
						format(string, sizeof(string), "\n������� ��������� �����: {cccccc}%i\n{fffff0}������� ����� ��� ������ �� {ffa500}QIWI.\n", get_player_donate(playerid));
						show_dialog(playerid, d_donate_getpay_qiwi, DIALOG_STYLE_INPUT, !"����� �������� ������� | {ffa500}QIWI", string, !"������", !"������");
						server_error(playerid, "����������� ������ �����.");
						return true;
					}
				}
			}
			if(strval(inputtext) < 1 || strval(inputtext) > get_player_donate(playerid))
			{
				static string[156];
				format(string, sizeof(string), "\n������� ��������� �����: {cccccc}%i\n{fffff0}������� ����� ��� ������ �� {ffa500}QIWI.\n", get_player_donate(playerid));
				show_dialog(playerid, d_donate_getpay_qiwi, DIALOG_STYLE_INPUT, !"����� �������� ������� | {ffa500}QIWI", string, !"������", !"������");
				server_error(playerid, "�� ������� ����� ���� 1 ��� ������ ���������.");
				return true;
			}
			SetPVarInt(playerid, "SummaGetPay", strval(inputtext));
			show_dialog(playerid, d_donate_getpay_qiwi_number, DIALOG_STYLE_INPUT, !"����� �������� ������� | {ffa500}QIWI", !"\n������� ����� �������� QIWI, ����� ������ ���������� � '+'\n", !"������", !"�����");
		}
	case d_donate_getpay_qiwi_number:
		{
			if(!response)
			{
				DeletePVar(playerid, "SummaGetPay");
				static string[156];
				format(string, sizeof(string), "\n������� ��������� �����: {cccccc}%i\n{fffff0}������� ����� ��� ������ �� {ffa500}QIWI.\n", get_player_donate(playerid));
				show_dialog(playerid, d_donate_getpay_qiwi, DIALOG_STYLE_INPUT, !"����� �������� ������� | {ffa500}QIWI", string, !"������", !"������");
				return true;
			}
			// new inputnumber = 0;
			// if(inputnumber) inputnumber = 0; // �������� �� ������ ������; 
			// for(new z = strlen(inputtext); z != 0; --z) if(inputtext[z] == '+') inputnumber = 1;
			// if(inputnumber != 1)
			if(strfind(inputtext, "+", false) != 0)
			{
				server_error(playerid, "����� ������ ���������� � '+'");
				show_dialog(playerid, d_donate_getpay_qiwi_number, DIALOG_STYLE_INPUT, !"����� �������� ������� | {ffa500}QIWI", !"\n������� ����� �������� QIWI, ����� ������ ���������� � '+'\n", !"������", !"�����");
				return true;
			}
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '+', '0'..'9': continue;
				default: 
					{
						show_dialog(playerid, d_donate_getpay_qiwi_number, DIALOG_STYLE_INPUT, !"����� �������� ������� | {ffa500}QIWI", !"\n������� ����� �������� QIWI, ����� ������ ���������� � '+'\n", !"������", !"�����");
						server_error(playerid, "����������� ������ ���� '+' � �����.");
						return true;
					}
				}
			}
			new str_sql[(150+1)+24+11];
			m_format(str_sql, sizeof(str_sql),"INSERT INTO "TABLE_CONCLUSION" (`cn_owner`, `cn_number`, `cn_summa`, `cn_payment`, `cn_status`, `cn_date`) VALUES ('%i', '%s', '%i', '0', '0', NOW());",
			users[playerid][u_id], inputtext, GetPVarInt(playerid, "SummaGetPay"));
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'%i' WHERE `u_id` = '%d' LIMIT 1", GetPVarInt(playerid, "SummaGetPay"), users[playerid][u_id]);
			m_query(str_sql);
			new string[(303+1)+16+11];
			format(string, sizeof(string), "�� ������� �������� ����� �������� ������� �� {ffa500}QIWI\n\n{cccccc}����� QIWI: {ADD8E6}%s\n{cccccc}����� ������: {ADD8E6}%i\n\n{CD5C5C}��� ������ ������, ������� � '����� > ����� �������� ������� > �������� ������� �����'.\n����� �������� � ��������� ������, �������� �������� �������� � ��� �� ����.",
			inputtext, GetPVarInt(playerid, "SummaGetPay"));
			show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"����� �������� ������� | {ffa500}QIWI", string, !"������", !"�����");
			DeletePVar(playerid, "SummaGetPay");
		}*/
	case d_marketplace:
		{
		    if(!response) return show_donate(playerid);
			switch(listitem)
			{
			case 0: // 
				{
					temp[playerid][marketplace_list] = 0;
					temp[playerid][marketplace_lastid] = 0;
					for(new i; i < 15; i++) temp[playerid][marketplace_items][i] = 0;
					market(playerid, 0, 0);
				}
			case 1: market(playerid, 1);
			case 2:
				{
					temp[playerid][marketplace_list] = 0;
					temp[playerid][marketplace_lastid] = 0;
					for(new i; i < 15; i++) temp[playerid][marketplace_items][i] = 0;
					market(playerid, 2, 0);

				}
			case 3:
				{
					static string[156];
					format(string, sizeof(string), "\n� ��� ������: {cccccc}%i\n{fffff0}������� ���-�� ������ ��� �������� �� � �����.\n", get_player_coins(playerid));
					show_dialog(playerid, d_marketplace_paydonate, DIALOG_STYLE_INPUT, !"�������� �������� | {cccccc}�����", string, !"������", !"������");
					/* show_dialog(playerid, d_marketplace_getpay, DIALOG_STYLE_LIST, "�������� �������� | {cccccc}�����", "\
					{cccccc}1. {fffff0}������� � �����\n\
					{cccccc}2. {fffff0}����� �� {ffa500}QIWI {fffff0}- {A52A2A}�������� � ����������\n\
					{cccccc}3. {fffff0}����� �� {B0E0E6}WebMoney {fffff0}- {A52A2A}�������� � ����������", "�����", "�����");
					*/
				}
			/* case 4:
				{
						static str[500];
						format(str, sizeof(str), "\n\
						������: {F4A460}%i ������.\n\n\
						{F4A460}����� {fffff0}- ������, ������� ����� �������� � �������� ������.\n\
						������ ������������ �� {F4A460}����� �����{fffff0}.\n\n\
						{cccccc}��������� ������� ��� ������:\n\
						{ffa500}QIWI {fffff0}- {A52A2A}�������� � ����������{fffff0}, {B0E0E6}WebMoney {fffff0}- {A52A2A}�������� � ����������\n\
						", get_player_coins(playerid));
						show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"�������� �������� | {cccccc}����������", str, !"�����", !"");

				}*/
			}
		}
		/* case d_marketplace_getpay:
			{
				if(!response) return show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				switch(listitem)
				{
				case 0:
					{
						static str[156];
						format(str, sizeof(str), "\n� ��� ������: {cccccc}%i\n{fffff0}������� ���-�� ������ ��� �������� �� � �����.\n", get_player_coins(playerid));
						show_dialog(playerid, d_marketplace_paydonate, DIALOG_STYLE_INPUT, !"�������� �������� | {cccccc}�����", str, !"������", !"������");
					}
				case 1: return server_error(playerid, "� ����������.");
				}
			}*/
		case d_marketplace_paydonate:
			{
				if(!response) return show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				for(new Index = strlen(inputtext)-1; Index != -1; Index--)
				{
					switch(inputtext[Index])
					{
					case '0'..'9': continue;
					default: 
						{
							static str[156];
							format(str, sizeof(str), "\n� ��� ������: {cccccc}%i\n{fffff0}������� ���-�� ������ ��� �������� �� � �����.\n", get_player_coins(playerid));
							show_dialog(playerid, d_marketplace_paydonate, DIALOG_STYLE_INPUT, !"�������� �������� | {cccccc}�����", str, !"������", !"������");
							server_error(playerid, "����������� ������ �����.");
							return true;
						}
					}
				}
				if(strval(inputtext) < 1 || strval(inputtext) > get_player_coins(playerid))
				{
					static str[156];
					format(str, sizeof(str), "\n� ��� ������: {cccccc}%i\n{fffff0}������� ���-�� ������ ��� �������� �� � �����.\n", get_player_coins(playerid));
					show_dialog(playerid, d_marketplace_paydonate, DIALOG_STYLE_INPUT, !"�������� �������� | {cccccc}�����", str, !"������", !"������");
					server_error(playerid, "�� ������� ����� ���� 1 ��� ������ ���������.");
					return true;
				}
				static str_sql[196];
				m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`+'%i', `u_coins` = `u_coins`-'%i' WHERE `u_id` = '%d' LIMIT 1", strval(inputtext), strval(inputtext), users[playerid][u_id]);
				m_query(str_sql);
				SCMG(playerid, "�� ������� �������� %i ������ � ����� ������.", strval(inputtext));
				
			}
		case d_marketplace_myitem:
		{
			if(!response) return show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
			{cccccc}1. {fffff0}������ �����\n\
			{cccccc}2. {fffff0}�������� �� �������\n\
			{cccccc}3. {fffff0}��� ������\n\
			{cccccc}4. {fffff0}�����\n\
			{cccccc}���������� � �������", !"�����", !"�����");
			switch(listitem)
			{
			case 15: market(playerid, 2, temp[playerid][marketplace_lastid]);
			default:
				{
					static str_sql[256];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MARKETPLACE" WHERE `mp_id` = '%i' AND `mp_owner` = '%i' AND `mp_status` = '1' LIMIT 1", temp[playerid][marketplace_items][listitem], users[playerid][u_id]);
					new Cache:temp_sql = m_query(str_sql), r;
					cache_get_row_count(r);
					if(!r)
					{
						temp[playerid][marketplace_list] = 0;
						temp[playerid][marketplace_lastid] = 0;
						for(new i; i < 15; i++) temp[playerid][marketplace_items][i] = 0;
						market(playerid, 2, 0);
						// server_error(playerid, "��������� ���� ����� �� ������ (�������� ������������� � �������� #zum404).");
						server_error(playerid, "��������� ���� ����� ��� ������.");
						show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
						{cccccc}1. {fffff0}������ �����\n\
						{cccccc}2. {fffff0}�������� �� �������\n\
						{cccccc}3. {fffff0}��� ������\n\
						{cccccc}4. {fffff0}�����\n\
						{cccccc}���������� � �������", !"�����", !"�����");
						cache_delete(temp_sql);
						return true;
					}
					static count_[3], str[156];
					cache_get_value_name_int(0, "mp_item", count_[0]);
					cache_get_value_name_int(0, "mp_value", count_[1]);
					cache_get_value_name_int(0, "mp_price", count_[2]);
					temp[playerid][marketplace_item] = temp[playerid][marketplace_items][listitem];
					format(str, sizeof(str), "\n{fffff0}�� �������, ��� ������ ����� � ������� {cccccc}'%s' {fffff0}� ������� {cccccc}%i ��. {fffff0}�� {33AA33}%i ������{fffff0}?\n\n",
					loots[count_[0]][loot_name], count_[1], count_[2]);
					show_dialog(playerid, d_marketplace_myitem_two, DIALOG_STYLE_MSGBOX, "�������� �������� | {cccccc}������ � �������", str, "��", "���");
					cache_delete(temp_sql);
				}
			}
			/*if(listitem == temp[playerid][marketplace_last_list]+1) 
			{
				// new count_ = temp[playerid][marketplace_lastid]-(temp[playerid][marketplace_last_list]-1);
				market(playerid, 0, temp[playerid][marketplace_list_id][temp[playerid][marketplace_list]], 1);
			}*/
			
		}
	case d_marketplace_myitem_two:
		{
			if(!response)
			{
				temp[playerid][marketplace_list] = 0;
				temp[playerid][marketplace_lastid] = 0;
				for(new i; i < 15; i++) temp[playerid][marketplace_items][i] = 0;
				market(playerid, 2, 0);
				server_error(playerid, "�� ���������� �� ������ �������� � �������.");
				show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				return true;
			}
			static str_sql[256];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MARKETPLACE" WHERE `mp_id` = '%i' AND `mp_owner` = '%i' AND `mp_status` = '1' AND `mp_date_accept` < NOW() LIMIT 1", temp[playerid][marketplace_item], users[playerid][u_id]);
			new Cache:temp_sql = m_query(str_sql), r;
			cache_get_row_count(r);
			if(!r)
			{
				temp[playerid][marketplace_list] = 0;
				temp[playerid][marketplace_lastid] = 0;
				for(new i; i < 15; i++) temp[playerid][marketplace_items][i] = 0;
				market(playerid, 2, 0);
				server_error(playerid, "��������� ���� ����� ��� ������ ��� ��� �� ������ 24 ����, ����� ��� ������������ �� �������� ��������.");
				show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				cache_delete(temp_sql);
				return true;
			}
			static count_[5];
			cache_get_value_name_int(0, "mp_item", count_[0]);
			cache_get_value_name_int(0, "mp_value", count_[1]);
			cache_get_value_name_int(0, "mp_price", count_[2]);
			cache_get_value_name_int(0, "mp_owner", count_[3]);
			cache_get_value_name_int(0, "mp_quantity", count_[4]);
			if( (users[playerid][u_slots]+count_[1]) > users[playerid][u_backpack]*10) 
			{
				show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				server_error(playerid, "��� ��������� �����, ��������� ���-������!");
				return true;
			}
			switch(count_[0])
			{
			case 18..25, 63..65, 75..76: 
				{
					for(new rx = 0; rx < count_[1]; rx++) AddItem(playerid, count_[0], count_[4]);
				}
			default: AddItem(playerid, count_[0], count_[1], count_[4]);
			}
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_MARKETPLACE" SET `mp_status` = '0' WHERE `mp_id` = '%i'", temp[playerid][marketplace_item]);
			m_query(str_sql);
			SCMG(playerid, "�� ����� � ������� '%s' � ������� %i ��. �� %i ������.", loots[count_[0]][loot_name], count_[1], count_[2]);
			show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
			{cccccc}1. {fffff0}������ �����\n\
			{cccccc}2. {fffff0}�������� �� �������\n\
			{cccccc}3. {fffff0}��� ������\n\
			{cccccc}4. {fffff0}�����\n\
			{cccccc}���������� � �������", !"�����", !"�����");
			cache_delete(temp_sql);
		}
	case d_marketplace_buy:
		{
			if(!response) return show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
			{cccccc}1. {fffff0}������ �����\n\
			{cccccc}2. {fffff0}�������� �� �������\n\
			{cccccc}3. {fffff0}��� ������\n\
			{cccccc}4. {fffff0}�����\n\
			{cccccc}���������� � �������", !"�����", !"�����");
			switch(listitem)
			{
			case 15: market(playerid, 0, temp[playerid][marketplace_lastid]);
			default:
				{
					static str_sql[256];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MARKETPLACE" WHERE `mp_id` = '%i' AND `mp_owner` != '%i' AND `mp_status` = '1' LIMIT 1", temp[playerid][marketplace_items][listitem], users[playerid][u_id]);
					new Cache:temp_sql = m_query(str_sql), r;
					cache_get_row_count(r);
					if(!r)
					{
						temp[playerid][marketplace_list] = 0;
						temp[playerid][marketplace_lastid] = 0;
						for(new i; i < 15; i++) temp[playerid][marketplace_items][i] = 0;
						market(playerid, 0, 0);
						server_error(playerid, "��������� ���� ����� ��� ������.");
						cache_delete(temp_sql);
						return true;
					}
					static count_[3], str[156];
					cache_get_value_name_int(0, "mp_item", count_[0]);
					cache_get_value_name_int(0, "mp_value", count_[1]);
					cache_get_value_name_int(0, "mp_price", count_[2]);
					if(get_player_donate(playerid) < count_[2]) return server_error(playerid, "� ��� ������������ ����� ������.");
					temp[playerid][marketplace_item] = temp[playerid][marketplace_items][listitem];
					format(str, sizeof(str), "\n{fffff0}�� �������, ��� ������ ������ {cccccc}'%s' {fffff0}� ������� {cccccc}%i ��. {fffff0}�� {33AA33}%i ������{fffff0}?\n\n",
					loots[count_[0]][loot_name], count_[1], count_[2]);
					show_dialog(playerid, d_marketplace_buy_two, DIALOG_STYLE_MSGBOX, "�������� �������� | {cccccc}�������", str, "��", "���");
					cache_delete(temp_sql);
				}
			}
			/*if(listitem == temp[playerid][marketplace_last_list]+1) 
			{
				// new count_ = temp[playerid][marketplace_lastid]-(temp[playerid][marketplace_last_list]-1);
				market(playerid, 0, temp[playerid][marketplace_list_id][temp[playerid][marketplace_list]], 1);
			}*/
			
		}
	case d_marketplace_buy_two:
		{
			if(!response)
			{
				temp[playerid][marketplace_list] = 0;
				temp[playerid][marketplace_lastid] = 0;
				for(new i; i < 15; i++) temp[playerid][marketplace_items][i] = 0;
				market(playerid, 0, 0);
				server_error(playerid, "�� ���������� �� �������.");
				return true;
			}
			static str_sql[256];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MARKETPLACE" WHERE `mp_id` = '%i' AND `mp_owner` != '%i' AND `mp_status` = '1' LIMIT 1", temp[playerid][marketplace_item], users[playerid][u_id]);
			new Cache:temp_sql = m_query(str_sql), r;
			cache_get_row_count(r);
			if(!r)
			{
				temp[playerid][marketplace_list] = 0;
				temp[playerid][marketplace_lastid] = 0;
				for(new i; i < 15; i++) temp[playerid][marketplace_items][i] = 0;
				market(playerid, 0, 0);
				server_error(playerid, "��������� ���� ����� ��� ������.");
				cache_delete(temp_sql);
				return true;
			}
			static count_[5];
			cache_get_value_name_int(0, "mp_item", count_[0]);
			cache_get_value_name_int(0, "mp_value", count_[1]);
			cache_get_value_name_int(0, "mp_price", count_[2]);
			cache_get_value_name_int(0, "mp_owner", count_[3]);
			cache_get_value_name_int(0, "mp_quantity", count_[4]);
			if(get_player_donate(playerid) < count_[2]) return server_error(playerid, "� ��� ������������ ����� ������.");
			if( (users[playerid][u_slots]+count_[1]) > users[playerid][u_backpack]*10) 
			{
				show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				server_error(playerid, "��� ��������� �����, ��������� ���-������!");
				return true;
			}
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'%i' WHERE `u_id` = '%d' LIMIT 1", count_[2], users[playerid][u_id]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_coins` = `u_coins`+'%i' WHERE `u_id` = '%d' LIMIT 1", floatround(count_[2]/1.3), count_[3]);
			m_query(str_sql);
			if(GetPlayerID(getname(count_[3])) != INVALID_PLAYER_ID) SCMG(GetPlayerID(getname(count_[3])), "� ��� ������ ����� '%s' � ������� %i ��. �� %i ������.", loots[count_[0]][loot_name], count_[1], count_[2]);
			else 
			{
				format(str_sql, sizeof(str_sql), "� ��� ������ ����� '%s' � ������� %i ��. �� %i ������.", loots[count_[0]][loot_name], count_[1], count_[2]);
				AddMessage(count_[3], str_sql);
			}
			// for(new rx = 0; rx < count_[1]; rx++) AddItem(playerid, count_[0], count_[4]);
			
			switch(count_[0])
			{
			case 18..25, 63..65, 75..76: 
				{
					for(new rx = 0; rx < count_[1]; rx++) AddItem(playerid, count_[0], count_[4]);
				}
			default: AddItem(playerid, count_[0], count_[1], count_[4]);
			}
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_MARKETPLACE" SET `mp_status` = '2' WHERE `mp_id` = '%i'", temp[playerid][marketplace_item]);
			m_query(str_sql);
			SCMG(playerid, "�� ��������� '%s' � ������� %i ��. �� %i ������.", loots[count_[0]][loot_name], count_[1], count_[2]);
			cache_delete(temp_sql);
		}
	case d_marketplace_to_sell:
		{
			if(!response) return show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
			{cccccc}1. {fffff0}������ �����\n\
			{cccccc}2. {fffff0}�������� �� �������\n\
			{cccccc}3. {fffff0}��� ������\n\
			{cccccc}4. {fffff0}�����\n\
			{cccccc}���������� � �������", !"�����", !"�����");
			if (users[playerid][u_lifetime] < 10800)
			{
				show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				server_error(playerid, "������ �������������� �������� ��������, ���������� �������� ������� 3 ����.");
				return true;
			}
			static str_sql[256];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_MARKETPLACE" WHERE `mp_owner` = '%i' AND `mp_status` = '1'", users[playerid][u_id]);
			new Cache:temp_sql = m_query(str_sql), r;
			cache_get_row_count(r);
			if(r > 4)
			{
				server_error(playerid, "������ ���������� ������ 5-�� �������� �� �������� ��������.");
				show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				cache_delete(temp_sql);
				return true;
			}
			cache_delete(temp_sql);
			users[playerid][PlayertoItem] = listitem;
			temp[playerid][marketplace_value] = 0;
			temp[playerid][marketplace_price] = 0;
			show_dialog(playerid, d_marketplace_item, DIALOG_STYLE_INPUT, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"������� ���������� �������� ��� �������(�� 1 �� 10):", !"�����", !"������");
		}
	case d_marketplace_item:
		{
			if(!response) return show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
			{cccccc}1. {fffff0}������ �����\n\
			{cccccc}2. {fffff0}�������� �� �������\n\
			{cccccc}3. {fffff0}��� ������\n\
			{cccccc}4. {fffff0}�����\n\
			{cccccc}���������� � �������", !"�����", !"�����");
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						show_dialog(playerid, d_marketplace_item, DIALOG_STYLE_INPUT, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"������� ���������� �������� ��� �������(�� 1 �� 10):", !"�����", !"������");
						server_error(playerid, "����������� ������ �����.");
						return true;
					}
				}
			}
			if(strval(inputtext) < 1 || strval(inputtext) > 10)
			{
				show_dialog(playerid, d_marketplace_item, DIALOG_STYLE_INPUT, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"������� ���������� �������� ��� �������(�� 1 �� 10):", !"�����", !"������");
				server_error(playerid, "���-�� �� 1 �� 10 ��.");
				return true;
			}
			if(GetItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]) < strval(inputtext))
			{
				show_dialog(playerid, d_marketplace_item, DIALOG_STYLE_INPUT, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"������� ���������� �������� ��� �������(�� 1 �� 10):", !"�����", !"������");
				server_error(playerid, "������: � ��� ����� ���-�� ��. ������������� �������� ��� � ��� ��� ������� ���������.");
				SCMASS(playerid, "� ��� ���� ������: %i ��.", GetItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]));
				return true;
			}
			temp[playerid][marketplace_value] = strval(inputtext);
			show_dialog(playerid, d_marketplace_item_two, DIALOG_STYLE_INPUT, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"������� ���� �������(�� 1 �� 300 ������):", !"������", !"������");
		}
	case d_marketplace_item_two:
		{
			if(!response) return show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
			{cccccc}1. {fffff0}������ �����\n\
			{cccccc}2. {fffff0}�������� �� �������\n\
			{cccccc}3. {fffff0}��� ������\n\
			{cccccc}4. {fffff0}�����\n\
			{cccccc}���������� � �������", !"�����", !"�����");
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						show_dialog(playerid, d_marketplace_item_two, DIALOG_STYLE_INPUT, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"������� ���� �������(�� 1 �� 300 ������):", !"������", !"������");
						server_error(playerid, "����������� ������ �����.");
						return true;
					}
				}
			}
			if(strval(inputtext) < 1 || strval(inputtext) > 300)
			{
				show_dialog(playerid, d_marketplace_item_two, DIALOG_STYLE_INPUT, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"������� ���� �������(�� 1 �� 300 ������):", !"������", !"������");
				server_error(playerid, "���� �� 1 �� 300 ������.");
				return true;
			}
			temp[playerid][marketplace_price] = strval(inputtext);
			if(GetItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]) < temp[playerid][marketplace_value]) 
			{
				show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
				{cccccc}1. {fffff0}������ �����\n\
				{cccccc}2. {fffff0}�������� �� �������\n\
				{cccccc}3. {fffff0}��� ������\n\
				{cccccc}4. {fffff0}�����\n\
				{cccccc}���������� � �������", !"�����", !"�����");
				server_error(playerid, "������: � ��� ����� ���-�� ��. ������������� �������� ��� � ��� ��� ������� ���������.");
				return true;
			}
			new str_sql[296];
			m_format(str_sql, sizeof(str_sql),"INSERT INTO "TABLE_MARKETPLACE" (`mp_owner`, `mp_item`, `mp_value`, `mp_price`, `mp_quantity`, `mp_status`, `mp_date`, `mp_date_accept`) VALUES ('%i', '%i', '%i', '%i', '%i', '1', NOW(), NOW() + INTERVAL 1 DAY)",
			users[playerid][u_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_id], temp[playerid][marketplace_value], temp[playerid][marketplace_price],
			user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			m_query(str_sql);
			for(new rx = 0; rx < temp[playerid][marketplace_value]; rx++) RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			SCMG(playerid, "������� '%s' ��������� �� ������� � ������� %i ��. �� %i ������.", loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], temp[playerid][marketplace_value], temp[playerid][marketplace_price]);
			show_dialog(playerid, d_marketplace, DIALOG_STYLE_LIST, !"�������� ��������", !"\
			{cccccc}1. {fffff0}������ �����\n\
			{cccccc}2. {fffff0}�������� �� �������\n\
			{cccccc}3. {fffff0}��� ������\n\
			{cccccc}4. {fffff0}�����\n\
			{cccccc}���������� � �������", !"�����", !"�����");
		}
	case d_donate_starter:
		{
		    if(!response) return show_donate(playerid);
			switch(listitem)
			{
			case 0:
				{
					if(get_player_donate(playerid) < 80) return server_error(playerid, "� ��� ������������ �������� �������.");
					users[playerid][u_pack][0] += 25;
					SaveUser(playerid, "pack");
					static str_sql[165];
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'80', `u_donate_skin` = '%i' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_donate_skin], users[playerid][u_id]);
					m_query(str_sql);
					server_accept(playerid, "�� ��������� ''{87CEEB}������� ���������{fffff0}'' - 25 ����.");
				}
			case 1:
				{
					if(get_player_donate(playerid) < 100) return server_error(playerid, "� ��� ������������ �������� �������.");
					users[playerid][u_pack][1] += 25;
					SaveUser(playerid, "pack");
					static str_sql[165];
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'100', `u_donate_skin` = '%i' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_donate_skin], users[playerid][u_id]);
					m_query(str_sql);
					server_accept(playerid, "�� ��������� ''{87CEEB}����������� �������{fffff0}'' - 25 ����.");
				}
			case 2:
				{
					if(get_player_donate(playerid) < 120) return server_error(playerid, "� ��� ������������ �������� �������.");
					users[playerid][u_pack][2] += 25;
					SaveUser(playerid, "pack");
					static str_sql[165];
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'120', `u_donate_skin` = '%i' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_donate_skin], users[playerid][u_id]);
					m_query(str_sql);
					server_accept(playerid, "�� ��������� ''{87CEEB}����������� �������{fffff0}'' - 25 ����.");
				}
			case 3:
				{
					if(get_player_donate(playerid) < 140) return server_error(playerid, "� ��� ������������ �������� �������.");
					users[playerid][u_pack][3] += 25;
					SaveUser(playerid, "pack");
					static str_sql[165];
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'140', `u_donate_skin` = '%i' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_donate_skin], users[playerid][u_id]);
					m_query(str_sql);
					server_accept(playerid, "�� ��������� ''{87CEEB}������� �������{fffff0}'' - 25 ����.");
				}
			case 4:
				{
					if(get_player_donate(playerid) < 180) return server_error(playerid, "� ��� ������������ �������� �������.");
					users[playerid][u_pack][4] += 25;
					SaveUser(playerid, "pack");
					static str_sql[165];
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'180', `u_donate_skin` = '%i' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_donate_skin], users[playerid][u_id]);
					m_query(str_sql);
					server_accept(playerid, "�� ��������� ''{87CEEB}����������� �������{fffff0}'' - 25 ����.");
				}
			case 5: show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"���������� � ���������", "{87CEEB}�������� {ffffff}- ��� ����������� ����� ��������, � ������� 2-� ����� ����� ��������� ��� ��� ���������.\n\
			������� ��� ������������� ���������: {87CEEB}/pack{ffffff}.\n\n\
			{87CEEB}������� ���������:{ffffff}\n\
			������� ������, GPS, �����, �����������, ������, �������� 9mm, ������� - 2,\n\ 
			������� ��� ��������� 9mm - 2, ������� ���� - 2, ������� � ����� - 2;\n\n\
			{87CEEB}����������� �������:{ffffff}\n\
			������� ������, GPS, �����, MP5, ������ �24, ������������� - 2,\n\
			������� ��� MP5 - 2, ������ - 2, ����������� - 3, ������� - 3;\n\n\
			{87CEEB}����������� �������:{ffffff}\n\
			������� ������, GPS, �����, �������, Desert Eagle, ShotGun, ����������, ������ �33\n\
			������� - 2, ������� ��� Desert Eagle - 3, ������� ��� ShotGun - 3;\n\n\
			{87CEEB}������� �������:{ffffff}\n\
			������� ������, GPS, �����, ����, �������, Desert Eagle, M4A1, ����������, ����, ������ �9,\n\
			������� - 2, ����������� - 2, ������� ��� Desert Eagle - 3, ������� ��� M4A1 - 3;\n\n\
			{87CEEB}����������� �������:{ffffff}\n\
			������� ������, GPS, �����, ����, MP5, Sniper Rifle, ����������, ����, ������ �8\n\
			������� - 3, ������� ��� MP5 - 4, ������� ��� Sniper Rifle - 4;", !"�������", !"");
			}
		}
	case d_starter:
		{
		    if(!response) return true;
			switch(listitem)
			{
			case 0..4:
				{
					if(!users[playerid][u_pack][listitem]) return server_error(playerid, "� ��� ������� ��������.");
					// if(temp[playerid][TimeUsePack] == -1) return server_error(playerid, "��� ���������� ��� �� ��� ����� �������.");
					if(temp[playerid][TimeUsePack] == 0) return server_error(playerid, "����� ����������� ��� �� ��� ����� �������.");
					RemovePlayerAttachedObject(playerid, users[playerid][u_backpack_object]);
					switch(listitem)
					{
					case 0:
						{
							users[playerid][u_backpack] = 3;
							// users[playerid][u_slots] += 13;
							printf("Slots: %i", users[playerid][u_slots]);
							AddItem(playerid, 32, 1);//�����������
							AddItem(playerid, 27, 1);//������
							AddItem(playerid, 59, 1);//9mm
							AddItem(playerid, 35, 2);//�������
							AddItem(playerid, 63, getAmmoByItem(63));//������� ��� ��������� 9mm
							AddItem(playerid, 63, getAmmoByItem(63));
							AddItem(playerid, 4, 2);//������� ����
							AddItem(playerid, 44, 2);//������� � �����
							server_accept(playerid, "�� ������������ ''{87CEEB}������� ���������{fffff0}''.");
						}
					case 1:
						{
							users[playerid][u_backpack] = 3;
							users[playerid][u_slots] += 15;
							AddItem(playerid, 16, 1);//MP5
							AddItem(playerid, 36, 2);//�������������
							AddItem(playerid, 24, getAmmoByItem(24));//������� ��� MP5
							AddItem(playerid, 24, getAmmoByItem(24));
							AddItem(playerid, 37, 2);//������
							AddItem(playerid, 32, 3);//�����������
							AddItem(playerid, 35, 3);//�������
							SetPlayerSkin(playerid, ItemToSkin(97, users[playerid][u_gender]));
							users[playerid][u_skin] = ItemToSkin(97, users[playerid][u_gender]);
							server_accept(playerid, "�� ������������ ''{87CEEB}����������� �������{fffff0}''.");
						}
					case 2:
						{
							users[playerid][u_backpack] = 3;
							users[playerid][u_slots] += 14;
							AddItem(playerid, 30, 1);//�������
							AddItem(playerid, 11, 1);//Desert Eagle
							AddItem(playerid, 10, 1);//ShotGun
							AddItem(playerid, 38, 1);//����������
							AddItem(playerid, 35, 2);//�������
							AddItem(playerid, 19, getAmmoByItem(19));//������� ��� Desert Eagle
							AddItem(playerid, 19, getAmmoByItem(19));
							AddItem(playerid, 19, getAmmoByItem(19));
							AddItem(playerid, 18, getAmmoByItem(18));//������� ��� ShotGun
							AddItem(playerid, 18, getAmmoByItem(18));
							AddItem(playerid, 18, getAmmoByItem(18));
							SetPlayerSkin(playerid, ItemToSkin(111, users[playerid][u_gender]));
							users[playerid][u_skin] = ItemToSkin(111, users[playerid][u_gender]);
							server_accept(playerid, "�� ������������ ''{87CEEB}����������� �������{fffff0}''.");
						}
					case 3:
						{
							users[playerid][u_backpack] = 4;
							users[playerid][u_slots] += 16;
							AddItem(playerid, 78, 1);//����
							AddItem(playerid, 54, 1);//����
							AddItem(playerid, 73, 1);//�������
							AddItem(playerid, 11, 1);//Desert Eagle
							AddItem(playerid, 13, 1);//M4A1
							AddItem(playerid, 38, 1);//����������
							AddItem(playerid, 35, 2);//�������
							AddItem(playerid, 19, getAmmoByItem(19));//������� ��� Desert Eagle
							AddItem(playerid, 19, getAmmoByItem(19));
							AddItem(playerid, 19, getAmmoByItem(19));
							AddItem(playerid, 21, getAmmoByItem(21));//������� ��� M4A1
							AddItem(playerid, 21, getAmmoByItem(21));
							AddItem(playerid, 21, getAmmoByItem(21));
							SetPlayerSkin(playerid, ItemToSkin(82, users[playerid][u_gender]));
							users[playerid][u_skin] = ItemToSkin(82, users[playerid][u_gender]);
							server_accept(playerid, "�� ������������ ''{87CEEB}������� �������{fffff0}''.");
						}
					case 4:
						{
							users[playerid][u_backpack] = 4;
							users[playerid][u_slots] += 18;
							AddItem(playerid, 78, 1);//����
							AddItem(playerid, 54, 1);//����
							AddItem(playerid, 16, 1);//MP5
							AddItem(playerid, 14, 1);//Sniper Rifle
							AddItem(playerid, 38, 1);//����������
							AddItem(playerid, 35, 3);//�������
							AddItem(playerid, 24, getAmmoByItem(24));//������� ��� MP5
							AddItem(playerid, 24, getAmmoByItem(24));
							AddItem(playerid, 24, getAmmoByItem(24));
							AddItem(playerid, 24, getAmmoByItem(24));
							AddItem(playerid, 22, getAmmoByItem(22));//������� ��� Sniper Rifle
							AddItem(playerid, 22, getAmmoByItem(22));
							AddItem(playerid, 22, getAmmoByItem(22));
							AddItem(playerid, 22, getAmmoByItem(22));
							SetPlayerSkin(playerid, ItemToSkin(81, users[playerid][u_gender]));
							users[playerid][u_skin] = ItemToSkin(81, users[playerid][u_gender]);
							server_accept(playerid, "�� ������������ ''{87CEEB}����������� �������{fffff0}''.");
						}
					}
					AddItem(playerid, 52, 1); //GPS
					AddItem(playerid, 53, 1); //�����
					RemovePlayerAttachedObject(playerid, users[playerid][u_backpack_object]);
					switch (users[playerid][u_backpack])
					{
					case 1: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,3026,1,-0.058000,-0.110999,0.000000,0.000000,0.000000,0.000000,0.759000,0.928999,0.770000);//�� ���������
					case 2: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,3026,1,-0.158000,-0.097999,-0.010000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);//���������
					case 3: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,371,1,0.056000,-0.116000,-0.004999,2.300001,87.000030,-0.300001,1.000000,0.733999,1.058000);//��
					case 4: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,1310,1,-0.098999,-0.170999,0.000000,-3.200003,87.799934,2.499999,1.000000,0.741999,1.000000);//�������
					case 5: users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid,0,19559,1,0.056000,-0.096000,-0.004999,-3.200003,87.799934,2.499999,1.000000,1.046000,1.184999);//�� �������
					}
					temp[playerid][TimeUsePack] = 0;
					users[playerid][u_pack][listitem]--;
					SaveUser(playerid, "pack");
					printf("Slots: %i", users[playerid][u_slots]);
				}
			case 5: show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"���������� � ���������", "{87CEEB}�������� {ffffff}- ��� ����������� ����� ��������, � ������� 2-� ����� ����� ��������� ��� ��� ���������.\n\
			������� ��� ������������� ���������: {87CEEB}/pack{ffffff}.\n\n\
			{87CEEB}������� ���������:{ffffff}\n\
			������� ������, GPS, �����, �����������, ������, �������� 9mm, ������� - 2,\n\ 
			������� ��� ��������� 9mm - 2, ������� ���� - 2, ������� � ����� - 2;\n\n\
			{87CEEB}����������� �������:{ffffff}\n\
			������� ������, GPS, �����, MP5, ������ �24, ������������� - 2,\n\
			������� ��� MP5 - 2, ������ - 2, ����������� - 3, ������� - 3;\n\n\
			{87CEEB}����������� �������:{ffffff}\n\
			������� ������, GPS, �����, �������, Desert Eagle, ShotGun, ����������, ������ �33\n\
			������� - 2, ������� ��� Desert Eagle - 3, ������� ��� ShotGun - 3;\n\n\
			{87CEEB}������� �������:{ffffff}\n\
			������� ������, GPS, �����, ����, �������, Desert Eagle, M4A1, ����������, ����, ������ �9,\n\
			������� - 2, ����������� - 2, ������� ��� Desert Eagle - 3, ������� ��� M4A1 - 3;\n\n\
			{87CEEB}����������� �������:{ffffff}\n\
			������� ������, GPS, �����, ����, MP5, Sniper Rifle, ����������, ����, ������ �8\n\
			������� - 3, ������� ��� MP5 - 4, ������� ��� Sniper Rifle - 4;", !"�������", !"");
			}
		}
	case d_donate_skin: 
		{
		    if(!response) return show_donate(playerid);
			if(get_player_donate(playerid) < 50) return server_error(playerid, "� ��� ������������ �������� �������.");
			show_dialog(playerid, d_donate_skin_2, DIALOG_STYLE_INPUT, !"������ ����", !"\n������� ���� ID ����� ������� ���� ���������� �� 1 �� 311\n", !"�������", !"������");
		}
	case d_donate_skin_2:
		{
		    if(!response) return show_donate(playerid);
			if(get_player_donate(playerid) < 50) return server_error(playerid, "� ��� ������������ �������� �������.");
			new input = strval(inputtext);
			if(input > 311 || input < 1 || input == 74)
			{
				server_error(playerid, "�������� ����� ����� ��� ���� ��������.");
				show_dialog(playerid, d_donate_skin_2, DIALOG_STYLE_INPUT, !"������ ����", !"\n������� ���� ID ����� ������� ���� ���������� �� 1 �� 311\n", !"�������", !"������");
				return true;
			}
			users[playerid][u_donate_skin] = input;
			SetPlayerSkin(playerid, users[playerid][u_donate_skin]);
			SCMG(playerid, "������ ��� ���������� ���� �%i", users[playerid][u_donate_skin]);
			static str_sql[165];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'50', `u_donate_skin` = '%i' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_donate_skin], users[playerid][u_id]);
			m_query(str_sql);
		}
	case d_donate_spawn:
		{
		    if(!response) return show_donate(playerid);
			if(users[playerid][u_donate_spawn] == 1) return server_error(playerid, "�� ��� ������ ������ �� ������ ����� ���������. �������� ������ �������������."), show_donate(playerid);
			if(get_player_donate(playerid) < 50) return server_error(playerid, "� ��� ������������ �������� �������.");
			static Float: spawn_XYZF[4], str_sql[165];
			GetPlayerPos(playerid, spawn_XYZF[0], spawn_XYZF[1], spawn_XYZF[2]);
			GetPlayerFacingAngle(playerid, spawn_XYZF[3]);
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_donate_spawn` = '1', `u_donate_spawn_xyzwi` = '%f, %f, %f, %f, %i, %i' WHERE `u_id` = '%i'", 
			spawn_XYZF[0], spawn_XYZF[1], spawn_XYZF[2], spawn_XYZF[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), users[playerid][u_id]);
			m_query(str_sql);
			users[playerid][u_donate_spawn] = 1;
			server_accept(playerid, "������ �� ������ ����� ��������� ����������.");
			AdminChat("[A][�����] ����� ������ �� ������ ����� ������. �����������: /spawn.", 3);
		}
	case d_donate_base:
		{
		    if(!response) return show_donate(playerid);
			if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� �������� ����!");
			if(GetPVarInt(playerid, "base_number")) DeletePVar(playerid, "base_number");
			static str[50];
			SetPVarInt(playerid, "base_number", listitem+1);
			format(str, sizeof(str), "������������� ���� (���� �%i)", listitem+1);
			show_dialog(playerid, d_donate_base_buy, DIALOG_STYLE_LIST, str, !"{828282}- {ffffff}�������� ���� �� �����\n{828282}- {33AA33}���������� ����", !"�������", !"�����");
		}
	case d_teleport_1:
		{
			if(!response) return callcmd::teleport(playerid);
			switch(listitem)
			{
			case 0:
				{
					SPP(playerid, 1548.1127, -1365.7007, 326.2109, 0.0);
					server_accept(playerid, "�� ����������������� � {cccccc}'����� ����'");
				}
			case 1:
				{
					SPP(playerid, 1510.1595, -848.2604, 65.5188, 0.0);
					server_accept(playerid, "�� ����������������� �� {cccccc}'�������'");
				}
			case 2:
				{
					SPP(playerid, 1797.3173, 839.3347, 10.6719, 0.0);
					server_accept(playerid, "�� ����������������� � {cccccc}'����� ��'");
				}
			case 3:
				{
					SPP(playerid, -2026.0707, 179.2475, 28.8359, 0.0);
					server_accept(playerid, "�� ����������������� � {cccccc}'����� ��'");
				}
			case 4:
				{
					SPP(playerid, -1077.7568, -2305.7173, 52.3192, 0.0);
					server_accept(playerid, "�� ����������������� � {cccccc}'���'");
				}
			case 5:
				{
					SPP(playerid, 211.1892, 1852.7030, 12.7716, 0.0);
					server_accept(playerid, "�� ����������������� � {cccccc}'���� 51'");
				}
			case 6:
				{
					SPP(playerid, -915.3909, 2014.9252, 60.9141, 0.0);
					server_accept(playerid, "�� ����������������� �� {cccccc}'�����'");
				}
			}
		}
	case d_teleport:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					show_dialog(playerid, d_teleport_1, DIALOG_STYLE_LIST, !"���� ������������", !"\
					{cccccc}1. {ffffff}�������� � ����� ����\n\
					{cccccc}2. {ffffff}�������� �� �������\n\
					{cccccc}3. {ffffff}�������� � ����� ��\n\
					{cccccc}4. {ffffff}�������� � ����� ��\n\
					{cccccc}5. {ffffff}�������� � ���\n\
					{cccccc}6. {ffffff}�������� � ���� 51\n\
					{cccccc}7. {ffffff}�������� �� �����", !"�������", !"������");
				}
			case 1:
				{
					static str[96];
					global_string[0] = EOS;
					for(new i = 1; i < base_count; i++)
					{
						format(str, sizeof(str), "{828282}%i. {ffffff}���� �%i\n", i, i);
						strcat(global_string, str);
					}
					show_dialog(playerid, d_teleport_base, DIALOG_STYLE_LIST, !"�������� �� ����", global_string, !"�������", !"�����");
				}
			}
		}
	case d_teleport_base:
		{
			if(!response) return callcmd::teleport(playerid);
			SPP(playerid, base[listitem+1][b_coords_gate][0], base[listitem+1][b_coords_gate][1], base[listitem+1][b_coords_gate][2], 0.0);
			SCMG(playerid, "�� ����������������� � {cccccc}'���� �%i'", listitem+1);
		}
	case d_donate_base_buy:
		{
			if(!response)
			{
				static str[96], str_prise[24], string[1100];
				// global_string[0] = EOS;
				string[0] = EOS;
				strcat(string, "�������� ����:\t���������:\n");
				for(new i = 1; i < base_count; i++)
				{
					format(str_prise, sizeof(str_prise), "{33AA33}%i ������", base[i][b_price]);
					format(str, sizeof(str), "{828282}- {ffffff}���� �%i\t%s\n", i, (!base[i][b_owner_id])?(str_prise):("{A52A2A}������"));
					strcat(string, str);
				}
				show_dialog(playerid, d_donate_base, DIALOG_STYLE_TABLIST_HEADERS, !"������������� ����", string, !"�������", !"�������");
				return true;
			}
			switch(listitem)
			{
			case 0:
				{
					if(!GetItem(playerid, 52)) return server_error(playerid, "� ��� ��� � ����� GPS ����������");
					temp[playerid][gps] = true;
					new b = GetPVarInt(playerid, "base_number");
					SetPlayerRaceCheckpoint(playerid, 1, base[b][b_coords_gate][0], base[b][b_coords_gate][1], base[b][b_coords_gate][2], 0.0, 0.0, 0.0, 5.0);
					SCMG(playerid, "���� �%i �������� �� �����", b);
				}
			case 1:
				{
					new b = GetPVarInt(playerid, "base_number");
					if(get_player_donate(playerid) < base[b][b_price]) return server_error(playerid, "� ��� ������������ �������� �������");
					if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� �������� ����!");
					if(base[b][b_owner_id] != 0)
					{
						static str[50];
						format(str, sizeof(str), "������������� ���� (���� �%i)", b);
						show_dialog(playerid, d_donate_base_buy, DIALOG_STYLE_LIST, str, !"{828282}- {ffffff}�������� ���� �� �����\n{828282}- {33AA33}���������� ����", !"�������", !"�����");
						SCMASS(playerid, "���� �%i ��� ������!", b);
						return true;
					}
					static str_sql[256];
					/*m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_BASE" WHERE `b_owner_id` = '%i' LIMIT 1", users[playerid][u_id]);
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows)
					{
						server_error(playerid, "� ��� ��� ���� ����!");
						cache_delete(temp_sql);
						return true;
					}
					cache_delete(temp_sql);*/
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BASE" SET `b_owner_name` = '%s', `b_owner_id` = '%i', `b_delete_date` = NOW()+INTERVAL 30 DAY, `b_buy_date` = NOW() WHERE `b_owner_id` = '0' AND `b_id` = '%i'", 
					users[playerid][u_name], users[playerid][u_id], b);
					m_query(str_sql);
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'%i' WHERE `u_id` = '%d' LIMIT 1", base[b][b_price], users[playerid][u_id]);
					m_query(str_sql);
					base[b][b_owner_id] = users[playerid][u_id];
					format(base[b][b_owner_name], 24, users[playerid][u_name]);
					format(base[b][b_lock_password], 24, "1234");
					base[b][b_lock_status] = 0;
					SCMG(playerid, "�� ������� ��������� ���� �%i", b);
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_BASE" WHERE `b_owner_id` = '%i' LIMIT 1", users[playerid][u_id]);
					new Cache:temp_sql_1 = m_query(str_sql), r;
					cache_get_row_count(r);
					if(r)
					{
						cache_get_value_name(0, "b_delete_date", base[b][b_delete_date], MAX_PLAYER_NAME);
						cache_get_value_name(0, "b_buy_date", base[b][b_buy_date], MAX_PLAYER_NAME);
					}
					cache_delete(temp_sql_1);
					static str[50];
					format(str, sizeof(str), "���� �%i", b);
					show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, str, "\
					����������� ��� � ������������� ����!\n\n\
					{ffffff}��� ���������� ����� �����������: {828282}/pbase\n\
					{ffffff}��� �������� ����� �����������: {828282}/og\n\n\
					����������� ������ �� ����: 1234", !"�������", !"");
					if(GetPVarInt(playerid, "base_number")) DeletePVar(playerid, "base_number");
				}
			}
		}
	case d_base_menu:
		{
		    if(!response) return true;
			BaseGateOpen[playerid] = BaseMenuList[playerid][listitem];
			PanelBase(playerid);
		}
	case d_base:
		{
		    if(!response) return true;
			static str[256], str_sql[196], string[356];
			string[0] = EOS;
			new b = BaseGateOpen[playerid];
			switch(listitem)
			{
			case 0: 
				{
					format(str, sizeof(str), "\n{ffffff}����� ����: {cccccc}%i\n", b);
					strcat(string, str);
					format(str, sizeof(str), "{ffffff}������ ����: {cccccc}%s\n", (base[b][b_lock_status])?("{AFEEEE}��� �����"):("{cccccc}�� ������"));
					strcat(string, str);
					if(!base[b][b_lock_status])
					{
						format(str, sizeof(str), "{ffffff}������� ������: {cccccc}%s", base[b][b_lock_password]);
						strcat(string, str);
					}
					strcat(string, "\n\n");
					format(str, sizeof(str), "{ffffff}���� ������� ����: {cccccc}%s\n", base[b][b_buy_date]);
					strcat(string, str);
					format(str, sizeof(str), "{ffffff}���� ����� ����: {cccccc}%s\n", base[b][b_delete_date]);
					strcat(string, str);
					show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "���������� � ����", string, !"�������", !"");
				}
			case 1:
				{
					switch(base[b][b_lock_status])
					{
					case 0:
						{
							if(!users[playerid][u_clan]) return server_error(playerid, "�� �� �������� � �����.");
							base[b][b_lock_status] = users[playerid][u_clan];
							m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BASE" SET `b_lock_status` = '%i' WHERE `b_owner_id` = '%i' AND `b_id` = '%i'", 
							base[b][b_lock_status], users[playerid][u_id], b);
							m_query(str_sql);
							server_accept(playerid, "��� ����� ���� ���������� ��: {cccccc}��� �����");
						}
					default: show_dialog(playerid, d_base_new_password, DIALOG_STYLE_INPUT, "������ �� �����", "\n\n������� ������ ��� ����� ����\n\n", !"����", !"�����");
					}
				}
			case 2:
				{
					if(get_player_donate(playerid) < base[b][b_price]) return server_error(playerid, "� ��� ������������ �������� �������.");
					if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� ���������� ����!");
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BASE" SET `b_delete_date` = `b_delete_date` + INTERVAL 30 DAY WHERE `b_owner_id` = '%i' AND `b_id` = '%i'", users[playerid][u_id], b);
					m_query(str_sql);
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'%i' WHERE `u_id` = '%d' LIMIT 1", base[b][b_price], users[playerid][u_id]);
					m_query(str_sql);
					
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_BASE" WHERE `b_owner_id` = '%i' LIMIT 1", users[playerid][u_id]);
					new Cache:temp_sql_1 = m_query(str_sql), r;
					cache_get_row_count(r);
					if(r)
					{
						cache_get_value_name(0, "b_delete_date", base[b][b_delete_date], MAX_PLAYER_NAME);
						cache_get_value_name(0, "b_buy_date", base[b][b_buy_date], MAX_PLAYER_NAME);
					}
					cache_delete(temp_sql_1);
					server_accept(playerid, "���� �������� �� 30 ����.");
					callcmd::pbase(playerid);
				}
			case 3: show_dialog(playerid, d_base_change_password, DIALOG_STYLE_INPUT, "������ �� �����", "\n\n������� ����� ������ ��� ����� ����\n\n", !"����", !"�����");
			}
		}
	case d_base_change_password:
		{
		    if(!response) return callcmd::pbase(playerid);
			if(!strlen(inputtext) || strlen(inputtext) < 4 || strlen(inputtext) > 24)
			{
				show_dialog(playerid, d_base_change_password, DIALOG_STYLE_INPUT, "������ �� �����", "\n\n������� ����� ������ ��� ����� ����\n{cccccc}������ ������ ���� �� 4-�� �� 24-� ��������\n", !"����", !"�����");
				return true;
			}
			new b = BaseGateOpen[playerid];
			format(base[b][b_lock_password], 24, inputtext);
			static str_sql[196];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BASE" SET `b_lock_password` = '%s', `b_lock_status` = '0' WHERE `b_owner_id` = '%i' AND `b_id` = '%i'", 
			base[b][b_lock_password], users[playerid][u_id], b);
			m_query(str_sql);
			SCMG(playerid, "����� ������ �� ����� ����: {cccccc}%s", base[b][b_lock_password]);
		}
	case d_base_new_password:
		{
		    if(!response) return callcmd::pbase(playerid);
			if(!strlen(inputtext) || strlen(inputtext) < 4 || strlen(inputtext) > 24)
			{
				show_dialog(playerid, d_base_new_password, DIALOG_STYLE_INPUT, "������ �� �����", "\n\n������� ������ ��� ����� ����\n{cccccc}������ ������ ���� �� 4-�� �� 24-� ��������\n", !"����", !"�����");
				return true;
			}
			new b = BaseGateOpen[playerid];
			format(base[b][b_lock_password], 24, inputtext);
			static str_sql[128];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BASE" SET `b_lock_password` = '%s', `b_lock_status` = '0' WHERE `b_owner_id` = '%i' AND `b_id` = '%i'", 
			base[b][b_lock_password], users[playerid][u_id], b);
			m_query(str_sql);
			base[b][b_lock_status] = 0;
			server_error(playerid, "��� ����� ���� ���������� ��: {cccccc}�� ������");
			SCMG(playerid, "����� ������ �� ����� ����: {cccccc}%s", base[b][b_lock_password]);
		}
	case d_base_password:
		{
		    if(!response) return true;
			if(!strlen(inputtext) || strcmp(base[BaseGateOpen[playerid]][b_lock_password], inputtext, false))
			{
				show_dialog(playerid, d_base_password, DIALOG_STYLE_INPUT, "������", "\n\n������� ������ �� ����� ����\n{cccccc}�� ����� �� ������ ������!\n\n", !"����", !"�������");
				return true;
			}
			new b = BaseGateOpen[playerid];
			if(base[b][b_gate_open_number] && base[b][b_gate_open]) return server_error(playerid, "��������� ���� ��������� ������.");
			base[b][b_gate_open] = true;
			temp[playerid][BaseGuardGate] = b;
			MoveDynamicObject(base[b][b_gate], base[b][b_coords_gate_interactions][0], base[b][b_coords_gate_interactions][1], base[b][b_coords_gate_interactions][2], 3);
			base[BaseGateOpen[playerid]][b_gate_open_number] = b;
			SetTimerEx("@base_gate", 10000, false, "i", base[BaseGateOpen[playerid]][b_gate_open_number]);
		}
	case d_donate_items:
		{
		    if(!response) return show_donate(playerid);
			switch(listitem)
			{
			case 0:
				{
					if(get_player_donate(playerid) < 30) return server_error(playerid, "� ��� ������������ �������� �������");
					if (users[playerid][u_slots] >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
					
					AddItem(playerid, 108, 1);
					server_accept(playerid, "�� ��������� ������� �����. �� �������� � ���������.");
					new query_string [ 128 ] ;
					m_format ( query_string, sizeof ( query_string ),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'30' WHERE `u_id` = '%d' LIMIT 1", users[ playerid ] [ u_id ] ) ;
					m_query (query_string ) ;

				}
			case 1:
				{
					if(get_player_donate(playerid) < 30) return server_error(playerid, "� ��� ������������ �������� �������");
					if (users[playerid][u_slots] == users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
					
					AddItem(playerid, 110, 1);
					server_accept(playerid, "�� ��������� ���������� ������. �� �������� � ���������.");
					new query_string [ 128 ] ;
					m_format ( query_string, sizeof ( query_string ),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'15' WHERE `u_id` = '%d' LIMIT 1", users[ playerid ] [ u_id ] ) ;
					m_query (query_string ) ;
				}
			}
		}
	case d_donate_konvert:
		{
		    if(!response) return show_donate(playerid);
  			new moneys = strval(inputtext);
			if(moneys < 1 || moneys > 10000) 
			{
				server_error(playerid, "������� ���-�� ����� �� 1 �� 10.000");
				show_dialog(playerid, d_donate_konvert, DIALOG_STYLE_INPUT, !"��������� ������� ������", !"{ffffff}������� ���-�� ����� ����� ������� ������ ��������� � ������\n{499CF5}1 �����{ffffff}- {499CF5}2.500 �����\n\n{33AA33}��������: ���-�� ������� � ������!", !"���������", !"������");
				return true;
			}
			if(get_player_donate(playerid) < moneys) return server_error(playerid, "� ��� ������������ �������� �������");
			// users[playerid][u_money] += moneys*2500;
			money(playerid, "+", moneys*2500);
			new query_string [ 128 ] ;
			m_format ( query_string, sizeof ( query_string ),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'%i' WHERE `u_id` = '%d' LIMIT 1", moneys, users[ playerid ] [ u_id ] ) ;
			m_query (query_string ) ;
			SCMG(playerid, "�� �������� %i ������ �� %i �����", moneys, moneys*2500);
		}
	case d_donate_clan:
		{
		    if(!response) return show_donate(playerid);
			if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� ��������� ����!");
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
				case ' ', '=', '(', '_', ')', '{', '}', '[', ']', '"', ':', ';', '!', '@', '#', '$', '%', '^', 
					 '&', '?', '*', '-', '+', '/', ',', '.', '<', '>':
				{
					show_dialog(playerid, d_donate_clan, DIALOG_STYLE_INPUT, !"�������������� ������", !"\n\
					{ffffff}���������� �������� ��� ������ �����\n\n\
					{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
					{A52A2A}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"�������", !"�����");
					return true;
				}
			}
			if(strlen(inputtext) < 3 || strlen(inputtext) > 24)
			{
				show_dialog(playerid, d_donate_clan, DIALOG_STYLE_INPUT, !"�������������� ������", !"\n\
				{ffffff}���������� �������� ��� ������ �����\n\n\
				{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
				{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
				{A52A2A}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
				", !"�������", !"�����");
				return true;
			}
			for(new i = strlen(inputtext); i != 0; --i)
			{
				switch(inputtext[i])
				{
					case '�'..'�', '�'..'�', ' ', '=':
					{
						show_dialog(playerid, d_donate_clan, DIALOG_STYLE_INPUT, !"�������������� ������", !"\n\
						{ffffff}���������� �������� ��� ������ �����\n\n\
						{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
						{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
						{A52A2A}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
						", !"�������", !"�����");
						server_error(playerid, "����������� ������ ��������� �����.");
						return true;
					}
				}
			}
			new str_sql[196];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_name` = '%s' LIMIT 1", inputtext);
			new Cache:temp_sql = m_query(str_sql), r;
			cache_get_row_count(r);
			if(r) 
			{
				show_dialog(playerid, d_donate_clan, DIALOG_STYLE_INPUT, !"�������������� ������", !"\n\
				{ffffff}���������� �������� ��� ������ �����\n\n\
				{A52A2A}- {ffffff}�������� ����� ������ ���� ����������.\n\
				{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
				{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\n\
				{A52A2A}����� ���� ����������!", !"�������", !"�����");
				cache_delete(temp_sql);
				return true;
			}
			m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_CLAN" (`c_name`, `c_owner`, `c_date`) VALUES ('%s', '%s', NOW())", inputtext, users[playerid][u_name]);
			m_query(str_sql);

			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_name` = '%s' LIMIT 1", inputtext);
			new Cache:temp_sql_1 = m_query(str_sql), rows;
			cache_get_row_count(rows);
			cache_get_value_name_int(0, "c_id", users[playerid][u_clan]);
			cache_delete(temp_sql_1);
			users[playerid][u_clan_rank] = 5;
			clan[users[playerid][u_clan]][c_skin] = 0;
			for(new rank = 0; rank != 5; rank++) format(c_rank[users[playerid][u_clan]][rank], 24, "������ %i", rank+1);
			format(clan[users[playerid][u_clan]][c_owner], 24, "%s", users[playerid][u_name]);
			format(clan[users[playerid][u_clan]][c_name], 24, "%s", inputtext);
			format(clan[users[playerid][u_clan]][c_name_abbr], 24, "NoNameAbbreviatur");
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'200', `u_clan` = '%i', `u_clan_rank` = '5' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_clan], users[playerid][u_id]);
			m_query(str_sql);
			static str[128];
			format(str, sizeof(str), "����� %s ������ ���� %s.", users[playerid][u_name], inputtext);
			server_errorToAll(str);
			server_accept(playerid, "�� ������� ������� ���� ����.");
			server_accept(playerid, "�����������: /clan - ��� ���������� ������.");
			cache_delete(temp_sql);
			return true;
		}
	case d_clan_close_panel: callcmd::clan(playerid);
	case d_clan:
		{
		    if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					new str_sql[196];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_clan` = '%i'", users[playerid][u_clan]);
					new Cache:temp_sql_2 = m_query(str_sql), rows1;
					cache_get_row_count(rows1);
					cache_delete(temp_sql_2);
					global_string [ 0 ] = EOS ;
					static str[96];
					format(str, sizeof(str), "\n{cccccc}����� �����:\t\t{ADD8E6}%i", users[playerid][u_clan]);
					strcat(global_string, str);
					format(str, sizeof(str), "\n{cccccc}�������� �����:\t{ADD8E6}%s", clan[users[playerid][u_clan]][c_name]);
					strcat(global_string, str);
					static str_two[MAX_PLAYER_NAME];
					format(str_two, sizeof(str_two), "%s", clan[users[playerid][u_clan]][c_name_abbr]);
					format(str, sizeof(str), "\n{cccccc}������������ �����:\t{ADD8E6}%s", (!strcmp("NoNameAbbreviatur", clan[users[playerid][u_clan]][c_name_abbr]))?("{A52A2A}���"):(str_two));
					strcat(global_string, str); 
					format(str, sizeof(str), "\n{cccccc}���������� �����:\t{ADD8E6}%s", clan[users[playerid][u_clan]][c_owner]);
					strcat(global_string, str); 
					format(str, sizeof(str), "\n{cccccc}����� ����� �����:\t{ADD8E6}%i", clan[users[playerid][u_clan]][c_skin]);
					strcat(global_string, str); 
					format(str, sizeof(str), "\n{cccccc}����� �����������:\t{ADD8E6}%i", rows1);
					strcat(global_string, str);
					if(clan[users[playerid][u_clan]][c_reprimand] > 0)
					{
						format(str, sizeof(str), "\n{cccccc}�������� �����:\t{ADD8E6}%i/3", clan[users[playerid][u_clan]][c_reprimand]);
						strcat(global_string, str);
					}
					format(str, sizeof(str), "\n\n{cccccc}��� ���� � �����:\t{ADD8E6}%s (%i)", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_clan_rank]);
					strcat(global_string, str); 
					if(clan[users[playerid][u_clan]][c_reprimand] > 2) strcat(global_string, "\n\n{DC143C}� ������ ����� 3 �� 3 ���������, ��� ���� ����� ������ ����� ��������!");
					show_dialog(playerid, d_clan_close_panel, DIALOG_STYLE_MSGBOX, !"���������� �����", global_string, !"�����", !"");
				}
			case 1:
				{
					new str_sql[196];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_clan` = '%i'", users[playerid][u_clan]);
					new Cache:temp_sql = m_query(str_sql), rows;
    				cache_get_row_count(rows);
					if(rows)
					{		
						global_string [ 0 ] = EOS ;
						new str[128], name[MAX_PLAYER_NAME], level/*, last_online[MAX_PLAYER_NAME]*/;
						strcat(global_string, "�\t���\t����\t������\n");
						for(new idx = 1; idx <= rows; idx++)
						{
							cache_get_value_name(idx-1, "u_name", name, MAX_PLAYER_NAME);
							cache_get_value_name_int(idx-1, "u_clan_rank", level);
							format(str, sizeof(str), "{cccccc}%i\t{ffffff}%s\t{cccccc}%s (%i)\t{ffffff}%s\n", idx, name, c_rank[users[playerid][u_clan]][level-1], level, ConnectPlayer(name));
							strcat(global_string, str);
						}
						show_dialog ( playerid, d_clan_close_panel, DIALOG_STYLE_TABLIST_HEADERS, !"������ �����������", global_string, !"�����", !"" ) ;
					}
					else server_error(playerid, "����������� �� �������.");
					cache_delete(temp_sql);
				}
			case 2: 
				{
					if(clan[users[playerid][u_clan]][c_rank_zam] > users[playerid][u_clan_rank]) show_dialog ( playerid, d_clan_leave, DIALOG_STYLE_MSGBOX, !"���� �� �����", "\n{ffffff}�� ������������� ������ �������� ����?\n", !"��", !"�����");
					else show_dialog ( playerid, d_clan_invite, DIALOG_STYLE_INPUT, !"�������� ������ � ����", !"\n{ffffff}������� �� ������ ��� ����� ��� � ����\n", !"�������", !"�����" ) ;
				}
			case 3: show_dialog ( playerid, d_clan_inv, DIALOG_STYLE_MSGBOX, !"�������� �� �����", !" ", !"������", !"�������" ) ;
			case 4: show_dialog ( playerid, d_clan_give_rank, DIALOG_STYLE_INPUT, !"��������� ����� ������", !"\n\n{ffffff}�������: {cccccc}��{ffffff},{cccccc}����\n\n{ffffff}������� �� � ���� ������ ����� �������!", !"��������", !"�����");
			case 5:
				{
					new str[96];
					global_string [ 0 ] = EOS ;
					format(str, sizeof(str), "{cccccc}1. {ffffff}%s\n", c_rank[users[playerid][u_clan]][0]);
					strcat(global_string, str);
					format(str, sizeof(str), "{cccccc}2. {ffffff}%s\n", c_rank[users[playerid][u_clan]][1]);
					strcat(global_string, str);
					format(str, sizeof(str), "{cccccc}3. {ffffff}%s\n", c_rank[users[playerid][u_clan]][2]);
					strcat(global_string, str);
					format(str, sizeof(str), "{cccccc}4. {ffffff}%s\n", c_rank[users[playerid][u_clan]][3]);
					strcat(global_string, str);
					format(str, sizeof(str), "{cccccc}5. {ffffff}%s", c_rank[users[playerid][u_clan]][4]);
					strcat(global_string, str);
					show_dialog ( playerid, d_clan_ranks, DIALOG_STYLE_LIST, !"����� �����", global_string, !"��������", !"�����" ) ;
				}
			case 6: show_dialog ( playerid, d_clan_skin, DIALOG_STYLE_INPUT, !"��������� ������ �����", !"\n{ffffff}������� ����� ������ ��� ������ �����\n", !"��������", !"�����" ) ;
			case 7:
				{
					if(strcmp (users[playerid][u_name], clan[users[playerid][u_clan]][c_owner], false)) show_dialog ( playerid, d_clan_leave, DIALOG_STYLE_MSGBOX, !"���� �� �����", "\n{ffffff}�� ������������� ������ �������� ����?\n", !"��", !"�����");
					else 
					{
						new str[96];
						global_string [ 0 ] = EOS ;
						strcat(global_string, "�������� ���� ��������� ����� ��������:\n");
						strcat(global_string, "���������, ��������, �������� �����, �������� ������ ��� ������:\n");
						format(str, sizeof(str), "{cccccc}1. {ffffff}%s\n", c_rank[users[playerid][u_clan]][0]);
						strcat(global_string, str);
						format(str, sizeof(str), "{cccccc}2. {ffffff}%s\n", c_rank[users[playerid][u_clan]][1]);
						strcat(global_string, str);
						format(str, sizeof(str), "{cccccc}3. {ffffff}%s\n", c_rank[users[playerid][u_clan]][2]);
						strcat(global_string, str);
						format(str, sizeof(str), "{cccccc}4. {ffffff}%s\n", c_rank[users[playerid][u_clan]][3]);
						strcat(global_string, str);
						format(str, sizeof(str), "{cccccc}5. {ffffff}%s", c_rank[users[playerid][u_clan]][4]);
						strcat(global_string, str);
						show_dialog ( playerid, d_clan_rank_zam, DIALOG_STYLE_LIST, !"���������� �����", global_string, !"��������", !"�����" ) ;
					}
				}
			case 8: show_dialog(playerid, d_clan_name, DIALOG_STYLE_INPUT, !"�������� �����", !"\n\
					{ffffff}������� ����� �������� ��� ������ �����\n\n\
					{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
					{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"��������", !"�����");
			case 9: show_dialog(playerid, d_clan_abbr, DIALOG_STYLE_INPUT, !"������������ �����", !"\n\
					{ffffff}������� ����� ������������ ��� ������ �����\n\n\
					{828282}- {ffffff}������������ ������ ���� ����������.\n\
					{828282}- {ffffff}� ������������ ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}������������ ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"��������", !"�����");
			case 10: 
				{
					if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "� ���������� ������!.");
					static str_sql[196];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_change_spawn` = '0' AND c_change_spawn_xyzfwi = '0, 0, 0, 0, 0, 0' AND `c_id` = '%i'", users[playerid][u_clan]);
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						static Float:SpawnXYZF[4];
						GetPlayerPos(playerid, SpawnXYZF[0], SpawnXYZF[1], SpawnXYZF[2]);
						GetPlayerFacingAngle(playerid, SpawnXYZF[3]);
						m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_change_spawn_xyzfwi` = '%f, %f, %f, %f, %i, %i', `c_change_spawn` = '1' WHERE `c_id` = '%i' LIMIT 1", 
						SpawnXYZF[0], SpawnXYZF[1], SpawnXYZF[2], SpawnXYZF[3], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), users[playerid][u_clan]);
						m_query(str_sql);
						server_accept(playerid, "������ �� ����� ������ ����������.");
						AdminChat("[A][�����] ����� ������ �� ����� ������ ��� �����. �����������: /clanspawn.", 3);
					}
					else server_error(playerid, "�� �������� ��� ������ �� ����� ������, �������� ������ �� �������������.");
					cache_delete(temp_sql);
				}
			case 11: show_dialog ( playerid, d_clan_rasform, DIALOG_STYLE_MSGBOX, !"������� �����", "\n{ffffff}�� ������� ��� ������ ���������� ����?\n", !"����������", !"�����" ) ;
			case 12: show_dialog ( playerid, d_clan_delete, DIALOG_STYLE_MSGBOX, !"�������� �����", "\n{ffffff}�� ������� ��� ������ ������� ����?\n", !"�������", !"�����" ) ;
			}
		}
	case d_clan_give_rank:
		{
			if(!response) return callcmd::clan(playerid);
			if(!strlen(inputtext) || strfind(inputtext, ",", true) == -1)
			{
				show_dialog(playerid, d_clan_give_rank, DIALOG_STYLE_INPUT, !"��������� ����� ������", !"\n\n{ffffff}�������: {cccccc}��{ffffff},{cccccc}����\n\n{ffffff}������� �� � ���� ������ ����� �������!", !"��������", !"�����");
				return true;
			}
			static id_rank[2][6];
			split(inputtext, id_rank, ',');
			new id = strval(id_rank[0]);
			new rank = strval(id_rank[1]);
			if(rank < 1 || rank > 4)
			{
				show_dialog(playerid, d_clan_give_rank, DIALOG_STYLE_INPUT, !"��������� ����� ������", !"\n\n{ffffff}�������: {cccccc}��{ffffff},{cccccc}����\n\n{ffffff}���� ������ ���� �� 1-�� �� 4-�!", !"��������", !"�����");
				return true;
			}
			if(PlayerIsOnline(id) || playerid == id) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
			if(rank == users[id][u_clan_rank]) return server_error(playerid, "����� ��� ����� ����� ����.");
			if (users[playerid][u_clan] != users[id][u_clan]) return server_error(playerid, "����� �� �� ������ �����.");
			if(!strcmp (users[id][u_name], clan[users[playerid][u_clan]][c_name]) || users[id][u_clan_rank] == 5) return server_error(playerid, "������ ����� ������ �������.");
			static str[156];
			format(str, sizeof(str), "[R][CLAN] %s %s ������� ���� ���������� %s � %i �� %i.", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name], users[id][u_name], users[id][u_clan_rank], rank);
			clan_message (users[playerid][u_clan], str);
			SCMG(id, "��� ���� � ����� ��� ������� � %i �� %i", users[id][u_clan_rank], rank);
			users[id][u_clan_rank] = rank;
			new str_sql[156];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan_rank` = '%i' WHERE `u_id` = '%d' AND `u_clan` = '%i' LIMIT 1", users[id][u_clan_rank], users[id][u_id], users[playerid][u_clan]);
			m_query(str_sql);
		}
	case d_recon_kick:
		{
			if(!response) return true;
			static str[96];
			if(!strlen(inputtext))
			{
				format(str, sizeof(str), "\n������� ������� ��� ���� ������ %s (%i)\n", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
				show_dialog(playerid, d_recon_kick, DIALOG_STYLE_INPUT, "���", str, !"�������", !"������");//KICK
				return true;
			}
			if(PlayerIsOnline(observation[playerid][observation_id])) return SCMASS(playerid, "����� %s ����� � �������.", users[observation[playerid][observation_id]][u_name]);
			format(str, sizeof(str), "%i %s", observation[playerid][observation_id], inputtext);
			callcmd::kick(playerid, str);
		}
	case d_recon_mute:
		{
			if(!response) return true;
			static str[96];
			if(!strlen(inputtext))
			{
				format(str, sizeof(str), "\n������� ������� ��� ���������� ���� ������ %s (%i)\n", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
				show_dialog(playerid, d_recon_mute, DIALOG_STYLE_INPUT, "���������� ����", str, !"����", !"������");//MUTE
				return true;
			}
			if(PlayerIsOnline(observation[playerid][observation_id])) return SCMASS(playerid, "����� %s ����� � �������.", users[observation[playerid][observation_id]][u_name]);
			format(str, sizeof(str), "%i 5 %s", observation[playerid][observation_id], inputtext);
			callcmd::mute(playerid, str);
		}
	case d_recon_iban:
		{
			if(!response) return true;
			static str[96];
			if(!strlen(inputtext))
			{
				format(str, sizeof(str), "\n������� ������� ��� ���������� �������� � IP ������ %s (%i)\n", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
				show_dialog(playerid, d_recon_iban, DIALOG_STYLE_INPUT, "���������� ��������", str, !"����", !"������");//IBAN
				return true;
			}
			if(PlayerIsOnline(observation[playerid][observation_id])) return SCMASS(playerid, "����� %s ����� � �������.", users[observation[playerid][observation_id]][u_name]);
			format(str, sizeof(str), "%i 60 %s", observation[playerid][observation_id], inputtext);
			callcmd::iban(playerid, str);
		}
	case d_recon_ban:
		{
			if(!response) return true;
			static str[96];
			if(!strlen(inputtext))
			{
				format(str, sizeof(str), "\n������� ������� ��� ���������� �������� ������ %s (%i)\n", users[observation[playerid][observation_id]][u_name], observation[playerid][observation_id]);
				show_dialog(playerid, d_recon_ban, DIALOG_STYLE_INPUT, "���������� ��������", str, !"����", !"������");//IBAN
				return true;
			}
			if(PlayerIsOnline(observation[playerid][observation_id])) return SCMASS(playerid, "����� %s ����� � �������.", users[observation[playerid][observation_id]][u_name]);
			format(str, sizeof(str), "%i 60 %s", observation[playerid][observation_id], inputtext);
			callcmd::ban(playerid, str);
		}
	case d_clan_delete:
		{
			if(!response) return callcmd::clan(playerid);
			new ClanID = users[playerid][u_clan];
			foreach(Player, i)
			{
        		if(PlayerIsOnline(i)) continue; 
				if(ClanID != users[i][u_clan]) continue;
				users[i][u_clan] = 0;
				users[i][u_clan_rank] = 0;
				clan_syntax(i);
			}
			new str_sql[156];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan` = '0', `u_clan_rank` = '0' WHERE `u_clan` = '%i'", ClanID);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"DELETE FORM "TABLE_CLAN" WHERE `c_id` = '%i' LIMIT 1", ClanID);
			m_query(str_sql);
			static str[128];
			format(str, sizeof(str), "���� %s ��� ��������� ������.", clan[ClanID][c_name]);
			server_errorToAll(str);
			server_accept(playerid, "��� ���� ��� ��������� ������!");
		}
	case d_clan_rasform:
		{
			if(!response) return callcmd::clan(playerid);
			new ClanID = users[playerid][u_clan];
			foreach(Player, i)
			{
        		if(PlayerIsOnline(i)) continue; 
				if (users[i][u_clan] != ClanID) continue;
				if(!strcmp (users[i][u_name], clan[ClanID][c_owner], false)) continue; 
				clan_syntax(i);
				users[i][u_clan] = 0;
				users[i][u_clan_rank] = 0;
			}
			new str_sql[156];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan` = '0', `u_clan_rank` = '0' WHERE `u_name` != '%s' AND `u_clan` = '%i'", clan[ClanID][c_owner], ClanID);
			m_query(str_sql);

			static str[128];
			format(str, sizeof(str), "���� %s ��� �������������.", clan[ClanID][c_name]);
			server_errorToAll(str);

			foreach(Player, i) clan_syntax(i);
			server_accept(playerid, "��� ���� ��������!");
		}
	case d_clan_abbr:
		{
			if(!response) return callcmd::clan(playerid);
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
				case ' ', '=', '(', '_', ')', '{', '}', '[', ']', '"', ':', ';', '!', '@', '#', '$', '%', '^', 
					 '&', '?', '*', '-', '+', '/', ',', '.', '<', '>':
				{
					show_dialog(playerid, d_clan_abbr, DIALOG_STYLE_INPUT, !"������������ �����", !"\n\
					{ffffff}������� ����� ������������ ��� ������ �����\n\n\
					{828282}- {ffffff}������������ ������ ���� ����������.\n\
					{A52A2A}- {ffffff}� ������������ ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}������������ ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"��������", !"�����");
					return true;
				}
			}
			if(strfind(inputtext, "'", true) != -1) return show_dialog(playerid, d_clan_abbr, DIALOG_STYLE_INPUT, !"������������ �����", !"\n\
					{ffffff}������� ����� ������������ ��� ������ �����\n\n\
					{828282}- {ffffff}������������ ������ ���� ����������.\n\
					{A52A2A}- {ffffff}� ������������ ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}������������ ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"��������", !"�����");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 24)
			{
				show_dialog(playerid, d_clan_abbr, DIALOG_STYLE_INPUT, !"������������ �����", !"\n\
				{ffffff}������� ����� ������������ ��� ������ �����\n\n\
				{828282}- {ffffff}������������ ������ ���� ����������.\n\
				{828282}- {ffffff}� ������������ ����� �� ������ ���� ����������� ��������.\n\
				{A52A2A}- {ffffff}������������ ����� ������ ���� ������ �� 3-� �� 24-�.\n\
				", !"��������", !"�����");
				return true;
			}
			static str_sql[156];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_name_abbr` = '%s' LIMIT 1", inputtext);
			new Cache:temp_sql = m_query(str_sql), rows;
			cache_get_row_count(rows);
			if(rows) 
			{
				show_dialog(playerid, d_clan_abbr, DIALOG_STYLE_INPUT, !"������������ �����", !"\n\
				{ffffff}������� ����� ������������ ��� ������ �����\n\n\
				{A52A2A}- {ffffff}������������ ������ ���� ����������.\n\
				{828282}- {ffffff}� ������������ ����� �� ������ ���� ����������� ��������.\n\
				{828282}- {ffffff}������������ ����� ������ ���� ������ �� 3-� �� 24-�.\n\n\
				{A52A2A}����� ������������ ��� ������!", !"��������", !"�����");
				cache_delete(temp_sql);
				return true;
			}
			cache_delete(temp_sql);
			format(clan[users[playerid][u_clan]][c_name_abbr], 24, "%s", inputtext);
			// new format_string[(29+1)+(MAX_PLAYER_NAME*2)];
			foreach(Player, i)
			{
				if(users[i][u_clan] != users[playerid][u_clan]) continue;
				// format(format_string, sizeof(format_string), "{AFEEEE}%s", clan[users[i][u_clan]][c_name_abbr], users[i][u_name], i);
				Update3DTextLabelText(users_nickname[i], 0xAFEEEEFF, clan[users[i][u_clan]][c_name_abbr]);
			}
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_name_abbr` = '%s' WHERE `c_id` = '%i' LIMIT 1", inputtext, users[playerid][u_clan]);
			m_query(str_sql);
			static str[156];
			format(str, sizeof(str), "[R][CLAN] %s %s ������� ������������ �����", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name]);
			clan_message (users[playerid][u_clan], str);
			SCMG(playerid, "������������ ����� �������� �� {cccccc}%s", inputtext);
		}
	case d_clan_name:
		{
			if(!response) return callcmd::clan(playerid);
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
				case ' ', '=', '(', '_', ')', '{', '}', '[', ']', '"', ':', ';', '!', '@', '#', '$', '%', '^', 
					 '&', '?', '*', '-', '+', '/', ',', '.', '<', '>':
				{
					show_dialog(playerid, d_clan_name, DIALOG_STYLE_INPUT, !"�������� �����", !"\n\
					{ffffff}������� ����� �������� ��� ������ �����\n\n\
					{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
					{A52A2A}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"��������", !"�����");
					return true;
				}
			}
			if(strfind(inputtext, "'", true) != -1) return show_dialog(playerid, d_clan_name, DIALOG_STYLE_INPUT, !"�������� �����", !"\n\
					{ffffff}������� ����� �������� ��� ������ �����\n\n\
					{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
					{A52A2A}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
					{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
					", !"��������", !"�����");
			if(strlen(inputtext) < 3 || strlen(inputtext) > 24)
			{
				show_dialog(playerid, d_clan_name, DIALOG_STYLE_INPUT, !"�������� �����", !"\n\
				{ffffff}������� ����� �������� ��� ������ �����\n\n\
				{828282}- {ffffff}�������� ����� ������ ���� ����������.\n\
				{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
				{A52A2A}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\
				", !"��������", !"�����");
				return true;
			}
			static str_sql[156];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_name` = '%s' LIMIT 1", inputtext);
			new Cache:temp_sql = m_query(str_sql), rows;
			cache_get_row_count(rows);
			if(rows) 
			{
				show_dialog(playerid, d_clan_name, DIALOG_STYLE_INPUT, !"�������� �����", !"\n\
				{ffffff}������� ����� �������� ��� ������ �����\n\n\
				{A52A2A}- {ffffff}�������� ����� ������ ���� ����������.\n\
				{828282}- {ffffff}� �������� ����� �� ������ ���� ����������� ��������.\n\
				{828282}- {ffffff}�������� ����� ������ ���� ������ �� 3-� �� 24-�.\n\n\
				{A52A2A}����� �������� ����� ��� ������!", !"��������", !"�����");
				cache_delete(temp_sql);
				return true;
			}
			cache_delete(temp_sql);
			format(clan[users[playerid][u_clan]][c_name], 24, "%s", inputtext);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_name` = '%s' WHERE `c_id` = '%i' LIMIT 1", inputtext, users[playerid][u_clan]);
			m_query(str_sql);
			static str[156];
			format(str, sizeof(str), "[R][CLAN] %s %s ������� �������� �����", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name]);
			clan_message (users[playerid][u_clan], str);
			SCMG(playerid, "�������� ����� �������� �� {cccccc}%s", inputtext);
		}
	case d_clan_rank_zam:
		{
			if(!response) return callcmd::clan(playerid);
			switch(listitem)
			{
			case 0, 1:
				{
					new str[96];
					global_string [ 0 ] = EOS ;
					strcat(global_string, "�������� ���� ��������� ����� ��������:\n");
					strcat(global_string, "���������, ��������, �������� �����, �������� ������ ��� ������:\n");
					format(str, sizeof(str), "{cccccc}1. {ffffff}%s\n", c_rank[users[playerid][u_clan]][0]);
					strcat(global_string, str);
					format(str, sizeof(str), "{cccccc}2. {ffffff}%s\n", c_rank[users[playerid][u_clan]][1]);
					strcat(global_string, str);
					format(str, sizeof(str), "{cccccc}3. {ffffff}%s\n", c_rank[users[playerid][u_clan]][2]);
					strcat(global_string, str);
					format(str, sizeof(str), "{cccccc}4. {ffffff}%s\n", c_rank[users[playerid][u_clan]][3]);
					strcat(global_string, str);
					//format(str, sizeof(str), "{cccccc}5. {ffffff}%s", c_rank[users[playerid][u_clan]][4]);
					//strcat(global_string, str);
					show_dialog ( playerid, d_clan_rank_zam, DIALOG_STYLE_LIST, !"���������� �����", global_string, !"��������", !"�����" ) ;

				}
			default:
				{
					clan[users[playerid][u_clan]][c_rank_zam] = listitem-1;
					new str_sql[156];
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_rank_zam` = '%i' WHERE `c_id` = '%i' LIMIT 1", clan[users[playerid][u_clan]][c_rank_zam], users[playerid][u_clan]);
					m_query(str_sql);
					server_accept(playerid, "����� ������� �� ������� ��������� ����� ����������.");
				}
			}
		} 
	case d_clan_skin:
		{
			if(!response) return callcmd::clan(playerid);
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						show_dialog(playerid, d_clan_skin, DIALOG_STYLE_INPUT, !"��������� ������ �����", !"\n{ffffff}������� ����� ������ ��� ������ �����\n", !"��������", !"�����" ) ;
						server_error(playerid, "����������� ������ �����.");
						return true;
					}
				}
			}
			switch(strval(inputtext))
			{
			case 1..73, 75..311:
				{
					static str_sql[156];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_skin` = '%i' LIMIT 1", strval(inputtext));
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						show_dialog(playerid, d_clan_skin, DIALOG_STYLE_INPUT, !"��������� ������ �����", !"\n{ffffff}������� ����� ������ ��� ������ �����\n", !"��������", !"�����" ) ;
						server_error(playerid, "������ ����� ������ ��� �����!");
						cache_delete(temp_sql);
						return true;
					}
					cache_delete(temp_sql);
					clan[users[playerid][u_clan]][c_skin] = strval(inputtext);
					foreach(Player, i)
					{
						if(PlayerIsOnline(i)) continue; 
						if (users[i][u_clan] != users[playerid][u_clan]) continue; 
						SetPlayerSkin(i, clan[users[i][u_clan]][c_skin]);
					}
					m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_skin` = '%i' WHERE `c_id` = '%i' LIMIT 1", strval(inputtext), users[playerid][u_clan]);
					m_query(str_sql);
					static str[156];
					format(str, sizeof(str), "[R][CLAN] %s %s ������� ������ �����", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name]);
					clan_message (users[playerid][u_clan], str);
					server_accept(playerid, "���� ��� ����� �������.");
					return true;
				}
			default:
				{
					show_dialog(playerid, d_clan_skin, DIALOG_STYLE_INPUT, !"��������� ������ �����", !"\n{ffffff}������� ����� ������ ��� ������ �����\n", !"��������", !"�����" ) ;
					server_error(playerid, "������ ����� ������ �������� ��� ������!");
					return true;
				}
			}
		}
	case d_clan_ranks:
		{
			if(!response) return callcmd::clan(playerid);
			if(GetPVarInt(playerid, "edit_rank")) DeletePVar(playerid, "edit_rank");
			SetPVarInt(playerid, "edit_rank", listitem);
			show_dialog ( playerid, d_clan_ranks_edit, DIALOG_STYLE_INPUT, !"��������� �����", !"\n{ffffff}������� ����� �������� ��� �����\n", !"��������", !"�����" ) ;
		}
	case d_clan_ranks_edit:
		{
			if(!response)
			{
				new str[96];
				global_string [ 0 ] = EOS ;
				format(str, sizeof(str), "{cccccc}1. {ffffff}%s\n", c_rank[users[playerid][u_clan]][0]);
				strcat(global_string, str);
				format(str, sizeof(str), "{cccccc}2. {ffffff}%s\n", c_rank[users[playerid][u_clan]][1]);
				strcat(global_string, str);
				format(str, sizeof(str), "{cccccc}3. {ffffff}%s\n", c_rank[users[playerid][u_clan]][2]);
				strcat(global_string, str);
				format(str, sizeof(str), "{cccccc}4. {ffffff}%s\n", c_rank[users[playerid][u_clan]][3]);
				strcat(global_string, str);
				format(str, sizeof(str), "{cccccc}5. {ffffff}%s\n", c_rank[users[playerid][u_clan]][4]);
				strcat(global_string, str);
				show_dialog ( playerid, d_clan_ranks, DIALOG_STYLE_LIST, !"����� �����", global_string, !"��������", !"�����" ) ;
				return true;
			}
			format(c_rank[users[playerid][u_clan]][GetPVarInt(playerid, "edit_rank")], 24, "%s", inputtext);
			new str_sql[156];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_rank%i` = '%s' WHERE `c_id` = '%i' LIMIT 1", GetPVarInt(playerid, "edit_rank")+1, inputtext, users[playerid][u_clan]);
			m_query(str_sql);
			if(GetPVarInt(playerid, "edit_rank")) DeletePVar(playerid, "edit_rank");
			server_accept(playerid, "�������� ����� ������� ��������.");
			callcmd::clan(playerid);
		}
	case d_clan_inv:
		{
			if(!response) return show_dialog ( playerid, d_clan_uninvite_offline, DIALOG_STYLE_INPUT, !"�������� ������ �� �����", !"\n{ffffff}������� ��� ������ ��� �������� ������� �� �����\n", !"�������", !"�����" ) ;
			show_dialog ( playerid, d_clan_uninvite, DIALOG_STYLE_INPUT, !"�������� ������ �� �����", !"\n{ffffff}������� �� ������ ��� �������� ��� �� �����\n", !"�������", !"�����" ) ;
		}
	case d_clan_uninvite_offline:
		{
			if(!response) return callcmd::clan(playerid);
			if(GetPlayerID(inputtext) != INVALID_PLAYER_ID) return server_error(playerid, "����� ������! (����������, ������� ���������� �������).");
			if(!strcmp(inputtext, clan[users[playerid][u_clan]][c_name])) return server_error(playerid, "������ ����� ������ �������.");
			new str_sql[156];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' AND `u_clan` = '%i' AND `u_name` != '%s' LIMIT 1", inputtext, users[playerid][u_clan], clan[users[playerid][u_clan]][c_owner]);
			new Cache:temp_sql_1 = m_query(str_sql), rows;
			cache_get_row_count(rows);
			if(rows)
			{
				m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan` = '0', `u_clan_rank` = '0' WHERE `u_name` = '%s' AND `u_clan` = '%i' LIMIT 1", inputtext, users[playerid][u_clan]);
				m_query(str_sql);
				SCMG(playerid, "����� %s ��� �������� �� �����.", inputtext);
			}
			else SCMASS(playerid, "����� %s �� ������. �������� ������ ����� �� ������� � ��� � �����!", inputtext);
			cache_delete(temp_sql_1);
		}
	case d_clan_uninvite:
		{
			if(!response) return callcmd::clan(playerid);
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						show_dialog ( playerid, d_clan_uninvite, DIALOG_STYLE_INPUT, !"�������� ������ � ����", "\n{ffffff}������� �� ������ ��� �������� ��� �� �����\n", !"�������", !"�����" ) ;
						server_error(playerid, "����������� ������ �����.");
						return true;
					}
				}
			}
			new invite_id = strval(inputtext);
			if(PlayerIsOnline(invite_id)) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
			if (users[invite_id][u_clan] != users[playerid][u_clan]) return server_error(playerid, "����� �� � ����� �����.");
			if(!strcmp (users[invite_id][u_name], clan[users[playerid][u_clan]][c_name]) || users[invite_id][u_clan_rank] == 5) return server_error(playerid, "������ ����� ������ �������.");

			users[invite_id][u_clan] = 0;
			users[invite_id][u_clan_rank] = 0;
			new str_sql[128];
			static str[156];
			format(str, sizeof(str), "[R][CLAN] %s %s ������ ���������� %s", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name], users[invite_id][u_name]);
			clan_message (users[playerid][u_clan], str);
			if (users[invite_id][u_donate_skin]) SetPlayerSkin(invite_id, users[invite_id][u_donate_skin]);
			else SetPlayerSkin(invite_id, users[invite_id][u_skin]);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan` = '0', `u_clan_rank` = '0' WHERE `u_id` = '%d' LIMIT 1", users[invite_id][u_id]);
			m_query(str_sql);
			foreach(Player, i) clan_syntax(i);
			SCMASS(invite_id, "%s �������� ��� �� ����� %s.", users[playerid][u_name], clan[users[playerid][u_clan]][c_name]);
			SCMG(playerid, "����� %s ��� �������� �� �����.", users[invite_id][u_name]);
			// new format_string[(7+1)+MAX_PLAYER_NAME+3];
			// format(format_string, sizeof(format_string), "%s (%i)", users[invite_id][u_name], invite_id);
			// Update3DTextLabelText(users_nickname[invite_id], -1, format_string);
			// Delete3DTextLabel(users_nickname[invite_id]);
			Update3DTextLabelText(users_nickname[invite_id], 0xAFEEEEFF, " ");
		}
	case d_clan_leave:
		{
			if(!response) return callcmd::clan(playerid);
			static str[156];
			format(str, sizeof(str), "[R][CLAN] %s %s ������� ����.", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name]);
			clan_message (users[playerid][u_clan], str);
			SCMG(playerid, "�� �������� ���� %s.", clan[users[playerid][u_clan]][c_name]);
			users[playerid][u_clan] = 0;
			users[playerid][u_clan_rank] = 0;
			// new format_string[(7+1)+MAX_PLAYER_NAME+3];
			// format(format_string, sizeof(format_string), "%s (%i)", users[playerid][u_name], playerid);
			// Update3DTextLabelText(users_nickname[playerid], -1, format_string);
			// Delete3DTextLabel(users_nickname[playerid]);
			
			Update3DTextLabelText(users_nickname[playerid], 0xAFEEEEFF, " ");
			if (users[playerid][u_donate_skin]) SetPlayerSkin(playerid, users[playerid][u_donate_skin]);
			else SetPlayerSkin(playerid, users[playerid][u_skin]);
			new str_sql[128];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan` = '0', `u_clan_rank` = '0' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_id]);
			m_query(str_sql);
			foreach(Player, i) clan_syntax(i);
		}
	case d_clan_invite:
		{
			if(!response) return callcmd::clan(playerid);
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						show_dialog ( playerid, d_clan_invite, DIALOG_STYLE_INPUT, !"�������� ������ � ����", "\n{ffffff}������� �� ������ ��� ����� ��� � ����\n", !"�������", !"�����" ) ;
						server_error(playerid, "����������� ������ �����.");
						return true;
					}
				}
			}
			new invite_id = strval(inputtext);
			//new Float: xyz[3];
			if(PlayerIsOnline(invite_id)) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
			if (users[invite_id][u_clan]) return server_error(playerid, "����� ��� ������� � �����.");
			//GetPlayerPos(playerid, xyz[0], xyz[1], xyz[2]);
			//if(!IsPlayerInRangeOfPoint(playerid, 5, xyz[0], xyz[1], xyz[2]) || 
			//GetPlayerVirtualWorld(invite_id) != GetPlayerVirtualWorld(playerid)) return server_error(playerid, "����� ������� ������.");
			if(GetPVarInt(playerid, "invite_player")) DeletePVar(playerid, "invite_player");
			if(GetPVarInt(playerid, "invite_leader")) DeletePVar(playerid, "invite_leader");
			SetPVarInt(playerid, "invite_player", invite_id);
			SetPVarInt(invite_id, "invite_leader", playerid);
			new str[76];
			format(str, sizeof(str), "\n{ffffff}��� ���������� � ���� %s\n������� ��� ��������� �����������\n", clan[users[playerid][u_clan]][c_name]);
			show_dialog(GetPVarInt(playerid, "invite_player"), d_clan_invite_player, DIALOG_STYLE_MSGBOX, !"����������� � ����", str, !"�������", !"��������" ) ;
		}
	case d_clan_invite_player:
		{
			if(!response)
			{
				SCMASS(playerid, "�� ���������� �� ����������� � ���� %s.", clan[users[GetPVarInt(playerid, "invite_leader")][u_clan]][c_name]);
				SCMASS(GetPVarInt(playerid, "invite_leader"), "����� %s ��������� �� ����������� � ����.", users[playerid][u_name]);
				callcmd::clan(playerid);
				return true;
			}
			SCMG(playerid, "�� ������� ����������� � ���� %s.", clan[users[GetPVarInt(playerid, "invite_leader")][u_clan]][c_name]);
			SCMG(GetPVarInt(playerid, "invite_leader"), "����� %s ������ ����������� � ����.", users[playerid][u_name]);
			if(PlayerIsOnline(GetPVarInt(playerid, "invite_leader"))) return server_error(playerid, "����� ������������ ��� �������������� � ����� �����.");
			users[playerid][u_clan] = users[GetPVarInt(playerid, "invite_leader")][u_clan];
			users[playerid][u_clan_rank] = 1;
			if (users[playerid][u_clan] && clan[users[playerid][u_clan]][c_skin] != 0) SetPlayerSkin(playerid, clan[users[playerid][u_clan]][c_skin]);
			new str_sql[128];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_clan` = '%i', `u_clan_rank` = '1' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_clan], users[playerid][u_id]);
			m_query(str_sql);
			static str[156];
			foreach(Player, i)
			{
				if(users[i][u_clan] != users[playerid][u_clan]) continue;
				// format(format_string, sizeof(format_string), "{AFEEEE}%s", clan[users[i][u_clan]][c_name_abbr], users[i][u_name], i);
				Update3DTextLabelText(users_nickname[i], 0xAFEEEEFF, clan[users[i][u_clan]][c_name_abbr]);
			}
			format(str, sizeof(str), "[R][CLAN] %s %s ������������� � �����.", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name]);
			clan_message (users[playerid][u_clan], str);
			foreach(Player, i) clan_syntax(i);
			server_accept(playerid, "�� ��������, ������� ����� � ������ ���������� ��������.");
			if(GetPVarInt(playerid, "invite_player")) DeletePVar(playerid, "invite_player");
			if(GetPVarInt(playerid, "invite_leader")) DeletePVar(playerid, "invite_leader");
		}
	case d_donate_vip:
		{
		    if(!response) return show_donate(playerid);
			if(get_player_donate(playerid) < 150) return server_error(playerid, " � ��� ������������ ������� ��� ������������ VIP �������");
			switch (users[playerid][u_vip_time])
			{
			case 0: server_accept(playerid, "�� ��������� {FFD700}������� VIP");
			default: server_accept(playerid, "�� �������� {FFD700}������� VIP");
			}
			users[playerid][u_vip_time] += 1296000;
			server_accept(playerid, "�����������: {FFD700}/vip");
			SaveAccountInt(playerid, "u_vip_time", users[playerid][u_vip_time]);
			new query_string [ 128 ] ;
			m_format ( query_string, sizeof ( query_string ),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'150' WHERE `u_id` = '%d' LIMIT 1", users[ playerid ] [ u_id ] ) ;
			m_query (query_string ) ;
			return true;
		}
	case d_vip:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					static str[200];
					format(str, sizeof(str), "\n\n\
					{ffffff}������ ��������: {FFD700}VIP\n\
					{ffffff}��������� ������� �����: {cccccc}%i ����� � %i �����\n\n\
					��� ��������� VIP ������� ����������� ''{ffffff}/donate{cccccc}''\n\n", users[playerid][u_vip_time]/3600,  (users[playerid][u_vip_time]-users[playerid][u_vip_time]/3600*3600)/60);
					show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"���������� � VIP �������", str, !"�������", !"");
				}
			case 1:
				{
					static str[200];
					format(str, sizeof(str), "�������\t������\n\
					{cccccc}1. {ffffff}���������� VIP ������ � ����\t%s",  (users[playerid][u_settings_vip][0])?("{33AA33}��������"):("{A52A2A}���������"));
					show_dialog(playerid, d_vip_settings, DIALOG_STYLE_TABLIST_HEADERS, !"��������� VIP �������", str, !"�������", !"�����");
				}
			}
		}
	case d_vip_settings:
		{
			if(!response) return callcmd::vip(playerid);
			switch (users[playerid][u_settings_vip][listitem])
			{
			case 0:
				{
					users[playerid][u_settings_vip][listitem] = 1;
					server_accept(playerid, "������� ��������.");
				}
			case 1:
				{
					users[playerid][u_settings_vip][listitem] = 0;
					server_error(playerid, "������� ���������.");
				}
			}
			SaveUser(playerid, "vip");
			static str[200];
			format(str, sizeof(str), "�������\t������\n\
			{cccccc}1. {ffffff}���������� VIP ������ � ����\t%s",  (users[playerid][u_settings_vip][0])?("{33AA33}��������"):("{A52A2A}���������"));
			show_dialog(playerid, d_vip_settings, DIALOG_STYLE_TABLIST_HEADERS, !"��������� VIP �������", str, !"�������", !"�����");
		}
	case d_settings_r:
		{
			if(!response) return ShowSettings(playerid);
			switch(listitem)
			{
			case 0:
				{
					show_dialog(playerid, d_settings_r, DIALOG_STYLE_LIST, !"����� �����", "{cccccc}�������� ����� ��� �����\n\
					{cccccc}1. {ffffff}����� �1\n\
					{cccccc}2. {ffffff}����� �2\n\
					{cccccc}3. {ffffff}����� �3\n\
					{cccccc}4. {ffffff}����� �4\n\
					{cccccc}5. {ffffff}����� �5\n\
					{cccccc}6. {ffffff}����� �6\n\
					{cccccc}7. {ffffff}����� �7\n\
					{cccccc}8. {ffffff}����� �8\n\
					{cccccc}9. {ffffff}����� �9\n\
					{cccccc}10. {ffffff}����� �10", !"�������", !"�����");
				}
			default:
				{
					users[playerid][u_settings][1] = listitem;
					SCMG(playerid, "����� ����� �������� �� �%i", users[playerid][u_settings][1]);
					SaveUser(playerid, "settings");
					ShowSettings(playerid);
				}
			}
		}
	case d_setname_accept:
		{
			new id_ = GetPVarInt(playerid, "changename");
			if(!strcmp(temp[id_][player_setname], "NoChangeName"))
			{
				server_error(playerid, "����� �� ����� ������ �� ����� ���� ��� ���������.");
				DeletePVar(playerid, "changename");
				return true;
			}
			if(!response)
			{
				AdminChatF("[A] %s %s ������� � ����� ���� ��� ������ %s (��� � ������: %s).", admin_rank_name(playerid), users[playerid][u_name], users[id_][u_name], temp[id_][player_setname]);
				server_error(id_, "������������� �������� � ����� ����.");
				show_dialog(id_, d_none, DIALOG_STYLE_MSGBOX, "����� ����", "\n������������� �������� ��� � ����� ����.\n", !"��", !"");
				static str_logs[96];
				format(str_logs, sizeof(str_logs), "������� � ����� ���� ��� ������ %s", users[id_][u_name]);
				logs_admin(playerid, str_logs, "/acceptname");
				format(temp[id_][player_setname], MAX_PLAYER_NAME, "NoChangeName");
				DeletePVar(playerid, "changename");
				return true;
			}
			static str_sql[256];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1", temp[id_][player_setname]);
			new Cache:temp_sql = m_query(str_sql), rows;
			cache_get_row_count(rows);
			if(rows)
			{
				AdminChatF("[A] %s %s ������� � ����� ���� ��� ������ %s (��� � ������: %s). �������: ��� ��� �����.", admin_rank_name(playerid), users[playerid][u_name], users[id_][u_name], temp[id_][player_setname]);
				server_error(id_, "������������� �������� � ����� ����.");
				show_dialog(id_, d_none, DIALOG_STYLE_MSGBOX, "����� ����", "\n������������� �������� ��� � ����� ����. ��� ��� �����!\n", !"��", !"");
				static str_logs[96];
				format(str_logs, sizeof(str_logs), "������� � ����� ���� ��� ������ %s (��� ��� �����)", users[id_][u_name]);
				logs_admin(playerid, str_logs, "/acceptname");
				format(temp[id_][player_setname], MAX_PLAYER_NAME, "NoChangeName");
				DeletePVar(playerid, "changename");
				return true;
			}
			cache_delete(temp_sql);
			users[id_][u_setname] -= 1;
			
			static string[128];
			format(string, sizeof(string), "[����������] ����� %s ������ �������� ��� ����� ����� %s", users[id_][u_name], temp[id_][player_setname]);
			server_errorToAll(string);

			AdminChatF("[A] %s %s ������� ����� ���� ��� ������ %s (��� � ������: %s).", admin_rank_name(playerid), users[playerid][u_name], users[id_][u_name], temp[id_][player_setname]);
			static str_logs[96];
			format(str_logs, sizeof(str_logs), "������� ����� ���� ��� ������ %s", users[id_][u_name]);
			logs_admin(playerid, str_logs, "/acceptname");
			if (users[id_][u_clan] > 0 && users[id_][u_clan_rank] == 5) format(clan[users[id_][u_clan]][c_owner], 24, "%s", temp[id_][player_setname]);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_name` = '%s' WHERE `u_id` = '%i' LIMIT 1", temp[id_][player_setname], users[id_][u_id]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_friend` = '%s' WHERE `u_friend` = '%s'", temp[id_][player_setname], users[id_][u_name]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_ADMINS_LOGS" SET `l_a_name` = '%s' WHERE `l_a_name` = '%s' LIMIT 1", temp[id_][player_setname], users[id_][u_name]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_BASE" SET `b_owner_name` = '%s' WHERE `b_owner_id` = '%i' LIMIT 1", temp[id_][player_setname], users[id_][u_id]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_ADMIN" SET `u_a_name` = '%s' WHERE `u_a_name` = '%s' LIMIT 1", temp[id_][player_setname], users[id_][u_name]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_BAN" SET `u_b_name` = '%s' WHERE `u_b_name` = '%s' LIMIT 1", temp[id_][player_setname], users[id_][u_name]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_BAN" SET `u_b_admin` = '%s' WHERE `u_b_admin` = '%s' LIMIT 1", temp[id_][player_setname], users[id_][u_name]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_BANIP" SET `u_b_ip_admin` = '%s' WHERE `u_b_ip_admin` = '%s' LIMIT 1", temp[id_][player_setname], users[id_][u_name]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_owner` = '%s' WHERE `c_owner` = '%s' LIMIT 1", temp[id_][player_setname], users[id_][u_name]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql),"UPDATE `freekassa_payments` SET `account` = '%s' WHERE `account` = '%s' LIMIT 1", temp[id_][player_setname], users[id_][u_name]);
			m_query(str_sql);
			m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_HISTORY_NAME" (`uh_id`, `uh_name_new`, `uh_name_old`, `uh_date`, `uh_ip`) VALUES ('%i', '%s', '%s', NOW(), '%s')", 
			users[id_][u_id], temp[id_][player_setname], users[id_][u_name], GetIp(id_));
			m_query(str_sql);
			static str[156];
			format(str, sizeof(str), "\n{33AA33}��� �������� ����� ����!\n{cccccc}��� ����� ���: {fffff0}%s\n����������� �� ������ � ������ �����!\n", temp[id_][player_setname]);
			show_dialog(id_, d_none, DIALOG_STYLE_MSGBOX, "����� ����", str, !"��", !"");
			TKICK(id_, "����������� � ����, �������������� ������ ���.");
			DeletePVar(playerid, "changename");
		}
	case d_setname:
		{
			if(!response) return ShowSettings(playerid);
			static str_sql[128];
			/*m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' LIMIT 1", users[playerid][u_name]);
			new Cache:temp_sql_1 = m_query(str_sql), r;
			cache_get_row_count(r);
			if(r) 
			{
				server_error(playerid, "�������������� ��������� ����� ����!");
				cache_delete(temp_sql_1);
				return true;
			}
			cache_delete(temp_sql_1); */
			if(CheckOfAdmin(playerid)) return server_error(playerid, "�������������� ��������� ����� ����!");
			if (users[playerid][u_setname] < 1)
			{
				server_error(playerid, "� ��� ��� ������� ��� ����� ����.");
				server_error(playerid, "������ ����� ���������� � /donate.");
				ShowSettings(playerid);
				return true;
			}
			if(strlen(inputtext) < 3 || strlen(inputtext) > 20)
			{
				server_error(playerid, "��� ������ ���� �� 3-� �� 20-�� ��������!");
				static str[356];
				format(str, sizeof(str), "\n\
				{fffff0}������� �������� ��� ����, ����� ����������:\n\
				{CD5C5C}1. {fffff0}��� ������ ���� �� ������������������.\n\
				{CD5C5C}2. {fffff0}��� ������ ���� �� 3-� �� 20-�� ��������.\n\
				{CD5C5C}3. {fffff0}��� ������ �������� ������ �� ��������� ����, ��� �� ����������� �����.\n\n");
				show_dialog(playerid, d_setname, DIALOG_STYLE_INPUT, !"����� ����", str, !"�������", "�����");
				return true;
			}
			for(new i = strlen(inputtext); i != 0; --i)
			{
				switch(inputtext[i])
				{
					case '�'..'�', '�'..'�', ' ', '=', '(', '_', ')', '{', '}', '[', ']', '"', ':', ';', '!', '@', '#', '$', '%', '^', 
					 '&', '?', '*', '-', '+', '/', ',', '.', '<', '>':
					{
						server_error(playerid, "��� ������ �������� ������ �� ��������� ����, ��� �� ����������� �����.");
						static str[356];
						format(str, sizeof(str), "\n\
						{fffff0}������� �������� ��� ����, ����� ����������:\n\
						{CD5C5C}1. {fffff0}��� ������ ���� �� ������������������.\n\
						{CD5C5C}2. {fffff0}��� ������ ���� �� 3-� �� 20-�� ��������.\n\
						{CD5C5C}3. {fffff0}��� ������ �������� ������ �� ��������� ����, ��� �� ����������� �����.\n\n");
						show_dialog(playerid, d_setname, DIALOG_STYLE_INPUT, !"����� ����", str, !"�������", "�����");
						return true;
					}
				}
			}
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1", inputtext);
			new Cache:temp_sql = m_query(str_sql), rows;
			cache_get_row_count(rows);
			if(rows)
			{
				server_error(playerid, "��� ������ ���� �� ������������������, �� ����� �������������� ���!");
				static str[356];
				format(str, sizeof(str), "\n\
				{fffff0}������� �������� ��� ����, ����� ����������:\n\
				{CD5C5C}1. {fffff0}��� ������ ���� �� ������������������.\n\
				{CD5C5C}2. {fffff0}��� ������ ���� �� 3-� �� 20-�� ��������.\n\
				{CD5C5C}3. {fffff0}��� ������ �������� ������ �� ��������� ����, ��� �� ����������� �����.\n\n");
				show_dialog(playerid, d_setname, DIALOG_STYLE_INPUT, !"����� ����", str, !"�������", "�����");
				return true;
			}
			cache_delete(temp_sql);
			foreach(Player, i)
			{
				if(!IsPlayerConnected(i)) continue;
				if(!strcmp(temp[i][player_setname], inputtext))
				{
					server_error(playerid, "��� ��������� ���� ������ ������ ����� � ������.");
					static str[356];
					format(str, sizeof(str), "\n\
					{fffff0}������� �������� ��� ����, ����� ����������:\n\
					{CD5C5C}1. {fffff0}��� ������ ���� �� ������������������.\n\
					{CD5C5C}2. {fffff0}��� ������ ���� �� 3-� �� 20-�� ��������.\n\
					{CD5C5C}3. {fffff0}��� ������ �������� ������ �� ��������� ����, ��� �� ����������� �����.\n\n");
					show_dialog(playerid, d_setname, DIALOG_STYLE_INPUT, !"����� ����", str, !"�������", "�����");
					return true;
				}
			}
			format(temp[playerid][player_setname], MAX_PLAYER_NAME, inputtext);
			server_accept(playerid, "������ �� ����� ���� ����������, �������� ������ ��� ��������� �� �������������.");
			server_accept(playerid, "�������, ���� �� ������� �� ����, �� ���� ������ ������������� �����������.");
			server_accept(playerid, "��� ���������������� ���������� ������, ����������� �������: /cancel.");
			AdminChat("[A][����� ����] ����� ������ �� ����� ����. �����������: /listname.", 4);
		}
	case d_settings_spawn:
		{
			if(!response) return ShowSettings(playerid);
			switch(listitem)
			{
			case 0:
				{
					show_dialog(playerid, d_settings_spawn, DIALOG_STYLE_LIST, !"����� ���������", "{cccccc}�������� ����� ��������� ����� ������\n\
					{cccccc}1. {ffffff}��������� ����� ���������\n\
					{cccccc}2. {ffffff}�������� ����� ���������\n\
					{cccccc}3. {ffffff}������ ����� ���������\n", !"�������", !"�����");
					// {cccccc}4. {ffffff}����� ��������� �� ����
				}
			default:
				{
					// new count = listitem-1;
					switch(listitem)
					{
					case 1:
						{
							if(!users[playerid][u_clan]) 
							{
								server_error(playerid, "�� �� �������� � �����.");
								ShowSettings(playerid);
								return true;
							}
						}
					case 2:
						{
							if(!users[playerid][u_donate_spawn]) 
							{
								server_error(playerid, "� ��� ��� ������ ����� ������.");
								ShowSettings(playerid);
								return true;
							}
							else if (users[playerid][u_donate_spawn] == 1) 
							{
								server_error(playerid, "���� ������ ����� ������ �� ��������.");
								ShowSettings(playerid);
								return true;
							}
						}
					}
					users[playerid][u_settings][2] = listitem;
					new name_spawn[(25+1)];
					switch (users[playerid][u_settings][2])
					{
					case 0: name_spawn = "{cccccc}�������� �����";
					case 1: name_spawn = "{98FB98}�������� �����";
					case 2: name_spawn = "{FFFACD}������ �����";
					// case 3: name_spawn = "{FFFACD}������� ���������";
					}
					SCMG(playerid, "����� ��������� �������� �� %s", name_spawn);
					SaveUser(playerid, "settings");
					ShowSettings(playerid);
				}
			}
		}
	case d_security:
		{
			if(!response) return callcmd::menu(playerid);
			switch(listitem)
			{
			case 0: 
				{
					if(!users[playerid][u_email_status]) return show_dialog(playerid, d_security_old_pass, DIALOG_STYLE_INPUT, !"����� ������", "\n{ffffff}������� ���� ������� ������:\n", !"��", !"�����");
					EmailMessage(playerid, users[playerid][u_email], "��� ��� ������������� ����� ������");
					show_dialog(playerid, d_security_email_pass, DIALOG_STYLE_INPUT, !"����� ������", "\n{ffffff}� ��� ��������� �����! ������ ��� ������� ������ ������� ��� ���� ������������ �� �����:\n", !"��", !"�����");
				}
			case 1: 
				{
					if(!users[playerid][u_email_status]) return show_dialog(playerid, d_security_email, DIALOG_STYLE_INPUT, !"����� (Email)", "\n{ffffff}����� ��������� �����, ������� ����� ����:\n", !"��", !"�����");
					ShowSecurity(playerid);
				}
			case 2:
				{
					if(!users[playerid][u_email_status]) return server_error(playerid, "��� ��������� ������ Google Authenticator, ���������� ��������� �����.");
					if(!strcmp(users[playerid][u_googleauth], "NoGoogleAuth", false))
					{
						EmailMessage(playerid, users[playerid][u_email], "��� ��� ��������� Google Authenticator");
						show_dialog(playerid, d_security_email_googleauth, DIALOG_STYLE_INPUT, !"Google Authenticator", "\n{ffffff}� ��� ��������� �����! ������ ��� �������� ������ ������� ��� ������������ �� �����:\n", !"��", !"�����");
						return true;
					}
					show_dialog(playerid, d_security_googleauth_off, DIALOG_STYLE_INPUT, !"Google Authenticator", "\n{ffffff}��� ���������� ������ Google Authenticator, ������� ���� ���:\n", !"��", !"�����");
				}
			case 3:
				{
					if(!users[playerid][u_email_status]) return server_error(playerid, "��� ��������� ���-����, ���������� ��������� �����.");
					if(!strcmp (users[playerid][u_code], "NoCode", false))
					{
						EmailMessage(playerid, users[playerid][u_email], "��� ��� ��������� ���-����");
						show_dialog(playerid, d_security_email_cod, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}� ��� ��������� �����! ������ ��� �������� ������ ������� ��� ������������ �� �����:\n", !"��", !"�����");
						return true;
					}
					show_dialog(playerid, d_security_code_off, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}��� ���������� ������ ���-���, ������� ���� ���-���:\n", !"��", !"�����");
				}
			/*case 4:
				{
					if(!strcmp (users[playerid][u_email], "NoEmail", false)) return server_error(playerid, "��� ��������� ��������������� ����� ������, ���������� ��������� �����.");
					else 
					{
						switch (users[playerid][u_connect_ip])
						{
						case 0:
							{
								users[playerid][u_connect_ip] = 1;
								server_error(playerid, "�� �������� �������������� ����� ������.", 1);
								server_error(playerid, "������ ����� ������������� ��� ����� IP.", 1);
							}
						case 1:
							{
								users[playerid][u_connect_ip] = 0;
								server_error(playerid, "�� ��������� �������������� ����� ������.");
							}
						}
						static str_sql[165];
						m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_connect_ip` = '%i' WHERE `u_name` = '%s' AND `u_id` = '%i' LIMIT 1", users[playerid][u_connect_ip], users[playerid][u_name], users[playerid][u_id]);
						m_query(str_sql);
						ShowSecurity(playerid);
					}
				}*/
			case 4:
				{
					if(!users[playerid][u_email_status]) return server_error(playerid, "����� ����������� ������ � ����� � ������, ���������� ��������� �����.");
					static str_sql[168];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS_LOGIN" WHERE `u_i_owner` = '%i' ORDER BY `u_i_id` DESC LIMIT 15", users[playerid][u_id]);
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						global_string[0] = EOS;
						new str[128], info_satus, info_date[30], info_ip[MAX_PLAYER_NAME];
						for(new idx = 1; idx <= rows; idx++)
						{
							cache_get_value_name(idx-1, "u_i_date", info_date, 30);
							cache_get_value_name(idx-1, "u_i_ip", info_ip, MAX_PLAYER_NAME);
							cache_get_value_name_int(idx-1, "u_i_status", info_satus);
							switch(info_satus)
							{
							case 0: format(str, sizeof(str), "{cccccc}%i. {A52A2A}��������� ����������� {ffffff}| {cccccc}����: %s {ffffff}| {cccccc}IP: %s\n", idx, info_date, info_ip);
							case 1: format(str, sizeof(str), "{cccccc}%i. {33AA33}�������� ����������� {ffffff}| {cccccc}����: %s {ffffff}| {cccccc}IP: %s\n", idx, info_date, info_ip);
							}
							strcat(global_string, str);
						}
						show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"���������� � �����", global_string, !"��", !"");
					}
					else server_error(playerid, "���������� ������ �� �������.");
					cache_delete(temp_sql);
				}
			}
		}
	case d_security_code_off:
		{
			if(!response) return ShowSecurity(playerid);
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						server_error(playerid, "���-��� ������ �������� ������ �� ����.");
						show_dialog(playerid, d_security_code_off, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}��� ���������� ������ ���-���, ������� ���� ���-���:\n", !"��", !"�����");
						return true;
					}
				}
			}
			if(strlen(inputtext) != 5) 
			{
				show_dialog(playerid, d_security_code_off, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}��� ���������� ������ ���-���, ������� ���� ���-���:\n", !"��", !"�����");
				server_error(playerid, "���-��� ������ ��������� 5 ����.");
				return true;
			}
			if(strcmp(users[playerid][u_code], inputtext, false))
			{
				show_dialog(playerid, d_security_code_off, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}��� ���������� ������ ���-���, ������� ���� ���-���:\n", !"��", !"�����");
				server_error(playerid, "���-��� ������ �� �����.");
				return true;
			}
			format (users[playerid][u_googleauth], 17, "NoCode");
			static str_sql[165];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_code` = 'NoCode' WHERE `u_name` = '%s' AND `u_id` = '%i' LIMIT 1", users[playerid][u_name], users[playerid][u_id]);
			m_query(str_sql);
			server_error(playerid, "�� �������� ���-���");
		}
	case d_security_email_cod:
		{
			if(!response) return ShowSecurity(playerid);
			if(strcmp(temp[playerid][temp_email_code], inputtext))
			{
				server_error(playerid, "������ �� ������ ���.");
				show_dialog(playerid, d_security_email_cod, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}� ��� ��������� �����! ������ ��� �������� ������ ������� ��� ������������ �� �����:\n", !"��", !"�����");
				return true;
			}
			show_dialog(playerid, d_security_code, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}���������� � ������� ���� ���-���\n\n���-��� - ��� ��� ������������ ���, ������� �� ������� ���������.\n��� ���-���� �� �� ������� ������ �����������.\n\n1. ���-��� ������ �������� �� 5 ����.\n2. �� ����������� � ���-��� ���� ���� ��������\n3. ����������� � ���-���� ������ ������� ���������� ����.\n", !"��", !"�����");
		}
	case d_security_code:
		{
			if(!response) return ShowSecurity(playerid);
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						server_error(playerid, "���-��� ������ �������� ������ �� ����.");
						show_dialog(playerid, d_security_code, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}���������� � ������� ���� ���-���\n\n���-��� - ��� ��� ������������ ���, ������� �� ������� ���������.\n��� ���-���� �� �� ������� ������ �����������.\n\n1. ���-��� ������ �������� �� 5 ����.\n2. �� ����������� � ���-��� ���� ���� ��������\n3. ����������� � ���-���� ������ ������� ���������� ����.\n", !"��", !"�����");
						return true;
					}
				}
			}
			if(strlen(inputtext) != 5) 
			{
				show_dialog(playerid, d_security_code, DIALOG_STYLE_INPUT, !"���-���", "\n{ffffff}���������� � ������� ���� ���-���\n\n���-��� - ��� ��� ������������ ���, ������� �� ������� ���������.\n��� ���-���� �� �� ������� ������ �����������.\n\n1. ���-��� ������ �������� �� 5 ����.\n2. �� ����������� � ���-��� ���� ���� ��������\n3. ����������� � ���-���� ������ ������� ���������� ����.\n", !"��", !"�����");
				server_error(playerid, "���-��� ������ ��������� 5 ����.");
				return true;
			}
			EmailMessage(playerid, users[playerid][u_email], "� ������ �������� ��� �������� ���-���", 1, users[playerid][u_name]);
			server_accept(playerid, "�� ��������� ���-���");
			format (users[playerid][u_code], 8, inputtext);
			static str_sql[165];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_code` = '%s' WHERE `u_name` = '%s' AND `u_id` = '%i' LIMIT 1", users[playerid][u_code], users[playerid][u_name], users[playerid][u_id]);
			m_query(str_sql);
		}
	case d_googleauth:
		{
			if(!response) return TKICK(playerid, "�� ���������� �� ����� ���� � Google Authenticator");
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						server_error(playerid, "��� ������ �������� ������ �� ����.");
						show_dialog(playerid, d_googleauth, DIALOG_STYLE_INPUT, !"Google Authenticator", "\n{ffffff}��� ����������� ����������� ������� 6-�� ������� ��� � {33AA33}Google Authenticator'a.\n", !"��", !"������");
						return true;
					}
				}
			}
			new code = GoogleAuthenticatorCode (users[playerid][u_googleauth], gettime());
			if(code != strval(inputtext))
			{
				AddUserLogin(playerid, 0);
				TKICK(playerid, "������ �� ������ ��� � Google Authenticator.");
				//show_dialog(playerid, d_googleauth, DIALOG_STYLE_INPUT, !"Google Authenticator", "\n{ffffff}��� ����������� ����������� ������� 6-�� ������� ��� � {33AA33}Google Authenticator'a.\n", !"��", !"������");
				return true;
			}
			if(strcmp (users[playerid][u_code], "NoCode", false))
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
			else if(!strcmp (users[playerid][u_code], "NoCode", false)) return LoadPlayer(playerid);
		}
	case d_security_googleauth_off:
		{
			if(!response) return ShowSecurity(playerid);
			if(GoogleAuthenticatorCode(users[playerid][u_googleauth], gettime()) != strval(inputtext))
			{
				server_error(playerid, "������ �� ������ ���.");
				show_dialog(playerid, d_security_googleauth_off, DIALOG_STYLE_INPUT, !"Google Authenticator", "\n{ffffff}��� ���������� ������ Google Authenticator, ������� ���� ���:\n", !"��", !"�����");
				return true;
			}
			format (users[playerid][u_googleauth], 17, "NoGoogleAuth");
			static str_sql[165];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_googleauth` = 'NoGoogleAuth' WHERE `u_name` = '%s' AND `u_id` = '%i' LIMIT 1", users[playerid][u_name], users[playerid][u_id]);
			m_query(str_sql);
			server_error(playerid, "�� �������� Google Authenticator");
		}
	case d_security_email_googleauth:
		{
			if(!response) return ShowSecurity(playerid);
			if(strcmp(temp[playerid][temp_email_code], inputtext))
			{
				server_error(playerid, "������ �� ������ ���.");
				show_dialog(playerid, d_security_email_googleauth, DIALOG_STYLE_INPUT, !"Google Authenticator", "\n{ffffff}� ��� ��������� �����! ������ ��� �������� ������ ������� ��� ������������ �� �����:\n", !"��", !"�����");
				return true;
			}
			new Password_GA[18];
			new RANDOM_GA[32][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y","Z","2", "3", "4", "5", "6", "7"};
			for(new i = 0; i < 17; i ++) strcat(Password_GA, RANDOM_GA[random(sizeof(RANDOM_GA))]);
			format(temp[playerid][googleauth], 17, Password_GA);
			static str[356];
			format(str, sizeof(str), "\n{ffffff}��� �������� Google Authenticator'a, ������� � Google Authenticator\n{bd787d}���: %s\n\n{ffffff}����� ������� ���� 6-�� ������� ��� � Google Authenticator'a.\n(������� �������� � ��� �� ������ ��������, ����� ����� � Google Authenticator ����, ������� ������� ����)\n", temp[playerid][googleauth]);
			show_dialog(playerid, d_security_googleauth, DIALOG_STYLE_INPUT, !"Google Authenticator", str, !"��", !"�����");
		}
	case d_security_googleauth:
		{
			if(!response)
			{
				format (users[playerid][u_googleauth], 17, "NoGoogleAuth");
				ShowSecurity(playerid);
				return true;
			}
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						server_error(playerid, "������ �� ������ ���.");
						static str[356];
						format(str, sizeof(str), "\n{ffffff}��� �������� Google Authenticator'a, ������� � Google Authenticator\n{bd787d}���: %s\n\n{ffffff}����� ������� ���� 6-�� ������� ��� � Google Authenticator'a.\n(������� �������� � ��� �� ������ ��������, ����� ����� � Google Authenticator ����, ������� ������� ����)\n", temp[playerid][googleauth]);
						show_dialog(playerid, d_security_googleauth, DIALOG_STYLE_INPUT, !"Google Authenticator", str, !"��", !"�����");
						return true;
					}
				}
			}
			if(GoogleAuthenticatorCode(temp[playerid][googleauth], gettime()) != strval(inputtext))
			{
				server_error(playerid, "������ �� ������ ���.");
				static str[356];
				format(str, sizeof(str), "\n{ffffff}��� �������� Google Authenticator'a, ������� � Google Authenticator\n{bd787d}���: %s\n\n{ffffff}����� ������� ���� 6-�� ������� ��� � Google Authenticator'a.\n(������� �������� � ��� �� ������ ��������, ����� ����� � Google Authenticator ����, ������� ������� ����)\n", temp[playerid][googleauth]);
				show_dialog(playerid, d_security_googleauth, DIALOG_STYLE_INPUT, !"Google Authenticator", str, !"��", !"�����");
				return true;
			}
			EmailMessage(playerid, users[playerid][u_email], "� ������ �������� ��� �������� Google Authenticator", 1, users[playerid][u_name]);
			server_accept(playerid, "�� ��������� Google Authenticator");
			format(users[playerid][u_googleauth], 17, temp[playerid][googleauth]);
			static str_sql[165];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_googleauth` = '%s' WHERE `u_name` = '%s' AND `u_id` = '%i'", users[playerid][u_googleauth], users[playerid][u_name], users[playerid][u_id]);
			m_query(str_sql);
		}
	case d_security_email_pass:
		{
			if(!response) return ShowSecurity(playerid);
			if(strcmp(temp[playerid][temp_email_code], inputtext))
			{
				server_error(playerid, "������ �� ������ ���.");
				show_dialog(playerid, d_security_email_pass, DIALOG_STYLE_INPUT, !"����� ������", "\n{ffffff}� ��� ��������� �����! ������ ��� ������� ������ ������� ��� ���� ������������ �� �����:\n", !"��", !"�����");
				return true;
			}
			show_dialog(playerid, d_security_old_pass, DIALOG_STYLE_INPUT, !"����� ������", "\n{ffffff}������� ���� ������� ������:\n", !"��", !"�����");
		}
	case d_security_email:
		{
			if(!response) return ShowSecurity(playerid);
			if(users[playerid][u_email_status])
			{
				server_error(playerid, "� ��� ��� ��������� �������������� �����.");
				ShowSecurity(playerid);
				return true;
			}
			if(!IsValidEMail(inputtext))
			{
				server_error(playerid, "�� �������� ��� ����� �����.");
				show_dialog(playerid, d_security_email, DIALOG_STYLE_INPUT, !"����� (Email)", "\n{ffffff}����� ��������� �����, ������� ����� ����:\n", !"��", !"�����");
				return true;
			}
			for(new i = strlen(inputtext); i != 0; --i)
			{
				switch(inputtext[i])
				{
					case '�'..'�', '�'..'�', ' ', '=':
					{
						show_dialog(playerid, d_security_email, DIALOG_STYLE_INPUT, !"����� (Email)", "\n{ffffff}����� ��������� �����, ������� ����� ����:\n", !"��", !"�����");
						server_error(playerid, "����������� ������ ��������� ����� � �����.");
						return true;
					}
				}
			}
			if(strlen(inputtext) < 4 || strlen(inputtext) > 65) 
			{
				show_dialog(playerid, d_security_email, DIALOG_STYLE_INPUT, !"����� (Email)", "\n{ffffff}����� ��������� �����, ������� ����� ����:\n", !"��", !"�����");
				server_error(playerid, "������ ������ ��������� �� 4 �� 65 ��������.");
				return true;
			}
			format(users[playerid][u_email], 65, inputtext);
			EmailMessage(playerid, users[playerid][u_email], "��� ��� ������������� �����");
			show_dialog(playerid, d_security_email_code, DIALOG_STYLE_INPUT, !"����� (Email)", "\n{ffffff}������� ��� � ����� ������������ ��� �� �����:\n", !"��", !"�����");
		}
	case d_security_email_code:
		{
			if(!response) return ShowSecurity(playerid);
			if(strcmp(temp[playerid][temp_email_code], inputtext))
			{
				server_error(playerid, "������ �� ������ ���.");
				show_dialog(playerid, d_security_email_code, DIALOG_STYLE_INPUT, !"����� (Email)", "\n{ffffff}������� ��� � ����� ������������ ��� �� �����:\n", !"��", !"�����");
				return true;
			}
			users[playerid][u_email_status] = 1;
			EmailMessage(playerid, users[playerid][u_email], "�� ������� ��������� ���� � ��������", 1, users[playerid][u_name]);
			SCMG(playerid, "���������� ��� �� �������� ����� � ��������: %s", users[playerid][u_email]);
			static str_sql[196];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_email` = '%s', `u_email_status` = '1' WHERE `u_name` = '%s' AND `u_id` = '%i' LIMIT 1", users[playerid][u_email], users[playerid][u_name], users[playerid][u_id]);
			m_query(str_sql);
		}
	case d_security_old_pass:
		{
			if(!response) return ShowSecurity(playerid);
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
				case '�'..'�', '�'..'�', ' ', '=':
				{
					show_dialog(playerid, d_security_old_pass, DIALOG_STYLE_INPUT, !"����� ������", "\n{ffffff}������� ���� ������� ������:\n", !"��", !"�����");
					server_error(playerid, "����������� ������ ��������� ����� � �����.");
					return true;
				}
			}
			if(strlen(inputtext) < 6 || strlen(inputtext) > 32)
			{
				show_dialog(playerid, d_security_old_pass, DIALOG_STYLE_INPUT, !"����� ������", "\n{ffffff}������� ���� ������� ������:\n", !"��", !"�����");
				server_error(playerid, "������ ������ ��������� �� 6 �� 32 ��������.");
				return true;
			}
			static str_sql[165];
			m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_id` = '%i' AND `u_name` = '%s' AND `u_password` = MD5('%e') LIMIT 1", users[playerid][u_id], users[playerid][u_name], inputtext);
			new Cache:temp_sql = m_query(str_sql), rows;
			cache_get_row_count(rows);
			if(!rows)
			{
				show_dialog(playerid, d_security_old_pass, DIALOG_STYLE_INPUT, !"����� ������", "\n{ffffff}������� ���� ������� ������:\n", !"��", !"�����");
				server_error(playerid, "������ �� ������ ������.");
				cache_delete(temp_sql);
				return true;
			}
			show_dialog(playerid, d_security_new_pass, DIALOG_STYLE_INPUT, !"����� ������", "���������� ������\n\n{33AA33}- {FFFFFF}������ ������ �������� �� ��������� ����, � ��� �� ����\n{33AA33}- {FFFFFF}����� ������ �� 6-�� �� 32-� ��������", !"��", !"�����");
			cache_delete(temp_sql);
		}
	case d_security_new_pass:
		{
			if(!response) return ShowSecurity(playerid);
			for(new i = strlen(inputtext); i != 0; --i)
			switch(inputtext[i])
			{
				case '�'..'�', '�'..'�', ' ', '=':
				{
					show_dialog(playerid, d_security_new_pass, DIALOG_STYLE_INPUT, !"����� ������", "���������� ������\n\n{B22222}- {FFFFFF}������ ������ �������� �� ��������� ����, � ��� �� ����\n{33AA33}- {FFFFFF}����� ������ �� 6-�� �� 32-� ��������", !"��", !"�����");
					server_error(playerid, "����������� ������ ��������� ����� � �����.");
					return true;
				}
			}
			if(strlen(inputtext) < 6 || strlen(inputtext) > 32)
			{
				show_dialog(playerid, d_security_new_pass, DIALOG_STYLE_INPUT, !"����� ������", "���������� ������\n\n{33AA33}- {FFFFFF}������ ������ �������� �� ��������� ����, � ��� �� ����\n{B22222}- {FFFFFF}����� ������ �� 6-�� �� 32-� ��������", !"��", !"�����");
				server_error(playerid, "������ ������ ��������� �� 6 �� 32 ��������.");
				return true;
			}
			if(strcmp (users[playerid][u_email], "NoEmail", false)) EmailMessage(playerid, users[playerid][u_email], "�� ����� �������� ������� ������� ������.\n��� ����� ������ �� ��������", 1, inputtext);
			SCMG(playerid, "��� ����� ������ �� ��������: %s", inputtext);
			static str_sql[165];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_password` = MD5('%s') WHERE `u_name` = '%s' AND `u_id` = '%i' LIMIT 1", inputtext, users[playerid][u_name], users[playerid][u_id]);
			m_query(str_sql);
		}
	case d_settings:
		{
			if(!response) return callcmd::menu(playerid);
			switch(listitem)
			{
			case 1: 
				{
					show_dialog(playerid, d_settings_r, DIALOG_STYLE_LIST, !"����� �����", "{cccccc}�������� ����� ��� �����\n\
					{cccccc}1. {ffffff}����� �1\n\
					{cccccc}2. {ffffff}����� �2\n\
					{cccccc}3. {ffffff}����� �3\n\
					{cccccc}4. {ffffff}����� �4\n\
					{cccccc}5. {ffffff}����� �5\n\
					{cccccc}6. {ffffff}����� �6\n\
					{cccccc}7. {ffffff}����� �7\n\
					{cccccc}8. {ffffff}����� �8\n\
					{cccccc}9. {ffffff}����� �9\n\
					{cccccc}10. {ffffff}����� �10", !"�������", !"�����");
				}
			case 2:
				{
					show_dialog(playerid, d_settings_spawn, DIALOG_STYLE_LIST, !"����� ���������", "{cccccc}�������� ����� ��������� ����� ������\n\
					{cccccc}1. {ffffff}��������� ����� ���������\n\
					{cccccc}2. {ffffff}�������� ����� ���������\n\
					{cccccc}3. {ffffff}������ ����� ���������\n\
					", !"�������", !"�����");
					// {cccccc}4. {ffffff}����� ��������� �� ����
				}
			case 4:
				{
					if (users[playerid][u_setname] < 1)
					{
						server_error(playerid, "� ��� ��� ������� ��� ����� ����.");
						server_error(playerid, "������ ����� ���������� � /donate.");
						ShowSettings(playerid);
						return true;
					}
					/*static str_sql[165];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' AND `c_change_spawn` = '1' AND `c_change_spawn_xyzfwi` != '0, 0, 0, 0, 0, 0' LIMIT 1", GetPVarInt(playerid, "AdminClanSpawn"));
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					

					cache_delete(temp_sql);*/
					if(strcmp(temp[playerid][player_setname], "NoChangeName"))
					{
						static str[196];
						format(str, sizeof(str), "��� � ������ �� �����: {fffff0}%s\n�� ��� ������ ������ �� ����� ����, �������� ��������� ������.\n\n{cccccc}��� ������ ������, ����������� ������� /cancel", 
						temp[playerid][player_setname]);
						show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"����� ����", str, !"��", "");
						return true;
					}
					static str[356];
					format(str, sizeof(str), "\n\
					{fffff0}������� �������� ��� ����, ����� ����������:\n\
					{CD5C5C}1. {fffff0}��� ������ ���� �� ������������������.\n\
					{CD5C5C}2. {fffff0}��� ������ ���� �� 3-� �� 20-�� ��������.\n\
					{CD5C5C}3. {fffff0}��� ������ �������� ������ �� ��������� ����, ��� �� ����������� �����.\n\n");
					show_dialog(playerid, d_setname, DIALOG_STYLE_INPUT, !"����� ����", str, !"�������", "�����");
				}
			default:
				{
					switch (users[playerid][u_settings][listitem])
					{
					case 0:
						{
							users[playerid][u_settings][listitem] = 1;
							server_error(playerid, "������� ���������.");
						}
					case 1:
						{
							users[playerid][u_settings][listitem] = 0;
							server_accept(playerid, "������� ��������.");
						}
					}
					SaveUser(playerid, "settings");
					ShowSettings(playerid);
				}
			}
		}
	case d_menu:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: inventory_use(playerid);
			case 1: ShowStats(playerid, playerid);
			case 2: callcmd::report(playerid);
			case 3: ShowSecurity(playerid);
			case 4: ShowSettings(playerid);
			//case 5: callcmd::admins(playerid);
			case 5: callcmd::animation(playerid, "");
			case 6: ShowProgress(playerid);
			case 7: callcmd::craft(playerid);
			case 8: callcmd::donate(playerid);
			case 9: 
				{
					show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"� �������", !"\n\
					{FFE4B5}����: {FFFFE0}"SITE_NAME"\n\
					{FFE4B5}�����: {FFFFE0}"FORU_NAME"\n\
					{FFE4B5}������ � VK: {FFFFE0}"VKON_NAME"\n\n\
					{cccccc}"FULL_NAME" 2019", !"OK", !""); 
				}
			case 10: callcmd::friends(playerid);
			}
		}
	case d_takedrop:
		{
			if(!response) return ClearAnimLoop(playerid);
			users[playerid][PlayertoItem] = listitem;
			if(!user_items[playerid][users[playerid][PlayertoItem]][item_use_id]) return server_error(playerid, "��� ���-�� �������� ���� �������!");
			ClearAnimLoop(playerid);
			if (users[playerid][u_slots] >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������");
			SCMG(playerid, "{7bc078}%s {ffffff}�������(�/�) ��� � ���������.", loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name]);

			switch(user_items[playerid][users[playerid][PlayertoItem]][item_use_id])
			{
			case 18..25, 63..65, 75..76: AddItem(playerid, LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LData], LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LCount]);
			default: AddItem(playerid, LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LData], 1, LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LCount]);
			}
			
			user_items[playerid][users[playerid][PlayertoItem]][item_use_id] = 0;
			user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity] = 0;
			
			DestroyDynamicObject(LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LIndexObj]);
			LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LPos][0] = 0.0;
			LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LPos][1] = 0.0;
			LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LPos][2] = 0.0;
			LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LIndexObj] = -1;
			LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LData] = 0;
			LootInfo[user_items[playerid][users[playerid][PlayertoItem]][item_use_value]][LCount] = 0;
			users[playerid][u_loot]++;
			Equipment(playerid);
			return true;
		}
    case d_anticheat_menu: // ������� ���� ��������� ����-����
        {
            if(!response) // ���� ����� ������ ������
            {
                pAntiCheatSettingsPage{playerid} = 0; // ����������� �������� 0 ����������, �������� ����� �������� �������� ����-����, �� ������� ��������� �����
                return 1; // ��������� ������
            }

            if(!strcmp(inputtext, AC_DIALOG_NEXT_PAGE_TEXT)) // ���� ����� ����� �� ������ �������������� �� ��������� ��������
            {
                pAntiCheatSettingsPage{playerid}++; // �������������� (���������� 1) �������� ����������, �������� ����� �������� �������� ����-����, �� ������� ��������� �����
            }
            else if(!strcmp(inputtext, AC_DIALOG_PREVIOUS_PAGE_TEXT)) // ���� ����� ����� �� ������ �������������� �� ���������� ��������
            {
                pAntiCheatSettingsPage{playerid}--; // �������������� (�������� 1) �������� ����������, �������� ����� �������� �������� ����-����, �� ������� ��������� �����
            }
            else // ���� ����� ������ �����-���� �� ����� ����-����
            {
                pAntiCheatSettingsEditCodeId[playerid] = pAntiCheatSettingsMenuListData[playerid][listitem]; // ����������� ����������, �������� ����� ���� ����-����, ������� ����������� �����, ����� ����, ������� �� ������
                return ShowPlayer_AntiCheatEditCode(playerid, pAntiCheatSettingsEditCodeId[playerid]); // ���������� ������ ������ ��������� ���� ����-����
            }
            return ShowPlayer_AntiCheatSettings(playerid); // ��������� � ������ ��������� � ���������� ��������. ������ ���������� ������ ������� ���� ��������� ����-����.
        }
    case d_anticheat_settings: // ���� ��������� ������������ ���� ����-����
        {
            if(!response) // ���� ����� ������ ������
            {
                pAntiCheatSettingsEditCodeId[playerid] = -1; // ����������� ����������, �������� ������������� (ID) ���� ����-����, ������� ����������� �����, �������� -1
                return ShowPlayer_AntiCheatSettings(playerid); // ���������� ������ ������� ���� �������� ����-����
            }

            new item = pAntiCheatSettingsEditCodeId[playerid]; // ������ ��������� ���������� item, ������� ������ �������� ���� ����-����, ������� ����������� �����

            if(anticheat[item][ac_code_trigger_type] == listitem) // ���� ����� �������� ��������� ���� ��� ����������� ��� ��� ������������
                return ShowPlayer_AntiCheatSettings(playerid); // ���������� ������� ���� �������� ����-����

            if(anticheat[item][ac_code_trigger_type] == 0 && listitem != 0)
                EnableAntiCheat(item, 1);

            anticheat[item][ac_code_trigger_type] = listitem; // ���� �� ����� ������ ������ ��� ������������ - ����������� ��� ����������

            new
                sql_query[101 - 4 + 1 + 2];

            // ����������� ������ �� ���������� ������ ��������� ���� ����-���� � ���� ������
            m_format(sql_query, sizeof(sql_query), "UPDATE "TABLE_ANTICHEAT" SET `ac_code_trigger_type` = '%d' WHERE `ac_code` = '%d'", listitem, item);
            m_query(sql_query); 
            return ShowPlayer_AntiCheatSettings(playerid); // ���������� ������� ���� �������� ����-����
        }
	case d_ban:
		{
			if(!response) return TKICK(playerid, "��� ������� ������������.");
			if(get_player_donate(playerid) < 200)
			{
				server_error(playerid, "� ��� ������������ ������� ��� ������ ���������� � ��������.");
				server_error(playerid, "{cccccc}> {ffffff}��������� ���� ����� �� ����� ����� {cccccc}"SITE_NAME".");
				static str[128];
				m_format(str, sizeof(str), "SELECT * FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW() LIMIT 1", users[playerid][u_name]);
				m_tquery(str, "@CheckPlayerBan", "i", playerid);
				return true;
			}
			server_accept(playerid, "�� ����� ��� � ��������.");
			static str[128];
			m_format(str, sizeof(str), "UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'200' WHERE `u_id` = '%d' LIMIT 1", users[playerid][u_id]);
			m_query(str);
			m_format(str, sizeof(str), "DELETE FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW()", users[playerid][u_name]);
			m_query(str);
			PlayerBan[playerid] = 0;
			TogglePlayerSpectating(playerid, false);
			TogglePlayerControllable(playerid, true);
			temp[playerid][temp_login] = true;
			LoadingForUser(playerid, 1);
			SetSpawnInfo(playerid, 0, 0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0);
			SpawnPlayer(playerid);
		}
	case d_ban_ip:
		{
			if(!response) return TKICK(playerid, "��� ip-����� ������������.");
			if(get_player_donate(playerid) < 200)
			{
				server_error(playerid, "� ��� ������������ ������� ��� ������ ���������� � ip-������.");
				server_error(playerid, "{cccccc}> {ffffff}��������� ���� ����� �� ����� ����� {cccccc}"SITE_NAME".");
				static str[128];
				static str_ip[20];
				GetPlayerIp(playerid, str_ip, MAX_PLAYER_NAME);
				m_format(str, sizeof(str), "SELECT * FROM "TABLE_BANIP" WHERE `u_b_ip` = '%s' AND `u_b_ip_date` > NOW() LIMIT 1", str_ip);
				m_tquery(str, "@CheckPlayerBanIP", "i", playerid);
				return true;
			}
			static str[128];
			static str_ip[20];
			GetPlayerIp(playerid, str_ip, MAX_PLAYER_NAME);
			m_format(str, sizeof(str), "UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'200' WHERE `u_name` = '%s' LIMIT 1", users[playerid][u_name]);
			m_query(str);
			m_format(str, sizeof(str), "DELETE FROM "TABLE_BANIP" WHERE `u_b_ip` = '%s' AND `u_b_ip_date` > NOW()", str_ip);
			m_query(str);
			static const size_str[] = "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1";
			new str_sql[sizeof(size_str)+MAX_PLAYER_NAME];
			m_format(str_sql, sizeof(str_sql), size_str, users[playerid][u_name]);
			m_tquery(str_sql, "OnPlayerCheck", "i", playerid);
		}
	case d_box_take:
		{
			if(!response) return BoxFunctions(playerid);
			if(temp[playerid][player_box] == -1) return true;
			new box_number = temp[playerid][player_box];
			users[playerid][PlayertoItem] = listitem;
			if (users[playerid][u_slots] >= users[playerid][u_backpack]*10)
			{
				BoxFunctions(playerid);
				server_error(playerid, "��� ��������� �����, ��������� ���-������!");
				return true;
			}
			if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
			
			new check_item = 0;
			if(check_item) check_item = 0;
				
			for(new z = 0; z < INVENTORY_USE; z++)
			{
				if(!box_items[temp[playerid][player_box]][z][item_id]) continue;
				if(box_items[temp[playerid][player_box]][z][item_id] != box_items[box_number][users[playerid][PlayertoItem]][item_use_id]) continue;
				if(!box_items[temp[playerid][player_box]][z][item_value]) continue;
				check_item++;
				break;
			}
			if(!check_item)
			{
				BoxFunctions(playerid);
				server_error(playerid, "��������, ���-�� ��� ���� ���� �������!");
				return true;
			}
			SCMG(playerid, "�� �����:{808000} %s.", loots[box_items[box_number][users[playerid][PlayertoItem]][item_use_id]][loot_name]);
			
			switch(box_items[temp[playerid][player_box]][users[playerid][PlayertoItem]][item_use_id])
			{
			case 18..25, 63..65, 75..76: AddItem(playerid, box_items[box_number][users[playerid][PlayertoItem]][item_use_id], box_items[box_number][users[playerid][PlayertoItem]][item_use_quantity]);
			default: AddItem(playerid, box_items[box_number][users[playerid][PlayertoItem]][item_use_id], 1, box_items[box_number][users[playerid][PlayertoItem]][item_use_quantity]);
			}

			RemoveItemFromBox(box_number, box_items[box_number][users[playerid][PlayertoItem]][item_use_id], box_items[box_number][users[playerid][PlayertoItem]][item_use_quantity]);
			
			box[box_number][box_slots]--;
			SaveBox(box_number);
			EquipmentBox(playerid); 
		}
	case d_box_castle:
		{
			if(!response) return true;
			if(!GetItem(playerid, 40)) return server_error(playerid, "� ��� ��� ������ ������������.");
			for(new b = 1; b < MAX_BOX; b++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.5, box[b][box_xyzf][0], box[b][box_xyzf][1], box[b][box_xyzf][2]) && box[b][box_id])
				{
					if(strcmp(box[b][box_pass], "NoBoxPass1234"))
					{
						format(box[b][box_pass], MAX_PLAYER_NAME, "1234");
						server_error(playerid, "���������� ������ ��� �����: {cccccc}1234");
						box[b][box_lock] = 1;
						RemoveItem(playerid, 108);
						
						break;
					}
				}
			}
		}
	case d_box_code:
		{
			if(!response) return temp[playerid][player_box] = -1, true;
			if(temp[playerid][player_box] == -1) return true;
			new box_number = temp[playerid][player_box];
			if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
			if(!strlen(inputtext) || strcmp(box[box_number][box_pass], inputtext, false))
			{
				static str[96]; 
				format(str, sizeof(str), "{FF0000}�� ����� ������� ������ �� %s�!\n{FFFFFF}���������� ��� ���!", boxname[box[box_number][box_type]][box_name]);
				show_dialog(playerid, d_box_code, DIALOG_STYLE_PASSWORD, boxname[box[box_number][box_type]][box_name], str, !"�������", !"������");	
				return true;	
			}
			SCMG(playerid, "%s ������.", boxname[box[box_number][box_type]][box_name]);
			box[box_number][box_lock] = 0;
			BoxFunctions(playerid);
			SaveBox(box_number);
		}
	case d_box_1:
		{
			if(!response) return temp[playerid][player_box] = -1, true;
			switch(listitem)
			{
			case 0: EquipmentBox(playerid); // �����
			case 1: PutBox(playerid); // ��������
			case 2:
				{
					if(temp[playerid][player_box] == -1) return true;
					new box_number = temp[playerid][player_box];
					if(!GetItem(playerid, 40))
					{
						BoxFunctions(playerid);
						server_error(playerid, "� ��� ��� ������ ������������.");
						return true;
					}
					static str[128];
					format(str, sizeof(str), "�� ����� ������ ��������� %s?\n{ff0000}��� ���� � ���, ����� ����������!", boxname[box[box_number][box_type]][box_name]);
					show_dialog(playerid, d_box_delete, DIALOG_STYLE_MSGBOX, boxname[box[box_number][box_type]][box_name], str, !"��", !"������");
				}
			case 3: //���������� �����
				{
					if(temp[playerid][player_box] == -1) return true;
					new box_number = temp[playerid][player_box];
					if(!GetItem(playerid, 40))
					{
						BoxFunctions(playerid);
						server_error(playerid, "� ��� ��� ������ ������������.");
						return true;
					}
					if(!GetItem(playerid, 108))
					{
						BoxFunctions(playerid);
						server_error(playerid, "� ��� ��� �������� �����.");
						return true;
					}
					format(box[box_number][box_pass], MAX_PLAYER_NAME, "1234");
					server_accept(playerid, "�� ���������� ������� �����, ����������� ������: {cccccc}1234");
					
					RemoveItem(playerid, 108);
					box[box_number][box_lock] = 1;
					SaveBox(box_number);
				}
			}
		}
	case d_box_put:
		{
			if(!response) return BoxFunctions(playerid);
			if(temp[playerid][player_box] == -1) return true;
			new box_number = temp[playerid][player_box];
			if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
			users[playerid][PlayertoItem] = listitem;//s(box)//BoxSlot[i][vSlotBox]--; dBoxData[i][bSlot]
			if(box[box_number][box_slots] >= boxname[box[box_number][box_type]][box_max_slots])
			{
				SCMASS(playerid, "%s ����������! ������������ ���������� ������ %i!", boxname[box[box_number][box_type]][box_name], boxname[box[box_number][box_type]][box_max_slots]);
				BoxFunctions(playerid);
				return true;
			}
			
			switch(user_items[playerid][users[playerid][PlayertoItem]][item_use_id])
			{
			case 18..25, 63..65, 75..76: AddBoxItem(box_number, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			default: AddBoxItem(box_number, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], 1, user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			}

			/*switch(user_items[playerid][users[playerid][PlayertoItem]][item_use_id])
			{
			case 18..25, 63..65, 75..76: AddBoxItem(box_number, box_items[box_number][users[playerid][PlayertoItem]][item_use_id], box_items[box_number][users[playerid][PlayertoItem]][item_use_quantity]);
			default: AddBoxItem(box_number, box_items[box_number][users[playerid][PlayertoItem]][item_use_id], 1, box_items[box_number][users[playerid][PlayertoItem]][item_use_quantity]);
			}*/
			box[box_number][box_slots]++;
			if (users[playerid][PlayertoItem] == 51 && temp[playerid][temp_use_map]) 
			{
				TextDrawHideForPlayer(playerid, Mapen_S);
				temp[playerid][temp_use_map] = false;
				for(new d; d < sizeof(MapLine); d++) { TextDrawHideForPlayer(playerid, MapLine[d]); }
				for(new f; f < CountIcon; f++) { TextDrawHideForPlayer(playerid, MapIcon[f]); } 
			}
			
			RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			SCMG(playerid, "�� �������� � %s: {808000}%s{ffffff}.", boxname[box[box_number][box_type]][box_name], loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name]);
			PutBox(playerid);
			SaveBox(box_number);
		}/*
	case d_box_put:
		{
			if(!response) return true;
			new Float: POS[3];
			new i = AntiBagAutoDoop[playerid];
			GetCoordBootVehicle(i, POS[0], POS[1], POS[2]);
			if(!IsPlayerInRangeOfPoint(playerid, 1.5, POS[0], POS[1], POS[2])) return server_error(playerid, "�� ������ ���� ����� � ����.");
			if(car_boot{i} == VEHICLE_PARAMS_OFF) return server_error(playerid, "�������� ������.");
			users[playerid][PlayertoItem] = listitem;
			if(CarInfo[i][car_the_trunk] >= 100) return server_error(playerid, "�������� ����������!");
			CarInfo[i][car_the_trunk]++;
			// CarInfo[i][car_the_trunk_info][users[playerid][PlayertoItem]]++;
			
			switch(user_items[playerid][users[playerid][PlayertoItem]][item_use_id])
			{
			case 18..25, 63..65, 75..76: AddVehicleItem(i, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			default: AddVehicleItem(i, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], 1, user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			}
			if(i != GetPVarInt(playerid, "admin_vehicle")) SaveVehicle(i);
			if(user_items[playerid][users[playerid][PlayertoItem]][item_use_id] == 51 && temp[playerid][temp_use_map]) 
			{
				TextDrawHideForPlayer(playerid, Mapen_S),temp[playerid][temp_use_map] = false;
				for(new d; d<sizeof(MapLine); d++) { TextDrawHideForPlayer(playerid, MapLine[d]); }
				for(new f; f<CountIcon; f++) { TextDrawHideForPlayer(playerid, MapIcon[f]); } 
			}
			RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			
			SCMG(playerid, "�� �������� � ��������: {808000}%s{ffffff}.", loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name]);
			PutVehicle(playerid);
		}*/
	case d_box_change_code:
		{
			if(!response) return temp[playerid][player_box] = -1, true;
			if(temp[playerid][player_box] == -1) return true;
			new box_number = temp[playerid][player_box];
			if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
			if(!strlen(inputtext) || strcmp(box[box_number][box_pass], inputtext, false))
			{
				static str[96]; 
				format(str, sizeof(str), "{FF0000}�� ����� ������� ������ �� %s�!\n{FFFFFF}���������� ��� ���!", boxname[box[box_number][box_type]][box_name]);
				show_dialog(playerid, d_box_code, DIALOG_STYLE_INPUT, boxname[box[box_number][box_type]][box_name], str, !"�������", !"������");	
				return true;	
			}
			show_dialog(playerid, d_box_change_code_2, DIALOG_STYLE_INPUT, boxname[box[box_number][box_type]][box_name], !"\n������� ����� ������\n{FF0000}������ ������ ����:\n\t{FF0000}- ������ �� ���� ��� ��������� ����;\n\t{FF0000}- �� ������ 24 � �� ������ 4 ��������.\n", !"����", !"�����");
		}
	case d_box_change_code_2:
		{
			if(!response) return BoxFunctions(playerid);
			if(temp[playerid][player_box] == -1) return true;
			new box_number = temp[playerid][player_box];
			if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
			if(strlen(inputtext) <= 3 || strlen(inputtext) >= 24) 
			{
				show_dialog(playerid, d_box_change_code_2, DIALOG_STYLE_INPUT, boxname[box[box_number][box_type]][box_name], !"\n������� ����� ������\n{FF0000}������ ������ ����:\n\t{FF0000}- ������ �� ���� ��� ��������� ����;\n\t{FF0000}- �� ������ 24 � �� ������ 4 ��������.\n", !"����", !"�����");
				return true;
			}
			for(new iy = strlen(inputtext); iy != 0; --iy)
			switch(inputtext[iy]) 
			{
			case '�'..'�', '�'..'�', '=', ' ','%','}','{': 
				{
					show_dialog(playerid, d_box_change_code_2, DIALOG_STYLE_INPUT, boxname[box[box_number][box_type]][box_name], !"\n������� ����� ������\n{FF0000}������ ������ ����:\n\t{FF0000}- ������ �� ���� ��� ��������� ����;\n\t{FF0000}- �� ������ 24 � �� ������ 4 ��������.\n", !"����", !"�����");
					return true;
				}
			}
			format(box[box_number][box_pass], MAX_PLAYER_NAME, inputtext);
			SCMG(playerid, "�� �������� ������ �� %s'�! ������: %s", boxname[box[box_number][box_type]][box_name], box[box_number][box_pass]);
			BoxFunctions(playerid);
			SaveBox(box_number);
		}
	case d_box_2:
		{
			if(!response) return temp[playerid][player_box] = -1, true;
			switch(listitem)
			{
			case 0: EquipmentBox(playerid); //�����
			case 1: PutBox(playerid);//��������
			case 2: //�������� ������
				{
					if(temp[playerid][player_box] == -1) return true;
					new box_number = temp[playerid][player_box];
					if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
					show_dialog(playerid, d_box_change_code, DIALOG_STYLE_INPUT, boxname[box[box_number][box_type]][box_name], !"\n������� ������� ������ ��� ��� �����\n", !"����", !"�����");
				}
			case 3://�������
				{
					if(temp[playerid][player_box] == -1) return true;
					new box_number = temp[playerid][player_box];
					if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
					SCMG(playerid, "�� ������� %s.", boxname[box[box_number][box_type]][box_name]);
					box[box_number][box_lock] = 1;
					SaveBox(box_number);
				}
			}
		}
	case d_box_3:
		{
			if(!response) return temp[playerid][player_box] = -1, true;
			switch(listitem)
			{
			case 0: EquipmentBox(playerid); //�����
			case 1: PutBox(playerid);//��������
			case 2: //�������� ������
				{
					if(temp[playerid][player_box] == -1) return true;
					new box_number = temp[playerid][player_box];
					if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
					show_dialog(playerid, d_box_change_code, DIALOG_STYLE_INPUT, boxname[box[box_number][box_type]][box_name], !"\n������� ������� ������ ��� ��� �����\n", !"����", !"�����");
				}
			case 3:
				{
					if(temp[playerid][player_box] == -1) return true;
					new box_number = temp[playerid][player_box];
					if(!GetItem(playerid, 40))
					{
						BoxFunctions(playerid);
						server_error(playerid, "� ��� ��� ������ ������������.");
						return true;
					}
					static str[128];
					format(str, sizeof(str), "�� ����� ������ ��������� %s?\n{ff0000}��� ���� � ���, ����� ����������!", boxname[box[box_number][box_type]][box_name]);
					show_dialog(playerid, d_box_delete, DIALOG_STYLE_MSGBOX, boxname[box[box_number][box_type]][box_name], str, !"��", !"������");
				}
			case 4: //�������
				{
					if(temp[playerid][player_box] == -1) return true;
					new box_number = temp[playerid][player_box];
					if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
					SCMG(playerid, "�� ������� %s.", boxname[box[box_number][box_type]][box_name]);
					box[box_number][box_lock] = 1;
					SaveBox(box_number);
				}
			}
		}
	case d_box_delete:
		{
			if(!response) return BoxFunctions(playerid);
			if(temp[playerid][player_box] == -1) return true;
			new box_number = temp[playerid][player_box];
			if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[box_number][box_xyzf][0], box[box_number][box_xyzf][1], box[box_number][box_xyzf][2])) return true;
			if(!GetItem(playerid, 40))
			{
				BoxFunctions(playerid);
				server_error(playerid, "� ��� ��� ������ ������������.");
				return true;
			}
			if (users[playerid][u_slots] >= users[playerid][u_backpack]*10) 
			{
				BoxFunctions(playerid);
				server_error(playerid, "��� ��������� �����, ��������� ���-������!");
				return true;
			}
			SCMG(playerid, "%s �������� � ������� ��� � ���������.", boxname[box[box_number][box_type]][box_name]);
			switch(box[box_number][box_type])
			{
			case 0: AddItem(playerid, 77, 1);
			case 1: AddItem(playerid, 109, 1);
			case 2: AddItem(playerid, 110, 1);
			}
			if(strcmp(box[box_number][box_pass], "NoBoxPass1234")) AddItem(playerid, 108, 1);
			
			box[box_number][box_type] = 0;
			box[box_number][box_lock] = 0;
			box[box_number][box_slots] = 0;
			box[box_number][box_xyzf][0] = 0;
			box[box_number][box_xyzf][1] = 0;
			box[box_number][box_xyzf][2] = 0;
			DestroyDynamicObject(box[box_number][box_object]);
			new str_sql[128];
			m_format(str_sql, sizeof(str_sql), "DELETE FROM "TABLE_BOX" WHERE `box_id` = '%i' LIMIT 1", box[box_number][box_id]);
			m_query(str_sql);
			temp[playerid][player_box] = -1;
		}
	case d_clan_change_spawn:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{	
					static str_sql[165];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_id` = '%i' AND `c_change_spawn` = '1' AND `c_change_spawn_xyzfwi` != '0, 0, 0, 0, 0, 0' LIMIT 1", GetPVarInt(playerid, "AdminClanSpawn"));
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						SPP(playerid, GetPVarFloat(playerid, "AdminClanSpawnX"), GetPVarFloat(playerid, "AdminClanSpawnY"), GetPVarFloat(playerid, "AdminClanSpawnZ"), GetPVarFloat(playerid, "AdminClanSpawnF"), GetPVarInt(playerid, "AdminClanSpawnW"), GetPVarInt(playerid, "AdminClanSpawnI"));
						SCMG(playerid, "�� ����������������� �� ''������������� ����� ������ ������ �%i''.", GetPVarInt(playerid, "AdminClanSpawn"));
						SCMG(playerid, "����������� ��� ��� /changeclanspawn %i", GetPVarInt(playerid, "AdminClanSpawn"));
					}
					else SCMASS(playerid, "���� �%i �� ������� ��� ��� �������� ������ �� ����� ������.", GetPVarInt(playerid, "AdminClanSpawn"));
					cache_delete(temp_sql);
				}
			case 1:
				{
					static str_sql[256];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_id` = '%i' AND `c_change_spawn` = '1' AND `c_change_spawn_xyzfwi` != '0, 0, 0, 0, 0, 0' LIMIT 1", GetPVarInt(playerid, "AdminClanSpawn"));
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						static owner[MAX_PLAYER_NAME];
						cache_get_value_name(0, "c_owner", owner, MAX_PLAYER_NAME);
						m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CLAN" SET `c_change_spawn` = '0', `c_spawn_xyzfwi` = '%f, %f, %f, %f, %i, %i', `c_change_spawn_xyzfwi` = '0, 0, 0, 0, 0, 0' WHERE `c_id` = '%i'", 
						GetPVarFloat(playerid, "AdminClanSpawnX"), GetPVarFloat(playerid, "AdminClanSpawnY"), GetPVarFloat(playerid, "AdminClanSpawnZ"), GetPVarFloat(playerid, "AdminClanSpawnF"), GetPVarInt(playerid, "AdminClanSpawnW"), GetPVarInt(playerid, "AdminClanSpawnI"), GetPVarInt(playerid, "AdminClanSpawn"));
						m_query(str_sql);
						clan[GetPVarInt(playerid, "AdminClanSpawn")][c_spawn_xyzf][0] = GetPVarFloat(playerid, "AdminClanSpawnX");
						clan[GetPVarInt(playerid, "AdminClanSpawn")][c_spawn_xyzf][1] = GetPVarFloat(playerid, "AdminClanSpawnY");
						clan[GetPVarInt(playerid, "AdminClanSpawn")][c_spawn_xyzf][2] = GetPVarFloat(playerid, "AdminClanSpawnZ");
						clan[GetPVarInt(playerid, "AdminClanSpawn")][c_spawn_xyzf][3] = GetPVarFloat(playerid, "AdminClanSpawnF");
						clan[GetPVarInt(playerid, "AdminClanSpawn")][c_spawn_wi][0] = GetPVarInt(playerid, "AdminClanSpawnW");
						clan[GetPVarInt(playerid, "AdminClanSpawn")][c_spawn_wi][1] = GetPVarInt(playerid, "AdminClanSpawnI");
						AdminChatF("[A] %s %s ������� ����� ������ ��� ����� %s(�%i).", admin_rank_name(playerid), users[playerid][u_name], clan[GetPVarInt(playerid, "AdminClanSpawn")][c_name], GetPVarInt(playerid, "AdminClanSpawn"));
						if(GetPlayerID(owner) != INVALID_PLAYER_ID)
						{
							server_error(GetPlayerID(owner), "������������� �������� ������ ����� ����� ������.");
							show_dialog(GetPlayerID(owner), d_none, DIALOG_STYLE_MSGBOX, "����", "\n������������� �������� ������ ����� ����� ������.\n", !"��", !"");
						}
						else 
						{
							m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' AND `u_clan` = '%i' LIMIT 1", owner, GetPVarInt(playerid, "AdminClanSpawn"));
							new Cache:temp_sql1 = m_query(str_sql), rows_two;
							cache_get_row_count(rows_two);
							static number;
							cache_get_value_name_int(0, "u_id", number);
							AddMessage(number, "������ ������ �� ����� ������: {33AA33}��������");
							cache_delete(temp_sql1);
						}
						clan_message(GetPVarInt(playerid, "AdminClanSpawn"), "[R][CLAN] ������������� �������� ������ ����� ����� ������.");
						
						static str_logs[96];
						format(str_logs, sizeof(str_logs), "������� ����� ������ ��� ����� �%i", GetPVarInt(playerid, "AdminClanSpawn"));
						logs_admin(playerid, str_logs, "/changeclanspawn");
					}
					else SCMASS(playerid, "���� �%i �� ������� ��� ��� �������� ������ �� ����� ������.", GetPVarInt(playerid, "AdminClanSpawn"));
					cache_delete(temp_sql);
				}
			case 2:
				{
					static str_sql[256];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_id` = '%i' AND `c_change_spawn` = '1' AND `c_change_spawn_xyzfwi` != '0, 0, 0, 0, 0, 0' LIMIT 1", GetPVarInt(playerid, "AdminClanSpawn"));
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						static owner[MAX_PLAYER_NAME];
						cache_get_value_name(0, "c_owner", owner, MAX_PLAYER_NAME);
						m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CLAN" SET `c_change_spawn` = '0', `c_change_spawn_xyzfwi` = '0, 0, 0, 0, 0, 0' WHERE `c_id` = '%i'", GetPVarInt(playerid, "AdminClanSpawn"));
						m_query(str_sql);
						AdminChatF("[A] %s %s ������� � ����� ������ ��� ����� %s(�%i).", admin_rank_name(playerid), users[playerid][u_name], clan[GetPVarInt(playerid, "AdminClanSpawn")][c_name], GetPVarInt(playerid, "AdminClanSpawn"));
						if(GetPlayerID(owner) != INVALID_PLAYER_ID)
						{
							server_error(GetPlayerID(owner), "������������� �������� ������ ������ ����� � ����� ������.");
							show_dialog(GetPlayerID(owner), d_none, DIALOG_STYLE_MSGBOX, "����", "\n������������� �������� ������ ����� � ����� ������.\n", !"��", !"");
						}
						else 
						{
							m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' AND `u_clan` = '%i' LIMIT 1", owner, GetPVarInt(playerid, "AdminClanSpawn"));
							new Cache:temp_sql1 = m_query(str_sql), rows_two;
							cache_get_row_count(rows_two);
							static number;
							cache_get_value_name_int(0, "u_id", number);
							AddMessage(number, "������ ������ �� ����� ������: {A52A2A}��������");
							cache_delete(temp_sql1);
						}
						
						static str_logs[96];
						format(str_logs, sizeof(str_logs), "������� � ����� ������ ��� ����� �%i", GetPVarInt(playerid, "AdminClanSpawn"));
						logs_admin(playerid, str_logs, "/changeclanspawn");
					}
					else SCMASS(playerid, "���� �%i �� ������� ��� ��� �������� ������ �� ����� ������.", GetPVarInt(playerid, "AdminClanSpawn"));
					cache_delete(temp_sql);
				}
			}
		}
	case d_change_spawn:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{	
					static str_sql[165];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_id` = '%i' AND `u_donate_spawn` = '1' AND `u_donate_spawn_xyzwi` != '0.0, 0.0, 0.0, 0.0, 0, 0' LIMIT 1", GetPVarInt(playerid, "AdminSpawn"));
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						SPP(playerid, GetPVarFloat(playerid, "AdminSpawnX"), GetPVarFloat(playerid, "AdminSpawnY"), GetPVarFloat(playerid, "AdminSpawnZ"), GetPVarFloat(playerid, "AdminSpawnF"), GetPVarInt(playerid, "AdminSpawnW"), GetPVarInt(playerid, "AdminSpawnI"));
						SCMG(playerid, "�� ����������������� �� ''������������� ����� ������ �%i''.", GetPVarInt(playerid, "AdminSpawn"));
						SCMG(playerid, "����������� ��� ��� /changespawn %i", GetPVarInt(playerid, "AdminSpawn"));
					}
					else SCMASS(playerid, "����� �������� �%i �� ������� ��� ��� �������� ������ �� ����� ������.", GetPVarInt(playerid, "AdminSpawn"));
					cache_delete(temp_sql);
				}
			case 1:
				{
					static str_sql[256];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_id` = '%i' AND `u_donate_spawn` = '1' AND `u_donate_spawn_xyzwi` != '0.0, 0.0, 0.0, 0.0, 0, 0' LIMIT 1", GetPVarInt(playerid, "AdminSpawn"));
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						static owner[MAX_PLAYER_NAME];
						cache_get_value_name(0, "u_name", owner, MAX_PLAYER_NAME);
						m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_id` = '%i' AND `u_donate` < 50 LIMIT 1", GetPVarInt(playerid, "AdminSpawn"));
						new Cache:temp_sql1 = m_query(str_sql), rows1;
						cache_get_row_count(rows1);
						if(rows1)
						{
							if(GetPlayerID(owner) != INVALID_PLAYER_ID)
							{
								new id = GetPlayerID(owner);
								server_error(id, "������������� �������� � ������ ����� ������.");
								show_dialog(id, d_none, DIALOG_STYLE_MSGBOX, "����� ������", "\n������ ������ �� ������ ����� ������: {A52A2A}��������. \n{cccccc}� ��� ������������ �������� ������� �� �������!\n", !"��", !"");
							}
							else 
							{
								AddMessage(GetPVarInt(playerid, "AdminSpawn"), "������ ������ �� ������ ����� ������: {A52A2A}��������. {cccccc}� ��� ������������ �������� ������� �� �������!");
							}
							server_error(playerid, "����� ��������� ��������� ��-�� ��������� �������� ������� � ������.");
							cache_delete(temp_sql);
							cache_delete(temp_sql1);
							return true;
						}
						cache_delete(temp_sql1);
						m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_donate_spawn` = '2', `u_donate_spawn_xyzwi` = '%f, %f, %f, %f, %i, %i' WHERE `u_id` = '%i'", 
						GetPVarFloat(playerid, "AdminSpawnX"), GetPVarFloat(playerid, "AdminSpawnY"), GetPVarFloat(playerid, "AdminSpawnZ"), GetPVarFloat(playerid, "AdminSpawnF"), GetPVarInt(playerid, "AdminSpawnW"), GetPVarInt(playerid, "AdminSpawnI"), GetPVarInt(playerid, "AdminSpawn"));
						m_query(str_sql);
						AdminChatF("[A] %s %s ������� ������ ����� ������ ��� %s (�%i).", admin_rank_name(playerid), users[playerid][u_name], owner, GetPVarInt(playerid, "AdminSpawn"));
						m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'50' WHERE `u_id` = '%i' LIMIT 1", GetPVarInt(playerid, "AdminSpawn"));
						m_query(str_sql);
						if(GetPlayerID(owner) != INVALID_PLAYER_ID)
						{
							new id = GetPlayerID(owner);
							users[id][u_donate_spawn_xyzf][0] = GetPVarFloat(playerid, "AdminSpawnX");
							users[id][u_donate_spawn_xyzf][1] = GetPVarFloat(playerid, "AdminSpawnY");
							users[id][u_donate_spawn_xyzf][2] = GetPVarFloat(playerid, "AdminSpawnZ");
							users[id][u_donate_spawn_xyzf][3] = GetPVarFloat(playerid, "AdminSpawnF");
							users[id][u_donate_spawn_wi][0] = GetPVarInt(playerid, "AdminSpawnW");
							users[id][u_donate_spawn_wi][1] = GetPVarInt(playerid, "AdminSpawnI");
							users[id][u_donate_spawn] = 2;

							server_accept(id, "������������� �������� ��� ������ ����� ������.");
							show_dialog(id, d_none, DIALOG_STYLE_MSGBOX, "����� ������", "\n������������� �������� ��� ������ ����� ������.\n", !"��", !"");
						}
						else AddMessage(GetPVarInt(playerid, "AdminSpawn"), "������ ������ �� ������ ����� ������: {33AA33}��������");
						static str_logs[96];
						format(str_logs, sizeof(str_logs), "������� ������ ����� ������ ��� �������� �%i", GetPVarInt(playerid, "AdminSpawn"));
						logs_admin(playerid, str_logs, "/changespawn");
					}
					else SCMASS(playerid, "����� �������� �%i �� ������� ��� ��� �������� ������ �� ������ ����� ������.", GetPVarInt(playerid, "AdminSpawn"));
					cache_delete(temp_sql);
				}
			case 2:
				{
					static str_sql[256];
					m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_id` = '%i' AND `u_donate_spawn` = '1' AND `u_donate_spawn_xyzwi` != '0.0, 0.0, 0.0, 0.0, 0, 0' LIMIT 1", GetPVarInt(playerid, "AdminSpawn"));
					new Cache:temp_sql = m_query(str_sql), rows;
					cache_get_row_count(rows);
					if(rows) 
					{
						static owner[MAX_PLAYER_NAME];
						cache_get_value_name(0, "c_owner", owner, MAX_PLAYER_NAME);
						m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_USERS" SET `u_donate_spawn` = '0', `u_donate_spawn_xyzwi` = '0.0, 0.0, 0.0, 0.0, 0, 0' WHERE `u_id` = '%i'", GetPVarInt(playerid, "AdminSpawn"));
						m_query(str_sql);
						AdminChatF("[A] %s %s ������� � ������ ����� ������ ��� %s (�%i).", admin_rank_name(playerid), users[playerid][u_name], owner, GetPVarInt(playerid, "AdminSpawn"));
						if(GetPlayerID(owner) != INVALID_PLAYER_ID)
						{
							users[GetPlayerID(owner)][u_donate_spawn] = 0;
							server_error(GetPlayerID(owner), "������������� �������� � ������ ����� ������.");
							show_dialog(GetPlayerID(owner), d_none, DIALOG_STYLE_MSGBOX, "����� ������", "\n������������� �������� � ������ ����� ������.\n", !"��", !"");
						}
						else 
						{
							AddMessage(GetPVarInt(playerid, "AdminSpawn"), "������ ������ �� ����� ������: {A52A2A}��������");
						}
						static str_logs[96];
						format(str_logs, sizeof(str_logs), "������� � ������ ����� ������ ��� �������� �%i", GetPVarInt(playerid, "AdminSpawn"));
						logs_admin(playerid, str_logs, "/changespawn");
					}
					else SCMASS(playerid, "����� �������� �%i �� ������� ��� ��� �������� ������ �� ������ ����� ������.", GetPVarInt(playerid, "AdminSpawn"));
					cache_delete(temp_sql);
				}
			}
		}
	case d_achievements_back: ShowProgress(playerid);
	case d_achievements:
		{
			if(!response) return callcmd::menu(playerid);
			switch(listitem)
			{
			case 0:
				{
					static get_achieve;
					if(get_achieve) get_achieve = 0;
					for(new z = 0; z != sizeof(achievements); z++) 
					{
						if (users[playerid][u_achievement][z] == 1) get_achieve++;
					}
					if(!get_achieve) return show_dialog(playerid, d_achievements_back, DIALOG_STYLE_MSGBOX, !"���� ����������", "� ��� ��� ���������� ����������.", !"�����", !"");
					static str[96], numb;
					global_string[0] = EOS;
					strcat(global_string, "������ ����� ����������:\n\n");
					if(numb) numb = 0;
					for(new z = 0; z != sizeof(achievements); z++) 
					{
						if (users[playerid][u_achievement][z] == 1) 
						{
							numb++;
							format(str, sizeof(str), "{cccccc}%i. {4682B4}%s\n", numb, achievements[z][achievement_name]);
							strcat(global_string, str);
						}
					}
					show_dialog(playerid, d_achievements_back, DIALOG_STYLE_MSGBOX, !"���� ����������", global_string, !"�����", !"");
				}
			case 1:
				{
					static str[1300];
					format(str, sizeof(str), "{fffff0}\ 
					������ ��� ���������� �������� �� �������� ������ �������\n\ 
					�������� � ���������� �� ������������� �� �������� ����������.\n\n\ 
					��� ����� ������� ���� ����������, ���� � ������� �� ����������:\n\n\ 
					{cccccc}1.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}��������� %i �������{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}2.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}��������� %i �������{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}3.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}��������� %i �������{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}4.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}��������� %i �������{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\n\ 
					{fffff0}��� ������� �������� ����� ����� ���������� ��������� ����������.\n\ 
					��� ���������� ���� ���������� � ��� ������� �����, � ��� ����� ���������� � ��������� ����������.", 
					achievements[0][achievement_name], achievements[0][achievement_progress], achievements[0][achievement_about],  (users[playerid][u_achievement][0])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[1][achievement_name], achievements[1][achievement_progress], achievements[1][achievement_about],  (users[playerid][u_achievement][1])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[2][achievement_name], achievements[2][achievement_progress], achievements[2][achievement_about],  (users[playerid][u_achievement][2])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[3][achievement_name], achievements[3][achievement_progress], achievements[3][achievement_about],  (users[playerid][u_achievement][3])?("{33AA33}���������"):("{A52A2A}�� ���������"));
					show_dialog(playerid, d_achievements_back, DIALOG_STYLE_MSGBOX, !"������", str, !"�����", !"");
				}
			case 2:
				{
					static str[1300];
					format(str, sizeof(str), "{fffff0}\ 
					������ ��� ���������� �������� �� �������� �����\n\n\ 
					��� ����� ������� ���� ����������, ���� � ������� �� ����������:\n\n\ 
					{cccccc}1.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}��������� %i ������� �����{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}2.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}��������� %i ������� �����{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}3.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}��������� %i ������� �����{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}4.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}��������� %i ������� �����{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\n\ 
					{fffff0}��� ������� �������� ����� ����� ���������� ��������� ����������.\n\ 
					��� ���������� ���� ���������� � ��� ������� �����, � ��� ����� ���������� � ��������� ����������.",
					achievements[4][achievement_name], achievements[4][achievement_progress], achievements[4][achievement_about],  (users[playerid][u_achievement][4])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[5][achievement_name], achievements[5][achievement_progress], achievements[5][achievement_about],  (users[playerid][u_achievement][5])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[6][achievement_name], achievements[6][achievement_progress], achievements[6][achievement_about],  (users[playerid][u_achievement][6])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[7][achievement_name], achievements[7][achievement_progress], achievements[7][achievement_about],  (users[playerid][u_achievement][7])?("{33AA33}���������"):("{A52A2A}�� ���������"));
					show_dialog(playerid, d_achievements_back, DIALOG_STYLE_MSGBOX, !"�������� ��������", str, !"�����", !"");
				}
			case 3:
				{
					static str[900];
					format(str, sizeof(str), "{fffff0}\ 
					������ ��� ���������� �������� �� �������� �����\n\n\ 
					��� ����� ������� ���� ����������, ���� � ������� �� ����������:\n\n\ 
					{cccccc}1.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}������� %i ������{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}2.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}������� %i ������{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\n\
					{fffff0}��� ������� �������� ����� ����� ���������� ��������� ����������.\n\ 
					��� ���������� ���� ���������� � ��� ������� �����, � ��� ����� ���������� � ��������� ����������.",
					achievements[8][achievement_name], achievements[8][achievement_progress], achievements[8][achievement_about],  (users[playerid][u_achievement][8])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[9][achievement_name], achievements[9][achievement_progress], achievements[9][achievement_about],  (users[playerid][u_achievement][9])?("{33AA33}���������"):("{A52A2A}�� ���������"));
					show_dialog(playerid, d_achievements_back, DIALOG_STYLE_MSGBOX, !"������� ���� �� �����", str, !"�����", !"");
				}
			case 4:
				{
					static str[1100];
					format(str, sizeof(str), "{fffff0}\ 
					������ ��� ���������� �������� �� �������� �����\n\n\ 
					��� ����� ������� ���� ����������, ���� � ������� �� ����������:\n\n\ 
					{cccccc}1.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}������ %i ���{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}2.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}������ %i ���{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\ 
					{cccccc}3.\n\
					\t��������: {4682B4}%s{cccccc}.\n\
					\t����: {4682B4}������ %i ���{cccccc}.\n\
					\t�������: {4682B4}%s{cccccc}.\n\ 
					\t������ �������: %s{cccccc}.\n\n\ 
					{fffff0}��� ������� �������� ����� ����� ���������� ��������� ����������.\n\ 
					��� ���������� ���� ���������� � ��� ������� �����, � ��� ����� ���������� � ��������� ����������.",
					achievements[10][achievement_name], achievements[10][achievement_progress], achievements[10][achievement_about],  (users[playerid][u_achievement][10])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[11][achievement_name], achievements[11][achievement_progress], achievements[11][achievement_about],  (users[playerid][u_achievement][11])?("{33AA33}���������"):("{A52A2A}�� ���������"),
					achievements[12][achievement_name], achievements[12][achievement_progress], achievements[12][achievement_about],  (users[playerid][u_achievement][12])?("{33AA33}���������"):("{A52A2A}�� ���������"));
					show_dialog(playerid, d_achievements_back, DIALOG_STYLE_MSGBOX, !"����������", str, !"�����", !"");
				}
			}
		}
	case d_menu_drop:
		{
			if(!response)
			{
				TextDrawHideForPlayer(playerid, Text: drop_items_TD);
				CancelSelectTextDraw(playerid);
				ClearAnimLoop(playerid);
				return true;
			}
			switch(user_drop_equipment[playerid][listitem])
			{
			case 38:
				{
					user_drop_equipment[playerid][listitem] = 0;
					users[playerid][u_armour] = 0;
					new Float: count_;
					GetPlayerArmour(playerid, count_);
					AddItem(playerid, 38, 1, floatround(count_, floatround_round));
					SetPlayerArmour(playerid, 0);
					server_accept(playerid, "�� ����� ���������.");
					if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
				}
			case 78:
				{
					user_drop_equipment[playerid][listitem] = 0;
					users[playerid][u_helmet] = 0;
					AddItem(playerid, 78, 1);
					SetPlayerArmour(playerid, 0);
					server_accept(playerid, "�� ����� ����.");
					if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
				}
			case 0..13:
				{
					new weapon, ammo, ammo_ = 0;
					GetPlayerWeaponData(playerid, user_drop_equipment[playerid][listitem], weapon, ammo);
					// if(protect_ammo[playerid][user_drop_equipment[playerid][listitem]] > ammo) protect_ammo[playerid][user_drop_equipment[playerid][listitem]] = ammo;
					if(ammo > protect_ammo[playerid][user_drop_equipment[playerid][listitem]]) ammo = protect_ammo[playerid][user_drop_equipment[playerid][listitem]];
					AddItem(playerid, GetWeaponItem(weapon), 1);
					if(weapon == WEAPON_ROCKETLAUNCHER)
					{
						AddItem(playerid, GetWeaponAmmoItem(weapon), ammo);
					}
					else
					{
						if(ammo > WeaponAmmo(weapon))
						{
							ammo_ = ammo % WeaponAmmo(weapon);
							for(new z = 0; z < (ammo/WeaponAmmo(weapon)); z++) 
							{
								AddItem(playerid, GetWeaponAmmoItem(weapon), WeaponAmmo(weapon));
							}
							if(ammo_ != 0) AddItem(playerid, GetWeaponAmmoItem(weapon), ammo_);
							if(ammo_) ammo_ = 0;
						}
						else AddItem(playerid, GetWeaponAmmoItem(weapon), ammo);
					}
					RemovePlayerWeapon(playerid, weapon);
					SCMG(playerid, "�� ����� ������ ''%s''", WeaponNames[weapon]);
					user_drop_equipment[playerid][listitem] = 0;
				}
			}
			inventory_use(playerid);
			// callcmd::drop(playerid);
		}
	case d_usetoh:
		{
			if(!response) return true;
			ShowCraftTools(playerid, users[playerid][PlayerItem][listitem]);
		}
	case d_inventory:
		{
			if(!response)
			{
				TextDrawHideForPlayer(playerid, Text: drop_items_TD);
				CancelSelectTextDraw(playerid);
				ClearAnimLoop(playerid);
				return true;
			}
			TextDrawHideForPlayer(playerid, Text: drop_items_TD);
			CancelSelectTextDraw(playerid);
			users[playerid][PlayertoItem] = listitem;
			if(user_items[playerid][users[playerid][PlayertoItem]][item_use_value] == 1) return show_dialog(playerid, d_inventory_menu, DIALOG_STYLE_LIST, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"- ������������\n- ���������\n- ����������", !"�����", !"�����");
			else if(user_items[playerid][users[playerid][PlayertoItem]][item_use_value] > 1) return show_dialog(playerid, d_inventory_menu, DIALOG_STYLE_LIST, loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], !"- ������������\n- ���������\n- ��������� ���������\n- ����������", !"�����", !"�����");
		}
	case d_inventory_stol:
		{
			if(!response) return UseCraftTools(playerid, 2);
			users[playerid][PlayertoItem] = listitem;
			if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] == 0) 
			{
				craft_tool[use_craft_tools_pila[playerid]][craft_stol_one] = user_items[playerid][users[playerid][PlayertoItem]][item_use_id];
				RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
				UseCraftTools(playerid, 2);
				return true;
			}
			else if(craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] == 0) 
			{
				craft_tool[use_craft_tools_pila[playerid]][craft_stol_two] = user_items[playerid][users[playerid][PlayertoItem]][item_use_id];
				RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
				UseCraftTools(playerid, 2);
			}
		}
	case d_inventory_pech:
		{
			if(!response) return UseCraftTools(playerid, 3);
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] >= 100) return server_error(playerid, "�������� �������������� ������ �� ����. (������� 'done')");
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_timer] > 0) return server_error(playerid, "�������� ��������� ����������.");
			if(craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] < 100 && craft_tool[use_craft_tools_pila[playerid]][craft_pech_progress] > 0) return server_error(playerid, "�������� ��������� ����������.");
			users[playerid][PlayertoItem] = listitem;
			craft_tool[use_craft_tools_pila[playerid]][craft_pech_unwrought]++;
			RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			server_error(playerid, "������ ��������� �� ����������.");
			UseCraftTools(playerid, 3);
		}
	case d_inventory_menu:
		{
			if(!response) return inventory_use(playerid), true;
			switch(listitem)
			{
			case 0: 
				{
					ClearAnimLoop(playerid);
					UseItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]); // ���������� �������;
				}
			case 1:
				{
					if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "�� �� ������ ���������� � ������������ ��������!"), true;
					if(IsPlayerInWater(playerid)) return server_error(playerid, "�� �� ������ ���������� � ����!"), true;
					if(!user_items[playerid][users[playerid][PlayertoItem]][item_use_id]) return true;
					ClearAnimLoop(playerid);
					if(user_items[playerid][users[playerid][PlayertoItem]][item_use_id] == 51 && temp[playerid][temp_use_map]) 
					{
						TextDrawHideForPlayer(playerid, Mapen_S);
						temp[playerid][temp_use_map] = false;
						for(new z = 0; z != sizeof(MapLine); z++) TextDrawHideForPlayer(playerid, MapLine[z]); 
						for(new z = 0; z != CountIcon; z++) TextDrawHideForPlayer(playerid, MapIcon[z]); 
					}
					SCMG(playerid, "��������� �� ���������: %s.", loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name]);
					static Float: pos_xyz[3];
					GetPlayerPos(playerid, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
					DroppedInventoryPlayer(user_items[playerid][users[playerid][PlayertoItem]][item_use_id], pos_xyz[0], pos_xyz[1], pos_xyz[2], 1, user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
					RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
				}
			case 2:
				{
					if(user_items[playerid][users[playerid][PlayertoItem]][item_use_value] == 1) 
					{
						static str[256];
						format(str, sizeof(str), "\n\
						{fffff0}��������: {cccccc}%s\n\
						{fffff0}�����: {cccccc}%s\n\
						{fffff0}��������: {cccccc}%s", 
						loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], 
						loot_quality_name[loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_quality]-1], 
						loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_about]);
						show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "���������� � ��������", str, !"OK", !""); 
						return true;
					}
					static str[96]; 
					format(str, sizeof(str), "%s - %i ��.", 
					loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], 
					user_items[playerid][users[playerid][PlayertoItem]][item_use_value]);
					show_dialog(playerid, d_inventory_drop, DIALOG_STYLE_INPUT, str, "\n������� ���������� ���������, �� 2 �� 10 �� 1 ���\n", "���������", "���������");
				}
			case 3: 
				{
					static str[256];
					format(str, sizeof(str), "\n\
					{fffff0}��������: {cccccc}%s\n\
					{fffff0}�����: {cccccc}%s\n\
					{fffff0}��������: {cccccc}%s", 
					loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], 
					loot_quality_name[loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_quality]-1], 
					loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_about]);
					show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "���������� � ��������", str, !"OK", !""); 
				}
			}
		}
	case d_anim:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: callcmd::animation(playerid, "");
			default: animations(playerid, listitem);
			}
		}
	case d_inventory_drop:
		{
			if(!response) return inventory_use(playerid), true;
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "�� �� ������ ���������� � ������������ ��������!");
			if(IsPlayerInWater(playerid)) return server_error(playerid, "�� �� ������ ���������� � ����!");
			for(new Index = strlen(inputtext)-1; Index != -1; Index--)
			{
				switch(inputtext[Index])
				{
				case '0'..'9': continue;
				default: 
					{
						static str[96]; 
						format(str, sizeof(str), "%s - %i ��.", 
						loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], 
						user_items[playerid][users[playerid][PlayertoItem]][item_use_value]);
						show_dialog(playerid, d_inventory_drop, DIALOG_STYLE_INPUT, str, "\n������� ���������� ���������, �� 2 �� 10 �� 1 ���\n", "���������", "���������");
						server_error(playerid, "����������� ������ �����.");
						return true;
					}
				}
			}
			new count = strval(inputtext);
			if(count > user_items[playerid][users[playerid][PlayertoItem]][item_use_value])
			{
				static str[96]; 
				format(str, sizeof(str), "%s - %i ��.", 
				loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], 
				user_items[playerid][users[playerid][PlayertoItem]][item_use_value]);
				show_dialog(playerid, d_inventory_drop, DIALOG_STYLE_INPUT, str, "\n������� ���������� ���������, �� 2 �� 10 �� 1 ���\n", "���������", "���������");
				server_error(playerid, "�� ������� ���-�� ������ ��� � ��� ����.");
				return true;
			}
			if(count < 2 || count > 10)
			{
				static str[96]; 
				format(str, sizeof(str), "%s - %i ��.", 
				loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], 
				user_items[playerid][users[playerid][PlayertoItem]][item_use_value]);
				show_dialog(playerid, d_inventory_drop, DIALOG_STYLE_INPUT, str, "\n������� ���������� ���������, �� 2 �� 10 �� 1 ���\n", "���������", "���������");
				server_error(playerid, "���-�� ����� ������� �� 2-��.");
				return true;
			}
			if(!user_items[playerid][users[playerid][PlayertoItem]][item_use_id]) return true;
			ClearAnimLoop(playerid);
			new Float: pos[3];
			GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
			if(user_items[playerid][users[playerid][PlayertoItem]][item_use_id] == 51 && temp[playerid][temp_use_map]) 
			{
				TextDrawHideForPlayer(playerid, Mapen_S);
				temp[playerid][temp_use_map] = false;
				for(new z = 0; z != sizeof(MapLine); z++) TextDrawHideForPlayer(playerid, MapLine[z]); 
				for(new z = 0; z != CountIcon; z++) TextDrawHideForPlayer(playerid, MapIcon[z]); 
			}
			for(new z = 0; z != count; z++)
			{
				
				RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			}
			static Float: pos_xyz[3];
			GetPlayerPos(playerid, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
			DroppedInventoryPlayer(user_items[playerid][users[playerid][PlayertoItem]][item_use_id], pos_xyz[0], pos_xyz[1], pos_xyz[2], count, user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			SCMG(playerid, "%s - %i ��. ��������� �� ���������.", loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name], count);
		}
	case d_click_to_player:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0: 
				{
					static str[11];
					format(str, sizeof(str), "%i", admin[playerid][u_a_click_to_player]);
					callcmd::showstats(playerid, str);
				}
			case 1:
				{
					static str[11];
					format(str, sizeof(str), "%i", admin[playerid][u_a_click_to_player]);
					callcmd::goto(playerid, str);
				}
			case 2:
				{
					static str[11];
					format(str, sizeof(str), "%i", admin[playerid][u_a_click_to_player]);
					callcmd::gethere(playerid, str);
				}
			}
		}
	case d_car:
		{
			if(!response) return true;
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
			switch(listitem)
			{
			case 0: Engine(playerid);
			case 1:
				{
					if(GetPVarInt(playerid, "AntiFloodVehicleFunction") > gettime()) return server_error(playerid, "�� �����!"), true;
					SetPVarInt(playerid,"AntiFloodVehicleFunction", gettime() + 2);
					if(car_lights{GetPlayerVehicleID(playerid)}) 
					{
						ManualCar(GetPlayerVehicleID(playerid), "car_lights", 0);
						me_action(playerid, "��������(-�) ����.");
					}
					else 
					{
						ManualCar(GetPlayerVehicleID(playerid), "car_lights", 1);
						me_action(playerid, "�������(-�) ����.");
					}
				}
			case 2:
				{
					if(GetPVarInt(playerid, "AntiFloodVehicleFunction") > gettime()) return server_error(playerid, "�� �����!"), true;
					SetPVarInt(playerid,"AntiFloodVehicleFunction", gettime() + 2);
					if(car_boot{GetPlayerVehicleID(playerid)}) 
					{
						me_action(playerid, "������(-�) ��������.");
						ManualCar(GetPlayerVehicleID(playerid), "car_boot", 0);
					}
					else 
					{
						me_action(playerid, "������(-�) ��������.");
						ManualCar(GetPlayerVehicleID(playerid), "car_boot", 1);
						server_accept(playerid, "������� 'H', ����� ������� ��������!");
					}
				}
			case 3:
				{
					if(GetPVarInt(playerid, "AntiFloodVehicleFunction") > gettime()) return server_error(playerid, "�� �����!"), true;
					SetPVarInt(playerid,"AntiFloodVehicleFunction", gettime() + 2);
					if(car_bonnet{GetPlayerVehicleID(playerid)}) 
					{
						me_action(playerid, "������(-�) �����.");
						ManualCar(GetPlayerVehicleID(playerid), "car_bonnet", 0);
					}
					else 
					{
						me_action(playerid, "������(-�) �����.");
						ManualCar(GetPlayerVehicleID(playerid), "car_bonnet", 1);
					}
				}
			}
			callcmd::car(playerid);
		}
	case d_the_choice:
		{
			if(response) return EquipmentVehicle(playerid);
			PutVehicle(playerid);
			return 1; 
		}
	case d_car_put:
		{
			if(!response) return true;
			new Float: POS[3];
			new i = AntiBagAutoDoop[playerid];
			GetCoordBootVehicle(i, POS[0], POS[1], POS[2]);
			if(!IsPlayerInRangeOfPoint(playerid, 1.5, POS[0], POS[1], POS[2])) return server_error(playerid, "�� ������ ���� ����� � ����.");
			if(car_boot{i} == VEHICLE_PARAMS_OFF) return server_error(playerid, "�������� ������.");
			users[playerid][PlayertoItem] = listitem;
			if(CarInfo[i][car_the_trunk] >= 100) return server_error(playerid, "�������� ����������!");
			CarInfo[i][car_the_trunk]++;
			// CarInfo[i][car_the_trunk_info][users[playerid][PlayertoItem]]++;
			
			switch(user_items[playerid][users[playerid][PlayertoItem]][item_use_id])
			{
			case 18..25, 63..65, 75..76: AddVehicleItem(i, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			default: AddVehicleItem(i, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], 1, user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			}
			if(i != GetPVarInt(playerid, "admin_vehicle")) SaveVehicle(i);
			if(user_items[playerid][users[playerid][PlayertoItem]][item_use_id] == 51 && temp[playerid][temp_use_map]) 
			{
				TextDrawHideForPlayer(playerid, Mapen_S),temp[playerid][temp_use_map] = false;
				for(new d; d<sizeof(MapLine); d++) { TextDrawHideForPlayer(playerid, MapLine[d]); }
				for(new f; f<CountIcon; f++) { TextDrawHideForPlayer(playerid, MapIcon[f]); } 
			}
			RemoveItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], user_items[playerid][users[playerid][PlayertoItem]][item_use_quantity]);
			
			SCMG(playerid, "�� �������� � ��������: {808000}%s{ffffff}.", loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name]);
			PutVehicle(playerid);
		}
	case d_medikal_box:
		{
			if(!response) return true;
			users[playerid][PlayertoItem] = listitem;
			if (users[playerid][u_slots]  >= users[playerid][u_backpack]*10) return server_error(playerid,"��� ��������� �����, ��������� ���-������!");
			for(new i = 0; i != sizeof(MediksBoxData); i++) 
			{
				if(!IsPlayerInRangeOfPoint(playerid, 2.6, MediksBoxData[i][med_x], MediksBoxData[i][med_y], MediksBoxData[i][med_z])) continue;
				if(MediksBox[i][user_items[playerid][users[playerid][PlayertoItem]][item_use_id]] < 1) return server_error(playerid, "��������, ���-�� ��� ���� ���� �������!");
				SCMG(playerid, "�� �����:{808000} %s{ffffff} �� �����.", loots[user_items[playerid][users[playerid][PlayertoItem]][item_use_id]][loot_name]);
				AddItem(playerid, user_items[playerid][users[playerid][PlayertoItem]][item_use_id], 1);
				MediksBox[i][user_items[playerid][users[playerid][PlayertoItem]][item_use_id]] --;
				
				MediksBoxData[i][med_slot]--;
				MediksEquipmentBox(playerid);
			} 
		}
	case d_car_inv:
		{
			if(!response) return true;
			users[playerid][PlayertoItem] = listitem;
			if (users[playerid][u_slots]  >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
			new i = AntiBagAutoDoop[playerid];
			new Float:x, Float:y, Float:z;
			new Float: POS[3];
			GetVehiclePos(i, x, y, z);
			if(!IsPlayerInRangeOfPoint(playerid, 4.0, x, y, z)) return true;
			GetCoordBootVehicle(i, POS[0], POS[1], POS[2]);
			if(!IsPlayerInRangeOfPoint(playerid, 1.5, POS[0], POS[1], POS[2])) return true;
			if(car_boot{i} == VEHICLE_PARAMS_OFF) return 1;
			// if(CarInfo[i][car_the_trunk_info][users[playerid][PlayertoItem]] <= 0) return server_error(playerid, "��������, ���-�� ��� ���� ���� �������!");
			new check_item = 0;
			if(check_item) check_item = 0;
				
			for(new u = 0; u < INVENTORY_USE; u++)
			{
				if(!car_items[i][u][item_id]) continue;
				if(car_items[i][u][item_id] != car_items[i][users[playerid][PlayertoItem]][item_use_id]) continue;
				if(!car_items[i][u][item_value]) continue;
				check_item++;
				break;
			}
			if(!check_item) return server_error(playerid, "��������, ���-�� ��� ���� ���� �������!");
			SCMG(playerid, "�� �����:{808000} %s{fffff0} �� ���������.", loots[car_items[i][users[playerid][PlayertoItem]][item_use_id]][loot_name]);
			RemoveItemFromVehicle(i, car_items[i][users[playerid][PlayertoItem]][item_use_id], car_items[i][users[playerid][PlayertoItem]][item_use_quantity]);
			
			switch(car_items[i][users[playerid][PlayertoItem]][item_use_id])
			{
			case 18..25, 63..65, 75..76: AddItem(playerid, car_items[i][users[playerid][PlayertoItem]][item_use_id], car_items[i][users[playerid][PlayertoItem]][item_use_quantity]);
			default: AddItem(playerid, car_items[i][users[playerid][PlayertoItem]][item_use_id], 1, car_items[i][users[playerid][PlayertoItem]][item_use_quantity]);
			}
			
			CarInfo[i][car_the_trunk] --;
			EquipmentVehicle(playerid);
			if(i != GetPVarInt(playerid, "admin_vehicle")) SaveVehicle(i);
			return 1; 
		}
	case d_shop_menu:
		{
			if(!response)
			{
				show_dialog(playerid, d_store, DIALOG_STYLE_LIST, !"������� �����", !"\
				{cccccc}- {fffff0}���\n\
				{cccccc}- {fffff0}������\n\
				{cccccc}- {fffff0}�������\n\
				{cccccc}- {fffff0}�����������\n\
				{cccccc}- {fffff0}������", !"�����", !"�������");
				SetPVarInt(playerid, "buy_and_sell", 0);
				return true;
			}
			show_dialog(playerid, d_store, DIALOG_STYLE_LIST, !"������� �����", !"\
			{cccccc}- {fffff0}���\n\
			{cccccc}- {fffff0}������\n\
			{cccccc}- {fffff0}�������\n\
			{cccccc}- {fffff0}�����������\n\
			{cccccc}- {fffff0}������\n\
			{cccccc}- {fffff0}������", !"�����", !"�������");
			SetPVarInt(playerid, "buy_and_sell", 1);
		}	
	case d_store:
		{
			if(!response) return true;
			if(!IsPlayerInRangeOfPoint(playerid, 3.0, PickXYZ[0][0][0], PickXYZ[0][0][1], PickXYZ[0][0][2])) return server_error(playerid, "�� ������ ���� ����� �������� �� �����!");
			new bool:buy_and_sell = false;
			if(buy_and_sell) buy_and_sell = false;
			if(GetPVarInt(playerid,"buy_and_sell")) buy_and_sell = true;
			switch(listitem) 
			{
			case 0: STORE(playerid, buy_and_sell, 1);
			case 1: STORE(playerid, buy_and_sell, 2);
			case 2: STORE(playerid, buy_and_sell, 3);
			case 3: STORE(playerid, buy_and_sell, 4);
			case 4: STORE(playerid, buy_and_sell, 5);
			case 5: show_dialog(playerid, d_store_clothes, DIALOG_STYLE_INPUT, "�������", !"������� ����� ������ (1-33)", !"������", !"�����");
			}
		}
	case d_store_clothes:
		{
			if(!response)
			{
				show_dialog(playerid, d_store, DIALOG_STYLE_LIST, "�������", !"\
				{cccccc}- {fffff0}���\n\
				{cccccc}- {fffff0}������\n\
				{cccccc}- {fffff0}�������\n\
				{cccccc}- {fffff0}�����������\n\
				{cccccc}- {fffff0}������\n\
				{cccccc}- {fffff0}������", !"�����", !"�������");
				SetPVarInt(playerid, "buy_and_sell", 1);
				return true;
			}
			if(!IsPlayerInRangeOfPoint(playerid, 3.0, PickXYZ[0][0][0], PickXYZ[0][0][1], PickXYZ[0][0][2])) return server_error(playerid, "�� ������ ���� ����� �������� �� �����!");
			new buy_skin = 0;
			if(sscanf(inputtext, "i", buy_skin)) return show_dialog(playerid, d_store_clothes, DIALOG_STYLE_INPUT, !"�������", !"������� ����� ������ (1-33)", !"������", !"�����");
			if(buy_skin < 1 || buy_skin > 33) return show_dialog(playerid, d_store_clothes, DIALOG_STYLE_INPUT, !"�������", !"������� ����� ������ (1-33)", !"������", !"�����");
			if (users[playerid][u_money] < GetItemPrise(playerid, Clothing[buy_skin-1]))
			{
				SCMASS(playerid, "� ��� ������������ �������! ��������� ���� ������: %d", GetItemPrise(playerid, Clothing[buy_skin-1]));
				show_dialog(playerid, d_store_clothes, DIALOG_STYLE_INPUT, !"�������", !"������� ����� ������ (1-33)", !"������", !"�����");
				return true;
			}
			if (users[playerid][u_slots] >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
			buy_skin = buy_skin-1;
			AddItem(playerid, Clothing[buy_skin], 1);
			
			new m = GetItemPrise(playerid, Clothing[buy_skin]);
			money(playerid, "-", m);
			SCMG(playerid, "�� ��������� %s �� %d ����. �������: %d", loots[Clothing[buy_skin]][loot_name], GetItemPrise(playerid, Clothing[buy_skin]), users[playerid][u_money]);
			show_dialog(playerid, d_store, DIALOG_STYLE_LIST, !"�������", !"\
			{cccccc}- {fffff0}���\n\
			{cccccc}- {fffff0}������\n\
			{cccccc}- {fffff0}�������\n\
			{cccccc}- {fffff0}�����������\n\
			{cccccc}- {fffff0}������\n\
			{cccccc}- {fffff0}������", !"�����", !"�������");
			SetPVarInt(playerid, "buy_and_sell", 1);		
		}
	case d_store_buy_and_sell:
		{
			if(!IsPlayerInRangeOfPoint(playerid, 3.0, PickXYZ[0][0][0], PickXYZ[0][0][1], PickXYZ[0][0][2])) return server_error(playerid, "�� ������ ���� ����� �������� �� �����!");
			new bool:buy_and_sell = false;
			if(buy_and_sell) buy_and_sell = false;
			if(GetPVarInt(playerid, "buy_and_sell")) buy_and_sell = true;
			if(!response)
			{
				if(buy_and_sell)
				{
					show_dialog(playerid, d_store, DIALOG_STYLE_LIST, !"������� �����", !"\
					{cccccc}- {fffff0}���\n\
					{cccccc}- {fffff0}������\n\
					{cccccc}- {fffff0}�������\n\
					{cccccc}- {fffff0}�����������\n\
					{cccccc}- {fffff0}������", !"�����", !"�������");
					SetPVarInt(playerid, "buy_and_sell", 1);
					return true;
				}
				else
				{
					show_dialog(playerid, d_store, DIALOG_STYLE_LIST, !"������� �����", !"\
					{cccccc}- {fffff0}���\n\
					{cccccc}- {fffff0}������\n\
					{cccccc}- {fffff0}�������\n\
					{cccccc}- {fffff0}�����������\n\
					{cccccc}- {fffff0}������\n\
					{cccccc}- {fffff0}������", !"�����", !"�������");
					SetPVarInt(playerid, "buy_and_sell", 0);
				}
				return true;
			}
			if(GetPVarInt(playerid,"depot")) 
			{
				switch(GetPVarInt(playerid,"act")) 
				{
				case 1: 
					{
						if (users[playerid][u_money] < GetItemPrise(playerid, Eats[listitem])) return server_error(playerid, "� ��� ������������ �������!"),STORE(playerid, buy_and_sell, GetPVarInt(playerid,"act"));
						if (users[playerid][u_slots]  >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid,"act"));
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "-", GetItemPrise(playerid, Eats[listitem]));
						SCMG(playerid, "�� ��������� %s �� %d ����. �������: %d", loots[Eats[listitem]][loot_name], GetItemPrise(playerid, Eats[listitem]), users[playerid][u_money]);
						AddItem(playerid, Eats[listitem], 1);
						 
					}
				case 2: 
					{
						if (users[playerid][u_money] < GetItemPrise(playerid, Weapons[listitem])) return server_error(playerid, "� ��� ������������ �������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid,"act"));
						if (users[playerid][u_slots] >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid,"act"));
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "-", GetItemPrise(playerid, Weapons[listitem]));
						SCMG(playerid,"�� ��������� %s �� %d ����. �������: %d", loots[Weapons[listitem]][loot_name], GetItemPrise(playerid, Weapons[listitem]), users[playerid][u_money]);
						if(Weapons[listitem] != 38) AddItem(playerid, Weapons[listitem], 1);
						else AddItem(playerid, Weapons[listitem], 1, 100);
						 
					}
				case 3: 
					{
						if (users[playerid][u_money] < GetItemPrise(playerid,Ammunition[listitem])) return server_error(playerid, "� ��� ������������ �������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid,"act"));
						if (users[playerid][u_slots] >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid,"act"));
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "-", GetItemPrise(playerid, Ammunition[listitem]));
						SCMG(playerid,"�� ��������� %s �� %d ����. �������: %d", loots[Ammunition[listitem]][loot_name], GetItemPrise(playerid, Ammunition[listitem]), users[playerid][u_money]);
						AddItem(playerid, Ammunition[listitem], getAmmoByItem(Ammunition[listitem]));
						 
					}
				case 4: 
					{
						if (users[playerid][u_money] < GetItemPrise(playerid, Medicines[listitem])) return server_error(playerid, "� ��� ������������ �������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						if (users[playerid][u_slots] >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "-", GetItemPrise(playerid, Medicines[listitem]));
						SCMG(playerid,"�� ��������� %s �� %d ����. �������: %d", loots[Medicines[listitem]][loot_name], GetItemPrise(playerid,Medicines[listitem]), users[playerid][u_money]);
						AddItem(playerid, Medicines[listitem], 1);
						 
					}
				case 5: 
					{
						if (users[playerid][u_money] < GetItemPrise(playerid, Rest[listitem])) return server_error(playerid, "� ��� ������������ �������!"), STORE(playerid, buy_and_sell,GetPVarInt(playerid,"act"));
						if (users[playerid][u_slots] >= users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!"), STORE(playerid, buy_and_sell,GetPVarInt(playerid,"act"));
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "-", GetItemPrise(playerid, Rest[listitem]));
						SCMG(playerid,"�� ��������� %s �� %d ����. �������: %d", loots[Rest[listitem]][loot_name], GetItemPrise(playerid, Rest[listitem]), users[playerid][u_money]);
						AddItem(playerid, Rest[listitem], 1);
						 
					}
				}
			}
			else 
			{
				switch(GetPVarInt(playerid,"act")) 
				{
					case 1:
					{
						if(GetItem(playerid, Eats[listitem]) < 1) return server_error(playerid, "� ��� ��� ����� ���!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid,"act"));
						money(playerid, "+", (GetItemPrise(playerid, Eats[listitem])/2));
						SCMG(playerid,"�� ������� %s �� %d ����. ����� ����: %d", loots[Eats[listitem]][loot_name], loots[Eats[listitem]][loot_price]/2, users[playerid][u_money]);
						RemoveItem(playerid, Eats[listitem]);
						
						STORE(playerid, buy_and_sell, GetPVarInt(playerid,"act")); 
					}
					case 2: 
					{
						if(GetItem(playerid, Weapons[listitem]) < 1) return server_error(playerid, "� ��� ��� ������ ��������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						if(!GetItem(playerid, Weapons[listitem], 100) && Weapons[listitem] == 38) return server_error(playerid, "������������ ���������� ������ �������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "+", (GetItemPrise(playerid, Weapons[listitem])/2));
						SCMG(playerid, "�� ������� %s �� %d ����. ����� ����: %d", loots[Weapons[listitem]][loot_name], loots[Weapons[listitem]][loot_price]/2, users[playerid][u_money]);
						if(Weapons[listitem] != 38) RemoveItem(playerid, Weapons[listitem]);
						else RemoveItem(playerid, Weapons[listitem], 100);
						
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act")); 
					}
					case 3: 
					{
						if(GetItem(playerid, Ammunition[listitem], getAmmoByItem(Ammunition[listitem])) < 1) return server_error(playerid, "� ��� ���� ����� ��������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "+", (GetItemPrise(playerid, Ammunition[listitem])/2));
						SCMG(playerid,"�� ������� %s �� %d ����. ����� ����: %d", loots[Ammunition[listitem]][loot_name], loots[Ammunition[listitem]][loot_price]/2, users[playerid][u_money]);
						RemoveItem(playerid, Ammunition[listitem], getAmmoByItem(Ammunition[listitem]));
						
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act")); 
					}
					case 4: 
					{
						if(GetItem(playerid, Medicines[listitem]) < 1) return server_error(playerid, "� ��� ���� ����� ������������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "+", (GetItemPrise(playerid, Medicines[listitem])/2));
						SCMG(playerid,"�� ������� %s �� %d ����. ����� ����: %d", loots[Medicines[listitem]][loot_name], loots[Medicines[listitem]][loot_price]/2, users[playerid][u_money]);
						RemoveItem(playerid, Medicines[listitem]);
						
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act")); 
					}
					case 5: 
					{
						if(GetItem(playerid, Rest[listitem]) < 1) return server_error(playerid, "� ��� ���� ������ �������!"), STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act"));
						money(playerid, "+", (GetItemPrise(playerid, Rest[listitem])/2));
						SCMG(playerid,"�� ������� %s �� %d ����. ����� ����: %d", loots[Rest[listitem]][loot_name], loots[Rest[listitem]][loot_price]/2, users[playerid][u_money]);
						RemoveItem(playerid, Rest[listitem]);
						
						STORE(playerid, buy_and_sell, GetPVarInt(playerid, "act")); 
					} 
				}
			}
		}	
	case d_craft:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0..4:  CraftSystemTool(playerid, listitem+1); //5
			case 5:
				ShowPerkPlayerCraft ( playerid );
			case 6: show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"����������", !"\
			{fffff0}��� ����, ����� ������ ������������, ��� �����������, \n\
			������������ ����, ������ ��� ������������ ��� ��� ���� ���������.\n\
			���� ������ ��� ���������� ������������ �� ������ ���������� � �������� � ������� ����.\n\
			������� ���� �������� �� ����� ������� ������.\n\n\
			���� ������� ����� ���������� � ������� ����:\n\
			{cccccc}- {fffff0}�����;\n\
			{cccccc}- {fffff0}�������������� ������;\n\
			{cccccc}- {fffff0}����������� ����;\n\
			{cccccc}- {fffff0}�������� ��������;\n\
			{cccccc}- {fffff0}���������� �� '������' (��� ��������).\n\n\
			��� �� ��� ����������� ����� ������������, ������� �� ������� ����� ����� ����.\n\
			���� ������ ������ �� ������ ���������� �������� ���� �� �����.\n\n\
			������ ���������, ������� ����� ���������� ������ �� ������� ��.\n\
			{cccccc}- {fffff0}����� - ��������� ������ �� ����������� ������.\n\
			{cccccc}- {fffff0}�������������� ������ - ����������� ������ � ����.\n\
			{cccccc}- {fffff0}�������� �������� - ����������� � ���� 6 ��. ��������������� ������.\n\
			{cccccc}- {fffff0}���������� - ���������� �� ��������.", !"�������", !"");
			}
		}
	case d_craft_tools_use:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0, 1: ShowCraftTools(playerid, edit_player_object[playerid]); // ���������, ��� ���������;
			case 2: // �������������;
				{
					switch(craft_tool[edit_player_object[playerid]][craft_type])
					{
					case 1, 2:
						{	
							switch(craft_tool[edit_player_object[playerid]][craft_open])
							{
							case 1:
								{
									static Float: RotX, Float: RotY, Float: RotZ;
									GetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], RotX, RotY, RotZ);
									SetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], RotX, RotY, RotZ-100);
									craft_tool[edit_player_object[playerid]][craft_open] = 0;
									server_accept(playerid, "�� ������� �����.");
								}
							default:
								{
									if(craft_tool[edit_player_object[playerid]][craft_owner] != users[playerid][u_id]) 
									{
										if(strcmp(craft_tool[edit_player_object[playerid]][craft_password], "NoCraftPass321")) return show_dialog(playerid, d_craft_password, DIALOG_STYLE_PASSWORD, " ", "\n������� ��� �� �����\n", "������", "�������");
									}
									static Float: RotX, Float: RotY, Float: RotZ;
									GetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], RotX, RotY, RotZ);
									SetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], RotX, RotY, RotZ+100);
									craft_tool[edit_player_object[playerid]][craft_open] = 1;
									server_accept(playerid, "�� ������� �����.");
								}
							}
						}
					case 3: UseCraftTools(playerid, 1);
					case 4: UseCraftTools(playerid, 2);
					case 5: UseCraftTools(playerid, 3);
					}
				}
			case 3: // �������/�����;
				{
					if(craft_tool[edit_player_object[playerid]][craft_owner] != users[playerid][u_id]) // ���� �� ��������, �� �������� �4;
					{
						if(GetItem(playerid, 107) < 1) return server_error(playerid, "� ��� ��� � ����� �4.");
						ExplosiveCraft(playerid);
						return true;
					}
					switch(craft_tool[edit_player_object[playerid]][craft_type])
					{
					case 1: 
						{
							if(craft_tool[edit_player_object[playerid]][craft_health] == craft_table[craft_tool[edit_player_object[playerid]][craft_type]-1][craft_prochnost]) return server_error(playerid, "����� �����.");
							if(GetItem(playerid, 40) < 1) return server_error(playerid, "� ��� ��� ������ ������������.");
						}
					case 2: 
						{
							if(craft_tool[edit_player_object[playerid]][craft_health] == craft_table[craft_tool[edit_player_object[playerid]][craft_type]-1][craft_prochnost]) return server_error(playerid, "����� �����.");
							if(GetItem(playerid, 40) < 1) return server_error(playerid, "� ��� ��� ������ ������������.");
						}
					case 3:
						{
							if(craft_tool[edit_player_object[playerid]][craft_health] == craft_table[craft_tool[edit_player_object[playerid]][craft_type]-1][craft_prochnost]) return server_error(playerid, "����������� ������ �����.");
							if(GetItem(playerid, 40) < 1) return server_error(playerid, "� ��� ��� ������ ������������.");
						}
					case 4:
						{
							if(craft_tool[edit_player_object[playerid]][craft_health] == craft_table[craft_tool[edit_player_object[playerid]][craft_type]-1][craft_prochnost]) return server_error(playerid, "������� �����.");
							if(GetItem(playerid, 40) < 1) return server_error(playerid, "� ��� ��� ������ ������������.");
						}
					case 5:
						{
							if(craft_tool[edit_player_object[playerid]][craft_health] == craft_table[craft_tool[edit_player_object[playerid]][craft_type]-1][craft_prochnost]) return server_error(playerid, "����������� �����.");
							if(GetItem(playerid, 40) < 1) return server_error(playerid, "� ��� ��� ������ ������������.");
						}
					case 6:
						{
							if(craft_tool[edit_player_object[playerid]][craft_health] == craft_table[craft_tool[edit_player_object[playerid]][craft_type]-1][craft_prochnost]) return server_error(playerid, "��������� �����.");
							if(GetItem(playerid, 40) < 1) return server_error(playerid, "� ��� ��� ������ ������������.");
						}
					}
				}
			case 4: // ��������������;
				{
					EditDynamicObject(playerid, craft_tool[edit_player_object[playerid]][craft_object]);
					GetPlayerPos(playerid, craft_player_pos_xyz[playerid][0], craft_player_pos_xyz[playerid][1], craft_player_pos_xyz[playerid][2]);
				}
			case 5: // ������/�����;
				{
					if(!GetItem(playerid, 108) && GetItem(playerid, 107) > 1) // ���� �� ��������, �� �������� �4;
					{
						if(GetItem(playerid, 107) < 1) return server_error(playerid, "� ��� ��� � ����� �4.");
						ExplosiveCraft(playerid);
						return true;
					}
					if(craft_tool[edit_player_object[playerid]][craft_type] == 1 || craft_tool[edit_player_object[playerid]][craft_type] == 2)
					{
						if(!strcmp(craft_tool[edit_player_object[playerid]][craft_password], "NoCraftPass321"))
						{
							if(!GetItem(playerid, 40)) return server_error(playerid, "� ��� ��� ������ ������������.");
							if(!GetItem(playerid, 108)) return server_error(playerid, "� ��� ��� �������� �����.");
							format(craft_tool[edit_player_object[playerid]][craft_password], MAX_PLAYER_NAME, "1234");
							server_accept(playerid, "�� ���������� ������� �����, ����������� ������: {cccccc}1234");
							static str_sql[196];
							m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CRAFT_TOOLS" SET `craft_password` = '1234', `craft_date_use` = NOW() WHERE `craft_id` = '%i';", craft_tool[edit_player_object[playerid]][craft_id]);
							m_query(str_sql);
							
							RemoveItem(playerid, 108);
							return true;
						}
						else show_dialog(playerid, d_craft_setpass, DIALOG_STYLE_INPUT, !" ", !"\n������� ����� ��� �� �����\n", !"������", !"������");
						return true;
					}
				}
			case 6: // �����;
				{
					if(GetItem(playerid, 107) < 1) return server_error(playerid, "� ��� ��� � ����� �4.");
					ExplosiveCraft(playerid);
				}
			}
		}
	case d_craft_password:
		{
			if(!response) return true;
			if(strlen(inputtext) < 1 || strlen(inputtext) > MAX_PLAYER_NAME || strcmp(craft_tool[edit_player_object[playerid]][craft_password], inputtext, false))
			{
				show_dialog(playerid, d_craft_password, DIALOG_STYLE_PASSWORD, !" ", !"\n\n������� ������ �� �����\n{cccccc}�� ����� �� ������ ������!\n\n", !"������", !"�������");
				return true;
			}
			switch(craft_tool[edit_player_object[playerid]][craft_open])
			{
			case 1:
				{
					static Float: RotX, Float: RotY, Float: RotZ;
					GetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], RotX, RotY, RotZ);
					SetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], RotX, RotY, RotZ-100);
					craft_tool[edit_player_object[playerid]][craft_open] = 0;
					server_accept(playerid, "�� ������� �����.");
				}
			default:
				{
					static Float: RotX, Float: RotY, Float: RotZ;
					GetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], RotX, RotY, RotZ);
					SetDynamicObjectRot(craft_tool[edit_player_object[playerid]][craft_object], RotX, RotY, RotZ+100);
					craft_tool[edit_player_object[playerid]][craft_open] = 1;
					server_accept(playerid, "�� ������� �����.");
				}
			}
		}
	case d_craft_setpass:
		{
			if(!response) return true;
			if(strlen(inputtext) < 4 || strlen(inputtext) > MAX_PLAYER_NAME || !strcmp(craft_tool[edit_player_object[playerid]][craft_password], inputtext, false))
			{
				show_dialog(playerid, d_craft_setpass, DIALOG_STYLE_INPUT, !" ", !"\n\n������� ����� ��� �� �����\n{cccccc}��� �� ������ ���� ������ 4-� � �� ������ 24-� ��������.\n��� ����� �� ������ ����������.\n\n", !"������", !"�������");
				return true;
			}
			format(craft_tool[edit_player_object[playerid]][craft_password], MAX_PLAYER_NAME, inputtext);
			SCMG(playerid, "����� ��� �� �����: {cccccc}%s", craft_tool[edit_player_object[playerid]][craft_password]);
			static str_sql[196];
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CRAFT_TOOLS" SET `craft_password` = '%s', `craft_date_use` = NOW() WHERE `craft_id` = '%i';", 
			craft_tool[edit_player_object[playerid]][craft_password], craft_tool[edit_player_object[playerid]][craft_id]);
			m_query(str_sql);

		}
	case d_green_shop:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					if (users[playerid][u_money] < 1000) return server_error(playerid, "� ��� ������������ �������.");
					if( (users[playerid][u_slots]+1) > users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
					// users[playerid][u_money] -= 1000;
					money(playerid, "-", 1000);
					AddItem(playerid, 115, 1);
					
					server_error(playerid, "�� ��������� ''�����''");
				}
			case 1:
				{
					if (users[playerid][u_money] < 2500) return server_error(playerid, "� ��� ������������ �������.");
					if( (users[playerid][u_slots]+1) > users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
					// users[playerid][u_money] -= 2500;
					money(playerid, "-", 2500);
					AddItem(playerid, 117, 1);
					
					server_error(playerid, "�� ��������� ''������������� ������''");
				}
			case 2:
				{
					if (users[playerid][u_money] < 5000) return server_error(playerid, "� ��� ������������ �������.");
					if( (users[playerid][u_slots]+1) > users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
					// users[playerid][u_money] -= 5000;
					money(playerid, "-", 5000);
					AddItem(playerid, 120, 1);
					
					server_error(playerid, "�� ��������� ''����������''");
				}
			case 3:
				{
					if (users[playerid][u_money] < 8000) return server_error(playerid, "� ��� ������������ �������.");
					if( (users[playerid][u_slots]+1) > users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
					// users[playerid][u_money] -= 8000;
					money(playerid, "-", 8000);
					AddItem(playerid, 118, 1);
					
					server_error(playerid, "�� ��������� ''�������� ��������''");
				}
			case 4:
				{
					if (users[playerid][u_money] < 1500) return server_error(playerid, "� ��� ������������ �������.");
					if( (users[playerid][u_slots]+1) > users[playerid][u_backpack]*10) return server_error(playerid, "��� ��������� �����, ��������� ���-������!");
					// users[playerid][u_money] -= 1500;
					money(playerid, "-", 1500);
					AddItem(playerid, 113, 1);
					
					server_error(playerid, "�� ��������� ''���������� �� ������''");
				}
			}
			show_dialog(playerid, d_green_shop, DIALOG_STYLE_TABLIST_HEADERS, !" ", !"������������\t����\n\
			{cccccc}1. {fffff0}�����\t{33AA33}1000$\n\
			{cccccc}2. {fffff0}������������� ������\t{33AA33}2500$\n\
			{cccccc}3. {fffff0}����������\t{33AA33}5000$\n\
			{cccccc}4. {fffff0}�������� ��������\t{33AA33}8000$\n\
			{cccccc}5. {fffff0}���������� �� ������\t{33AA33}1500$", !"������", !"������");
		}
	case d_campfire:
		{
			if(!response) return true;
			switch(listitem)
			{
			case 0:
				{
					if(users[playerid][u_temperature] >= 36)
					{
						server_error(playerid, "��� �� ��������� ����������.");
						callcmd::campfire(playerid);
						return true;
					}
					users[playerid][u_temperature] = 36.6;
					progress_bar(playerid, "BD_FIRE", "wash_up", 6);
					server_message(playerid, "�� ��������� � ������.");
				}
			case 1:
				{
					if(!GetItem(playerid, 5)) 
					{
						server_error(playerid, "� ��� ��� ������ ����!");
						callcmd::campfire(playerid);
						return true;
					}
					progress_bar(playerid, "BD_FIRE", "wash_up");
					AddItem(playerid, 4, 1);
					RemoveItem(playerid, 5);
				}
			case 2:
				{
					if(!GetItem(playerid, 125))
					{
						server_error(playerid, "� ��� ��� ������� ����!");
						callcmd::campfire(playerid);
						return true;
					}
					progress_bar(playerid, "BD_FIRE", "wash_up");
					AddItem(playerid, 44, 1);
					RemoveItem(playerid, 125);
				}
			case 3:
				{
					if(!GetItem(playerid, 125) && !GetItem(playerid, 44))
					{
						server_error(playerid, "��� ������� ������ ���������� ����.");
						callcmd::campfire(playerid);
						return true;
					}
					new fx = GetPVarInt(playerid, "CAMPFIRE_USER");
					progress_bar(playerid, "BD_FIRE", "wash_up");
					DestroyDynamicObject(fire[fx][fire_object][0]);
					DestroyDynamicObject(fire[fx][fire_object][1]);
					fire[fx][fire_time] = 0;
					fire[fx][fire_xyz][0] = 0.0;
					fire[fx][fire_xyz][1] = 0.0;
					fire[fx][fire_xyz][2] = 0.0;
					DeletePVar(playerid, "CAMPFIRE_USER");
					server_message(playerid, "�� �������� ������.");
					if(GetItem(playerid, 125)) RemoveItem(playerid, 125);
					else RemoveItem(playerid, 44);
					foreach(Player, i)
					{
						if(GetPVarInt(i, "FIRE_OWNER") == playerid) break;
						if(!GetPVarInt(i, "FIRE_OWNER")) continue;
						server_error(GetPVarInt(i, "FIRE_OWNER"), "��� ������ ��������.");
						DeletePVar(i, "FIRE_OWNER");
					}
				}
			}
		}
	case d_friends:
		{
			if(!response) return callcmd::menu(playerid);
			switch(listitem)
			{
			case 0: 
				{
					new mysql_format_string[(51+1)+MAX_PLAYER_NAME];
					m_format(mysql_format_string, sizeof(mysql_format_string), "SELECT * FROM "TABLE_USERS" WHERE `u_friend` = '%s'", users[playerid][u_name]);
					new Cache: temp_mysql = m_query(mysql_format_string), r;
					cache_get_row_count(r);
					if(r)
					{
						new 
							friend_name[MAX_PLAYER_NAME], friend_time, n = 0, 
							format_string[(24*100)], strcat_format_string[96];
						format_string[0] = EOS;
						for(new idx = 1; idx <= r; idx++)
						{
							cache_get_value_name(idx-1, "u_name", friend_name, MAX_PLAYER_NAME);
							cache_get_value_name_int(idx-1, "u_lifetime", friend_time);
							n++;
							switch(n)
							{
							case 1..6, 8..14, 16..22, 24..30, 32..38, 40..46, 48..54, 56..62, 63..69, 71..77, 79..85, 87..93, 95..101, 103..109, 111..117, 119..125, 127..133:
								{
									format(strcat_format_string, sizeof(strcat_format_string), "{fffff0}%s (%s) {cccccc}| ", friend_name, (friend_time < 86400)?("{CD5C5C}�� ��������{fffff0}"):("{90EE90}��������{fffff0}"));
									strcat(format_string, strcat_format_string);
								}
							default:
								{
									format(strcat_format_string, sizeof(strcat_format_string), "\n{fffff0}%s (%s) {cccccc}| ", friend_name, (friend_time < 86400)?("{CD5C5C}�� ��������{fffff0}"):("{90EE90}��������{fffff0}"));
									strcat(format_string, strcat_format_string);
								}
							}
						}
						if(n) show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "��� ������������ ������", format_string, !"�������", "");
					}
					else
					{
						callcmd::friends(playerid);
						server_error(playerid, "�� ��� �� ���������� ������.");
					}
					cache_delete(temp_mysql);
				}
			case 1: reward_users(playerid);
			case 2: show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "����������", "\
			{EEE8AA}����� ��������:\n\
			{fffff0}�� ������ ���������� ������ ��� �������� �� ������, ���� ��� ��� ����������� ������ ��� ��� � �������� 24 ����, �� �� �������� ��������� ��������������.\n\n\
			{EEE8AA}��������:\n\
			{fffff0}���������� - {FAEBD7}����� ���-�� ������� ��������� ��� ��� ��� �����������.\n\
			{fffff0}����������� - {FAEBD7}����� ���-�� �������, ������� �������� 24 ���� ����� �����������.\n\
			{fffff0}�� ����������� - {FAEBD7}����� ���-�� �������, �� �������� 24 ���� ����� �����������, �� ������� ��� ���.\n\n\
			{FFE4B5}�������:\n\
			{fffff0}'���������� 2 �����' - {FAFAD2}30.000$\n\
			{fffff0}'���������� 5 ������' - {FAFAD2}40.000$ + 10 ��������� ���������\n\
			{fffff0}'���������� 7 ������' - {FAFAD2}50.000$ + 15 ��������� ������������\n\
			{fffff0}'���������� 10 ������' - {FAFAD2}60.000$ + 10 ����������� ��������� + 10 ��������� ���������\n\
			{fffff0}'���������� 15 ������' - {FAFAD2}70.000$ + VIP �� ����� + 15 ����������� ���������\n\
			{fffff0}'���������� 20 ������' - {FAFAD2}80.000$ + VIP �� ����� + 15 ����������� ��������� + 15 ��������� ������������", !"�������", !"");
			}
		}
	case d_reward:
		{
			if(!response) return callcmd::friends(playerid);
			switch(listitem)
			{
			case 0: reward_users(playerid);
			default:
				{
					if(users[playerid][u_reward][listitem-1])
					{
						server_error(playerid, "�� ��� �������� �������������� �� ������������ ������!");
						reward_users(playerid);
						return true;
					}
					new mysql_format_string[(76+1)+MAX_PLAYER_NAME];
					m_format(mysql_format_string, sizeof(mysql_format_string), "SELECT * FROM "TABLE_USERS" WHERE `u_friend` = '%s' AND `u_lifetime` > '86399'", users[playerid][u_name]);
					new Cache: temp_mysql = m_query(mysql_format_string), r;
					cache_get_row_count(r);
					switch(listitem)
					{
					case 1:	
						{
							if(!users[playerid][u_reward][listitem-1] && r >= 2)
							{
								money(playerid, "+", 30000);
								users[playerid][u_reward][listitem-1] = 1;
								SaveUser(playerid, "reward");
								server_message(playerid, "�� �������� 30.000$ �� ����������� ������.");		
								reward_users(playerid);			
							}
							else
							{
								server_error(playerid, "��� ��������� ������� ���������� ���������� ������ ��� �������� �� ������.");
								reward_users(playerid);
							}
						}
					case 2:
						{
							if(!users[playerid][u_reward][listitem-1] && r >= 5)
							{
								users[playerid][u_pack][0] += 10;
								users[playerid][u_reward][listitem-1] = 1;
								money(playerid, "+", 40000);
								SaveUser(playerid, "pack");
								SaveUser(playerid, "reward");
								server_message(playerid, "�� �������� 40.000$ + 10 ��������� ��������� �� ����������� ������.");	
								reward_users(playerid);	
							}
							else
							{
								server_error(playerid, "��� ��������� ������� ���������� ���������� ������ ��� �������� �� ������.");
								reward_users(playerid);
							}
						}
					case 3:
						{
							if(!users[playerid][u_reward][listitem-1] && r >= 7)
							{
								users[playerid][u_pack][2] += 15;
								users[playerid][u_reward][listitem-1] = 1;
								money(playerid, "+", 50000);
								SaveUser(playerid, "pack");
								SaveUser(playerid, "reward");
								server_message(playerid, "�� �������� 50.000$ + 15 ��������� ������������ �� ����������� ������.");	
								reward_users(playerid);	
							}
							else
							{
								server_error(playerid, "��� ��������� ������� ���������� ���������� ������ ��� �������� �� ������.");
								reward_users(playerid);
							}
						}
					case 4:
						{
							if(!users[playerid][u_reward][listitem-1] && r >= 10)
							{
								users[playerid][u_pack][0] += 10;
								users[playerid][u_pack][4] += 10;
								users[playerid][u_reward][listitem-1] = 1;
								money(playerid, "+", 60000);
								SaveUser(playerid, "pack");
								SaveUser(playerid, "reward");
								server_message(playerid, "�� �������� 60.000$ + 10 ����������� ��������� + 10 ��������� ��������� �� ����������� ������.");	
								reward_users(playerid);	
							}
							else
							{
								server_error(playerid, "��� ��������� ������� ���������� ���������� ������ ��� �������� �� ������.");
								reward_users(playerid);
							}
						}
					case 5:
						{
							if(!users[playerid][u_reward][listitem-1] && r >= 10)
							{
								users[playerid][u_pack][0] += 10;
								users[playerid][u_pack][4] += 10;
								users[playerid][u_reward][listitem-1] = 1;
								money(playerid, "+", 60000);
								SaveUser(playerid, "pack");
								SaveUser(playerid, "reward");
								server_message(playerid, "�� �������� 60.000$ + 10 ����������� ��������� + 10 ��������� ��������� �� ����������� ������.");	
								reward_users(playerid);	
							}
							else
							{
								server_error(playerid, "��� ��������� ������� ���������� ���������� ������ ��� �������� �� ������.");
								reward_users(playerid);
							}
						}
					case 6:
						{
							if(!users[playerid][u_reward][listitem-1] && r >= 15)
							{
								users[playerid][u_pack][4] += 15;
								users[playerid][u_reward][listitem-1] = 1;
								money(playerid, "+", 70000);
								SaveUser(playerid, "pack");
								SaveUser(playerid, "reward");
								users[playerid][u_vip_time] += 1296000;
								SaveAccountInt(playerid, "u_vip_time", users[playerid][u_vip_time]);
								server_message(playerid, "�� �������� 70.000$ + VIP �� ����� + 15 ����������� ��������� �� ����������� ������.");	
								reward_users(playerid);	
							}
							else
							{
								server_error(playerid, "��� ��������� ������� ���������� ���������� ������ ��� �������� �� ������.");
								reward_users(playerid);
							}
						}
					case 7:
						{
							if(!users[playerid][u_reward][listitem-1] && r >= 20)
							{
								users[playerid][u_pack][2] += 15;
								users[playerid][u_pack][4] += 15;
								users[playerid][u_reward][listitem-1] = 1;
								money(playerid, "+", 80000);
								SaveUser(playerid, "pack");
								SaveUser(playerid, "reward");
								users[playerid][u_vip_time] += 1296000;
								SaveAccountInt(playerid, "u_vip_time", users[playerid][u_vip_time]);
								server_message(playerid, "�� �������� 80.000$ + VIP �� ����� + 15 ����������� ��������� + 15 ��������� ������������ �� ����������� ������.");	
								reward_users(playerid);	
							}
							else
							{
								server_error(playerid, "��� ��������� ������� ���������� ���������� ������ ��� �������� �� ������.");
								reward_users(playerid);
							}
						}
					}
					cache_delete(temp_mysql);
				}
			}
		}
	}
	return true; 
}