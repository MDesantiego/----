
stock CreatePlayerInventory ( playerid )
{
	for ( new i = 0; i < 60; i ++ )
	{
		if ( i >= 30 )
		{
			new k = i-30;
			if ( user_items [ playerid ] [ k ] [ item_id ] == 0 )
				PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ i ], 17972 );
			else
				PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ i ], loots [ user_items [ playerid ] [ k ] [ item_id ] ] [ loot_object ] );
		}
		//user_items[MAX_PLAYERS][INVENTORY_USE][inventory_structure]
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ i ] );
	}
	SelectTextDraw ( playerid, COLOR_RED );
	return 1;
}

CMD:inv ( playerid )
{
	CreatePlayerInventory ( playerid );
	return 1;
}

stock HidePlayerInventory ( playerid )
{
	for ( new i = 0; i < 60; i ++ )
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ i ] );

	return 1;
}

CMD:hide_inv ( playerid )
{
	HidePlayerInventory ( playerid );
	return 1;
}