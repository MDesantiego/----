new const bool: test_server = false;

//Быстрое изменение сервера:
#define NUMB_SERV                           "1"
#define IP_ADRESS                           "81.176.176.14:7777"
#define FULL_NAME   						"WAR PROJECT"
#define LEFT_NAME   						"WAR ZONE"
#define MODE_NAME   						"WP-GM 1.0"
#define HOST_NAME   						""FULL_NAME" | Вооруженный конфликт России и Украины" 
// #undef HOST_NAME
// #define HOST_NAME							"IP: 81.176.176.17:7777"
#define LANG_NAME   						"RU/UA"
#define VKON_NAME   						"vk.com/defiantblood"
#define SITE_NAME   						"defiant-blood.com"
#define FORU_NAME   						"forum."SITE_NAME""
#define RCON_NAME   						"qQOKY1oJD2TbXLmz"

//Версии и данные о моде:
// #define ZUMMORE								"vk.com/a.diazz"

//Настройки игравого мода:
#define TimeForReLoot						130// Время перезагрузки лута в минутах

#undef MAX_PLAYERS
#define MAX_PLAYERS							256

#undef MAX_VEHICLES
#define MAX_VEHICLES						1000

#define KEY_AIM 							128

#define MAX_FIRE 							255
#define MAX_CRAFT							4000
#define MAX_PICKUP   						2//Кол-во пикапов
#define MAX_CLANS							2500//Макс. кол-во кланов

#define COLOR_BROWN							0xCD5C5CAA
#define COLOR_ALL							0x8FBC8FAA
#define COLOR_ADMIN							0xA52A2AAA
//Функции:
#define m_format(							mysql_format(database,
#define m_tquery(							mysql_tquery(database,
#define m_query(							mysql_query(database,
#define void%0(%1)							forward %0(%1); public %0(%1)
#define PlayerIsOnline(%0)					!temp[%0][temp_login] || !temp[%0][temp_spawn] || IsPlayerNPC(%0)
#define AdminProtect(%1)   					if(admin[playerid][admin_level] < %1 || admin[playerid][u_a_dostup] != 1) return NoCommand(playerid)
#define AdminChatF(%1,%2)					format(format_string_, sizeof(format_string_), %1,%2) && AdminChat(format_string_, 1)
#define SCMF(%0,%1,%2,%3) 					format(format_string_, sizeof(format_string_), %2, %3) && SendClientMessage(%0, %1, format_string_)
#define SCMAF(%0,%1,%2) 					format(format_string_, sizeof(format_string_), %1, %2) && SendClientMessageToAll(%0, format_string_)
#define ClearChatForPlayer(%0);				for(new clear = 0; clear != 15; clear++) { SendClientMessage(%0, COLOR_GREY, " "); }

#define SCMG(%0,%1,%2)						format(format_string_, 144, %1,%2) && server_accept(%0,format_string_)
#define SCMASS(%0,%1,%2)					format(format_string_, 144, %1,%2) && server_error(%0,format_string_)

#define PRESSED(%0)                 		(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define NOPRESSED(%0)                 		(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

#define random_ex(%1,%2)					(random(%2-%1)+%1)

// Переменные:
// new PlayerSpawned[MAX_PLAYERS]; // Как будет время перемести в temp;
new global_string[3048]; // Глобальная переменная;
new format_string_[256]; // Глобальная мини переменная;
new GPS_Zone[MAX_PLAYERS][2]; // 0 - Время показа названия локации, 1 - Номер локации;

new Text3D: users_death [ MAX_PLAYERS ]; 

new global_hour, global_minute, global_second; // Переменные для записи времени;
new Text3D: users_nickname[MAX_PLAYERS]; // Ник игрока;
new users_register[MAX_PLAYERS][4][65]; // Временное хранение данных при регистрации;
// new email_code[MAX_PLAYERS]; // Код отправленный на почту;
new get_weapon_player[MAX_PLAYERS][6][2]; // Для записи оружия и патрон на игроке;

