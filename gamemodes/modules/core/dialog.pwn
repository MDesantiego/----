Dialog:dialog_player_group_ ( params_dialog )
{
	users [ playerid ] [ user_group ] = listitem + 1;
	
	new query [ 128 ];
	
	m_format ( query, sizeof ( query ), "UPDATE "TABLE_USERS" SET user_group = '%i' WHERE id = '%i'",
		users [ playerid ] [ user_group ],
		users [ playerid ] [ u_id ]
	);
	m_tquery ( query );
	
	SpawnPlayer(playerid);
	
	return 1;
}

Dialog:perk_craft ( params_dialog )
{
	if ( !response )
		return 1;

	switch ( listitem )
	{
		case 0:
		{
			if ( users [ playerid ] [ u_perk ] == 1 )
			{
				if ( temp [ playerid ] [ perk_KD ] [ 0 ] != 0 )
					return SEM ( playerid, "Вам необходимо подождать ещё %i минут(-ы).", temp [ playerid ] [ perk_KD ] [ 0 ] );

				ServerGivePlayerWeapon ( playerid, 16, 1 );
				temp [ playerid ] [ perk_KD ] [ 0 ] = KD_SHTURM_GRANATA;
			}
		}

		case 1:
		{
			if ( users [ playerid ] [ u_perk ] == 1 )
			{
				if ( temp [ playerid ] [ perk_KD ] [ 1 ] != 0 )
					return SEM ( playerid, "Вам необходимо подождать ещё %i минут(-ы).", temp [ playerid ] [ perk_KD ] [ 1 ] );

				ServerGivePlayerWeapon ( playerid, 35, 2 );
				temp [ playerid ] [ perk_KD ] [ 1 ] = KD_SHTURM_BAZYKA;
			}
		}

		default: return 1;
	}
	
	return 1;
}

Dialog:dialog_perk_select ( params_dialog )
{
	if ( !response )
		return 1;

	users [ playerid ] [ u_perk ] = listitem + 1;

	return 1;
}