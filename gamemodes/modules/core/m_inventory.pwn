//106 73 74 26..30 10..17, 59..62, 71..72 18..25, 63..66, 75..76

/*


*/

stock GiveWeapon2Slot ( playerid, slot, k )
{
	switch(slot)
	{
		/*case 38:
		{
			user_drop_equipment[playerid][listitem] = 0;
			users[playerid][u_armour] = 0;
			new Float: count_;
			GetPlayerArmour(playerid, count_);
			AddItem(playerid, 38, 1, floatround(count_, floatround_round));
			SetPlayerArmour(playerid, 0);
			server_accept(playerid, "Вы сняли бронжелет.");
			if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
		}
		case 78:
		{
			user_drop_equipment[playerid][listitem] = 0;
			users[playerid][u_helmet] = 0;
			AddItem(playerid, 78, 1);
			SetPlayerArmour(playerid, 0);
			server_accept(playerid, "Вы сняли шлем.");
			if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
		}*/
		case 0..13:
		{
			new weapon, ammo, ammo_ = 0;
			GetPlayerWeaponData(playerid, slot, weapon, ammo);
			// if(protect_ammo[playerid][user_drop_equipment[playerid][listitem]] > ammo) protect_ammo[playerid][user_drop_equipment[playerid][listitem]] = ammo;
			if(ammo > protect_ammo[playerid][slot]) ammo = protect_ammo[playerid][slot];
			
			user_items [ playerid ] [ k ] [ item_id ] = GetWeaponItem(weapon);
			user_items [ playerid ] [ k ] [ item_value ] = ammo;
			user_items [ playerid ] [ k ] [ item_quantity ] =
			user_items [ playerid ] [ k ] [ item_use_id ] =
			user_items [ playerid ] [ k ] [ item_use_value ] =
			user_items [ playerid ] [ k ] [ item_use_quantity ] = 0;
			
			RemovePlayerWeapon(playerid, weapon);
			SCMG(playerid, "Вы сняли оружие ''%s''", WeaponNames[weapon]);
		}
	}
	return 1;
}


stock GetWeaponMainSlot ( weaponid )
{
	switch ( weaponid )
	{
		case 25,26,27,28,29,30,31,33,34,35,36: return 1;
	}
	return 0;	 
}