new 
	weather_index,
	PlayerBan[MAX_PLAYERS];
new actor[4],
	count_veh = 0,
	ServerRestarted = -1;
new LogsChat[MAX_PLAYERS][20][128];
enum templ {
	temp_text[96],
	bool: temp_login,
	bool: temp_spawn,
	temp_timer,
	bool: temp_use_map,

	// bool:login_player,
	// use_dialog,
	// protect_gun_info,
	bool:gps,
	timer_speedomitr,
	time_infinity_health,
	infinity_health,
	LoginRegisterTime,
	// UserRegister,
	temp_email_code[MAX_PLAYER_NAME],
	googleauth[17],
	// temp_email[65],
	BaseGuardGate,
	TimeUsePack,
	// protect_loading,
	// protect_info_hunger,
	// protect_info_thirst,
	player_box,

	player_setname[MAX_PLAYER_NAME],

	marketplace_list,
	marketplace_lastid,

	marketplace_item,
	marketplace_price,
	marketplace_value,
	marketplace_items[15],
	
	temp_register [ 3 ],
	tMissStamina,
	perk_KD [ 2 ],

	tSelect,
	tSelect_1,

	bool:t_inv_new_slot,
	t_inv_old_slot_id,
};
new temp[MAX_PLAYERS][templ];

enum {
	d_none,
	d_register_password,
	d_register_email,
	d_register_email_question,
	d_register_email_confirmation,
	d_register_friend,
	d_register_floor,
	d_register_info, 
	d_login, 
	d_report,
	d_report_admin,
	d_report_admin_otvet,
	d_admin_login,
	d_admin_panel_cmd,
	d_admin_panel,
	d_admin_panel_settings,
	d_donate_menu,
	d_donate,
	d_donate_vip,
	d_donate_clan,
	d_donate_konvert,
	d_donate_items,
	d_donate_base,
	d_donate_base_buy,
	d_donate_spawn,
	d_donate_skin,
	d_donate_skin_2,
	d_donate_starter,
	d_clan,
	d_clan_close_panel,
	d_clan_inv,
	d_clan_invite,
	d_clan_invite_player,
	d_clan_uninvite,
	d_clan_uninvite_offline,
	d_clan_leave,
	d_clan_ranks,
	d_clan_skin,
	d_clan_rank_zam,
	d_clan_name,
	d_clan_abbr,
	d_clan_rasform,
	d_clan_delete,
	d_clan_ranks_edit,
	d_clan_give_rank,
	d_clan_change_spawn,
	d_vip,
	d_vip_settings,
	d_menu,
	d_base,
	d_base_password,
	d_base_new_password,
	d_base_change_password,
	d_takedrop,
	d_shop_menu,
	d_teleport,
	d_teleport_1,
	d_teleport_base,
	d_anticheat_menu,
	d_anticheat_settings,
	d_ban,
	d_ban_ip,
	d_cmd,
	d_cmd_back,
	d_box_take,
	d_box_put,
	d_box_castle,
	d_box_code,
	d_box_change_code,
	d_box_change_code_2,
	d_box_delete,
	d_box_1,
	d_box_2,
	d_box_3,
	d_recon_kick,
	d_recon_mute,
	d_recon_iban,
	d_recon_ban,
	d_inventory,
	d_inventory_menu,
	d_inventory_drop,
	d_settings,
	d_settings_r,
	d_settings_spawn,
	d_clan_money,
	d_clan_money_2,
	d_change_spawn,
	d_security,
	d_security_old_pass,
	d_security_new_pass,
	d_security_email,
	d_security_email_pass,
	d_security_email_code,
	d_security_email_googleauth,
	d_security_googleauth_off,
	d_security_googleauth,
	d_security_code_off,
	d_security_email_cod,
	d_security_code,
	d_googleauth,
	d_starter,
	d_click_to_player,
	d_car,
	d_car_inv,
	d_the_choice,
	d_car_put,
	d_medikal_box,
	d_achievements,
	d_achievements_back,
	d_store,
	d_store_clothes,
	d_store_buy_and_sell,
	d_craft,
	d_craft_tools_use,
	d_craft_password,
	d_craft_setpass,
	d_green_shop,
	d_inventory_stol,
	d_marketplace,
	d_marketplace_buy,
	d_marketplace_buy_two,
	d_marketplace_to_sell,
	d_marketplace_item,
	d_marketplace_item_two,
	d_marketplace_item_three,
	d_inventory_pech,
	d_marketplace_myitem,
	d_marketplace_myitem_two,
	d_marketplace_getpay,
	d_marketplace_paydonate,
	d_setname,
	d_setname_accept,
	d_base_menu,
	d_menu_drop,
	// d_donate_getpay,
	// d_donate_getpay_qiwi,
	// d_donate_getpay_qiwi_number,
	// d_donate_getpay_qiwi_cancel,
	d_conclusion,
	d_conclusion_choice,
	d_conclusion_act,
	d_anim,
	d_campfire,
	d_usetoh, 
	d_friends,
	d_reward
};
new ReLootTime;

