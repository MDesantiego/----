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