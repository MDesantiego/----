new report_timer;
const MAX_REPORTS = 61;
enum e_reports
{
    r_id,
    r_owner,
    r_time,
    r_message[196],
    r_time_text[20],
    bool: r_checking
};
new report_system[MAX_REPORTS][e_reports]; 
@report_cleaner();
@report_cleaner()
{
    new total_cleaned_reports = 0;
    for(new i = 1; i < MAX_REPORTS; i++)
    {
        if(report_system[i][r_owner] == 999) continue;
        if(gettime() - report_system[i][r_time] >= 10)
        {
            server_error(report_system[i][r_owner], "[REPORT] Ваше сообщение в репорт было удалено системой, попробуйте обратиться вновь.");
            DeletePVar(report_system[i][r_owner], "report_id");
            report_system[i][r_checking] = false;
            report_system[i][r_id] = i;
            report_system[i][r_owner] = 999;
            report_system[i][r_message][0] = EOS;
            report_system[i][r_time] = -1;
            report_system[i][r_time_text][0] = EOS;
            total_cleaned_reports++;
        }
    }
	if(total_cleaned_reports) AdminChatF("[A][REPORT] Система репортов автоматически очищена, всего было удалено репортов: %i шт.", total_cleaned_reports);
    return 1;
}  
/*

	OnGameModeInit;

*/
public OnGameModeInit()
{
	for(new i = 1; i < MAX_REPORTS; i++)
    {
        report_system[i][r_checking] = false;
        report_system[i][r_id] = i;
        report_system[i][r_owner] = 999;
        report_system[i][r_message][0] = EOS;
        report_system[i][r_time] = -1;
        report_system[i][r_time_text][0] = EOS;
    }
    report_timer = SetTimer("@report_cleaner", 60000*10, true); 
#if defined hook_OnGameModeInit
    return hook_OnGameModeInit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit hook_OnGameModeInit
#if defined   hook_OnGameModeInit
	forward hook_OnGameModeInit();
#endif 
/*

	OnGameModeExit;

*/
public OnGameModeExit()
{
	KillTimer(report_timer);
#if defined hook_OnGameModeExit
    return hook_OnGameModeExit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit hook_OnGameModeExit
#if defined   hook_OnGameModeExit
	forward hook_OnGameModeExit();
#endif 
/*

	OnPlayerDisconnect;

*/
public OnPlayerDisconnect(playerid, reason)
{
	if(GetPVarInt(playerid, "report_id"))
    {
        new report_id = GetPVarInt(playerid, "report_id");

        report_system[report_id][r_checking] = false;
        report_system[report_id][r_id] = report_id;
        report_system[report_id][r_owner] = 999;
        report_system[report_id][r_message][0] = EOS;
        report_system[report_id][r_time] = -1;
        report_system[report_id][r_time_text][0] = EOS;
		DeletePVar(playerid, "report_id");
    }  
	#if defined RS_OnPlayerDisconnect
		return RS_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect RS_OnPlayerDisconnect

#if defined RS_OnPlayerDisconnect
    forward RS_OnPlayerDisconnect(playerid, reason);
#endif

/*

	OnDialogResponse;

*/
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
	switch(dialogid)
	{
	case d_report_admin:
        {
            if(!response) return true;
            if(!report_system[listitem+1][r_checking]) return ShowPlayer_Admin_Report_Answer(playerid, listitem+1);
            server_error(playerid, "Другой администратор уже отвечает на данную жалобу/вопрос.");
        }
    case d_report_admin_otvet:
        {
            if(!response)
            {
                report_system[GetPVarInt(playerid, "report_id_to_answer")][r_checking] = false;
                DeletePVar(playerid, "report_id_to_answer");
                callcmd::otvet(playerid);
				return true;
            }
            new report_id = GetPVarInt(playerid, "report_id_to_answer"), target_id = report_system[report_id][r_owner];
           	if(!IsPlayerConnected(target_id)) return server_error(playerid, "Ошибка: Данный игрок отключился от сервера!");
			AdminChatF("[A][REPORT] %s %s ответил игроку %s[%i]: %s.", admin_rank_name(playerid), users[playerid][u_name], users[target_id][u_name], target_id, inputtext);
			SCMF(target_id, COLOR_BROWN, "[REPORT] {ffffff}Администратор %s ответил: %s", users[playerid][u_name], inputtext);
			
			static str_logs[196];
			format(str_logs, sizeof(str_logs), "Ответил игроку %s: %s", users[target_id][u_name], inputtext);
			logs_admin(playerid, str_logs, "/otvet");

            report_system[report_id][r_checking] = false;
            report_system[report_id][r_id] = report_id;
            report_system[report_id][r_owner] = 999;
            report_system[report_id][r_message][0] = EOS;
            report_system[report_id][r_time] = -1;
            report_system[report_id][r_time_text][0] = EOS;
			DeletePVar(target_id, "report_id");
		}
	case d_report:
		{
			if(!response) return true;
			if(users[playerid][u_mute]) return SCMASS(playerid, "У вас заблокирован чат. Осталось: %i секунд(ы)", users[playerid][u_mute]);
			if(!strlen(inputtext)) return callcmd::report(playerid);
			if(GetPVarInt(playerid, "report_id")) return server_error(playerid, "Вы уже отправили жалобу/сообщение. Ожидайте ответ.");
			AdminChatF("[A]{F6C500}[REPORT] {FFFFFF} %s[%i] оставил жалобу/сообщение для администрации (просмотреть: /otvet).", users[playerid][u_name], playerid);
			server_accept(playerid, "Обращение отправлено. Ожидайте ответ от администратора.");
			new hour, minute, second;
			for(new i = 1; i < MAX_REPORTS; i++)
			{
				if(report_system[i][r_owner] != 999) continue;
				report_system[i][r_checking] = false;
				report_system[i][r_id] = i;
				report_system[i][r_owner] = playerid;
				format(report_system[i][r_message], 196, inputtext);
				report_system[i][r_time] = gettime();
				gettime(hour, minute, second);
				format(report_system[i][r_time_text], 20, "%02d:%02d:%02d", hour, minute, second);
				SetPVarInt(playerid, "report_id", i);
				break;
			}
		}
	}
	#if defined RS_OnDialogResponse
		return RS_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	#endif
}
#if defined _ALS_OnDialogResponse
    #undef OnDialogResponse
#else
    #define _ALS_OnDialogResponse
#endif
#define OnDialogResponse RS_OnDialogResponse

#if defined RS_OnDialogResponse
	forward RS_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
#endif  

CMD:otvet(playerid)
{
	AdminProtect(1);
	global_string[0] = EOS;
    new string[128], index_ = 0;
	strcat(global_string, "№\tАвтор вопроса\tВремя\n");
    for(new i = 1; i < MAX_REPORTS; i++)
    {
        if(report_system[i][r_owner] == 999) continue;
		index_++;
        format(string, sizeof(string), "{cccccc}%i.\t{fffff0}%s\t{B0E0E6}%s\n", index_, users[report_system[i][r_owner]][u_name], report_system[i][r_time_text]);
		strcat(global_string, string);
    }
    if(!index_) return server_error(playerid, "Список репортов/сообщений пуст.");
    show_dialog(playerid, d_report_admin, DIALOG_STYLE_TABLIST_HEADERS, !"Список репортов", global_string, !"Выбрать", !"Отмена");
    return 1;
}
stock ShowPlayer_Admin_Report_Answer(playerid, report_id) 
{ 
    SetPVarInt(playerid, "report_id_to_answer", report_id); 
    report_system[report_id][r_checking] = true;
	static dialog_string[356];
	format(dialog_string, sizeof(dialog_string), "\
	{fffff0}Номер жалобы/вопроса: {B0E0E6}%i\n\
	{fffff0}Автор жалобы/вопроса: {B0E0E6}%s(%i)\n\
	{fffff0}Время отправки жалобы/вопроса: %s\n\n\
	{fffff0}Жалоба/Вопрос: {87CEFA}%s", 
	report_id, users[report_system[report_id][r_owner]][u_name], report_system[report_id][r_owner], report_system[report_id][r_time_text], report_system[report_id][r_message]);
	show_dialog(playerid, d_report_admin_otvet, DIALOG_STYLE_INPUT, !"Жалоба/Вопрос", dialog_string, !"Ответить", !"Назад"); 
    return 1; 
}  