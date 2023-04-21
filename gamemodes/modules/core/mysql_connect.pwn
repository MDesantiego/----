/*
    Описание: Подключение к mysql;
    Автор: zummore;
  #include "a_mysql" */
#if defined _mysql_included
	#endinput
#endif
#define _mysql_included

new 										MySQL:database;

#define SQL_VER   							"MySQL R41-4"

#define SQL_HOST							"localhost"
#define SQL_USER							"H46184"
#define SQL_PASS							"adgagasdga"
#define SQL_BASE							"EVE46184"

#define TEST_SQL_HOST						"127.0.0.1"
#define TEST_SQL_USER						"root"
#define TEST_SQL_PASS						""
#define TEST_SQL_BASE						"defiant" 

#define m_format(							mysql_format(database,
#define m_tquery(							mysql_tquery(database,
#define m_query(							mysql_query(database,

#define TABLE_USERS 						"`users`"
#define TABLE_ADMIN 						"`users_admins`"
#define TABLE_BAN 							"`users_bans`"
#define TABLE_MARKETPLACE					"`users_marketplace`"
#define TABLE_BANIP 						"`users_bans_ip`"
#define TABLE_CLAN	 						"`users_clans`"
#define TABLE_QUEST		 					"`users_quest`"
#define TABLE_BASE	 						"`bases`"
#define TABLE_LOOT	 						"`server_loots`"
#define TABLE_BOX 							"`server_box`"
#define TABLE_ZOMBIE 						"`zombies`"
#define TABLE_MESSAGE	 					"`server_message`"
#define TABLE_CRAFT_TOOLS	 				"`server_craft_tools`"
#define TABLE_CARS							"`server_vehicles`"
#define TABLE_ANTICHEAT               		"`anticheat`"
#define TABLE_ADMINS_LOGS 					"`logs_admin`"
#define TABLE_USERS_LOGIN 					"`users_info_login`"
#define TABLE_HISTORY_NAME	 				"`users_history_name`"
#define TABLE_CONCLUSION					"`users_conclusion`"

#define TABLE_SKIN  						"`skin_menu`"
/*

	OnGameModeInit;

*/
public OnGameModeInit()
{
	new 
		server_ip[16], 
		MySQLOpt: option_id = mysql_init_options();
    mysql_set_option(option_id, AUTO_RECONNECT, true);
    GetServerVarAsString("bind", server_ip, sizeof(server_ip));
    if(!strcmp(server_ip, "127.0.0.1", false)) database = mysql_connect(TEST_SQL_HOST, TEST_SQL_USER, TEST_SQL_PASS, TEST_SQL_BASE, option_id);
	else database = mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_BASE, option_id);
    if(database == MYSQL_INVALID_HANDLE || mysql_errno(database) != 0) 
	{
		print("["SQL_VER"]: Подключиться к базе данных не удалось.");
        // SendRconCommand("exit");
        return true;
    }
    print("["SQL_VER"]: Подключение к базе успешно.");
	m_tquery(!"SET CHARACTER SET 'utf8'", "", "");
	m_tquery(!"SET NAMES 'utf8'", "", "");
	m_tquery(!"SET character_set_client = 'cp1251'", "", "");
	m_tquery(!"SET character_set_connection = 'cp1251'", "", "");
	m_tquery(!"SET character_set_results = 'cp1251'", "", "");
	m_tquery(!"SET SESSION collation_connection = 'utf8_general_ci'", "", "");

	m_query("ALTER TABLE "TABLE_BOX" MODIFY `box_id` INT(11);");
    m_tquery("ALTER TABLE "TABLE_BOX" DROP PRIMARY KEY; ");
	m_query("UPDATE "TABLE_BOX" SET `box_id` = '0';");
	m_query("ALTER TABLE "TABLE_BOX" AUTO_INCREMENT = 0;");
	m_query("ALTER TABLE "TABLE_BOX" MODIFY `box_id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY;");
	
	m_query("ALTER TABLE "TABLE_CRAFT_TOOLS" MODIFY `craft_id` INT(11);");
	m_query("ALTER TABLE "TABLE_CRAFT_TOOLS" DROP PRIMARY KEY; ");
	m_query("UPDATE "TABLE_CRAFT_TOOLS" SET `craft_id` = '0';");
	m_query("ALTER TABLE "TABLE_CRAFT_TOOLS" AUTO_INCREMENT = 0;");
	m_query("ALTER TABLE "TABLE_CRAFT_TOOLS" MODIFY `craft_id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY;");

	if(test_server == false) 
	{
		m_query("DELETE FROM "TABLE_BOX" WHERE NOW() > (`box_last_use` + INTERVAL 21 DAY);");
		m_query("DELETE FROM "TABLE_CRAFT_TOOLS" WHERE NOW() > (`craft_date_use` + INTERVAL 21 DAY);");
		m_query("DELETE FROM "TABLE_CLAN" WHERE `c_reprimand` > 2;");
		m_query("UPDATE "TABLE_BASE" SET `b_owner_name` = 'NoOwner', `b_owner_id` = '0', `b_lock_status` = '0', `b_lock_password` = '1234', `b_delete_date` = ' ', `b_buy_date` = ' ' WHERE `b_owner_id` != '0' AND `b_delete_date` < NOW()");
	}
	//m_tquery("SELECT * FROM "TABLE_ZOMBIE"", "@LoadZombie");
	m_tquery("SELECT * FROM "TABLE_CARS"", "@LoadingOfCars");
	m_tquery("SELECT * FROM "TABLE_CLAN"", "@LoadClan");
	m_tquery("SELECT * FROM "TABLE_LOOT"", "@LoadLoots");
	m_tquery("SELECT * FROM "TABLE_BASE" WHERE `b_price` != '0'", "@LoadBase");
	m_tquery("SELECT * FROM "TABLE_CRAFT_TOOLS"", "@LoadingCraftTools");
	m_tquery("SELECT * FROM "TABLE_ANTICHEAT" ORDER BY `ac_code`", "@LoadAntiCheat");
	m_tquery("SELECT * FROM "TABLE_BOX"", "@LoadBox");
	m_tquery ( "SELECT * FROM "TABLE_SKIN"", "LoadDynamicSkin" );
	
	ShowNameTags(1);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	SetNameTagDrawDistance(20.0);
	ManualVehicleEngineAndLights();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_STREAMED);

	ServerRestarted = -1;
	ReLootTime = TimeForReLoot;

	SetGameModeText(""MODE_NAME"");
	SendRconCommand("weburl "SITE_NAME"");
	SendRconCommand("hostname "HOST_NAME"");
	SendRconCommand("language "LANG_NAME"");
	SendRconCommand("rcon_password "RCON_NAME"");

	// mail_init("hostde15.fornex.org", "support@defiant-blood.com", "%3ChURJyBRBpT5b^", "support@defiant-blood.com", FULL_NAME); 
    // HTTP(0, HTTP_POST, ""SITE_NAME"/System/plugins/message_mail.php", "email=zummore@mail.ru&message=1", "@OnPlayerReceiveMessage");
#if defined MC_OnGameModeInit
    return MC_OnGameModeInit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit MC_OnGameModeInit
#if defined   MC_OnGameModeInit
	forward MC_OnGameModeInit();
#endif 
/*

	OnGameModeExit;

*/
public OnGameModeExit()
{
	mysql_close(database);
#if defined MC_OnGameModeExit
    return MC_OnGameModeExit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit MC_OnGameModeExit
#if defined   MC_OnGameModeExit
	forward MC_OnGameModeExit();
#endif 
