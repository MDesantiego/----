/* 
    Описание: Предметы;
    Автор: zummore;
*/
#if defined _loots_included
	#endinput
#endif

#define _loots_included

/*
	loot_quality:
	1 - Распространённый; (AFEEEE)
	2 - Редкий; (FF7F50)
	3 - Очень редкий; (A52A2A)

	loot_type:
	1 - Еда;
	2 - Медикоменты;
	3 - Одежда;
	4 - Оружие;
	5 - Патроны;
	6 - Броня;
	7 - Остальное;
*/
enum structure_loots { 
	loot_id,
	loot_object,
	loot_name[64],
	loot_about[96],
	loot_type,
	loot_price,
	loot_quality
}
new loots[max_items][structure_loots],
	count_loots = 0,
	loot_quality_name[][30] = {
	{"{33AA33}Распространённый"},
	{"{FF6600}Редкий"},
	{"{FF0000}Очень редкий"}
};
@LoadLoots();
@LoadLoots()
{
	new time = GetTickCount(), rows;
	cache_get_row_count(rows);
	if(!rows) return print("["SQL_VER"][WARNING]: Предметы не найдены.");
	for(new idx = 1; idx < rows + 1; idx++)
	{
		cache_get_value_name_int(idx-1, "loot_id", loots[idx][loot_id]);
		cache_get_value_name(idx-1, "loot_name", loots[idx][loot_name], 64);
		cache_get_value_name(idx-1, "loot_about", loots[idx][loot_about], 96);
		cache_get_value_name_int(idx-1, "loot_object", loots[idx][loot_object]);
		cache_get_value_name_int(idx-1, "loot_type", loots[idx][loot_type]);
		cache_get_value_name_int(idx-1, "loot_price", loots[idx][loot_price]);
		cache_get_value_name_int(idx-1, "loot_quality", loots[idx][loot_quality]);
	}
	LoadAllLoot();
	count_loots = rows + 1;
	printf("["SQL_VER"][%04dМС]: Загружено предметов: %04d.", GetTickCount() - time, count_loots-1);
	return 1; 
}
stock getWeaponByAmmo(ammo) 
{
	new item_weapon;
	switch(ammo) 
	{
		case 18: item_weapon = 10; //Shotgun
		case 19: item_weapon = 11; // deagle
		case 20: item_weapon = 12; // ak
		case 21: item_weapon = 13; // m4
		case 22: item_weapon = 14; // sniper rifle
		case 23: item_weapon = 15; // uzi
		case 24: item_weapon = 16; // mp5
		case 25: item_weapon = 17; // tec-9
		case 63: item_weapon = 59; // 9m
		case 64: item_weapon = 60; // silenced 9mm
		case 65: item_weapon = 61; // Sawnoff
		case 66: item_weapon = 62; // rpg
		case 75: item_weapon = 71; // Country rifle
		case 76: item_weapon = 72; // Combat Shotgun

	}
	return item_weapon; 
}
stock getAmmoByWeapon(weapon) 
{
	new item_ammo;
	switch(weapon) 
	{
		case 10: item_ammo = 18; // Shotgun
		case 11: item_ammo = 19; // deagle
		case 12: item_ammo = 20; // ak
		case 13: item_ammo = 21; // m4
		case 14: item_ammo = 22; // sniper rifle
		case 15: item_ammo = 23; // uzi
		case 16: item_ammo = 24; // mp5
		case 17: item_ammo = 25; // tec-9
		case 59: item_ammo = 63; // 9m
		case 60: item_ammo = 64; // silenced 9mm
		case 61: item_ammo = 65; // Sawnoff
		case 62: item_ammo = 66; // rpg
		case 71: item_ammo = 75; // Country rifle
		case 72: item_ammo = 76; // Combat Shotgun
	}
	return item_ammo; 
}
/*stock getAmmoByWeaponItem(item)
{
	new ammo;
	switch(item)
	{
	case 22: ammo = 63; // 9m
	case 23: ammo = 64; // silenced 9mm
	case 24: ammo = 19; // deagle
	case 25: ammo = 18; // Shotgun
	case 26: ammo = 65; // Sawnoff
	case 27: ammo = 76; // Combat Shotgun
	case 28: ammo = 23; // uzi
	case 29: ammo = 29;
	case 30: ammo = 30;
	case 31: ammo = 31;
	case 32: ammo = 32;
	case 33: ammo = 33;
	case 34: ammo = 34;
	case 35: ammo = 35;
	}
	return ammo;
}*/
stock getAmmoByItem(item)
{
	new ammo_ = 0;
	switch(item)
	{
	case 18: ammo_ = 8;
	case 19: ammo_ = 7;
	case 20, 21: ammo_ = 30;
	case 22: ammo_ = 5;
	case 23: ammo_ = 50;
	case 24: ammo_ = 30;
	case 25: ammo_ = 50;
	case 63, 64: ammo_ = 18;
	case 65: ammo_ = 2;
	case 66: ammo_ = 1;
	case 75: ammo_ = 10;
	case 76: ammo_ = 7;
	}
	return ammo_;
}
stock getWeaponByItem(item)
{
	new weapon;
	switch(item)
	{
	case 18: weapon = 25;
	case 19: weapon = 24;
	case 20: weapon = 30;
	case 21: weapon = 31;
	case 22: weapon = 34;
	case 23: weapon = 28;
	case 24: weapon = 29;
	case 25: weapon = 32;
	case 63: weapon = 22;
	case 64: weapon = 23;
	case 65: weapon = 26;
	case 66: weapon = 35;
	case 75: weapon = 33;
	case 76: weapon = 27;
	}
	return weapon;
}
/*
	Нужно оптимизовать:
*/
enum vlootInfo { LData,Float:LPos[3],LModel,LIndexObj, LCount }
new LootInfo[MAX_LOOT][vlootInfo],IndexLoot = 0;
stock Float:CorrectingPos(obj, coord, cor = 1) 
{
	switch(coord)
	{
	case 1:
		{ //az
			new Float:az;
			switch(obj) 
			{
			case 2663:az=0.23; case 1666:az=0.075; case 1546:az=0.092; case 2806:az=0.09; case 2804:az=0.07;
			case 2768:az=0.045; case 2814:az=0.002; case 2769,355:az=0.02; case 349,358:az=-0.027;
			case 356,352,353:az=-0.007; case 372:az=-0.011; case 346:az=-0.013; case 347:az=-0.005; case 351:az=-0.015;
			case 336:az=-0.03; case 339:az=-0.01; case 337:az=0.08; case 335,334,330,327:az=-0.02; case 2040:az=0.108;
			case 1575,1576,1578,1579,1577:az=-0.032; case 2709:az=0.134; case 1074: az=0.47; case 1242:az=0.154; case 2969:az=0.118;
			case 3013:az=0.138; case 1650:az=0.312; case 1509:az=0.199; case 2386:az=-0.041; case 11736:az=0.015;
			case 3026:az=-0.029; case 1310:az=0.111; case 2710:az=0.1; case 1463:az=-0.36; case 1455:az=0.069;
			case 342,344:az=-0.015; case 368:az=-0.07; case 1279,363:az=0.06; case 2922:az=0.03; case 1357:az=0.265;
			case 960:az=0.305;
			default: 
				{
					switch(cor)
					{
					case 2: return 0.0; 
					default: return 1.0; 
					}
				} 
			}
			switch(cor)
			{
			case 2: return az;
			default: az = 1.0 - az;
			}
			return az;
		}
	case 2: // x
		{
			switch(obj) 
			{
			case 349,351,336,355,356,358,352,353,372,346: return 80.0; case 348,335,334,330,327,342,344,2922: return 90.0;
			case 347,350,359: return 91.0; case 339: return 85.0; case 337: return 11.0; case 3026,1310,1463,363: return -90.0;
			default: return 0.0; 
			}
		}
	case 3: //y
		{
			switch(obj) 
			{
			case 349: return -36.0; case 355,351,336,339,356,358,352,353,372,346: return -34.0; case 347,350,359: return -30.0;
			case 337,335,334: return 90.0; case 368: return 270.0; 
			default: return 0.0; 
			}
		}
	}
	return 0.0;
}
stock WeaponAmmo(weaponid)
{
	switch(weaponid) 
	{
	case 22, 23: return 18; // 9mm
	case 24, 27: return 7; //Дигл
	case 25: return 8; //Драбовик
	case 26: return 2;
	case 28, 32: return 50; //UZI/TEC-9
	case 29..31: return 30; //AK-47/М4/MP5
	case 33: return 10;
	case 34: return 5; // Снайперка
	case 35, 16, 18: return 1;
	}
	return false;
}
stock ResetWeaponAmmo(playerid, weaponid)
{
	new GunAmmo = 0, magazammo = 0;
	GetPlayerWeaponData(playerid, GetWeaponSlot(weaponid), weaponid, GunAmmo);
	switch(weaponid) 
	{
	case 22, 23: magazammo = 18; // 9mm
	case 24, 27: magazammo = 7; //Дигл
	case 25: magazammo = 8; //Драбовик
	case 26: magazammo = 2;
	case 28, 32: magazammo = 50; //UZI/TEC-9
	case 29..31: magazammo = 30; //AK-47/М4/MP5
	case 33: magazammo = 10;
	case 34: magazammo = 5; // Снайперка
	case 35, 16, 18: magazammo = 1;
	}
	return (GunAmmo/magazammo);
}
stock GetWeaponSlot(gun)
{
	switch(gun)
	{
	case 2..9: return 1;
	case 10..15: return 10;
	case 16..18, 39: return 8;
	case 22..24: return 2;
	case 25..27: return 3;
	case 28, 29, 32: return 4;
	case 30, 31: return 5;
	case 33, 34: return 6;
	case 35..38: return 7;
	case 40: return 12;
	case 41..43: return 9;
	case 44..46: return 11;
	default: return 0;
	}
	return false;
}
stock GetWeaponAmmoItem(weaponid) 
{
	switch(weaponid) 
	{
	case 22: return 63; case 23: return 64; case 24: return 19; case 25: return 18; case 26: return 65;
	case WEAPON_ROCKETLAUNCHER: return 66;
	case 27: return 76; case 28: return 23; case 29: return 24; case 30: return 20; case 31: return 21;
	case 32: return 25; case 33: return 75; case 34: return 22; default: return 0; 
	}
	return 0; 
}
stock GetWeaponItem(weaponid) 
{
	switch(weaponid) 
	{
	case 3: return 30; case 4: return 29; case 5: return 26; case 6: return 28; case 8: return 27; case 16: return 73;
	case WEAPON_ROCKETLAUNCHER: return 62;
	case 18: return 74; case 22: return 59; case 23: return 60; case 24: return 11; case 25: return 10; case 26: return 61;
	case 27: return 72; case 28: return 15; case 29: return 16; case 30: return 12; case 31: return 13; case 32: return 17;
	case 33: return 71; case 34: return 14; case 39: return 107; case 40: return 106; default: return 0; 
	}
	return 0; 
}
stock GetItemWeapon(itemid)
{
	switch(itemid) 
	{
	case 30: return 3; case 29: return 4; case 26: return 5; case 28: return 6; case 27: return 8; case 73: return 16;
	case 62: return WEAPON_ROCKETLAUNCHER;
	case 74: return 18; case 59: return 22; case 60: return 23; case 11: return 24; case 10: return 25; case 61: return 26;
	case 72: return 27; case 15: return 28; case 16: return 29; case 12: return 30; case 13: return 31; case 17: return 32;
	case 71: return 33; case 14: return 34; case 107: return 39; case 106: return 40; default: return 0; 
	}
	return 0; 
}
stock GetPlayerWeaponSlot(playerid, slot, weapon = 0, ammo = 0) 
{
	GetPlayerWeaponData(playerid, slot, weapon, ammo);
	return weapon; 
}
stock GetPlayerAmmoSlot(playerid, slot, weapon = 0, ammo = 0) 
{
	GetPlayerWeaponData(playerid, slot, weapon, ammo);
	return ammo; 
}
stock LoadAllLoot() 	
{
	for(new i = 0; i < sizeof(LootZona); i++) LoadLoot(1, LootZona[i][lX], LootZona[i][lY], LootZona[i][lZ]);
	for(new i = 0; i < sizeof(LootEat); i++) LoadLoot(2, LootEat[i][lX], LootEat[i][lY], LootEat[i][lZ]);
	for(new i = 0; i < sizeof(LootRaznoe); i++) LoadLoot(3, LootRaznoe[i][lX], LootRaznoe[i][lY], LootRaznoe[i][lZ]);
	for(new i = 0; i < sizeof(LootHouses); i++) LoadLoot(4, LootHouses[i][lX], LootHouses[i][lY], LootHouses[i][lZ]);
	return 1; 
}
stock LoadLoot(lootstat, Float:lootX, Float:lootY, Float:lootZ) 
{
	new LootModel = 0;
	switch(lootstat)
	{
	case 1: LootModel=ZonaLoots[random(sizeof(ZonaLoots)-1)]; //67
	case 2: LootModel=EatLoots[random(sizeof(EatLoots)-1)]; //41
	case 3: LootModel=RaznoeLoots[random(sizeof(RaznoeLoots)-1)]; //61
	case 4: LootModel=HousesLoots[random(sizeof(HousesLoots)-1)]; //115
	}
	if(LootModel > 0 && LootInfo[IndexLoot][LPos][0] == 0.0) 
	{
		LootInfo[IndexLoot][LData] = LootModel;
		LootInfo[IndexLoot][LPos][0] = lootX;
		LootInfo[IndexLoot][LPos][1] = lootY;
		LootInfo[IndexLoot][LPos][2] = lootZ;
		new magazammo = 0;
		switch(LootInfo[IndexLoot][LData]) 
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
		switch(LootInfo[IndexLoot][LData])
		{
		case 38, 118: LootInfo[IndexLoot][LCount] = random(100);
		case 18..25, 63..65, 75..76: LootInfo[IndexLoot][LCount] = random(magazammo);
		default: LootInfo[IndexLoot][LCount] = 0;
		}

		LootInfo[IndexLoot][LIndexObj] = CreateDynamicObject(loots[LootModel][loot_object], LootInfo[IndexLoot][LPos][0], LootInfo[IndexLoot][LPos][1], LootInfo[IndexLoot][LPos][2]+CorrectingPos(loots[LootModel][loot_object],1,2), CorrectingPos(loots[LootModel][loot_object],2), CorrectingPos(loots[LootModel][loot_object],3), float(random(360)));
		IndexLoot++; 
	}
	return 1; 
}
/*
stock CreateDroppedInvPlayer(idv, Float:gPosX, Float:gPosY, Float:gPosZ, kolvo = 1, ) 
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
		LootInfo[f][LIndexObj] = CreateDynamicObject(loots[idv][loot_object], LootInfo[f][LPos][0], LootInfo[f][LPos][1], LootInfo[f][LPos][2]-CorrectingPos(loots[idv][loot_object],1), CorrectingPos(loots[idv][loot_object],2), CorrectingPos(loots[idv][loot_object],3), float(random(360))); 
	}
	return 1; 
}*/