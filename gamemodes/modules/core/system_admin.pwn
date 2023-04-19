enum admin_structure 
{
	u_a_dostup,
	u_a_connect_players,
	u_a_gm,
	// u_a_protrct_ac,
	u_a_click_to_player,
	u_a_freeze,
	u_a_reprimand,
	

	admin_level,
	admin_color[11],
	admin_rank[40],
	admin_fulldostup,
	admin_protection,
	admin_settings[15]
}
new admin[MAX_PLAYERS][admin_structure];
new const stock admin_name_rank[][19+1] =
{
	"Мл. Помощник",
	"Ст. Помощник",
	"Мл. Администратор",
	"Ст. Администратор",
	"Гл. Администратор",
	"Спец. Администратор",
	"Основатель"
};
stock admin_rank_name(playerid)
{
	new format_string_name[40];
	format_string_name[0] = EOS;
	if(strcmp("no_color", admin[playerid][admin_color], false))
	{
		new format_string_color[11];
		format(format_string_color, sizeof(format_string_color), "{%s}", admin[playerid][admin_color]);
		strcat(format_string_name, format_string_color);
	}
	if(strcmp("no_rank", admin[playerid][admin_rank], false)) strcat(format_string_name, admin[playerid][admin_rank]);
	else strcat(format_string_name, admin_name_rank[admin[playerid][admin_level]-1]);
	return format_string_name;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ) 
{
    if(admin[playerid][admin_level] < 1) return true;
	if(!admin[playerid][admin_settings][1]) return true;
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) SetVehiclePos(GetPlayerVehicleID(playerid), fX, fY, fZ + 1.5);
    else SetPlayerPos(playerid, fX, fY, fZ + 1.5);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
	return 1; 
}