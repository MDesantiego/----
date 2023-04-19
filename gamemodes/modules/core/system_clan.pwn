
/*
	Подсветка ников для сокланевцев
*/
stock clan_syntax(playerid)
{
	// if(!users[playerid][u_clan]) foreach(Player, i) SetPlayerMarkerForPlayer(playerid, i, 0xFFFFFF00);
	foreach(Player, i)
	{
		if(!users[playerid][u_clan] && !admin[playerid][admin_level])
		{
			SetPlayerMarkerForPlayer(i, playerid, 0xFFFFFF00);
			SetPlayerMarkerForPlayer(playerid, i, 0xFFFFFF00);
			continue;
		}
		if(admin[i][admin_level] && admin[playerid][admin_level])
		{
			SetPlayerMarkerForPlayer(i, playerid, 0xCD5C5CFF);
			SetPlayerMarkerForPlayer(playerid, i, 0xCD5C5CFF);
			continue;
		}
		if(!users[playerid][u_clan]) continue;
		if(users[i][u_clan] != users[playerid][u_clan]) continue;
		// if(i == playerid) continue;
		SetPlayerMarkerForPlayer(i, playerid, 0x98FB98FF);
		SetPlayerMarkerForPlayer(playerid, i, 0x98FB98FF);
	}
	return true;
}