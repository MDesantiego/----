// itemid == 39 - Колесо
// itemid == 40 - Набор инструментов
// itemid == 41 - Запчасти
// itemid == 42 - Канистра
//engine, lights, alarm, doors, bonnet, boot
const car_slot = 20;
new 
	car_engine[MAX_VEHICLES char],
	car_lights[MAX_VEHICLES char],
	car_bonnet[MAX_VEHICLES char],
	car_boot[MAX_VEHICLES char];

	// car_player_use
enum car_info {
	car_id,
	car_model,
	car_tires[4],
	Float: car_static_pos_xyzf[4],
	Float: car_pos_xyzf[4],
	car_color[2],
	Float: car_health,
	Float: car_fuel,
	Float: car_mileage,
	car_the_trunk,
	car_the_trunk_info[max_items],
	car_death,
	car_admin,
	car_base
	// Броня на автомобили;
	/*car_protection_object[car_slot],
	car_protection[car_slot],
	car_protection_quantity[car_slot],
	Float: car_protection_x[car_slot],
	Float: car_protection_y[car_slot],
	Float: car_protection_z[car_slot],
	// Float: car_protection_f[car_slot],
	Float: car_protection_rx[car_slot],
	Float: car_protection_ry[car_slot],
	Float: car_protection_rz[car_slot],
	// Float: car_protection_rf[car_slot],*/
}
new CarInfo[MAX_VEHICLES][car_info];
// new car_object[MAX_PLAYERS];
	// car_edit_object[MAX_PLAYERS];

/*

		SetPVarInt(playerid, "ItemObjectCarID") - номер предмета;
		SetPVarInt(playerid, "SetObjectCarID") - номер объекта на автомобиль;
		SetPVarInt(playerid, "SetObjectCarQuantity") - процент объекта;
		SetPVarInt(playerid, "CarID") - номер автомобиля;
		SetPVarInt(playerid, "ObjectToCar") - Объект на автомобиле;
		SetPVarInt(playerid, "EditObjectToCar") - редактирование объекта на автомобиле;
*/

enum vehicle_structure { // Структура инвентаря;
	item_id, // Ид предмета;
	item_value, // Кол-Во;
	item_quantity, // Доп. значение;

	item_use_id,
	item_use_value,
	item_use_quantity
};
new 
	car_items[MAX_VEHICLES][max_items][vehicle_structure];
@LoadingOfCars();
@LoadingOfCars()
{
	new time = GetTickCount(), rows;
	cache_get_row_count(rows);
	if(!rows) return print("["SQL_VER"][WARNING]: Автомобили не найдены.");
	for(new idx = 1; idx <= rows; idx++)
	{
		cache_get_value_name_int(idx-1, "car_id", CarInfo[idx][car_id]);
		cache_get_value_name_int(idx-1, "car_model", CarInfo[idx][car_model]);
		cache_get_value_name_int(idx-1, "car_death", CarInfo[idx][car_death]);
		cache_get_value_name_int(idx-1, "car_color_one", CarInfo[idx][car_color][0]);
		cache_get_value_name_int(idx-1, "car_color_two", CarInfo[idx][car_color][1]);

		cache_get_value_name_int(idx-1, "car_tires_one", CarInfo[idx][car_tires][0]);
		cache_get_value_name_int(idx-1, "car_tires_two", CarInfo[idx][car_tires][1]);
		cache_get_value_name_int(idx-1, "car_tires_three", CarInfo[idx][car_tires][2]);
		cache_get_value_name_int(idx-1, "car_tires_four", CarInfo[idx][car_tires][3]);

		cache_get_value_name_float(idx-1, "car_fuel", CarInfo[idx][car_fuel]);
		cache_get_value_name_float(idx-1, "car_health", CarInfo[idx][car_health]);
		cache_get_value_name_float(idx-1, "car_mileage", CarInfo[idx][car_mileage]);
		cache_get_value_name_int(idx-1, "car_the_trunk", CarInfo[idx][car_the_trunk]);
		cache_get_value_name_int(idx-1, "car_base", CarInfo[idx][car_base]);

		/*for(new z = 0; z < car_slot+1; z++)
		{
			format(str_load_items, sizeof(str_load_items), "car_protection_%i", z+1);
			cache_get_value_name_int(0, str_load_items, CarInfo[idx][car_protection][z]);
			format(str_load_items, sizeof(str_load_items), "car_protection_quantity_%i", z+1);
			cache_get_value_name_int(0, str_load_items, CarInfo[idx][car_protection_quantity][z]);
			format(str_load_items, sizeof(str_load_items), "car_protection_x_%i", z+1);
			cache_get_value_name_float(0, str_load_items, CarInfo[idx][car_protection_x][z]);
			format(str_load_items, sizeof(str_load_items), "car_protection_y_%i", z+1);
			cache_get_value_name_float(0, str_load_items, CarInfo[idx][car_protection_y][z]);
			format(str_load_items, sizeof(str_load_items), "car_protection_z_%i", z+1);
			cache_get_value_name_float(0, str_load_items, CarInfo[idx][car_protection_z][z]);
			format(str_load_items, sizeof(str_load_items), "car_protection_rx_%i", z+1);
			cache_get_value_name_float(0, str_load_items, CarInfo[idx][car_protection_rx][z]);
			format(str_load_items, sizeof(str_load_items), "car_protection_ry_%i", z+1);
			cache_get_value_name_float(0, str_load_items, CarInfo[idx][car_protection_ry][z]);
			format(str_load_items, sizeof(str_load_items), "car_protection_rz_%i", z+1);
			cache_get_value_name_float(0, str_load_items, CarInfo[idx][car_protection_rz][z]);
			CarInfo[idx][car_protection_object][z] = CreateDynamicObject(
			CarInfo[idx][car_protection][z], 
			CarInfo[idx][car_protection_x][z],
			CarInfo[idx][car_protection_y][z],
			CarInfo[idx][car_protection_z][z],
			CarInfo[idx][car_protection_rx][z],
			CarInfo[idx][car_protection_ry][z],
			CarInfo[idx][car_protection_rz][z]);
			AttachDynamicObjectToVehicle(CarInfo[idx][car_protection_object][z], idx, 
			CarInfo[idx][car_protection_x][z],
			CarInfo[idx][car_protection_y][z],
			CarInfo[idx][car_protection_z][z],
			CarInfo[idx][car_protection_rx][z],
			CarInfo[idx][car_protection_ry][z],
			CarInfo[idx][car_protection_rz][z]);
		}*/
		static coords_car[96];
		cache_get_value_name(idx-1, "car_pos_xyzf", coords_car);
		sscanf(coords_car, "p<,>ffff", CarInfo[idx][car_pos_xyzf][0], CarInfo[idx][car_pos_xyzf][1], CarInfo[idx][car_pos_xyzf][2], CarInfo[idx][car_pos_xyzf][3]);
		
		static coords_static_car[96];
		cache_get_value_name(idx-1, "car_static_pos_xyzf", coords_static_car);
		sscanf(coords_static_car, "p<,>ffff", CarInfo[idx][car_static_pos_xyzf][0], CarInfo[idx][car_static_pos_xyzf][1], CarInfo[idx][car_static_pos_xyzf][2], CarInfo[idx][car_static_pos_xyzf][3]);
		
		new str_load_items[128];
		for(new z = 0; z < max_items; z++)
		{
			format(str_load_items, sizeof(str_load_items), "car_the_trunk_info_%i", z+1);
			cache_get_value_name(idx-1, str_load_items, str_load_items);
			sscanf(str_load_items, "p<,>iii", car_items[idx][z][item_id], car_items[idx][z][item_value], car_items[idx][z][item_quantity]);
		}
		if(CarInfo[idx][car_death] == 1)
		{
			CarInfo[idx][car_death] = 0;
			CarInfo[idx][car_mileage] = 0;
			CarInfo[idx][car_the_trunk] = 0;
			for(new s = 0; s != max_items; s++) 
			{ 
				CarInfo[idx][car_the_trunk_info][s] = 0; 
			}
			for(new vt = 0; vt != 4; vt++) 
			{
				switch(random(3)) 
				{
					case 0: CarInfo[idx][car_tires][vt] = 0;
					case 1: CarInfo[idx][car_tires][vt] = 2;
					case 2: CarInfo[idx][car_tires][vt] = 1;
				}
			}
			CarInfo[idx][car_static_pos_xyzf][0] = CarInfo[idx][car_pos_xyzf][0];
			CarInfo[idx][car_static_pos_xyzf][1] = CarInfo[idx][car_pos_xyzf][1];
			CarInfo[idx][car_static_pos_xyzf][2] = CarInfo[idx][car_pos_xyzf][2];
			CarInfo[idx][car_static_pos_xyzf][3] = CarInfo[idx][car_pos_xyzf][3];
			CarInfo[idx][car_color][0] = random(255);
			CarInfo[idx][car_color][1] = random(255);
			CarInfo[idx][car_health] = 600+random(400);
			CarInfo[idx][car_fuel] = (InfoOfFuel(idx)/2)+random(InfoOfFuel(idx)/2);
		}
		CreateVehicle(CarInfo[idx][car_model], CarInfo[idx][car_static_pos_xyzf][0], CarInfo[idx][car_static_pos_xyzf][1], CarInfo[idx][car_static_pos_xyzf][2], 
		CarInfo[idx][car_static_pos_xyzf][3], CarInfo[idx][car_color][0], CarInfo[idx][car_color][1], -1);
		ManualCar(idx, "clear");
		FailedTires(idx, GetCarWheels(idx));
	}
	printf("["SQL_VER"][%04dМС]: Загружено автомобилей: %04d.", GetTickCount() - time, (count_veh = rows));
	return true;
}