stock CreatePlayerInventory ( playerid )
{
	TextDrawShowForPlayer ( playerid, inventory_TD );

	new saveweapon, 
		saveammo,
		bool:indx = false;

	for ( new i = 0; i < 13; i ++ )
	{
    	GetPlayerWeaponData ( playerid, i, saveweapon, saveammo );
		
		if ( GetWeaponMainSlot ( saveweapon ) != 1 )
			continue;
		
		indx = true;
		
		PlayerTextDrawSetSelectable ( playerid, inventory__TD [ playerid ] [ 168 ], 1 );
		PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ 168 ], GetWeaponModel ( saveweapon ) );

		new str_ [ 50 ];
		
		format ( str_, sizeof str_, "%i", saveammo );
		PlayerTextDrawSetString ( playerid, inventory__TD [ playerid ] [ 169 ], str_ );
		
		format ( str_, sizeof str_, "%s", WeaponNames [ saveweapon ] );
		PlayerTextDrawSetString ( playerid, inventory__TD [ playerid ] [ 170 ], str_ );

		PlayerTextDrawColor ( playerid, inventory__TD [ playerid ] [ 168 ], -1 );
		break;
	}

	if ( indx == false )
	{
		PlayerTextDrawSetSelectable ( playerid, inventory__TD [ playerid ] [ 168 ], 0 );
		PlayerTextDrawSetString ( playerid, inventory__TD [ playerid ] [ 169 ], "0" );
		PlayerTextDrawSetString ( playerid, inventory__TD [ playerid ] [ 170 ], TranslateText ( "Отсутствует" ) );
		PlayerTextDrawColor ( playerid, inventory__TD [ playerid ] [ 168 ], 255 );
	}
	
	PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ 168 ] );
	PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ 169 ] );
	PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ 170 ] );
	
	for ( new i = 0; i < 84; i ++ )
	{
		if ( i >= 30 && i <= 59 )
		{
			new k = i-30;
			if ( user_items [ playerid ] [ k ] [ item_id ] == 0 )
				continue;
			
			switch ( user_items [ playerid ] [ k ] [ item_id ] )
			{
				case 26,27,28,29,30,10,11,12,13,14,15,16,17,59,60,61,71,72,73,74,38,78:
				{
					PlayerTextDrawSetPreviewRot ( playerid, inventory__TD [ playerid ] [ i ], 23.000000, 0.000000, 46.000000, 2.499998 );
					PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ i ], loots [ user_items [ playerid ] [ k ] [ item_id ] ] [ loot_object ] );
				}
				default:
				{
					PlayerTextDrawSetPreviewRot(playerid, inventory__TD [ playerid ] [ i ], -10.000000, 0.000000, -20.000000, 1.000000);
					PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ i ], loots [ user_items [ playerid ] [ k ] [ item_id ] ] [ loot_object ] );
				}
			}
		}
		else if ( i >= 60 && i <= 75 )
		{
			if ( i >= 68 && i <= 75 )
			{
				new k = i - 38;
				if ( user_items [ playerid ] [ k ] [ item_id ] == 0 )
					continue;

				PlayerTextDrawSetPreviewRot(playerid, inventory__TD [ playerid ] [ i + 60 ], -10.000000, 0.000000, -20.000000, 1.000000);
				PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ i + 60 ], loots [ user_items [ playerid ] [ k ] [ item_id ] ] [ loot_object ] );
			}
			
			PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ i + 60 ] );
			continue;
		}
		else if ( i >= 76 )
		{
			if ( i >= 80 )
			{
				new k = i - 42;
				//80-38=
				if ( user_items [ playerid ] [ k ] [ item_id ] == 0 )
					continue;

				//SSM ( playerid, "%i", i + 76 );
				PlayerTextDrawSetPreviewRot(playerid, inventory__TD [ playerid ] [ i + 76 ], -10.000000, 0.000000, -20.000000, 1.000000);
				PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ i + 76 ], loots [ user_items [ playerid ] [ k ] [ item_id ] ] [ loot_object ] );
			}
			
			PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ i + 76 ] );
			continue;
		}
		//152->159
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ i ] );
	}
	temp [ playerid ] [ inventory_open ] = true;
	SelectTextDraw(playerid, 0xFF0000FF);
	return 1;
}

Dialog:inventory_menu ( params_dialog )
{
	if ( !response )
		return 1;
	
	new k = temp [ playerid ] [ t_inv_old_slot_id ]; 
	switch ( listitem )
	{
		case 0:
		{
			ClearAnimLoop ( playerid );
			UseItem ( playerid, user_items [ playerid ] [ k ] [ item_id ], user_items [ playerid ] [ k ] [ item_use_quantity ], k );
		}
		case 1:
		{
			static str [ 256 ];
			
			format ( str, sizeof ( str ), "\n\
				{fffff0}Название: {cccccc}%s\n\
				{fffff0}Класс: {cccccc}%s\n\
				{fffff0}Описание: {cccccc}%s", 
				loots [ user_items [ playerid ] [ k ] [ item_id ] ] [ loot_name ], 
				loot_quality_name [ loots [ user_items [ playerid ] [ k ] [ item_id ] ] [loot_quality] - 1 ], 
				loots [ user_items [ playerid ] [ k ] [ item_id ] ] [ loot_about ]
			);
			
			Dialog_Show ( playerid, null, DIALOG_STYLE_MSGBOX, "Информация о предмете", str, !"Закрыть", !"" ); 	
		}
	}

	return 1;
}

