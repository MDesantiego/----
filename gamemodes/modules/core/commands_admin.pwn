//Алиасы:
alias:clearchat("cc");
alias:recon("re");
alias:otvet("ans");
alias:admin("a");
alias:goto("g");
alias:gethere("gh");
alias:ooc("o");
alias:apanel("ap");
alias:teleport("tp");
alias:changeclanspawn("cspclan");
alias:clanspawn("spclan");
alias:reprimand("avig");
alias:creprimand("cvig");

//Команды:
CMD:alogin(playerid)
{
	if(admin[playerid][u_a_dostup] == 1)
	{
		AdminChatF("%s %s вышел из административной панели.", admin_rank_name(playerid), users[playerid][u_name]);
		admin[playerid][u_a_dostup] = 0;
		admin[playerid][admin_level] = 0;
		// admin[playerid][u_a_protrct_ac] = 0;
		AntiCheatOffAndOn(playerid, 1);
		foreach(Player, i) clan_syntax(i);
		server_error(playerid, "Вы вышли из административной панели.");
		return true;
	}
	new str_sql[96], str_sql_password[65];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' LIMIT 1", users[playerid][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r) 
	{
		cache_get_value_name(0, "u_a_password", str_sql_password, 65);
		if(GetPVarInt(playerid, "AdminLogin")) DeletePVar(playerid, "AdminLogin");
		if(!strcmp(str_sql_password, "newadminplayer", false)) 
		{
			SetPVarInt(playerid, "AdminLogin", 1);
			show_dialog(playerid, d_admin_login, DIALOG_STYLE_INPUT, !"Вход в административную систему", !"Придумайте пароль\n\n{33AA33}- {FFFFFF}Пароль должен состоять из латинских букв, а так же цифр\n{33AA33}- {FFFFFF}Длина пароля от 6-ти до 32-х символов", !"Войти", !"Отмена");
		}
		else 
		{
			SetPVarInt(playerid, "AdminLogin", 2);
			show_dialog(playerid, d_admin_login, DIALOG_STYLE_PASSWORD, !"Вход в административную систему", !"Введите пароль от административной панели\n\n{33AA33}- {FFFFFF}Пароль должен состоять из латинских букв, а так же цифр\n{33AA33}- {FFFFFF}Длина пароля от 6-ти до 32-х символов", !"Войти", !"Отмена");
		}
	}
	else server_error(playerid, "Доступ ограничен.");
	cache_delete(temp_sql);
	return true;
}
CMD:aspawn(playerid, params[])
{
	AdminProtect(1);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "Используйте: /aspawn [имя/ид]");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	SCMG(params[0], "Администратор %s заспавнил вас.", users[playerid][u_name]);
	SCMG(playerid, "Вы заспавнили игрока %s.", users[params[0]][u_name]);
	SpawnPlayer(params[0]);
	AntiFloodCommands(playerid, "/aspawn", 5);
	return true;
}
CMD:offadmin(playerid, params[])
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "s[24]", params[0])) return server_error(playerid, "Используйте: /offadmin [имя]");
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	new str_sql[156];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' LIMIT 1", params[0]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		m_format(str_sql, sizeof(str_sql), "DELETE FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s'", params[0]);
		m_query(str_sql);
		SCMG(playerid, "Вы сняли администратора %s с поста модератора.", params[0]);
	}
	else server_error(playerid, "Такой ник не найден в базе данных администрации.");
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/offadmin");
	return true;
}
CMD:makeadmin(playerid, params[])
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "ui", params[0], params[1])) return server_error(playerid, "Используйте: /makeadmin [имя/ид] [уровень от 1 до 6 (0 - снять)]");
	if(!FullDostup(playerid, 1))
	{
		if(params[1] > 6 || params[1] < 0) return server_error(playerid, "Уровень не может быть меньше 1 и больше 6!");
	}
	else
	{
		if(params[1] > 7 || params[1] < 0) return server_error(playerid, "Уровень не может быть меньше 1 и больше 7!");
	}
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	new str_sql[156];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' LIMIT 1", users[params[0]][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		if(params[1] == 0)
		{	
			m_format(str_sql, sizeof(str_sql), "DELETE FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s'", users[params[0]][u_name]);
			m_query(str_sql);
			SCMG(params[0], "%s снял вас с поста модератора.", users[playerid][u_name]);
			SCMG(playerid, "Вы сняли администратора %s с поста модератора.", users[params[0]][u_name]);
			admin[params[0]][u_a_dostup] = 0;
			admin[params[0]][admin_level] = 0;
			server_error(playerid, "Вас сняли с поста модератора.");
			
		}
		else 
		{
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_level` = '%i' WHERE `u_a_name` = '%s'", params[1], users[params[0]][u_name]);
			m_query(str_sql);
			SCMG(params[0], "%s изменил вам уровень администраторания на %s.", users[playerid][u_name], admin_name_rank[params[1]-1]);
			SCMG(playerid, "Вы изменили для %s уровень администраторания на %s.", users[params[0]][u_name], admin_name_rank[params[1]-1]);
		}
	}
	else 
	{
		m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_ADMIN" (`u_a_name`, `admin_level`, `u_a_owner`, `u_a_data`) VALUES ('%s', '%i', '%s', NOW())", users[params[0]][u_name], params[1], users[playerid][u_name]);
		m_query(str_sql);
		SCMG(params[0], "%s назначил вас на пост %s.", users[playerid][u_name], admin_name_rank[params[1]-1]);
		server_accept(params[0], "Используйте /alogin для авторизации в административной панели.");
		SCMG(playerid, "Вы назначили %s на пост %s.", users[params[0]][u_name], admin_name_rank[params[1]-1]);
	}
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/makeadmin");
	return true;
}
CMD:setadmin(playerid, params[])
{
	AdminProtect(6);
	if(sscanf(params, "ui", params[0], params[1])) return server_error(playerid, "Используйте: /setadmin [имя/ид] [уровень от 1 до 4 (0 - снять)]");
	if(params[1] > 4 || params[1] < 0) return server_error(playerid, "Уровень не может быть меньше 1 и больше 4!");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	new str_sql[156];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' LIMIT 1", users[params[0]][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		if(params[1] == 0)
		{	
			m_format(str_sql, sizeof(str_sql), "DELETE FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s'", users[params[0]][u_name]);
			m_query(str_sql);
			SCMG(params[0], "%s снял вас с поста модератора.", users[playerid][u_name]);
			SCMG(playerid, "Вы сняли администратора %s с поста модератора.", users[params[0]][u_name]);
			admin[params[0]][u_a_dostup] = 0;
			admin[params[0]][admin_level] = 0;
			server_error(playerid, "Вас сняли с поста модератора.");

			static str_logs[96];
			format(str_logs, sizeof(str_logs), "Администратор снял игрока %s с поста администратора.", users[params[0]][u_name]);
			logs_admin(playerid, str_logs, "/setadmin");
		}
		else 
		{
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_level` = '%i' WHERE `u_a_name` = '%s'", params[1], users[params[0]][u_name]);
			m_query(str_sql);
			if(admin[params[0]][u_a_dostup] != 0) admin[params[0]][admin_level] = params[1];
			SCMG(params[0], "%s изменил вам уровень администраторания на %s.", users[playerid][u_name], admin_name_rank[params[1]-1]);
			SCMG(playerid, "Вы изменили для %s уровень администраторания на %s.", users[params[0]][u_name], admin_name_rank[params[1]-1]);

			static str_logs[96];
			format(str_logs, sizeof(str_logs), "Изменил уровень администрирования для %s на %i уровень.", users[params[0]][u_name], params[1]);
			logs_admin(playerid, str_logs, "/setadmin");
		}
	}
	else 
	{
		m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_ADMIN" (`u_a_name`, `admin_level`, `u_a_owner`, `u_a_data`) VALUES ('%s', '%i', '%s', NOW())", users[params[0]][u_name], params[1], users[playerid][u_name]);
		m_query(str_sql);
		SCMG(params[0], "%s назначил вас на пост %s.", users[playerid][u_name], admin_name_rank[params[1]-1]);
		server_accept(params[0], "Используйте /alogin для авторизации в административной панели.");
		SCMG(playerid, "Вы назначили %s на пост %s.", users[params[0]][u_name], admin_name_rank[params[1]-1]);

		static str_logs[96];
		format(str_logs, sizeof(str_logs), "Назначил игрока %s на пост администратора %i уровня.", users[params[0]][u_name], params[1]);
		logs_admin(playerid, str_logs, "/setadmin");
	}
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/setadmin", 300);
	return true;
}
CMD:afreezeoff(playerid, params[])
{
	AdminProtect(6);
	static str[24];
	if(sscanf(params, "us[2]s[128]", params[0], str, params[2])) return server_error(playerid, "Используйте: /afreezeoff [имя/ид] [+/-] [Причина]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' LIMIT 1", users[params[0]][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		static freeze;
		// cache_get_value_name_int(0, "u_a_reprimand", reprimand);
		cache_get_value_name_int(0, "u_a_freeze", freeze);
		if(!strcmp(str, "+", false))
		{
			if(freeze > 0)
			{
				server_error(playerid, "Администратор уже заморожен в административной панели.");
				cache_delete(temp_sql);
				return true;
			}
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_freeze` = '1' WHERE `u_a_name` = '%s'", users[params[0]][u_name]);
			m_query(str_sql);
			AdminChatF("[A] %s %s заморозил администратора %s[%i]. Причина: %s.", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);

			static str_logs[128];
			format(str_logs, sizeof(str_logs), "Заморозил администратора %s. Причина: %s", users[params[0]][u_name], params[2]);
			logs_admin(playerid, str_logs, "/afreezeoff");

			SCMG(playerid, "Вы заморозили администратора %s(%i).", users[params[0]][u_name], params[0]);
			callcmd::alogin(params[0]);
		}
		if(!strcmp(str, "-", false))
		{
			if(freeze < 1)
			{
				server_error(playerid, "Администратор уже разморожен в административной панели.");
				cache_delete(temp_sql);
				return true;
			}
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_freeze` = '0' WHERE `u_a_name` = '%s'", users[params[0]][u_name]);
			m_query(str_sql);
			AdminChatF("[A] %s %s разморозил администратора %s[%i]. Причина: %s.", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
			
			static str_logs[128];
			format(str_logs, sizeof(str_logs), "Разморозил администратора %s. Причина: %s", users[params[0]][u_name], params[2]);
			logs_admin(playerid, str_logs, "/afreezeoff");

			SCMG(playerid, "Вы разморозили администратора %s(%i).", users[params[0]][u_name], params[0]);
			callcmd::alogin(params[0]);
		}
	}
	else SCMASS(playerid, "Игрок %s не администратор.", users[params[0]][u_name]);
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/afreezeoff");
	return true;
}
CMD:reprimand(playerid, params[])
{
	AdminProtect(5);
	static str[24];
	if(sscanf(params, "us[2]s[128]", params[0], str, params[2])) return server_error(playerid, "Используйте: /reprimand [имя/ид] [+/-] [Причина]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' LIMIT 1", users[params[0]][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		static reprimand, freeze;
		cache_get_value_name_int(0, "u_a_reprimand", reprimand);
		cache_get_value_name_int(0, "u_a_freeze", freeze);
		if(freeze > 0 && reprimand > 2)
		{
			SCMG(playerid, "Администратор %s(%i) заморожен, напишите старшему составу администрации", users[params[0]][u_name], params[0]);
			cache_delete(temp_sql);
			return true;
		}
		if(!strcmp(str, "+", false))
		{
			switch(reprimand)
			{
			case 0, 1:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_reprimand` = `u_a_reprimand` + '1' WHERE `u_a_name` = '%s'", users[params[0]][u_name]);
					m_query(str_sql);
					AdminChatF("[A] %s %s выдал администратору %s[%i] выговор. Причина: %s.", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
					SCMG(playerid, "Вы выдали выговор игроку %s(%i).", users[params[0]][u_name], params[0]);

					static str_logs[156];
					format(str_logs, sizeof(str_logs), "Выдал выговор администратору %s. Причина: %s", users[params[0]][u_name], params[2]);
					logs_admin(playerid, str_logs, "/reprimand");
				}
			case 2:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_reprimand` = '3', `u_a_freeze` = '1' WHERE `u_a_name` = '%s'", users[params[0]][u_name]);
					m_query(str_sql);
					AdminChatF("[A] %s %s выдал администратору %s[%i] выговор. Причина: %s.", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
					AdminChatF("[A] %s %s временно заморожен в административной панели. Причина: Выговор 3 из 3", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
					
					static str_logs[196];
					format(str_logs, sizeof(str_logs), "Выдал выговор администратору %s, после администртора заморозило. Причина: %s", users[params[0]][u_name], params[2]);
					logs_admin(playerid, str_logs, "/reprimand");

					SCMG(playerid, "Вы выдали выговор игроку %s(%i).", users[params[0]][u_name], params[0]);
					callcmd::alogin(params[0]);
				}
			}
		}
		if(!strcmp(str, "-", false))
		{
			switch(reprimand)
			{
			case 0: server_error(playerid, "У администратора нет выговоров");
			case 1, 2:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_reprimand` = `u_a_reprimand` - '1' WHERE `u_a_name` = '%s'", users[params[0]][u_name]);
					m_query(str_sql);
					AdminChatF("[A] %s %s снял администратору %s[%i] выговор. Причина: %s.", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
					SCMG(playerid, "Вы сняли выговор игроку %s(%i).", users[params[0]][u_name], params[0]);
					
					static str_logs[156];
					format(str_logs, sizeof(str_logs), "Снял выговор администратору %s. Причина: %s", users[params[0]][u_name], params[2]);
					logs_admin(playerid, str_logs, "/reprimand");
				}
			}
		}
	}
	else SCMASS(playerid, "Игрок %s не администратор.", users[params[0]][u_name]);
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/reprimand");
	return true;
}
CMD:creprimand(playerid, params[])
{
	AdminProtect(5);
	static str[24];
	if(sscanf(params, "is[2]s[128]", params[0], str, params[2])) return server_error(playerid, "Используйте: /creprimand [номер калана] [+/-] [Причина]");
	// if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_id` = '%i' LIMIT 1", params[0]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		static reprimand;
		cache_get_value_name_int(0, "c_reprimand", reprimand);
		if(!strcmp(str, "+", false))
		{
			switch(reprimand)
			{
			case 0..2:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CLAN" SET `c_reprimand` = `c_reprimand` + '1' WHERE `c_id` = '%i'", params[0]);
					m_query(str_sql);
					AdminChatF("[A] %s %s выдал клану %s(%i) выговор. Причина: %s.", admin_rank_name(playerid), users[playerid][u_name], clan[params[0]][c_name], params[0], params[2]);
					SCMG(playerid, "Вы выдали выговор клану %s(%i).", clan[params[0]][c_name], params[0]);
					
					format(str_sql, sizeof(str_sql), "[R][CLAN] Администратция выдала выговор клану. Причина: %s.", params[2]);
					clan_message(params[0], str_sql);

					static str_logs[156];
					format(str_logs, sizeof(str_logs), "Выдал выговор клану №%i. Причина: %s", params[0], params[2]);
					logs_admin(playerid, str_logs, "/creprimand");
				}
			case 3: server_error(playerid, "У клана %s(%i) 3 из 3 выговора.");
			}
		}
		else if(!strcmp(str, "-", false))
		{
			switch(reprimand)
			{
			case 0: server_error(playerid, "У клана нет выговоров");
			case 1..3:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CLAN" SET `c_reprimand` = `c_reprimand` - '1' WHERE `c_id` = '%i'", params[0]);
					m_query(str_sql);
					AdminChatF("[A] %s %s снял клану %s(%i) выговор. Причина: %s.", admin_rank_name(playerid), users[playerid][u_name], clan[params[0]][c_name], params[0], params[2]);
					
					static str_logs[156];
					format(str_logs, sizeof(str_logs), "Снял выговор клану №%i. Причина: %s", params[0], params[2]);
					logs_admin(playerid, str_logs, "/creprimand");

					SCMG(playerid, "Вы сняли выговор клану %s(%i).", clan[params[0]][c_name], params[0]);
					format(str_sql, sizeof(str_sql), "[R][CLAN] Администратция сняла выговор клану. Причина: %s.", params[2]);
					clan_message(params[0], str_sql);
				}
			}
		}
		else server_error(playerid, "ERROR ( + or - )");
	}
	else SCMASS(playerid, "Клан %i не найден.", params[0]);
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/creprimand");
	return true;
}
CMD:clearchat(playerid, params[]) 
{
	AdminProtect(1);
	for(new c = 0; c < 65; c++) { SendClientMessageToAll(COLOR_RED, " "); }
	SendClientMessageToAll(COLOR_BROWN, "Администрация "FULL_NAME" произвела очистку глобального чата!");
	AdminChatF("[A] %s %s произвёл очистку глобального чата.", admin_rank_name(playerid), users[playerid][u_name]);
	
	logs_admin(playerid, "Произвел очистку чата", "/clearchat");
	AntiFloodCommands(playerid, "/clearchat");
	return true; 
}
CMD:tpcar(playerid, params[]) 
{
	AdminProtect(3);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "Используйте: /tpcar [номер авто]");
	if(params[0] < 1 || params[0] > count_veh) return server_error(playerid, "Используйте: /tpcar [номер авто]");
	static Float: pos_veh[3];
	GetVehiclePos(params[0], pos_veh[0], pos_veh[1], pos_veh[2]);
	SetPlayerPos(playerid, pos_veh[0], pos_veh[1], pos_veh[2]+1);
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "Телепортировался к автомобилю №%i", params[0]);
	logs_admin(playerid, str_logs, "/tpcar");
	AntiFloodCommands(playerid, "/tpcar");
	return true;
}
CMD:tpbox(playerid, params[])
{
	AdminProtect(5);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "Используйте: /tpbox [номер бокса]");
	if(params[0] < 1 || params[0] > MAX_BOX) return server_error(playerid, "Используйте: /tpbox [номер бокса]");
	if(box[params[0]][box_xyzf][0] == 0) return server_error(playerid, "Бокс скорее всего уже кто-то уделил.");
	SPP(playerid, box[params[0]][box_xyzf][0], box[params[0]][box_xyzf][1], box[params[0]][box_xyzf][2]+1.5, random(360), 0, 0);
	
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "Телепортировался к боксу №%i", params[0]);
	logs_admin(playerid, str_logs, "/tpbox");
	AntiFloodCommands(playerid, "/tpbox");
	return true;
}
CMD:sethp(playerid, params[]) 
{
	AdminProtect(2);
	if(sscanf(params,"ui", params[0], params[1])) return server_error(playerid, "Используйте: /sethp [имя/ид] [уровень жизни]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	if(params[1] > 100) return server_error(playerid, "Больше 100 hp нельзя.");
	AdminChatF("[A] %s %s установил %i жизней игроку %s[%i].", admin_rank_name(playerid), users[playerid][u_name], params[1], users[params[0]][u_name], params[0]);
	SCMG(params[0], "Администратор %s установил вам %i жизней.", users[playerid][u_name], params[1]);
	SetPlayerHealth(params[0], params[1]);
	//l[params[0]][u_health] = params[1];
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "Изменил жизни игроку %s на %i", users[params[0]][u_name], params[1]);
	logs_admin(playerid, str_logs, "/sethp");
	AntiFloodCommands(playerid, "/sethp");
	return 1; 
}
/*
CMD:otvet(playerid, params[]) 
{
	AdminProtect(1);
	if(sscanf(params,"us[96]", params[0], params[1])) return server_error(playerid, "Используйте: /otvet [имя/ид] [ответ]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	SCMF(params[0], COLOR_BROWN, "[REPORT] {ffffff}Администратор %s ответил: %s", users[playerid][u_name], params[1]);
	AdminChatF("[A] %s %s ответил игроку %s[%i]: %s.", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[1]);
	
	static str_logs[196];
	format(str_logs, sizeof(str_logs), "Ответил игроку %s: %s", users[params[0]][u_name], params[1]);
	logs_admin(playerid, str_logs, "/otvet");
	return 1; 
}
*/
CMD:givegun(playerid, params[]) 
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params,"uii", params[0], params[1], params[2])) 
	{
		server_error(playerid, "Используйте: /givegun [имя/ид] [weaponid] [ammo]");
		SendClientMessage(playerid, COLOR_GREY, "2(Клюшка для гольфа) 3(Дубинка) 4(Нож) 5(Бита) 6(Лопата) 7(Кий) 8(Катана) 9(Пила) 10-13(Фалоиммитатор) 14(Цветы)");
		SendClientMessage(playerid, COLOR_GREY, "16(Граната) 17(Дымовая шашка) 18(Коктейль Молотова) 22(Пистолет) 23(Пистолет с глушителем) 24(Пустынный орёл) ");
		SendClientMessage(playerid, COLOR_GREY, "25(Дробовик) 26(Обрез) 27(Боевой дробовик) 28(Uzi) 29(MP5) 30(AK-47) 31(M4) 32(TEC-9) 33(Винтовка) 34(Снайперка)");
		SendClientMessage(playerid, COLOR_GREY, "37(Огнемёт) 41(Баллончик) 42(Огнетушитель) 43(Фотоаппарат) 46(Парашют)");
		return 1; 
	}
	switch(params[1])
	{
	case 35..38, 44, 45: return server_error(playerid, "Это оружие запрещено!");
	}
	if(params[2] < 1 || params[2] > 500) return server_error(playerid, "Кол-во патронов можно выдавать от 1 до 500");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	ServerGivePlayerWeapon(params[0], params[1], params[2]);
	AdminChatF("[A] %s %s выдал оружие %i и %i патрон игроку %s[%i].", admin_rank_name(playerid), users[playerid][u_name], params[1], params[2], users[params[0]][u_name], params[0]);
	SCMG(params[0], "Администратор %s выдал вам оружие %i и %i патрон.", users[playerid][u_name], params[1], params[2]);
	
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "Выдал оружие игроку %s (GUN: %i, AMMO: %i)", users[params[0]][u_name], params[1], params[2]);
	logs_admin(playerid, str_logs, "/givegun");
	AntiFloodCommands(playerid, "/givegun", 120);

	return 1; 
}
CMD:hp(playerid, params[]) 
{
	AdminProtect(1);
	users[playerid][u_damage][0] = 0;
	users[playerid][u_damage][1] = 0;
	SetPlayerDrunkLevel(playerid, 0);
	GivePlayerHealth(playerid, 100.0);
	SetPlayerNeed(playerid, 0, 100);
	SetPlayerNeed(playerid, 1, 100);
	//users[playerid][u_health] = 100.0;
	logs_admin(playerid, "Выдал себе жизни.", "/hp");
	return 1; 
}
CMD:admin(playerid, params[]) 
{
	AdminProtect(1);
	if(sscanf(params, "s[80]", params[0])) return server_error(playerid, "Используйте: /(a)dmin [текст]");
	AdminChatF("[A] %s {FFFFFF}%s[%d]: {E0E0E0}%s", admin_rank_name(playerid), users[playerid][u_name], playerid, params[0]);
	return true; 
}
CMD:lootname(playerid)
{
	if(!FullDostup(playerid)) return -1;
	global_string[0] = EOS;
	new str[96];
	strcat(global_string, "Номер предмета\tНазвание предмета\n");
	for(new slot = 1; slot != max_items; slot++) 
	{
		format(str, sizeof(str), "%i\t%s\n", slot, loots[slot][loot_name]);
		strcat(global_string, str);
	}
	show_dialog(playerid, d_none, DIALOG_STYLE_TABLIST_HEADERS, !"{FFA07A}Предметы "FULL_NAME"", global_string, !"Закрыть", !"");
	return true;
}
CMD:loot(playerid, params[]) 
{
	if(!FullDostup(playerid)) return -1;
	if(sscanf(params,"ii", params[0], params[1])) 
	{
		server_error(playerid, "Используйте: /loot [Номер пердмета] [Кол-во]");
		server_error(playerid, "Для просмотра полного списка предметов, введите /lootname");
		return 1; 
	}
	if(params[0] < 1 || params[0] > max_items-1) return SCMASS(playerid, "ID лута от 1 до %i!", max_items-1);
	if(params[1] < 1 || params[1] > 5) return server_error(playerid, "Кол-во от 1 до 5!");
	new Float:l_c[3];
	GetPlayerPos(playerid, l_c[0], l_c[1], l_c[2]);
	// DroppedInventoryPlayer(params[0], l_c[0], l_c[1], l_c[2], params[1], );
	// AddItem(playerid, Ammunition[listitem], getAmmoByItem(Ammunition[listitem]));
	switch(params[0])
	{
	case 18..25, 63..65, 75..76: DroppedInventoryPlayer(params[0], l_c[0], l_c[1], l_c[2], params[1], getAmmoByItem(params[0]));
	case 118: DroppedInventoryPlayer(params[0], l_c[0], l_c[1], l_c[2], params[1], 100);
	default: DroppedInventoryPlayer(params[0], l_c[0], l_c[1], l_c[2], params[1]);
	}
	// AdminChatF("[A] %s %s создал предмет %s в колличестве %i шт (%f, %f, %f).", admin_rank_name(playerid), users[playerid][u_name], loots[params[0]][loot_name], params[1], l_c[0], l_c[1], l_c[2]);
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "Создал предмет %s(%i) в кол-ве %i", loots[params[0]][loot_name], params[0], params[1]);
	logs_admin(playerid, str_logs, "/loot");
	return true; 
}
CMD:goto(playerid, params[]) 
{
	AdminProtect(2);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "Используйте: /(g)oto [имя/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	// if(observation[params[0]][observation_id] != -1) return server_error(playerid, "Данный игрок в режиме наблюдения.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	new Float: g_plocx[3];
	GetPlayerPos(params[0], g_plocx[0], g_plocx[1], g_plocx[2]);
	SPP(playerid, g_plocx[0]+1, g_plocx[1], g_plocx[2]+1.0, GetPlayerVirtualWorld(params[0]), GetPlayerInterior(params[0]));
	AdminChatF("[A] %s %s телепортировался к игроку %s[%i].", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0]);
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "Телепортировался к игроку %s", users[params[0]][u_name]);
	logs_admin(playerid, str_logs, "/goto");
	AntiFloodCommands(playerid, "/goto");
	return 1; 
}
CMD:setworld(playerid, params[])
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params,"uii", params[0], params[1], params[2])) return server_error(playerid, "Используйте: /setworld [имя/ид] [мир] [инт]");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	// if(observation[params[0]][observation_id] != -1) return server_error(playerid, "Данный игрок в режиме наблюдения.");
	SetPVarInt(playerid, "OldVirtualWorld", GetPlayerVirtualWorld(params[0]));
	SetPVarInt(playerid, "OldVirtualWorld2", GetPlayerInterior(params[0]));
	SetPlayerVirtualWorld(params[0], params[1]);
	SetPlayerInterior(params[0], params[2]);
	static str[256];
	format(str, sizeof(str), "{33AA33}Вы сменили мир и иньерьер для игрока {cccccc}%s(%i)\n\n{ffffff}Старый мир: {cccccc}%i{ffffff}, Старый интерьер: {cccccc}%i\n{ffffff}Новый мир: {cccccc}%i{ffffff}, Новый интерьер: {cccccc}%i", 
	users[params[0]][u_name], params[0], GetPVarInt(playerid, "OldVirtualWorld"), GetPVarInt(playerid, "OldVirtualWorld2"), params[1], params[2]);
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "setworld", str, "Ок", "");

	static str_logs[196];
	format(str_logs, sizeof(str_logs), "Установил новый вирт. мир %i и инт. %i для игрока %s (Old world: %i, Old int: %i)", params[1], params[2], users[params[0]][u_name], GetPVarInt(playerid, "OldVirtualWorld"), GetPVarInt(playerid, "OldVirtualWorld2"));
	logs_admin(playerid, str_logs, "/setworld");

	DeletePVar(playerid, "OldVirtualWorld");
	DeletePVar(playerid, "OldVirtualWorld2");
	return true;
}
CMD:getworld(playerid, params[])
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params,"u", params[0])) return server_error(playerid, "Используйте: /getworld [имя/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	SCMG(playerid, "Ник: {cccccc}%s(%i) {fffff0}| Мир: {cccccc}%i {fffff0}| Интерьер: {cccccc}%i", users[params[0]][u_name], params[0], GetPlayerVirtualWorld(params[0]), GetPlayerInterior(params[0]));
	return true;
}
CMD:gethere(playerid, params[]) 
{
	AdminProtect(2);
	if(sscanf(params,"u", params[0])) return server_error(playerid, "Используйте: /gethere [имя/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	new Float: g_plocx[3];
	GetPlayerPos(playerid, g_plocx[0], g_plocx[1], g_plocx[2]);
	SPP(params[0], g_plocx[0]+1, g_plocx[1], g_plocx[2]+1.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	server_accept(params[0], "Вас телепортировал администратор проекта "FULL_NAME"");
	AdminChatF("[A] %s %s телепортировал к себе игрока %s[%i].", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0]);
	
	static str_logs[196];
	format(str_logs, sizeof(str_logs), "Телепортировал игрока %s к себе", users[params[0]][u_name]);
	logs_admin(playerid, str_logs, "/gethere");
	AntiFloodCommands(playerid, "/gethere");
	return 1; 
}
CMD:agm(playerid) 
{
	AdminProtect(2);
	switch(admin[playerid][u_a_gm])
	{
	case 0:
		{
			SetPlayerHealth(playerid, 0x7F800000);
			admin[playerid][u_a_gm] = 1;
			server_accept(playerid, "Вы включили {cccccc}'Бесконечные жизни'.");
		}
	case 1:
		{
			SetPlayerHealth(playerid, 100.0);
			admin[playerid][u_a_gm] = 0;
			server_error(playerid, "Вы выключили {cccccc}'Бесконечные жизни'.");
		}
	}
	return 1; 
}
CMD:agm_player(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params,"u", params[0])) return server_error(playerid, "Используйте: /agm_player [имя/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	switch(admin[params[0]][u_a_gm])
	{
	case 0:
		{
			//SetPlayerHealth(params[0], 0x7F800000);
			admin[params[0]][u_a_gm] = 1;
			SCMG(playerid, "Вы включили {cccccc}'Бесконечные жизни' {ffffff}для игрока %s (%i).", users[params[0]][u_name], params[0]);
		}
	case 1:
		{
			//dSetPlayerHealth(params[0], 100);
			admin[params[0]][u_a_gm] = 0;
			SCMASS(playerid, "Вы выключили {cccccc}'Бесконечные жизни' {ffffff}для игрока %s (%i).", users[params[0]][u_name], params[0]);
		}
	}
	return true;
}/*
CMD:unac(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params,"u", params[0])) return server_error(playerid, "Используйте: /unac [имя/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(!admin[params[0]][admin_level]) return server_error(playerid, "Игрок не администратор.");
	switch(admin[params[0]][u_a_protrct_ac])
	{
	case 0:
		{
			admin[params[0]][u_a_protrct_ac] = 1;
			SCMASS(playerid, "Вы выключили {cccccc}'Анти-чит' {ffffff}для игрока %s (%i).", users[params[0]][u_name], params[0]);
		}
	case 1:
		{
			admin[params[0]][u_a_protrct_ac] = 0;
			SCMG(playerid, "Вы включили {cccccc}'Анти-чит' {ffffff}для игрока %s (%i).", users[params[0]][u_name], params[0]);
		}
	}
	return true;
}*/
CMD:ooc(playerid, params[]) 
{
	AdminProtect(2);
	if(sscanf(params, "s[128]", params[0])) return server_error(playerid, "Используйте: /(o)oc [Text]");
	//if(GetTextBlurb(playerid,params[0],"/o")) return true;
	SCMAF(0xFFFFFFFF, "[OOC] %s[%d]: %s", users[playerid][u_name], playerid, params[0]);
	return 1; 
}
CMD:mute(playerid, params[]) 
{
	AdminProtect(1);
	if(sscanf(params, "uis[100]", params[0], params[1], params[2])) return server_error(playerid, "Используйте: /mute [имя/ид] [минуты] [причина] (снять бан чата /unmute [имя/ид])");
	if(PlayerIsOnline(params[0]) || params[0] == playerid) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(params[1] < 1 || params[1] > 300) return server_error(playerid, "Время от 1 минуты до 300");
	if(admin[params[0]][admin_level] >= 1) return server_error(playerid,"Игрок администратор");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	new str[96];
	global_string[0] = EOS;
	strcat(global_string, "{ffffff}");
	strcat(global_string, "Вы получили бан-чата!\n\n");
	format(str, sizeof(str), "Выдал администратор: {FF3333}%s\n", users[playerid][u_name]);
	strcat(global_string, str);
	format(str, sizeof(str), "{FFFFFF}Время бана: {FF3333}%i минут(ы/а)\n", params[1]);
	strcat(global_string, str);
	format(str, sizeof(str), "{FFFFFF}Причина бана: {FF3333}%s\n", params[2]);
	strcat(global_string, str);
	strcat(global_string, "{FFFFFF}Если вы считаете что бан чата выдан ложно, можете написать жалобу на форуме "FORU_NAME".");
	show_dialog(params[0], d_none, DIALOG_STYLE_MSGBOX, !"", global_string, !"Закрыть", !"");
	SCMAF(COLOR_BROWN, "Администратор %s выдал бан чата игроку %s на %i минут(ы). Причина: %s", users[playerid][u_name], users[params[0]][u_name], params[1], params[2]);
	users[params[0]][u_mute] = params[1]*60;
	
	static str_logs[196];
	format(str_logs, sizeof(str_logs), "Заблокирвоал чат игроку %s на %i минут. Причина: %s", users[params[0]][u_name], params[1], params[2]);
	logs_admin(playerid, str_logs, "/mute");
	AntiFloodCommands(playerid, "/mute");
	return 1; 
}
CMD:unmute(playerid, params[]) 
{
	AdminProtect(1);
	if(sscanf(params, "us[100]", params[0], params[1])) return server_error(playerid, "Используйте: /unmute [имя/ид] [причина]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(!users[params[0]][u_mute]) return server_error(playerid, "У игрока нету блокировки чата!");
	users[params[0]][u_mute] = 0;
	SCMAF(COLOR_BROWN, "Администратор %s снял бан чата игроку %s. Причина: %s", users[playerid][u_name], users[params[0]][u_name], params[1]);
	static str_logs[196];
	format(str_logs, sizeof(str_logs), "Разблокировал чат игроку %s. Причина: %s", users[params[0]][u_name], params[1]);
	logs_admin(playerid, str_logs, "/unmute");
	AntiFloodCommands(playerid, "/unmute");
	return 1; 
}
/*CMD:repair(playerid) 
{
	AdminProtect(3);
	if(!IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы должны находиться в транспортном средстве!");
	RepairVehicle(GetPlayerVehicleID(playerid));
	dSetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
	for(new vtire = 0; vtire != 4; vtire++) { dVehicleInfo[GetPlayerVehicleID(playerid)][VehicleTires][vtire] = 1; }
	dVehicleInfo[GetPlayerVehicleID(playerid)][VehicleFuel] = 80;
	server_error(playerid, "Транспорт был успешно отремонтирован!", 1);
	return 1; 
}*/
CMD:kick(playerid, params[]) 
{
	AdminProtect(1);
	if(sscanf(params,"us[100]", params[0], params[1])) return server_error(playerid, "Используйте: /kick [имя/ид] [причина]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	//if(GetTextBlurb(playerid,params[1],"/kick"))											return true;
	if(admin[params[0]][admin_level] > admin[playerid][admin_level])
	{
		server_error(playerid, "Администратора нельзя кинуть"); 
		AdminChatF("[A] %s %s хотел кикнуть администратора %s. Причина: %s", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[1]);
		return true;
	}
	SCMAF(COLOR_BROWN, "Администратор %s кикнул игрока %s. Причина: %s", users[playerid][u_name], users[params[0]][u_name], params[1]);
	TKICK(params[0], "Вы были кикнуты администрацией проекта.");
	
	static str_logs[196];
	format(str_logs, sizeof(str_logs), "Кикнул игрока %s. Причина: %s", users[params[0]][u_name], params[1]);
	logs_admin(playerid, str_logs, "/kick");
	AntiFloodCommands(playerid, "/kick");
	return 1; 
}
CMD:weather(playerid, params[]) 
{
	AdminProtect(5);
	SetWeather(weather[random(sizeof(weather))]);
	server_accept(playerid, "Вы сменили погоду.");
	AdminChatF("[A] %s %s сменил погоду.", admin_rank_name(playerid), users[playerid][u_name]);
	logs_admin(playerid, "Сменил погоду", "/weather");
	AntiFloodCommands(playerid, "/weather");
	return 1; 
}
CMD:restart(playerid, params[]) 
{
	AdminProtect(6);
	foreach(Player, i)
	{
		if(!IsPlayerConnected(i)) continue;
		//SaveUser(i, "account");
		TKICK(i, "Сервер перезапускается...");
	}
	ServerRestarted = 2;
	SendRconCommand("hostname "FULL_NAME" | Рестарт сервера...");
	//for(new i = 1; i < count_veh; i++) { SaveVeh(i); }
	//for(new i = 1; i < count_box; i++) { SaveBox(i); }
	return 1; 
}
CMD:ahelp(playerid)
{
	AdminProtect(1);
	global_string[0] = EOS;
	strcat(global_string, "Название\tУровень доступа\n");
	if(admin[playerid][admin_level] >= 1) strcat(global_string, "{cccccc}- {ffffff}Команды администрации\t{cccccc}1 уровень\n");
	if(admin[playerid][admin_level] >= 2) strcat(global_string, "{cccccc}- {ffffff}Команды администрации\t{cccccc}2 уровень\n");
	if(admin[playerid][admin_level] >= 3) strcat(global_string, "{cccccc}- {ffffff}Команды администрации\t{cccccc}3 уровень\n");
	if(admin[playerid][admin_level] >= 4) strcat(global_string, "{cccccc}- {ffffff}Команды администрации\t{cccccc}4 уровень\n");
	if(admin[playerid][admin_level] >= 5) strcat(global_string, "{cccccc}- {ffffff}Команды администрации\t{cccccc}5 уровень\n");
	if(admin[playerid][admin_level] >= 6) strcat(global_string, "{cccccc}- {ffffff}Команды администрации\t{cccccc}6 уровень\n");
	if(FullDostup(playerid)) strcat(global_string, "{cccccc}- {ffffff}Команды администрации\t{FA8072}Основатель\n");
	if(FullDostup(playerid, 1)) strcat(global_string, "{cccccc}- {ffffff}Команды администрации\t{FA8072}Разработчик\n");
	show_dialog ( playerid, d_admin_panel_cmd, DIALOG_STYLE_TABLIST_HEADERS, !"Административная панель", global_string, !"Выбрать", !"Закрыть" ) ;
	return true;
}
CMD:apanel(playerid)
{
	AdminProtect(1);
	global_string [ 0 ] = EOS ;
	format ( global_string, sizeof ( global_string ), "\
	Название раздела\tСтатус\n\
	{cccccc}- {ffffff}Список всей Администрации\t{33AA33}ONLINE {ffffff}/ {A52A2A}OFFLINE\n\
	{cccccc}- {ffffff}Команды администрации\t{cccccc}с 1-го уровеня\n\
	{cccccc}- {ffffff}Меню телепортации\t{cccccc}с 1-го уровеня\n\
	{cccccc}- {ffffff}Настройки административной панели\t{cccccc}с 1-го уровеня\n\
	") ;
	show_dialog ( playerid, d_admin_panel, DIALOG_STYLE_TABLIST_HEADERS, !"Административная панель", global_string, !"Выбрать", !"Закрыть" ) ;
	return 1;
}
CMD:offadmins( playerid )
{
	AdminProtect(1);
	new Cache:temp_sql = m_query("SELECT * FROM `users_admins` WHERE 1"), rows, count;
    cache_get_row_count(rows);
	if(rows) 
	{
		count = 0;
		global_string [ 0 ] = EOS ;
		new str[128], name[MAX_PLAYER_NAME], level, last_online[MAX_PLAYER_NAME];
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name(idx-1, "u_a_name", name, MAX_PLAYER_NAME);
			if(!FullDostup(playerid))
			{
				if(HideAdmins(name)) continue;
			}
			count++;
			cache_get_value_name_int(idx-1, "admin_level", level);
			cache_get_value_name(idx-1, "u_a_last_login", last_online, MAX_PLAYER_NAME);
			format(str, sizeof(str), "%i. Ник: %s, уровень: %i, дата последнего захода: %s\n", count, name, level, last_online);
			strcat(global_string, str);
		}
		show_dialog ( playerid, d_none, DIALOG_STYLE_MSGBOX, !"Список администрации", global_string, !"Ок", !"" ) ;
	}
	else server_error(playerid, "Администрация не найдена.");
	cache_delete(temp_sql);
 	return 1;
}
CMD:teleport(playerid)
{
	AdminProtect(1);
    show_dialog(playerid, d_teleport, DIALOG_STYLE_LIST, !"Меню телепортации", "\
	{cccccc}1. {ffffff}Важные места\n\
	{cccccc}2. {ffffff}Телепорт к базе\
	", !"Выбрать", !"Отмена");
	return true;
}
CMD:anticheat(playerid)
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
    pAntiCheatSettingsPage{playerid} = 1; // Присваиваем переменной, хранящей номер страницы, на который находится игрок, значение 1 (т.е, теперь игрок на 1-ой странице)
    return ShowPlayer_AntiCheatSettings(playerid); // Показываем игрок главный диалог настроек анти-чита
}
/*CMD:zomb(playerid)
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	static Float: coords[4];
	GetPlayerPos(playerid, coords[0], coords[1], coords[2]);
 	new string_sql[144];
	m_format(string_sql, sizeof(string_sql), "INSERT INTO "TABLE_ZOMBIE" (`zombie_xyz`) VALUE ('%f,%f,%f')", coords[0], coords[1], coords[2]);
	m_query(string_sql);
	total_zombie++;
	format(string_sql, sizeof(string_sql), "Место спавна зомби №%i после рестарта", total_zombie);
	Create3DTextLabel(string_sql, 0x00FFFFAA, coords[0], coords[1], coords[2], 25, 0, 1);
	CreatePickup(1318, 1, coords[0], coords[1], coords[2], -1);
	SCMG(playerid, "Зомби №%i добавлен.", total_zombie);
	return true;
}
CMD:deletezomb(playerid, params[])
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "i", params[0]) || params[0] < 1) return server_error(playerid, "Используйте: /deletezomb [ид зомби]");
	static str_sql[128];
	m_format(str_sql, sizeof(str_sql), "DELETE FROM "TABLE_ZOMBIE" WHERE `zombie_id` = '%i'", params[0]);
	m_query(str_sql);
	
	FCNPC_Destroy(zombie[params[0]-1][zombie_id]);
	SCMG(playerid, "Зомби №%i удален.", params[0]);
	return true;
}*/
CMD:banip(playerid, params[])
{
	AdminProtect(4);
	new ip[20];
	if(sscanf(params, "s[20]s[64]", ip, params[1])) return server_error(playerid, "Используйте: /banip [IP] [причина]");
	if(strfind(ip, "*", true) != -1) return server_error(playerid, "Неправильный ip адрес.");
	new protect_ = 0;
	foreach(Player, i)
	{
		static str_ip[20];
		GetPlayerIp(i, str_ip, 20);
		if(!strcmp(ip,  str_ip, true))
		{
			protect_ = 1;
			SCMASS(playerid, "Игрок %s(%i) на сервере и имеет такой же IP %s.", users[i][u_name], i, ip);
			server_error(playerid, "Используйте /iban для блокировки данного пользователя.");
			break;
		}
	}
	if(protect_) return true;
	static str[256];
	m_format(str, sizeof(str), "SELECT * FROM "TABLE_BANIP" WHERE `u_b_ip` = '%s' AND `u_b_ip_date` > NOW() LIMIT 1", ip);
	new Cache:temp_sql = m_query(str), r;
    cache_get_row_count(r);
	if(!r)
	{
		new days = 20+random(31)+random(31);
		format(str, sizeof(str), "Администратор %s заблокировал %s на %i дней. Причина: %s.", users[playerid][u_name], ip, days, params[1]);
		SendClientMessageToAll(COLOR_BROWN, str);

		m_format(str, sizeof(str), "INSERT INTO "TABLE_BANIP" (`u_b_ip_admin`, `u_b_ip`, `u_b_ip_reason`, `u_b_ip_date`, `u_b_ip_ndate`, `u_b_ip_days`) VALUES ('%s', '%s', '%s', NOW() + INTERVAL %i DAY, NOW(), '%i')",
		users[playerid][u_name], ip, params[1], days, days);
		m_query(str);	

		SCMG(playerid, "IP %s был заблокирован на %i д.", ip, days);
		
		static str_logs[128];
		format(str_logs, sizeof(str_logs), "Заблокировал IP и аккаунт %s. Причина: %s", ip, params[1]);
		logs_admin(playerid, str_logs, "/banip");
		AntiFloodCommands(playerid, "/banip");
	}
	else server_error(playerid, "Данный IP уже заблокирован.");
	cache_delete(temp_sql);
	return true;
}
CMD:iban(playerid, params[])
{
	AdminProtect(4);
	if(sscanf(params, "uis[100]", params[0], params[1], params[2])) return server_error(playerid, "Используйте: /iban [имя/ид] [дни] [причина]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	if(params[1] < 7 || params[1] > 20000) return server_error(playerid, "Кол-во дней должно быть от 7-и до 20000-сяч");
	if(admin[playerid][admin_level] <= admin[params[0]][admin_level])
	{
		AdminChatF("[A][WARNING] Администратор %s(%i) попытался забанить администратора %s(%i).", users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
		SCMASS(params[0], "Администратор %s(%i) попытался вас забанить.", users[playerid][u_name], playerid);
		server_error(playerid, "Данный игрок администратор и выше вашего уровня администрирования.");
	    return true;
	}
	// if(observation[params[0]][observation_id] != -1) return server_error(playerid, "Данный игрок в режиме наблюдения.");
	static str[256];
	format(str, sizeof(str), "Администратор %s забанил игрока %s на %i дней. Причина: %s.", users[playerid][u_name], users[params[0]][u_name], params[1], params[2]);
	SendClientMessageToAll(COLOR_BROWN, str);
	if(users[params[0]][u_clan] > 0) AdminChatF("[A][LOG] IP: %s | R-IP: %s | Клан: %i", GetIp(params[0]), users[params[0]][u_ip_registration], users[params[0]][u_clan]);
	else if(users[params[0]][u_clan] < 1) AdminChatF("[A][LOG] IP: %s | R-IP: %s", GetIp(params[0]), users[params[0]][u_ip_registration]);
	/*if(users[params[0]][u_clan] > 0)
	{
		static str_sql[128];
		m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_reprimand` = `c_reprimand`+'1' WHERE `c_id` = '%i' LIMIT 1", clan[l[params[0]][u_clan]][c_id]);
		m_query(str_sql);
		AdminChatF("[A] Клану %s(%i) выдан выговор (%i/3). Причина: читер в клане.", clan[l[params[0]][u_clan]][c_name], users[params[0]][u_clan], clan[params[0]][c_reprimand]);
		if()
		
	}*/
	m_format(str, sizeof(str), "INSERT INTO "TABLE_BAN" (`u_b_admin`, `u_b_name`, `u_b_reason`, `u_b_date`, `u_b_ndate`, `u_b_days`) VALUES ('%s', '%s', '%s', NOW() + INTERVAL %i DAY, NOW(), '%i')",
	users[playerid][u_name], users[params[0]][u_name], params[2], params[1], params[1]);
	m_query(str);

	static str_ip[20];
	GetPlayerIp(params[0], str_ip, MAX_PLAYER_NAME);
	m_format(str, sizeof(str), "INSERT INTO "TABLE_BANIP" (`u_b_ip_admin`, `u_b_ip`, `u_b_ip_reason`, `u_b_ip_date`, `u_b_ip_ndate`, `u_b_ip_days`) VALUES ('%s', '%s', '%s', NOW() + INTERVAL %i DAY, NOW(), '%i')",
	users[playerid][u_name], str_ip, params[2], params[1], params[1]);
	m_query(str);	

	static str_logs[196];
	format(str_logs, sizeof(str_logs), "Заблокировал аккаунт игрока %s и IP %s на %i дней. Причина: %s", users[params[0]][u_name], str_ip, params[1], params[2]);
	logs_admin(playerid, str_logs, "/iban");
	AntiFloodCommands(playerid, "/iban");

	m_format(str, sizeof(str), "SELECT * FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW() LIMIT 1", users[params[0]][u_name]);
	m_tquery(str, "@CheckPlayerBan", "i", params[0]);
	return true;
}
CMD:unbanip(playerid, params[])
{
	AdminProtect(4);
	new ip[20];
	if(sscanf(params, "s[20]s[64]", ip, params[1])) return server_error(playerid, "Используйте: /unbanip [IP] [причина]");
	//if(GetPlayerID(params[0]) != INVALID_PLAYER_ID) return server_error(playerid, "Игрок на сервере! Используйте: /ban");
	static str[256];
	m_format(str, sizeof(str), "SELECT * FROM "TABLE_BANIP" WHERE `u_b_ip` = '%s' AND `u_b_ip_date` > NOW() LIMIT 1", ip);
	new Cache:temp_sql = m_query(str), r;
    cache_get_row_count(r);
	if(r) 
	{
		m_format(str, sizeof(str), "DELETE FROM "TABLE_BANIP" WHERE `u_b_ip` = '%s' AND `u_b_ip_date` > NOW()", ip);
		m_query(str);
		SCMG(playerid, "IP %s разблокирован.", ip);
		format(str, sizeof(str), "Администратор %s разблокировал ip %s. Причина: %s.", users[playerid][u_name], ip, params[1]);
		SendClientMessageToAll(COLOR_BROWN, str);
		
		static str_logs[96];
		format(str_logs, sizeof(str_logs), "Разблокировал IP %s. Причина: %s",  ip, params[1]);
		logs_admin(playerid, str_logs, "/unbanip");
		AntiFloodCommands(playerid, "/unbanip");
	}
	else SCMASS(playerid, "IP %s не найдет в таблице с банами.", ip);
	cache_delete(temp_sql);
	return true;
}
CMD:offban(playerid, params[])
{
	AdminProtect(3);
	new name[MAX_PLAYER_NAME], reason[100], days;
    if(sscanf(params, "s[24]is[100]", name, days, reason)) return server_error(playerid, "Используйте: /offban [ник] [дни] [причина]");
	if(GetPlayerID(name) != INVALID_PLAYER_ID) return server_error(playerid, "Игрок на сервере! Используйте: /ban");
    if(!strcmp(name, full_dostup[0], true) || !strcmp(name, full_dostup[1], true)) return server_error(playerid, "Главную администрацию нельзя заблокировать оффлайн");
	if(days < 7 || days > 20000) return server_error(playerid, "Кол-во дней должно быть от 7-и до 20000-сяч");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	static str_sql[96];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1", name);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(!r) 
	{
		SCMASS(playerid, "Аккаунт {cccccc}%s{ffffff} не зарегистрирован.", name);
		cache_delete(temp_sql);
		return true;
	}
	cache_delete(temp_sql);
    m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_BAN" WHERE `u_b_name` = '%s' LIMIT 1", name);
	m_tquery(str_sql, "@CheckPlayerBanTable", "isis", playerid, name, days, reason);
    return 1;
}
CMD:ban(playerid, params[])
{
	AdminProtect(3);
	if(sscanf(params, "uis[100]", params[0], params[1], params[2])) return server_error(playerid, "Используйте: /ban [имя/ид] [дни] [причина]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	if(params[1] < 7 || params[1] > 20000) return server_error(playerid, "Кол-во дней должно быть от 7-и до 20000-сяч");
	if(admin[playerid][admin_level] <= admin[params[0]][admin_level])
	{
		AdminChatF("[A][WARNING] Администратор %s(%i) попытался забанить администратора %s(%i).", users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
		SCMASS(params[0], "Администратор %s(%i) попытался вас забанить.", users[playerid][u_name], playerid);
		server_error(playerid, "Данный игрок администратор и выше вашего уровня администрирования.");
	    return true;
	}
	// if(observation[params[0]][observation_id] != -1) return server_error(playerid, "Данный игрок в режиме наблюдения.");
	static str[256];
	format(str, sizeof(str), "Администратор %s забанил игрока %s на %i дней. Причина: %s.", users[playerid][u_name], users[params[0]][u_name], params[1], params[2]);
	SendClientMessageToAll(COLOR_BROWN, str);
	if(users[params[0]][u_clan] > 0) AdminChatF("[A][LOG] IP: %s | R-IP: %s | Клан: %i", GetIp(params[0]), users[params[0]][u_ip_registration], users[params[0]][u_clan]);
	else if(users[params[0]][u_clan] < 1) AdminChatF("[A][LOG] IP: %s | R-IP: %s", GetIp(params[0]), users[params[0]][u_ip_registration]);

	m_format(str, sizeof(str), "INSERT INTO "TABLE_BAN" (`u_b_admin`, `u_b_name`, `u_b_reason`, `u_b_date`, `u_b_ndate`, `u_b_days`) VALUES ('%s', '%s', '%s', NOW() + INTERVAL %i DAY, NOW(), '%i')",
	users[playerid][u_name], users[params[0]][u_name], params[2], params[1], params[1]);
	m_query(str);

	static str_logs[128];
	format(str_logs, sizeof(str_logs), "Заблокировал игрока %s на %i дней. Причина: %s", users[params[0]][u_name], params[1], params[2]);
	logs_admin(playerid, str_logs, "/ban");
	AntiFloodCommands(playerid, "/ban");

	m_format(str, sizeof(str), "SELECT * FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW() LIMIT 1", users[params[0]][u_name]);
	m_tquery(str, "@CheckPlayerBan", "i", params[0]);
	return true;
}
CMD:unban(playerid, params[])
{
	AdminProtect(3);
	new name[MAX_PLAYER_NAME];
	if(sscanf(params, "s[24]s[64]", name, params[1])) return server_error(playerid, "Используйте: /unban [имя] [причина]");
	//if(GetPlayerID(params[0]) != INVALID_PLAYER_ID) return server_error(playerid, "Игрок на сервере! Используйте: /ban");
	static str[128];
	m_format(str, sizeof(str), "SELECT * FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW() LIMIT 1", name);
	new Cache:temp_sql = m_query(str), r;
    cache_get_row_count(r);
	if(r) 
	{
		m_format(str, sizeof(str), "DELETE FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW()", name);
		m_query(str);
		SCMG(playerid, "Игрок %s разблокирован.", name);
		format(str, sizeof(str), "Администратор %s разбанил игрока %s. Причина: %s.", users[playerid][u_name], name, params[1]);
		SendClientMessageToAll(COLOR_BROWN, str);

		static str_logs[96];
		format(str_logs, sizeof(str_logs), "Разблокировал игрока %s. Причина: %s", name, params[1]);
		logs_admin(playerid, str_logs, "/unban");
	}
	else SCMASS(playerid, "Игрок %s не найдет в таблице с банами.", name);
	cache_delete(temp_sql);
	return true;
}
CMD:getip(playerid, params[])
{
	AdminProtect(4);
	if(sscanf(params, "u", params[0]))return server_error(playerid, "Используйте: /getip [ид]");
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	global_string[0] = EOS;
	static str[96];
	format(str, sizeof(str), "\n{ffffff}Ник игрока: {cccccc}%s", users[params[0]][u_name]);
	strcat(global_string, str);
	format(str, sizeof(str), "\n{ffffff}Текущий Ip-адрес игрока: {cccccc}%s", GetIp(params[0]));
	strcat(global_string, str);
	format(str, sizeof(str), "\n{ffffff}Ip-адрес при регистрации игрока: {cccccc}%s", users[params[0]][u_ip_registration]);
	strcat(global_string, str);
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"IP-адрес игрока", global_string, !"Закрыть", !"");
	return 1;
}
CMD:recon(playerid, params[])
{
	AdminProtect(1);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "Используйте: /re(con) [имя/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(params[0] == playerid) return server_error(playerid, "За самим собой нельзя наблюдать.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return server_error(playerid, "Игрок не вступил в игру.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен от слежки.");
	// if(observation[params[0]][observation_id] != -1) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(observation[playerid][observation_id] == INVALID_PLAYER_ID)
	{
		GetPlayerPos(playerid, observation[playerid][observation_XYZF][0], observation[playerid][observation_XYZF][1], observation[playerid][observation_XYZF][2]);
		GetPlayerFacingAngle(playerid, observation[playerid][observation_XYZF][3]);
		observation[playerid][observation_WI][0] = GetPlayerVirtualWorld(params[0]);
		observation[playerid][observation_WI][1] = GetPlayerInterior(params[0]);
		SavePlayerWeapons(playerid);
	}
	observation[playerid][observation_id] = params[0];
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(params[0])); 
    SetPlayerInterior(playerid, GetPlayerInterior(params[0])); 
    TogglePlayerSpectating(playerid, true); 
	if(IsPlayerInAnyVehicle(params[0])) PlayerSpectateVehicle(playerid, GetPlayerVehicleID(params[0]), SPECTATE_MODE_NORMAL); 
 	else PlayerSpectatePlayer(playerid, params[0], SPECTATE_MODE_NORMAL);
	//SelectTextDraw(playerid, 0x535250AA);
 	for(new i = 0; i != 2; i++) PlayerTextDrawShow(playerid, PlayerText: PanelReconAdmin_PTD[playerid][i]);
	for(new i = 0; i != 15; i++) TextDrawShowForPlayer(playerid, Text: PanelReconAdmin_TD[i]);
	AdminChatF("[A] %s %s(%i) начал наблюдать за игроком %s(%i).", admin_rank_name(playerid), users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
	server_accept(playerid, "Нажмите '{cccccc}ESC{fffff0}' для отключения курсора мышки.");
	server_accept(playerid, "Нажмите '{cccccc}LALT{fffff0}' для включения курсора мышки.");
	server_accept(playerid, "Введите '{cccccc}/reoff{fffff0}' для выхода из панели наблюдения.");
	return true;
}
CMD:reoff(playerid)
{
	AdminProtect(1);
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) return server_error(playerid, "Вы не в режиме наблюдения.");
	SetPlayerVirtualWorld(playerid,0); 
    SetPlayerInterior(playerid,0); 
    TogglePlayerSpectating(playerid, false); 
 	for(new i = 0; i != 2; i++) PlayerTextDrawHide(playerid, PlayerText: PanelReconAdmin_PTD[playerid][i]);
	for(new i = 0; i != 15; i++) TextDrawHideForPlayer(playerid, Text: PanelReconAdmin_TD[i]);
    CancelSelectTextDraw(playerid);
	server_accept(playerid, "Вы вышли из режима наблюдения.");
	return true;
}
CMD:alldonate(playerid)
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	static str_sql[168];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM `freekassa_payments` ORDER BY `id` DESC LIMIT 30", users[playerid][u_id]);
	new Cache:temp_sql = m_query(str_sql), rows;
	cache_get_row_count(rows);
	if(rows)
	{
		global_string[0] = EOS;
		new str[196], info_satus, info_date[30], info_ip[MAX_PLAYER_NAME], summa;
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name(idx-1, "dateComplete", info_date, 30);
			cache_get_value_name(idx-1, "account", info_ip, MAX_PLAYER_NAME);
			cache_get_value_name_int(idx-1, "status", info_satus);
			cache_get_value_name_int(idx-1, "sum", summa);
			switch(info_satus)
			{
			case 0: format(str, sizeof(str), "{cccccc}%i. {A52A2A}Неудачно {ffffff}| {cccccc} Ник: %s {ffffff}| {cccccc}Сумма: %i {ffffff}| {cccccc}Дата: %s\n", idx, info_ip, summa, info_date);
			case 1: format(str, sizeof(str), "{cccccc}%i. {33AA33}Успешно {ffffff}| {cccccc} Ник: %s {ffffff}| {cccccc}Сумма: %i {ffffff}| {cccccc}Дата: %s\n", idx, info_ip, summa, info_date);
			}
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Информация о донатах", global_string, !"Ок", !"");
	}
	else server_error(playerid, "Донатов нет.");
	cache_delete(temp_sql);
	return true;
}
CMD:slap(playerid, params[])
{
	AdminProtect(2);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "Используйте: /slap [ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	if(admin[playerid][admin_level] <= admin[params[0]][admin_level])
	{
		AdminChatF("[A][WARNING] Администратор %s(%i) попытался пнуть администратора %s(%i).", users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
		SCMASS(params[0], "Администратор %s(%i) попытался вас пнуть.", users[playerid][u_name], playerid);
		server_error(playerid, "Данный игрок администратор и выше вашего уровня администрирования.");
	    return true;
	}
	new Float: pl_pos [ 3 ];
	GetPlayerPos( params [ 0 ], pl_pos [ 0 ], pl_pos [ 1 ], pl_pos [ 2 ]);
	SetPlayerPos( params [ 0 ], pl_pos [ 0 ], pl_pos [ 1 ], pl_pos [ 2 ] + 6);
	PlayerPlaySound( params [ 0 ], 1130, pl_pos [ 0 ], pl_pos [ 1 ], pl_pos [ 2 ] + 6);
	SCMG(params [ 0 ], "Администратор %s[%d] подкинул вас.", users[playerid][u_name], playerid);
	AdminChatF("[A] Администратор %s(%i) подкинул игрока %s(%i).", users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
	
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "Пнул игрока %s", users[params[0]][u_name]);
	logs_admin(playerid, str_logs, "/slap");
	AntiFloodCommands(playerid, "/slap", 3);
	return 1;
}
CMD:skin(playerid, params[])
{
	AdminProtect(3);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "Используйте: /skin [скин]");
	//if(params[0] > 311 || params[0] < 1 || params[0] == 74) return server_error(playerid, "Неверный номер скина или скин запрещен.");
	AdminChatF("[A] Администратор %s(%i) изменил себе скин на номер %i.", users[playerid][u_name], playerid, params[0]);
	server_error(playerid, "Вы изменили себе скин.");
	SetPlayerSkin(playerid, params[0]);
	return 1;
}
CMD:clanspawn(playerid)
{
	AdminProtect(3);
	new Cache:temp_sql = m_query("SELECT * FROM "TABLE_CLAN" WHERE `c_change_spawn` = '1' AND c_change_spawn_xyzfwi != '0, 0, 0, 0, 0, 0'"), rows;
    cache_get_row_count(rows);
	if(rows) 
	{
		global_string[0] = EOS;
		new str[128], name[MAX_PLAYER_NAME], number;
		strcat(global_string, "Используйте: {cccccc}/changeclanspawn [номер клана]\n\n");
		strcat(global_string, "{ffffff}№\tНазвание клана\tНомер клана\n\n");
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name_int(idx-1, "c_id", number);
			cache_get_value_name(idx-1, "c_name", name, MAX_PLAYER_NAME);
			format(str, sizeof(str), "{cccccc}%i.\t{ADD8E6}%s\t\t\t{cccccc}%i\n", idx, name, number);
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Заявки на смену спавна", global_string, !"Ок", !"");
	}
	else server_error(playerid, "Кланы не подавали заявку на смену спавна.");
	cache_delete(temp_sql);
	return true;
}
CMD:conclusion(playerid)
{
	// "INSERT INTO "TABLE_CONCLUSION" (`cn_owner`, `cn_number`, `cn_summa`, `cn_date`) VALUES ('%i', '%s', '%i', NOW());"
	if(!FullDostup(playerid)) return true;
	new Cache:temp_sql = m_query("SELECT * FROM "TABLE_CONCLUSION" WHERE `cn_status` != '4'"), rows;
    cache_get_row_count(rows);
	if(rows) 
	{
		global_string[0] = EOS;
		new str[64], number, index_ = 0;
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name_int(idx-1, "cn_status", number);
			switch(number)
			{
			case 0: index_++;
			}
		}
		if(index_) 
		{
			format(str, sizeof(str), "Заявки на вывод | {CD5C5C}%i шт.\n", index_);
			strcat(global_string, str);
		}
		else strcat(global_string, "Заявки на вывод\n");
		strcat(global_string, "История выводов");
		show_dialog(playerid, d_conclusion, DIALOG_STYLE_LIST, !"Вывод", global_string, !"Ок", !"Отмена");
	}
	else server_error(playerid, "Заявок на вывод нет");
	cache_delete(temp_sql);
	return true;
}
CMD:spawn(playerid)
{
	AdminProtect(3);
	new Cache:temp_sql = m_query("SELECT * FROM "TABLE_USERS" WHERE `u_donate_spawn` = '1' AND `u_donate_spawn_xyzwi` != '0.0, 0.0, 0.0, 0.0, 0, 0'"), rows;
    cache_get_row_count(rows);
	if(rows) 
	{
		global_string[0] = EOS ;
		new str[128], name[MAX_PLAYER_NAME], number;
		strcat(global_string, "Используйте: {cccccc}/changespawn [номер аккаунта]\n\n");
		strcat(global_string, "{ffffff}№\tНик\t\tНомер аккаунта\n\n");
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name_int(idx-1, "u_id", number);
			cache_get_value_name(idx-1, "u_name", name, MAX_PLAYER_NAME);
			format(str, sizeof(str), "{cccccc}%i.\t{ADD8E6}%s\t\t{cccccc}%i\n", idx, name, number);
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Заявки на личный спавн", global_string, !"Ок", !"");
	}
	else server_error(playerid, "Игроки не подавали заявку на личный спавн.");
	cache_delete(temp_sql);
	return true;
}
CMD:listname(playerid)
{
	AdminProtect(4);
	static index_ = 0;
	if(index_) index_ = 0;
	global_string[0] = EOS;
	static str[128];
	strcat(global_string, "Используйте: {cccccc}/acceptname [текущий ник/ид]\n\n");
	strcat(global_string, "{ffffff}ID\tТекущий ник\tЖелаемый ник\n\n");
	foreach(Player, i)
	{
		if(!IsPlayerConnected(i)) continue;
		if(!strcmp(temp[i][player_setname], "NoChangeName")) continue;
		index_++;
		format(str, sizeof(str), "{cccccc}%i\t{ADD8E6}%s\t{cccccc}%s\n", i, users[i][u_name], temp[i][player_setname]);
		strcat(global_string, str);
	}
	if(!index_) return server_error(playerid, "Игроки не подавали заявку на смену ника.");
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Заявки на смену ника", global_string, !"Ок", !"");
	return true;
}
CMD:acceptname(playerid, params[])
{
	AdminProtect(4);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "Используйте: /acceptname [текущий ник/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(!strcmp(temp[params[0]][player_setname], "NoChangeName")) return server_error(playerid, "Игрок не подал заявку на смену ника или отказался.");
	SetPVarInt(playerid, "changename", params[0]);
	static str[256];
	format(str, sizeof(str), "\n\
	{cccccc}Текущий ник: {fffff0}%s\n\
	{fffff0}Ник в заявке на смену: {cccccc}%s\n\n\
	{fffff0}Вы действительно хотите одобрить смену ника?", users[params[0]][u_name], temp[params[0]][player_setname]);
	show_dialog(playerid, d_setname_accept, DIALOG_STYLE_MSGBOX, !"Заявки на смену ника", str, !"Да", !"Нет");
	return true;
}
CMD:changespawn(playerid, params[])
{
	AdminProtect(3);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "Используйте: /changespawn [номер аккаунта]");
	static str_sql[165];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_id` = '%i' AND `u_donate_spawn` = '1' AND `u_donate_spawn_xyzwi` != '0.0, 0.0, 0.0, 0.0, 0, 0' LIMIT 1", params[0]);
	new Cache:temp_sql = m_query(str_sql), rows;
    cache_get_row_count(rows);
	if(rows) 
	{
		static LoadSpawnXYZWI[65], Float: SpawnXYZF[4], SpawnWI[2];
		cache_get_value_name(0, "u_donate_spawn_xyzwi", LoadSpawnXYZWI, 65);
		sscanf(LoadSpawnXYZWI, "p<,>ffffii", SpawnXYZF[0], SpawnXYZF[1], SpawnXYZF[2], SpawnXYZF[3], SpawnWI[0], SpawnWI[1]);
		SetPVarFloat(playerid, "AdminSpawnX", SpawnXYZF[0]);
		SetPVarFloat(playerid, "AdminSpawnY", SpawnXYZF[1]);
		SetPVarFloat(playerid, "AdminSpawnZ", SpawnXYZF[2]);
		SetPVarFloat(playerid, "AdminSpawnF", SpawnXYZF[3]);
		SetPVarInt(playerid, "AdminSpawnW", SpawnWI[0]);
		SetPVarInt(playerid, "AdminSpawnI", SpawnWI[1]);
		SetPVarInt(playerid, "AdminSpawn", params[0]);
		format(str_sql, sizeof(str_sql), "Номер аккаунта №%i", GetPVarInt(playerid, "AdminSpawn"));
		show_dialog(playerid, d_change_spawn, DIALOG_STYLE_LIST, str_sql, "{cccccc}1. {ffffff}Просмотреть спавн\n{cccccc}2. {33AA33}Разрешить спавн\n{cccccc}3. {A52A2A}Отказать в смене спавна", !"Выбрать", !"Отмена");
	}
	else SCMASS(playerid, "Номер аккаунта №%i не подавал или уже одобрили заявку на личную точку спавна.", params[0]);
	cache_delete(temp_sql);
	return true;
}
CMD:testlang(playerid)
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	switch(users[playerid][u_language])
	{
	case 0:
		{
			users[playerid][u_language] = 1;
			server_accept(playerid, "RUS");
		}
	case 1:
		{
			users[playerid][u_language] = 0;
			server_accept(playerid, "ENG");
		}
	}
	return true;
}
CMD:changeclanspawn(playerid, params[])
{
	AdminProtect(3);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "Используйте: /changeclanspawn (/cspclan) [номер клана]");
	static str_sql[165];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_id` = '%i' AND `c_change_spawn` = '1' AND `c_change_spawn_xyzfwi` != '0, 0, 0, 0, 0, 0' LIMIT 1", params[0]);
	new Cache:temp_sql = m_query(str_sql), rows;
    cache_get_row_count(rows);
	if(rows) 
	{
		static LoadSpawnXYZWI[65], Float: SpawnXYZF[4], SpawnWI[2];
		cache_get_value_name(0, "c_change_spawn_xyzfwi", LoadSpawnXYZWI, 65);
		sscanf(LoadSpawnXYZWI, "p<,>ffffii", SpawnXYZF[0], SpawnXYZF[1], SpawnXYZF[2], SpawnXYZF[3], SpawnWI[0], SpawnWI[1]);
		SetPVarFloat(playerid, "AdminClanSpawnX", SpawnXYZF[0]);
		SetPVarFloat(playerid, "AdminClanSpawnY", SpawnXYZF[1]);
		SetPVarFloat(playerid, "AdminClanSpawnZ", SpawnXYZF[2]);
		SetPVarFloat(playerid, "AdminClanSpawnF", SpawnXYZF[3]);
		SetPVarInt(playerid, "AdminClanSpawnW", SpawnWI[0]);
		SetPVarInt(playerid, "AdminClanSpawnI", SpawnWI[1]);
		SetPVarInt(playerid, "AdminClanSpawn", params[0]);
		format(str_sql, sizeof(str_sql), "Заявка клана №%i", GetPVarInt(playerid, "AdminClanSpawn"));
		show_dialog(playerid, d_clan_change_spawn, DIALOG_STYLE_LIST, str_sql, "{cccccc}1. {ffffff}Просмотреть спавн\n{cccccc}2. {33AA33}Разрешить спавн\n{cccccc}3. {A52A2A}Отказать в смене спавна", !"Выбрать", !"Отмена");
	}
	else SCMASS(playerid, "Клан №%i не подавал или уже одобрили заявку на смену спавна.", params[0]);
	cache_delete(temp_sql);
	return true;
}
CMD:chatlog(playerid, params[])
{
	AdminProtect(1);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "Используйте: /chatlog [имя/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	if(!strcmp(LogsChat[params[0]][0], "NoChatLogsClear")) return server_error(playerid, "Лог чата пуст! Игрок ещё не писал в чат.");
	new str[128];
	global_string[0] = EOS;
	format(str, sizeof(str),"\n{cccccc}1. {FFFFFF}%s", LogsChat[params[0]][0]);
	if(strcmp(LogsChat[params[0]][0], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}2. {FFFFFF}%s", LogsChat[params[0]][1]);
	if(strcmp(LogsChat[params[0]][1], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}3. {FFFFFF}%s", LogsChat[params[0]][2]);
	if(strcmp(LogsChat[params[0]][2], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}4. {FFFFFF}%s", LogsChat[params[0]][3]);
	if(strcmp(LogsChat[params[0]][3], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}5. {FFFFFF}%s", LogsChat[params[0]][4]);
	if(strcmp(LogsChat[params[0]][4], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}6. {FFFFFF}%s", LogsChat[params[0]][5]);
	if(strcmp(LogsChat[params[0]][5], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}7. {FFFFFF}%s", LogsChat[params[0]][6]);
	if(strcmp(LogsChat[params[0]][6], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}8. {FFFFFF}%s", LogsChat[params[0]][7]);
	if(strcmp(LogsChat[params[0]][7], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}9. {FFFFFF}%s", LogsChat[params[0]][8]);
	if(strcmp(LogsChat[params[0]][8], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}10. {FFFFFF}%s", LogsChat[params[0]][9]);
	if(strcmp(LogsChat[params[0]][9], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}11. {FFFFFF}%s", LogsChat[params[0]][10]);
	if(strcmp(LogsChat[params[0]][10], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}12. {FFFFFF}%s", LogsChat[params[0]][11]);
	if(strcmp(LogsChat[params[0]][11], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}13. {FFFFFF}%s", LogsChat[params[0]][12]);
	if(strcmp(LogsChat[params[0]][12], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}14. {FFFFFF}%s", LogsChat[params[0]][13]);
	if(strcmp(LogsChat[params[0]][13], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}15. {FFFFFF}%s", LogsChat[params[0]][14]);
	if(strcmp(LogsChat[params[0]][14], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}16. {FFFFFF}%s", LogsChat[params[0]][15]);
	if(strcmp(LogsChat[params[0]][15], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}17. {FFFFFF}%s", LogsChat[params[0]][16]);
	if(strcmp(LogsChat[params[0]][16], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}18. {FFFFFF}%s", LogsChat[params[0]][17]);
	if(strcmp(LogsChat[params[0]][17], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}19. {FFFFFF}%s", LogsChat[params[0]][18]);
	if(strcmp(LogsChat[params[0]][18], "NoChatLogsClear")) strcat(global_string, str);
	format(str, sizeof(str),"\n{cccccc}20. {FFFFFF}%s", LogsChat[params[0]][19]);
	if(strcmp(LogsChat[params[0]][19], "NoChatLogsClear")) strcat(global_string, str);
	new str_header[20+MAX_PLAYER_NAME];
	format(str_header, sizeof(str_header),"ChatLog игрока: %s", users[params[0]][u_name]);
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, str_header, global_string, !"Ок", !"");
	return true;
}
CMD:showstats(playerid, params[])
{
	AdminProtect(2);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "Используйте: /showstats [имя/ид]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	ShowStats(playerid, params[0]);
	return true;
}
CMD:amoney(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "uii", params[0], params[1], params[2])) return server_error(playerid, "Используйте: /amoney [имя/ид] [0/1] [деньги]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	switch(params[1])
	{
	case 0:
		{
			if(users[params[0]][u_money] < params[2]) return server_error(playerid, "У игрока меньше денег.");
			// users[params[0]][u_money] -= params[2];
			money(params[0], "-", params[2]);
			SCMG(playerid, "Вы забрали %i денег у игрока %s(%i)", params[2], users[params[0]][u_name], params[0]);
			// SaveUser(params[0], "money");
		}
	case 1:
		{
			if(params[2] < 1 || params[2] > 1000000) return server_error(playerid, "Нельзя выдавать меньше 1 и больше 1.000.000$.");
			// users[params[0]][u_money] += params[2];
			money(params[0], "+", params[2]);
			SCMG(playerid, "Вы выдали %i денег игроку %s(%i)", params[2], users[params[0]][u_name], params[0]);
			// SaveUser(params[0], "money");
		}
	}
	return true;
}
CMD:adonat(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "uii", params[0], params[1], params[2])) return server_error(playerid, "Используйте: /adonat [имя/ид] [0/1] [деньги]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	switch(params[1])
	{
	case 0:
		{
			static str_sql[128];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'%i' WHERE `u_id` = '%i' LIMIT 1", params[2], users[params[0]][u_id]);
			m_query(str_sql);
			SCMG(playerid, "Вы забрали %i донат у игрока %s(%i)", params[2], users[params[0]][u_name], params[0]);
		}
	case 1:
		{
			static str_sql[128];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`+'%i' WHERE `u_id` = '%i' LIMIT 1", params[2], users[params[0]][u_id]);
			m_query(str_sql);
			SCMG(playerid, "Вы выдали %i доната игроку %s(%i)", params[2], users[params[0]][u_name], params[0]);
		}
	}
	return true;
}
CMD:setclan(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "ui", params[0], params[1])) return server_error(playerid, "Используйте: /setclan [имя/ид] [клан]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	users[params[0]][u_clan] = params[1];
	SCMG(playerid, "Вы сунули игрока %s в клан %i.", users[params[0]][u_name], params[1]);
	return true;
}
CMD:setrank(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "ui", params[0], params[1])) return server_error(playerid, "Используйте: /setrank [имя/ид] [ранг]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	users[params[0]][u_clan_rank] = params[1];
	SCMG(playerid, "Вы изминили ранг игроку %s на %i.", users[params[0]][u_name], params[1]);
	return true;
}

CMD:veh(playerid, params[])
{
	AdminProtect(4);
	if(GetPVarInt(playerid, "admin_vehicle")) return server_error(playerid, "Вы уже создали автомобиль.");
	if(GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER ) return server_error(playerid, "Вы уже за рулём.");
	if(sscanf(params, "iii", params [ 0  ], params [ 1  ], params [ 2 ])) return server_error(playerid, "Используйте: /veh [ид авто] [цвет 1] [цвет 2]");
	if(params [ 0 ] < 400 || params [ 0 ] > 611) return server_error(playerid,"Используйте: /veh [ид авто] [цвет 1] [цвет 2]");
	if(params [ 1 ] < 0 || params [ 1 ] > 255) return server_error(playerid,"Используйте: /veh [ид авто] [цвет 1] [цвет 2]");
	if(params [ 2 ] < 0 || params [ 2 ] > 255) return server_error(playerid,"Используйте: /veh [ид авто] [цвет 1] [цвет 2]");
	new Float:player_pos [ 3 ];
	GetPlayerPos(playerid, player_pos [ 0 ], player_pos [ 1 ], player_pos [ 2 ]);
	new adm_veh = CreateVehicle(params [ 0 ], player_pos [ 0 ], player_pos [ 1 ], player_pos [ 2 ], 0.0, params [ 1 ], params [ 2 ], -1);
	SetPVarInt(playerid, "admin_vehicle", adm_veh);
	CarInfo[adm_veh][car_admin] = 1;
	CarInfo[adm_veh][car_mileage] = 0;
	CarInfo[adm_veh][car_fuel] = InfoOfFuel(adm_veh);
	switch(GetCarWheels(adm_veh))
	{
	case 4:
		{
			CarInfo[adm_veh][car_tires][0] = 1;
			CarInfo[adm_veh][car_tires][1] = 1;
			CarInfo[adm_veh][car_tires][2] = 1;
			CarInfo[adm_veh][car_tires][3] = 1;
		}
	case 2:
		{
			CarInfo[adm_veh][car_tires][0] = 1;
			CarInfo[adm_veh][car_tires][1] = 1;
		}
	case 0: return false;
	}
	ManualCar(adm_veh, "car_engine", 1);
	PutPlayerInVehicle(playerid, adm_veh, 0);
	AdminChatF("[A] %s %s создал транспорт. (ID: %i | Model: %i)", admin_rank_name(playerid), users[playerid][u_name], adm_veh, params[0]);
	return true;
}
CMD:delveh( playerid, params [ ])
{
	AdminProtect(4);
	if ( ! GetPVarInt ( playerid, "admin_vehicle" ) ) return server_error(playerid, "Вы не создавали автомобиль.");
	new veh_id = GetPVarInt(playerid, "admin_vehicle");
	DestroyVehicle ( veh_id ) ;
	AdminChatF("[A] %s %s удалил транспорт. (ID: %i)", admin_rank_name(playerid), users[playerid][u_name], veh_id);
	CarInfo[veh_id][car_admin] = 0;
	DeletePVar ( playerid, "admin_vehicle" ) ;
	return true;
}
CMD:repair(playerid) 
{
	AdminProtect(4);
	if(!IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы должны находиться в транспортном средстве!");
	RepairVehicle(GetPlayerVehicleID(playerid));
	SetHealthVehicle(GetPlayerVehicleID(playerid), 1000.0);
	for(new z = 0; z != 4; z++) 
	{ 
		if(CarInfo[GetPlayerVehicleID(playerid)][car_tires][z] == 1) continue;
		CarInfo[GetPlayerVehicleID(playerid)][car_tires][z] = 1; 
	}
	CarInfo[GetPlayerVehicleID(playerid)][car_fuel] = InfoOfFuel(GetPlayerVehicleID(playerid));
	server_accept(playerid, "Транспорт был успешно отремонтирован!");
	return 1; 
}
CMD:asetcolor(playerid, params[])
{
	AdminProtect(6);
	if(sscanf(params, "ui", params[0], params[1]))
	{
		server_error(playerid, "Используйте: /asetcolor [имя/ид] [номер цвета]");
		callcmd::acolors(playerid);
		return true;
	}
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует."); 
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	if(params[1] < 1 || params[1] > sizeof(prefix_colors)) return SCMASS(playerid, "Нельзя указиывать цвет меньше 1 и больше %i", sizeof(prefix_colors));
	if(admin[params[0]][u_a_dostup] != 1) return SCMASS(playerid, "Игрок %s не залогинен в админ панели.", users[params[0]][u_name]);
	format(admin[params[0]][admin_color], 20, prefix_colors[params[1]-1][1]);
	static str_sql[156];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_color` = '%s' WHERE `u_a_name` = '%s'", prefix_colors[params[1]-1][1], users[params[0]][u_name]);
	m_query(str_sql);
	AdminChatF("[A] %s %s изменил цвет администратору %s на {%s}%s", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], prefix_colors[params[1]-1][1], prefix_colors[params[1]-1][0]);
	server_accept(playerid, "Вы сменили цвет администратору");
	return true;
}
CMD:acolors(playerid)
{
	AdminProtect(6);
	new str[96];
	global_string[0] = EOS;
	strcat(global_string, "Номер\tЦвет\n");
	for(new i = 0; i < sizeof(prefix_colors); i++)
	{
		format(str, sizeof(str), "%i\t{%s}%s\n", i+1, prefix_colors[i][1], prefix_colors[i][0]);
		strcat(global_string, str);
	}
	show_dialog(playerid, d_none, DIALOG_STYLE_TABLIST_HEADERS, !"Таблица цветов", global_string, !"Закрыть", !"");
	return true;
}
CMD:reloot(playerid, params[])
{
	AdminProtect(6);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "Используйте: /reloot [время в минутах]");
	if(params[0] < 1 || params[0] > TimeForReLoot) return SCMASS(playerid, "Вермя должно быть от 1 до %i минут.", TimeForReLoot);
	ReLootTime = params[0];
	SCMG(playerid, "Вы изменили время релута, релут через %i минут(у) ( время +- )", params[0]);
	
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "Изменил время релута на %i", params[0]);
	logs_admin(playerid, str_logs, "/reloot");
	AntiFloodCommands(playerid, "/reloot");

	AdminChatF("[A] %s %s изменил время релута, релут через %i минут(у)", admin_rank_name(playerid), users[playerid][u_name], params[0]);
	return true;
}
CMD:asetrank(playerid, params[])
{
	AdminProtect(6);
	if(sscanf(params, "us[40]", params[0], params[1])) return server_error(playerid, "Используйте: /asetrank [имя/ид] [новое название ранга]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует."); 
	// if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	if(admin[params[0]][u_a_dostup] != 1) return SCMASS(playerid, "Игрок %s не залогинен в админ панели.", users[params[0]][u_name]);
	format(admin[params[0]][admin_rank], 40, params[1]);
	static str_sql[156];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_rank` = '%s' WHERE `u_a_name` = '%s'", params[1], users[params[0]][u_name]);
	m_query(str_sql);
	AdminChatF("[A] %s %s изменил название ранга администратору %s на %s", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], admin[playerid][admin_rank]);
	server_accept(playerid, "Вы сменили ранг администратору");
	return true;
}
CMD:setcoords(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "Администратор в режиме наблюдения.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "Администратор защищен.");
	static Float: coords[3];
	if(sscanf(params, "p<,>fff", coords[0], coords[1], coords[2])) return server_error(playerid, "Используйте: /setcoords x, y, z");
	SetPlayerPos(playerid, coords[0], coords[1], coords[2]);
	SCMG(playerid, "Вы телепортировались на координаты: %f, %f, %f ", coords[0], coords[1], coords[2]);
	return true;
}
/*
CMD:ownerbase(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует."); 
	if(admin[params[0]][u_a_dostup] != 1) return SCMASS(playerid, "Игрок %s не залогинен в админ панели.", users[params[0]][u_name]);
	format(admin[playerid][admin_rank], 40, params[1]);
	static str_sql[156];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_rank` = '%s' WHERE `u_a_name` = '%s'", params[1], users[params[0]][u_name]);
	m_query(str_sql);
	AdminChatF("[A] %s %s изменил название ранга администратору %s на %s", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], admin[playerid][admin_rank]);
	SCMG(playerid, "Вы сменили ранг администратору", 1);
	return true;
}*/
CMD:ownerbase(playerid)
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	new Cache:temp_sql = m_query("SELECT * FROM "TABLE_BASE""), rows;
    cache_get_row_count(rows);
	if(rows) 
	{
		global_string [ 0 ] = EOS ;
		new str[128], name[MAX_PLAYER_NAME], date[MAX_PLAYER_NAME], number;
		strcat(global_string, "Номер\tВладелец (номер)\tДата слета\n");
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name(idx-1, "b_owner_name", name, MAX_PLAYER_NAME);
			cache_get_value_name(idx-1, "b_delete_date", date, MAX_PLAYER_NAME);
			format(str, sizeof(str), "%i\t%s (%i)\t%s\n", idx, name, number, date);
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_TABLIST_HEADERS, !"Список владельцов баз", global_string, !"Ок", !"");
	}
	else server_error(playerid, "Базы не найдены.");
	cache_delete(temp_sql);
 	return 1;
}
/*CMD:editbase(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "is[24]", params[0], params[1])) return server_error(playerid, "Используйте: /editbase [номер базы] [новый имя владельца (no_base - слить базу в гос.)]");
	if(params[0] < 1 || params[0] > base_count) return SCMASS(playerid, "Номер базы от 1 до %i", base_count);
	if(!strcmp("no_base", params[1], false)) 
	{
		static str_sql[196];
		m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BASE" SET `b_name` = 'NoOwner', `b_lock_status` = '0', `b_lock_password` = '1234', `b_delete_date` = ' ', `b_buy_date` = ' ' WHERE `b_id` = '%i'", params[0]);
		m_query(str_sql);
		
		base[params[0]][b_lock_status] = 0;
		base[params[0]][b_owner_id] = 0;
		format(base[params[0]][b_lock_password], 24, "1234");
		format(base[params[0]][b_owner_name], 24, "NoOwner");

		SCMG(playerid, "База №%i слита в гос.", params[0]);
		return true;
	}
	//if(PlayerIsOnline(params[1])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует."); 
	base[params[0]][b_lock_status] = 0;
	format(base[params[0]][b_lock_password], 24, "1234");
	format(base[params[0]][b_owner_name], 24, params[1]);

	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BASE" SET `b_name` = '%s', `b_lock_status` = '0', `b_lock_password` = '1234' WHERE `b_id` = '%i'", base[params[0]][b_name], params[0]);
	m_query(str_sql);

	SCMG(playerid, "Вы изменили владельца базы %i. Новый владелец базы: %s.", params[0], base[params[0]][b_name]);
	return true;
}*/