enum structure_clan
{
	c_id,
	c_owner[MAX_PLAYER_NAME],
	c_name[MAX_PLAYER_NAME],
	c_name_abbr[MAX_PLAYER_NAME],
	Float:c_spawn_xyzf[4],
	c_spawn_wi[2],
	c_kills,
	c_rank_zam,
	c_skin,
	c_reprimand
};
new clan[MAX_CLANS][structure_clan];
new c_rank[MAX_CLANS][5][MAX_PLAYER_NAME];
new Float: PickXYZ[MAX_PICKUP][1][3] =
{
	// {{-929.9669,2025.5354,62.4659}} // Магазин на дамбе
	{{-926.5366,2036.1575,60.9141}}, // Магазин на дамбе
	{{-2516.6284,2513.2991,18.8233}} // Магазин в ЗЗ
};
new PickWorld[MAX_PICKUP][1][1] =
{
	{{0}}, // Магазин на дамбе
	{{0}} // Магазин в ЗЗ
};
new PickManager[MAX_PICKUP];
new const weather[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20 };
enum structure_recon 
{
	observation_id,
	Float: observation_XYZF[4],
	observation_WI[2]
};
new observation[MAX_PLAYERS][structure_recon];
new AntiBagAutoDoop[MAX_PLAYERS]; //Авто

new PlayerText:Captcha[12], //Секретный пароль TD
	TextArray[11] = "1234567890";  //Секретный пароль TD
