/*
    Описание: Система инвентаря;
    Автор: zummore;
	Благодарность: ihnify;
*/
#if defined _inventory_included
	#endinput
#endif
#define _inventory_included

/*
	---------------------------------------------------
				Начало системы инвентаря
	---------------------------------------------------
*/
#if defined TABLE_USER_INVENTORY
	#endinput
#endif
#define TABLE_USER_INVENTORY						"`users_inventory`" // Таблица с инвентарем;
#define INVENTORY_USE								50 // Максимальное кол-во вещей у игрока;
// #define MAX_DROP_PACK								1500 // Максимальное кол-во рюкзаков на сервере;

enum inventory_structure { // Структура инвентаря;
	item_id, // Ид предмета;
	item_value, // Кол-Во;
	item_quantity, // Доп. значение;

	item_use_id,
	item_use_value,
	item_use_quantity
};
new 
	user_items[MAX_PLAYERS][INVENTORY_USE][inventory_structure],
	user_drop_equipment[MAX_PLAYERS][16];
	// enum vlootInfo { LData,Float:LPos[3],LModel,LIndexObj, LCount }
/*enum structure_drop = {
	drop_pack,
	drop_object,
	drop_item
	drop_value,
	drop_quantity,
	Float: drop_xyz[3]
};
new drop_box[MAX_DROP_PACK][structure_drop];*/