/*CMD:addcar(playerid)
{
	if(!FullDostup(playerid)) return server_error(playerid, "Доступ ограничен.");
	if(!IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы должны находиться в транспортном средстве!");
	static Float: veh_posf[4], str_sql[196];
	GetVehiclePos(GetPlayerVehicleID(playerid), veh_posf[0], veh_posf[1], veh_posf[2]);
	GetVehicleZAngle(GetPlayerVehicleID(playerid), veh_posf[3]);
	m_format(str_sql, sizeof(str_sql), "INSERT INTO "TABLE_CARS" (`car_model`, `car_pos_xyzf`, `car_add_date`) VALUES ('%i', '%f,%f,%f,%f', NOW())", 
	GetVehicleModel(GetPlayerVehicleID(playerid)), veh_posf[0], veh_posf[1], veh_posf[2], veh_posf[3]);
	m_query(str_sql); 
	server_error(playerid, "Автомобиль добавлен в базу данных, перезапустите сервер.", 1);
	server_error(playerid, "Не создавайте больше автомобилей близко к этому месту.", 0);
	server_error(playerid, "Для полной работоспособности необходимо перезапустить сервер!", 1);
	return true;
}*/
stock SetHealthVehicle(vehicleid, Float: value)
{
	CarInfo[vehicleid][car_health] = value;
	if(CarInfo[vehicleid][car_health] < 1) CarInfo[vehicleid][car_health] = 0;
	if(CarInfo[vehicleid][car_health] > 1000.0) CarInfo[vehicleid][car_health] = 1000.0;
	SetVehicleHealth(vehicleid, CarInfo[vehicleid][car_health]);
	return true;
}
public OnPlayerStateChange(playerid, newstate, oldstate) 
{
	foreach(Player, i)
    { 
        if(PlayerIsOnline(i)) continue;
       	if(observation[i][observation_id] == playerid) UpdateObservationStatus(i, playerid);
    } 
	switch(newstate)
	{
	case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER:
		{
			if(!CarInfo[GetPlayerVehicleID(playerid)][car_admin])
			{
				switch(IsGuardBase(playerid))
				{
				case 1: return TKICK(playerid, "[Защита]: Для использования автомобилей базы, необходимо один раз открыть ворота.");
				case 2: return TKICK(playerid, "[Защита]: Вы не состоите в клане владельца базы.");
				}
			}
		}
	}
	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
    {
		// if(GetPVarInt(playerid, "LoadWeapon") < gettime()) SetPVarInt(playerid,"LoadWeapon", gettime() + 3);
        new weapon, ammo;
        GetPlayerWeaponData(playerid, 4, weapon, ammo);
        SetPlayerArmedWeapon(playerid, weapon);
    }
	if(newstate == PLAYER_STATE_DRIVER) 
	{
		if(IsABycicle(GetPlayerVehicleID(playerid)))
        {
			if(CarInfo[GetPlayerVehicleID(playerid)][car_health] < 600) SetHealthVehicle(GetPlayerVehicleID(playerid), 1000.0);
			ManualCar(GetPlayerVehicleID(playerid), "car_engine", 1);
			return true;
        }
		if(TransportTires(GetPlayerVehicleID(playerid)) == 1)
		{
			ManualCar(GetPlayerVehicleID(playerid), "car_engine", 0);
		}
		FailedTires(GetPlayerVehicleID(playerid), GetCarWheels(GetPlayerVehicleID(playerid)));
		ShowSpeed(playerid);
	}
	if(oldstate == PLAYER_STATE_DRIVER) HideSpeed(playerid);
	return 1; 
}
public OnVehicleDeath(vehicleid, killerid)
{
	CarInfo[vehicleid][car_death] = 1;
	CarInfo[vehicleid][car_mileage] = 0;
	CarInfo[vehicleid][car_the_trunk] = 0;
	for(new s = 0; s != max_items; s++) 
	{ 
		CarInfo[vehicleid][car_the_trunk_info][s] = 0; 
	}
	for(new vt = 0; vt != 4; vt++) 
	{
		switch(random(3)) 
		{
		case 0: CarInfo[vehicleid][car_tires][vt] = 0;
		case 1: CarInfo[vehicleid][car_tires][vt] = 2;
		case 2: CarInfo[vehicleid][car_tires][vt] = 1;
		}
	}
	CarInfo[vehicleid][car_static_pos_xyzf][0] = CarInfo[vehicleid][car_pos_xyzf][0];
	CarInfo[vehicleid][car_static_pos_xyzf][1] = CarInfo[vehicleid][car_pos_xyzf][1];
	CarInfo[vehicleid][car_static_pos_xyzf][2] = CarInfo[vehicleid][car_pos_xyzf][2];
	CarInfo[vehicleid][car_static_pos_xyzf][3] = CarInfo[vehicleid][car_pos_xyzf][3];
	CarInfo[vehicleid][car_color][0] = random(255);
	CarInfo[vehicleid][car_color][1] = random(255);
	CarInfo[vehicleid][car_health] = 600+random(400);
	CarInfo[vehicleid][car_fuel] = (InfoOfFuel(vehicleid)/2)+random(InfoOfFuel(vehicleid)/2);
	ManualCar(vehicleid, "clear");
	SaveVehicle(vehicleid);
	return true;
}
public OnVehicleSpawn(vehicleid) 
{
	CarInfo[vehicleid][car_death] = 0;
	ChangeVehicleColor(vehicleid, CarInfo[vehicleid][car_color][0], CarInfo[vehicleid][car_color][1]);
	if(CarInfo[vehicleid][car_health] < 300) SetHealthVehicle(vehicleid, 300);
	else SetHealthVehicle(vehicleid, CarInfo[vehicleid][car_health]);
	SetVehiclePos(vehicleid, CarInfo[vehicleid][car_static_pos_xyzf][0], CarInfo[vehicleid][car_static_pos_xyzf][1], CarInfo[vehicleid][car_static_pos_xyzf][2]+0.5);
	SetVehicleZAngle(vehicleid, CarInfo[vehicleid][car_static_pos_xyzf][3]);
	ManualCar(vehicleid, "clear");
	SaveVehicle(vehicleid);
	return 1; 
}
stock ShowSpeed(playerid)
{
	if(IsABycicle(GetPlayerVehicleID(playerid))) return true;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
	server_accept(playerid, "Для просмотра клавиш, используте: /help.");
	server_accept(playerid, "Для открытия меню транспорта, используте: /car.");
	for(new i = 0; i != 13; i++) 
	{
		TextDrawShowForPlayer(playerid, Text: Speedomitr_TD[i]);
	}
	for(new i = 0; i != 4; i++) 
	{
		PlayerTextDrawShow(playerid, PlayerText: Speedomitr_PTD[playerid][i]);
	}
	temp[playerid][timer_speedomitr] = SetTimerEx("UpdateIsSpeedometer", 200, true, "i", playerid);
	return true;
}
stock HideSpeed(playerid)
{
	for(new i = 0; i != 13; i++) 
	{
		TextDrawHideForPlayer(playerid, Text: Speedomitr_TD[i]);
	}
	for(new i = 0; i != 4; i++) 
	{
		PlayerTextDrawHide(playerid, PlayerText: Speedomitr_PTD[playerid][i]);
	}
	KillTimer(temp[playerid][timer_speedomitr]);
	return true;
}
void UpdateIsSpeedometer(playerid)
{
	static str[56], Float: veh_health;
	new vehicleid = GetPlayerVehicleID(playerid);
	format(str, sizeof(str), "%i", GetSpeed(playerid));
	PlayerTextDrawSetString(playerid, Speedomitr_PTD[playerid][0], str);
	format(str, sizeof(str), "%i", floatround(CarInfo[vehicleid][car_fuel]));
	PlayerTextDrawSetString(playerid, Speedomitr_PTD[playerid][1], str);
	GetVehicleHealth(vehicleid, veh_health);
	format(str, sizeof(str), "%i", floatround(veh_health/10));
	PlayerTextDrawSetString(playerid, Speedomitr_PTD[playerid][2], str);
	if(!IsABycicle(vehicleid) && !IsBoatsAirplans(vehicleid)) 
	{
		CarInfo[vehicleid][car_mileage] += ((float(GetSpeed(playerid)) / 60.0) / 50.0); 
		format(str, sizeof(str), "%.1f", CarInfo[vehicleid][car_mileage]);
		PlayerTextDrawSetString(playerid, Speedomitr_PTD[playerid][3], str);
	}
	return true;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new weapon, ammo;
    GetPlayerWeaponData(playerid, 4, weapon, ammo);
	SetPlayerArmedWeapon(playerid, weapon);
    return 1;
} 
public OnPlayerExitVehicle(playerid, vehicleid) 
{
	new weapon, ammo;
    GetPlayerWeaponData(playerid, 4, weapon, ammo);
	SetPlayerArmedWeapon(playerid, weapon);
	/*if(IsAPlane(vehicleid))
    {
        temp[playerid][player_weapon_info][46] = true;
        temp[playerid][player_ammo_slot][11] += 1;
    }*/
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !CarInfo[vehicleid][car_admin]) SaveVehicle(vehicleid);
	return 1; 
}
stock Engine(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return true;
	if(IsABycicle(GetPlayerVehicleID(playerid))) return true;
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
	if(GetPVarInt(playerid, "AntiFloodEngine") > gettime()) return server_error(playerid, "Не флуди!"), true;
	SetPVarInt(playerid,"AntiFloodEngine", gettime() + 2);
	if(car_engine{GetPlayerVehicleID(playerid)} == 1)
	{
		ManualCar(GetPlayerVehicleID(playerid), "car_engine", 0);
		if(GetCarWheels(GetPlayerVehicleID(playerid)) == 0)
		{
			me_action(playerid, "заглушил(-а) мотор.");
			server_accept(playerid, "Мотор выключен.");
		}
		else
		{
			me_action(playerid, "заглушил(-а) двигатель.");
			server_accept(playerid, "Двигатель выключен.");
		}
		return true;
	}
	if(!CarInfo[GetPlayerVehicleID(playerid)][car_fuel]) 
	{
		server_error(playerid, "В транспорте закончилось топливо!");
		ManualCar(GetPlayerVehicleID(playerid), "off");
		return true;
	}
	switch(GetCarWheels(GetPlayerVehicleID(playerid)))
	{
	case 0:
		{
			ManualCar(GetPlayerVehicleID(playerid), "car_engine", 1);
			me_action(playerid, "завел(-а) мотор.");
			server_accept(playerid, "Мотор заведен.");
			return true;
		}
	}
	if(TransportTires(GetPlayerVehicleID(playerid)))
	{
		if(GetTires(GetPlayerVehicleID(playerid)) == GetCarWheels(GetPlayerVehicleID(playerid)) && GetTiresFail(GetPlayerVehicleID(playerid)) == GetCarWheels(GetPlayerVehicleID(playerid))) 
		{
			SCMASS(playerid, "Необходимо колес %i из %i.", GetCarWheels(GetPlayerVehicleID(playerid)), GetCarWheels(GetPlayerVehicleID(playerid)));
		}
		else
		{
			static tires_failed[3];
			switch(GetCarWheels(GetPlayerVehicleID(playerid)))
			{
			case 4:
				{
					switch(GetTires(GetPlayerVehicleID(playerid)))
					{
					case 1: tires_failed[0] = 3;
					case 2: tires_failed[0] = 2;
					case 3: tires_failed[0] = 1;
					default: tires_failed[0] = 0;
					}
					switch(GetTiresFail(GetPlayerVehicleID(playerid)))
					{
					case 1: tires_failed[1] = 3;
					case 2: tires_failed[1] = 2;
					case 3: tires_failed[1] = 1;
					default: tires_failed[1] = 0;
					}
					tires_failed[2] = GetCarWheels(GetPlayerVehicleID(playerid)) - tires_failed[1] - tires_failed[0];
				}
			case 2:
				{
					switch(GetTires(GetPlayerVehicleID(playerid)))
					{
					case 1: tires_failed[0] = 1;
					default: tires_failed[0] = 0;
					}
					switch(GetTiresFail(GetPlayerVehicleID(playerid)))
					{
					case 1: tires_failed[1] = 1;
					default: tires_failed[1] = 0;
					}
					tires_failed[2] = GetCarWheels(GetPlayerVehicleID(playerid)) - tires_failed[1] - tires_failed[0];
				}
			}

			SCMASS(playerid, "Необходимо колес %i из %i.", tires_failed[2], GetCarWheels(GetPlayerVehicleID(playerid)));
			if(tires_failed[0]) SCMASS(playerid, "Целых колес: %i.", tires_failed[0]);
			if(tires_failed[1]) SCMASS(playerid, "Пробитых колес: %i.", tires_failed[1]);
		}
		server_error(playerid, "Вы не можете управлять т/с пока не буду установлены все компоненты!");
		return true;
	}
	static Float: get_car_health;
	GetVehicleHealth(GetPlayerVehicleID(playerid), get_car_health);
	if(get_car_health < 300) 
	{
		server_error(playerid, "Транспортное средство сильно повреждено, почините его чтобы завести.");
		ManualCar(GetPlayerVehicleID(playerid), "off");
		return true;
	}
	FailedTires(GetPlayerVehicleID(playerid), GetCarWheels(GetPlayerVehicleID(playerid)));
	ManualCar(GetPlayerVehicleID(playerid), "car_engine", 1);
	me_action(playerid, "завел(-а) двигатель.");
	return true;
}
stock ManualCar(vehicleid, const name[], status = 0)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	if(!strcmp(name, "car_engine", false))
	{
		car_engine{vehicleid} = status;
		SetVehicleParamsEx(vehicleid, status, lights, alarm, doors, bonnet, boot, objective);
	}
	if(!strcmp(name, "car_lights", false))
	{
		car_lights{vehicleid} = status;
		SetVehicleParamsEx(vehicleid, engine, status, alarm, doors, bonnet, boot, objective);
	}
	if(!strcmp(name, "car_bonnet", false))
	{
		car_bonnet{vehicleid} = status;
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, status, boot, objective);
	}
	if(!strcmp(name, "car_boot", false))
	{
		car_boot{vehicleid} = status;
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, status, objective);
	}
	if(!strcmp(name, "off", false))
	{
		car_engine{vehicleid} = 0;
		car_lights{vehicleid} = 0;
		SetVehicleParamsEx(vehicleid, car_engine{vehicleid}, car_lights{vehicleid}, alarm, doors, bonnet, boot, objective);
	}
	if(!strcmp(name, "clear", false))
	{
		car_engine{vehicleid} = 0;
		car_lights{vehicleid} = 0;
		car_bonnet{vehicleid} = 0;
		car_boot{vehicleid} = 0;
		SetVehicleParamsEx(vehicleid, car_engine{vehicleid}, car_lights{vehicleid}, alarm, doors, car_bonnet{vehicleid}, car_boot{vehicleid}, objective);
	}
	return true;
}
stock GetTires(vehicleid)
{
	static tires = 0;
	switch(GetCarWheels(vehicleid))
	{
	case 4:
		{
			if(tires) tires = 0;
			if(CarInfo[vehicleid][car_tires][0] != 1) tires++;
			if(CarInfo[vehicleid][car_tires][1] != 1) tires++;
			if(CarInfo[vehicleid][car_tires][2] != 1) tires++;
			if(CarInfo[vehicleid][car_tires][3] != 1) tires++;
		}
	case 2: 
		{
			if(tires) tires = 0;
			if(CarInfo[vehicleid][car_tires][0] != 1) tires++;
			if(CarInfo[vehicleid][car_tires][1] != 1) tires++;
		}
	case 0: tires = 0;
	}
	return tires;
}
stock GetTiresFail(vehicleid)
{
	static tires = 0;
	switch(GetCarWheels(vehicleid))
	{
	case 4:
		{
			if(tires) tires = 0;
			if(CarInfo[vehicleid][car_tires][0] != 2) tires++;
			if(CarInfo[vehicleid][car_tires][1] != 2) tires++;
			if(CarInfo[vehicleid][car_tires][2] != 2) tires++;
			if(CarInfo[vehicleid][car_tires][3] != 2) tires++;
		}
	case 2: 
		{
			if(tires) tires = 0;
			if(CarInfo[vehicleid][car_tires][0] != 2) tires++;
			if(CarInfo[vehicleid][car_tires][1] != 2) tires++;
		}
	case 0: tires = 0;
	}
	return tires;
}
stock TransportTires(vehicleid)
{
	static transp_tir = 1;
	if(transp_tir) transp_tir = 0;
	switch(GetCarWheels(vehicleid))
	{
	case 4:
		{
			if(GetTires(vehicleid) == 0 && GetTiresFail(vehicleid) != 4) return transp_tir = 1;
			if(GetTires(vehicleid) == 1 && GetTiresFail(vehicleid) != 3) return transp_tir = 1;
			if(GetTires(vehicleid) == 2 && GetTiresFail(vehicleid) != 2) return transp_tir = 1;
			if(GetTires(vehicleid) == 3 && GetTiresFail(vehicleid) != 1) return transp_tir = 1;
			if(GetTiresFail(vehicleid) == 0 && GetTires(vehicleid) != 4) return transp_tir = 1;
			if(GetTiresFail(vehicleid) == 1 && GetTires(vehicleid) != 3) return transp_tir = 1;
			if(GetTiresFail(vehicleid) == 2 && GetTires(vehicleid) != 2) return transp_tir = 1;
			if(GetTiresFail(vehicleid) == 3 && GetTires(vehicleid) != 1) return transp_tir = 1;
		}
	case 2:
		{
			if(GetTires(vehicleid) == 0 && GetTiresFail(vehicleid) != 2) return transp_tir = 1;
			if(GetTires(vehicleid) == 1 && GetTiresFail(vehicleid) != 1) return transp_tir = 1;
			if(GetTiresFail(vehicleid) == 0 && GetTires(vehicleid) != 2) return transp_tir = 1;
			if(GetTiresFail(vehicleid) == 1 && GetTires(vehicleid) != 1) return transp_tir = 1;
		}
	}
	if(GetTires(vehicleid) == GetCarWheels(vehicleid) && GetTiresFail(vehicleid) == GetCarWheels(vehicleid)) return transp_tir = 1;
	return transp_tir;
}
stock FailedTires(vehicleid, value)
{
	new panels, doors, lights, tires;	
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	switch(value)
	{
	case 2:
		{
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 0);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 3);
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 1);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 2);
		}
	case 4:
		{
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] != 2 && CarInfo[vehicleid][car_tires][2] != 2 && CarInfo[vehicleid][car_tires][3] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 0);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] == 2 && CarInfo[vehicleid][car_tires][2] == 2 && CarInfo[vehicleid][car_tires][3] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 15);
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] != 2 && CarInfo[vehicleid][car_tires][2] != 2 && CarInfo[vehicleid][car_tires][3] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 1);
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] != 2 && CarInfo[vehicleid][car_tires][2] == 2 && CarInfo[vehicleid][car_tires][3] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 2);
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] != 2 && CarInfo[vehicleid][car_tires][2] == 2 && CarInfo[vehicleid][car_tires][3] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 3);
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] == 2 && CarInfo[vehicleid][car_tires][2] != 2 && CarInfo[vehicleid][car_tires][3] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 4);
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] == 2 && CarInfo[vehicleid][car_tires][2] != 2 && CarInfo[vehicleid][car_tires][3] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 5);
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] == 2 && CarInfo[vehicleid][car_tires][2] == 2 && CarInfo[vehicleid][car_tires][3] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 6);
			if(CarInfo[vehicleid][car_tires][0] != 2 && CarInfo[vehicleid][car_tires][1] == 2 && CarInfo[vehicleid][car_tires][2] == 2 && CarInfo[vehicleid][car_tires][3] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 7);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] != 2 && CarInfo[vehicleid][car_tires][2] != 2 && CarInfo[vehicleid][car_tires][3] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 8);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] != 2 && CarInfo[vehicleid][car_tires][2] != 2 && CarInfo[vehicleid][car_tires][3] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 9);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] != 2 && CarInfo[vehicleid][car_tires][2] == 2 && CarInfo[vehicleid][car_tires][3] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 10);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] != 2 && CarInfo[vehicleid][car_tires][2] == 2 && CarInfo[vehicleid][car_tires][3] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 11);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] == 2 && CarInfo[vehicleid][car_tires][2] != 2 && CarInfo[vehicleid][car_tires][3] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 12);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] == 2 && CarInfo[vehicleid][car_tires][2] != 2 && CarInfo[vehicleid][car_tires][3] == 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 13);
			if(CarInfo[vehicleid][car_tires][0] == 2 && CarInfo[vehicleid][car_tires][1] == 2 && CarInfo[vehicleid][car_tires][2] == 2 && CarInfo[vehicleid][car_tires][3] != 2) return UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, 14);
		}
	}
	return true;
}
stock GetAttackTrires(vehicleid)
{
	new panels, doors, lights, tires;	
	GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
	switch(tires)
	{
	case 0:
		{
			if(CarInfo[vehicleid][car_tires][0] == 1) CarInfo[vehicleid][car_tires][0] = 1;
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 1;
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 1;
			if(CarInfo[vehicleid][car_tires][3] == 1) CarInfo[vehicleid][car_tires][3] = 1;
		}
	case 1:
		{
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 2;
		}
	case 2:
		{
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 2;
			if(CarInfo[vehicleid][car_tires][3] == 1) CarInfo[vehicleid][car_tires][3] = 2;
		}
	case 4:
		{
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
		}
	case 5:
		{
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
			if(CarInfo[vehicleid][car_tires][3] == 1) CarInfo[vehicleid][car_tires][3] = 2;
		}
	case 6:
		{
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 2;
		}
	case 7:
		{
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 2;
			if(CarInfo[vehicleid][car_tires][3] == 1) CarInfo[vehicleid][car_tires][3] = 2;
		}
	case 8:
		{
			if(CarInfo[vehicleid][car_tires][0] == 1) CarInfo[vehicleid][car_tires][0] = 2;
		}
	case 9:
		{
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
			if(CarInfo[vehicleid][car_tires][3] == 1) CarInfo[vehicleid][car_tires][3] = 2;
		}
	case 10:
		{
			if(CarInfo[vehicleid][car_tires][0] == 1) CarInfo[vehicleid][car_tires][0] = 2;
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 2;
		}
	case 11:
		{
			if(CarInfo[vehicleid][car_tires][0] == 1) CarInfo[vehicleid][car_tires][0] = 2;
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 2;
			if(CarInfo[vehicleid][car_tires][3] == 1) CarInfo[vehicleid][car_tires][3] = 2;
		}
	case 12:
		{
			if(CarInfo[vehicleid][car_tires][0] == 1) CarInfo[vehicleid][car_tires][0] = 2;
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
		}
	case 13:
		{
			if(CarInfo[vehicleid][car_tires][0] == 1) CarInfo[vehicleid][car_tires][0] = 2;
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
			if(CarInfo[vehicleid][car_tires][3] == 1) CarInfo[vehicleid][car_tires][3] = 2;
		}
	case 14:
		{
			if(CarInfo[vehicleid][car_tires][0] == 1) CarInfo[vehicleid][car_tires][0] = 2;
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 2;
		}
	case 15:
		{
			if(CarInfo[vehicleid][car_tires][0] == 1) CarInfo[vehicleid][car_tires][0] = 2;
			if(CarInfo[vehicleid][car_tires][1] == 1) CarInfo[vehicleid][car_tires][1] = 2;
			if(CarInfo[vehicleid][car_tires][2] == 1) CarInfo[vehicleid][car_tires][2] = 2;
			if(CarInfo[vehicleid][car_tires][3] == 1) CarInfo[vehicleid][car_tires][3] = 2;
		}
	}
	return true;
}
stock IsABycicle(vehicleid) 
{// Велики
	switch(GetVehicleModel(vehicleid))
	{
	case 481, 509, 510: return 1;
	}
	return 0; 
}
stock IsBoatsAirplans(vehicleid) 
{// Верталеты, самалеты, лодки
	switch(GetVehicleModel(vehicleid))
	{
	case 417, 425, 430, 446..448, 452..454, 460, 469, 472, 473, 476, 487, 488, 493, 497, 511..513, 519, 520, 548, 553, 563, 577, 592, 593, 595: return 1;
	}
	return 0; 
}
stock IsAPlane(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 417, 487, 488, 497, 563, 447, 469: return 1;
    }
    return 0;
}  
stock IsABike(vehicleid) 
{// Мотоциклы
	switch(GetVehicleModel(vehicleid))
	{
	case 448, 461..463, 468, 471, 521..523, 581, 586: return 1;
	}
	return 0; 
}
stock GetCarWheels(vehicleid) 
{
	switch(GetVehicleModel(vehicleid))
	{
		case 400..416,418..424,426..429,433..445,451,455..459,466,467,470,471,474,475,477..480,482,483,489..492,494..496, 
			498..508,514..518,524..536,540..547,549..552,554..562,565..568,572..576,578..580,582..585,587..589,596..610: return 4;
		case 586,581,521..523,468,461..463,448: return 2;
		default: return false; 
	}
	return false; 
}
stock InfoOfFuel(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
	case 406, 432: return 200;
	case 433: return 150;
	case 403, 443, 515: return 140;
	case 427, 514: return 120;
	case 413, 414, 455, 456: return 110;
	case 407, 428, 431, 437, 440, 444, 495, 556, 557: return 100;
	case 544, 578, 579: return 90;
	case 400, 408, 416, 422, 470, 489, 490, 498, 499, 505, 524, 599: return 80;
	case 418, 421, 459, 479, 482, 582: return 70;
	case 409, 411, 415, 420, 426, 442, 445, 466, 467, 507, 528, 529, 534..536: return 60;
	case 402, 405, 410, 419, 429, 451, 458, 474, 475, 477, 483, 486, 492, 494, 502..504, 516..518, 525, 526, 546, 547, 549..552, 554, 558..562, 565..567, 575, 576, 580, 585, 
	587, 589, 596..598, 609: return 50;
	case 439, 461, 491, 506, 508, 540..543, 602..605: return 45;
	case 401, 404, 424, 438, 448, 462, 463, 480, 496, 500, 523, 527, 533, 600: return 40;
	case 423, 436, 478, 485, 522, 532, 545, 555, 568, 573, 581, 586: return 35;
	case 434, 468, 521, 531, 588, 601: return 30;
	case 457, 471, 530, 539, 571, 572, 574: return 20;
	case 583: return 15;
	default: return 60;
	}
	return 0;
}
stock SaveVehicle(vehicleid)
{
	GetVehiclePos(vehicleid, CarInfo[vehicleid][car_static_pos_xyzf][0], CarInfo[vehicleid][car_static_pos_xyzf][1], CarInfo[vehicleid][car_static_pos_xyzf][2]);
	GetVehicleZAngle(vehicleid, CarInfo[vehicleid][car_static_pos_xyzf][3]);
	GetVehicleHealth(vehicleid, CarInfo[vehicleid][car_health]);
	
	CarInfo[vehicleid][car_base] = IsGuardBaseVehicle(vehicleid);
	new str_sql[900];
	m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CARS" SET `car_color_one` = '%i', `car_color_two` = '%i', `car_tires_one` = '%i', `car_tires_two` = '%i', \
	`car_tires_three` = '%i', `car_tires_four` = '%i', `car_fuel` = '%f', `car_the_trunk` = '%i', `car_static_pos_xyzf` = '%f,%f,%f,%f', `car_mileage` = '%f', \
	`car_death` = '%i', `car_health` = '%f', `car_base` = '%i' WHERE `car_id` = '%i';", 
	CarInfo[vehicleid][car_color][0], CarInfo[vehicleid][car_color][1], CarInfo[vehicleid][car_tires][0], CarInfo[vehicleid][car_tires][1], CarInfo[vehicleid][car_tires][2], 
	CarInfo[vehicleid][car_tires][3], CarInfo[vehicleid][car_fuel], CarInfo[vehicleid][car_the_trunk], CarInfo[vehicleid][car_static_pos_xyzf][0], 
	CarInfo[vehicleid][car_static_pos_xyzf][1], CarInfo[vehicleid][car_static_pos_xyzf][2], CarInfo[vehicleid][car_static_pos_xyzf][3], CarInfo[vehicleid][car_mileage], 
	CarInfo[vehicleid][car_death], CarInfo[vehicleid][car_health], CarInfo[vehicleid][car_base], CarInfo[vehicleid][car_id]);
	m_query(str_sql);

	for(new z = 0; z < max_items; z++)
	{
		 m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CARS" SET `car_the_trunk_info_%i` = '%i,%i,%i' WHERE `car_id` = '%i' LIMIT 1", 
		 z+1, car_items[vehicleid][z][item_id], car_items[vehicleid][z][item_value], car_items[vehicleid][z][item_quantity], CarInfo[vehicleid][car_id]);
         m_query(str_sql);
	}
	/*for(new z = 0; z < car_slot; z++)
	{
		m_format(str_sql, sizeof(str_sql), "UPDATE "TABLE_CARS" SET `car_protection_%i` = '%i', `car_protection_quantity_%i` = '%i', `car_protection_x_%i` = '%f', `car_protection_y_%i` = '%f', `car_protection_z_%i` = '%f', `car_protection_rx_%i` = '%f', `car_protection_ry_%i` = '%f', `car_protection_rz_%i` = '%f' WHERE `car_id` = '%i' LIMIT 1", 
		z+1, 
		CarInfo[vehicleid][car_protection][z], 
		CarInfo[vehicleid][car_protection_quantity][z], 
		CarInfo[vehicleid][car_protection_x][z],
		CarInfo[vehicleid][car_protection_y][z],
		CarInfo[vehicleid][car_protection_z][z],
		CarInfo[vehicleid][car_protection_rx][z],
		CarInfo[vehicleid][car_protection_ry][z],
		CarInfo[vehicleid][car_protection_rz][z]);
        m_query(str_sql);
	}*/
	printf("["SQL_VER"]: Автомобиль %i успешно сохранен.", vehicleid);
	return true;
}
new Float: GasStation[][3] = 
{
	{-1606.6432,-2713.7161,49.5492},
	{-90.5515,-1169.4578,2.4079},
	{1004.0070,-939.3102,42.1797},
	{1944.3260,-1772.9254,13.3906},
	{-1609.7958,-2718.2048,48.5391},
	{-2029.4968,156.4366,28.9498},
	{-2408.7590,976.0934,45.4175},
	{-2243.9629,-2560.6477,31.8841},
	{-1676.6323,414.0262,6.9484},
	{2202.2349,2474.3494,10.5258},
	{614.9333,1689.7418,6.6968},
	{-1328.8250,2677.2173,49.7665},
	{70.3882,1218.6783,18.5165},
	{2113.7390,920.1079,10.5255},
	{-1327.7218,2678.8723,50.0625},
	{656.4265,-559.8610,16.5015},
	{656.3797,-570.4138,16.5015},
	{-1471.0824,1863.8571,32.6328}
};