enum e_MediksBox { Float: med_x, Float: med_y, Float: med_z, med_slot, med_object }
new const MediksBoxData[][e_MediksBox] = {
	{2022.92603, -1404.79895, 17.20200,7,-1}, 
	{2035.96741, -1404.84961, 17.20200,7,-1}, 
	{-319.05429, 1050.41174, 20.14490,7,-1},
	{-1514.68848, 2523.88940, 55.56000,7,-1}, 
	{1608.24475, 1764.46313, 37.15800,7,-1}, 
	{1615.00000, 1821.15344, 10.64750,7,-1},
	{1599.20093, 1821.15894, 10.64750,7,-1}, 
	{-2684.16406, 637.28497, 14.48910,7,-1}, 
	{-2642.67505, 637.34161, 14.48910,7,-1},
	{-2666.30542, 637.44049, 14.48910,7,-1}, 
	{-2706.50586, 637.39001, 14.48910,7,-1} 
};
new MediksBox[11][max_items];
new const random_skin[][2] = // 0 - женский; 1 - мужской;
{
	{41, 176},
	{13, 289},
	{41, 35},
	{298, 37},
	{65, 73}
};
new const Float: random_position[][3] = 
{
	{154.2890, -1943.4993, 3.7734},
	{33.8894, -2650.0532, 40.7285},
	{953.1413, -909.6761, 45.7656},
	{2027.2528, -1421.4906, 16.9922},
	{2232.7686, -1333.1693, 23.9815},
	{2413.5105, -1425.9867, 23.9847},
	{2953.9294, -1487.1438, 1.6221},
	{2770.5527, -1628.0830, 12.1775},
	{2648.3923, -2021.9827, 13.5469},
	{2371.6375, -2500.3308, 3.0000},
	{2725.8638, -2327.7861, 3.0000},
	{2492.8826, -1956.7833, 13.5978},
	{1154.3335, -1770.7742, 16.5938},
	{1129.9063, -1483.3605, 22.7690},
	{915.6270, -1235.1580, 17.2109},
	{727.3074, -1276.2958, 13.6484},
	{386.4682, -1818.0546, 7.8410},
	{669.3777, -1867.3281, 5.4537},
	{-88.9715, -1564.7681, 3.0043},
	{-448.8276, -1320.5139, 32.8248},
	{-347.7105, -1046.3442, 59.8125},
	{-516.2578, -497.9338, 25.5234},
	{-579.8055, -1059.3873, 23.5437},
	{-396.3575, -1440.0033, 25.7209},
	{-256.3683, -1082.5482, 21.9013},
	{1846.4335, -1511.5260, 13.3638},
	{2649.8647, -1390.3694, 30.4514}, 
	{1930.3910, -1196.7496, 20.0311},
	{2009.1240, -1008.3203, 29.8449},
	{1809.9667, -1056.2428, 24.1024},
	{1549.5331, -28.2500, 21.3279}
};		
enum achievement_structure { achievement_name[MAX_PLAYER_NAME], achievement_about[40], achievement_progress }
new const achievements[][achievement_structure] =
{
	{"Убить чтобы выжить", "10 стартеров выжившего", 100},
	{"Убийца", "20 военных стартеров", 500},
	{"Мородер", "30 снайперских стартеров", 1000},
	{"Монстр", "Колокольчик при поподании в игрока", 5000},

	{"Это больше не люди", "30 стартеров выжившего", 100},
	{"Мясник", "300.000$ игровой валюты", 500},
	{"Гроза зомби", "700.000$ игровой валюты", 1000},
	{"Истинный выживший", "100 снайперских стартеров", 5000},

	{"Прожить хотя бы сутки", "5 кодовых замков", 86400},
	{"Я буду жить", "50 военных стартеров", 172800},

	{"Обед по расписанию", "50.000$ игровой валюты", 100},
	{"Обжора", "80.000$ игровой валюты", 500},
	{"Ненасытный", "100.000$ игровой валюты", 1000}
};
new prefix_colors[][2][25 + 1] = {
	{"Бирюза", "40E0D0"},
	{"Розовый", "FFC0CB"},
	{"Зеленый", "008000"},
	{"Лаванда", "E6E6FA"},
	{"Лазурный", "87CEEB"},
	{"Оранжевый", "FFA500"},
	{"SlateBlue", "6A5ACD"},
	{"Фиолетовый", "EE82EE"},
	{"Коралловый", "FF7F50"},
	{"Васильковый", "6495ED"},
	{"Ярко-розовый", "FF69B4"},
	{"Туманная Роза", "FFE4E1"},
	{"Бледно-Зеленый", "98FB98"},
	{"Стальной-Синий", "4682B4"},
	{"Черная орхидея", "9932CC"},
	{"Бледно-Бирюзовый", "AFEEEE"},
	{"Индийский Красный", "CD5C5C"},
	{"Темно-Золотой Стержень", "B8860B"},
	{"Бледно-Фиолетовый Красный", "DB7093"}
};
/*
	Система крафта
*/
new 
	// count_craft = 0,
	edit_player_object[MAX_PLAYERS],
	use_craft_tools_pila[MAX_PLAYERS],

	// use_object[MAX_PLAYERS],
	// object_create[MAX_PLAYERS],
	Float: craft_player_pos_xyz[MAX_PLAYERS][3];

