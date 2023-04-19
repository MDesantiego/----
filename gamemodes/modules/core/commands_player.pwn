public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if(PlayerIsOnline(playerid)) return server_error(playerid, "�� �� ������������."), false;
	if(GetPVarInt(playerid, "AntiFloodCommands") > gettime()) return server_error(playerid, "�� ����� ���������!"), false;
	SetPVarInt(playerid,"AntiFloodCommands", gettime() + 1);
	return 1 ;
}
public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if(result == -1) return server_error(playerid, "������ ������� �� ����������. ����������� {cccccc}/cmd{ffffff}, ����� ������ ������ ������ �������.");	
    return 1;
}
//������:
alias:opengate("og");
alias:whisper("w");
alias:shout("s");
alias:commands("cmd", "command");
alias:menu("mn", "mm", "mainmenu");
alias:pbase("pbaze", "panelbase");
alias:craft("crafting");
alias:report("rep");
alias:animation("anim");
//�������:
CMD:craft(playerid)
{
	show_dialog(playerid, d_craft, DIALOG_STYLE_LIST, !"������������", !"\
	{cccccc}1. {fffff0}���������� �����\n\
	{cccccc}2. {fffff0}�������� �����\n\
	{cccccc}3. {fffff0}����������� ������\n\
	{cccccc}4. {fffff0}�������\n\
	{cccccc}5. {fffff0}�����������\n\
	{87CEEB}����������", !"����������", !"�������");
	return true;
}
	// {cccccc}6. {fffff0}���������\n

CMD:report(playerid) 
{
	global_string [ 0 ] = EOS ;
	strcat(global_string, "{ffffff}�� ����������� �������� ��������� �������������.\n");
	strcat(global_string, "����� ��� ��� ��������� ��������� ���������,\n");
	strcat(global_string, "��� �� ���� �� ������� ������ �� ��� ��� ������ �� ��� ������.\n\n");
	strcat(global_string, "{AA3333}���������:\n");
	strcat(global_string, "1. ����, �����������, ������\n");
	strcat(global_string, "2. ������� (����� �����, ����� �������, ����� �����..)\n");
	strcat(global_string, "3. ������ ���������\n\n");
	strcat(global_string, "{DF4F4F}�� ��������� ������ ������������� �����: \n");
	strcat(global_string, "1. ������������\n");
	strcat(global_string, "2. ������� � �������\n");
	strcat(global_string, "3. ������������� �������\n\n");
	strcat(global_string, "{65C360}�������!\n");
	strcat(global_string, "�� ������ ������ ������ ���� �� ���������� �������.\n");
	strcat(global_string, "������ ������� ����������� ��� ���� ������� "FULL_NAME"\n\n");
	strcat(global_string, "{ffffff}���� ��� ����� �� ��������, ��������� ���� �����.\n");
	strcat(global_string, "{ffffff}������� �� ���������, � ��������� �������������.\n\n");
	show_dialog(playerid, d_report, DIALOG_STYLE_INPUT, !"��������� ��� �������������", global_string, !"���������", !"������");
	return true; 
}
CMD:pbase(playerid)
{
	// if(BaseGateOpen[playerid]) BaseGateOpen[playerid] = 0;
	for(new z = 0; z < sizeof(base); z++) BaseMenuList[playerid][z] = 0;
	new count_, str[96];
	count_ = 0;
	global_string[0] = EOS;
	for(new i = 1; i < base_count; i++)
	{
		if(base[i][b_owner_id] != users[playerid][u_id]) continue; 
		count_++;
		BaseMenuList[playerid][count_-1] = i;
		format(str, sizeof(str), "{cccccc}%i. {fffff0}���� �%i\n", count_, i);
		strcat(global_string, str);
		// BaseGateOpen[playerid] = i;
	}
	if(!count_) return server_error(playerid, "�� �� �������� �����!");
	show_dialog(playerid, d_base_menu, DIALOG_STYLE_LIST, "����", global_string, !"�������", !"�������");
	return true;
}
CMD:opengate(playerid)
{
	if(BaseGateOpen[playerid]) BaseGateOpen[playerid] = 0;
	for(new i = 1; i < base_count; i++)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 7.0, base[i][b_coords_gate][0], base[i][b_coords_gate][1], base[i][b_coords_gate][2])) continue;
		BaseGateOpen[playerid] = i;
	}
	new b = BaseGateOpen[playerid];
	if(!b) return server_error(playerid, "� ����� 7 ������ �� ��� ��� ������� �����.");
	if(base[b][b_gate_open_number] && base[b][b_gate_open]) return server_error(playerid, "��������� ���� ��������� ������.");
	if(FullDostup(playerid))
	{
		base[b][b_gate_open] = true;
		base[b][b_gate_open_number] = b;
		SetTimerEx("@base_gate", 10000, false, "i", base[b][b_gate_open_number]);
		temp[playerid][BaseGuardGate] = b;
		MoveDynamicObject(base[b][b_gate], base[b][b_coords_gate_interactions][0], base[b][b_coords_gate_interactions][1], base[b][b_coords_gate_interactions][2], 3);
	}
	else 
	{
		if(!base[b][b_owner_id]) return server_error(playerid, "� ���� ��� ���������!");
		switch(base[b][b_lock_status])
		{
		case 0: show_dialog(playerid, d_base_password, DIALOG_STYLE_INPUT, "������", "\n������� ������ �� ����� ����\n\n", !"����", !"�������");
		default:
			{
				if(base[b][b_lock_status] != users[playerid][u_clan]) return server_error(playerid, "�������� ���� �� � ����� �����!");
				base[b][b_gate_open] = true;
				base[b][b_gate_open_number] = b;
				SetTimerEx("@base_gate", 10000, false, "i", base[b][b_gate_open_number]);
				MoveDynamicObject(base[b][b_gate], base[b][b_coords_gate_interactions][0], base[b][b_coords_gate_interactions][1], base[b][b_coords_gate_interactions][2], 3);
			}
		}
	}
	return true;
}
CMD:clan(playerid)
{
	if(!users[playerid][u_clan] || !users[playerid][u_clan_rank])
	{
		server_error(playerid, "�� �� �������� � �����!");
		show_dialog(playerid, d_clan_money, DIALOG_STYLE_MSGBOX, !"���� �����", "� ��� ��� �����! ������ ������� ����?\n��������� �������� ����� 2.000.000 ��� 200 ������ � /donate", !"��", !"���");
		return true;
	}
	new str_sql[96];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_CLAN" WHERE `c_id` = '%i' LIMIT 1", users[playerid][u_clan]);
	new Cache:temp_sql_1 = m_query(str_sql), rows;