stock EquipmentVehicle(playerid) 
{
	if(IsPlayerInAnyVehicle(playerid)) return true;
	new Float: POS[3], i = AntiBagAutoDoop[playerid];
	GetCoordBootVehicle(i, POS[0], POS[1], POS[2]);
	if(!IsPlayerInRangeOfPoint(playerid, 1.5, POS[0], POS[1], POS[2])) return server_error(playerid, "Вы должны быть рядом с авто.");
	if(car_boot{i} == VEHICLE_PARAMS_OFF) return server_error(playerid, "Багажник закрыт.");
	new str[96], str_name[40], item = 0, slots = 0;
	global_string[0] = EOS;
	strcat(global_string, "Кол-во\tНазвание\n");
	for(new z = 0; z < max_items; z++)
	{
		if(!car_items[i][z][item_id]) continue;
		item++;
		car_items[i][item-1][item_use_id] = car_items[i][z][item_id];
		car_items[i][item-1][item_use_value] = car_items[i][z][item_value];
		car_items[i][item-1][item_use_quantity] = car_items[i][z][item_quantity];

		if(car_items[i][item-1][item_use_quantity] < 1) format(str, sizeof(str), "%i\t%s\n",
			car_items[i][item-1][item_use_value], loots[car_items[i][item-1][item_use_id]][loot_name]);
		if(car_items[i][item-1][item_use_quantity] > 0) format(str, sizeof(str), "%i\t%s [%i]\n",
			car_items[i][item-1][item_use_value], loots[car_items[i][item-1][item_use_id]][loot_name],
			car_items[i][item-1][item_use_quantity]);
		strcat(global_string, str);
		slots += car_items[i][item-1][item_use_value];
	}
	CarInfo[i][car_the_trunk] = slots;
	if(!item) return server_error(playerid, "Багажник пуст.");
	format(str_name, sizeof(str_name), "Багажник [%d/100]", CarInfo[i][car_the_trunk]);
	show_dialog(playerid, d_car_inv, DIALOG_STYLE_TABLIST_HEADERS, str_name, global_string, !"Взять", !"Закрыть");
	return 1; 
}