stock ShowPlayerNewSlot ( playerid, id )
{
	if ( temp [ playerid ] [ inventory_open ] == false )
		return 0;
	
	PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ id + 30 ], loots [ user_items [ playerid ] [ id ] [ item_id ] ] [ loot_object ] );
	PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ id + 30 ] );
	return 1;
}

stock ShowExtraDostupItem ( playerid, extraid )
{
	if ( temp [ playerid ] [ inventory_open ] == false )
		return 0;

	if ( extraid >= 0 && extraid <= 29 )
	{
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 60 ] );
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 61 ] );
		
		PlayerTextDrawBackgroundColor ( playerid, inventory__TD[playerid][ extraid+30 ], 255);
		UpdateTD ( playerid, inventory__TD[playerid][ extraid+30 ] );
	}
	else if ( extraid >= 30 && extraid <= 37 )
	{
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 76 ] );
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 77 ] );
		
		PlayerTextDrawBackgroundColor ( playerid, inventory__TD[playerid][ extraid+98 ], 255);
		UpdateTD ( playerid, inventory__TD[playerid][ extraid+98 ] );
	}
	else if ( extraid >= 38 && extraid <= 41 )
	{
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 84 ] );
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 85 ] );
		
		PlayerTextDrawBackgroundColor ( playerid, inventory__TD[playerid][ extraid+118 ], 255);
		UpdateTD ( playerid, inventory__TD[playerid][ extraid+118 ] );
	}
	return 1;
}

stock HideExtraDostupItem ( playerid, extraid )
{
	if ( temp [ playerid ] [ inventory_open ] == false )
		return 0;
	
	if ( extraid >= 0 && extraid <= 29 )
	{
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 60 ] );
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 61 ] );
		PlayerTextDrawBackgroundColor ( playerid, inventory__TD[playerid][ extraid+30 ], 0);
		
		UpdateTD ( playerid, inventory__TD[playerid][ extraid+30 ] );
	}
	else if ( extraid >= 30 && extraid <= 37 )
	{
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 76 ] );
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 77 ] );
		PlayerTextDrawBackgroundColor ( playerid, inventory__TD[playerid][ extraid+98 ], 0);
		
		UpdateTD ( playerid, inventory__TD[playerid][ extraid+98 ] );
	}
	else if ( extraid >= 38 && extraid <= 41 )
	{
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 84 ] );
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ ( extraid * 2 ) + 85 ] );
		PlayerTextDrawBackgroundColor ( playerid, inventory__TD[playerid][ extraid+118 ], 0);
		
		UpdateTD ( playerid, inventory__TD[playerid][ extraid+118 ] );
	}
	return 1;
}

CMD:showw ( playerid, params[] )
{
	new ot,
		doz;
	
	if ( sscanf ( params, "ii", ot, doz ) )
		return 1;

	for ( new i = ot; i < doz; i ++ )
		PlayerTextDrawShow ( playerid, inventory__TD [ playerid ] [ i ] );
	return 1;
}

stock IsWeapon ( itemid )
{
	switch ( itemid )
	{
		case 26,27,28,29,30,10,11,12,13,14,15,16,17,59,60,61,71,72,73,74,38,78: return 1;
	}

	return 0;
}