//	new clan_status[3], clan_status_name[2][MAX_PLAYER_NAME];
	static spawn_status;
	cache_get_row_count(rows);
	cache_get_value_name_int(0, "c_skin", clan[users[playerid][u_clan]][c_skin]);
	cache_get_value_name_int(0, "c_rank_zam", clan[users[playerid][u_clan]][c_rank_zam]);
	cache_get_value_name(0, "c_name", clan[users[playerid][u_clan]][c_name], MAX_PLAYER_NAME);
	cache_get_value_name(0, "c_owner", clan[users[playerid][u_clan]][c_owner], MAX_PLAYER_NAME);
	cache_get_value_name(0, "c_name_abbr", clan[users[playerid][u_clan]][c_name_abbr], MAX_PLAYER_NAME);
	cache_get_value_name_int(0, "c_reprimand", clan[users[playerid][u_clan]][c_reprimand]);
	cache_get_value_name_int(0, "c_change_spawn", spawn_status);
	cache_delete(temp_sql_1);

	if(clan[users[playerid][u_clan]][c_reprimand] > 2 && !strcmp(users[playerid][u_name], clan[users[playerid][u_clan]][c_owner], false))
	{
		server_error(playerid, "� ������ ����� 3 �� 3 ���������. ����� ��������, ��� ���� ��������!");
		server_error(playerid, "� ������ ����� 3 �� 3 ���������. ����� ��������, ��� ���� ��������!");
	}
	new str[96], str_two[MAX_PLAYER_NAME];
	global_string [ 0 ] = EOS ;
	strcat(global_string, "������\t������\n");
	strcat(global_string, "{cccccc}1. {ffffff}���������� �����\n");
	strcat(global_string, "{cccccc}2. {ffffff}������ �����������\t{ADD8E6}������\n");
	if(clan[users[playerid][u_clan]][c_rank_zam] > users[playerid][u_clan_rank]) strcat(global_string, "{cccccc}3. {ffffff}�������� ����");
	if(clan[users[playerid][u_clan]][c_rank_zam] <= users[playerid][u_clan_rank])
	{
		strcat(global_string, "{cccccc}3. {ffffff}������� � ����\n");
		strcat(global_string, "{cccccc}4. {ffffff}������� �� �����\n");
		strcat(global_string, "{cccccc}5. {ffffff}�������� ���� ����������\n");
		strcat(global_string, "{cccccc}6. {ffffff}�������� �������� ������\n");
		format(str_two, sizeof(str_two), "�%i", clan[users[playerid][u_clan]][c_skin]);
		format(str, sizeof(str), "{cccccc}7. {ffffff}������� ������ �����\t{ADD8E6}%s\n", (!clan[users[playerid][u_clan]][c_skin])?("{A52A2A}���"):(str_two));
		strcat(global_string, str);
		if(strcmp(users[playerid][u_name], clan[users[playerid][u_clan]][c_owner], false)) strcat(global_string, "{cccccc}8. {ffffff}�������� ����");
	}
	if(!strcmp(users[playerid][u_name], clan[users[playerid][u_clan]][c_owner], false))
	{
		format(str, sizeof(str), "{cccccc}8. {ffffff}��������� ���� ��� ����������\t{ADD8E6}����: %i\n", clan[users[playerid][u_clan]][c_rank_zam]);
		strcat(global_string, str);
		format(str, sizeof(str), "{cccccc}9. {ffffff}������� �������� �����\t{ADD8E6}%s\n", clan[users[playerid][u_clan]][c_name]);
		strcat(global_string, str);
		format(str_two, sizeof(str_two), "%s", clan[users[playerid][u_clan]][c_name_abbr]);
		format(str, sizeof(str), "{cccccc}10. {ffffff}������� ������������ �����\t{ADD8E6}%s\n", (!strcmp("NoNameAbbreviatur", clan[users[playerid][u_clan]][c_name_abbr]))?("{A52A2A}���"):(str_two));
		strcat(global_string, str);
		format(str, sizeof(str), "{cccccc}11. {ffffff}���������� ����� ����� ������\t%s\n", (!spawn_status)?(" "):("{A52A2A}�� ��������"));
		strcat(global_string, str);
		strcat(global_string, "{cccccc}12. {ffffff}�������������� ����\n");
		strcat(global_string, "{cccccc}13. {ffffff}������� ����");
	}
	show_dialog(playerid, d_clan, DIALOG_STYLE_TABLIST_HEADERS, !"���� �����", global_string, !"�������", !"�������");
	return true;
}
/*CMD:donate(playerid)
{
	new query[128];
   	m_format(query, sizeof(query), "SELECT SUM(sum) FROM `freekassa_payments` WHERE `account` = '%s' AND `status` = '1'", users[playerid][u_name]);
	new Cache:result = m_query(query), rows, count_money;
  	cache_get_row_count(rows);
  	if(rows > 0) cache_get_value_index_int(0, 0, count_money);
   	cache_delete(result);
   	static const size_str[] = "\
   	{FFFFFF}� ���� ������� �� ������� ������������ ��������������\n\
   	����������� �������. �������� ���� ��������������\n\
	������������, � ����� � �������� ���������� ����� �� ������\n\
	������ �� �����: {66CDAA}"SITE_NAME" � ������� ''���������� �����''.\n\n\
	{20B2AA}����������:\n\
	{FFFFFF}����� ��������: \t\t�%i\n\
	������� ��������� �����:\t%i ������.\n\
	����� ����� ����������:\t%i ������.\n\n\
	������� ��������� ������:\t%i\n";
	new string[sizeof(size_str)+86];
	format(string, sizeof(string), size_str, users[playerid][u_id], get_player_donate(playerid), count_money, get_player_coins(playerid));
	show_dialog(playerid, d_donate_menu, DIALOG_STYLE_MSGBOX, !"�������������� ������", string, !"������", !"�������");
	return 1;
}*/
CMD:donate(playerid)
{
	show_donate(playerid);
	return 1;
}
stock show_donate(playerid)
{
	//if(!get_player_donate ( playerid )) return server_error(playerid, "� ��� ������������ �������� �������."), server_error(playerid, "��������� ���� ����� �� ����� "SITE_NAME"") ;
	static str[96];
	format(str, sizeof(str), "�������������� ������ | {fffff0}������: %i", get_player_donate(playerid));
	show_dialog(playerid, d_donate, DIALOG_STYLE_TABLIST_HEADERS, str, !"�������� ������:\t���������:\n\
	{828282}- {ffffff}������ VIP ������\t{33AA33}150 ������\n\
	{828282}- {ffffff}������� ���� ����\t{33AA33}200 ������\n\
	{828282}- {ffffff}��������� ������� ������\t{33AA33}�� 1 �����\n\
	{828282}- {ffffff}���������� ������ ����\t{33AA33}�� 10 ������\n\
	{828282}- {ffffff}���������� ����\t{33AA33}�� 120 ������\n\
	{828282}- {ffffff}������ ����� ���������\t{33AA33}50 ������\n\
	{828282}- {ffffff}������ ����\t{33AA33}50 ������\n\
	{828282}- {ffffff}��������\t{33AA33}�� 80 ������\n\
	{828282}- {ffffff}����� ��� ����� ����\t{33AA33}5 ������\n\
	{FFD700}�������� ��������", !"�������", !"�������");//
	return 1;
}
// {ADD8E6}����� �������� �������
CMD:pack(playerid)
{
	// if(temp[playerid][TimeUsePack] == -1) return server_error(playerid, "��� ���������� ��� �� ��� ����� �������.");
	if(temp[playerid][TimeUsePack] == 0) return server_error(playerid, "����� ����������� ��� �� ��� ����� �������.");
	static str[400];
	format(str, sizeof(str), "��������:\t����������:\n\
	{828282}- {ffffff}������� ���������\t{cccccc}%i ��.\n\
	{828282}- {ffffff}����������� �������\t{cccccc}%i ��.\n\
	{828282}- {ffffff}����������� �������\t{cccccc}%i ��.\n\
	{828282}- {ffffff}������� �������\t{cccccc}%i ��.\n\
	{828282}- {ffffff}����������� �������\t{cccccc}%i ��.\n\
	{cccccc}���������� � ���������", users[playerid][u_pack][0], users[playerid][u_pack][1], users[playerid][u_pack][2], users[playerid][u_pack][3], users[playerid][u_pack][4]);
	show_dialog(playerid, d_starter, DIALOG_STYLE_TABLIST_HEADERS, !"��������", str, !"�������", !"�������");
	return true;
}
stock get_player_donate(playerid)
{
	new donate_count_money = 0,
		query_string [ 96 ] ;
	m_format ( query_string, sizeof ( query_string ),"SELECT `u_donate` FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1", users[playerid][u_name]);
	new Cache:result = m_query ( query_string ) ;
	cache_get_value_name_int(0, "u_donate", donate_count_money);
	cache_delete ( result ) ;
	return donate_count_money ;
}
stock get_player_coins(playerid)
{
	new donate_count_money = 0,
		query_string [ 96 ] ;
	m_format ( query_string, sizeof ( query_string ),"SELECT `u_coins` FROM "TABLE_USERS" WHERE `u_name` = '%s' LIMIT 1", users[playerid][u_name]);
	new Cache:result = m_query ( query_string ) ;
	cache_get_value_name_int(0, "u_coins", donate_count_money);
	cache_delete ( result ) ;
	return donate_count_money ;
}
CMD:rc(playerid, params[]) 
{
	if(!GetItem(playerid, 53)) return server_error(playerid, "� ��� ��� � ����� �����!");
	if(!users[playerid][u_clan]) return server_error(playerid, "�� �� �������� � �����.");
	if(users[playerid][u_mute]) return SCMASS(playerid, "��� ������������. ��������: %i ������(�).", users[playerid][u_mute]);
	if(sscanf(params, "s[128]", params[0])) return server_error(playerid, "�����������: /rc [���������]");
	static str[156];
	format(str, sizeof(str), "[R][CLAN] %s %s: {ffffff}%s", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name], params[0]);
	clan_message(users[playerid][u_clan], str);
	return 1; 
}
CMD:help(playerid) 
{
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"������", !"\n\n\
	{96c199}��������������� �������:\n\
	{96c199}Y - {a9a884}������� ������ (���������)\n\
	{96c199}�.ALT - {a9a884}��������� ������� (���)\n\
	{96c199}H - {a9a884}������� ���.����, ������� ����, ��������\n\
	{96c199}N - {a9a884}������� ����\n\n\
	{96c199}2 - {a9a884}���� ����������.\n\
	{96c199}Ctrl - {a9a884}�������/��������� ���������.\n\
	{96c199}Num 4 - {a9a884}�������/������� �����.\n\
	{96c199}Num 6 - {a9a884}�������/������� ��������.\n\
	{96c199}L.ALT - {a9a884}��������/��������� ����.", !"�������", !"");
	return 1; 
}
CMD:vip(playerid) 
{
	if(!users[playerid][u_vip_time]) return server_error(playerid, "������ �������� ������ ��� �������. ����� ���������� ����� ������� ''/donate''");
	global_string [ 0 ] = EOS ;
	strcat(global_string, "{cccccc}1. {ffffff}���������� � VIP �������\n");
	strcat(global_string, "{cccccc}2. {ffffff}��������� VIP �������");
	show_dialog(playerid, d_vip, DIALOG_STYLE_LIST, !"VIP ����", global_string, !"�������", !"�������");
	return 1; 
}
CMD:r(playerid, params[]) 
{
	if(!GetItem(playerid, 53)) return server_error(playerid, "� ��� ��� � ����� �����!");
	if(users[playerid][u_mute]) return SCMASS(playerid, "��� ������������. ��������: %i ������(�).", users[playerid][u_mute]);
	if(!users[playerid][u_settings][1]) return server_error(playerid, "�������� ����� ����� � ������ ����������.");
	if(sscanf(params,"s[196]", params[0])) return server_error(playerid, "�����������: /r [���������]");
	static str[356];
	switch(users[playerid][u_settings_vip][0])
	{
	case 0: format(str, sizeof(str), "[�����][%i] %s(%i){ffffff}: %s", users[playerid][u_settings][1], users[playerid][u_name], playerid, params[0]);
	case 1: format(str, sizeof(str), "[�����][%i]{FFD700}[VIP] {007AEB}%s(%i){ffffff}: %s", users[playerid][u_settings][1], users[playerid][u_name], playerid, params[0]);
	}
	foreach(Player, i)
	{
		if(!GetItem(i, 53)) continue;
		if(users[playerid][u_settings][1] != users[i][u_settings][1]) continue;
		SendClientMessage(i, 0x007AEBFF, str);
	}
	return 1; 
}
CMD:pm(playerid, params[]) 
{
	if(users[playerid][u_mute]) return SCMASS(playerid, "��� ������������. ��������: %i ������(�).", users[playerid][u_mute]);
	if(sscanf(params,"ds[128]", params[0], params[1])) return server_error(playerid, "�����������: /pm [���/��] [���������]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(users[params[0]][u_settings][0]) return server_error(playerid, "����� �������� ������ ��� ������ ���������.");
	static str[256];
	if(params[0] == playerid) 
	{
		format(str, sizeof(str), " {ffffff}%s {8effa9}�������� ���-�� ���� ��� ���.", users[playerid][u_name]);
		ProxDetector(playerid, 5.0, str, COLOR_LILAC, COLOR_LILAC, COLOR_LILAC, COLOR_LILAC, COLOR_LILAC);
		return true; 
	}
	switch(users[playerid][u_settings_vip][0])
	{
	case 0: format(str, sizeof(str), "[��] �� %s(%i){ffffff}: %s", users[playerid][u_name], playerid, params[1]);
	case 1: format(str, sizeof(str), "[��]{FFD700}[VIP] {ffff99}�� %s(%i){ffffff}: %s", users[playerid][u_name], playerid, params[1]);
	}
	SendClientMessage(params[0], COLOR_LIGHTYELLOW, str);
	PlayerPlaySound(params[0], 1052, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SCMG(playerid, "{e5e5e5}�� ��������� �� {feffe6}%s(%d): {e1e0b5}%s", users[params[0]][u_name], params[0], params[1]);
	return 1; 
}
CMD:campfire(playerid)
{
	DeletePVar(playerid, "CAMPFIRE_USER");
	for(new fz = 0; fz < MAX_FIRE; fz++)
	{
		if(!IsPlayerInRangeOfPoint(playerid, 1.5, fire[fz][fire_xyz][0], fire[fz][fire_xyz][1], fire[fz][fire_xyz][2])) continue;
		SetPVarInt(playerid, "CAMPFIRE_USER", fz);
		break;
	}
	if(!GetPVarInt(playerid, "CAMPFIRE_USER")) return server_error(playerid, "����� � ���� ��� ������.");
	if(!IsPlayerInRangeOfPoint(playerid, 1.5, fire[GetPVarInt(playerid, "CAMPFIRE_USER")][fire_xyz][0], fire[GetPVarInt(playerid, "CAMPFIRE_USER")][fire_xyz][1], fire[GetPVarInt(playerid, "CAMPFIRE_USER")][fire_xyz][2])) return server_error(playerid, "�� ������ ��������� ����� ������.");
	if(!fire[GetPVarInt(playerid, "CAMPFIRE_USER")][fire_time]) return server_error(playerid, "������ �����.");
	show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "������", !"\
	��������� ����� ������\n\
	{8FBC8F}| {fffff0}�������� ����\n\
	{8FBC8F}| {fffff0}����������� ����\n\
	{AFEEEE}| {fffff0}�������� ������", !"�������", !"�������");
	return true;
}
	/*if(GetItem(playerid, 5) && !GetItem(playerid, 125) && !GetItem(playerid, 44)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "������", !"\
	��������� ����� ������\n\
	{8FBC8F}| {fffff0}�������� ����", !"�������", !"�������");
	else if(GetItem(playerid, 5) && GetItem(playerid, 125)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "������", !"\
	��������� ����� ������\n\
	{8FBC8F}| {fffff0}�������� ����\n\
	{8FBC8F}| {fffff0}����������� ����\n\
	{AFEEEE}| {fffff0}�������� ������", !"�������", !"�������");
	else if(GetItem(playerid, 5) && GetItem(playerid, 44)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "������", !"\
	��������� ����� ������\n\
	{8FBC8F}| {fffff0}�������� ����\n\
	{AFEEEE}| {fffff0}�������� ������", !"�������", !"�������");
	else if(!GetItem(playerid, 5) && GetItem(playerid, 44)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "������", !"\
	��������� ����� ������\n\
	{AFEEEE}| {fffff0}�������� ������", !"�������", !"�������");
	else if(!GetItem(playerid, 5) && GetItem(playerid, 125)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "������", !"\
	��������� ����� ������\n\
	{8FBC8F}| {fffff0}����������� ����\n\
	{AFEEEE}| {fffff0}�������� ������", !"�������", !"�������");

	show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "������", !"\
	��������� ����� ������\n\
	{8FBC8F}| {fffff0}�������� ����\n\
	{8FBC8F}| {fffff0}����������� ����\n\
	{AFEEEE}| {fffff0}�������� ������", !"�������", !"�������");
	return true;
}
*/
CMD:rules(playerid)
{
	global_string[0] = EOS;
	strcat(global_string, "{ffffff}");
	strcat(global_string, "�������� ������ �� ����������� �� ���������������!\n");
	strcat(global_string, "����� ����� ������� ������ ��������� ������ �������, � ��������� ������ ����� ������ ���������!\n");
	strcat(global_string, "��������� ������� ������������� � ����� � ����������� ��������� �������������.\n");
	strcat(global_string, "��������� ��������� ����� ����� �� ����� ����� ������� ���������.\n\n");
	strcat(global_string, "1. ���:\n");
	strcat(global_string, "1.1 ��������� ����������� �������/�������������/���������� �����/�����.\n");
	strcat(global_string, "1.2 ��������� ����� ������������� �������, � ��� �� ������������� ������������� ������� (������ ����� ��� ����� ���� ������� ������� ��� ���������).\n");
	strcat(global_string, "1.3 �������� ���� � ����� ���, � ��� �� ���� ��������� �������.\n");
	strcat(global_string, "1.4 ��������� ����� �������/���������� ��������� ��������.\n");
	strcat(global_string, "1.5 ��������� ���������� ��������������� ������� ���������, �� �� 'CAPS LOCK'.\n\n");
	strcat(global_string, "2. �������������� �����������/���������/����/����:\n");
	strcat(global_string, "2.1 ��������� ����� �����������/���������/����/���� ������ ����� ������������ ��� ������� �������� ����.\n");
	strcat(global_string, "2.2 ��������� ����� �����������/���������/����/���� ���������� ������������ ������ �������� ���� � ��� ��������/��������.\n\n");
	strcat(global_string, "3. ���������� IP ������� ������:\n");
	strcat(global_string, "3.1 ��������� ����� ������ ���������� IP ������.\n\n");
	strcat(global_string, "4. ������� �������:\n");
	strcat(global_string, "4.1 ��������� ������ ���� SpawnKill(SK,��), ����� 2 ������� �� ����� ������ ������.\n");
	strcat(global_string, "4.2 ��������� ������� � AFK, �������� �� ���� � ������ ��������� ����� �� ������� ������.\n");
	strcat(global_string, "4.3 ��������� ����� ������������� ����� �������� ����, ����������: ������������ � ��������� ������������� �� ������ �������� ���� �������.\n");
	strcat(global_string, "4.4 ��������� ������ ���� �������� ������ ��� ������ ��� �� ������� ���� � ����� �������� ��� ��������� �����.\n");
	strcat(global_string, "4.5 ��������� �������� ����� ���� �� ��� ������� ������ ������������ � ������� ����.\n\n");
	strcat(global_string, "5. �������������� � ��������������:\n");
	strcat(global_string, "5.1 �������� ����� ������ �������������.\n");
	strcat(global_string, "5.2 ��������� ����� ������������ ���� ���� � �������������.\n");
	strcat(global_string, "5.3 �������� ������ � /report.\n\n");
	strcat(global_string, "6. ������� � ������� �� ������� ������:\n");
	strcat(global_string, "6.1 ���������� ����� ������� ����-���� �� ������� �� ����� ������������� ������� (/donate).\n");
	strcat(global_string, "6.2 ���������� ����� ������� ����-���� �� ������� �� ����� ������������� ������� (/donate).\n\n\n");
	strcat(global_string, "��������� ������ ������ ����� ���������� ����������� ������� � ����� �����!");
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"������� "FULL_NAME"", global_string, !"�������", !"");
	return true;
}
CMD:menu(playerid)
{
	show_dialog(playerid, d_menu, DIALOG_STYLE_LIST, "����", !"\
	{cccccc}1. {87CEEB}���������\n\
	{cccccc}2. {FFFFF0}������� ����������\n\
	{cccccc}3. {87CEEB}��������� ������/������ �������������\n\
	{cccccc}4. {87CEEB}��������� ������������\n\
	{cccccc}5. {FFFFF0}������ ���������\n\
	{cccccc}6. {FFFFF0}��������\n\
	{cccccc}7. {FFFFF0}����������\n\
	{cccccc}8. {FFFFF0}������������\n\
	{cccccc}9. {87CEEB}�������������� ������\n\
	{cccccc}10. {87CEEB}� �������\n\
	{cccccc}11. {FFFFF0}��� ������������ ������", !"�������", !"�������");
	return true;
}
CMD:friends(playerid)
{
	show_dialog(playerid, d_friends, DIALOG_STYLE_LIST, "��� ������������ ������", !"\
	{cccccc}1. {87CEEB}������ ������������ ������\n\
	{cccccc}2. {FFFFF0}������� �� �����������\n\
	{cccccc}����������", !"�������", !"�����");
	return true;
}
/*CMD:testin(playerid, params[])
{
	if(sscanf(params, "i", params[0])) return server_error(playerid, "/testin [�����]");
	if(params[0] < 1 || params[0] > 8) return server_error(playerid, "����� �� 1 �� 8");
	if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "� ���������� ������!");
	switch(params[0])
	{
	case 1: 
		{
			server_message(playerid, "����");
			SetPlayerDrunkLevel(playerid, 5*1000);
			OnePlayAnim(playerid,"GRAVEYARD","mrnF_loop", 4.0, 0, 0, 0, 0, 0);
		}
	case 2: 
		{
			server_message(playerid, "��������");
			OnePlayAnim(playerid, "FOOD", "EAT_Vomit_P", 4.0, 0, 0, 0, 0, 0);
		}
	case 3: 
		{
			server_message(playerid, "���������� ����");
			SetPlayerSpecialAction(playerid, 68);
			OnePlayAnim(playerid, "PAULNMAC", "Piss_in", 4.4, 1, 0, 0, 0, 5000);
		}
	case 4: 
		{
			server_message(playerid, "������������ ������������");
			OnePlayAnim(playerid,"PED","HIT_back", 0.1, 1, 0, 0, 0, 10000);
		}
	case 5: 
		{
			server_message(playerid, "���������");
			OnePlayAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 15000);
		}
	case 6: 
		{
			server_message(playerid, "������");
			OnePlayAnim(playerid,"SCRATCHING","scdrdlp", 4.0, 0, 0, 0, 0, 0);
		}
	case 7: 
		{
			server_message(playerid, "�����");
			SetPlayerDrunkLevel(playerid, 7*1000);
			OnePlayAnim(playerid,"PAULNMAC","PnM_Argue2_A", 4.0, 0, 0, 0, 0, 0);
		}
	case 8: 
		{
			server_message(playerid, "���������");
			OnePlayAnim(playerid,"HEIST9","CAS_G2_GasKO", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return true;
}*/
CMD:needs(playerid)
{
	new format_string[456];
	format(format_string, sizeof(format_string), "{fffff0}�����:\t\t{90EE90}%s {fffff0}%i%%\n�����:\t\t{ADD8E6}%s {fffff0}%i%%\n���������:\t{FFA07A}%s {fffff0}%i%%", 
	PointOfStatus(users[playerid][u_hunger], 100 - users[playerid][u_hunger]), users[playerid][u_hunger], 
	PointOfStatus(users[playerid][u_thirst], 100 - users[playerid][u_thirst]), users[playerid][u_thirst], 
	PointOfStatus(users[playerid][u_infected], 100 - users[playerid][u_infected]), users[playerid][u_infected]);
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "�����������", format_string, !"�������", !"");
	return true;
}
CMD:commands(playerid)
{
	show_dialog(playerid, d_cmd, DIALOG_STYLE_LIST, !"������� �������", !"\
	{cccccc}1. {ffffff}�������� �������\n\
	{cccccc}2. {ffffff}������� ��� ����\n\
	{cccccc}3. {ffffff}������� ��� �����\n\
	{cccccc}4. {ffffff}������� ��� ����\n\
	", !"�������", !"�������");
	return true;
}
CMD:pay(playerid, params[])
{
	if(sscanf(params, "ud", params[0], params[1])) return server_error(playerid, "�����������: /pay [��/���] [�����]");
    if(PlayerIsOnline(params[0])) return server_error(playerid, "����� �� ������������� ��� ����� �����������.");
	if(!users[playerid][u_vip_time])
	{
	    if(params[1] < 1 || params[1] > 10000) return server_error(playerid, "����� ������ ���� �� 1 �� 10000 �� ���.");
	}
	else
	{
	    if(params[1] < 1 || params[1] > 50000) return server_error(playerid, "����� ������ ���� �� 1 �� 50000 �� ���.");
	}
	if(!IsPlayerInRangeOfPlayer(3.0, playerid, params[0])) return server_error(playerid, "�� ������� ������ �� ������");
	if(users[playerid][u_money] < params[1]) return server_error(playerid, "� ��� ������������ �����.");
	// users[params[0]][u_money] += params[1];
	// users[playerid][u_money] -= params[1];
	money(params[0], "+", params[1]);
	money(playerid, "-", params[1]);
	SaveUser(params[0], "money");
	SaveUser(playerid, "money");
	SCMG(playerid, "�� �������� %s(%i), %i �������� �������.", users[params[0]][u_name], params[0], params[1]);
	SCMG(params[0], "�� �������� %i ���� �� %s(%i).", params[1], users[playerid][u_name], playerid);
	PlayerPlaySound(params[0], 1052, 0.0, 0.0, 0.0);
	//format(stringer, sizeof(stringer), "������ �������� � ������� ������ %s", users[params[0]][u_name]);
	//SetPlayerChatBubble(playerid, stringer, COLOR_PURPLE, 30.0, 10000);
	return true;
}
CMD:whisper(playerid, params[])
{
	if(users[playerid][u_mute]) return SCMASS(playerid, "��� ������������. ��������: %i ������(�).", users[playerid][u_mute]);
	if(sscanf(params, "s[128]", params[0]))return server_error(playerid, "�����������: /w [�����]");
 	static str[144];
	format(str, sizeof(str), "%s(%d) ������: %s.", users[playerid][u_name], playerid, params[0]);
	ProxDetector(playerid, 2.0, str, 0x7AADA8AA, 0x7AADA8AA, 0x7AADA8AA, 0x7AADA8AA, 0x7AADA8AA);
	return true;
}
CMD:shout(playerid, params[])
{
	if(users[playerid][u_mute]) return SCMASS(playerid, "��� ������������. ��������: %i ������(�)", users[playerid][u_mute]);
	if(sscanf(params, "s[128]", params[0]))return server_error(playerid, "�����������: /s [�����]");
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "ON_LOOKERS", "shout_in", 9000.999, 0, 0, 0, 0, 0, 1);
 	static str[144];
	format(str, sizeof(str), "%s(%i) �������(�): %s!!.", users[playerid][u_name], playerid, params[0]);
	ProxDetector(playerid, 50.0, str);
	return true;
}
CMD:eject(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "�� ������ ���� � ������!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return server_error(playerid, "�� ������ ���� �� ������������ �����!");
	if(sscanf(params, "u", params[0])) return server_error(playerid, "�����������: /eject [���/id]");
	if(!IsPlayerConnected(params[0])) return server_error(playerid, "����� �� ������!");
	if(params[0] == playerid) return server_error(playerid, "�� �� ������ �������� �� ������ ����!");
	if(!IsPlayerInVehicle(params[0], GetPlayerVehicleID(playerid))) return server_error(playerid, "����� �� ��������� � ����� ����������!");
	SCMG(playerid, "�� �������� �� ������ %s!", users[params[0]][u_name]);
	SCMASS(params[0], "��� ������� �� ������ %s!", users[playerid][u_name]);
	RemovePlayerFromVehicle(params[0]);
	//TogglePlayerControllable(params[0], true);
	return 1;
}
CMD:car(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "�� ������ ���������� � ������������ ��������.");
	if(IsABycicle(GetPlayerVehicleID(playerid))) return server_error(playerid, "�� ������ ������.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return server_error(playerid, "�� ������ ���� �� ������������ �����.");
	// static engine, lights, alarm, doors, bonnet, boot, objective;
	// GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
	static str[156];
	if(IsABike(GetPlayerVehicleID(playerid))) 
	{
		format(str, sizeof(str), "��������\t������\n\
		���������:\t%s\n����:\t%s", 
		(car_engine{GetPlayerVehicleID(playerid)})?("{33AA33}�������"):("{A52A2A}��������"),
		(car_lights{GetPlayerVehicleID(playerid)})?("{33AA33}��������"):("{A52A2A}���������"));
		show_dialog(playerid, d_car, DIALOG_STYLE_TABLIST_HEADERS, !"���� ������������� ��������", str, !"�������", !"�������");
		return true;
	}
	if(IsBoatsAirplans(GetPlayerVehicleID(playerid))) 
	{
		format(str, sizeof(str), "��������\t������\n�����:\t%s", (car_engine{GetPlayerVehicleID(playerid)})?("{33AA33}�������"):("{A52A2A}��������"));
		show_dialog(playerid, d_car, DIALOG_STYLE_TABLIST_HEADERS, !"���� ������������� ��������", str, !"�������", !"�������");
		return true;
	}
	if(!IsBoatsAirplans(GetPlayerVehicleID(playerid)) && !IsABike(GetPlayerVehicleID(playerid)))
	{
		format(str, sizeof(str), "��������\t������\n\
		���������:\t%s\n����:\t%s\n��������:\t%s\n�����:\t%s", 
		(car_engine{GetPlayerVehicleID(playerid)})?("{33AA33}�������"):("{A52A2A}��������"),
		(car_lights{GetPlayerVehicleID(playerid)})?("{33AA33}��������"):("{A52A2A}���������"),
		(car_boot{GetPlayerVehicleID(playerid)})?("{33AA33}������"):("{A52A2A}������"), 
		(car_bonnet{GetPlayerVehicleID(playerid)})?("{33AA33}������"):("{A52A2A}������"));
		show_dialog(playerid, d_car, DIALOG_STYLE_TABLIST_HEADERS, !"���� ������������� ��������", str, !"�������", !"�������");
		return true;
	}
	return true;
}
CMD:id(playerid, params[])  
{  
	if(sscanf(params, "s[24]", params[0])) return server_error(playerid, "�����������: /id [����� ����]");
	// if(params[0] == playerid) return server_error(playerid, "�� ������� ���� ID/���.");  
	global_string[0] = EOS;
	static index_ = 0, str[96];
	if(index_) index_ = 0;   
    foreach(Player, i)  
    {  
		if(!IsPlayerConnected(i)) continue;
		if(playerid == i) continue;
		if(strfind(users[i][u_name], params[0], true) != -1)
		{
			index_++;
			format(str, sizeof(str), "\n{cccccc}%i. {fffff0}%s ({cccccc}ID: %i{fffff0})", index_, users[i][u_name], i);
			strcat(global_string, str);
		}
    }  
	if(!index_) return server_error(playerid, "���������� �� �������.");  
	if(index_ > 1) strcat(global_string, "\n\n{cccccc}������� ��������� ����������.\n");
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "����������", global_string, "��", "");
    return 1;  
}  
CMD:cancel(playerid)
{
	if(!strcmp(temp[playerid][player_setname], "NoChangeName")) return server_error(playerid, "�� �� �������� ������ �� ����� ����.");
	SCMG(playerid, "�� ���������� �� ����� ����. ���, ������� ��� � ������: %s.", temp[playerid][player_setname]);
	format(temp[playerid][player_setname], MAX_PLAYER_NAME, "NoChangeName");
	return true;
}
CMD:history(playerid)
{
	static str_sql[128];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_HISTORY_NAME" WHERE `uh_id` = '%i' ORDER BY `uh_index` DESC", users[playerid][u_id]);
	new Cache:temp_sql = m_query(str_sql), rows;
    cache_get_row_count(rows);
	if(rows) 
	{
		global_string[0] = EOS;
		new str[128], name[3][MAX_PLAYER_NAME];
		strcat(global_string, "�\t����� ���\t���������� ���\t���� �����\n");
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name(idx-1, "uh_name_new", name[0], MAX_PLAYER_NAME);
			cache_get_value_name(idx-1, "uh_name_old", name[1], MAX_PLAYER_NAME);
			cache_get_value_name(idx-1, "uh_date", name[2], MAX_PLAYER_NAME);
			format(str, sizeof(str), "{cccccc}%i.\t{ADD8E6}%s\t{cccccc}%s\t{ADD8E6}%s\n", idx, name[0], name[1], name[2]);
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_TABLIST_HEADERS, !"������� �����", global_string, !"��", !"");
	}
	else server_error(playerid, "�� ��� �� ������ ����!");
	cache_delete(temp_sql);
	return true;
}
CMD:animation(playerid, params[])
{
	if(sscanf(params, "i", params[0]))
	{
		show_dialog(playerid, d_anim, DIALOG_STYLE_LIST, "��������", "\
		{fffff0}�� ������ ������������: {FFE4B5}/anim [����� ��������]\n\
		{cccccc}1.\t {fffff0}����������� ������\n\
		{cccccc}2.\t {fffff0}�����������\n\
		{cccccc}3.\t {fffff0}��������\n\
		{cccccc}4.\t {fffff0}��������\n\
		{cccccc}5.\t {fffff0}����\n\
		{cccccc}6.\t {fffff0}������� ����-��\n\
		{cccccc}7.\t {fffff0}���� �����\n", !"�������", !"�������");
		// server_error(playerid, "�� ������ ������������: /anim [����� ��������]");
		return true;
	}
	if(params[0] < 1 || params[0] > 7) return server_error(playerid, "����� �������� ����� ���� �� 1 �� 7.");
	animations(playerid, params[0]);
	return true;
}