stock RemoveItemFromVehicle(vehicleid, item, quantity = 0)
{
	for(new z = 0; z < max_items; z++)
	{
		if(!car_items[vehicleid][z][item_id]) continue;
		if(car_items[vehicleid][z][item_id] != item) continue;
		if(car_items[vehicleid][z][item_quantity] != quantity) continue;
		car_items[vehicleid][z][item_value]--;
		if(!car_items[vehicleid][z][item_value])
		{
			car_items[vehicleid][z][item_id] = 0;
			car_items[vehicleid][z][item_value] = 0;
			car_items[vehicleid][z][item_quantity] = 0;
		}
		break;
	}
	return true;
}
stock PutVehicle(playerid)
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
	show_dialog(playerid, d_car_put, DIALOG_STYLE_TABLIST_HEADERS, str_name, global_string, !"Положить", !"Назад");
	return true;
}

stock AddVehicleItem(boxidx, item, value_one, value_two = 0)
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
				if(!car_items[boxidx][z][item_id]) continue;
				if(car_items[boxidx][z][item_id] != item) continue;
				if(car_items[boxidx][z][item_value] < 1) continue;
				if(car_items[boxidx][z][item_quantity] != magazammo) continue;
				protect = 1;
				break;
			}
			new 
				get_ = value_one % magazammo;
				// get_ = params[1] % magazammo;
			for(new zx = 0; zx < max_items; zx++)
			{
				if(get_ == 0) break;
				if(car_items[boxidx][zx][item_id] != item) continue;
				if(car_items[boxidx][zx][item_quantity] >= magazammo) continue;
				if((get_ + car_items[boxidx][zx][item_quantity]) == magazammo)
				{
					ammo_value++;
					car_items[boxidx][zx][item_id] = 0;
					car_items[boxidx][zx][item_value] = 0;
					car_items[boxidx][zx][item_quantity] = 0;
					protect = 1;
					break;
				}
				if((get_ + car_items[boxidx][zx][item_quantity]) < magazammo)
				{
					count_++;
					protect = 1;
					car_items[boxidx][zx][item_quantity] += get_;
					break;
				}
				if((get_ + car_items[boxidx][zx][item_quantity]) > magazammo)
				{
					if(!protect)
					{
						ammo_value += ((get_ + car_items[boxidx][zx][item_quantity]) /  magazammo);
						ammo_val = (get_ + car_items[boxidx][zx][item_quantity]) % magazammo;
						car_items[boxidx][zx][item_id] = 0;
						car_items[boxidx][zx][item_value] = 0;
						car_items[boxidx][zx][item_quantity] = 0;
					}
					else 
					{
						protect = 1;
						ammo_value += ((get_ + car_items[boxidx][zx][item_quantity]) /  magazammo);
						car_items[boxidx][zx][item_quantity] = (get_ + car_items[boxidx][zx][item_quantity]) % magazammo;
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
			if(!car_items[boxidx][z][item_id]) continue;
			if(car_items[boxidx][z][item_id] != item) continue;
			switch(car_items[boxidx][z][item_id])
			{
				case 18..25, 63..65, 75..76:
				{
					if(value_one < magazammo && !ammo_value) break;
					count_++;
					protect = 1;
					car_items[boxidx][z][item_value] += (value_one /  magazammo) + ammo_value;
					if(car_items[boxidx][z][item_quantity] < magazammo) car_items[boxidx][z][item_quantity] = magazammo;
					break;
				}
			}
			if(count_) break;
			if(car_items[boxidx][z][item_quantity] != value_two) continue;
			count_++;
			car_items[boxidx][z][item_value] += value_one;
			break;
		}
	}
	if(!count_)
	{
		for(new z = 0; z < max_items; z++)
		{
			if(car_items[boxidx][z][item_id]) continue;
			switch(item)
			{
				case 18..25, 63..65, 75..76:
				{
					count_++;
					if(!ammo_val) protect = 1;
					if(!protect) ammo_value--;
					car_items[boxidx][z][item_id] = item;
					car_items[boxidx][z][item_value] += (value_one /  magazammo) + ammo_value;
					if(car_items[boxidx][z][item_value] < 1) car_items[boxidx][z][item_value] = 1;
					if(ammo_val) car_items[boxidx][z][item_quantity] = magazammo;
					else 
					{
						if(magazammo > value_one && !ammo_value) car_items[boxidx][z][item_quantity] = value_one;
						else car_items[boxidx][z][item_quantity] = magazammo;
					}
					if(car_items[boxidx][z][item_quantity] < 1) car_items[boxidx][z][item_quantity] = magazammo;
					break;
				}
			}
			if(!count_)
			{
				count_++;
				protect = 1;
				car_items[boxidx][z][item_id] = item;
				car_items[boxidx][z][item_value] = value_one;
				car_items[boxidx][z][item_quantity] = value_two;
				if(car_items[boxidx][z][item_value] < 1) car_items[boxidx][z][item_value] = 1;
				break;
			}
		}
		if(!protect)
		{
			for(new z = 0; z < max_items; z++)
			{
				if(car_items[boxidx][z][item_id]) continue;
				car_items[boxidx][z][item_id] = item;
				car_items[boxidx][z][item_value] = 1;
				car_items[boxidx][z][item_quantity] = ammo_val;
				break;
			}
		}
	}
	return true;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	if(!CarInfo[vehicleid][car_admin] && CarInfo[vehicleid][car_base] && 
	GetVehicleDistanceFromPoint(vehicleid, CarInfo[vehicleid][car_static_pos_xyzf][0], CarInfo[vehicleid][car_static_pos_xyzf][1], CarInfo[vehicleid][car_static_pos_xyzf][2]) > 2.0)
	{
		SetVehiclePos(vehicleid, CarInfo[vehicleid][car_static_pos_xyzf][0], CarInfo[vehicleid][car_static_pos_xyzf][1], CarInfo[vehicleid][car_static_pos_xyzf][2]+0.5);
	}
	#if defined VEH_OnUnoccupiedVehicleUpdate
		return VEH_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnUnoccupiedVehicleUpdate
    #undef OnUnoccupiedVehicleUpdate
#else
    #define _ALS_OnUnoccupiedVehicleUpdate
#endif
#define OnUnoccupiedVehicleUpdate VEH_OnUnoccupiedVehicleUpdate

#if defined VEH_OnUnoccupiedVehicleUpdate
    forward VEH_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);
#endif