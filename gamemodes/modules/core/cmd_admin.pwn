// ������:
alias:admin("a");
alias:apanel("ap");
alias:otvet("ans");
alias:recon("re");
alias:goto("g");
alias:clearchat("cc");
alias:ooc("o");
alias:gethere("gh");
alias:teleport("tp");
alias:changeclanspawn("cspclan");
alias:clanspawn("spclan");
alias:reprimand("avig");
alias:creprimand("cvig");

// �������:
CMD:alogin(playerid)
{
	if(admin[playerid][admin_dostup])
	{
		if(admin[playerid][admin_hide])
		{
			format(format_string_admin, sizeof(format_string_admin), "%s %s ����� �� ���������������� ������.", admin_rank_name(playerid), users[playerid][u_name]);
			admin_chat(format_string_admin);
		}
		admin[playerid][admin_dostup] = 0;
		admin[playerid][admin_level] = 0;
		AntiCheatEnable(playerid, false);
		server_error(playerid, "�� ����� �� ���������������� ������.");
		return true;
	}
	new format_string_mysql[96], string_password[65];
	m_format(format_string_mysql, sizeof(format_string_mysql), "SELECT * FROM "TABLE_ADMIN" WHERE `admin_name` = '%s' LIMIT 1", users[playerid][u_name]);
	new Cache: temp_MySQL = m_query(format_string_mysql), r;
    cache_get_row_count(r);
	if(r) 
	{
		cache_get_value_name(0, "admin_password", string_password, sizeof(string_password));
		DeletePVar(playerid, "ADMIN_CHECK");
		if(!strcmp(string_password, "newadminplayer", false)) 
		{
			SetPVarInt(playerid, "ADMIN_CHECK", 1);
			dialog_admin_login(playerid, 0);
		}
		else dialog_admin_login(playerid, 1);
	}
	else server_error(playerid, "������ ���������.");
	cache_delete(temp_MySQL);
	return true;
}
CMD:admin(playerid, params[]) 
{
	AdminCheck(1);
	if(sscanf(params, "s[96]", params[0])) return server_error(playerid, "�����������: /(a)dmin [�����]");
	format(format_string_admin, sizeof(format_string_admin), "[A] %s {FFFFFF}%s[%i]: {E0E0E0}%s", admin_rank_name(playerid), users[playerid][u_name], playerid, params[0]);
	admin_chat(format_string_admin);
	return true; 
}
CMD:apanel(playerid)
{
	AdminCheck(1);
	show_dialog(playerid, d_admin_panel, DIALOG_STYLE_TABLIST_HEADERS, "���������������� ������", "\
	�������� �������\t������\n\
	{cccccc}- {ffffff}������ �������������\t{33AA33}ONLINE\n\
	{cccccc}- {ffffff}������ ���� �������������\t{33AA33}ONLINE {ffffff}/ {A52A2A}OFFLINE\n\
	{cccccc}- {ffffff}������� �������������\t{cccccc}� 1-�� �������\n\
	{cccccc}- {ffffff}���� ������������\t{cccccc}� 1-�� �������\n\
	{cccccc}- {ffffff}��������� ���������������� ������\t{cccccc}� 1-�� �������\n\
	", !"�������", !"�������");
	return 1;
}
CMD:ahelp(playerid)
{
	AdminCheck(1);
	cmd_admin(playerid);
	return true;
}
CMD:admins(playerid)
{
	AdminCheck(1);
	new number = 0, format_string[96];
	global_string[0] = EOS;
	strcat(global_string, "�\t���\t������\n");
	foreach(Player, i)
	{
		if(!admin[i][admin_level]) continue;
		if(!admin[i][admin_dostup]) continue;
		if(admin[playerid][admin_level] == 9 && admin[i][admin_hide]) continue;
		number++;
		format(format_string, sizeof(format_string), "{cccccc}%i.\t{ffffff}%s\t%s\n", number, users[i][u_name], (GetPVarInt(i, "AFK") > 1)?("{B22222}AFK"):("{33AA33}� ����"));
		strcat(global_string, format_string);
	}
	if(!number) strcat(global_string, "������������� ��� � ����.");
	show_dialog(playerid, d_none, DIALOG_STYLE_TABLIST_HEADERS, !"������������� ������", global_string, !"�������", !"");
	// number = 0;
	return true;
}
CMD:recon(playerid, params[])
{
	AdminCheck(1);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "�����������: /re(con) [���/��]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(params[0] == playerid) return server_error(playerid, "�� ����� ����� ������ ���������.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	if(GetPlayerState(params[0]) != 1 && GetPlayerState(params[0]) != 2 && GetPlayerState(params[0]) != 3) return server_error(playerid, "����� �� ������� � ����.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� ������� �� ������.");
	Spectate(playerid, params[0], true);
	if(!admin[playerid][admin_hide])
	{
		format(format_string_admin, sizeof(format_string_admin), "[A] %s %s(%i) ����� ��������� �� ������� %s(%i).", admin_rank_name(playerid), users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
		admin_chat(format_string_admin);
	}
	return true;
}
CMD:reoff(playerid)
{
	AdminCheck(1);
	if(GetPlayerState(playerid) != PLAYER_STATE_SPECTATING) return server_error(playerid, "�� �� � ������ ����������.");
	Spectate(playerid);
	server_accept(playerid, "�� ����� �� ������ ����������.");
	return true;
}
CMD:mute(playerid, params[]) 
{
	AdminCheck(1);
	if(sscanf(params, "uis[100]", params[0], params[1], params[2])) return server_error(playerid, "�����������: /mute [���/��] [������] [�������] (����� ��� ���� /unmute [���/��])");
	if(PlayerIsOnline(params[0]) || params[0] == playerid) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(params[1] < 1 || params[1] > 300) return server_error(playerid, "����� �� 1 ������ �� 300");
	if(admin[params[0]][u_a_level] >= 1) return server_error(playerid,"����� �������������");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	new str[96];
	global_string[0] = EOS;
	strcat(global_string, "{ffffff}");
	strcat(global_string, "�� �������� ���-����!\n\n");
	format(str, sizeof(str), "����� �������������: {FF3333}%s\n", users[playerid][u_name]);
	strcat(global_string, str);
	format(str, sizeof(str), "{FFFFFF}����� ����: {FF3333}%i �����(�/�)\n", params[1]);
	strcat(global_string, str);
	format(str, sizeof(str), "{FFFFFF}������� ����: {FF3333}%s\n", params[2]);
	strcat(global_string, str);
	strcat(global_string, "{FFFFFF}���� �� �������� ��� ��� ���� ����� �����, ������ �������� ������ �� ������ "FORU_NAME".");
	show_dialog(params[0], d_none, DIALOG_STYLE_MSGBOX, !"", global_string, !"�������", !"");
	SCMAF(COLOR_BROWN, "������������� %s ����� ��� ���� ������ %s �� %i �����(�). �������: %s", users[playerid][u_name], users[params[0]][u_name], params[1], params[2]);
	users[params[0]][u_mute] = params[1]*60;
	new format_string_logs[196];
	format(format_string_logs, sizeof(format_string_logs), "������������ ��� ������ %s �� %i �����. �������: %s", users[params[0]][u_name], params[1], params[2]);
	logs_admin(playerid, format_string_logs, "/mute");
	AntiFloodCommands(playerid, "/mute");
	return 1; 
}
CMD:unmute(playerid, params[]) 
{
	AdminCheck(1);
	if(sscanf(params, "us[100]", params[0], params[1])) return server_error(playerid, "�����������: /unmute [���/��] [�������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!users[params[0]][u_mute]) return server_error(playerid, "� ������ ���� ���������� ����!");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	users[params[0]][u_mute] = 0;
	SCMAF(COLOR_BROWN, "������������� %s ���� ��� ���� ������ %s. �������: %s", users[playerid][u_name], users[params[0]][u_name], params[1]);
	new format_string_logs[196];
	format(format_string_logs, sizeof(format_string_logs), "������������� ��� ������ %s. �������: %s", users[params[0]][u_name], params[1]);
	logs_admin(playerid, format_string_logs, "/unmute");
	AntiFloodCommands(playerid, "/unmute");
	return 1; 
}
CMD:hp(playerid, params[]) 
{
	AdminCheck(1);
	users[playerid][u_damage][0] = 0;
	users[playerid][u_damage][1] = 0;
	SetPlayerDrunkLevel(playerid, 0);
	GivePlayerHealth(playerid, 100.0);
	SetPlayerNeed(playerid, 0, 100);
	SetPlayerNeed(playerid, 1, 100);
	//users[playerid][u_health] = 100.0;
	server_message(playerid, "�� ������������ ��������� ������ ���������.");
	logs_admin(playerid, "����������� ����.", "/hp");
	return 1; 
}
CMD:chatlog(playerid, params[])
{
	AdminCheck(1);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "�����������: /chatlog [���/��]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	if(!strcmp(LogsChat[params[0]][0], "NoChatLogsClear")) return server_error(playerid, "��� ���� ����! ����� ��� �� ����� � ���.");
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
	format(str_header, sizeof(str_header),"ChatLog ������: %s", users[params[0]][u_name]);
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, str_header, global_string, !"��", !"");
	return true;
}
CMD:goto(playerid, params[]) 
{
	AdminCheck(2);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "�����������: /(g)oto [���/��]");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	new Float: g_plocx[3];
	GetPlayerPos(params[0], g_plocx[0], g_plocx[1], g_plocx[2]);
	SPP(playerid, g_plocx[0]+1, g_plocx[1], g_plocx[2]+1.0, GetPlayerVirtualWorld(params[0]), GetPlayerInterior(params[0]));
	AdminChatF("[A] %s %s ���������������� � ������ %s[%i].", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[0]);
	new format_string_logs[96];
	format(format_string_logs, sizeof(format_string_logs), "���������������� � ������ %s", users[params[0]][u_name]);
	logs_admin(playerid, format_string_logs, "/goto");
	AntiFloodCommands(playerid, "/goto");
	return 1; 
}
CMD:sethp(playerid, params[]) 
{
	AdminCheck(2);
	if(sscanf(params,"ui", params[0], params[1])) return server_error(playerid, "�����������: /sethp [���/��] [������� �����]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	if(params[1] > 100) return server_error(playerid, "������ 100 hp ������.");
	AdminChatF("[A] %s %s ��������� %i ������ ������ %s[%i].", admin_rank_name(playerid), users[playerid][u_name], params[1], users[params[0]][u_name], params[0]);
	SCMG(params[0], "������������� %s ��������� ��� %i ������.", users[playerid][u_name], params[1]);
	users[params[0]][u_health] = params[1];
	SetPlayerHealth(params[0], params[1]);
	new format_string_logs[96];
	format(format_string_logs, sizeof(format_string_logs), "������� ����� ������ %s �� %i", users[params[0]][u_name], params[1]);
	logs_admin(playerid, format_string_logs, "/sethp");
	AntiFloodCommands(playerid, "/sethp");
	return 1; 
}
CMD:kick(playerid, params[]) 
{
	AdminCheck(1);
	if(sscanf(params,"us[100]", params[0], params[1])) return server_error(playerid, "�����������: /kick [���/��] [�������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	//if(GetTextBlurb(playerid,params[1],"/kick"))											return true;
	if(admin[params[0]][admin_level] > admin[playerid][admin_level])
	{
		server_error(playerid, "�������������� ������ ������"); 
		AdminChatF("[A] %s %s ����� ������� �������������� %s. �������: %s", admin_rank_name(playerid), users[playerid][u_name], users[params[0]][u_name], params[1]);
		return true;
	}
	SCMAF(COLOR_BROWN, "������������� %s ������ ������ %s. �������: %s", users[playerid][u_name], users[params[0]][u_name], params[1]);
	TKICK(params[0], "�� ���� ������� �������������� �������.");
	
	new format_string_logs[96];
	format(format_string_logs, sizeof(format_string_logs), "������ ������ %s. �������: %s", users[params[0]][u_name], params[1]);
	logs_admin(playerid, format_string_logs, "/kick");
	AntiFloodCommands(playerid, "/kick");
	return 1; 
}
CMD:slap(playerid, params[])
{
	AdminCheck(2);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "�����������: /slap [��]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	if(admin[playerid][u_a_level] <= admin[params[0]][u_a_level])
	{
		AdminChatF("[A][WARNING] ������������� %s(%i) ��������� ����� �������������� %s(%i).", users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
		SCMASS(params[0], "������������� %s(%i) ��������� ��� �����.", users[playerid][u_name], playerid);
		server_error(playerid, "������ ����� ������������� � ���� ������ ������ �����������������.");
	    return true;
	}
	new Float: pl_pos [ 3 ];
	GetPlayerPos( params [ 0 ], pl_pos [ 0 ], pl_pos [ 1 ], pl_pos [ 2 ]);
	SetPlayerPos( params [ 0 ], pl_pos [ 0 ], pl_pos [ 1 ], pl_pos [ 2 ] + 6);
	PlayerPlaySound( params [ 0 ], 1130, pl_pos [ 0 ], pl_pos [ 1 ], pl_pos [ 2 ] + 6);
	SCMG(params [ 0 ], "������������� %s[%d] �������� ���.", users[playerid][u_name], playerid);
	AdminChatF("[A] ������������� %s(%i) �������� ������ %s(%i).", users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
	
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "���� ������ %s", users[params[0]][u_name]);
	logs_admin(playerid, str_logs, "/slap");
	AntiFloodCommands(playerid, "/slap", 3);
	return 1;
}
CMD:showstats(playerid, params[])
{
	AdminCheck(2);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "�����������: /showstats [���/��]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	ShowStats(playerid, params[0]);
	return true;
}
CMD:ooc(playerid, params[]) 
{
	AdminCheck(2);
	if(sscanf(params, "s[128]", params[0])) return server_error(playerid, "�����������: /ooc(/o) [Text]");
	SCMAF(0xFFFFFFFF, "[OOC] %s: %s", users[playerid][u_name], playerid, params[0]);
	return 1; 
}
CMD:clearchat(playerid, params[]) 
{
	AdminCheck(2);
	for(new c = 0; c < 65; c++) SendClientMessageToAll(-1, " ");
	SendClientMessageToAll(COLOR_BROWN, "������������� "FULL_NAME" ��������� ������� ����!");
	AdminChatF("[A] %s %s ������� ������� ����.", AdminRankName(playerid), users[playerid][u_name]);
	
	logs_admin(playerid, "�������� ������� ����", "/clearchat");
	AntiFloodCommands(playerid, "/clearchat");
	return true; 
}
CMD:gethere(playerid, params[]) 
{
	AdminCheck(3);
	if(sscanf(params,"u", params[0])) return server_error(playerid, "�����������: /gethere [���/��]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	// if(observation[params[0]][observation_id] != -1) return server_error(playerid, "������ ����� � ������ ����������.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	new Float: g_plocx[3];
	GetPlayerPos(playerid, g_plocx[0], g_plocx[1], g_plocx[2]);
	SPP(params[0], g_plocx[0]+1, g_plocx[1], g_plocx[2]+1.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	server_accept(params[0], "��� �������������� ������������� ������� "FULL_NAME"");
	AdminChatF("[A] %s %s �������������� � ���� ������ %s[%i].", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], params[0]);
	
	static str_logs[196];
	format(str_logs, sizeof(str_logs), "�������������� ������ %s � ����", users[params[0]][u_name]);
	logs_admin(playerid, str_logs, "/gethere");
	AntiFloodCommands(playerid, "/gethere");
	return 1; 
}
CMD:tpcar(playerid, params[]) 
{
	AdminCheck(3);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "�����������: /tpcar [����� ����]");
	if(params[0] < 1 || params[0] > count_veh) return server_error(playerid, "�����������: /tpcar [����� ����]");
	static Float: pos_veh[3];
	GetVehiclePos(params[0], pos_veh[0], pos_veh[1], pos_veh[2]);
	SetPlayerPos(playerid, pos_veh[0], pos_veh[1], pos_veh[2]+1);
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "���������������� � ���������� �%i", params[0]);
	logs_admin(playerid, str_logs, "/tpcar");
	AntiFloodCommands(playerid, "/tpcar");
	return true;
}
CMD:ban(playerid, params[])
{
	AdminProtect(3);
	if(sscanf(params, "uis[100]", params[0], params[1], params[2])) return server_error(playerid, "�����������: /ban [���/��] [���] [�������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	if(params[1] < 7 || params[1] > 365) return server_error(playerid, "���-�� ���� ������ ���� �� 7-� �� 365-��");
	if(admin[params[0]][u_a_level])
	{
		AdminChatF("[A][WARNING] ������������� %s(%i) ��������� �������� �������������� %s(%i).", users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
		SCMASS(params[0], "������������� %s(%i) ��������� ��� ��������.", users[playerid][u_name], playerid);
		server_error(playerid, "������ ����� ������������� � ���� ������ ������ �����������������.");
	    return true;
	}
	static str[256];
	format(str, sizeof(str), "������������� %s ������� ������ %s �� %i ����. �������: %s.", users[playerid][u_name], users[params[0]][u_name], params[1], params[2]);
	SendClientMessageToAll(COLOR_BROWN, str);
	if(users[params[0]][u_clan] > 0) AdminChatF("[A][LOG] IP: %s | R-IP: %s | ����: %i", GetIp(params[0]), users[params[0]][u_ip_registration], users[params[0]][u_clan]);
	else if(users[params[0]][u_clan] < 1) AdminChatF("[A][LOG] IP: %s | R-IP: %s", GetIp(params[0]), users[params[0]][u_ip_registration]);

	m_format(str, sizeof(str), "INSERT INTO "TABLE_BAN" (`u_b_admin`, `u_b_name`, `u_b_reason`, `u_b_date`, `u_b_ndate`, `u_b_days`) VALUES ('%s', '%s', '%s', NOW() + INTERVAL %i DAY, NOW(), '%i')",
	users[playerid][u_name], users[params[0]][u_name], params[2], params[1], params[1]);
	m_query(str);

	static str_logs[128];
	format(str_logs, sizeof(str_logs), "������������ ������ %s �� %i ����. �������: %s", users[params[0]][u_name], params[1], params[2]);
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
	if(sscanf(params, "s[24]s[64]", name, params[1])) return server_error(playerid, "�����������: /unban [���] [�������]");
	//if(GetPlayerID(params[0]) != INVALID_PLAYER_ID) return server_error(playerid, "����� �� �������! �����������: /ban");
	static str[128];
	m_format(str, sizeof(str), "SELECT * FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW() LIMIT 1", name);
	new Cache:temp_sql = m_query(str), r;
    cache_get_row_count(r);
	if(r) 
	{
		m_format(str, sizeof(str), "DELETE FROM "TABLE_BAN" WHERE `u_b_name` = '%s' AND `u_b_date` > NOW()", name);
		m_query(str);
		SCMG(playerid, "����� %s �������������.", name);
		format(str, sizeof(str), "������������� %s �������� ������ %s. �������: %s.", users[playerid][u_name], name, params[1]);
		SendClientMessageToAll(COLOR_BROWN, str);

		static str_logs[96];
		format(str_logs, sizeof(str_logs), "������������� ������ %s. �������: %s", name, params[1]);
		logs_admin(playerid, str_logs, "/unban");
	}
	else SCMASS(playerid, "����� %s �� ������ � ������� � ������.", name);
	cache_delete(temp_sql);
	return true;
}
CMD:skin(playerid, params[])
{
	AdminProtect(3);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "�����������: /skin [����]");
	//if( params[0] == 74) return server_error(playerid, "�������� ����� ����� ��� ���� ��������.");
	AdminChatF("[A] ������������� %s(%i) ������� ���� ���� �� ����� %i.", users[playerid][u_name], playerid, params[0]);
	server_error(playerid, "�� �������� ���� ����.");
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
		strcat(global_string, "�����������: {cccccc}/changeclanspawn [����� �����]\n\n");
		strcat(global_string, "{ffffff}�\t�������� �����\t����� �����\n\n");
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name_int(idx-1, "c_id", number);
			cache_get_value_name(idx-1, "c_name", name, MAX_PLAYER_NAME);
			format(str, sizeof(str), "{cccccc}%i.\t{ADD8E6}%s\t\t\t{cccccc}%i\n", idx, name, number);
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"������ �� ����� ������", global_string, !"��", !"");
	}
	else server_error(playerid, "����� �� �������� ������ �� ����� ������.");
	cache_delete(temp_sql);
	return true;
}
CMD:changeclanspawn(playerid, params[])
{
	AdminProtect(3);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "�����������: /changeclanspawn (/cspclan) [����� �����]");
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
		format(str_sql, sizeof(str_sql), "������ ����� �%i", GetPVarInt(playerid, "AdminClanSpawn"));
		show_dialog(playerid, d_clan_change_spawn, DIALOG_STYLE_LIST, str_sql, "{cccccc}1. {ffffff}����������� �����\n{cccccc}2. {33AA33}��������� �����\n{cccccc}3. {A52A2A}�������� � ����� ������", !"�������", !"������");
	}
	else SCMASS(playerid, "���� �%i �� ������� ��� ��� �������� ������ �� ����� ������.", params[0]);
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
		strcat(global_string, "�����������: {cccccc}/changespawn [����� ��������]\n\n");
		strcat(global_string, "{ffffff}�\t���\t\t����� ��������\n\n");
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name_int(idx-1, "u_id", number);
			cache_get_value_name(idx-1, "u_name", name, MAX_PLAYER_NAME);
			format(str, sizeof(str), "{cccccc}%i.\t{ADD8E6}%s\t\t{cccccc}%i\n", idx, name, number);
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"������ �� ������ �����", global_string, !"��", !"");
	}
	else server_error(playerid, "������ �� �������� ������ �� ������ �����.");
	cache_delete(temp_sql);
	return true;
}
CMD:changespawn(playerid, params[])
{
	AdminProtect(3);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "�����������: /changespawn [����� ��������]");
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
		format(str_sql, sizeof(str_sql), "����� �������� �%i", GetPVarInt(playerid, "AdminSpawn"));
		show_dialog(playerid, d_change_spawn, DIALOG_STYLE_LIST, str_sql, "{cccccc}1. {ffffff}����������� �����\n{cccccc}2. {33AA33}��������� �����\n{cccccc}3. {A52A2A}�������� � ����� ������", !"�������", !"������");
	}
	else SCMASS(playerid, "����� �������� �%i �� ������� ��� ��� �������� ������ �� ������ ����� ������.", params[0]);
	cache_delete(temp_sql);
	return true;
}
CMD:veh(playerid, params[])
{
	AdminProtect(4);
	if(GetPVarInt(playerid, "admin_vehicle")) return server_error(playerid, "�� ��� ������� ����������.");
	if(GetPlayerState ( playerid ) == PLAYER_STATE_DRIVER ) return server_error(playerid, "�� ��� �� ����.");
	if(sscanf(params, "iii", params [ 0  ], params [ 1  ], params [ 2 ])) return server_error(playerid, "�����������: /veh [�� ����] [���� 1] [���� 2]");
	if(params [ 0 ] < 400 || params [ 0 ] > 611) return server_error(playerid,"�����������: /veh [�� ����] [���� 1] [���� 2]");
	if(params [ 1 ] < 0 || params [ 1 ] > 255) return server_error(playerid,"�����������: /veh [�� ����] [���� 1] [���� 2]");
	if(params [ 2 ] < 0 || params [ 2 ] > 255) return server_error(playerid,"�����������: /veh [�� ����] [���� 1] [���� 2]");
	new Float:player_pos [ 3 ];
	GetPlayerPos(playerid, player_pos [ 0 ], player_pos [ 1 ], player_pos [ 2 ]);
	new adm_veh = CreateVehicle(params [ 0 ], player_pos [ 0 ], player_pos [ 1 ], player_pos [ 2 ], 0.0, params [ 1 ], params [ 2 ], -1);
	SetPVarInt(playerid, "admin_vehicle", adm_veh);
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
	AdminChatF("[A] %s %s ������ ���������. (ID: %i | Model: %i)", AdminRankName(playerid), users[playerid][u_name], adm_veh, params[0]);
	return true;
}
CMD:delveh( playerid, params [ ])
{
	AdminProtect(4);
	if ( ! GetPVarInt ( playerid, "admin_vehicle" ) ) return server_error(playerid, "�� �� ��������� ����������.");
	new veh_id = GetPVarInt ( playerid, "admin_vehicle" ) ;
	DestroyVehicle ( veh_id ) ;
	AdminChatF("[A] %s %s ������ ���������. (ID: %i)", AdminRankName(playerid), users[playerid][u_name], veh_id);
	DeletePVar ( playerid, "admin_vehicle" ) ;
	return true;
}
CMD:repair(playerid) 
{
	AdminProtect(4);
	if(!IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "�� ������ ���������� � ������������ ��������!");
	RepairVehicle(GetPlayerVehicleID(playerid));
	SetHealthVehicle(GetPlayerVehicleID(playerid), 1000.0);
	for(new z = 0; z != 4; z++) 
	{ 
		if(CarInfo[GetPlayerVehicleID(playerid)][car_tires][z] == 1) continue;
		CarInfo[GetPlayerVehicleID(playerid)][car_tires][z] = 1; 
	}
	CarInfo[GetPlayerVehicleID(playerid)][car_fuel] = InfoOfFuel(GetPlayerVehicleID(playerid));
	server_accept(playerid, "��������� ��� ������� ��������������!");
	return 1; 
}
CMD:banip(playerid, params[])
{
	AdminProtect(4);
	new ip[20];
	if(sscanf(params, "s[20]s[64]", ip, params[1])) return server_error(playerid, "�����������: /banip [IP] [�������]");
	if(strfind(ip, "*", true) != -1) return server_error(playerid, "������������ ip �����.");
	new protect_ = 0;
	foreach(Player, i)
	{
		static str_ip[20];
		GetPlayerIp(i, str_ip, 20);
		if(!strcmp(ip,  str_ip, true))
		{
			protect_ = 1;
			SCMASS(playerid, "����� %s(%i) �� ������� � ����� ����� �� IP %s.", users[i][u_name], i, ip);
			server_error(playerid, "����������� /iban ��� ���������� ������� ������������.");
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
		format(str, sizeof(str), "������������� %s ������������ %s �� %i ����. �������: %s.", users[playerid][u_name], ip, days, params[1]);
		SendClientMessageToAll(COLOR_BROWN, str);

		m_format(str, sizeof(str), "INSERT INTO "TABLE_BANIP" (`u_b_ip_admin`, `u_b_ip`, `u_b_ip_reason`, `u_b_ip_date`, `u_b_ip_ndate`, `u_b_ip_days`) VALUES ('%s', '%s', '%s', NOW() + INTERVAL %i DAY, NOW(), '%i')",
		users[playerid][u_name], ip, params[1], days, days);
		m_query(str);	

		SCMG(playerid, "IP %s ��� ������������ �� %i �.", ip, days);
		
		static str_logs[128];
		format(str_logs, sizeof(str_logs), "������������ IP � ������� %s. �������: %s", ip, params[1]);
		logs_admin(playerid, str_logs, "/banip");
		AntiFloodCommands(playerid, "/banip");
	}
	else server_error(playerid, "������ IP ��� ������������.");
	cache_delete(temp_sql);
	return true;
}
CMD:iban(playerid, params[])
{
	AdminProtect(4);
	if(sscanf(params, "uis[100]", params[0], params[1], params[2])) return server_error(playerid, "�����������: /iban [���/��] [���] [�������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	if(params[1] < 7 || params[1] > 20000) return server_error(playerid, "���-�� ���� ������ ���� �� 7-� �� 20000-���");
	if(admin[playerid][u_a_level])
	{
		AdminChatF("[A][WARNING] ������������� %s(%i) ��������� �������� �������������� %s(%i).", users[playerid][u_name], playerid, users[params[0]][u_name], params[0]);
		SCMASS(params[0], "������������� %s(%i) ��������� ��� ��������.", users[playerid][u_name], playerid);
		server_error(playerid, "������ ����� ������������� � ���� ������ ������ �����������������.");
	    return true;
	}
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	
	static str[256];
	format(str, sizeof(str), "������������� %s ������� ������ %s �� %i ����. �������: %s.", users[playerid][u_name], users[params[0]][u_name], params[1], params[2]);
	SendClientMessageToAll(COLOR_BROWN, str);
	if(users[params[0]][u_clan] > 0) AdminChatF("[A][LOG] IP: %s | R-IP: %s | ����: %i", GetIp(params[0]), users[params[0]][u_ip_registration], users[params[0]][u_clan]);
	else if(users[params[0]][u_clan] < 1) AdminChatF("[A][LOG] IP: %s | R-IP: %s", GetIp(params[0]), users[params[0]][u_ip_registration]);
	/*if(users[params[0]][u_clan] > 0)
	{
		static str_sql[128];
		m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_CLAN" SET `c_reprimand` = `c_reprimand`+'1' WHERE `c_id` = '%i' LIMIT 1", clan[l[params[0]][u_clan]][c_id]);
		m_query(str_sql);
		AdminChatF("[A] ����� %s(%i) ����� ������� (%i/3). �������: ����� � �����.", clan[l[params[0]][u_clan]][c_name], users[params[0]][u_clan], clan[params[0]][c_reprimand]);
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
	format(str_logs, sizeof(str_logs), "������������ ������� ������ %s � IP %s �� %i ����. �������: %s", users[params[0]][u_name], str_ip, params[1], params[2]);
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
	if(sscanf(params, "s[20]s[64]", ip, params[1])) return server_error(playerid, "�����������: /unbanip [IP] [�������]");
	//if(GetPlayerID(params[0]) != INVALID_PLAYER_ID) return server_error(playerid, "����� �� �������! �����������: /ban");
	static str[256];
	m_format(str, sizeof(str), "SELECT * FROM "TABLE_BANIP" WHERE `u_b_ip` = '%s' AND `u_b_ip_date` > NOW() LIMIT 1", ip);
	new Cache:temp_sql = m_query(str), r;
    cache_get_row_count(r);
	if(r) 
	{
		m_format(str, sizeof(str), "DELETE FROM "TABLE_BANIP" WHERE `u_b_ip` = '%s' AND `u_b_ip_date` > NOW()", ip);
		m_query(str);
		SCMG(playerid, "IP %s �������������.", ip);
		format(str, sizeof(str), "������������� %s ������������� ip %s. �������: %s.", users[playerid][u_name], ip, params[1]);
		SendClientMessageToAll(COLOR_BROWN, str);
		
		static str_logs[96];
		format(str_logs, sizeof(str_logs), "������������� IP %s. �������: %s",  ip, params[1]);
		logs_admin(playerid, str_logs, "/unbanip");
		AntiFloodCommands(playerid, "/unbanip");
	}
	else SCMASS(playerid, "IP %s �� ������ � ������� � ������.", ip);
	cache_delete(temp_sql);
	return true;
}
CMD:offban(playerid, params[])
{
	AdminProtect(3);
	new name[MAX_PLAYER_NAME], reason[100], days;
    if(sscanf(params, "s[24]is[100]", name, days, reason)) return server_error(playerid, "�����������: /offban [���] [���] [�������]");
	if(GetPlayerID(name) != INVALID_PLAYER_ID) return server_error(playerid, "����� �� �������! �����������: /ban");
    if(!strcmp(name, "Noir", true) || !strcmp(name, "Felix", true)) return server_error(playerid, "������� ������������� ������ ������������� �������");
	if(days < 7 || days > 20000) return server_error(playerid, "���-�� ���� ������ ���� �� 7-� �� 20000-���");
	static str_sql[96];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1", name);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(!r) 
	{
		SCMASS(playerid, "������� {cccccc}%s{ffffff} �� ���������������.", name);
		cache_delete(temp_sql);
		return true;
	}
	cache_delete(temp_sql);
    m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_BAN" WHERE `u_b_name` = '%s' LIMIT 1", name);
	m_tquery(str_sql, "@CheckPlayerBanTable", "isis", playerid, name, days, reason);
    return 1;
}
CMD:getip(playerid, params[])
{
	AdminProtect(4);
	if(sscanf(params, "u", params[0]))return server_error(playerid, "�����������: /getip [��]");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	global_string[0] = EOS;
	static str[96];
	format(str, sizeof(str), "\n{ffffff}��� ������: {cccccc}%s", users[params[0]][u_name]);
	strcat(global_string, str);
	format(str, sizeof(str), "\n{ffffff}������� Ip-����� ������: {cccccc}%s", GetIp(params[0]));
	strcat(global_string, str);
	format(str, sizeof(str), "\n{ffffff}Ip-����� ��� ����������� ������: {cccccc}%s", users[params[0]][u_ip_registration]);
	strcat(global_string, str);
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"IP-����� ������", global_string, !"�������", !"");
	return 1;
}
CMD:listname(playerid)
{
	AdminProtect(4);
	static index_ = 0;
	if(index_) index_ = 0;
	global_string[0] = EOS;
	static str[128];
	strcat(global_string, "�����������: {cccccc}/acceptname [������� ���/��]\n\n");
	strcat(global_string, "{ffffff}ID\t������� ���\t�������� ���\n\n");
	foreach(Player, i)
	{
		if(!IsPlayerConnected(i)) continue;
		if(!strcmp(temp[i][player_setname], "NoChangeName")) continue;
		index_++;
		format(str, sizeof(str), "{cccccc}%i\t{ADD8E6}%s\t{cccccc}%s\n", i, users[i][u_name], temp[i][player_setname]);
		strcat(global_string, str);
	}
	if(!index_) return server_error(playerid, "������ �� �������� ������ �� ����� ����.");
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"������ �� ����� ����", global_string, !"��", !"");
	return true;
}
CMD:acceptname(playerid, params[])
{
	AdminProtect(4);
	if(sscanf(params, "u", params[0])) return server_error(playerid, "�����������: /acceptname [������� ���/��]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!strcmp(temp[params[0]][player_setname], "NoChangeName")) return server_error(playerid, "����� �� ����� ������ �� ����� ���� ��� ���������.");
	SetPVarInt(playerid, "changename", params[0]);
	static str[256];
	format(str, sizeof(str), "\n\
	{cccccc}������� ���: {fffff0}%s\n\
	{fffff0}��� � ������ �� �����: {cccccc}%s\n\n\
	{fffff0}�� ������������� ������ �������� ����� ����?", users[params[0]][u_name], temp[params[0]][player_setname]);
	show_dialog(playerid, d_setname_accept, DIALOG_STYLE_MSGBOX, !"������ �� ����� ����", str, !"��", !"���");
	return true;
}
CMD:weather(playerid, params[]) 
{
	AdminProtect(5);
	SetWeather(weather[random(sizeof(weather))]);
	server_accept(playerid, "�� ������� ������.");
	AdminChatF("[A] %s %s ������ ������.", AdminRankName(playerid), users[playerid][u_name]);
	logs_admin(playerid, "������ ������", "/weather");
	AntiFloodCommands(playerid, "/weather");
	return 1; 
}
CMD:reprimand(playerid, params[])
{
	AdminProtect(5);
	static str[24];
	if(sscanf(params, "us[2]s[128]", params[0], str, params[2])) return server_error(playerid, "�����������: /reprimand [���/��] [+/-] [�������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `admin_name` = '%s' LIMIT 1", users[params[0]][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		static reprimand, freeze;
		cache_get_value_name_int(0, "admin_vig", reprimand);
		cache_get_value_name_int(0, "admin_block", freeze);
		if(freeze > 0 && reprimand > 2)
		{
			SCMG(playerid, "������������� %s(%i) ���������, ��������� �� ������� ��������������.", users[params[0]][u_name], params[0]);
			cache_delete(temp_sql);
			return true;
		}
		if(!strcmp(str, "+", false))
		{
			switch(reprimand)
			{
			case 0, 1:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_vig` = `admin_vig` + '1' WHERE `admin_name` = '%s'", users[params[0]][u_name]);
					m_query(str_sql);
					AdminChatF("[A] %s %s ����� �������������� %s[%i] �������. �������: %s.", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
					SCMG(playerid, "�� ������ ������� ������ %s(%i).", users[params[0]][u_name], params[0]);

					static str_logs[156];
					format(str_logs, sizeof(str_logs), "����� ������� �������������� %s. �������: %s", users[params[0]][u_name], params[2]);
					logs_admin(playerid, str_logs, "/reprimand");
				}
			case 2:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_vig` = '3', `admin_block` = '1' WHERE `admin_name` = '%s'", users[params[0]][u_name]);
					m_query(str_sql);
					AdminChatF("[A] %s %s ����� �������������� %s[%i] �������. �������: %s.", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
					AdminChatF("[A] %s %s �������� ��������� � ���������������� ������. �������: ������� 3 �� 3", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
					
					static str_logs[196];
					format(str_logs, sizeof(str_logs), "����� ������� �������������� %s, ����� ������������� ����������. �������: %s", users[params[0]][u_name], params[2]);
					logs_admin(playerid, str_logs, "/reprimand");

					SCMG(playerid, "�� ������ ������� ������ %s(%i).", users[params[0]][u_name], params[0]);
					callcmd::alogin(params[0]);
				}
			}
		}
		if(!strcmp(str, "-", false))
		{
			switch(reprimand)
			{
			case 0: server_error(playerid, "� �������������� ��� ���������");
			case 1, 2:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_vig` = `admin_vig` - '1' WHERE `admin_name` = '%s'", users[params[0]][u_name]);
					m_query(str_sql);
					AdminChatF("[A] %s %s ���� �������������� %s[%i] �������. �������: %s.", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
					SCMG(playerid, "�� ����� ������� ������ %s(%i).", users[params[0]][u_name], params[0]);
					
					static str_logs[156];
					format(str_logs, sizeof(str_logs), "���� ������� �������������� %s. �������: %s", users[params[0]][u_name], params[2]);
					logs_admin(playerid, str_logs, "/reprimand");
				}
			}
		}
	}
	else SCMASS(playerid, "����� %s �� �������������.", users[params[0]][u_name]);
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/reprimand");
	return true;
}
CMD:creprimand(playerid, params[])
{
	AdminProtect(5);
	static str[24];
	if(sscanf(params, "is[2]s[128]", params[0], str, params[2])) return server_error(playerid, "�����������: /creprimand [����� ������] [+/-] [�������]");
	// if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
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
					AdminChatF("[A] %s %s ����� ����� %s(%i) �������. �������: %s.", AdminRankName(playerid), users[playerid][u_name], clan[params[0]][c_name], params[0], params[2]);
					SCMG(playerid, "�� ������ ������� ����� %s(%i).", clan[params[0]][c_name], params[0]);
					
					format(str_sql, sizeof(str_sql), "[R][CLAN] �������������� ������ ������� �����. �������: %s.", params[2]);
					clan_message(params[0], str_sql);

					static str_logs[156];
					format(str_logs, sizeof(str_logs), "����� ������� ����� �%i. �������: %s", params[0], params[2]);
					logs_admin(playerid, str_logs, "/creprimand");
				}
			case 3: server_error(playerid, "� ����� %s(%i) 3 �� 3 ��������.");
			}
		}
		else if(!strcmp(str, "-", false))
		{
			switch(reprimand)
			{
			case 0: server_error(playerid, "� ����� ��� ���������");
			case 1..3:
				{
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CLAN" SET `c_reprimand` = `c_reprimand` - '1' WHERE `c_id` = '%i'", params[0]);
					m_query(str_sql);
					AdminChatF("[A] %s %s ���� ����� %s(%i) �������. �������: %s.", AdminRankName(playerid), users[playerid][u_name], clan[params[0]][c_name], params[0], params[2]);
					
					static str_logs[156];
					format(str_logs, sizeof(str_logs), "���� ������� ����� �%i. �������: %s", params[0], params[2]);
					logs_admin(playerid, str_logs, "/creprimand");

					SCMG(playerid, "�� ����� ������� ����� %s(%i).", clan[params[0]][c_name], params[0]);
					format(str_sql, sizeof(str_sql), "[R][CLAN] �������������� ����� ������� �����. �������: %s.", params[2]);
					clan_message(params[0], str_sql);
				}
			}
		}
		else server_error(playerid, "ERROR ( + or - )");
	}
	else SCMASS(playerid, "���� %i �� ������.", params[0]);
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/creprimand");
	return true;
}
CMD:tpbox(playerid, params[])
{
	AdminProtect(5);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "�����������: /tpbox [����� �����]");
	if(params[0] < 1 || params[0] > MAX_BOX) return server_error(playerid, "�����������: /tpbox [����� �����]");
	if(box[params[0]][box_xyzf][0] == 0) return server_error(playerid, "���� ������ ����� ��� ���-�� ������.");
	SPP(playerid, box[params[0]][box_xyzf][0], box[params[0]][box_xyzf][1], box[params[0]][box_xyzf][2]+1.5, random(360), 0, 0);
	
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "���������������� � ����� �%i", params[0]);
	logs_admin(playerid, str_logs, "/tpbox");
	AntiFloodCommands(playerid, "/tpbox");
	return true;
}
CMD:restart(playerid, params[]) 
{
	AdminProtect(6);
	foreach(Player, i)
	{
		if(!IsPlayerConnected(i)) continue;
		//SaveUser(i, "account");
		TKICK(i, "������ ���������������...");
	}
	ServerRestarted = 2;
	SendRconCommand("hostname "FULL_NAME" | ������� �������...");
	//for(new i = 1; i < count_veh; i++) { SaveVeh(i); }
	//for(new i = 1; i < count_box; i++) { SaveBox(i); }
	return 1; 
}
CMD:teleport(playerid)
{
	AdminProtect(1);
    show_dialog(playerid, d_teleport, DIALOG_STYLE_LIST, !"���� ������������", "\
	{cccccc}1. {ffffff}������ �����\n\
	{cccccc}2. {ffffff}�������� � ����\
	", !"�������", !"������");
	return true;
}
CMD:setadmin(playerid, params[])
{
	AdminProtect(6);
	if(sscanf(params, "ui", params[0], params[1])) return server_error(playerid, "�����������: /setadmin [���/��] [������� �� 1 �� 4 (0 - �����)]");
	if(params[1] > 4 || params[1] < 0) return server_error(playerid, "������� �� ����� ���� ������ 1 � ������ 4!");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	new str_sql[156];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `admin_name` = '%s' LIMIT 1", users[params[0]][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		if(params[1] == 0)
		{	
			m_format(str_sql, sizeof(str_sql), "DELETE FROM "TABLE_ADMIN" WHERE `admin_name` = '%s'", users[params[0]][u_name]);
			m_query(str_sql);
			SCMG(params[0], "%s ���� ��� � ����� ����������.", users[playerid][u_name]);
			SCMG(playerid, "�� ����� �������������� %s � ����� ����������.", users[params[0]][u_name]);
			admin[params[0]][admin_dostup] = 0;
			admin[params[0]][u_a_level] = 0;
			server_error(playerid, "��� ����� � ����� ����������.");

			static str_logs[96];
			format(str_logs, sizeof(str_logs), "������������� ���� ������ %s � ����� ��������������.", users[params[0]][u_name]);
			logs_admin(playerid, str_logs, "/setadmin");
		}
		else 
		{
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_level` = '%i' WHERE `admin_name` = '%s'", params[1], users[params[0]][u_name]);
			m_query(str_sql);
			if(admin[params[0]][admin_dostup] != 0) admin[params[0]][u_a_level] = params[1];
			SCMG(params[0], "%s ������� ��� ������� ����������������� �� %s.", users[playerid][u_name], admin_name_rank[params[1]-1]);
			SCMG(playerid, "�� �������� ��� %s ������� ����������������� �� %s.", users[params[0]][u_name], admin_name_rank[params[1]-1]);

			static str_logs[96];
			format(str_logs, sizeof(str_logs), "������� ������� ����������������� ��� %s �� %i �������.", users[params[0]][u_name], params[1]);
			logs_admin(playerid, str_logs, "/setadmin");
		}
	}
	else 
	{
		m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_ADMIN" (`admin_name`, `u_a_level`, `u_a_owner`, `u_a_data`) VALUES ('%s', '%i', '%s', NOW())", users[params[0]][u_name], params[1], users[playerid][u_name]);
		m_query(str_sql);
		SCMG(params[0], "%s �������� ��� �� ���� %s.", users[playerid][u_name], admin_name_rank[params[1]-1]);
		server_accept(params[0], "����������� /alogin ��� ����������� � ���������������� ������.");
		SCMG(playerid, "�� ��������� %s �� ���� %s.", users[params[0]][u_name], admin_name_rank[params[1]-1]);

		static str_logs[96];
		format(str_logs, sizeof(str_logs), "�������� ������ %s �� ���� �������������� %i ������.", users[params[0]][u_name], params[1]);
		logs_admin(playerid, str_logs, "/setadmin");
	}
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/setadmin", 300);
	return true;
}
CMD:asetcolor(playerid, params[])
{
	AdminProtect(6);
	if(sscanf(params, "ui", params[0], params[1]))
	{
		server_error(playerid, "�����������: /asetcolor [���/��] [����� �����]");
		callcmd::acolors(playerid);
		return true;
	}
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������."); 
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	if(params[1] < 1 || params[1] > sizeof(prefix_colors)) return SCMASS(playerid, "������ ���������� ���� ������ 1 � ������ %i", sizeof(prefix_colors));
	if(admin[params[0]][admin_dostup] != 1) return SCMASS(playerid, "����� %s �� ��������� � ����� ������.", users[params[0]][u_name]);
	format(admin[params[0]][admin_color], 20, prefix_colors[params[1]-1][1]);
	static str_sql[156];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_color` = '%s' WHERE `admin_name` = '%s'", prefix_colors[params[1]-1][1], users[params[0]][u_name]);
	m_query(str_sql);
	AdminChatF("[A] %s %s ������� ���� �������������� %s �� {%s}%s", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], prefix_colors[params[1]-1][1], prefix_colors[params[1]-1][0]);
	server_accept(playerid, "�� ������� ���� ��������������");
	return true;
}
CMD:acolors(playerid)
{
	AdminProtect(6);
	new str[96];
	global_string[0] = EOS;
	strcat(global_string, "�����\t����\n");
	for(new i = 0; i < sizeof(prefix_colors); i++)
	{
		format(str, sizeof(str), "%i\t{%s}%s\n", i+1, prefix_colors[i][1], prefix_colors[i][0]);
		strcat(global_string, str);
	}
	show_dialog(playerid, d_none, DIALOG_STYLE_TABLIST_HEADERS, !"������� ������", global_string, !"�������", !"");
	return true;
}
CMD:reloot(playerid, params[])
{
	AdminProtect(6);
	if(sscanf(params, "i", params[0])) return server_error(playerid, "�����������: /reloot [����� � �������]");
	if(params[0] < 1 || params[0] > TimeForReLoot) return SCMASS(playerid, "����� ������ ���� �� 1 �� %i �����.", TimeForReLoot);
	ReLootTime = params[0];
	SCMG(playerid, "�� �������� ����� ������, ����� ����� %i �����(�) ( ����� +- )", params[0]);
	
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "������� ����� ������ �� %i", params[0]);
	logs_admin(playerid, str_logs, "/reloot");
	AntiFloodCommands(playerid, "/reloot");

	AdminChatF("[A] %s %s ������� ����� ������, ����� ����� %i �����(�)", AdminRankName(playerid), users[playerid][u_name], params[0]);
	return true;
}
CMD:asetrank(playerid, params[])
{
	AdminProtect(6);
	if(sscanf(params, "us[40]", params[0], params[1])) return server_error(playerid, "�����������: /asetrank [���/��] [����� �������� �����]");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	if(admin[params[0]][admin_dostup] != 1) return SCMASS(playerid, "����� %s �� ��������� � ����� ������.", users[params[0]][u_name]);
	format(admin[params[0]][admin_rank], 40, params[1]);
	static str_sql[156];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_name` = '%s' WHERE `admin_name` = '%s'", params[1], users[params[0]][u_name]);
	m_query(str_sql);
	AdminChatF("[A] %s %s ������� �������� ����� �������������� %s �� %s", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], admin[playerid][admin_rank]);
	server_accept(playerid, "�� ������� ���� ��������������");
	return true;
}
CMD:afreezeoff(playerid, params[])
{
	AdminProtect(6);
	static str[24];
	if(sscanf(params, "us[2]s[128]", params[0], str, params[2])) return server_error(playerid, "�����������: /afreezeoff [���/��] [+/-] [�������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `admin_name` = '%s' LIMIT 1", users[params[0]][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r)
	{
		static freeze;
		// cache_get_value_name_int(0, "u_a_reprimand", reprimand);
		cache_get_value_name_int(0, "admin_block", freeze);
		if(!strcmp(str, "+", false))
		{
			if(freeze > 0)
			{
				server_error(playerid, "������������� ��� ��������� � ���������������� ������.");
				cache_delete(temp_sql);
				return true;
			}
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_block` = '1' WHERE `admin_name` = '%s'", users[params[0]][u_name]);
			m_query(str_sql);
			AdminChatF("[A] %s %s ��������� �������������� %s[%i]. �������: %s.", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);

			static str_logs[128];
			format(str_logs, sizeof(str_logs), "��������� �������������� %s. �������: %s", users[params[0]][u_name], params[2]);
			logs_admin(playerid, str_logs, "/afreezeoff");

			SCMG(playerid, "�� ���������� �������������� %s(%i).", users[params[0]][u_name], params[0]);
			callcmd::alogin(params[0]);
		}
		if(!strcmp(str, "-", false))
		{
			if(freeze < 1)
			{
				server_error(playerid, "������������� ��� ���������� � ���������������� ������.");
				cache_delete(temp_sql);
				return true;
			}
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `admin_block` = '0' WHERE `admin_name` = '%s'", users[params[0]][u_name]);
			m_query(str_sql);
			AdminChatF("[A] %s %s ���������� �������������� %s[%i]. �������: %s.", AdminRankName(playerid), users[playerid][u_name], users[params[0]][u_name], params[0], params[2]);
			
			static str_logs[128];
			format(str_logs, sizeof(str_logs), "���������� �������������� %s. �������: %s", users[params[0]][u_name], params[2]);
			logs_admin(playerid, str_logs, "/afreezeoff");

			SCMG(playerid, "�� ����������� �������������� %s(%i).", users[params[0]][u_name], params[0]);
			callcmd::alogin(params[0]);
		}
	}
	else SCMASS(playerid, "����� %s �� �������������.", users[params[0]][u_name]);
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/afreezeoff");
	return true;
}
CMD:makeadmin(playerid, params[])
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params, "ui", params[0], params[1])) return server_error(playerid, "�����������: /makeadmin [���/��] [������� �� 1 �� 6 (0 - �����)]");
	if(params[1] > 7 || params[1] < 0) return server_error(playerid, "������� �� ����� ���� ������ 1 � ������ 7!");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
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
			SCMG(params[0], "%s ���� ��� � ����� ����������.", users[playerid][u_name]);
			SCMG(playerid, "�� ����� �������������� %s � ����� ����������.", users[params[0]][u_name]);
			admin[params[0]][u_a_dostup] = 0;
			admin[params[0]][u_a_level] = 0;
			server_error(playerid, "��� ����� � ����� ����������.");
			
		}
		else 
		{
			m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_level` = '%i' WHERE `u_a_name` = '%s'", params[1], users[params[0]][u_name]);
			m_query(str_sql);
			SCMG(params[0], "%s ������� ��� ������� ����������������� �� %s.", users[playerid][u_name], admin_name_rank[params[1]-1]);
			SCMG(playerid, "�� �������� ��� %s ������� ����������������� �� %s.", users[params[0]][u_name], admin_name_rank[params[1]-1]);
		}
	}
	else 
	{
		m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_ADMIN" (`u_a_name`, `u_a_level`, `u_a_owner`, `u_a_data`) VALUES ('%s', '%i', '%s', NOW())", users[params[0]][u_name], params[1], users[playerid][u_name]);
		m_query(str_sql);
		SCMG(params[0], "%s �������� ��� �� ���� %s.", users[playerid][u_name], admin_name_rank[params[1]-1]);
		server_accept(params[0], "����������� /alogin ��� ����������� � ���������������� ������.");
		SCMG(playerid, "�� ��������� %s �� ���� %s.", users[params[0]][u_name], admin_name_rank[params[1]-1]);
	}
	cache_delete(temp_sql);
	AntiFloodCommands(playerid, "/makeadmin");
	return true;
}
CMD:givegun(playerid, params[]) 
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params,"uii", params[0], params[1], params[2])) 
	{
		server_error(playerid, "�����������: /givegun [���/��] [weaponid] [ammo]");
		SendClientMessage(playerid, COLOR_GREY, "2(������ ��� ������) 3(�������) 4(���) 5(����) 6(������) 7(���) 8(������) 9(����) 10-13(�������������) 14(�����)");
		SendClientMessage(playerid, COLOR_GREY, "16(�������) 17(������� �����) 18(�������� ��������) 22(��������) 23(�������� � ����������) 24(��������� ���) ");
		SendClientMessage(playerid, COLOR_GREY, "25(��������) 26(�����) 27(������ ��������) 28(Uzi) 29(MP5) 30(AK-47) 31(M4) 32(TEC-9) 33(��������) 34(���������)");
		SendClientMessage(playerid, COLOR_GREY, "37(������) 41(���������) 42(������������) 43(�����������) 46(�������)");
		return 1; 
	}
	switch(params[1])
	{
	case 35..38, 44, 45: return server_error(playerid, "��� ������ ���������!");
	}
	if(params[2] < 1 || params[2] > 500) return server_error(playerid, "���-�� �������� ����� �������� �� 1 �� 500");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(observation[params[0]][observation_id] != -1) return server_error(playerid, "������ ����� � ������ ����������.");
	ServerGivePlayerWeapon(params[0], params[1], params[2]);
	AdminChatF("[A] %s %s ����� ������ %i � %i ������ ������ %s[%i].", AdminRankName(playerid), users[playerid][u_name], params[1], params[2], users[params[0]][u_name], params[0]);
	SCMG(params[0], "������������� %s ����� ��� ������ %i � %i ������.", users[playerid][u_name], params[1], params[2]);
	
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "����� ������ ������ %s (GUN: %i, AMMO: %i)", users[params[0]][u_name], params[1], params[2]);
	logs_admin(playerid, str_logs, "/givegun");
	AntiFloodCommands(playerid, "/givegun", 120);
	return 1; 
}
CMD:offadmins( playerid )
{
	AdminProtect(1);
	new Cache:temp_sql = m_query("SELECT * FROM `users_admins` WHERE 1"), rows, count = 0;
    cache_get_row_count(rows);
	if(rows) 
	{
		global_string [ 0 ] = EOS ;
		new str[128], name[MAX_PLAYER_NAME], hide, level, last_online[MAX_PLAYER_NAME];
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name_int(idx-1, "admin_hide", hide);
			if(hide) continue;
			count++;
			cache_get_value_name(idx-1, "admin_name", name, MAX_PLAYER_NAME);
			cache_get_value_name_int(idx-1, "admin_level", level);
			cache_get_value_name(idx-1, "admin_lastlogin", last_online, MAX_PLAYER_NAME);
			format(str, sizeof(str), "%i. ���: %s, �������: %i, ���� ���������� ������: %s\n", count, name, level, last_online);
			strcat(global_string, str);
		}
		show_dialog ( playerid, d_none, DIALOG_STYLE_MSGBOX, !"������ �������������", global_string, !"��", !"" ) ;
	}
	else server_error(playerid, "������������� �� �������.");
	cache_delete(temp_sql);
 	return 1;
}
CMD:anticheat(playerid)
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
    pAntiCheatSettingsPage{playerid} = 1; // ����������� ����������, �������� ����� ��������, �� ������� ��������� �����, �������� 1 (�.�, ������ ����� �� 1-�� ��������)
    return ShowPlayer_AntiCheatSettings(playerid); // ���������� ����� ������� ������ �������� ����-����
}
CMD:alldonate(playerid)
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
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
			case 0: format(str, sizeof(str), "{cccccc}%i. {A52A2A}�������� {ffffff}| {cccccc} ���: %s {ffffff}| {cccccc}�����: %i {ffffff}| {cccccc}����: %s\n", idx, info_ip, summa, info_date);
			case 1: format(str, sizeof(str), "{cccccc}%i. {33AA33}������� {ffffff}| {cccccc} ���: %s {ffffff}| {cccccc}�����: %i {ffffff}| {cccccc}����: %s\n", idx, info_ip, summa, info_date);
			}
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"���������� � �������", global_string, !"��", !"");
	}
	else server_error(playerid, "������� ���.");
	cache_delete(temp_sql);
	return true;
}
CMD:setworld(playerid, params[])
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params,"uii", params[0], params[1], params[2])) return server_error(playerid, "�����������: /setworld [���/��] [���] [���]");
	if(!admin[playerid][admin_fulldostup] && admin[params[0]][admin_protection]) return server_error(playerid, "������������� �������.");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	SetPVarInt(playerid, "OldVirtualWorld", GetPlayerVirtualWorld(params[0]));
	SetPVarInt(playerid, "OldVirtualWorld2", GetPlayerInterior(params[0]));
	SetPlayerVirtualWorld(params[0], params[1]);
	SetPlayerInterior(params[0], params[2]);
	static str[256];
	format(str, sizeof(str), "{33AA33}�� ������� ��� � �������� ��� ������ {cccccc}%s(%i)\n\n{ffffff}������ ���: {cccccc}%i{ffffff}, ������ ��������: {cccccc}%i\n{ffffff}����� ���: {cccccc}%i{ffffff}, ����� ��������: {cccccc}%i", 
	users[params[0]][u_name], params[0], GetPVarInt(playerid, "OldVirtualWorld"), GetPVarInt(playerid, "OldVirtualWorld2"), params[1], params[2]);
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "setworld", str, "��", "");

	static str_logs[196];
	format(str_logs, sizeof(str_logs), "��������� ����� ����. ��� %i � ���. %i ��� ������ %s (Old world: %i, Old int: %i)", params[1], params[2], users[params[0]][u_name], GetPVarInt(playerid, "OldVirtualWorld"), GetPVarInt(playerid, "OldVirtualWorld2"));
	logs_admin(playerid, str_logs, "/setworld");

	DeletePVar(playerid, "OldVirtualWorld");
	DeletePVar(playerid, "OldVirtualWorld2");
	return true;
}
CMD:getworld(playerid, params[])
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params,"u", params[0])) return server_error(playerid, "�����������: /getworld [���/��]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(GetPlayerState(params[0]) == PLAYER_STATE_SPECTATING && observation[params[0]][observation_id] != INVALID_PLAYER_ID) return server_error(playerid, "������������� � ������ ����������.");
	SCMG(playerid, "���: {cccccc}%s(%i) {fffff0}| ���: {cccccc}%i {fffff0}| ��������: {cccccc}%i", users[params[0]][u_name], params[0], GetPlayerVirtualWorld(params[0]), GetPlayerInterior(params[0]));
	return true;
}
CMD:lootname(playerid)
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	global_string[0] = EOS;
	new str[96];
	strcat(global_string, "����� ��������\t�������� ��������\n");
	for(new slot = 1; slot < max_items; slot++) 
	{
		format(str, sizeof(str), "%i\t%s\n", slot, loots[slot][loot_name]);
		strcat(global_string, str);
	}
	show_dialog(playerid, d_none, DIALOG_STYLE_TABLIST_HEADERS, "{FFA07A}�������� "FULL_NAME"", global_string, !"�������", !"");
	return true;
}
CMD:loot(playerid, params[]) 
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params,"ii", params[0], params[1])) 
	{
		server_error(playerid, "�����������: /loot [����� ��������] [���-��]");
		server_error(playerid, "��� ��������� ������� ������ ���������, ������� /lootname");
		return 1; 
	}
	if(params[0] < 1 || params[0] > max_items-1) return SCMASS(playerid, "ID ���� �� 1 �� %i!", max_items-1);
	if(params[1] < 1 || params[1] > 5) return server_error(playerid, "���-�� �� 1 �� 5!");
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
	if(!admin[playerid][admin_hide]) AdminChatF("[A] %s %s ������ ������� %s � ����������� %i �� (%f, %f, %f).", AdminRankName(playerid), users[playerid][u_name], loots[params[0]][loot_name], params[1], l_c[0], l_c[1], l_c[2]);
	static str_logs[96];
	format(str_logs, sizeof(str_logs), "������ ������� %s(%i) � ���-�� %i", loots[params[0]][loot_name], params[0], params[1]);
	logs_admin(playerid, str_logs, "/loot");
	return true; 
}

CMD:amoney(playerid, params[])
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params, "uii", params[0], params[1], params[2])) return server_error(playerid, "�����������: /amoney [���/��] [0/1] [������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	switch(params[1])
	{
	case 0:
		{
			if(users[params[0]][u_money] < params[2]) return server_error(playerid, "� ������ ������ �����.");
			// users[params[0]][u_money] -= params[2];
			money(params[0], "-", params[2]);
			SCMG(playerid, "�� ������� %i ����� � ������ %s(%i)", params[2], users[params[0]][u_name], params[0]);
			// SaveUser(params[0], "money");
		}
	case 1:
		{
			if(params[2] < 1 || params[2] > 1000000) return server_error(playerid, "������ �������� ������ 1 � ������ 1.000.000$.");
			// users[params[0]][u_money] += params[2];
			money(params[0], "+", params[2]);
			SCMG(playerid, "�� ������ %i ����� ������ %s(%i)", params[2], users[params[0]][u_name], params[0]);
			// SaveUser(params[0], "money");
		}
	}
	return true;
}
CMD:adonat(playerid, params[])
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params, "uii", params[0], params[1], params[2])) return server_error(playerid, "�����������: /adonat [���/��] [0/1] [������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	switch(params[1])
	{
	case 0:
		{
			static str_sql[128];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`-'%i' WHERE `u_id` = '%i' LIMIT 1", params[2], users[params[0]][u_id]);
			m_query(str_sql);
			SCMG(playerid, "�� ������� %i ����� � ������ %s(%i)", params[2], users[params[0]][u_name], params[0]);
		}
	case 1:
		{
			static str_sql[128];
			m_format(str_sql, sizeof(str_sql),"UPDATE "TABLE_USERS" SET `u_donate` = `u_donate`+'%i' WHERE `u_id` = '%i' LIMIT 1", params[2], users[params[0]][u_id]);
			m_query(str_sql);
			SCMG(playerid, "�� ������ %i ������ ������ %s(%i)", params[2], users[params[0]][u_name], params[0]);
		}
	}
	return true;
}
CMD:setclan(playerid, params[])
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params, "ui", params[0], params[1])) return server_error(playerid, "�����������: /setclan [���/��] [����]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	users[params[0]][u_clan] = params[1];
	SCMG(playerid, "�� ������ ������ %s � ���� %i.", users[params[0]][u_name], params[1]);
	return true;
}
CMD:setrank(playerid, params[])
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	if(sscanf(params, "ui", params[0], params[1])) return server_error(playerid, "�����������: /setrank [���/��] [����]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	users[params[0]][u_clan_rank] = params[1];
	SCMG(playerid, "�� �������� ���� ������ %s �� %i.", users[params[0]][u_name], params[1]);
	return true;
}
CMD:setcoords(playerid, params[])
{
	if(!admin[playerid][admin_fulldostup]) return server_error(playerid, "������ ���������.");
	static Float: coords[3];
	if(sscanf(params, "p<,>fff", coords[0], coords[1], coords[2])) return server_error(playerid, "�����������: /setcoords x, y, z");
	SetPlayerPos(playerid, coords[0], coords[1], coords[2]);
	SCMG(playerid, "�� ����������������� �� ����������: %f, %f, %f ", coords[0], coords[1], coords[2]);
	return true;
}