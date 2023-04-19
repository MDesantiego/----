public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if(PlayerIsOnline(playerid)) return server_error(playerid, "Вы не авторизованы."), false;
	if(GetPVarInt(playerid, "AntiFloodCommands") > gettime()) return server_error(playerid, "Не флуди командами!"), false;
	SetPVarInt(playerid,"AntiFloodCommands", gettime() + 1);
	return 1 ;
}
public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if(result == -1) return server_error(playerid, "Данная команда не существует. Используйте {cccccc}/cmd{ffffff}, чтобы узнать список команд сервера.");	
    return 1;
}
//Алиасы:
alias:opengate("og");
alias:whisper("w");
alias:shout("s");
alias:commands("cmd", "command");
alias:menu("mn", "mm", "mainmenu");
alias:pbase("pbaze", "panelbase");
alias:craft("crafting");
alias:report("rep");
alias:animation("anim");
//Команды:
CMD:craft(playerid)
{
	show_dialog(playerid, d_craft, DIALOG_STYLE_LIST, !"Изготовление", !"\
	{cccccc}1. {fffff0}Деревянная дверь\n\
	{cccccc}2. {fffff0}Железная дверь\n\
	{cccccc}3. {fffff0}Циркулярный станок\n\
	{cccccc}4. {fffff0}Верстак\n\
	{cccccc}5. {fffff0}Электропечь\n\
	{87CEEB}Информация", !"Изготовить", !"Закрыть");
	return true;
}
	// {cccccc}6. {fffff0}Генератор\n

