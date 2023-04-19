
new const full_dostup[][MAX_PLAYER_NAME] =
{
	"Moretti",
	"Grupotore",
	"Felix"
};
new const hide_admins[][MAX_PLAYER_NAME] = 
{
	"Moretti",
	"Grupotore",
	"Felix"
};
new const protection_admins[][MAX_PLAYER_NAME] =
{
	"Moretti",
	"Grupotore",
	"Felix"
};

stock ProtectionAdmins(name[])
{
	for(new pa_i = 0; pa_i < sizeof(protection_admins); pa_i ++) if(!strcmp(name, protection_admins[pa_i])) return true;
	return false;
}
stock HideAdmins(name[])
{
	for(new ha_i = 0; ha_i < sizeof(hide_admins); ha_i ++) if(!strcmp(name, hide_admins[ha_i])) return true;
	return false;
}
stock FullDostup(playerid, status = 0)
{
	switch(status)
	{
	case 0: for(new fd_i; fd_i < sizeof(full_dostup); fd_i ++) if(!strcmp(users[playerid][u_name], full_dostup[fd_i])) return 1;
	case 1: if(!strcmp(users[playerid][u_name], full_dostup[0])) return 1;
	}
	return 0;
}