CMD:additem(playerid, params[])
{
	if(!FullDostup(playerid, 1)) return server_error(playerid, "Доступ ограничен.");
	if(sscanf(params, "iii", params[0], params[1], params[2])) return server_error(playerid, "Используйте: /additem [предмет] [кол-во] [%%]");
	if(params[0] < 1 || params[0] > max_items-1) return SCMASS(playerid, "ID лута от 1 до %i!", max_items-1);
	AddItem(playerid, params[0], params[1], params[2]);
	server_error(playerid, "Предмет выдан.");
	return true;
}
/*

	Добавление предметов;
	
*/
/*stock add_item(playerid, idx_item, idx_value = 1, idx_quantity = 0, bool: idx_newitem)
{
	// new protect_items = 0;

	if(idx_newitem)
	{
		for(new add_idx = 0; add_idx < INVENTORY_USE; add_idx++) 
		{
			if(!user_items[playerid][add_idx][item_id]) continue;
			user_items[playerid][add_idx][item_id] = idx_item;
			user_items[playerid][add_idx][item_value] = idx_value;
			users[playerid][u_slots] += idx_value;
			user_items[playerid][add_idx][item_quantity] = idx_quantity;
			if(user_items[playerid][add_idx][item_value] < 1) user_items[playerid][z][item_value] = 1;
		}
		return true;
	}
	for(new add_idx = 0; add_idx < INVENTORY_USE; add_idx++) 
	{
		if(user_items[playerid][add_idx][item_id] != idx_item) continue;
		if(user_items[playerid][add_idx][item_quantity] != idx_quantity) continue;
		user_items[playerid][add_idx][item_value] += idx_value;
		break;
	}
	return true;
}
stock AddItem(playerid, idx_item, idx_value = 1, idx_quantity = 0)
{
	new 
		protect_item = 0;
	// Патроны на оружие;
	switch(item)
	{
		case 18..25, 63..65, 75..76:
		{
			new magazammo = 0;
			switch(item) 
			{
			case 18: magazammo = 8; //Shotgun
			case 19, 76: magazammo = 7; // deagle / combat shut
			case 20..21, 24: magazammo = 30; //AK-47 / М4/MP5
			case 22: magazammo = 5; // sniper rifle
			case 23, 25: magazammo = 50; // uzi / tec
			case 63, 64: magazammo = 18; // 9mm / silence
			case 65: magazammo = 2; // sawnoff shutgun
			case 75: magazammo = 10; // rifle
			}
			for(new z = 0; z < INVENTORY_USE; z++) // Если нету ничего из пт.
			{
				if(!user_items[playerid][z][item_id]) continue;
				if(user_items[playerid][z][item_id] != idx_item) continue;
				if(!user_items[playerid][z][item_value]) continue;
				if(user_items[playerid][z][item_quantity] != magazammo) continue;
				protect_item = 1;
				break;
			}
			new 
				count_value = idx_value % magazammo;
			for(new zx = 0; zx < INVENTORY_USE; zx++)
			{
				if(count_value == 0) break;
				if(user_items[playerid][zx][item_id] != item) continue;
				if(user_items[playerid][zx][item_quantity] >= magazammo) continue;
				if((count_value + user_items[playerid][zx][item_quantity]) == magazammo)
				{
					user_items[playerid][zx][item_id] = 0;
					user_items[playerid][zx][item_value] = 0;
					user_items[playerid][zx][item_quantity] = 0;
					protect_item = 1;
					add_item(playerid, idx_item, idx_value, idx_quantity, false);
					server_error(playerid, "Предмет забрало и выдало полноценный");
					break;
				}
				if((count_value + user_items[playerid][zx][item_quantity]) < magazammo)
				{
					protect_item = 1;
					user_items[playerid][zx][item_quantity] += get_;
					server_error(playerid, "Добавлены остатки");
					break;
				}
				if((count_value + user_items[playerid][zx][item_quantity]) > magazammo)
				{
					new 
						ammo_val = ((count_value + user_items[playerid][zx][item_quantity]) / magazammo),
						ammo_value = ((count_value + user_items[playerid][zx][item_quantity]) % magazammo);
					add_item(playerid, idx_item, ammo_val, ammo_value, true);
					add_item(playerid, idx_item, ammo_val, ammo_value, false);
					server_error(playerid, "Добавлены остатки + выдан новый");
					break;
				}
				break;
			}
			return true;
		}
	}
	return true;
}
*/
/*
stock AddItemAmmo(playerid, item, status, value, quantity)
{
	for()
	return true;
}*/
/*stock AddItem(playerid, item, value, quantity = 0)
{
	switch(item)
	{
	case 18..25, 63..65, 75..76:
		{
			new magazammo = 0;
			switch(item) 
			{
			case 18: magazammo = 8; //Shotgun
			case 19, 76: magazammo = 7; // deagle / combat shut
			case 20..21, 24: magazammo = 30; //AK-47 / М4/MP5
			case 22: magazammo = 5; // sniper rifle
			case 23, 25: magazammo = 50; // uzi / tec
			case 63, 64: magazammo = 18; // 9mm / silence
			case 65: magazammo = 2; // sawnoff shutgun
			case 75: magazammo = 10; // rifle
			}
			new 
				addammo = 1,
				add_residue = 0,
				residue = value % magazammo;
			for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
			{
				if(!residue) break;
				if(!user_items[playerid][id_inv][item_id]) continue;
				if(user_items[playerid][id_inv][item_id] != item) continue;
				if((residue + user_items[playerid][id_inv][item_quantity]) == magazammo)
				{
					addammo = 1;
					add_residue = 0;
					user_items[playerid][id_inv][item_id] = 0;
					user_items[playerid][id_inv][item_value] = 0;
					user_items[playerid][id_inv][item_quantity] = 0;
					break;
				}
				if((residue + user_items[playerid][id_inv][item_quantity]) < magazammo)
				{	
					addammo = add_residue = 0;
					user_items[playerid][id_inv][item_quantity] += residue;
					break;
				}
				if((residue + user_items[playerid][id_inv][item_quantity]) > magazammo)
				{
					addammo = 1;
					user_items[playerid][id_inv][item_id] = 0;
					user_items[playerid][id_inv][item_value] = 0;
					user_items[playerid][id_inv][item_quantity] = 0;
					add_residue = ((residue + user_items[playerid][id_inv][item_quantity]) /  magazammo);
					break;
				}
			}
			if(addammo == 1)
			{
				for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
				{
					if(user_items[playerid][id_inv][item_id] != item) continue;
					if(user_items[playerid][id_inv][item_quantity] != magazammo) continue;
					user_items[playerid][id_inv][item_value] += 1;
					addammo = 0;
					break;
				}
				if(addammo == 1)
				{
					for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
					{
						if(user_items[playerid][id_inv][item_id]) continue;
						user_items[playerid][id_inv][item_id] = item;
						user_items[playerid][id_inv][item_value] = 1;
						user_items[playerid][id_inv][item_quantity] = value;
						break;
					}
				}
			}
			if(add_residue)
			{
				for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
				{
					if(!user_items[playerid][id_inv][item_id]) continue;
					if((add_residue + user_items[playerid][id_inv][item_quantity]) > magazammo) continue;
					user_items[playerid][id_inv][item_quantity] += add_residue;
					add_residue = 0;
					break;
				}
				for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
				{
					if(!add_residue) break;
					if(user_items[playerid][id_inv][item_id]) continue;
					user_items[playerid][id_inv][item_id] = item;
					user_items[playerid][id_inv][item_value] = 1;
					user_items[playerid][id_inv][item_quantity] = add_residue;
					break;
				}
			}
			return true;
		}
	}
	new add_item = 1;
	for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
	{
		if(user_items[playerid][id_inv][item_id] != item) continue;
		if(user_items[playerid][id_inv][item_quantity] != quantity) continue;
		add_item = 0;
		user_items[playerid][id_inv][item_value] += value;
		break;
	}
	if(add_item)
	{
		for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
		{
			if(user_items[playerid][id_inv][item_id]) continue;
			user_items[playerid][id_inv][item_id] = item;
			user_items[playerid][id_inv][item_value] = value;
			user_items[playerid][id_inv][item_quantity] = quantity;
			break;
		}
	}
	return true;
}
*/
stock AddItem(playerid, item, value_one, value_two = 0)
{
	switch(item)
	{
	case 18..25, 63..65, 75..76:
		{
			new count_ = 0;
			if(count_) count_ = 0; // Перменная не всегда устанавлевается на 0!
			new 
				magazammo = 0,
				protect = 0,
				ammo_val = 0,
				ammo_value = 0;
			switch(item)
			{
				case 18..25, 63..65, 75..76:
				{
					switch(item) 
					{
					case 18: magazammo = 8; //Shotgun
					case 19, 76: magazammo = 7; // deagle / combat shut
					case 20..21, 24: magazammo = 30; //AK-47 / М4/MP5
					case 22: magazammo = 5; // sniper rifle
					case 23, 25: magazammo = 50; // uzi / tec
					case 63, 64: magazammo = 18; // 9mm / silence
					case 65: magazammo = 2; // sawnoff shutgun
					case 75: magazammo = 10; // rifle
					}
					for(new z = 0; z < INVENTORY_USE; z++) // Если нету ничего из пт.
					{
						if(!user_items[playerid][z][item_id]) continue;
						if(user_items[playerid][z][item_id] != item) continue;
						if(user_items[playerid][z][item_value] < 1) continue;
						if(user_items[playerid][z][item_quantity] != magazammo) continue;
						protect = 1;
						break;
					}
					new 
						get_ = value_one % magazammo;
					for(new zx = 0; zx < INVENTORY_USE; zx++)
					{
						if(get_ == 0) break;
						if(user_items[playerid][zx][item_id] != item) continue;
						if(user_items[playerid][zx][item_quantity] >= magazammo) continue;
						if((get_ + user_items[playerid][zx][item_quantity]) == magazammo)
						{
							ammo_value++;
							user_items[playerid][zx][item_id] = 0;
							user_items[playerid][zx][item_value] = 0;
							user_items[playerid][zx][item_quantity] = 0;
							protect = 1;
							// server_error(playerid, "Предмет забрало и выдало полноценный");
							break;
						}
						if((get_ + user_items[playerid][zx][item_quantity]) < magazammo)
						{
							count_++;
							protect = 1;
							user_items[playerid][zx][item_quantity] += get_;
							// server_error(playerid, "Добавлены остатки");
							break;
						}
						if((get_ + user_items[playerid][zx][item_quantity]) > magazammo)
						{
							if(!protect)
							{
								ammo_value += ((get_ + user_items[playerid][zx][item_quantity]) /  magazammo);
								ammo_val = (get_ + user_items[playerid][zx][item_quantity]) % magazammo;
								user_items[playerid][zx][item_id] = 0;
								user_items[playerid][zx][item_value] = 0;
								user_items[playerid][zx][item_quantity] = 0;
							}
							else 
							{
								protect = 1;
								ammo_value += ((get_ + user_items[playerid][zx][item_quantity]) /  magazammo);
								user_items[playerid][zx][item_quantity] = (get_ + user_items[playerid][zx][item_quantity]) % magazammo;
							}
							// server_error(playerid, "Добавлены остатки + выдан новый");
							break;
						}
						break;
					}
				}
			}
			if(!count_)
			{
				for(new z = 0; z < INVENTORY_USE; z++)
				{
					if(!user_items[playerid][z][item_id]) continue;
					if(user_items[playerid][z][item_id] != item) continue;
					switch(user_items[playerid][z][item_id])
					{
						case 18..25, 63..65, 75..76:
						{
							if(value_one < magazammo && !ammo_value) break;
							count_++;
							protect = 1;
							user_items[playerid][z][item_value] += (value_one /  magazammo) + ammo_value;
							users[playerid][u_slots] += (value_one /  magazammo) + ammo_value;
							if(user_items[playerid][z][item_quantity] < magazammo) user_items[playerid][z][item_quantity] = magazammo;
							// SCMG(playerid, "Добавлен предмет: №%i, теперь кол-во: %i []", user_items[playerid][z][item_id], user_items[playerid][z][item_value]);
							break;
						}
					}
					if(count_) break;
					if(user_items[playerid][z][item_quantity] != value_two) continue;
					count_++;
					user_items[playerid][z][item_value] += value_one;
					users[playerid][u_slots] += value_one;
					// SCMG(playerid, "Добавлен предмет: №%i, теперь кол-во: %i", user_items[playerid][z][item_id], user_items[playerid][z][item_value]);
					break;
				}
			}
			if(!count_)
			{
				for(new z = 0; z < INVENTORY_USE; z++)
				{
					if(user_items[playerid][z][item_id]) continue;
					switch(item)
					{
						case 18..25, 63..65, 75..76:
						{
							count_++;
							if(!ammo_val) protect = 1;
							if(!protect) ammo_value--;
							user_items[playerid][z][item_id] = item;
							user_items[playerid][z][item_value] += (value_one /  magazammo) + ammo_value;
							users[playerid][u_slots] += (value_one /  magazammo) + ammo_value;
							if(user_items[playerid][z][item_value] < 1) user_items[playerid][z][item_value] = 1;
							if(ammo_val) user_items[playerid][z][item_quantity] = magazammo;
							else 
							{
								if(magazammo > value_one && !ammo_value) user_items[playerid][z][item_quantity] = value_one;
								else user_items[playerid][z][item_quantity] = magazammo;
							}
							if(user_items[playerid][z][item_quantity] < 1) user_items[playerid][z][item_quantity] = magazammo;
							// SCMG(playerid, "Выдан предмет: #%i (%i, %i) [Слот: %i]1", user_items[playerid][z][item_id], user_items[playerid][z][item_value], user_items[playerid][z][item_quantity], z);
							break;
						}
					}
					if(!count_)
					{
						count_++;
						protect = 1;
						user_items[playerid][z][item_id] = item;
						user_items[playerid][z][item_value] = value_one;
						users[playerid][u_slots] += value_one;
						user_items[playerid][z][item_quantity] = value_two;
						if(user_items[playerid][z][item_value] < 1) user_items[playerid][z][item_value] = 1;
						// SCMG(playerid, "Выдан предмет: #%i (%i, %i) [Слот: %i]", user_items[playerid][z][item_id], user_items[playerid][z][item_value], user_items[playerid][z][item_quantity], z);
						break;
					}
				}
				if(!protect)
				{
					for(new z = 0; z < INVENTORY_USE; z++)
					{
						if(user_items[playerid][z][item_id]) continue;
						user_items[playerid][z][item_id] = item;
						user_items[playerid][z][item_value] += 1;
						users[playerid][u_slots] += 1;
						user_items[playerid][z][item_quantity] = ammo_val;
						// server_error(playerid, "+");
						break;
					}
				}
			}
			return true;
		}
	default:
		{
			new add_item = 1;
			for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
			{
				if(user_items[playerid][id_inv][item_id] != item) continue;
				if(user_items[playerid][id_inv][item_quantity] != value_two) continue;
				add_item = 0;
				user_items[playerid][id_inv][item_value] += value_one;
				break;
			}
			if(add_item)
			{
				for(new id_inv = 0; id_inv < INVENTORY_USE; id_inv++)
				{
					if(user_items[playerid][id_inv][item_id]) continue;
					user_items[playerid][id_inv][item_id] = item;
					user_items[playerid][id_inv][item_value] = value_one;
					user_items[playerid][id_inv][item_quantity] = value_two;
					SSM ( playerid, "ShowPlayerNewSlot" );
					ShowPlayerNewSlot ( playerid, id_inv );
					break;
				}
			}
		}
	}
	// if(!count_) return server_error(playerid, "Инвентарь полон.");
	return true;
}
/*

	Очистка инвентаря;
	
*/
stock inventory_clear(playerid) // Очистка инвентаря
{
	for(new z = 0; z < INVENTORY_USE; z++)
	{
		if(!user_items[playerid][z][item_id]) continue;
		user_items[playerid][z][item_id] = 0;
		user_items[playerid][z][item_value] = 0;
		user_items[playerid][z][item_quantity] = 0;
	}
	users[playerid][u_slots] = 0;
	return true;
}
/*

	Инвентарь;

*/
stock inventory_use(playerid)
{
	if ( users [ playerid ] [ u_injured ] != 0 )
		return SEM ( playerid, "Вы находитесь в стадии, нельзя сейчас использовать данную функцию." );

	new str[96], str_name[40], item = 0, slots = 0;
	global_string[0] = EOS;
	strcat(global_string, "Кол-во\tНазвание\n");
	for(new z = 0; z < INVENTORY_USE; z++)
	{
		if(user_items[playerid][z][item_id] < 1) continue;
		item++;
		user_items[playerid][item-1][item_use_id] = user_items[playerid][z][item_id];
		user_items[playerid][item-1][item_use_value] = user_items[playerid][z][item_value];
		user_items[playerid][item-1][item_use_quantity] = user_items[playerid][z][item_quantity];

		if(user_items[playerid][item-1][item_use_quantity] < 1) format(str, sizeof(str), "%i\t%s\n",
			user_items[playerid][item-1][item_use_value], loots[user_items[playerid][item-1][item_use_id]][loot_name]);
		if(user_items[playerid][item-1][item_use_quantity] > 0) format(str, sizeof(str), "%i\t%s [%i]\n",
			user_items[playerid][item-1][item_use_value], loots[user_items[playerid][item-1][item_use_id]][loot_name],
			user_items[playerid][item-1][item_use_quantity]);
		strcat(global_string, str);
		slots += user_items[playerid][item-1][item_use_value];
	}
	users[playerid][u_slots] = slots;
	if(!item) return server_error(playerid, "Инвентарь пуст.");
	switch(users[playerid][u_backpack])
	{
	case 1: format(str_name, sizeof(str_name), "Очень маленький рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 2: format(str_name, sizeof(str_name), "Маленький рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 3: format(str_name, sizeof(str_name), "Средний рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 4: format(str_name, sizeof(str_name), "Большой рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 5: format(str_name, sizeof(str_name), "Очень большой рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	}
	show_dialog(playerid, d_inventory, DIALOG_STYLE_TABLIST_HEADERS, str_name, global_string, !"Выбрать", !"Выход");
	
	new weapon, ammo, index_ = 0;
	for(new slot = 0; slot < 13; slot++) 
	{
		GetPlayerWeaponData(playerid, slot, weapon, ammo);
		if(weapon > 0) index_++;
	}
	if(users[playerid][u_helmet] || users[playerid][u_armour]) index_++;
	if(!index_) 
	{
		TextDrawHideForPlayer(playerid, Text: drop_items_TD);
		CancelSelectTextDraw(playerid);
	}
	else
	{
		SelectTextDraw(playerid, 0x535250AA);
		TextDrawShowForPlayer(playerid, Text: drop_items_TD);
	}
	if(!IsPlayerInWater(playerid)) LoopingAnim(playerid, "BOMBER", "BOM_Plant_Loop", 2.1, 0, 1, 1, 1, 1);
	return true;
}
/*

	Забераем предмет из инвентаря;

*/
stock RemoveItem(playerid, item, quantity = 0, count = 1)
{
	for(new rx = 0; rx < count; rx++)
	{
		for(new z = 0; z < INVENTORY_USE; z++)
		{
			if(!user_items[playerid][z][item_id]) continue;
			if(user_items[playerid][z][item_id] != item) continue;
			if(user_items[playerid][z][item_quantity] != quantity) continue;
			user_items[playerid][z][item_value]--;
			if(!user_items[playerid][z][item_value])
			{
				user_items[playerid][z][item_id] = 0;
				user_items[playerid][z][item_value] = 0;
				user_items[playerid][z][item_quantity] = 0;
			}
			break;
		}
	}
	users[playerid][u_slots] -= count;
	return true;
}
/*

	Предметы рядом;

*/
stock Equipment(playerid) 
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return true;
	new str[96], adm = 0;
	if(adm) adm = 0;
	global_string[0] = EOS;
	for(new a = 0; a < MAX_LOOT; a++) 
	{
		if(!IsPlayerInRangeOfPoint(playerid, 1.75, LootInfo[a][LPos][0], LootInfo[a][LPos][1], LootInfo[a][LPos][2])) continue;
		adm ++;
		// users[playerid][PlayerItem][adm-1] = a;
		user_items[playerid][adm-1][item_use_id] = LootInfo[a][LData];
		user_items[playerid][adm-1][item_use_value] = a;
		user_items[playerid][adm-1][item_use_quantity] = LootInfo[a][LCount];
		if(LootInfo[a][LCount] < 1) format(str, sizeof(str), "%s\n", loots[LootInfo[a][LData]][loot_name]);
		if(LootInfo[a][LCount] > 0) format(str, sizeof(str), "%s [%i]\n", loots[LootInfo[a][LData]][loot_name], LootInfo[a][LCount]);
		strcat(global_string, str);
	}
	if(!adm) return true; 
	LoopingAnim(playerid,"BOMBER","BOM_Plant_Loop", 2.1, 0, 1, 1, 1, 1);
	show_dialog(playerid, d_takedrop, DIALOG_STYLE_LIST, !"Снаряжение рядом:", global_string, !"Взять", !"Закрыть");
	return true; 
}
/*

	Сохронение инвентаря;

*/
stock SavePlayerWeapons(playerid)
{
	new weapon[13], ammo[13], ammo_ = 0;
	if(ammo_) ammo_ = 0;
	for(new w = 0; w < 13; w++) 
	{
		GetPlayerWeaponData(playerid, w, weapon[w], ammo[w]);
		if(weapon[w] < 1) continue; 
		if(ammo[w] > protect_ammo[playerid][w]) ammo[w] = protect_ammo[playerid][w];
		AddItem(playerid, GetWeaponItem(weapon[w]), 1);
		if(weapon[w] == WEAPON_ROCKETLAUNCHER)
		{
			AddItem(playerid, GetWeaponAmmoItem(weapon[w]), ammo[w]);
			continue;
		}
		if(ammo[w] > WeaponAmmo(weapon[w]))
		{
			ammo_ = ammo[w] % WeaponAmmo(weapon[w]);
			for(new z = 0; z < (ammo[w]/WeaponAmmo(weapon[w])); z++) 
			{
				AddItem(playerid, GetWeaponAmmoItem(weapon[w]), WeaponAmmo(weapon[w]));
			}
			if(ammo_ != 0) AddItem(playerid, GetWeaponAmmoItem(weapon[w]), ammo_);
			if(ammo_) ammo_ = 0;
		}
		else AddItem(playerid, GetWeaponAmmoItem(weapon[w]), ammo[w]);
	}
	ServerResetPlayerWeapons(playerid); // Чистим оружие;
	return true;
}
stock SavePlayerInventory(playerid)
{
   /* static sql_string[96];
    m_format(sql_string, sizeof(sql_string), "SELECT * FROM "TABLE_USER_INVENTORY" WHERE `u_i_owner` = '%i' LIMIT 1", users[playerid][u_id]);
    new Cache:result = m_query(sql_string);
    if(!cache_num_rows()) // Если не найдено;
	{
        m_format(sql_string, sizeof(sql_string), "INSERT INTO "TABLE_USER_INVENTORY" (`u_i_owner`) VALUES ('%i')", users[playerid][u_id]);
		m_query(sql_string); // Создаем в таблице инвентарь для игрока;
		SavePlayerInventory(playerid); // После создания заново пытаемся сохранить инвентарь;
		cache_delete(result);
		return true;
	}
	cache_delete(result);*/
	/*if(users[playerid][u_newgame]) // Если у игрока новая игра, переменная не равна 0, то не сохраняем инвентарь;
	{
		static sql_str[128];
		for(new z = 0; z < INVENTORY_USE; z++)
		{
			m_format(sql_str, sizeof(sql_str), "UPDATE "TABLE_USER_INVENTORY" SET `u_i_slot_%i` = '0,0,0' WHERE `u_i_owner` = '%i' LIMIT 1", z+1, users[playerid][u_id]);
			m_query(sql_str);
		}
		return true;
	}*/
    new mysql_format_string[1600];
	if(users[playerid][u_newgame])
	{
		/*for(new ix = 0; ix < INVENTORY_USE; ix++)
		{
			m_format(mysql_format_string, sizeof(mysql_format_string), "UPDATE "TABLE_USER_INVENTORY" SET `u_i_slot_%i` = '0,0,0' WHERE `u_i_owner` = '%i'", 
			ix+1, users[playerid][u_id]);
			m_query(mysql_format_string);
		}*/
		m_format(mysql_format_string, sizeof(mysql_format_string), "UPDATE "TABLE_USER_INVENTORY" SET \
		`u_i_slot_1` = '0,0,0', `u_i_slot_2` = '0,0,0', `u_i_slot_3` = '0,0,0', `u_i_slot_4` = '0,0,0', `u_i_slot_5` = '0,0,0', `u_i_slot_6` = '0,0,0', \
		`u_i_slot_7` = '0,0,0', `u_i_slot_8` = '0,0,0', `u_i_slot_9` = '0,0,0', `u_i_slot_10` = '0,0,0', `u_i_slot_11` = '0,0,0', `u_i_slot_12` = '0,0,0', \
		`u_i_slot_13` = '0,0,0', `u_i_slot_14` = '0,0,0', `u_i_slot_15` = '0,0,0', `u_i_slot_16` = '0,0,0', `u_i_slot_17` = '0,0,0', `u_i_slot_18` = '0,0,0', \
		`u_i_slot_19` = '0,0,0', `u_i_slot_20` = '0,0,0', `u_i_slot_21` = '0,0,0', `u_i_slot_22` = '0,0,0', `u_i_slot_23` = '0,0,0', `u_i_slot_24` = '0,0,0', \
		`u_i_slot_25` = '0,0,0', `u_i_slot_26` = '0,0,0', `u_i_slot_27` = '0,0,0', `u_i_slot_28` = '0,0,0', `u_i_slot_29` = '0,0,0', `u_i_slot_30` = '0,0,0', \
		`u_i_slot_31` = '0,0,0', `u_i_slot_32` = '0,0,0', `u_i_slot_33` = '0,0,0', `u_i_slot_34` = '0,0,0', `u_i_slot_35` = '0,0,0', `u_i_slot_36` = '0,0,0', \
		`u_i_slot_37` = '0,0,0', `u_i_slot_38` = '0,0,0', `u_i_slot_39` = '0,0,0', `u_i_slot_40` = '0,0,0', `u_i_slot_41` = '0,0,0', `u_i_slot_42` = '0,0,0', \
		`u_i_slot_43` = '0,0,0', `u_i_slot_44` = '0,0,0', `u_i_slot_45` = '0,0,0', `u_i_slot_46` = '0,0,0', `u_i_slot_47` = '0,0,0', `u_i_slot_48` = '0,0,0', \
		`u_i_slot_49` = '0,0,0', `u_i_slot_50` = '0,0,0' WHERE `u_i_owner` = '%i'", users[playerid][u_id]);
		m_query(mysql_format_string);
	}
	else
	{
		/*
		for(new ix = 0; ix < INVENTORY_USE; ix++)
		{
			m_format(mysql_format_string, sizeof(mysql_format_string), "UPDATE "TABLE_USER_INVENTORY" SET `u_i_slot_%i` = '%i,%i,%i' WHERE `u_i_owner` = '%i'", 
			ix+1, user_items[playerid][ix][item_id], user_items[playerid][ix][item_value], user_items[playerid][ix][item_quantity], users[playerid][u_id]);
			m_query(mysql_format_string);
		}
		*/
		m_format(mysql_format_string, sizeof(mysql_format_string), "UPDATE "TABLE_USER_INVENTORY" SET \
		`u_i_slot_1` = '%i,%i,%i', `u_i_slot_2` = '%i,%i,%i', `u_i_slot_3` = '%i,%i,%i', `u_i_slot_4` = '%i,%i,%i', `u_i_slot_5` = '%i,%i,%i', `u_i_slot_6` = '%i,%i,%i', \
		`u_i_slot_7` = '%i,%i,%i', `u_i_slot_8` = '%i,%i,%i', `u_i_slot_9` = '%i,%i,%i', `u_i_slot_10` = '%i,%i,%i', `u_i_slot_11` = '%i,%i,%i', `u_i_slot_12` = '%i,%i,%i', \
		`u_i_slot_13` = '%i,%i,%i', `u_i_slot_14` = '%i,%i,%i', `u_i_slot_15` = '%i,%i,%i', `u_i_slot_16` = '%i,%i,%i', `u_i_slot_17` = '%i,%i,%i', `u_i_slot_18` = '%i,%i,%i', \
		`u_i_slot_19` = '%i,%i,%i', `u_i_slot_20` = '%i,%i,%i', `u_i_slot_21` = '%i,%i,%i', `u_i_slot_22` = '%i,%i,%i', `u_i_slot_23` = '%i,%i,%i', `u_i_slot_24` = '%i,%i,%i', \
		`u_i_slot_25` = '%i,%i,%i' WHERE `u_i_owner` = '%i'", 
		user_items[playerid][0][item_id], user_items[playerid][0][item_value], user_items[playerid][0][item_quantity], 
		user_items[playerid][1][item_id], user_items[playerid][1][item_value], user_items[playerid][1][item_quantity],  
		user_items[playerid][2][item_id], user_items[playerid][2][item_value], user_items[playerid][2][item_quantity],  
		user_items[playerid][3][item_id], user_items[playerid][3][item_value], user_items[playerid][3][item_quantity],  
		user_items[playerid][4][item_id], user_items[playerid][4][item_value], user_items[playerid][4][item_quantity],  
		user_items[playerid][5][item_id], user_items[playerid][5][item_value], user_items[playerid][5][item_quantity],  
		user_items[playerid][6][item_id], user_items[playerid][6][item_value], user_items[playerid][6][item_quantity],  
		user_items[playerid][7][item_id], user_items[playerid][7][item_value], user_items[playerid][7][item_quantity],  
		user_items[playerid][8][item_id], user_items[playerid][8][item_value], user_items[playerid][8][item_quantity],  
		user_items[playerid][9][item_id], user_items[playerid][9][item_value], user_items[playerid][9][item_quantity],  
		user_items[playerid][10][item_id], user_items[playerid][10][item_value], user_items[playerid][10][item_quantity],  
		user_items[playerid][11][item_id], user_items[playerid][11][item_value], user_items[playerid][11][item_quantity],  
		user_items[playerid][12][item_id], user_items[playerid][12][item_value], user_items[playerid][12][item_quantity],  
		user_items[playerid][13][item_id], user_items[playerid][13][item_value], user_items[playerid][13][item_quantity],  
		user_items[playerid][14][item_id], user_items[playerid][14][item_value], user_items[playerid][14][item_quantity],  
		user_items[playerid][15][item_id], user_items[playerid][15][item_value], user_items[playerid][15][item_quantity],  
		user_items[playerid][16][item_id], user_items[playerid][16][item_value], user_items[playerid][16][item_quantity],  
		user_items[playerid][17][item_id], user_items[playerid][17][item_value], user_items[playerid][17][item_quantity],  
		user_items[playerid][18][item_id], user_items[playerid][18][item_value], user_items[playerid][18][item_quantity],  
		user_items[playerid][19][item_id], user_items[playerid][19][item_value], user_items[playerid][19][item_quantity],  
		user_items[playerid][20][item_id], user_items[playerid][20][item_value], user_items[playerid][20][item_quantity],  
		user_items[playerid][21][item_id], user_items[playerid][21][item_value], user_items[playerid][21][item_quantity],  
		user_items[playerid][22][item_id], user_items[playerid][22][item_value], user_items[playerid][22][item_quantity],  
		user_items[playerid][23][item_id], user_items[playerid][23][item_value], user_items[playerid][23][item_quantity],  
		user_items[playerid][24][item_id], user_items[playerid][24][item_value], user_items[playerid][24][item_quantity],
		users[playerid][u_id]);
		m_query(mysql_format_string);
		m_format(mysql_format_string, sizeof(mysql_format_string), "UPDATE "TABLE_USER_INVENTORY" SET \
		`u_i_slot_26` = '%i,%i,%i', `u_i_slot_27` = '%i,%i,%i', `u_i_slot_28` = '%i,%i,%i', `u_i_slot_29` = '%i,%i,%i', `u_i_slot_30` = '%i,%i,%i', \
		`u_i_slot_31` = '%i,%i,%i', `u_i_slot_32` = '%i,%i,%i', `u_i_slot_33` = '%i,%i,%i', `u_i_slot_34` = '%i,%i,%i', `u_i_slot_35` = '%i,%i,%i', `u_i_slot_36` = '%i,%i,%i', \
		`u_i_slot_37` = '%i,%i,%i', `u_i_slot_38` = '%i,%i,%i', `u_i_slot_39` = '%i,%i,%i', `u_i_slot_40` = '%i,%i,%i', `u_i_slot_41` = '%i,%i,%i', `u_i_slot_42` = '%i,%i,%i', \
		`u_i_slot_43` = '%i,%i,%i', `u_i_slot_44` = '%i,%i,%i', `u_i_slot_45` = '%i,%i,%i', `u_i_slot_46` = '%i,%i,%i', `u_i_slot_47` = '%i,%i,%i', `u_i_slot_48` = '%i,%i,%i', \
		`u_i_slot_49` = '%i,%i,%i', `u_i_slot_50` = '%i,%i,%i' WHERE `u_i_owner` = '%i'",
		user_items[playerid][25][item_id], user_items[playerid][25][item_value], user_items[playerid][25][item_quantity],  
		user_items[playerid][26][item_id], user_items[playerid][26][item_value], user_items[playerid][26][item_quantity],  
		user_items[playerid][27][item_id], user_items[playerid][27][item_value], user_items[playerid][27][item_quantity],  
		user_items[playerid][28][item_id], user_items[playerid][28][item_value], user_items[playerid][28][item_quantity],  
		user_items[playerid][29][item_id], user_items[playerid][29][item_value], user_items[playerid][29][item_quantity],  
		user_items[playerid][30][item_id], user_items[playerid][30][item_value], user_items[playerid][30][item_quantity],  
		user_items[playerid][31][item_id], user_items[playerid][31][item_value], user_items[playerid][31][item_quantity],  
		user_items[playerid][32][item_id], user_items[playerid][32][item_value], user_items[playerid][32][item_quantity],  
		user_items[playerid][33][item_id], user_items[playerid][33][item_value], user_items[playerid][33][item_quantity],  
		user_items[playerid][34][item_id], user_items[playerid][34][item_value], user_items[playerid][34][item_quantity],  
		user_items[playerid][35][item_id], user_items[playerid][35][item_value], user_items[playerid][35][item_quantity],  
		user_items[playerid][36][item_id], user_items[playerid][36][item_value], user_items[playerid][36][item_quantity],  
		user_items[playerid][37][item_id], user_items[playerid][37][item_value], user_items[playerid][37][item_quantity],  
		user_items[playerid][38][item_id], user_items[playerid][38][item_value], user_items[playerid][38][item_quantity], 
		user_items[playerid][39][item_id], user_items[playerid][39][item_value], user_items[playerid][39][item_quantity], 
		user_items[playerid][40][item_id], user_items[playerid][40][item_value], user_items[playerid][40][item_quantity], 
		user_items[playerid][41][item_id], user_items[playerid][41][item_value], user_items[playerid][41][item_quantity], 
		user_items[playerid][42][item_id], user_items[playerid][42][item_value], user_items[playerid][42][item_quantity], 
		user_items[playerid][43][item_id], user_items[playerid][43][item_value], user_items[playerid][43][item_quantity], 
		user_items[playerid][44][item_id], user_items[playerid][44][item_value], user_items[playerid][44][item_quantity], 
		user_items[playerid][45][item_id], user_items[playerid][45][item_value], user_items[playerid][45][item_quantity], 
		user_items[playerid][46][item_id], user_items[playerid][46][item_value], user_items[playerid][46][item_quantity], 
		user_items[playerid][47][item_id], user_items[playerid][47][item_value], user_items[playerid][47][item_quantity], 
		user_items[playerid][48][item_id], user_items[playerid][48][item_value], user_items[playerid][48][item_quantity], 
		user_items[playerid][49][item_id], user_items[playerid][49][item_value], user_items[playerid][49][item_quantity], 
		users[playerid][u_id]);
		m_query(mysql_format_string);
	}
	return true;
}
/*

	Загрузка инвентаря;
		(LoginCallback)
*/
stock LoadPlayerInventory(playerid)
{
	if(users[playerid][u_newgame]) return true; // Если у игрока новая игра, переменная не равна 0, то не загружаем инвентарь;
    static sql_string[96];
    m_format(sql_string, sizeof(sql_string), "SELECT * FROM "TABLE_USER_INVENTORY" WHERE `u_i_owner` = '%i' LIMIT 1", users[playerid][u_id]);
    new Cache:result = m_query(sql_string);
    if(!cache_num_rows()) // Если не найдено;
	{
        m_format(sql_string, sizeof(sql_string), "INSERT INTO "TABLE_USER_INVENTORY" (`u_i_owner`) VALUES ('%i')", users[playerid][u_id]);
		m_query(sql_string); // Создаем в таблице инвентарь для игрока;
		cache_delete(result);
		return true;
	}
    static str_load_items[MAX_PLAYER_NAME];
	for(new z = 0; z < INVENTORY_USE; z++)
	{
		format(str_load_items, sizeof(str_load_items), "u_i_slot_%i", z+1);
		cache_get_value_name(0, str_load_items, str_load_items);
		sscanf(str_load_items, "p<,>iii", user_items[playerid][z][item_id], user_items[playerid][z][item_value], user_items[playerid][z][item_quantity]);
	}
	cache_delete(result);
	return true;
}
/*

	Проверка на наличие предмета;

*/
stock GetItem(playerid, item, quantity = 0)
{
	new count = 0;
	if(count) count = 0; // Переменная не обнуляется сама при поиске.
	switch(quantity)
	{
	case 0:
		{
			for(new zx = 0; zx < INVENTORY_USE; zx++)
			{
				if(!user_items[playerid][zx][item_id]) continue;
				if(user_items[playerid][zx][item_id] != item) continue;
				if(user_items[playerid][zx][item_value] < 1) continue;
				count = user_items[playerid][zx][item_value];
				break;
			}
		}
	default:
		{
			for(new zx = 0; zx < INVENTORY_USE; zx++)
			{
				if(!user_items[playerid][zx][item_id]) continue;
				if(user_items[playerid][zx][item_id] != item) continue;
				if(user_items[playerid][zx][item_quantity] != quantity) continue;
				if(user_items[playerid][zx][item_value] < 1) continue;
				count = user_items[playerid][zx][item_value];
				break;
			}
		}
	}
	return count;
}
/*

	Выпадение вещей;

*/
stock DropItems(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	static Float: pos_xyz[3];
	GetPlayerPos(playerid, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
	users[playerid][u_damage][0] = 0; 
	// users[playerid][pDamageTime] = 0;
	DeletePVar(playerid, "RECEIVED_DAMAGE_TIME");

	for(new zx = 0; zx < INVENTORY_USE; zx++) // Сканируем на шмот в инвентаре;
	{
		if(!user_items[playerid][zx][item_id]) continue; // Если предмет равен 0, то пропускаем;
		DroppedInventoryPlayer(user_items[playerid][zx][item_id], pos_xyz[0], pos_xyz[1], pos_xyz[2], user_items[playerid][zx][item_value], user_items[playerid][zx][item_quantity]);
		user_items[playerid][zx][item_id] = 0;
		user_items[playerid][zx][item_value] = 0;
		user_items[playerid][zx][item_quantity] = 0;
	}
	switch(users[playerid][u_backpack]) // Рюкзак;
	{
	case 2: DroppedInventoryPlayer(49, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
	case 3: DroppedInventoryPlayer(50, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
	case 4: DroppedInventoryPlayer(69, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
	case 5: DroppedInventoryPlayer(70, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
	}
	if(SkinToItem(GetPlayerSkin(playerid)) != 255) DroppedInventoryPlayer(SkinToItem(GetPlayerSkin(playerid)), pos_xyz[0], pos_xyz[1], pos_xyz[2]); // Одежда;
	new weapon[13], ammo[13], ammo_ = 0;
	for(new w = 0; w < 13; w++) 
	{
		GetPlayerWeaponData(playerid, w, weapon[w], ammo[w]);
		if(weapon[w] < 1) continue;
		if(ammo[w] > protect_ammo[playerid][w]) ammo[w] = protect_ammo[playerid][w];
		DroppedInventoryPlayer(GetWeaponItem(weapon[w]), pos_xyz[0], pos_xyz[1], pos_xyz[2], 1);
		if(weapon[w] == WEAPON_ROCKETLAUNCHER)
		{
			DroppedInventoryPlayer(GetWeaponAmmoItem(weapon[w]), pos_xyz[0], pos_xyz[1], pos_xyz[2], ammo[w]);
			continue;
		}
		if(ammo[w] > WeaponAmmo(weapon[w]))
		{
			if(ammo_) ammo_ = 0;
			ammo_ = ammo[w] % WeaponAmmo(weapon[w]);
			DroppedInventoryPlayer(GetWeaponAmmoItem(weapon[w]), pos_xyz[0], pos_xyz[1], pos_xyz[2], ammo[w]/WeaponAmmo(weapon[w]), WeaponAmmo(weapon[w]));
			if(ammo_ != 0) DroppedInventoryPlayer(GetWeaponAmmoItem(weapon[w]), pos_xyz[0], pos_xyz[1], pos_xyz[2], 1, ammo_);
		}
		else DroppedInventoryPlayer(GetWeaponAmmoItem(weapon[w]), pos_xyz[0], pos_xyz[1], pos_xyz[2], 1, ammo[w]);
	}
	// Чистим полностью инвентарь;
	SetCameraBehindPlayer(playerid); // Сбрасываем камеру;
	RemovePlayerAttachedObject(playerid, users[playerid][u_backpack_object]); // Удаляем рюкзак со спины;
	ClearChatForPlayer(playerid); // Чистим чат для игрока;
	inventory_clear(playerid); // Чистим инвентарь;
	ServerResetPlayerWeapons(playerid); // Чистим оружие;
	return true;
}
/*

	Функция для выпадения заряженных патрон оружия;

*/
/*stock DroppedAmmoPlayer(playerid)
{
	new weapon[13], ammo[13], ammo_ = 0;
	// if(ammo_) ammo_ = 0;
	for(new w = 0; w < 13; w++) 
	{
		GetPlayerWeaponData(playerid, w, weapon[w], ammo[w]);
		ammo_ = ammo[w] % WeaponAmmo(w);
		DroppedInventoryPlayer(GetWeaponAmmoItem(weapon[w]), pos_xyz[0], pos_xyz[1], pos_xyz[2], ammo[w]/WeaponAmmo(w), WeaponAmmo(w));
		if(ammo_ != 0) DroppedInventoryPlayer(GetWeaponAmmoItem(weapon[w]), pos_xyz[0], pos_xyz[1], pos_xyz[2], 1, ammo_);
		if(ammo_) ammo_ = 0;
	}
	return true;
}*/
/*

	Функция для выпадения вещей;

*/
stock DroppedInventoryPlayer(idv, Float:gPosX, Float:gPosY, Float:gPosZ, kolvo = 1, quantity = 0) 
{
	for(new kz = 0; kz < kolvo; kz++) 
	{
		new f, Float:rPosX = float(random(15))/10,  Float:rPosY = float(random(15))/10;
		for(new a = 0; a < MAX_LOOT; a++) 
		{
			if(LootInfo[a][LPos][0] == 0.0) 
			{
				f = a;
				break; 
			} 
		}
		switch(random(4)) 
		{
		case 0:LootInfo[f][LPos][0] = gPosX+rPosX,LootInfo[f][LPos][1] = gPosY-rPosY;
		case 1:LootInfo[f][LPos][0] = gPosX-rPosX,LootInfo[f][LPos][1] = gPosY-rPosY;
		case 2:LootInfo[f][LPos][0] = gPosX+rPosX,LootInfo[f][LPos][1] = gPosY+rPosY;
		default:LootInfo[f][LPos][0] = gPosX-rPosX,LootInfo[f][LPos][1] = gPosY+rPosY; 
		}
		LootInfo[f][LData] = idv,LootInfo[f][LPos][2] = gPosZ;
		LootInfo[f][LCount] = quantity;
		LootInfo[f][LIndexObj] = CreateDynamicObject(loots[idv][loot_object], LootInfo[f][LPos][0], LootInfo[f][LPos][1], LootInfo[f][LPos][2]-CorrectingPos(loots[idv][loot_object],1), CorrectingPos(loots[idv][loot_object],2), CorrectingPos(loots[idv][loot_object],3), float(random(360))); 
	}
	return 1; 
}
/*

	OnPlayerDeath;

*/

/*

	OnPlayerConnect;

*/
/*public OnPlayerConnect(playerid)
{
	inventory_clear(playerid); // Чистим инвентарь при входе;
	#if defined IN_OnPlayerConnect
		return IN_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect IN_OnPlayerConnect

#if defined IN_OnPlayerConnect
    forward IN_OnPlayerConnect(playerid);
#endif*/
/*

	OnPlayerDisconnect;

*/
/*public OnPlayerDisconnect(playerid, reason)
{
	SavePlayerWeapons(playerid);
	SavePlayerInventory(playerid); // Сохронение инвентаря при выходе;
	#if defined IN_OnPlayerDisconnect
		return IN_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect IN_OnPlayerDisconnect

#if defined IN_OnPlayerDisconnect
    forward IN_OnPlayerDisconnect(playerid, reason);
#endif*/
/*

	OnPlayerKeyStateChange;

*/
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_WALK)) 
	{ // ALT
		if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && observation[playerid][observation_id] != INVALID_PLAYER_ID) SelectTextDraw(playerid, 0x535250AA);
		else Equipment(playerid);
		return 1; 
	}
	if(PRESSED(KEY_YES)) return inventory_use(playerid); // Открытие инвентаря;
	#if defined IN_OnPlayerKeyStateChange
		return IN_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange IN_OnPlayerKeyStateChange

#if defined IN_OnPlayerKeyStateChange
    forward IN_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

/*

	Снятие предметов;
	()

	

*/
CMD:drop(playerid)
{
	new 
		index_ = 0,
		menu_string[256], 
		weapon_string[96],
		weapon[13], ammo[13];
	menu_string[0] = EOS;
	for(new slot = 0; slot < 13; slot++)
	{
		GetPlayerWeaponData(playerid, slot, weapon[slot], ammo[slot]);
		if(weapon[slot] < 1 || ammo[slot] < 1) continue;
		index_++;
		user_drop_equipment[playerid][index_-1] = slot;
		format(weapon_string, sizeof(weapon_string), "{cccccc}- {5F9EA0}Снять оружие ''{fffff0}%s{5F9EA0}''\n", WeaponNames[weapon[slot]]);
		strcat(menu_string, weapon_string);
	}
	if(users[playerid][u_helmet]) 
	{
		strcat(menu_string, "{cccccc}- {B0E0E6}Снять шлем\n");
		index_++;
		user_drop_equipment[playerid][index_-1] = 78;
	}
	if(users[playerid][u_armour]) 
	{
		strcat(menu_string, "{cccccc}- {B0E0E6}Снять бронжелет\n");
		index_++;
		user_drop_equipment[playerid][index_-1] = 38;
	}
	if(!index_) return true;
	// if(!index_) return server_error(playerid, "У вас на вас нет оружия, брони или шлема.");
	show_dialog(playerid, d_menu_drop, DIALOG_STYLE_LIST, !"Снаряжение", menu_string, !"Ок", !"Закрыть");
	TextDrawHideForPlayer(playerid, Text: drop_items_TD);
	CancelSelectTextDraw(playerid);
	return true;
}