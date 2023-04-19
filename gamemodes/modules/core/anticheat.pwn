/*
    Описание: Система зомби;
    Автор: Nexius_Tailer;
	Настройка: Noir;
*/
#if defined _anticheat_included
	#endinput
#endif
#define _anticheat_included
#include									<nex-ac>
/* 
	Настройка античита
*/
#define AC_MAX_CODES                    53 // Количество кодов анти-чита (на данный момент их 53)
#define AC_MAX_CODES_ON_PAGE            15 // Максимальное количество элементов на странице настроек анти-чита
#define AC_DIALOG_NEXT_PAGE_TEXT        ">>> Следующая страница" // Текст кнопки, которая будет отображать следующую страницу списка
#define AC_DIALOG_PREVIOUS_PAGE_TEXT    "<<< Предыдущая страница" // Текст кнопки, которая будет отображать предыдущую страницу списка

enum anticheat_structure {
	ac_code,
	ac_name[36],
	ac_code_trigger_type
};
new anticheat[AC_MAX_CODES][anticheat_structure];

// Массив AC_TRIGGER_TYPE_NAME хранит в себе названия типов срабатываний (наказаний) анти-чита.  
new const AC_TRIGGER_TYPE_NAME[][MAX_PLAYER_NAME] =  
{ 
    {"{cccccc}Отключено"}, {"{FFDEAD}Сообщать"}, {"{A52A2A}Кикнуть"} 
}; 
new 
    AC_CODE_TRIGGERED_COUNT[AC_MAX_CODES] = {0, ...}; // Массив, хранящий количество срабатываний того или иного кода анти-чита на протяжении текущей сессии
new 
    pAntiCheatLastCodeTriggerTime[MAX_PLAYERS][AC_MAX_CODES], // Массив, хранящий последнее время срабатывания каждого кода анти-чита на игрока
    pAntiCheatSettingsPage[MAX_PLAYERS char], // Массив, хранящий номер страницы настроек, на которой сейчас находится игрок
    pAntiCheatSettingsMenuListData[MAX_PLAYERS][AC_MAX_CODES_ON_PAGE], // Массив, хранящий в себе идентификаторы (ID) отображённых анти-читов на текущей странице, при их настройке в диалоге
    pAntiCheatSettingsEditCodeId[MAX_PLAYERS]; // Массив, хранящий номер кода анти-чита, который редактируется игроком  