stock InventoryUpdateSwipe ( playerid, old_slot, new_slot )
{
	if ( new_slot >= 0 && new_slot <= 29 )
	{
		if ( IsWeapon ( user_items [ playerid ] [ new_slot ] [ item_id ] ) == 1 )
			PlayerTextDrawSetPreviewRot ( playerid, inventory__TD [ playerid ] [ new_slot + 30 ], 23.000000, 0.000000, 46.000000, 2.499998 );
		
		PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ new_slot + 30 ], loots [ user_items [ playerid ] [ new_slot ] [ item_id ] ] [ loot_object ] );
		UpdateTD ( playerid, inventory__TD [ playerid ] [ new_slot + 30 ] );
	}
	else if ( new_slot >= 30 && new_slot <= 37 )
	{
		PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ new_slot + 98 ], loots [ user_items [ playerid ] [ new_slot ] [ item_id ] ] [ loot_object ] );
		UpdateTD ( playerid, inventory__TD [ playerid ] [ new_slot + 98 ] );
	}
	else if ( new_slot >= 38 && new_slot <= 41 )
	{
		PlayerTextDrawSetPreviewModel ( playerid, inventory__TD [ playerid ] [ new_slot + 118 ], loots [ user_items [ playerid ] [ new_slot ] [ item_id ] ] [ loot_object ] );
		UpdateTD ( playerid, inventory__TD [ playerid ] [ new_slot + 118 ] );
	}

	if ( old_slot >= 0 && old_slot <= 29 )
	{
		PlayerTextDrawSetPreviewRot ( playerid, inventory__TD [ playerid ] [ old_slot + 30 ], -10.000000, 0.000000, -20.000000, 1.000000 );
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ old_slot + 30 ] );
	}
	else if ( old_slot >= 30 && old_slot <= 37 )
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ old_slot + 98 ] );
	else if ( old_slot >= 38 && old_slot <= 41 )
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ old_slot + 118 ] );
	else if ( old_slot == 228 ) //Main weapon
	{
		PlayerTextDrawSetSelectable ( playerid, inventory__TD [ playerid ] [ 168 ], 0 );
		PlayerTextDrawSetString ( playerid, inventory__TD [ playerid ] [ 169 ], "0" );
		PlayerTextDrawSetString ( playerid, inventory__TD [ playerid ] [ 170 ], TranslateText ( "Отсутствует" ) );
		PlayerTextDrawColor ( playerid, inventory__TD [ playerid ] [ 168 ], 255 );
	}

	return 1;
}

CMD:inv ( playerid )
{
	if ( temp [ playerid ] [ inventory_open ] == true )
		return 1;

	CreateAllInventory ( playerid );
	CreatePlayerInventory ( playerid );
	
	return 1;
}

stock HidePlayerInventory ( playerid )
{
	TextDrawHideForPlayer ( playerid, inventory_TD );
	DestroyAllInventory ( playerid );
	temp [ playerid ] [ inventory_open ] = false;
	CancelSelectTextDraw ( playerid );
	/*for ( new i = 0; i < MAX_INV_TD; i ++ )
		PlayerTextDrawHide ( playerid, inventory__TD [ playerid ] [ i ] );
	*/
	return 1;
}

CMD:hide_inv ( playerid )
{
	HidePlayerInventory ( playerid );
	return 1;
}

stock ResetPlayerSlotInventory ( playerid, slot )
{
	user_items [ playerid ] [ slot ] [ item_id ] =
	user_items [ playerid ] [ slot ] [ item_value ] =
	user_items [ playerid ] [ slot ] [ item_quantity ] =
	user_items [ playerid ] [ slot ] [ item_use_id ] =
	user_items [ playerid ] [ slot ] [ item_use_value ] =
	user_items [ playerid ] [ slot ] [ item_use_quantity ] = 0;

	return 1;
}

stock ActivateGun ( playerid, slot )
{
	new temp_1,
		temp_2;
		
	for ( new i = 0; i < 13; i ++ )
	{
    	GetPlayerWeaponData ( playerid, i, temp_1, temp_2 );
		
		if ( GetWeaponMainSlot ( temp_1 ) == 1 )
			return SEM ( playerid, "Слот под данное оружие уже используется!" );
	}

	new itemid = user_items [ playerid ] [ slot ] [ item_id ];

	ServerGivePlayerWeapon ( playerid, GetItemWeapon ( itemid ), user_items [ playerid ] [ slot ] [ item_value ] );
	ResetPlayerSlotInventory ( playerid, slot );
	SSU ( playerid, "Вы использовали оружие %s", WeaponNames [ GetItemWeapon ( itemid ) ] );

	return 1;
}