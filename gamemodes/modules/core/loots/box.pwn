
#if defined _box_included
	#endinput
#endif

#define _box_included

#if defined MAX_BOX
	#endinput
#endif

#define MAX_BOX 								4000 // Макс. кол-во боксов;

// #define TABLE_BOX_INVENTORY						"`server_box_inventory`" // Таблица с инвентарем ящиков;

enum structure_boxname { box_name[MAX_PLAYER_NAME], box_max_slots };
new const boxname[][structure_boxname] = {{"Ящик", 100}, {"Тайник", 200}, {"Сундук", 300}};
enum structure_box {
	box_id,
	box_owner_id,
	box_object,
	// box_loot[max_items],
	box_type,
	box_lock,
	box_pass[MAX_PLAYER_NAME],
	box_slots,
	Float: box_xyzf[4]
}
new box[MAX_BOX][structure_box];

enum box_structure { // Структура инвентаря;
	item_id, // Ид предмета;
	item_value, // Кол-Во;
	item_quantity, // Доп. значение;

	item_use_id,
	item_use_value,
	item_use_quantity
};
new 
	box_items[MAX_BOX][max_items][box_structure];

stock RemoveItemFromBox(boxidx, item, quantity = 0)
{
	for(new z = 0; z < max_items; z++)
	{
		if(!box_items[boxidx][z][item_id]) continue;
		if(box_items[boxidx][z][item_id] != item) continue;
		if(box_items[boxidx][z][item_quantity] != quantity) continue;
		box_items[boxidx][z][item_value]--;
		if(!box_items[boxidx][z][item_value])
		{
			box_items[boxidx][z][item_id] = 0;
			box_items[boxidx][z][item_value] = 0;
			box_items[boxidx][z][item_quantity] = 0;
		}
		break;
	}
	return true;
}
stock SaveBox(number)
{
	static str_sql[196];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BOX" SET `box_type` = '%i', `box_slots` = '%i', `box_pass` = '%s', `box_last_use` = NOW() WHERE `box_id` = '%i';",
	box[number][box_type], box[number][box_slots], box[number][box_pass], box[number][box_id]);
	m_query(str_sql);
	for(new z = 0; z < max_items; z++)
	{
		 m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_BOX" SET `box_loot_%i` = '%i,%i,%i' WHERE `box_id` = '%i' LIMIT 1", 
		 z+1, box_items[number][z][item_id], box_items[number][z][item_value], box_items[number][z][item_quantity], box[number][box_id]);
         m_query(str_sql);
	}
	return 1; 
}
/*stock PutBox(playerid)
{	
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
	l[playerid][u_slots] = slots;
	if(!item) return server_error(playerid, "Ваш инвентарь пуст.");
	switch(users[playerid][u_backpack])
	{
	case 1: format(str_name, sizeof(str_name), "Очень маленький рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 2: format(str_name, sizeof(str_name), "Маленький рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 3: format(str_name, sizeof(str_name), "Средний рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 4: format(str_name, sizeof(str_name), "Большой рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 5: format(str_name, sizeof(str_name), "Очень большой рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	}
	show_dialog(playerid, d_box_put, DIALOG_STYLE_TABLIST_HEADERS, str_name, global_string, !"Положить", !"Назад");
	return true;
}*/
stock PutBox(playerid)
{
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
	if(!item) return server_error(playerid, "Ваш инвентарь пуст.");
	switch(users[playerid][u_backpack])
	{
	case 1: format(str_name, sizeof(str_name), "Очень маленький рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 2: format(str_name, sizeof(str_name), "Маленький рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 3: format(str_name, sizeof(str_name), "Средний рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 4: format(str_name, sizeof(str_name), "Большой рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	case 5: format(str_name, sizeof(str_name), "Очень большой рюкзак [%i/%i]", users[playerid][u_slots], users[playerid][u_backpack]*10);
	}
	show_dialog(playerid, d_box_put, DIALOG_STYLE_TABLIST_HEADERS, str_name, global_string, !"Положить", !"Назад");
	return true;
}
stock AddBoxItem(boxidx, item, value_one, value_two = 0)
{
	static count_ = 0;
	if(count_) count_ = 0; // Перменная не всегда устанавлевается на 0!
	new 
		magazammo = 0,
		// item = params[0],
		protect = 0,
		ammo_val = 0,
		ammo_value = 0;
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
	switch(item)
	{
		case 18..25, 63..65, 75..76:
		{
			for(new z = 0; z < max_items; z++) // Если нету ничего из пт.
			{
				if(!box_items[boxidx][z][item_id]) continue;
				if(box_items[boxidx][z][item_id] != item) continue;
				if(box_items[boxidx][z][item_value] < 1) continue;
				if(box_items[boxidx][z][item_quantity] != magazammo) continue;
				protect = 1;
				break;
			}
			new 
				get_ = value_one % magazammo;
				// get_ = params[1] % magazammo;
			for(new zx = 0; zx < max_items; zx++)
			{
				if(get_ == 0) break;
				if(box_items[boxidx][zx][item_id] != item) continue;
				if(box_items[boxidx][zx][item_quantity] >= magazammo) continue;
				if((get_ + box_items[boxidx][zx][item_quantity]) == magazammo)
				{
					ammo_value++;
					box_items[boxidx][zx][item_id] = 0;
					box_items[boxidx][zx][item_value] = 0;
					box_items[boxidx][zx][item_quantity] = 0;
					protect = 1;
					break;
				}
				if((get_ + box_items[boxidx][zx][item_quantity]) < magazammo)
				{
					count_++;
					protect = 1;
					box_items[boxidx][zx][item_quantity] += get_;
					break;
				}
				if((get_ + box_items[boxidx][zx][item_quantity]) > magazammo)
				{
					if(!protect)
					{
						ammo_value += ((get_ + box_items[boxidx][zx][item_quantity]) /  magazammo);
						ammo_val = (get_ + box_items[boxidx][zx][item_quantity]) % magazammo;
						box_items[boxidx][zx][item_id] = 0;
						box_items[boxidx][zx][item_value] = 0;
						box_items[boxidx][zx][item_quantity] = 0;
					}
					else 
					{
						protect = 1;
						ammo_value += ((get_ + box_items[boxidx][zx][item_quantity]) /  magazammo);
						box_items[boxidx][zx][item_quantity] = (get_ + box_items[boxidx][zx][item_quantity]) % magazammo;
					}
					break;
				}
				break;
			}
		}
	}
	if(!count_)
	{
		for(new z = 0; z < max_items; z++)
		{
			if(!box_items[boxidx][z][item_id]) continue;
			if(box_items[boxidx][z][item_id] != item) continue;
			switch(box_items[boxidx][z][item_id])
			{
				case 18..25, 63..65, 75..76:
				{
					if(value_one < magazammo && !ammo_value) break;
					count_++;
					protect = 1;
					box_items[boxidx][z][item_value] += (value_one /  magazammo) + ammo_value;
					if(box_items[boxidx][z][item_quantity] < magazammo) box_items[boxidx][z][item_quantity] = magazammo;
					break;
				}
			}
			if(count_) break;
			if(box_items[boxidx][z][item_quantity] != value_two) continue;
			count_++;
			box_items[boxidx][z][item_value] += value_one;
			break;
		}
	}
	if(!count_)
	{
		for(new z = 0; z < max_items; z++)
		{
			if(box_items[boxidx][z][item_id]) continue;
			switch(item)
			{
				case 18..25, 63..65, 75..76:
				{
					count_++;
					if(!ammo_val) protect = 1;
					if(!protect) ammo_value--;
					box_items[boxidx][z][item_id] = item;
					box_items[boxidx][z][item_value] += (value_one /  magazammo) + ammo_value;
					if(box_items[boxidx][z][item_value] < 1) box_items[boxidx][z][item_value] = 1;
					if(ammo_val) box_items[boxidx][z][item_quantity] = magazammo;
					else 
					{
						if(magazammo > value_one && !ammo_value) box_items[boxidx][z][item_quantity] = value_one;
						else box_items[boxidx][z][item_quantity] = magazammo;
					}
					if(box_items[boxidx][z][item_quantity] < 1) box_items[boxidx][z][item_quantity] = magazammo;
					break;
				}
			}
			if(!count_)
			{
				count_++;
				protect = 1;
				box_items[boxidx][z][item_id] = item;
				box_items[boxidx][z][item_value] = value_one;
				box_items[boxidx][z][item_quantity] = value_two;
				if(box_items[boxidx][z][item_value] < 1) box_items[boxidx][z][item_value] = 1;
				break;
			}
		}
		if(!protect)
		{
			for(new z = 0; z < max_items; z++)
			{
				if(box_items[boxidx][z][item_id]) continue;
				box_items[boxidx][z][item_id] = item;
				box_items[boxidx][z][item_value] = 1;
				box_items[boxidx][z][item_quantity] = ammo_val;
				break;
			}
		}
	}
	return true;
}

stock MediksEquipmentBox(playerid) 
{
	for(new i = 0; i < sizeof(MediksBoxData); i++) 
	{
		if(!IsPlayerInRangeOfPoint(playerid, 2.6, MediksBoxData[i][med_x], MediksBoxData[i][med_y], MediksBoxData[i][med_z])) continue;
		new str[96], item = 0;
		global_string[0] = EOS;
		strcat(global_string, "Кол-во\tНазвание\n");
		for(new slot; slot < max_items; slot++) 
		{
			if(MediksBox[i][slot] < 1) continue;
			item++;
			user_items[playerid][item-1][item_use_id] = slot;
			user_items[playerid][item-1][item_use_value] = MediksBox[i][slot];
			user_items[playerid][item-1][item_use_quantity] = 0;
			format(str, sizeof(str), "%i\t%s\n", user_items[playerid][item-1][item_use_value], loots[user_items[playerid][item-1][item_use_id]][loot_name]);
			strcat(global_string, str);
		}
		if(!item)
		{
			SCMASS(playerid, "%s пуст.", boxname[box[temp[playerid][player_box]][box_type]][box_name]);
			BoxFunctions(playerid); 
			return true;
		}
		show_dialog(playerid, d_medikal_box, DIALOG_STYLE_TABLIST_HEADERS, !"Медицинский ящик", global_string, !"Взять", !"Закрыть");
	}
	return 1;
}
stock EquipmentBox(playerid)
{
	if(temp[playerid][player_box] == -1) return true;
	if(!IsPlayerInRangeOfPoint(playerid, 2.6, box[temp[playerid][player_box]][box_xyzf][0], box[temp[playerid][player_box]][box_xyzf][1], box[temp[playerid][player_box]][box_xyzf][2])) return true;
	if(!box[temp[playerid][player_box]][box_slots]) 
	{
		SCMASS(playerid, "%s пуст.", boxname[box[temp[playerid][player_box]][box_type]][box_name]);
		BoxFunctions(playerid); 
		return true;
	}
	new str[96], str_name[40], item = 0, slots = 0;
	global_string[0] = EOS;
	strcat(global_string, "Кол-во\tНазвание\n");
	for(new z = 0; z < max_items; z++)
	{
		if(!box_items[temp[playerid][player_box]][z][item_id]) continue;
		item++;
		box_items[temp[playerid][player_box]][item-1][item_use_id] = box_items[temp[playerid][player_box]][z][item_id];
		box_items[temp[playerid][player_box]][item-1][item_use_value] = box_items[temp[playerid][player_box]][z][item_value];
		box_items[temp[playerid][player_box]][item-1][item_use_quantity] = box_items[temp[playerid][player_box]][z][item_quantity];

		if(box_items[temp[playerid][player_box]][item-1][item_use_quantity] < 1) format(str, sizeof(str), "%i\t%s\n",
			box_items[temp[playerid][player_box]][item-1][item_use_value], loots[box_items[temp[playerid][player_box]][item-1][item_use_id]][loot_name]);
		if(box_items[temp[playerid][player_box]][item-1][item_use_quantity] > 0) format(str, sizeof(str), "%i\t%s [%i]\n",
			box_items[temp[playerid][player_box]][item-1][item_use_value], loots[box_items[temp[playerid][player_box]][item-1][item_use_id]][loot_name],
			box_items[temp[playerid][player_box]][item-1][item_use_quantity]);
		strcat(global_string, str);
		slots += box_items[temp[playerid][player_box]][item-1][item_use_value];
	}
	box[temp[playerid][player_box]][box_slots] = slots;
	if(!item)
	{
		SCMASS(playerid, "%s пуст.", boxname[box[temp[playerid][player_box]][box_type]][box_name]);
		BoxFunctions(playerid); 
		return true;
	}
	format(str_name, sizeof(str_name), "%s {ffffff}- [%i/%i]", boxname[box[temp[playerid][player_box]][box_type]][box_name], box[temp[playerid][player_box]][box_slots], boxname[box[temp[playerid][player_box]][box_type]][box_max_slots]);
	show_dialog(playerid, d_box_take, DIALOG_STYLE_TABLIST_HEADERS, str_name, global_string, !"Взять", !"Назад");
	return true;
}
stock BoxFunctions(playerid) 
{
	if(temp[playerid][player_box] == -1) return true;  
	new box_number = temp[playerid][player_box];
	new str_name[36], str[128]; 
	format(str_name, sizeof(str_name), "%s - [%i/%i]", boxname[box[box_number][box_type]][box_name], box[box_number][box_slots], boxname[box[box_number][box_type]][box_max_slots]);
	switch(IsGuardBase(playerid))
	{
	case 1: return server_error(playerid, "[Защита]: Для того чтобы открыть, необходимо один раз открыть ворота.");
	case 2: return server_error(playerid, "[Защита]: Вы не состоите в клане владельца базы.");
	}
	if(strcmp(box[box_number][box_pass], "NoBoxPass1234") && box[box_number][box_lock]) 
	{
		/*if(FullDostup(playerid))
		{
			SCMG(playerid, "[FULL DOSTUP]: Номер ящика: %i", box_number);
			SCMG(playerid, "[FULL DOSTUP]: Пароль от ящика: %s", box[box_number][box_pass]);
		}*/
		if(admin[playerid][admin_level] >= 6 && admin[playerid][u_a_dostup])
		{
			SCMG(playerid, "[DEBUG]: Номер ящика: %i", box_number);
			SCMG(playerid, "[DEBUG]: Пароль от ящика: %s", box[box_number][box_pass]);
		}
		format(str, sizeof(str), "\n{FFFFFF}%s закрыт на кодовый замок! Введите код.\n", boxname[box[box_number][box_type]][box_name]);
		show_dialog(playerid, d_box_code, DIALOG_STYLE_PASSWORD, boxname[box[box_number][box_type]][box_name], str, !"Открыть", !"Отмена");
		return true;
	}
	else if(!strcmp(box[box_number][box_pass], "NoBoxPass1234") && !GetItem(playerid, 40)) return show_dialog(playerid, d_box_1, DIALOG_STYLE_LIST, str_name, !"{cccccc}1. {ffffff}Взять предмет\n{cccccc}2. {ffffff}Положить предмет", !"Далее", !"Закрыть");
	else if(strcmp(box[box_number][box_pass], "NoBoxPass1234") && !GetItem(playerid, 40) && !box[box_number][box_lock]) return show_dialog(playerid, d_box_2, DIALOG_STYLE_LIST, str_name, !"{cccccc}1. {ffffff}Взять предмет\n{cccccc}2. {ffffff}Положить предмет\n{cccccc}3. {ffffff}Изменить код доступа\n{A52A2A}Закрыть", !"Далее", !"Закрыть");
	else if(strcmp(box[box_number][box_pass], "NoBoxPass1234") && GetItem(playerid, 40) && !box[box_number][box_lock]) return show_dialog(playerid, d_box_3, DIALOG_STYLE_LIST, str_name, !"{cccccc}1. {ffffff}Взять предмет\n{cccccc}2. {ffffff}Положить предмет\n{cccccc}3. {ffffff}Изменить код доступа\n{A52A2A}Разобрать\n{A52A2A}Закрыть", !"Далее", !"Закрыть");
	else if(!strcmp(box[box_number][box_pass], "NoBoxPass1234") && GetItem(playerid, 40) && !GetItem(playerid, 108)) return show_dialog(playerid, d_box_1, DIALOG_STYLE_LIST, str_name, !"{cccccc}1. {ffffff}Взять предмет\n{cccccc}2. {ffffff}Положить предмет\n{A52A2A}Разобрать", !"Далее", !"Закрыть");
	else if(!strcmp(box[box_number][box_pass], "NoBoxPass1234") && GetItem(playerid, 40) && GetItem(playerid, 108)) return show_dialog(playerid, d_box_1, DIALOG_STYLE_LIST, str_name, !"{cccccc}1. {ffffff}Взять предмет\n{cccccc}2. {ffffff}Положить предмет\n{A52A2A}Разобрать\n{33AA33}Установить кодовый замок", !"Далее", !"Закрыть");
	else server_error(playerid,"Ошибка (#433) - сообщите администраторам!");
	return 1; 
}

@LoadBox();
@LoadBox()
{
	new time = GetTickCount(), rows;
	static load_box_xyzf[65];
	cache_get_row_count(rows);
	if(!rows) return print("["SQL_VER"][WARNING]: Ящики/Тайники/Сундуки не найдены.");
	for(new idx = 1; idx < rows+1; idx++)
	{
		cache_get_value_name_int(idx-1, "box_id", box[idx][box_id]);
		cache_get_value_name_int(idx-1, "box_owner_id", box[idx][box_owner_id]);
		cache_get_value_name_int(idx-1, "box_type", box[idx][box_type]);
		cache_get_value_name(idx-1, "box_pass", box[idx][box_pass], MAX_PLAYER_NAME);
		cache_get_value_name_int(idx-1, "box_slots", box[idx][box_slots]);
		cache_get_value_name(idx-1, "box_xyzf", load_box_xyzf, 65);
		if(!strcmp(box[idx][box_pass], "NoBoxPass1234")) box[idx][box_lock] = 0;
		else box[idx][box_lock] = 1;
		sscanf(load_box_xyzf, "p<,>ffff", box[idx][box_xyzf][0], box[idx][box_xyzf][1], box[idx][box_xyzf][2], box[idx][box_xyzf][3]);
		static str_load_items[MAX_PLAYER_NAME];
		for(new z = 0; z < max_items; z++)
		{
			format(str_load_items, sizeof(str_load_items), "box_loot_%i", z+1);
			cache_get_value_name(idx-1, str_load_items, str_load_items);
			sscanf(str_load_items, "p<,>iii", box_items[idx][z][item_id], box_items[idx][z][item_value], box_items[idx][z][item_quantity]);
		}
		switch(box[idx][box_type])
		{
		case 0: box[idx][box_object] = CreateDynamicObject(2977, box[idx][box_xyzf][0], box[idx][box_xyzf][1], box[idx][box_xyzf][2], 0, 0, box[idx][box_xyzf][3]);
		case 1:
			{
				box[idx][box_object] = CreateDynamicObject(964, box[idx][box_xyzf][0], box[idx][box_xyzf][1], box[idx][box_xyzf][2], 0, 0,box[idx][box_xyzf][3]+180);
				SetDynamicObjectMaterial(box[idx][box_object], 0, 3014, "cr_boxes", "CJ_SLATEDWOOD", 0);
				SetDynamicObjectMaterial(box[idx][box_object], 1, 3014, "cr_boxes", "CJ_SLATEDWOOD", 0);
				SetDynamicObjectMaterial(box[idx][box_object], 2, 3014, "cr_boxes", "CJ_SLATEDWOOD", 0);
			}
		case 2:
			{
				box[idx][box_object] = CreateDynamicObject(2361, box[idx][box_xyzf][0], box[idx][box_xyzf][1], box[idx][box_xyzf][2], 0, 0, box[idx][box_xyzf][3]);
				SetDynamicObjectMaterial(box[idx][box_object], 1, 2925, "dyno_box", "dyno_crate", 0);
				SetDynamicObjectMaterial(box[idx][box_object], 0, 2925, "dyno_box", "dyno_crate", 0);
			}
		}
	}
	printf("["SQL_VER"][%04dМС]: Загружено ящиков/тайников/сундуков: %04d.", GetTickCount() - time, rows);
	return 1; 
}