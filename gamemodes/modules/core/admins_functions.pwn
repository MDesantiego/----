/*
	�������� �� ��������������
*/
stock CheckOfAdmin(playerid) // �������� �� �������
{
	if(admin[playerid][u_a_dostup] != 0) return true;
	new str_sql[96];
	m_format(str_sql, sizeof(str_sql), "SELECT * FROM "TABLE_ADMIN" WHERE `u_a_name` = '%s' LIMIT 1", users[playerid][u_name]);
	new Cache:temp_sql = m_query(str_sql), r;
    cache_get_row_count(r);
	if(r) 
	{
		cache_delete(temp_sql);
		return true;
	}
	cache_delete(temp_sql);
	return false;
}
/*
	����������� �������� �������������
*/
stock logs_admin(playerid, string[], cmd[] = " ", str[] = " ") // ��, �����, �������, ���. ���� ��� ������
{
	static str_sql[356]; // ���������� ��� ������ �������;
	m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_ADMINS_LOGS" (`logs_admin_id`, `logs_admin_name`, `logs_admin_string`, `logs_admin_cmd`, `logs_admin_str`, `logs_admin_date`) VALUES ('%i', '%s', '%s', '%s', '%s', NOW());",
	users[playerid][u_id], users[playerid][u_name], string, cmd, str); // ������ �������;
	m_query(str_sql);// �������� ������� � ���� ������;
	return true;
}
/*
	������� ���� ��� �������
*/
stock admin_syntax(playerid)
{
	// �������� � OnPlayerSpawn, alogin;
	if(!admin[i][u_a_level] || !admin[i][u_a_dostup])
	{
		foreach(Player, i) SetPlayerMarkerForPlayer(playerid, i, 0xFFFFFF00);
		return true;
	}
	foreach(Player, i)
	{
		if(!admin[i][u_a_level] || !admin[i][u_a_dostup]) continue;
		SetPlayerMarkerForPlayer(playerid, i, COLOR_ADMIN); // �������� ������; (����� �������� ����� �����, ����� �������� ������, ����)
	}
	return true;
}
/*
	������� ����-����� ��� �������������;
*/
stock AntiFloodCommands(playerid, cmd[] = "����������", timer = 15)
{
	if(FullDostup(playerid, 1)) return true;
	new getcmd[24+1];
	GetPVarString(playerid, "AntiFloodCommandsName", getcmd, sizeof(getcmd));
	if(!strcmp(getcmd, cmd, false))
	{
		if(GetPVarInt(playerid, "AntiFloodCommandsTime") > gettime())
		{
			SetPVarInt(playerid, "AntiFloodCommands", GetPVarInt(playerid, "AntiFloodCommands")+1);
			global_string [ 0 ] = EOS;
			switch(GetPVarInt(playerid, "AntiFloodCommands"))
			{
			case 1..3: 
				{
					new str[128];
					SCMASS(playerid, "������� %s ����� ������������ ��� � %i ������.", cmd, timer);
					format(str, sizeof(str), "[A] ������������� %s(%i) ������ �������� %s. (%i ���)", users[playerid][u_name], playerid, cmd, GetPVarInt(playerid, "AntiFloodCommands"));
					AdminChat(str, 6);
				}
			case 4:
			    {
					new str_sql[96];
					AdminChatF("[A] ������������� %s ��� ��������� �� ���� �������� %s.", users[playerid][u_name], cmd);
					m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_ADMIN" SET `u_a_freeze` = '1' WHERE `u_a_name` = '%s'", users[playerid][u_name]);
					m_query(str_sql);
					server_error(playerid, "���� ���������������� ���������� �������� �������������.");
					callcmd::alogin(playerid);
			    }
			}
		}
		if(GetPVarInt(playerid, "AntiFloodCommandsTime") < gettime())
		{
			DeletePVar(playerid, "AntiFloodCommands");
			DeletePVar(playerid, "AntiFloodCommandsName");
			SetPVarInt(playerid, "AntiFloodCommandsTime", gettime() + timer);
		}
	}
	else
	{
		DeletePVar(playerid, "AntiFloodCommands");
		DeletePVar(playerid, "AntiFloodCommandsTime");
	}
	SetPVarString(playerid, "AntiFloodCommandsName", cmd);
	return true;
}
/*
	recon - ������ �� �������
*/