CMD:report(playerid) 
{
	global_string [ 0 ] = EOS ;
	strcat(global_string, "{ffffff}Вы собираетесь написать сообщение Администрации.\n");
	strcat(global_string, "Перед тем как отправить сообщение убедитесь,\n");
	strcat(global_string, "что не один из пунктов помощи не дал вам ответа на ваш вопрос.\n\n");
	strcat(global_string, "{AA3333}Запрещено:\n");
	strcat(global_string, "1. Флуд, оскорбления, оффтоп\n");
	strcat(global_string, "2. Просьбы (Дайте денег, дайте админку, дайте дайте..)\n");
	strcat(global_string, "3. Ложные сообщения\n\n");
	strcat(global_string, "{DF4F4F}За нарушение правил администрация может: \n");
	strcat(global_string, "1. Предупредить\n");
	strcat(global_string, "2. Кикнуть с сервера\n");
	strcat(global_string, "3. Заблокировать аккаунт\n\n");
	strcat(global_string, "{65C360}Помните!\n");
	strcat(global_string, "Мы всегда готовы помочь если вы соблюдаете правила.\n");
	strcat(global_string, "Данные правила установлены для всех игроков "FULL_NAME"\n\n");
	strcat(global_string, "{ffffff}Если вам долго не отвечают, подождите пару минут.\n");
	strcat(global_string, "{ffffff}Спасибо за понимание, с уважением Администрация.\n\n");
	show_dialog(playerid, d_report, DIALOG_STYLE_INPUT, !"Сообщение для администрации", global_string, !"Отправить", !"Отмена");
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
		format(str, sizeof(str), "{cccccc}%i. {fffff0}База №%i\n", count_, i);
		strcat(global_string, str);
		// BaseGateOpen[playerid] = i;
	}
	if(!count_) return server_error(playerid, "Вы не владеете базой!");
	show_dialog(playerid, d_base_menu, DIALOG_STYLE_LIST, "Базы", global_string, !"Выбрать", !"Закрыть");
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
	if(!b) return server_error(playerid, "В близи 7 метров от вас нет никаких ворот.");
	if(base[b][b_gate_open_number] && base[b][b_gate_open]) return server_error(playerid, "Подождите пока закроются ворота.");
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
		if(!base[b][b_owner_id]) return server_error(playerid, "У базы нет владельца!");
		switch(base[b][b_lock_status])
		{
		case 0: show_dialog(playerid, d_base_password, DIALOG_STYLE_INPUT, "Ворота", "\nВведите пароль от ворот базы\n\n", !"Ввод", !"Закрыть");
		default:
			{
				if(base[b][b_lock_status] != users[playerid][u_clan]) return server_error(playerid, "Владелец базы не в вашем клане!");
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
		server_error(playerid, "Вы не состоите в клане!");
		show_dialog(playerid, d_clan_money, DIALOG_STYLE_MSGBOX, !"Меню клана", "У вас нет клана! Хотите создать клан?\nСтоимость создания клана 2.000.000 или 200 рублей в /donate", !"Да", !"Нет");
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
		server_error(playerid, "У вашего клана 3 из 3 выговоров. После рестарта, ваш клан удалится!");
		server_error(playerid, "У вашего клана 3 из 3 выговоров. После рестарта, ваш клан удалится!");
	}
	new str[96], str_two[MAX_PLAYER_NAME];
	global_string [ 0 ] = EOS ;
	strcat(global_string, "Раздел\tСтатус\n");
	strcat(global_string, "{cccccc}1. {ffffff}Статистика клана\n");
	strcat(global_string, "{cccccc}2. {ffffff}Список соклановцев\t{ADD8E6}Полный\n");
	if(clan[users[playerid][u_clan]][c_rank_zam] > users[playerid][u_clan_rank]) strcat(global_string, "{cccccc}3. {ffffff}Покинуть клан");
	if(clan[users[playerid][u_clan]][c_rank_zam] <= users[playerid][u_clan_rank])
	{
		strcat(global_string, "{cccccc}3. {ffffff}Принять в клан\n");
		strcat(global_string, "{cccccc}4. {ffffff}Выгнать из клана\n");
		strcat(global_string, "{cccccc}5. {ffffff}Изменить ранг соклановцу\n");
		strcat(global_string, "{cccccc}6. {ffffff}Изменить название рангов\n");
		format(str_two, sizeof(str_two), "№%i", clan[users[playerid][u_clan]][c_skin]);
		format(str, sizeof(str), "{cccccc}7. {ffffff}Сменить одежду клана\t{ADD8E6}%s\n", (!clan[users[playerid][u_clan]][c_skin])?("{A52A2A}Нет"):(str_two));
		strcat(global_string, str);
		if(strcmp(users[playerid][u_name], clan[users[playerid][u_clan]][c_owner], false)) strcat(global_string, "{cccccc}8. {ffffff}Покинуть клан");
	}
	if(!strcmp(users[playerid][u_name], clan[users[playerid][u_clan]][c_owner], false))
	{
		format(str, sizeof(str), "{cccccc}8. {ffffff}Назначить ранг для привилегий\t{ADD8E6}Ранг: %i\n", clan[users[playerid][u_clan]][c_rank_zam]);
		strcat(global_string, str);
		format(str, sizeof(str), "{cccccc}9. {ffffff}Сменить название клана\t{ADD8E6}%s\n", clan[users[playerid][u_clan]][c_name]);
		strcat(global_string, str);
		format(str_two, sizeof(str_two), "%s", clan[users[playerid][u_clan]][c_name_abbr]);
		format(str, sizeof(str), "{cccccc}10. {ffffff}Сменить аббревиатуру клана\t{ADD8E6}%s\n", (!strcmp("NoNameAbbreviatur", clan[users[playerid][u_clan]][c_name_abbr]))?("{A52A2A}Нет"):(str_two));
		strcat(global_string, str);
		format(str, sizeof(str), "{cccccc}11. {ffffff}Установить новую точку спавна\t%s\n", (!spawn_status)?(" "):("{A52A2A}На проверке"));
		strcat(global_string, str);
		strcat(global_string, "{cccccc}12. {ffffff}Расформировать клан\n");
		strcat(global_string, "{cccccc}13. {ffffff}Удалить клан");
	}
	show_dialog(playerid, d_clan, DIALOG_STYLE_TABLIST_HEADERS, !"Меню клана", global_string, !"Выбрать", !"Закрыть");
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
   	{FFFFFF}В этом разделе вы сможете использовать дополнительные\n\
   	возможности сервера. Описание всех дополнительных\n\
	возможностей, а также о способах пополнения счёта вы можете\n\
	узнать на сайте: {66CDAA}"SITE_NAME" в разделе ''Пополнение счета''.\n\n\
	{20B2AA}Информация:\n\
	{FFFFFF}Номер аккаунта: \t\t№%i\n\
	Текущее состояние счёта:\t%i рублей.\n\
	Общая сумма пополнений:\t%i рублей.\n\n\
	Текущее состояние коинов:\t%i\n";
	new string[sizeof(size_str)+86];
	format(string, sizeof(string), size_str, users[playerid][u_id], get_player_donate(playerid), count_money, get_player_coins(playerid));
	show_dialog(playerid, d_donate_menu, DIALOG_STYLE_MSGBOX, !"Дополнительные услуги", string, !"Услуги", !"Закрыть");
	return 1;
}*/
CMD:donate(playerid)
{
	show_donate(playerid);
	return 1;
}
stock show_donate(playerid)
{
	//if(!get_player_donate ( playerid )) return server_error(playerid, "У вас недостаточно денежных средств."), server_error(playerid, "Пополнить счет можно на сайте "SITE_NAME"") ;
	static str[96];
	format(str, sizeof(str), "Дополнительные услуги | {fffff0}Баланс: %i", get_player_donate(playerid));
	show_dialog(playerid, d_donate, DIALOG_STYLE_TABLIST_HEADERS, str, !"Название услуги:\tСтоимость:\n\
	{828282}- {ffffff}Купить VIP статус\t{33AA33}150 рублей\n\
	{828282}- {ffffff}Создать свой клан\t{33AA33}200 рублей\n\
	{828282}- {ffffff}Конвертер игровой валюты\t{33AA33}от 1 рубля\n\
	{828282}- {ffffff}Приобрести редкие вещи\t{33AA33}от 10 рублей\n\
	{828282}- {ffffff}Приобрести базу\t{33AA33}от 120 рублей\n\
	{828282}- {ffffff}Личная точка появления\t{33AA33}50 рублей\n\
	{828282}- {ffffff}Личный скин\t{33AA33}50 рублей\n\
	{828282}- {ffffff}Стартеры\t{33AA33}от 80 рублей\n\
	{828282}- {ffffff}Жетон для смены ника\t{33AA33}5 рублей\n\
	{FFD700}Торговая площадка", !"Выбрать", !"Закрыть");//
	return 1;
}
// {ADD8E6}Вывод денежных средств
CMD:pack(playerid)
{
	// if(temp[playerid][TimeUsePack] == -1) return server_error(playerid, "Вам недоступно или Вы уже брали стартер.");
	if(temp[playerid][TimeUsePack] == 0) return server_error(playerid, "Время закончилось или Вы уже брали стартер.");
	static str[400];
	format(str, sizeof(str), "Название:\tКоличество:\n\
	{828282}- {ffffff}Стартер выжившего\t{cccccc}%i шт.\n\
	{828282}- {ffffff}Медицинский стартер\t{cccccc}%i шт.\n\
	{828282}- {ffffff}Полицейский стартер\t{cccccc}%i шт.\n\
	{828282}- {ffffff}Военный стартер\t{cccccc}%i шт.\n\
	{828282}- {ffffff}Снайперский стартер\t{cccccc}%i шт.\n\
	{cccccc}Информация о стартерах", users[playerid][u_pack][0], users[playerid][u_pack][1], users[playerid][u_pack][2], users[playerid][u_pack][3], users[playerid][u_pack][4]);
	show_dialog(playerid, d_starter, DIALOG_STYLE_TABLIST_HEADERS, !"Стартеры", str, !"Выбрать", !"Закрыть");
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
	if(!GetItem(playerid, 53)) return server_error(playerid, "У вас нет с собой рации!");
	if(!users[playerid][u_clan]) return server_error(playerid, "Вы не состоите в клане.");
	if(users[playerid][u_mute]) return SCMASS(playerid, "Чат заблокирован. Осталось: %i секунд(ы).", users[playerid][u_mute]);
	if(sscanf(params, "s[128]", params[0])) return server_error(playerid, "Используйте: /rc [сообщение]");
	static str[156];
	format(str, sizeof(str), "[R][CLAN] %s %s: {ffffff}%s", c_rank[users[playerid][u_clan]][users[playerid][u_clan_rank]-1], users[playerid][u_name], params[0]);
	clan_message(users[playerid][u_clan], str);
	return 1; 
}
CMD:help(playerid) 
{
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Помощь", !"\n\n\
	{96c199}Вспомогательные клавиши:\n\
	{96c199}Y - {a9a884}открыть рюкзак (инвентарь)\n\
	{96c199}Л.ALT - {a9a884}подобрать предмет (лут)\n\
	{96c199}H - {a9a884}открыть мед.ящик, простой ящик, багажник\n\
	{96c199}N - {a9a884}главное меню\n\n\
	{96c199}2 - {a9a884}Меню транспорта.\n\
	{96c199}Ctrl - {a9a884}Завести/заглушить двигатель.\n\
	{96c199}Num 4 - {a9a884}Открыть/Закрыть капот.\n\
	{96c199}Num 6 - {a9a884}Открыть/закрыть багажник.\n\
	{96c199}L.ALT - {a9a884}Включить/Выключить фары.", !"Понятно", !"");
	return 1; 
}
CMD:vip(playerid) 
{
	if(!users[playerid][u_vip_time]) return server_error(playerid, "Панель доступна только вип игрокам. Чтобы приобрести права введите ''/donate''");
	global_string [ 0 ] = EOS ;
	strcat(global_string, "{cccccc}1. {ffffff}Информация о VIP статусе\n");
	strcat(global_string, "{cccccc}2. {ffffff}Настройки VIP статуса");
	show_dialog(playerid, d_vip, DIALOG_STYLE_LIST, !"VIP Меню", global_string, !"Выбрать", !"Закрыть");
	return 1; 
}
CMD:r(playerid, params[]) 
{
	if(!GetItem(playerid, 53)) return server_error(playerid, "У вас нет с собой рации!");
	if(users[playerid][u_mute]) return SCMASS(playerid, "Чат заблокирован. Осталось: %i секунд(ы).", users[playerid][u_mute]);
	if(!users[playerid][u_settings][1]) return server_error(playerid, "Выберите волну рации в личных настройках.");
	if(sscanf(params,"s[196]", params[0])) return server_error(playerid, "Используйте: /r [сообщение]");
	static str[356];
	switch(users[playerid][u_settings_vip][0])
	{
	case 0: format(str, sizeof(str), "[Рация][%i] %s(%i){ffffff}: %s", users[playerid][u_settings][1], users[playerid][u_name], playerid, params[0]);
	case 1: format(str, sizeof(str), "[Рация][%i]{FFD700}[VIP] {007AEB}%s(%i){ffffff}: %s", users[playerid][u_settings][1], users[playerid][u_name], playerid, params[0]);
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
	if(users[playerid][u_mute]) return SCMASS(playerid, "Чат заблокирован. Осталось: %i секунд(ы).", users[playerid][u_mute]);
	if(sscanf(params,"ds[128]", params[0], params[1])) return server_error(playerid, "Используйте: /pm [имя/ид] [сообщение]");
	if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(users[params[0]][u_settings][0]) return server_error(playerid, "Игрок запретил писать ему личные сообщения.");
	static str[256];
	if(params[0] == playerid) 
	{
		format(str, sizeof(str), " {ffffff}%s {8effa9}бормочет что-то себе под нос.", users[playerid][u_name]);
		ProxDetector(playerid, 5.0, str, COLOR_LILAC, COLOR_LILAC, COLOR_LILAC, COLOR_LILAC, COLOR_LILAC);
		return true; 
	}
	switch(users[playerid][u_settings_vip][0])
	{
	case 0: format(str, sizeof(str), "[ЛС] От %s(%i){ffffff}: %s", users[playerid][u_name], playerid, params[1]);
	case 1: format(str, sizeof(str), "[ЛС]{FFD700}[VIP] {ffff99}От %s(%i){ffffff}: %s", users[playerid][u_name], playerid, params[1]);
	}
	SendClientMessage(params[0], COLOR_LIGHTYELLOW, str);
	PlayerPlaySound(params[0], 1052, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SCMG(playerid, "{e5e5e5}Вы отправили ЛС {feffe6}%s(%d): {e1e0b5}%s", users[params[0]][u_name], params[0], params[1]);
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
	if(!GetPVarInt(playerid, "CAMPFIRE_USER")) return server_error(playerid, "Рядом с вами нет костра.");
	if(!IsPlayerInRangeOfPoint(playerid, 1.5, fire[GetPVarInt(playerid, "CAMPFIRE_USER")][fire_xyz][0], fire[GetPVarInt(playerid, "CAMPFIRE_USER")][fire_xyz][1], fire[GetPVarInt(playerid, "CAMPFIRE_USER")][fire_xyz][2])) return server_error(playerid, "Вы должны находится около костра.");
	if(!fire[GetPVarInt(playerid, "CAMPFIRE_USER")][fire_time]) return server_error(playerid, "Костер потух.");
	show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "Костер", !"\
	Погреться возле костра\n\
	{8FBC8F}| {fffff0}Пожарить мясо\n\
	{8FBC8F}| {fffff0}Прокипятить воду\n\
	{AFEEEE}| {fffff0}Потушить костер", !"Выбрать", !"Закрыть");
	return true;
}
	/*if(GetItem(playerid, 5) && !GetItem(playerid, 125) && !GetItem(playerid, 44)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "Костер", !"\
	Погреться возле костра\n\
	{8FBC8F}| {fffff0}Пожарить мясо", !"Выбрать", !"Закрыть");
	else if(GetItem(playerid, 5) && GetItem(playerid, 125)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "Костер", !"\
	Погреться возле костра\n\
	{8FBC8F}| {fffff0}Пожарить мясо\n\
	{8FBC8F}| {fffff0}Прокипятить воду\n\
	{AFEEEE}| {fffff0}Потушить костер", !"Выбрать", !"Закрыть");
	else if(GetItem(playerid, 5) && GetItem(playerid, 44)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "Костер", !"\
	Погреться возле костра\n\
	{8FBC8F}| {fffff0}Пожарить мясо\n\
	{AFEEEE}| {fffff0}Потушить костер", !"Выбрать", !"Закрыть");
	else if(!GetItem(playerid, 5) && GetItem(playerid, 44)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "Костер", !"\
	Погреться возле костра\n\
	{AFEEEE}| {fffff0}Потушить костер", !"Выбрать", !"Закрыть");
	else if(!GetItem(playerid, 5) && GetItem(playerid, 125)) return show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "Костер", !"\
	Погреться возле костра\n\
	{8FBC8F}| {fffff0}Прокипятить воду\n\
	{AFEEEE}| {fffff0}Потушить костер", !"Выбрать", !"Закрыть");

	show_dialog(playerid, d_campfire, DIALOG_STYLE_LIST, "Костер", !"\
	Погреться возле костра\n\
	{8FBC8F}| {fffff0}Пожарить мясо\n\
	{8FBC8F}| {fffff0}Прокипятить воду\n\
	{AFEEEE}| {fffff0}Потушить костер", !"Выбрать", !"Закрыть");
	return true;
}
*/
CMD:rules(playerid)
{
	global_string[0] = EOS;
	strcat(global_string, "{ffffff}");
	strcat(global_string, "Незнание правил не освобождает от ответственности!\n");
	strcat(global_string, "Любой игрок сервера должен соблюдать данные правила, в противном случае будет выдано наказание!\n");
	strcat(global_string, "Наказание выносит администрация в связи с внутренними правилами администрации.\n");
	strcat(global_string, "Повторные нарушения могут вести за собой более суровые наказания.\n\n");
	strcat(global_string, "1. Чат:\n");
	strcat(global_string, "1.1 Запрещено оскорбление игроков/администрации/сообщества людей/клана.\n");
	strcat(global_string, "1.2 Запрещена любая ненормативная лексика, а так же зашифрованная ненормативная лексика (замена одной или более букв другими буквами или символами).\n");
	strcat(global_string, "1.3 Запрещён флуд в любой чат, а так же флуд командами сервера.\n");
	strcat(global_string, "1.4 Запрещена любая реклама/упоминание сторонних ресурсов.\n");
	strcat(global_string, "1.5 Запрещено намеренное злоупотребление верхним регистром, он же 'CAPS LOCK'.\n\n");
	strcat(global_string, "2. Дополнительные модификации/программы/моды/читы:\n");
	strcat(global_string, "2.1 Запрещены любые модификации/программы/моды/читы дающие любые преимущества над обычным клиентом игры.\n");
	strcat(global_string, "2.2 Запрещены любые модификации/программы/моды/читы нарушающие правильность работы игрового мода и его скриптов/плагинов.\n\n");
	strcat(global_string, "3. Блокировка IP адресса игрока:\n");
	strcat(global_string, "3.1 Запрещены любые обходы блокировки IP адреса.\n\n");
	strcat(global_string, "4. Игровой процесс:\n");
	strcat(global_string, "4.1 Запрещены любого рода SpawnKill(SK,СК), более 2 убийств на точке спавна игрока.\n");
	strcat(global_string, "4.2 Запрещено уходить в AFK, выходить из игры в случае получения урона от другого игрока.\n");
	strcat(global_string, "4.3 Запрещено любое использование багов игрового мода, исключения: тестирование и сообщение администрации об ошибки игрового мода проекта.\n");
	strcat(global_string, "4.4 Запрещено любого вида ожидание игрока при выходе его из зеленой зоны с целью убийства или нанесения урона.\n");
	strcat(global_string, "4.5 Запрещено наносить любой урон от вас другому игроку находящегося в зеленой зоне.\n\n");
	strcat(global_string, "5. Взаимодействия с администрацией:\n");
	strcat(global_string, "5.1 Зарещена любая помеха администрации.\n");
	strcat(global_string, "5.2 Запрещено любое выпрашивание чего любо у администрации.\n");
	strcat(global_string, "5.3 Запрещён оффтоп в /report.\n\n");
	strcat(global_string, "6. Продажа и покупка за рельные деньги:\n");
	strcat(global_string, "6.1 Запрещенна любая продажа чего-либо на проекте не через внутреигровую систему (/donate).\n");
	strcat(global_string, "6.2 Запрещенна любая покупка чего-либо на проекте не через внутреигровую систему (/donate).\n\n\n");
	strcat(global_string, "Регламент данных правил может изменяться основателем проекта в любое время!");
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Правила "FULL_NAME"", global_string, !"Закрыть", !"");
	return true;
}
CMD:menu(playerid)
{
	show_dialog(playerid, d_menu, DIALOG_STYLE_LIST, "Меню", !"\
	{cccccc}1. {87CEEB}Инвентарь\n\
	{cccccc}2. {FFFFF0}Игровая статистика\n\
	{cccccc}3. {87CEEB}Отправить жалобу/вопрос администрации\n\
	{cccccc}4. {87CEEB}Настройка безопасности\n\
	{cccccc}5. {FFFFF0}Личные настройки\n\
	{cccccc}6. {FFFFF0}Анимации\n\
	{cccccc}7. {FFFFF0}Достижения\n\
	{cccccc}8. {FFFFF0}Изготовление\n\
	{cccccc}9. {87CEEB}Дополнительные услуги\n\
	{cccccc}10. {87CEEB}О сервере\n\
	{cccccc}11. {FFFFF0}Мои приглашенные игроки", !"Выбрать", !"Закрыть");
	return true;
}
CMD:friends(playerid)
{
	show_dialog(playerid, d_friends, DIALOG_STYLE_LIST, "Мои приглашенные игроки", !"\
	{cccccc}1. {87CEEB}Список приглашенных друзей\n\
	{cccccc}2. {FFFFF0}Награда за приглашение\n\
	{cccccc}Информация", !"Выбрать", !"Назад");
	return true;
}
/*CMD:testin(playerid, params[])
{
	if(sscanf(params, "i", params[0])) return server_error(playerid, "/testin [номер]");
	if(params[0] < 1 || params[0] > 8) return server_error(playerid, "Номер от 1 до 8");
	if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "В автомобиле нельзя!");
	switch(params[0])
	{
	case 1: 
		{
			server_message(playerid, "ОРВИ");
			SetPlayerDrunkLevel(playerid, 5*1000);
			OnePlayAnim(playerid,"GRAVEYARD","mrnF_loop", 4.0, 0, 0, 0, 0, 0);
		}
	case 2: 
		{
			server_message(playerid, "Гастрита");
			OnePlayAnim(playerid, "FOOD", "EAT_Vomit_P", 4.0, 0, 0, 0, 0, 0);
		}
	case 3: 
		{
			server_message(playerid, "Недержания мочи");
			SetPlayerSpecialAction(playerid, 68);
			OnePlayAnim(playerid, "PAULNMAC", "Piss_in", 4.4, 1, 0, 0, 0, 5000);
		}
	case 4: 
		{
			server_message(playerid, "Психического расстройства");
			OnePlayAnim(playerid,"PED","HIT_back", 0.1, 1, 0, 0, 0, 10000);
		}
	case 5: 
		{
			server_message(playerid, "Эпилепсия");
			OnePlayAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 15000);
		}
	case 6: 
		{
			server_message(playerid, "Артрит");
			OnePlayAnim(playerid,"SCRATCHING","scdrdlp", 4.0, 0, 0, 0, 0, 0);
		}
	case 7: 
		{
			server_message(playerid, "Астма");
			SetPlayerDrunkLevel(playerid, 7*1000);
			OnePlayAnim(playerid,"PAULNMAC","PnM_Argue2_A", 4.0, 0, 0, 0, 0, 0);
		}
	case 8: 
		{
			server_message(playerid, "Пневмония");
			OnePlayAnim(playerid,"HEIST9","CAS_G2_GasKO", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return true;
}*/
CMD:needs(playerid)
{
	new format_string[456];
	format(format_string, sizeof(format_string), "{fffff0}Голод:\t\t{90EE90}%s {fffff0}%i%%\nЖажда:\t\t{ADD8E6}%s {fffff0}%i%%\nЗаражение:\t{FFA07A}%s {fffff0}%i%%", 
	PointOfStatus(users[playerid][u_hunger], 100 - users[playerid][u_hunger]), users[playerid][u_hunger], 
	PointOfStatus(users[playerid][u_thirst], 100 - users[playerid][u_thirst]), users[playerid][u_thirst], 
	PointOfStatus(users[playerid][u_infected], 100 - users[playerid][u_infected]), users[playerid][u_infected]);
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "Потребности", format_string, !"Закрыть", !"");
	return true;
}
CMD:commands(playerid)
{
	show_dialog(playerid, d_cmd, DIALOG_STYLE_LIST, !"Команды сервера", !"\
	{cccccc}1. {ffffff}Основные команды\n\
	{cccccc}2. {ffffff}Команды для чата\n\
	{cccccc}3. {ffffff}Команды для клана\n\
	{cccccc}4. {ffffff}Команды для базы\n\
	", !"Выбрать", !"Закрыть");
	return true;
}
CMD:pay(playerid, params[])
{
	if(sscanf(params, "ud", params[0], params[1])) return server_error(playerid, "Используйте: /pay [ид/имя] [сумма]");
    if(PlayerIsOnline(params[0])) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	if(!users[playerid][u_vip_time])
	{
	    if(params[1] < 1 || params[1] > 10000) return server_error(playerid, "Сумма должна быть от 1 до 10000 за раз.");
	}
	else
	{
	    if(params[1] < 1 || params[1] > 50000) return server_error(playerid, "Сумма должна быть от 1 до 50000 за раз.");
	}
	if(!IsPlayerInRangeOfPlayer(3.0, playerid, params[0])) return server_error(playerid, "Вы слишком далеко от игрока");
	if(users[playerid][u_money] < params[1]) return server_error(playerid, "У вас недостаточно денег.");
	// users[params[0]][u_money] += params[1];
	// users[playerid][u_money] -= params[1];
	money(params[0], "+", params[1]);
	money(playerid, "-", params[1]);
	SaveUser(params[0], "money");
	SaveUser(playerid, "money");
	SCMG(playerid, "Вы передали %s(%i), %i денежных средств.", users[params[0]][u_name], params[0], params[1]);
	SCMG(params[0], "Вы получили %i вирт от %s(%i).", params[1], users[playerid][u_name], playerid);
	PlayerPlaySound(params[0], 1052, 0.0, 0.0, 0.0);
	//format(stringer, sizeof(stringer), "достал бумажник и передал деньги %s", users[params[0]][u_name]);
	//SetPlayerChatBubble(playerid, stringer, COLOR_PURPLE, 30.0, 10000);
	return true;
}
CMD:whisper(playerid, params[])
{
	if(users[playerid][u_mute]) return SCMASS(playerid, "Чат заблокирован. Осталось: %i секунд(ы).", users[playerid][u_mute]);
	if(sscanf(params, "s[128]", params[0]))return server_error(playerid, "Используйте: /w [текст]");
 	static str[144];
	format(str, sizeof(str), "%s(%d) шепчет: %s.", users[playerid][u_name], playerid, params[0]);
	ProxDetector(playerid, 2.0, str, 0x7AADA8AA, 0x7AADA8AA, 0x7AADA8AA, 0x7AADA8AA, 0x7AADA8AA);
	return true;
}
CMD:shout(playerid, params[])
{
	if(users[playerid][u_mute]) return SCMASS(playerid, "Чат заблокирован. Осталось: %i секунд(ы)", users[playerid][u_mute]);
	if(sscanf(params, "s[128]", params[0]))return server_error(playerid, "Используйте: /s [текст]");
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "ON_LOOKERS", "shout_in", 9000.999, 0, 0, 0, 0, 0, 1);
 	static str[144];
	format(str, sizeof(str), "%s(%i) крикнул(а): %s!!.", users[playerid][u_name], playerid, params[0]);
	ProxDetector(playerid, 50.0, str);
	return true;
}
CMD:eject(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы должны быть в машине!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return server_error(playerid, "Вы должны быть на водительском месте!");
	if(sscanf(params, "u", params[0])) return server_error(playerid, "Используйте: /eject [имя/id]");
	if(!IsPlayerConnected(params[0])) return server_error(playerid, "Игрок не найден!");
	if(params[0] == playerid) return server_error(playerid, "Вы не можете выкинуть из машины себя!");
	if(!IsPlayerInVehicle(params[0], GetPlayerVehicleID(playerid))) return server_error(playerid, "Игрок не находится в вашем автомобиле!");
	SCMG(playerid, "Вы выкинули из машины %s!", users[params[0]][u_name]);
	SCMASS(params[0], "Вас выкинул из машины %s!", users[playerid][u_name]);
	RemovePlayerFromVehicle(params[0]);
	//TogglePlayerControllable(params[0], true);
	return 1;
}
CMD:car(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы должны находиться в транспортном средстве.");
	if(IsABycicle(GetPlayerVehicleID(playerid))) return server_error(playerid, "На велике нельзя.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return server_error(playerid, "Вы должны быть на водительском месте.");
	// static engine, lights, alarm, doors, bonnet, boot, objective;
	// GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
	static str[156];
	if(IsABike(GetPlayerVehicleID(playerid))) 
	{
		format(str, sizeof(str), "Название\tСтатус\n\
		Двигатель:\t%s\nФары:\t%s", 
		(car_engine{GetPlayerVehicleID(playerid)})?("{33AA33}Включен"):("{A52A2A}Выключен"),
		(car_lights{GetPlayerVehicleID(playerid)})?("{33AA33}Включены"):("{A52A2A}Выключены"));
		show_dialog(playerid, d_car, DIALOG_STYLE_TABLIST_HEADERS, !"Меню транспортного средства", str, !"Выбрать", !"Закрыть");
		return true;
	}
	if(IsBoatsAirplans(GetPlayerVehicleID(playerid))) 
	{
		format(str, sizeof(str), "Название\tСтатус\nМотор:\t%s", (car_engine{GetPlayerVehicleID(playerid)})?("{33AA33}Включен"):("{A52A2A}Выключен"));
		show_dialog(playerid, d_car, DIALOG_STYLE_TABLIST_HEADERS, !"Меню транспортного средства", str, !"Выбрать", !"Закрыть");
		return true;
	}
	if(!IsBoatsAirplans(GetPlayerVehicleID(playerid)) && !IsABike(GetPlayerVehicleID(playerid)))
	{
		format(str, sizeof(str), "Название\tСтатус\n\
		Двигатель:\t%s\nФары:\t%s\nБагажник:\t%s\nКапот:\t%s", 
		(car_engine{GetPlayerVehicleID(playerid)})?("{33AA33}Включен"):("{A52A2A}Выключен"),
		(car_lights{GetPlayerVehicleID(playerid)})?("{33AA33}Включены"):("{A52A2A}Выключены"),
		(car_boot{GetPlayerVehicleID(playerid)})?("{33AA33}Открыт"):("{A52A2A}Закрыт"), 
		(car_bonnet{GetPlayerVehicleID(playerid)})?("{33AA33}Открыт"):("{A52A2A}Закрыт"));
		show_dialog(playerid, d_car, DIALOG_STYLE_TABLIST_HEADERS, !"Меню транспортного средства", str, !"Выбрать", !"Закрыть");
		return true;
	}
	return true;
}
CMD:id(playerid, params[])  
{  
	if(sscanf(params, "s[24]", params[0])) return server_error(playerid, "Используйте: /id [Часть ника]");
	// if(params[0] == playerid) return server_error(playerid, "Вы указали свой ID/Ник.");  
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
	if(!index_) return server_error(playerid, "Совпадений не найдено.");  
	if(index_ > 1) strcat(global_string, "\n\n{cccccc}Найдено несоклько совпадений.\n");
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "Совпадения", global_string, "Ок", "");
    return 1;  
}  
CMD:cancel(playerid)
{
	if(!strcmp(temp[playerid][player_setname], "NoChangeName")) return server_error(playerid, "Вы не подавали заявку на смену ника.");
	SCMG(playerid, "Вы отказались от смены ника. Ник, который был в заявке: %s.", temp[playerid][player_setname]);
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
		strcat(global_string, "№\tНовое имя\tПредыдущие имя\tДата смены\n");
		for(new idx = 1; idx <= rows; idx++)
		{
			cache_get_value_name(idx-1, "uh_name_new", name[0], MAX_PLAYER_NAME);
			cache_get_value_name(idx-1, "uh_name_old", name[1], MAX_PLAYER_NAME);
			cache_get_value_name(idx-1, "uh_date", name[2], MAX_PLAYER_NAME);
			format(str, sizeof(str), "{cccccc}%i.\t{ADD8E6}%s\t{cccccc}%s\t{ADD8E6}%s\n", idx, name[0], name[1], name[2]);
			strcat(global_string, str);
		}
		show_dialog(playerid, d_none, DIALOG_STYLE_TABLIST_HEADERS, !"История ников", global_string, !"Ок", !"");
	}
	else server_error(playerid, "Вы еще не меняли ники!");
	cache_delete(temp_sql);
	return true;
}
CMD:animation(playerid, params[])
{
	if(sscanf(params, "i", params[0]))
	{
		show_dialog(playerid, d_anim, DIALOG_STYLE_LIST, "Анимации", "\
		{fffff0}Вы можете использовать: {FFE4B5}/anim [номер анимации]\n\
		{cccccc}1.\t {fffff0}Притворится мёртвым\n\
		{cccccc}2.\t {fffff0}Попрощаться\n\
		{cccccc}3.\t {fffff0}Укрыться\n\
		{cccccc}4.\t {fffff0}Присесть\n\
		{cccccc}5.\t {fffff0}Стыд\n\
		{cccccc}6.\t {fffff0}Позвать кого-то\n\
		{cccccc}7.\t {fffff0}Руки вверх\n", !"Выбрать", !"Закрыть");
		// server_error(playerid, "Вы можете использовать: /anim [номер анимации]");
		return true;
	}
	if(params[0] < 1 || params[0] > 7) return server_error(playerid, "Номер анимации может быть от 1 до 7.");
	animations(playerid, params[0]);
	return true;
}