@LoadAntiCheat();
@LoadAntiCheat()
{
	new time = GetTickCount(), rows;
	cache_get_row_count(rows);
	if(!rows) return print("["SQL_VER"][WARNING]: Настройки античита не найдены.");
	for(new idx = 1; idx <= rows; idx++)
	{
		
		cache_get_value_name_int(idx-1, "ac_code", anticheat[idx-1][ac_code]);
		cache_get_value_name(idx-1, "ac_name", anticheat[idx-1][ac_name]);
		cache_get_value_name_int(idx-1, "ac_code_trigger_type", anticheat[idx-1][ac_code_trigger_type]);
		if(!anticheat[idx-1][ac_code_trigger_type]) EnableAntiCheat(idx-1, 0);
	}
	printf("["SQL_VER"][%04dМС]: Загружено настроек античита: %04d.", GetTickCount() - time, rows);
	return 1; 
}
stock OnCheatDetected(playerid, ip_address[], type, code)
{
	return 1;
	// if(admin[playerid][u_a_protrct_ac]) return true;
    if(type)
	{
		AC_CODE_TRIGGERED_COUNT[code]++;
		static str[144];
		AdminChatF("[A][AC] {cccccc}IP-адрес {FFDEAD}%s {cccccc}был заблокирован. ({FFDEAD}%s (%03i){cccccc})", ip_address, anticheat[code][ac_name], code);
		m_format(str, sizeof(str), "INSERT INTO "TABLE_BANIP" (`u_b_ip_admin`, `u_b_ip`, `u_b_ip_reason`, `u_b_ip_date`, `u_b_ip_ndate`, `u_b_ip_days`) VALUES ('Система', '%s', '%s', NOW() + INTERVAL 96 DAY, NOW(), '96')",
		users[playerid][u_name], anticheat[code][ac_name], ip_address);
		m_query(str);	
		foreach(Player, i)
		{
			static str_ip[16];
			GetPlayerIp(i, str_ip, MAX_PLAYER_NAME);
			if(!strcmp(ip_address,  str_ip, true))
			{
				TKICK(playerid, "Ваш ip-адрес заблокирован.");
				break;
			}
		}
        BlockIpAddress(ip_address, 2592000000);
		return true;
	}
    if(gettime() - pAntiCheatLastCodeTriggerTime[playerid][code] < 5) return true;
    pAntiCheatLastCodeTriggerTime[playerid][code] = gettime();
    AC_CODE_TRIGGERED_COUNT[code]++;
	switch(anticheat[code][ac_code_trigger_type])
	{
	case 0: return true;
	case 1: AdminChatF("[A]{FFDEAD}[AC] {cccccc}Подозревается игрок {FFDEAD}%s(%i) {cccccc}в использовании чит-программ: {FFDEAD}%s (%03i)", users[playerid][u_name], playerid, anticheat[code][ac_name], code);
	case 2:
		{
			switch(code)
			{
			case 13: 
				{
					users[playerid][u_armour] = 0;
					SetPlayerArmour(playerid, 0);
					TKICK(playerid, "Вы были кикнуты по подозрению в использовании чит-программ.", code);
				}
			case 15..17: //Читы на оружие, патроны.
				{
					users[playerid][u_newgame] = 1;
					TKICK(playerid, "Вы были кикнуты по подозрению в использовании чит-программ.", code);
				}
			case 32:
				{
					new Float: xyz[3];
					AntiCheatGetPos(playerid, xyz[0], xyz[1], xyz[2]);
					SetPlayerPos(playerid, xyz[0], xyz[1], xyz[2]);
					TKICK(playerid, "Вы были кикнуты по подозрению в использовании чит-программ.", code);
				}
			case 40:
				{
					TKICK(playerid, "Вы превысили максимальное число подключений с 1 IP-адреса.", code);
				}
			case 41:
				{
					TKICK(playerid, "Данная версия клиента не подходит для игры на сервере.", code);
				}
			default:
				{
					TKICK(playerid, "Вы были кикнуты по подозрению в использовании чит-программ.", code);
				}
			}
            AdminChatF("[A][AC] {cccccc}Игрок {FFDEAD}%s(%i) {cccccc}был кикнут по подозрению в использовании чит-программ: {FFDEAD}%s (%03i)", users[playerid][u_name], playerid, anticheat[code][ac_name], code);
			AntiCheatKickWithDesync(playerid, code);
    	}
    }
    return 1;
}
stock ShowPlayer_AntiCheatSettings(playerid)
{
	static str[96];
	global_string[0] = EOS;
    new triggeredCount = 0, page = pAntiCheatSettingsPage{playerid}, next = 0, index = 0;
	strcat(global_string, "[Код] Название\tНаказание\tCрабатываний\n");
    for(new i = 0; i < AC_MAX_CODES; i++)
    {
        if(i >= (page * AC_MAX_CODES_ON_PAGE) && i < (page * AC_MAX_CODES_ON_PAGE) + AC_MAX_CODES_ON_PAGE)
            next++;

        if(i >= (page - 1) * AC_MAX_CODES_ON_PAGE && i < ((page - 1) * AC_MAX_CODES_ON_PAGE) + AC_MAX_CODES_ON_PAGE)
        {
            triggeredCount = AC_CODE_TRIGGERED_COUNT[i];
            format(str, sizeof(str), "{cccccc}[%i] {ffffff}%s\t%s\t{cccccc}%i\n", anticheat[i][ac_code], anticheat[i][ac_name], AC_TRIGGER_TYPE_NAME[anticheat[i][ac_code_trigger_type]], triggeredCount);
			strcat(global_string, str);
            pAntiCheatSettingsMenuListData[playerid][index++] = i;
        }
    }
    if(next) strcat(global_string, "{cccccc}"AC_DIALOG_NEXT_PAGE_TEXT"\n");
    if(page > 1) strcat(global_string, "{cccccc}"AC_DIALOG_PREVIOUS_PAGE_TEXT"");
    return show_dialog(playerid, d_anticheat_menu, DIALOG_STYLE_TABLIST_HEADERS, !"Античит", global_string, !"Выбрать", !"Отмена");
}