enum crafting_table { craft_name[24], craft_model, craft_prochnost, craft_damage }
new craft_table[][crafting_table] =	{
	{"Деревянная дверь", 1506, 3, 3},
	{"Железная дверь", 2924, 300, 25},
	{"Циркулярный станок", 941, 5, 5},
	{"Верстак", 937, 5, 5},
	{"Электропечь", 943, 200, 25},
	{"Генератор", 920, 100, 25}
};
enum crafting_tools {
	craft_id,
	craft_type, // Тип 1 - Деревянная дверь, Тип 2 - Железная дверь, Тип 3 - Циркулярный станок, Тип 4 - Верстак, Тип 5 - Электропечь, Тип 6 - Генератор.
	craft_owner,
	craft_object,
	craft_health,
	craft_open,
	craft_password[MAX_PLAYER_NAME],
	Float: craft_XYZ[3],
	Float: craft_rXrYrZ[3],
	
	craft_pila_circular,
	craft_pila_circular_percent,
	craft_pila_timber,
	craft_pila_woords,
	craft_pila_progress,
	craft_pila_timer,

	craft_stol_one,
	craft_stol_two,
	craft_stol_progress,
	craft_stol_timer,
	craft_stol_item,
	
	craft_pech_battery,
	craft_pech_battery_progress,
	craft_pech_progress,
	craft_pech_metal,
	craft_pech_unwrought,
	craft_pech_timer
}
new craft_tool[MAX_CRAFT][crafting_tools];	
// new Pitemlistuse[MAX_PLAYERS][20]; // by Михаил Николенко (vk.com/id135178010)

enum marketplace_stucture {
	mp_id,
	// mp_owner,
	mp_item,
	mp_value,
	mp_price,
	mp_status
}
new marketplace[MAX_PLAYERS][marketplace_stucture];

//sss
new 
	// potect_gun[13],
	protect_ammo[MAX_PLAYERS][13]
	;
enum player_info 
{ 
	u_id,
	u_name[MAX_PLAYER_NAME],
	u_password[65],
	u_email[65],
	u_email_status,
	u_ip_registration[18],
	u_date_registration[20],
	u_gender,
	u_friend[MAX_PLAYER_NAME],
	u_adverting,
	u_newgame,
	u_code[8],
	u_googleauth[17],
	Float: u_spawn_xyz[4],
	u_spawn_wi[2],
	// u_connect_ip,
	u_clan,
	u_clan_rank,
	u_language,
	u_mute,
	u_kill[2],
	u_score,
	u_settings[8],
	u_donate_spawn,
	Float: u_donate_spawn_xyzf[4],
	u_donate_spawn_wi[2],
	u_donate_skin,
	u_settings_vip[4],
	Float: u_health,
	Float: u_armour,
	u_pack[5],
	u_damage[2], // 0 - кровотечение, 1 - перелом;
	u_hunger,
	u_thirst,
	u_achievement[13],
	u_eat_food,
	u_helmet,
	u_money,
	u_setname,
	u_vip_time,
	u_backpack,
	u_backpack_object,
	Float: u_temperature,
	u_lifetime,
	u_lifegame,
	u_karma,
	u_death,
	u_loot,
	u_skin,
	u_slots,
	u_humanity,
	u_infected,
	u_donate,
	u_reward[10],

	PlayertoItem, PlayerItem[max_items],
	
	pFraction,
	user_group,

	Float:u_stamina,
	u_perk,
	u_perk_level,
	u_adrenaline_use,
	u_adrenaline_otx,

	Float:u_X,
	Float:u_Y,
	Float:u_Z,

	u_injured,//Стадия
	u_injured_time,//Время стадии
	u_injured_leg,//Время ограничения бега
};
new users[MAX_PLAYERS][player_info];

enum fire_structure {
	fire_time,
	fire_object[2],
	Float: fire_xyz[3]
};
new fire[MAX_FIRE][fire_structure];
/*enum usetoh_structure {
	usetoh_type
	Float: usetoh_distance,
};
new usetoh[MAX_PLAYERS][usetoh_structure];*/
// new usetoh[MAX_PLAYERS][4][30];