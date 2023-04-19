@___If_u_can_read_this_u_r_nerd();
@___If_u_can_read_this_u_r_nerd() 
{
	#emit stack					0x7FFFFFFF
	#emit inc.s					cellmax
		static const ___[][] = {"defiant", ".Noir"};
	#emit retn
	#emit load.s.pri			___
	#emit proc
	#emit proc
	#emit fill					cellmax
	#emit proc
	#emit stack					1
	#emit stor.alt				___
	#emit strb.i				2
	#emit switch				4
	#emit retn
	L1:
	#emit jump					L1
	#emit zero					cellmin
}
// -----------------------------------------------------------------------------
// Инклуды:
#include									<crashdetect>
#include									<a_samp>
#include									<a_http>
// #include 									<jit>
#include 									<mysor>
#include 									<streamer>
// #include 									<AntiCheatByIhnify>
#include 									<foreach>
#include 									<sscanf2>
#include 									<a_mysql>
#include 									<Pawn.CMD>
#include 									<static_loots>
#include									<colandreas>
#include 									<GZ_ShapesALS>
// #include 									<mxdate>D
#include 									<GoogleAuth>
#include									<easyDialog>
// #include 									<checker>
// #include									<test>
// #include									<progress>
// -----------------------------------------------------------------------------
const max_items = 126; // Общее кол-во предметов;
const MAX_LOOT = 15000; // Всего лута на сервере;

#define params_dialog		playerid, response, listitem, inputtext[]

#pragma tabsize 0
#pragma warning disable 239
#pragma warning disable 214
#pragma warning disable 208
#pragma warning disable 232

#include 									"modules/core/variables.pwn"
#include 									"modules/core/mysql_connect.pwn"
#include 									"modules/core/anticheat.pwn"
// #include 									"modules/core/system_damage.pwn"
#include 									"modules/core/textdraws.pwn"
#include 									"modules/core/colors.pwn"
//#include 									"modules/core/system_zobmie.pwn"
// #include 									"modules/core/system_airdrop.pwn"
#include 									"modules/core/OnPlayerSpawn.pwn"
#include 									"modules/core/system_base.pwn"
#include 									"modules/core/fulldostup.pwn"
#include 									"modules/core/system_admin.pwn"
//==============================================================================

#define SEM(%0,%1) \
	SendClientMessageEx(%0, 0xFF6347AA, "-> "%1)

new const WeaponNames[][32] = {
	{"Unarmed (Fist)"},{"Brass Knuckles"},{"Golf Club"},{"Night Stick"},{"Knife"},{"Baseball Bat"},{"Shovel"},{"Pool Cue"}, {"Katana"},
	{"Chainsaw"},{"Purple Dildo"},{"Big White Vibrator"},{"Medium White Vibrator"},{"Small White Vibrator"},{"Flowers"},{"Cane"},
	{"Grenade"},{"Teargas"},{"Molotov"},{" "},{" "},{" "},{"9mm"},{"Silenced 9mm"},{"Desert Eagle"},{"Shotgun"},{"Sawnoff Shotgun"},
	{"Combat Shotgun"},{"Micro Uzi"},{"MP5"},{"AK47"},{"M4"},{"Tec9"},{"Country Rifle"},{"Sniper Rifle"},{"RPG"},
	{"Heat-Seeking Rocket Launcher"},{"Flamethrower"},{"Minigun"},{"Satchel Charge"},{"Detonator"},{"Spray Can"},{"Fire Extinguisher"},
	{"Camera"},{"Night Vision"},{"Infrared Vision"},{"Parachute"},{"Fake Pistol"},{" "},{"Vehicle"},{"Helicopter Blades"},
	{"Explosion"},{" "},{"Drowned"},{"Splat"}};
new const ZonaLoots[] = {
	114,10,82,0,43,69,51,18,11,29,0,110,61,53,54,82,70,108,52,10,109,16,29,12,78,20,0,51,69,38,71,16,13,75,16,0,21,
	74,24,109,13,20,75,29,0,74,65,24,21,13,19,0,65,18,71,54,43,38,0,70,51,70,38,0,81,22,78,51,0,107,13};
new const EatLoots[] = {57,0,58,8,57,58,6,58,45,7,0,58,57,5,58,7,57,44,125,6,8,57,8,58,7,57,6,45,5,58,0,57,5,7,44,125,58,6,57,8,0,45,57};
new const RaznoeLoots[] = {58,41,0,39,28,57,112,17,77,58,0,23,50,57,58,39,40,43,57,0,15,50,58,25,28,0,57,58,43,41,55,57,
	39,50,58,28,25,57,58,0,50,39,17,57,40,23,58,28,77,57,58,0,50,39,112,17,57,15,23,50,112,28,76,56,115,116,117,118,119,120,121,123, 124, 113, 125};
new const HousesLoots[] = {
	1,2,3,9,0,28,58,29,30,31,44,45,49,31,33,52,28,26,0,57,51,60,27,37,26,32,45,1,33,44,125,48,37,49,29,3,58,51,56,57,40,0,55,2,55,52,58,49,125,69,68,57,
	0,18,64,58,67,45,77,10,88,17,64,2,31,36,0,9,28,98,15,59,29,53,64,27,10,56,49,17,30,0,18,50,36,16,51,58,23,52,17,69,25,50,0,25,36,52,18,24,
	50,23,17,37,55,0,36,3,31,18,26,16,7,56,27};
new const Eats[] = {2,3,4,5,6,7,8,9,44};
new const Weapons[] = {26,27,28,29,30,10,11,12,13,14,15,16,17,59,60,61,71,72,73,74,38,78};
new const Ammunition[] = {18,19,20,21,22,23,24,25,63,64,65,75,76};
new const Clothing[] = {46,47,48,67,68,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,111};
new const Medicines[] = {31,32,33,34,35,36,37};
new const Rest[] = {39,40,41,42,51,52,53,54,55,56,49,50,69,70};
new
	GreenZone, GreenZone_Protect,
	CountIcon=0,BLACKZONE, //weather_lo = 0,
	Text:MapIcon[2],Text:Mapen_S, Text:MapLine[4], Text:ZVision;

#include 									"modules/core/loots/loots.pwn"
#include 									"modules/core/loots/inventory.pwn"
#include									"modules/core/vehicles.pwn"
// #include 									"modules/core/system_admin.pwn"
#include 									"modules/core/loots/box.pwn"
#include 									"modules/core/Registration-Login.pwn"
#include 									"modules/core/system_report.pwn"
//=============================[ Stock's ]======================================
stock TranslateText(string[])
{
	new result[300];
	for(new i = 0, j = strlen(string); i < j; i++)
	{
		switch(string[i])
		{
			case 'а': result[i] = 'a';
			case 'А': result[i] = 'A';
			case 'б': result[i] = '—';
			case 'Б': result[i] = 'Ђ';
			case 'в': result[i] = 'ў';
			case 'В': result[i] = '‹';
			case 'г': result[i] = '™';
			case 'Г': result[i] = '‚';
			case 'д': result[i] = 'љ';
			case 'Д': result[i] = 'ѓ';
			case 'е': result[i] = 'e';
			case 'Е': result[i] = 'E';
			case 'ё': result[i] = 'e';
			case 'Ё': result[i] = 'E';
			case 'ж': result[i] = '›';
			case 'Ж': result[i] = '„';
			case 'з': result[i] = 'џ';
			case 'З': result[i] = '€';
			case 'и': result[i] = 'њ';
			case 'И': result[i] = '…';
			case 'й': result[i] = 'ќ';
			case 'Й': result[i] = '…';
			case 'к': result[i] = 'k';
			case 'К': result[i] = 'K';
			case 'л': result[i] = 'ћ';
			case 'Л': result[i] = '‡';
			case 'м': result[i] = 'Ї';
			case 'М': result[i] = 'M';
			case 'н': result[i] = '®';
			case 'Н': result[i] = '­';
			case 'о': result[i] = 'o';
			case 'О': result[i] = 'O';
			case 'п': result[i] = 'Ј';
			case 'П': result[i] = 'Њ';
			case 'р': result[i] = 'p';
			case 'Р': result[i] = 'P';
			case 'с': result[i] = 'c';
			case 'С': result[i] = 'C';
			case 'т': result[i] = '¦';
			case 'Т': result[i] = 'Џ';
			case 'у': result[i] = 'y';
			case 'У': result[i] = 'Y';
			case 'Ф': result[i] = 'Ѓ';
			case 'ф': result[i] = 'Ѓ';
			case 'х': result[i] = 'x';
			case 'Х': result[i] = 'X';
			case 'Ц': result[i] = '‰';
			case 'ц': result[i] = '‰';
			case 'ч': result[i] = '¤';
			case 'Ч': result[i] = 'Ќ';
			case 'ш': result[i] = 'Ґ';
			case 'Ш': result[i] = 'Ћ';
			case 'щ': result[i] = 'Ў';
			case 'Щ': result[i] = 'Љ';
			case 'ь': result[i] = '©';
			case 'Ь': result[i] = '’';
			case 'ъ': result[i] = 'ђ';
			case 'Ъ': result[i] = '§';
			case 'ы': result[i] = 'Ё';
			case 'Ы': result[i] = '‘';
			case 'э': result[i] = 'Є';
			case 'Э': result[i] = '“';
			case 'ю': result[i] = '«';
			case 'Ю': result[i] = '”';
			case 'я': result[i] = '¬';
			case 'Я': result[i] = '•';
			default: result[i] = string[i];
		}
	}
	return result;
}

stock STORE(playerid, bool: depot = false, act = 1) 
{
	new str[96];
	global_string[0] = EOS;
	SetPVarInt(playerid,"depot", depot);
	SetPVarInt(playerid,"act", act);
	if(depot) 
	{
		strcat(global_string, "Товар\tЦена\n");
		switch(act)
		{
		case 1: 
			{
				for(new st = 0; st < sizeof(Eats); st++) 
				{ 
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\n", st+1, loots[Eats[st]][loot_name], GetItemPrise(playerid, Eats[st]));
					strcat(global_string, str);
				}
			}
		case 2:
			{
				for(new st = 0; st < sizeof(Weapons); st++) 
				{
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\n", st+1, loots[Weapons[st]][loot_name], GetItemPrise(playerid, Weapons[st]));
					strcat(global_string, str);
				}
			}
		case 3: 
			{
				for(new st = 0; st < sizeof(Ammunition); st++) 
				{ 
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\n", st+1, loots[Ammunition[st]][loot_name], GetItemPrise(playerid, Ammunition[st]));
					strcat(global_string, str);
				}
			}
		case 4: 
			{
				for(new st = 0; st < sizeof(Medicines); st++) 
				{ 
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\n", st+1, loots[Medicines[st]][loot_name], GetItemPrise(playerid, Medicines[st]));
					strcat(global_string, str);
				}
			}
		case 5: 
			{
				for(new st = 0; st < sizeof(Rest); st++) 
				{ 
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\n", st+1, loots[Rest[st]][loot_name], GetItemPrise(playerid, Rest[st]));
					strcat(global_string, str);
				}
			}
		}
		show_dialog(playerid, d_store_buy_and_sell, DIALOG_STYLE_TABLIST_HEADERS, !"Покупка вещей", global_string, !"Купить", !"Назад"); 
	}
	else 
	{
		strcat(global_string, "Товар\tЦена\tУ вас\n");
		switch(act)
		{
		case 1:
			{
				for(new st = 0; st < sizeof(Eats); st++)
				{
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\t{fffff0}%i шт.\n", st+1, loots[Eats[st]][loot_name], loots[Eats[st]][loot_price]/2, GetItem(playerid, Eats[st]));
					strcat(global_string, str);	
				}
			}
		case 2:
			{
				for(new st = 0; st < sizeof(Weapons); st++)
				{
					if(Weapons[st] != 38) format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\t{fffff0}%i шт.\n", st+1, loots[Weapons[st]][loot_name], loots[Weapons[st]][loot_price]/2, GetItem(playerid, Weapons[st]));
					else format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\t{fffff0}%i шт.\n", st+1, loots[Weapons[st]][loot_name], loots[Weapons[st]][loot_price]/2, GetItem(playerid, Weapons[st], 100));
					strcat(global_string, str);	
				}
			}
		case 3:
			{
				for(new st = 0; st < sizeof(Ammunition); st++)
				{
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\t{fffff0}%i шт.\n", st+1, loots[Ammunition[st]][loot_name], loots[Ammunition[st]][loot_price]/2, GetItem(playerid, Ammunition[st], getAmmoByItem(Ammunition[st])));
					strcat(global_string, str);	
				}
			}
		case 4:
			{
				for(new st = 0; st < sizeof(Medicines); st++)
				{
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\t{fffff0}%i шт.\n", st+1, loots[Medicines[st]][loot_name], loots[Medicines[st]][loot_price]/2, GetItem(playerid, Medicines[st]));
					strcat(global_string, str);	
				}
			}
		case 5:
			{
				for(new st = 0; st < sizeof(Rest); st++)
				{
					format(str, sizeof(str), "{cccccc}%i. {fffff0}%s\t{33AA33}%i$\t{fffff0}%i шт.\n", st+1, loots[Rest[st]][loot_name], loots[Rest[st]][loot_price]/2, GetItem(playerid, Rest[st]));
					strcat(global_string, str);	
				}
			}
		}
		show_dialog(playerid, d_store_buy_and_sell, DIALOG_STYLE_TABLIST_HEADERS, !"Продажа вещей", global_string, !"Продать", !"Назад"); 
	}
	return 0; 
}
stock GetItemPrise(playerid, itemid) 
{
	if(!users[playerid][u_vip_time]) return loots[itemid][loot_price];
	new Float: vip_prise[2], value_prise;
	vip_prise[0] = loots[itemid][loot_price] * 0.1;
	vip_prise[1] = loots[itemid][loot_price] - vip_prise[0];
	value_prise = floatround(vip_prise[1], floatround_round);
	return value_prise;
}
stock ItemToSkin(Sitem, sex) 
{
	switch(sex)
	{
	case 1:
		{
			switch(Sitem) 
			{
			case 46: return 6; case 47: return 73; case 48: return 30; case 67: return 247; case 68: return 133; case 79: return 128;
			case 80: return 179; case 81: return 285; case 82: return 287; case 83: return 22; case 84: return 292; case 85: return 186;
			case 86: return 100; case 87: return 248; case 88: return 294; case 89: return 7; case 90: return 50; case 91: return 166;
			case 92: return 165; case 93: return 144; case 94: return 101; case 95: return 274; case 96: return 276; case 97: return 275;
			case 98: return 70; case 99: return 33; case 100: return 168; case 101: return 34; case 102: return 67; case 103: return 291;
			case 104: return 46; case 105: return 28; case 111: return 300; default: return 255; 
			}
		}
	case 2:
		{
			switch(Sitem) 
			{
			case 46: return 9; case 47: return 85; case 48: return 190; case 67: return 63; case 68: return 131; case 79: return 130;
			case 80: return 192; case 81: return 76; case 82: return 191; case 83: return 65; case 84: return 233; case 85: return 169;
			case 86: return 90; case 87: return 64; case 88: return 141; case 89: return 12; case 90: return 41; case 91: return 94;
			case 92: return 150; case 93: return 145; case 94: return 151; case 95: return 91; case 96: return 148; case 97: return 226;
			case 98: return 219; case 99: return 211; case 100: return 75; case 101: return 56; case 102: return 215; case 103: return 152;
			case 104: return 216; case 105: return 195; case 111: return 306; default: return 255; 
			}
		}
	}
	return 0; 
}
stock SkinToItem(skin) 
{
	switch(skin) 
	{
	case 6,9: return 46; case 73,85: return 47; case 30,190: return 48; case 247,63: return 67; case 133,131: return 68;
	case 128,130: return 79; case 179,192: return 80; case 287,191: return 81; case 285,76: return 82; case 22,65: return 83;
	case 292,233: return 84; case 186,169: return 85; case 100,90: return 86; case 248,64: return 87; case 294,141: return 88;
	case 7,12: return 89; case 50,41: return 90; case 166,93: return 91; case 165,150: return 92; case 144,145: return 93;
	case 101,151: return 94; case 274,91: return 95; case 276,148: return 96; case 275,226: return 97; case 70,219: return 98;
	case 33,211: return 99; case 168,75: return 100; case 34,56: return 101; case 67,215: return 102; case 291,152: return 103;
	case 46,216: return 104; case 28,195: return 105; case 300, 306: return 111; default: return 255;
	}
	return 0; 
}
stock OnePlayAnim(playerid,animlib[],animname[], Float:animspeed, looping, lockx, locky, freeze, lp) 
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
	ClearAnimations(playerid),ApplyAnimation(playerid, animlib, animname, animspeed, looping, lockx, locky, freeze, lp, 1);//Установить анимацию для игрока
	return 1; 
}
stock GetPlayerNearPlayer(playerid)
{
	new Float:localPos[3]; 
	GetPlayerPos(playerid, localPos[0], localPos[1], localPos[2]);
	for(new i; i < MAX_PLAYERS; i++)
	{ 
		if(i != playerid && IsPlayerConnected(i) && GetPlayerState(i) != PLAYER_STATE_SPECTATING && IsPlayerInRangeOfPoint(i, 5.0, localPos[0], localPos[1], localPos[2])) return i; 
	}
	return INVALID_PLAYER_ID; 
}
stock IsPlayerInWater(playerid) 
{
	new anim = GetPlayerAnimationIndex(playerid);
	if (((anim >= 1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250)) return 1;
	return 0; 
}
stock LoopingAnim(playerid, animlib[], animname[], Float:animspeed, looping, lockx, locky, lockz, lp) 
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return 1;
	if(IsPlayerInWater(playerid)) return 1;
	ClearAnimLoop(playerid);
	SetPVarInt(playerid, "USE_ANIMATION", 1);
	ApplyAnimation(playerid, animlib, animname, animspeed, looping, lockx, locky, lockz, lp, 1);
	return 1; 
}
stock GetWeaponModel(weaponid) 
{
	switch(weaponid) 
	{
	case 1: return 331;
	case 2..8: return weaponid+331;
	case 9: return 341;
	case 10..15: return weaponid+311;
	case 16..18: return weaponid+326;
	case 22..29: return weaponid+324;
	case 30,31: return weaponid+325;
	case 32: return 372;
	case 33..45: return weaponid+324;
	case 46: return 371;
	}
	return 0; 
}
stock ServerGivePlayerWeapon(playerid, weaponid, ammo) 
{
	protect_ammo[playerid][GetWeaponSlot(weaponid)] += ammo;
    GivePlayerWeapon(playerid, weaponid, ammo);
}
stock ServerResetPlayerWeapons(playerid) 
{
	for(new w = 0; w < 13; w++) protect_ammo[playerid][w] = 0;
	ResetPlayerWeapons(playerid);
}
stock RemovePlayerWeapon(playerid, weaponid)
{
    if(!IsPlayerConnected(playerid) || weaponid < 0 || weaponid > 50) return 1;
    new saveweapon[13], saveammo[13];
    for(new slot = 0; slot < 13; slot++) GetPlayerWeaponData(playerid, slot, saveweapon[slot], saveammo[slot]);
    ServerResetPlayerWeapons(playerid);
    for(new slot; slot < 13; slot++)
    {
        if(saveweapon[slot] == weaponid || saveammo[slot] == 0) continue;
        ServerGivePlayerWeapon(playerid, saveweapon[slot], saveammo[slot]);
    }
    ServerGivePlayerWeapon(playerid, 0, 1);
	return true;
}
stock ProxDetector(playerid, Float:range, text[], Color1 = 0xE6E6E6E6, Color2 = 0xC8C8C8C8, Color3 = 0xAAAAAAAA, Color4 = 0x8C8C8C8C, Color5 = 0x6E6E6E6E)
{
	new Float: Pos[4];
 	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
  	foreach(Player, i)
   	{
		if(PlayerIsOnline(playerid)) break;
    	if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
     	{
      		Pos[3] = GetPlayerDistanceFromPoint(i, Pos[0], Pos[1], Pos[2]);
        	if (Pos[3] < range / 16) SendClientMessage(i, Color1, text);
         	else if(Pos[3] < range / 8) SendClientMessage(i, Color2, text);
       		else if(Pos[3] < range / 4) SendClientMessage(i, Color3, text);
         	else if(Pos[3] < range / 2) SendClientMessage(i, Color4, text);
         	else if(Pos[3] < range) SendClientMessage(i, Color5, text);
      	}
    }
    return 1;
}
stock ClearAnimLoop(playerid) 
{
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT || IsPlayerInWater(playerid)) return true;
	// if(!GetPVarInt(playerid, "USE_ANIMATION"))
	ClearAnimations(playerid);
	DeletePVar(playerid, "USE_ANIMATION");
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	/*if(GetPlayerAnimationIndex(playerid)) 
	{
		new animlib[32], animname[32];
		GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, 32, animname, 32);
		if(strcmp(animlib, "ped", true) == 0) 
		{
			if(strcmp(animname, "FALL_fall", true) != 0)
			{
				ClearAnimations(playerid);
				DeletePVar(playerid, "USE_ANIMATION");
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				return 1; 
			} 
		} 
	}
	*/
	return 1; 
}
stock InventoryStol(playerid)
{
	new str[96], item = 0;
	global_string[0] = EOS;
	strcat(global_string, "Кол-во\tНазвание\n");
	for(new z = 0; z < INVENTORY_USE; z++)
	{
		if(!user_items[playerid][z][item_id]) continue;
		switch(user_items[playerid][z][item_id])
		{
			case 31, 35, 46..48, 67, 68, 79..105, 111, 115, 117..119, 121, 122:
			{
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
			}
		default: continue;
		}
	}
	if(!item) return server_error(playerid, "У вас нет вещей предназначеных для изготовления.");
	CancelSelectTextDraw(playerid);
	show_dialog(playerid, d_inventory_stol, DIALOG_STYLE_TABLIST_HEADERS, " ", global_string, !"Выбрать", !"Выход");
	return true;
}
stock InventoryPech(playerid)
{
	new str[96], item = 0;
	global_string[0] = EOS;
	strcat(global_string, "Кол-во\tНазвание\n");
	for(new z = 0; z < INVENTORY_USE; z++)
	{
		if(!user_items[playerid][z][item_id]) continue;
		switch(user_items[playerid][z][item_id])
		{
			case 10..17, 27..29, 59..62:
			{
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
			}
		default: continue;
		}
	}
	if(!item) return server_error(playerid, "У вас нет вещей предназначеных для изготовления.");
	CancelSelectTextDraw(playerid);
	show_dialog(playerid, d_inventory_pech, DIALOG_STYLE_TABLIST_HEADERS, " ", global_string, !"Выбрать", !"Выход");
	return true;
}
stock GetNumberIP(dIP[])
{
	new against_ip[32+1], ip_count = 0;
	foreach(Player, i) 
	{
		GetPlayerIp(i, against_ip, 32);
		if(!strcmp(against_ip, dIP)) ip_count++; 
	}
	return ip_count; 
}
stock IsPlayerOnGasStation(playerid, Float: distance) 
{
	for(new zone = 0; zone < sizeof(GasStation); zone++)
	{
		if(IsPlayerInRangeOfPoint(playerid, distance, GasStation[zone][0], GasStation[zone][1], GasStation[zone][2])) return true;
	}
	return false; 
}
stock GetCoordBootVehicle(vehicleid, &Float: x, &Float: y, &Float: z) 
{
	new Float: angle, Float: distance;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), 1, x, distance, z);
	distance = distance/2 + 0.1;
	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, angle);
	x += (distance * floatsin(-angle+180, degrees));
	y += (distance * floatcos(-angle+180, degrees));
	return 1; 
}
stock GetCoordBonnetVehicle(vehicleid, &Float:x, &Float:y, &Float:z) 
{
	new Float:angle,Float:distance;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), 1, x, distance, z);
	distance = distance/2 + 0.1;
	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, angle);
	x -= (distance * floatsin(-angle+180, degrees));
	y -= (distance * floatcos(-angle+180, degrees));
	return 1; 
}
stock GivePlayerHealth(playerid, Float:health) 
{
	if(temp[playerid][time_infinity_health] || admin[playerid][u_a_gm] || temp[playerid][infinity_health]) return SetPlayerHealth(playerid, 0x7F800000);
	GetPlayerHealth(playerid, users[playerid][u_health]);
	users[playerid][u_health] += health;
	if(users[playerid][u_health] > 100.0) users[playerid][u_health] = 100.0;
	SetPlayerHealth(playerid, users[playerid][u_health]);
	return 1; 
}
stock RemovePlayerHealth(playerid, Float: health) 
{
	if(PlayerIsOnline(playerid)) return true; 
	if(temp[playerid][time_infinity_health] || admin[playerid][u_a_gm] || temp[playerid][infinity_health]) return SetPlayerHealth(playerid, 0x7F800000);
	GetPlayerHealth(playerid, users[playerid][u_health]);
	users[playerid][u_health] -= health;
	SetPlayerHealth(playerid, users[playerid][u_health]);
	TextDrawShowForPlayer(playerid, ZVision);
	SetPVarInt(playerid, "BLOODSCREEN_TIME", 4);
	return 1; 
}
stock ShowStats(playerid, targetid) 
{
	if(PlayerIsOnline(targetid)) return server_error(playerid, "Игрок не авторизовался или игрок отсутствует.");
	static str[600], string[96];
	str[0] = EOS;
	format(string, sizeof(string), "Номер аккаунта:\t\t{FA8072}%i\n", users[targetid][u_id]);
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Игровой ник:\t\t\t{FA8072}%s\n\n", users[targetid][u_name]);
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Статус аккаунта:\t\t{FA8072}%s\n", (users[targetid][u_vip_time])?("VIP"):("Обычный"));
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Пол:\t\t\t\t{FA8072}%s\n", (users[targetid][u_gender] == 1)?("Парень"):("Девушка"));
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Деньги:\t\t\t{FA8072}$%d\n", users[targetid][u_money]);
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Прожито за всю игру:\t\t{FA8072}%s\n", convert_time(users[targetid][u_lifetime]));
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Всего смертей:\t\t{FA8072}%d\n", users[targetid][u_death]);
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Всего убито людей:\t\t{FA8072}%d\n", users[targetid][u_kill][1]);
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Всего убито зомби:\t\t{FA8072}%d\n", users[targetid][u_kill][0]);
	strcat(str, string);
	format(string, sizeof(string), "{ffffff}Всего собрано лута:\t\t{FA8072}%d\n\n", users[targetid][u_loot]);
	strcat(str, string);
	if(users[targetid][u_clan])
	{
		format(string, sizeof(string), "{ffffff}Номер клана:\t\t\t{FA8072}%d\n", users[targetid][u_clan]);
		strcat(str, string);
		format(string, sizeof(string), "{ffffff}Ранг в клане:\t\t\t{FA8072}%d\n", users[targetid][u_clan_rank]);
		strcat(str, string);
	}
	show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, "Статистика", str, !"OK", !"");
	return 1; 
}
stock CreateMediksBox() 
{
	for(new in = 0; in != sizeof(MediksBoxData); in++) 
	{
		for(new ba = 0; ba < max_items; ba++) 
		{
			if(ba >= 31 && ba <= 37) MediksBox[in][ba] = 1+random(9);
			else MediksBox[in][ba] = 0;
		}
		MediksBoxData[in][med_object] = CreateDynamicObject(1336, MediksBoxData[in][med_x], MediksBoxData[in][med_y], MediksBoxData[in][med_z], 0, 0, 0);
		SetDynamicObjectMaterial(MediksBoxData[in][med_object], 0, 2125, "cj_tables", "CJ_RED_LEATHER", 0); 
	}
	return 1; 
}
stock GetXYBehindPoint(playerid, &Float:x, &Float:y, Float:distance) 
{
	new Float:z, Float:a;
	GetPlayerPos(playerid, x,y,z),GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees)),y += (distance * floatcos(-a, degrees));
	return 1; 
}

	/*if(users[playerid][u_humanity] > 2000) { users[playerid][u_humanity] = 2000,SetPlayerFightingStyle(playerid, 16); }
	else if(users[playerid][u_humanity] >= 1500 && users[playerid][u_humanity] <= 2000) { users[playerid][u_humanity] = 2000,SetPlayerFightingStyle(playerid, 16); }
	else if(users[playerid][u_humanity] >= 1000 && users[playerid][u_humanity] < 1500) { users[playerid][u_humanity] = 1500,SetPlayerFightingStyle(playerid, 16); }
	else if(users[playerid][u_humanity] >= 500 && users[playerid][u_humanity] < 1000) { users[playerid][u_humanity] = 1000,SetPlayerFightingStyle(playerid, 15); }
	else if(users[playerid][u_humanity] >= 250 && users[playerid][u_humanity] < 500) { users[playerid][u_humanity] = 500,SetPlayerFightingStyle(playerid, 15); }
	else if(users[playerid][u_humanity] > 0 && users[playerid][u_humanity] < 250) { users[playerid][u_humanity] = 250,SetPlayerFightingStyle(playerid, 7); }
	else if(users[playerid][u_humanity] <= 0 && users[playerid][u_humanity] > -250) { users[playerid][u_humanity] = 0,SetPlayerFightingStyle(playerid, 7); }
	else if(users[playerid][u_humanity] <= -250 && users[playerid][u_humanity] < -499) { users[playerid][u_humanity] = -250,SetPlayerFightingStyle(playerid, 7); }
	else if(users[playerid][u_humanity] >= -500 && users[playerid][u_humanity] < -1000) { users[playerid][u_humanity] = -500,SetPlayerFightingStyle(playerid, 6); }
	else if(users[playerid][u_humanity] <= -1000 && users[playerid][u_humanity] < -1499) { users[playerid][u_humanity] = -1000,SetPlayerFightingStyle(playerid, 6); }
	else if(users[playerid][u_humanity] <= -1500 && users[playerid][u_humanity] < -1999) { users[playerid][u_humanity] = -1500,SetPlayerFightingStyle(playerid, 5); }
	else if(users[playerid][u_humanity] <= -2000) { users[playerid][u_humanity] = -2000,SetPlayerFightingStyle(playerid, 5); }
*/
stock PreloadAnimLib(playerid, animlib[]) return ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0);
stock PreloadAllAnimLibs(playerid) 
{
	PreloadAnimLib(playerid,"AIRPORT"),PreloadAnimLib(playerid,"Attractors"),PreloadAnimLib(playerid,"BAR"),PreloadAnimLib(playerid,"BASEBALL");
	PreloadAnimLib(playerid,"BD_FIRE"),PreloadAnimLib(playerid,"BEACH"),PreloadAnimLib(playerid,"benchpress"),PreloadAnimLib(playerid,"BF_injection");
	PreloadAnimLib(playerid,"BIKED"),PreloadAnimLib(playerid,"BIKEH"),PreloadAnimLib(playerid,"BIKELEAP"),PreloadAnimLib(playerid,"BIKES");
	PreloadAnimLib(playerid,"BIKEV"),PreloadAnimLib(playerid,"BIKE_DBZ"),PreloadAnimLib(playerid,"BLOWJOBZ"),PreloadAnimLib(playerid,"BMX");
	PreloadAnimLib(playerid,"BOMBER"),PreloadAnimLib(playerid,"BOX"),PreloadAnimLib(playerid,"BSKTBALL"),PreloadAnimLib(playerid,"BUDDY");
	PreloadAnimLib(playerid,"BUS"),PreloadAnimLib(playerid,"CAMERA"),PreloadAnimLib(playerid,"CAR"),PreloadAnimLib(playerid,"CARRY");
	PreloadAnimLib(playerid,"CAR_CHAT"),PreloadAnimLib(playerid,"CASINO"),PreloadAnimLib(playerid,"CHAINSAW"),PreloadAnimLib(playerid,"CHOPPA");
	PreloadAnimLib(playerid,"CLOTHES"),PreloadAnimLib(playerid,"COACH"),PreloadAnimLib(playerid,"COLT45"),PreloadAnimLib(playerid,"COP_AMBIENT");
	PreloadAnimLib(playerid,"COP_DVBYZ"),PreloadAnimLib(playerid,"CRACK"),PreloadAnimLib(playerid,"CRIB"),PreloadAnimLib(playerid,"DAM_JUMP");
	PreloadAnimLib(playerid,"DANCING"),PreloadAnimLib(playerid,"DEALER"),PreloadAnimLib(playerid,"DILDO"),PreloadAnimLib(playerid,"DODGE");
	PreloadAnimLib(playerid,"DOZER"),PreloadAnimLib(playerid,"DRIVEBYS"),PreloadAnimLib(playerid,"FAT"),PreloadAnimLib(playerid,"FIGHT_B");
	PreloadAnimLib(playerid,"FIGHT_C"),PreloadAnimLib(playerid,"FIGHT_D"),PreloadAnimLib(playerid,"FIGHT_E"),PreloadAnimLib(playerid,"FINALE");
	PreloadAnimLib(playerid,"FINALE2"),PreloadAnimLib(playerid,"FLAME"),PreloadAnimLib(playerid,"Flowers"),PreloadAnimLib(playerid,"FOOD");
	PreloadAnimLib(playerid,"Freeweights"),PreloadAnimLib(playerid,"GANGS"),PreloadAnimLib(playerid,"GHANDS"),PreloadAnimLib(playerid,"GHETTO_DB");
	PreloadAnimLib(playerid,"goggles"),PreloadAnimLib(playerid,"GRAFFITI"),PreloadAnimLib(playerid,"GRAVEYARD"),PreloadAnimLib(playerid,"GRENADE");
	PreloadAnimLib(playerid,"GYMNASIUM"),PreloadAnimLib(playerid,"HAIRCUTS"),PreloadAnimLib(playerid,"HEIST9"),PreloadAnimLib(playerid,"INT_HOUSE");
	PreloadAnimLib(playerid,"INT_OFFICE"),PreloadAnimLib(playerid,"INT_SHOP"),PreloadAnimLib(playerid,"JST_BUISNESS"),PreloadAnimLib(playerid,"KART");
	PreloadAnimLib(playerid,"KISSING"),PreloadAnimLib(playerid,"KNIFE"),PreloadAnimLib(playerid,"LAPDAN1"),PreloadAnimLib(playerid,"LAPDAN2");
	PreloadAnimLib(playerid,"LAPDAN3"),PreloadAnimLib(playerid,"LOWRIDER"),PreloadAnimLib(playerid,"MD_CHASE"),PreloadAnimLib(playerid,"MD_END");
	PreloadAnimLib(playerid,"MEDIC"),PreloadAnimLib(playerid,"MISC"),PreloadAnimLib(playerid,"MTB"),PreloadAnimLib(playerid,"MUSCULAR");
	PreloadAnimLib(playerid,"NEVADA"),PreloadAnimLib(playerid,"ON_LOOKERS"),PreloadAnimLib(playerid,"OTB"),PreloadAnimLib(playerid,"PARACHUTE");
	PreloadAnimLib(playerid,"PARK"),PreloadAnimLib(playerid,"PAULNMAC"),PreloadAnimLib(playerid,"ped"),PreloadAnimLib(playerid,"PLAYER_DVBYS");
	PreloadAnimLib(playerid,"PLAYIDLES"),PreloadAnimLib(playerid,"POLICE"),PreloadAnimLib(playerid,"POOL"),PreloadAnimLib(playerid,"POOR");
	PreloadAnimLib(playerid,"PYTHON"),PreloadAnimLib(playerid,"QUAD"),PreloadAnimLib(playerid,"QUAD_DBZ"),PreloadAnimLib(playerid,"RAPPING");
	PreloadAnimLib(playerid,"RIFLE"),PreloadAnimLib(playerid,"RIOT"),PreloadAnimLib(playerid,"ROB_BANK"),PreloadAnimLib(playerid,"ROCKET");
	PreloadAnimLib(playerid,"RUSTLER"),PreloadAnimLib(playerid,"RYDER"),PreloadAnimLib(playerid,"SCRATCHING"),PreloadAnimLib(playerid,"SHAMAL");
	PreloadAnimLib(playerid,"SHOP"),PreloadAnimLib(playerid,"SHOTGUN"),PreloadAnimLib(playerid,"SILENCED"),PreloadAnimLib(playerid,"SKATE");
	PreloadAnimLib(playerid,"SMOKING"),PreloadAnimLib(playerid,"SNIPER"),PreloadAnimLib(playerid,"SPRAYCAN"),PreloadAnimLib(playerid,"STRIP");
	PreloadAnimLib(playerid,"SUNBATHE"),PreloadAnimLib(playerid,"SWAT"),PreloadAnimLib(playerid,"SWEET"),PreloadAnimLib(playerid,"SWIM");
	PreloadAnimLib(playerid,"SWORD"),PreloadAnimLib(playerid,"TANK"),PreloadAnimLib(playerid,"TATTOOS"),PreloadAnimLib(playerid,"TEC");
	PreloadAnimLib(playerid,"TRAIN"),PreloadAnimLib(playerid,"TRUCK"),PreloadAnimLib(playerid,"UZI"),PreloadAnimLib(playerid,"VAN");
	PreloadAnimLib(playerid,"VENDING"),PreloadAnimLib(playerid,"VORTEX"),PreloadAnimLib(playerid,"WAYFARER"),PreloadAnimLib(playerid,"WEAPONS"),PreloadAnimLib(playerid,"WUZI");
	return 1; 
}
//==============================================================================
main()
{
	/*
	print("\n\n\n");
	const Float: numb1 = 50.0;
	const Float: numb2 = 39.0;
	const Float: metrov = 700.0;
	const Float: p = 0.30;
	printf("F = %.0f*1 + %.0f*1 = %.0f", numb1, numb2, (numb1*1) + (numb2*1));
	printf("Jy = (%.0f(3) * 1 : 12) + (1(3) * %.0f : 12) = %.1f + %.1f = %.1f", numb1, numb2, ((numb1*numb1*numb1)*1)/12, numb2/12, (((numb1*numb1*numb1)*1)/12) + (numb2/12));
	printf("Гy = ^%.1f : %.0f = %.1f", (((numb1*numb1*numb1)*1)/12) + (numb2/12), (numb1*1) + (numb2*1), floatsqroot(((((numb1*numb1*numb1)*1)/12) + (numb2/12)) / ((numb1*1) + (numb2*1))));
	printf("Лy = %.0f : %.1f = %.1f\t\tP = %.2f", metrov, floatsqroot(((((numb1*numb1*numb1)*1)/12) + (numb2/12)) / ((numb1*1) + (numb2*1))), metrov / floatsqroot(((((numb1*numb1*numb1)*1)/12) + (numb2/12)) / ((numb1*1) + (numb2*1))), p);
	printf("r = 105000 : (%.2f * %.0f) = %.1f", p, (numb1*1) + (numb2*1), 105000 / (p * (numb1*1) + (numb2*1)));
	printf("@F = ((2000 - %.1f) / %.1f) * 100 = %.1f", (105000 / (p * (numb1*1) + (numb2*1))), (105000 / (p * (numb1*1) + (numb2*1))), (((2000 - (105000 / (p * (numb1*1) + (numb2*1)))) / (105000 / (p * (numb1*1) + (numb2*1)))) * 100));
	printf("Ответ: %.0f * 1; %.0f * 1", numb1, numb2);

	print("\n\n");

	printf("F = %.0f*1 + %.0f*1 = %.0f", numb1, numb2, (numb1*1) + (numb2*1));
	printf("Jy = (%.0f(3) * 1 : 12) + (1(3) * %.0f : 12) = %.1f + %.1f = %.1f", numb1, numb2, ((numb1*numb1*numb1)*1)/12, numb2/12, (((numb1*numb1*numb1)*1)/12) + (numb2/12));
	printf("Гy = ^%.1f : %.0f = %.1f", (((numb1*numb1*numb1)*1)/12) + (numb2/12), (numb1*1) + (numb2*1), floatsqroot(((((numb1*numb1*numb1)*1)/12) + (numb2/12)) / ((numb1*1) + (numb2*1))));
	printf("Лy = 2 * (%.0f : %.1f) = %.1f\t\tP = %.2f", metrov, floatsqroot(((((numb1*numb1*numb1)*1)/12) + (numb2/12)) / ((numb1*1) + (numb2*1))), (metrov / floatsqroot(((((numb1*numb1*numb1)*1)/12) + (numb2/12)) / ((numb1*1) + (numb2*1)))) * 2, p);
	printf("r = 105000 : (%.2f * %.0f) = %.1f", p, (numb1*1) + (numb2*1), 105000 / (p * (numb1*1) + (numb2*1)));
	printf("@F = ((2000 - %.1f) / %.1f) * 100 = %.1f", (105000 / (p * (numb1*1) + (numb2*1))), (105000 / (p * (numb1*1) + (numb2*1))), (((2000 - (105000 / (p * (numb1*1) + (numb2*1)))) / (105000 / (p * (numb1*1) + (numb2*1)))) * 100));
	printf("Ответ: %.0f * 1; %.0f * 1", numb1, numb2);

	print("\n\n\n");
	*/
	new a[][15] = { "Unarmed (Fist)","Brass K" };
	#pragma unused a
	printf("\n");
	printf("*-----\t\t\t\t-----*");
	printf("\tProject Survival-Zone");
	printf("\tby zummore   (?) 2019");
	printf("*-----\t\t\t\t-----*");
	printf("\n");
}
//==============================================================================
stock CreateIcon(ID,Float:x,Float:y) {
	new Float:X,Float:Y;
	if(y < 0) Y=(y-(y*2))/15+212;
	else Y=212-y/15;
	if(x < 0) X=311-((x-(x*2))/14.8);
	else X=311+x/14.8;
	switch(ID) {
	case 2: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_centre");
	case 4: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_north");
	case 5: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_airYard");
	case 6: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_ammugun");
	case 7: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_barbers");
	case 8: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_BIGSMOKE");
	case 9: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_boatyard");
	case 10: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_burgerShot");
	case 11: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_bulldozer");
	case 12: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_CATALINAPINK");
	case 13: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_CESARVIAPANDO");
	case 14: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_chicken");
	case 15: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_CJ");
	case 16: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_CRASH1");
	case 17: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_diner");
	case 18: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_emmetGun");
	case 19: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_enemyAttack");
	case 20: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_fire");
	case 21: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_girlfriend");
	case 22: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_hostpital");
	case 23: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_LocoSyndicate");
	case 24: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_MADDOG");
	case 25: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_mafiaCasino");
	case 26: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_MCSTRAP");
	case 27: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_modGarage");
	case 28: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_OGLOC");
	case 29: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_pizza");
	case 30: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_police");
	case 31: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_propertyG");
	case 32: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_propertyR");
	case 33: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_race");
	case 34: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_RYDER");
	case 35: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_saveGame");
	case 36: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_school");
	case 37: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_qmark");
	case 38: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_SWEET");
	case 39: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_tattoo");
	case 40: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_THETRUTH");
	case 41: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_waypoint");
	case 42: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_TORENO");
	case 43: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_triads");
	case 44: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_triadsCasino");
	case 45: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_tshirt");
	case 46: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_WOOZIE");
	case 47: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_ZERO");
	case 48: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_dateDisco");
	case 49: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_dateDrink");
	case 50: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_dateFood");
	case 51: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_truck");
	case 52: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_cash");
	case 53: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_Flag");
	case 54: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_gym");
	case 55: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_impound");
	case 56: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_light");
	case 57: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_runway");
	case 58: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_gangB");
	case 59: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_gangP");
	case 60: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_gangY");
	case 61: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_gangN");
	case 62: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_gangG");
	case 63: MapIcon[CountIcon] = TextDrawCreate(X, Y, "hud:radar_spray"); }
	TextDrawBackgroundColor(MapIcon[CountIcon], 255);
	TextDrawFont(MapIcon[CountIcon], 4);
	TextDrawLetterSize(MapIcon[CountIcon], 0.500000, 1.000000);
	TextDrawColor(MapIcon[CountIcon], -1);
	TextDrawSetOutline(MapIcon[CountIcon], 0);
	TextDrawSetProportional(MapIcon[CountIcon], 1);
	TextDrawSetShadow(MapIcon[CountIcon], 1);
	TextDrawUseBox(MapIcon[CountIcon], 1);
	TextDrawBoxColor(MapIcon[CountIcon], 255);
	TextDrawTextSize(MapIcon[CountIcon], 14.000000, 14.000000);
	CountIcon++;}
stock CreateGlobalTextDraws(){
	MapLine[0] = TextDrawCreate(522.000000, 18.000000, "~n~");
	TextDrawBackgroundColor(MapLine[0], 255);
	TextDrawFont(MapLine[0], 1);
	TextDrawLetterSize(MapLine[0], 0.639999, -0.000000);
	TextDrawColor(MapLine[0], -1);
	TextDrawSetOutline(MapLine[0], 0);
	TextDrawSetProportional(MapLine[0], 1);
	TextDrawSetShadow(MapLine[0], 1);
	TextDrawUseBox(MapLine[0], 1);
	TextDrawBoxColor(MapLine[0], 255);
	TextDrawTextSize(MapLine[0], 118.000000, -3.000000);
	MapLine[1] = TextDrawCreate(522.000000, 421.000000, "~n~");
	TextDrawBackgroundColor(MapLine[1], 255);
	TextDrawFont(MapLine[1], 1);
	TextDrawLetterSize(MapLine[1], 0.639999, -0.000000);
	TextDrawColor(MapLine[1], -1);
	TextDrawSetOutline(MapLine[1], 0);
	TextDrawSetProportional(MapLine[1], 1);
	TextDrawSetShadow(MapLine[1], 1);
	TextDrawUseBox(MapLine[1], 1);
	TextDrawBoxColor(MapLine[1], 255);
	TextDrawTextSize(MapLine[1], 118.000000, -3.000000);
	MapLine[2] = TextDrawCreate(122.000000, 18.000000, "~n~");
	TextDrawBackgroundColor(MapLine[2], 255);
	TextDrawFont(MapLine[2], 1);
	TextDrawLetterSize(MapLine[2], 0.619999, 44.800025);
	TextDrawColor(MapLine[2], -1);
	TextDrawSetOutline(MapLine[2], 0);
	TextDrawSetProportional(MapLine[2], 1);
	TextDrawSetShadow(MapLine[2], 1);
	TextDrawUseBox(MapLine[2], 1);
	TextDrawBoxColor(MapLine[2], 255);
	TextDrawTextSize(MapLine[2], 114.000000, 0.000000);
	MapLine[3] = TextDrawCreate(522.000000, 18.000000, "~n~");
	TextDrawBackgroundColor(MapLine[3], 255);
	TextDrawFont(MapLine[3], 1);
	TextDrawLetterSize(MapLine[3], 0.619999, 44.800025);
	TextDrawColor(MapLine[3], -1);
	TextDrawSetOutline(MapLine[3], 0);
	TextDrawSetProportional(MapLine[3], 1);
	TextDrawSetShadow(MapLine[3], 1);
	TextDrawUseBox(MapLine[3], 1);
	TextDrawBoxColor(MapLine[3], 255);
	TextDrawTextSize(MapLine[3], 522.000000, 0.000000);
	Mapen_S = TextDrawCreate(120.0, 20.0, "samaps:map");
	TextDrawFont(Mapen_S, 4);
	TextDrawColor(Mapen_S, 0xFFFFFFFF);
	TextDrawTextSize(Mapen_S, 400.0, 400.0);
	ZVision = TextDrawCreate(2.000000, -1.000000, ".");
	TextDrawBackgroundColor(ZVision, 255);
	TextDrawFont(ZVision, 1);
	TextDrawLetterSize(ZVision, 0.509998, 54.000000);
	TextDrawColor(ZVision, -1);
	TextDrawSetOutline(ZVision, 0);
	TextDrawSetProportional(ZVision, 1);
	TextDrawSetShadow(ZVision, 1);
	TextDrawUseBox(ZVision, 1);
	TextDrawBoxColor(ZVision, -13495236);
	TextDrawTextSize(ZVision, 638.000000, 0.000000);
	return 1; 
}
stock progress_procent(Float: one, Float: two)
{
	// 100 / 4 = 25
	new count_ = floatround(100/(one + two), floatround_round);
	if(floatround(100/(one + two), floatround_round) >= 100) count_ = 100;
	return count_;
}
public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	if(areaid == GreenZone_Protect)
	{
		if(users[playerid][u_health] < 1) users[playerid][u_health] = 10;
		SetPlayerHealth(playerid, users[playerid][u_health]);
		temp[playerid][infinity_health] = 0;
		return true;
	}
   	return true;
}  
public OnPlayerEnterDynamicArea(playerid, areaid)
{
	if(areaid == GreenZone_Protect)
	{
		SetPlayerHealth(playerid, 0x7F800000);
		temp[playerid][infinity_health] = 1;
		return true;
	}
	if(areaid >= PickManager[0] && areaid <= PickManager[MAX_PICKUP-1] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		static pickup_id;
		for(new i = 0; i != MAX_PICKUP; i++) if(areaid == PickManager[i]) pickup_id = i;
		switch(pickup_id)
		{
		case 0: show_dialog(playerid, d_shop_menu, DIALOG_STYLE_MSGBOX, !"Магазин", !"{B2B2B2}Продавец: Что вы хотите?", !"Купить", !"Продать");
		case 1: show_dialog(playerid, d_green_shop, DIALOG_STYLE_TABLIST_HEADERS, !" ", !"Наименование\tЦена\n\
			{cccccc}1. {fffff0}Доски\t{33AA33}1000$\n\
			{cccccc}2. {fffff0}Необработаное железо\t{33AA33}2500$\n\
			{cccccc}3. {fffff0}Циркулярка\t{33AA33}5000$\n\
			{cccccc}4. {fffff0}Железная пластина\t{33AA33}8000$\n\
			{cccccc}5. {fffff0}Инструкция по крафту\t{33AA33}1500$", !"Купить", !"Отмена");
		}
 	}
	return true;
}
public OnPlayerRequestSpawn(playerid)
{
	if(!temp[playerid][temp_login]) return server_error(playerid, "Необходимо авторизоваться!"), false;
	return true;
}
public OnPlayerRequestClass(playerid, classid) 
{
	if(!temp[playerid][temp_login]) return true;
	new random_spawn = random(sizeof(random_position));
	SetSpawnInfo(playerid, 0, random_skin[random(sizeof(random_skin))][users[playerid][u_gender]], random_position[random_spawn][0], random_position[random_spawn][1], random_position[random_spawn][2], random(360), 0, 0, 0, 0, 0, 0 );
	SpawnPlayer(playerid);
	return true; 
}
public OnPlayerConnect(playerid) 
{
	// if(IsPlayerNPC(playerid)) return true;
	if(ServerRestarted != -1) return TKICK(playerid, "Сервер перезапускается.");
	ResetNew(playerid);
	temp[playerid][temp_timer] = SetTimerEx("@timer_seconds_for_player", 1000, true, "i", playerid);
	RemoveBuildingsForPlayer(playerid);
	if(GetNumberIP(GetIp(playerid)) > 3) return TKICK(playerid, "Слишком много игроков с данным IP.");
	
	SetPlayerColor(playerid, 0xFFFFFF00);
	static string[128];
	m_format(string, sizeof(string), "SELECT * FROM "TABLE_BANIP" WHERE `u_b_ip` = '%s' AND `u_b_ip_date` > NOW() LIMIT 1", GetIp(playerid));
	m_tquery(string, "@CheckPlayerBanIP", "i", playerid);
	return 1; 
}
public OnPlayerDisconnect(playerid, reason) 
{
	// NEW MODE:
	for(new at = 0; at < MAX_PLAYER_ATTACHED_OBJECTS; at++) 
	{ 
		if(IsPlayerAttachedObjectSlotUsed(playerid, at)) RemovePlayerAttachedObject(playerid, at);
	}
	//
	if(IsPlayerNPC(playerid)) return 1;
	/*if(GetPVarInt(playerid, "EditObjectToCar"))
	{
		DestroyDynamicObject(car_object[playerid]);
		DeletePVar(playerid, "CarID");
		DeletePVar(playerid, "EditObjectToCar");
	}*/
	if(GetPVarInt(playerid, "RECEIVED_DAMAGE_TIME") && ServerRestarted == -1)  
	{
		DropItems(playerid);
		// VeshiOff(playerid);
		users[playerid][u_newgame] = 1;
		SCMAF(COLOR_BROWN, "Игрок %s вышел во время боя.", users[playerid][u_name]);
		AddMessage(users[playerid][u_id], "Вы вышли во время боя, ваш лут утерен.");
	}
	if(GetPVarInt(playerid, "admin_vehicle"))
	{
		DestroyVehicle(GetPVarInt(playerid, "admin_vehicle"));
		CarInfo[GetPVarInt(playerid, "admin_vehicle")][car_admin] = 0;
		DeletePVar(playerid, "admin_vehicle");
	}
	if(admin[playerid][u_a_dostup] == 1)
	{
		if(!HideAdmins(users[playerid][u_name])) AdminChatF("%s %s вышел из административной игры.", admin_rank_name(playerid), users[playerid][u_name]);
		admin[playerid][u_a_dostup] = 0;
		admin[playerid][admin_level] = 0;
		foreach(Player, i) clan_syntax(i);
	}
	new str[33+MAX_PLAYER_NAME];
	switch(reason)
	{
	case 0: format(str, sizeof(str), "%s(%d) ~r~disconnected(Time out)", users[playerid][u_name], playerid);
	case 1: format(str, sizeof(str), "%s(%d) ~r~disconnected(Exit)", users[playerid][u_name], playerid);
	case 2: format(str, sizeof(str), "%s(%d) ~r~disconnected(Kick/Ban)", users[playerid][u_name], playerid); 
	}
	PlayersInfo(playerid, str);

	for(new m; m<sizeof(MapLine); m++) { TextDrawHideForPlayer(playerid, MapLine[m]); }
	for(new a; a<CountIcon; a++) { TextDrawHideForPlayer(playerid, MapIcon[a]); }
	TextDrawHideForPlayer(playerid, ZVision);
	TextDrawHideForPlayer(playerid, Mapen_S);
	Delete3DTextLabel(users_nickname[playerid]);
	KillTimer(temp[playerid][temp_timer]);
	SaveUser(playerid, "account");
	return true; 
}
public OnPlayerDeath(playerid, killerid, reason) 
{
	foreach(Player, i)
	{
		if(!admin[i][admin_level]) continue;
		if(!admin[playerid][admin_settings][2]) continue;
		SendDeathMessageToPlayer(i, killerid, playerid, reason);
	}
	// temp[playerid][use_dialog] 					= -1;
	users[playerid][u_newgame]						= 1;
	users[playerid][u_damage][0] 					= 0;
	users[playerid][u_helmet] 						= 0;
	users[playerid][u_armour] 						= 0;
	temp[playerid][temp_spawn] 						= false;
	if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
	if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
	TextDrawHideForPlayer(playerid, Text: drop_items_TD);
	TextDrawSetString(LoadingPlayer_TD[2], "~r~You are dead");
	TextDrawShowForPlayer(playerid, LoadingPlayer_TD[2]);
	LoadingForUser(playerid, 1);
	// VeshiOff(playerid);
	for(new m; m<sizeof(MapLine); m++) TextDrawHideForPlayer(playerid, MapLine[m]);
	for(new a; a<CountIcon; a++) TextDrawHideForPlayer(playerid, MapIcon[a]);
	new str[26+3+MAX_PLAYER_NAME];
	if(killerid != INVALID_PLAYER_ID && !IsPlayerNPC(killerid) && !IsPlayerNPC(playerid)) 
	{ 
		format(str, sizeof(str), "%s(%d) killed %s(%d) (%s)", users[killerid][u_name], killerid, users[playerid][u_name], playerid, WeaponNames[reason]);
		SCMASS(playerid, "Вас убил игрок %s(%i)", users[killerid][u_name], killerid);
	}
	else if(killerid != INVALID_PLAYER_ID && IsPlayerNPC(killerid)) 
	{ 
		format(str, sizeof(str), "ZOMBIE killed %s(%d)", users[playerid][u_name], playerid);
		server_error(playerid, "Вас убил зомби.");
	}
	else if(!IsPlayerNPC(playerid)) 
	{ 
		format(str, sizeof(str), "%s(%d) Death (Suicide)", users[playerid][u_name], playerid);
		server_error(playerid, "Вы умерли.");
	}
	PlayersInfo(playerid, str);
	TextDrawHideForPlayer(playerid, ZVision);
	TextDrawHideForPlayer(playerid, Mapen_S);
	DeletePVar(playerid, "USE_ANIMATION");
	temp[playerid][temp_use_map] = false;
	SetPlayerDrunkLevel(playerid, 0);
	if(killerid != INVALID_PLAYER_ID && !IsPlayerNPC(playerid)) 
	{ 
		switch(users[killerid][u_clan])
		{
		case 0: users[killerid][u_kill][1] ++;
		default:
			{
				if(users[playerid][u_clan] != users[killerid][u_clan]) users[killerid][u_kill][1] ++;
			}
		}
		users[playerid][u_death] ++;
		if(users[playerid][u_clan] != users[killerid][u_clan]) users[killerid][u_score] ++;
		users[playerid][u_score] = 0;
		SaveUser(killerid, "kill");
		Quest(killerid, 0);
		SetPlayerScore(playerid, users[playerid][u_score]);
		SetPlayerScore(killerid, users[killerid][u_score]); 
	}
	return 1; 
}
void Damage(playerid) 
{
	RemovePlayerHealth(playerid, 1.0);
	if(users[playerid][u_damage][0] != 0) 
	{
		SetTimerEx("Damage", 5000, false, "i", playerid);
		if(!users[playerid][u_settings][3])
		{
			DestroyPlayerObject(playerid, 18668);
			new Float: pos_xyz[3];
			GetPlayerPos(playerid, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
			CreatePlayerObject(playerid, 18668, pos_xyz[0], pos_xyz[1], pos_xyz[2]-2, 0, 0, 0, 10); 
		}
	}
	return 0; 
}
public OnPlayerUpdate(playerid) 
{
	if(PlayerIsOnline(playerid)) return true;
	if(GetPVarInt(playerid, "AFK") > 0) return SetPVarInt(playerid, "AFK", 0); 
	return 1; 
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_SPRINT) || PRESSED(KEY_JUMP))
	{
		if(GetPVarInt(playerid, "USE_ANIMATION")) ClearAnimLoop(playerid);
	}
	if(PRESSED(KEY_CROUCH))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			for(new i = 1; i < base_count; i++)
			{
				if(!IsPlayerInRangeOfPoint(playerid, 7.0, base[i][b_coords_gate][0], base[i][b_coords_gate][1], base[i][b_coords_gate][2])) continue;
				callcmd::opengate(playerid);
			}
		}
	}
	/*if(PRESSED(KEY_WALK)) 
	{ // ALT
		// if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && observation[playerid][observation_id] != INVALID_PLAYER_ID) SelectTextDraw(playerid, 0x535250AA);
		Equipment(playerid);
		return 1; 
	}*/
	if(PRESSED(KEY_NO)) return callcmd::menu(playerid);
	if((newkeys == KEY_SPRINT || newkeys == KEY_JUMP) && users[playerid][u_damage][1] != 0) 
	{
		if(GetPlayerAnimationIndex(playerid)) 
		{
			new animlib[32], animname[32];
			GetAnimationName(GetPlayerAnimationIndex(playerid), animlib, 32, animname,32);
			if(!strcmp(animlib, "ped", true) && strcmp(animname, "FALL_fall", true)) return ClearAnimations(playerid); 
			/*{
				if(strcmp(animname, "FALL_fall", true) == 0){}
				else return ClearAnimations(playerid); 
			} */
		}
		return 1; 
	}
	if(PRESSED(KEY_CTRL_BACK)) // H
	{
		if(IsPlayerInAnyVehicle(playerid)) return true;
		new Float: pos_xyz[3];
		for(new i = 1; i < MAX_VEHICLES; i++)
		{
			GetVehiclePos(i, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
			if(!IsPlayerInRangeOfPoint(playerid, 4.0, pos_xyz[0], pos_xyz[1], pos_xyz[2])) continue;
			GetCoordBootVehicle(i, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
			if(!IsPlayerInRangeOfPoint(playerid, 1.5, pos_xyz[0], pos_xyz[1], pos_xyz[2])) continue;
			if(car_boot{i} == VEHICLE_PARAMS_OFF) return server_error(playerid, "Багажник закрыт, откройте его.");
			show_dialog(playerid, d_the_choice, DIALOG_STYLE_MSGBOX, !"Багажник", !"Выберите действие", !"Взять", !"Положить"); 
			AntiBagAutoDoop[playerid] = i;
			break;
		}
		/*foramt_string[0] = EOS;
		strcat(foramt_string, "Название\tРасстояние\n");
		GetPlayerPos(playerid, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
		for(new h = 0; h < MAX_BOX; h++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.5, fire[h][fire_xyz][0], fire[h][fire_xyz][1], fire[h][fire_xyz][2]))
			{
				format(format_str, sizeof(format_str), "Костер\t%0.1f\n", DistancePointToPoint(pos_xyz[0], pos_xyz[1], pos_xyz[2], fire[fz][fire_xyz][0], fire[fz][fire_xyz][1], fire[fz][fire_xyz][2]));
				strcat(foramt_string, format_str);
			}
			if()
		}
		if(number) number = 0;
		for(new fz = 0; fz < MAX_FIRE; fz++)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 1.5, fire[fz][fire_xyz][0], fire[fz][fire_xyz][1], fire[fz][fire_xyz][2])) continue;
			format(format_str, sizeof(format_str), "Костер\t%0.1f\n", DistancePointToPoint(pos_xyz[0], pos_xyz[1], pos_xyz[2], fire[fz][fire_xyz][0], fire[fz][fire_xyz][1], fire[fz][fire_xyz][2]));
			strcat(foramt_string, format_str);
			index++;
			number++;
			usetoh[playerid][0][number-1] = fz;
		}
		if(number) number = 0;
		for(new c = 0; c < MAX_CRAFT; c++)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 2.0, craft_tool[c][craft_XYZ][0], craft_tool[c][craft_XYZ][1], craft_tool[c][craft_XYZ][2])) continue;
			format(format_str, sizeof(format_str), "%s\t%0.1f\n", craft_table[craft_tool[c][craft_type]-1][craft_name], 
			DistancePointToPoint(pos_xyz[0], pos_xyz[1], pos_xyz[2], craft_tool[c][craft_XYZ][0], craft_tool[c][craft_XYZ][1], craft_tool[c][craft_XYZ][2]));
			strcat(foramt_string, format_str);
			index++;
			number++;
			usetoh[playerid][1][number-1] = c;
		}
		if(number) number = 0;
		for(new med = 0; med < sizeof(MediksBoxData); med++) 
		{ 
			if(!IsPlayerInRangeOfPoint(playerid, 2.6, MediksBoxData[med][med_x], MediksBoxData[med][med_y], MediksBoxData[med][med_z])) continue;
			format(format_str, sizeof(format_str), "%s\t%0.1f\n", craft_table[craft_tool[med][craft_type]-1][craft_name], 
			DistancePointToPoint(pos_xyz[0], pos_xyz[1], pos_xyz[2], MediksBoxData[med][med_x], MediksBoxData[med][med_y], MediksBoxData[med][med_z]));
			strcat(foramt_string, format_str);
			index++;
			number++;
			usetoh[playerid][2][number-1] = c;
		}
		if(number) number = 0;
		for(new b = 1; b < MAX_BOX; b++) 
		{
			if(!IsPlayerInRangeOfPoint(playerid, 2.3, box[b][box_xyzf][0], box[b][box_xyzf][1], box[b][box_xyzf][2])) continue;
			format(format_str, sizeof(format_str), "%s\t%0.1f\n", boxname[box[box_number][box_type]][box_name], 
			DistancePointToPoint(pos_xyz[0], pos_xyz[1], pos_xyz[2], box[b][box_xyzf][0], box[b][box_xyzf][1], box[b][box_xyzf][2]));
			strcat(foramt_string, format_str);
			index++;
			number++;
			usetoh[playerid][3][number-1] = c;
		}
		if(index > 1) show_dialog(playerid, d_usetoh, DIALOG_STYLE_TABLIST_HEADERS, " ", foramt_string, !"Окей", !"Закрыть");*/
		for(new b = 1; b < MAX_BOX; b++) 
		{
			if(!IsPlayerInRangeOfPoint(playerid, 2.3, box[b][box_xyzf][0], box[b][box_xyzf][1], box[b][box_xyzf][2])) continue;
			temp[playerid][player_box] = b;
			BoxFunctions(playerid);
			break;
		}
		for(new i = 0; i < sizeof(MediksBoxData); i++) 
		{ 
			if(!IsPlayerInRangeOfPoint(playerid, 2.6, MediksBoxData[i][med_x], MediksBoxData[i][med_y], MediksBoxData[i][med_z])) continue;
			MediksEquipmentBox(playerid); 
			break;
		}
		for(new fz = 0; fz < MAX_FIRE; fz++)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 1.5, fire[fz][fire_xyz][0], fire[fz][fire_xyz][1], fire[fz][fire_xyz][2])) continue;
			callcmd::campfire(playerid);
			break;
		}
		new format_str[(11+1)+MAX_PLAYER_NAME+3], 
			format_string[sizeof(format_str)*10],
			index = 0;
		format_string[0] = EOS;
		strcat(format_string, "Название\tРасстояние\n");
		GetPlayerPos(playerid, pos_xyz[0], pos_xyz[1], pos_xyz[2]);
		for(new c = 0; c < MAX_CRAFT; c++)
		{
			// if(!IsPlayerInRangeOfPoint(playerid, 3.0, craft_tool[c][craft_XYZ][0], craft_tool[c][craft_XYZ][1], craft_tool[c][craft_XYZ][2])) continue;
			if(GetPlayerDistanceFromPoint(playerid, craft_tool[c][craft_XYZ][0], craft_tool[c][craft_XYZ][1], craft_tool[c][craft_XYZ][2]) > 2.0) continue;
			format(format_str, sizeof(format_str), "%s\t%0.1f\n", craft_table[craft_tool[c][craft_type]-1][craft_name], GetPlayerDistanceFromPoint(playerid, craft_tool[c][craft_XYZ][0], craft_tool[c][craft_XYZ][1], craft_tool[c][craft_XYZ][2]));
			strcat(format_string, format_str);
			index++;
			users[playerid][PlayerItem][index - 1] = c;
		}
		if(index > 1) show_dialog(playerid, d_usetoh, DIALOG_STYLE_TABLIST_HEADERS, " ", format_string, !"Выбрать", !"Закрыть");
		else if(index == 1 && GetPlayerDistanceFromPoint(playerid, craft_tool[users[playerid][PlayerItem][index-1]][craft_XYZ][0], craft_tool[users[playerid][PlayerItem][index-1]][craft_XYZ][1], craft_tool[users[playerid][PlayerItem][index-1]][craft_XYZ][2]) < 2.0) ShowCraftTools(playerid, users[playerid][PlayerItem][index-1]);
		return true; 
	}
	if(NOPRESSED(KEY_AIM))
	{
		if(GetPlayerWeapon(playerid) == 34)
		{
			if(users[playerid][u_helmet])
			{
				if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
				SetPlayerAttachedObject(playerid, 9, 19141, 2,  0.116999, 0.006000, 0.000000,  0.000000, 0.000000, 0.000000,  1.115001, 1.145001, 1.104000);
			}
			if(users[playerid][u_armour])
			{
				if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
				SetPlayerAttachedObject(playerid, 8, 19142, 1,  0.067999, 0.062999, 0.000000,  0.000000, 0.000000, 0.000000,  1.025000, 1.543997, 1.139000);
			}
		}
	}
	if(PRESSED(KEY_AIM))
	{
		if(GetPlayerWeapon(playerid) == 34)
		{
			if(users[playerid][u_helmet] && IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
			if(users[playerid][u_armour] && IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
		}
	}
	if(PRESSED(KEY_SUBMISSION))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return true;
		if(IsABycicle(GetPlayerVehicleID(playerid))) return true;
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true; 
		callcmd::car(playerid);
		return true;
	}
	if(PRESSED(KEY_ANALOG_LEFT))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return true;
		if(IsABycicle(GetPlayerVehicleID(playerid)) || IsBoatsAirplans(GetPlayerVehicleID(playerid)) || IsABike(GetPlayerVehicleID(playerid))) return true;
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
		if(GetPVarInt(playerid, "AntiFloodVehicleFunction") > gettime()) return server_error(playerid, "Не флуди!"), true;
		SetPVarInt(playerid,"AntiFloodVehicleFunction", gettime() + 2);
		if(car_bonnet{GetPlayerVehicleID(playerid)}) 
		{
			me_action(playerid, "закрыл(-а) капот.");
			ManualCar(GetPlayerVehicleID(playerid), "car_bonnet", 0);
		}
		else 
		{
			me_action(playerid, "открыл(-а) капот.");
			ManualCar(GetPlayerVehicleID(playerid), "car_bonnet", 1);
		}
		return true;
	}
	if(PRESSED(KEY_ACTION))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return true;
		if(IsABycicle(GetPlayerVehicleID(playerid))) return true;
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
		Engine(playerid);
		return true;
	}
	if(PRESSED(KEY_ANALOG_RIGHT))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return true;
		if(IsABycicle(GetPlayerVehicleID(playerid)) || IsBoatsAirplans(GetPlayerVehicleID(playerid)) || IsABike(GetPlayerVehicleID(playerid))) return true;
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
		if(GetPVarInt(playerid, "AntiFloodVehicleFunction") > gettime()) return server_error(playerid, "Не флуди!"), true;
		SetPVarInt(playerid,"AntiFloodVehicleFunction", gettime() + 2);
		if(car_boot{GetPlayerVehicleID(playerid)}) 
		{
			me_action(playerid, "закрыл(-а) багажник.");
			ManualCar(GetPlayerVehicleID(playerid), "car_boot", 0);
		}
		else 
		{
			me_action(playerid, "открыл(-а) багажник.");
			ManualCar(GetPlayerVehicleID(playerid), "car_boot", 1);
			server_accept(playerid, "Нажмите 'H', чтобы открыть багажник!");
		}
		return true;
	}
	if(PRESSED(KEY_FIRE))
	{
		if(!IsPlayerInAnyVehicle(playerid)) return true;
		if(IsABycicle(GetPlayerVehicleID(playerid)) || IsBoatsAirplans(GetPlayerVehicleID(playerid))) return true;
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return true;
		if(GetPVarInt(playerid, "AntiFloodVehicleFunction") > gettime()) return server_error(playerid, "Не флуди!"), true;
		SetPVarInt(playerid,"AntiFloodVehicleFunction", gettime() + 2);
		if(car_lights{GetPlayerVehicleID(playerid)}) 
		{
			me_action(playerid, "выключил(-а) фары.");
			ManualCar(GetPlayerVehicleID(playerid), "car_lights", 0);
		}
		else 
		{
			me_action(playerid, "включил(-а) фары.");
			ManualCar(GetPlayerVehicleID(playerid), "car_lights", 1);
		}
		return true;
	}
	return 0; 
}
/*
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart) 
{
	if(temp[playerid][time_infinity_health]) return true;
	if(temp[playerid][infinity_health]) return true;
	if(admin[playerid][u_a_gm]) return true;
	if(IsPlayerNPC(issuerid))
	{
		if(users[playerid][u_infected] < 1)
		{
			switch(random(6))
			{
			case 1, 3, 5:
				{
					users[playerid][u_infected] += 1 + random(15);
					server_error(playerid, "Вы были заражены.");
				}
			default: return false;
			}
		}
		RemovePlayerHealth(playerid, 15.0);
	}
	else
	{
		new Float: damage = 0.0;
		if(issuerid != INVALID_PLAYER_ID)
		{
			switch(weaponid)
			{
				case 22: damage = 13.0; // 9mm
				case 23: damage = 12.0; // 9mm с глушителем
				case 24: damage = 15.0; // Дигр
				case 25: damage = 19.0; // Shotgun
				case 26: damage = 21.0; // Sawnoff Shotgun
				case 27: damage = 30.0; // Combat Shotgun
				case 28: damage = 17.0; // Uzi
				case 29: damage = 22.0; // MP5
				case 30: damage = 33.0; // AK-47
				case 31: damage = 35.0; // M4
				case 32: damage = 25.0; // Тес-9
				case 33: damage = 40.0; // Винтовка
				case 34: damage = 64.0; // Снайперка
				default: damage = 5.0;
			}
			GetPlayerArmour(playerid, users[playerid][u_armour]);
			switch(weaponid)
			{
			case 22..34: 
				{
					switch(bodypart)
					{
					case 3: 
						{
							if(users[playerid][u_armour]) RemovePlayerArmour(playerid, damage+5.0);
							else RemovePlayerHealth(playerid, damage+12.0); //dSetPlayerHealth(playerid, health-damage-12); // Тело
						}
					case 4: 
						{
							if(users[playerid][u_armour]) RemovePlayerArmour(playerid, damage+5.0);
							else RemovePlayerHealth(playerid, damage+8.0); //dSetPlayerHealth(playerid, health-damage-8); // Копчик
						}
					case 5: 
						{
							if(users[playerid][u_armour]) RemovePlayerArmour(playerid, damage+5.0);
							else RemovePlayerHealth(playerid, damage+5.0); //dSetPlayerHealth(playerid, health-damage-5); // Левая рука
						}
					case 6: 
						{
							if(users[playerid][u_armour]) RemovePlayerArmour(playerid, damage+5.0);
							else RemovePlayerHealth(playerid, damage+5.0); //dSetPlayerHealth(playerid, health-damage-5); // Правая рука
						}
					case 7: 
						{
							if(users[playerid][u_armour]) RemovePlayerArmour(playerid, damage+5.0);
							else RemovePlayerHealth(playerid, damage+5.0); //dSetPlayerHealth(playerid, health-damage-5); // Левая нога
						}
					case 8: 
						{
							if(users[playerid][u_armour]) RemovePlayerArmour(playerid, damage+5.0);
							else RemovePlayerHealth(playerid, damage+5.0); //dSetPlayerHealth(playerid, health-damage-5); // Правая нога
						}
					case 9: 
						{
							if(users[playerid][u_helmet])
							{
								users[playerid][u_helmet] = 0;
								if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
								// temp[playerid][helmet_object] = SetPlayerAttachedObject(playerid, 9, 19141, 2,  0.116999, 0.006000, 0.000000,  0.000000, 0.000000, 0.000000,  1.115001, 1.145001, 1.104000);
								server_error(playerid, "Вам попрали в голову, шлем слетел с головы и сломался.");
							}
							else if(!users[playerid][u_helmet]) RemovePlayerHealth(playerid, 100.0); //dSetPlayerHealth(playerid, 0.0); // Голова 26
						}
					}
				}
			}
			SetPVarInt(playerid, "RECEIVED_DAMAGE_TIME", 40);
		}
	}
	if(!users[playerid][u_damage][0] && amount > 20.0 && bodypart != 9) 
	{
		switch(random(2))
		{
		case 0: 
			{
				RemovePlayerHealth(playerid, amount);
				users[playerid][u_damage][0] = 1;
				SetTimerEx("Damage", 4000, false, "i", playerid);
				SetPlayerDrunkLevel(playerid, 15000);
				server_error(playerid, "У вас кровотечение, перевяжите раны «бинтами»");
				server_error(playerid, "Вы получили болевой шок, примите «болеутоляющие»");
			}
		case 1:
			{
				RemovePlayerHealth(playerid, amount);
				LoopingAnim(playerid,"CRACK","crckidle3", 4.1, 0, 1, 1, 1, 1);
				users[playerid][u_damage][0] = 1;
				SetTimerEx("Damage", 5000, false, "i", playerid);
				SetPlayerDrunkLevel(playerid, 15000);
				users[playerid][u_damage][1] = 1;
				server_error(playerid, "У вас кровотечение, перевяжите раны «бинтами»");
				server_error(playerid, "У вас перелом, примите «морфин» и кость срастётся!");
			}
		}
	}
	return true; 
}*/
public OnPlayerText(playerid, text[]) 
{
	if(PlayerIsOnline(playerid)) return server_error(playerid, "Необходимо быть авторизованым!"), false;
	if(users[playerid][u_mute]) return SCMASS(playerid, "Чат заблокирован. Осталось: %i секунд(ы).", users[playerid][u_mute]), false;
	if(GetPVarInt(playerid,"AntiFloodChat") > gettime()) return server_error(playerid, "Не флуди!"), false;
	SetPVarInt(playerid,"AntiFloodChat", gettime() + 1);
	//if(GetTextBlurb(playerid,text,"IC")) return 0;
	SetPlayerChatBubble(playerid, text, 0x6ab1ffaa, 20.0, 10000);
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		ApplyAnimation(playerid, "PED", "IDLE_CHAT", 8.1, 0, 1, 1, 1, 1);
		SetTimerEx("ClearAnimText", 2000, false, "i", playerid);
	}
	new chat_format_string[(34+1)+MAX_PLAYER_NAME+3+128];
	switch(users[playerid][u_settings_vip][0])
	{
	case 0: format(chat_format_string, sizeof(chat_format_string), "- %s(%i): %s", users[playerid][u_name], playerid, text);
	case 1: format(chat_format_string, sizeof(chat_format_string), "- {FFD700}[VIP] {C0C0C0}%s(%i): %s", users[playerid][u_name], playerid, text);
	}
	ProxDetector(playerid, 30.0,  chat_format_string);
	AddChatLogs(playerid, text);
	return 0; 
}
stock UseItem(playerid, itemid, quantity = 0) 
{
	switch(itemid)
	{
	case 1:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "FOOD", "EAT_Burger");
			GivePlayerHealth(playerid, 25.0);
			SetPlayerNeed(playerid, 1, 50);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы съели Сухой паек");
		}
	case 2:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "FOOD", "EAT_Burger");
			GivePlayerHealth(playerid, 25.0);
			SetPlayerNeed(playerid, 1, 25);
			SetPlayerNeed(playerid, 0, 15);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы съели Банку бобов");
		}
	case 3:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "FOOD", "EAT_Burger");
			GivePlayerHealth(playerid, 25.0);
			SetPlayerNeed(playerid, 0, 40);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы выпили Sprunk.");
		}
	case 4:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "FOOD", "EAT_Burger");
			GivePlayerHealth(playerid, 25.0);
			SetPlayerNeed(playerid, 1, 60);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы съели Жареное мясо");
		}
	case 5: // return server_message(playerid, "Вам необходим костер, вы можете его создать или использовать уже созданный.");
		{
			switch(random(3))
			{
			case 1:
				{
					server_message(playerid, "Вы употребили сырое мясо.");
					// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
					progress_bar(playerid, "FOOD", "EAT_Burger");
					GivePlayerHealth(playerid, (1.0 + random(3)));
				}
			default: 
				{
					server_error(playerid, "Вы употребили сырое мясо, получено отравление!");
					// LoopingAnim(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 1, 1, 1, 1);
					progress_bar(playerid, "FOOD", "EAT_Vomit_P", 6);
					RemovePlayerHealth(playerid, (1.3 + random(5)));
				}
			}
			RemoveItem(playerid, itemid, quantity);
		}
	case 6:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "FOOD", "EAT_Burger");
			GivePlayerHealth(playerid, 25.0);
			SetPlayerNeed(playerid, 0, 60);
			SetPlayerNeed(playerid, 1, 10);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы выпили Молоко");
		}
	case 7:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "FOOD", "EAT_Burger");
			GivePlayerHealth(playerid, 25.0);
			SetPlayerNeed(playerid, 1, 50);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы съели Бургер");
		}
	case 8:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "FOOD", "EAT_Burger");
			GivePlayerHealth(playerid, 25.0);
			SetPlayerNeed(playerid, 1, 50);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы съели Пиццу"); 
		}
	case 9:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "FOOD", "EAT_Burger");
			GivePlayerHealth(playerid, 25.0);
			SetPlayerNeed(playerid, 1, 50);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы съели Буррито");
		}
	case 18..25, 63..66, 75..76:
		{
			if(GetPVarInt(playerid, "GUN_ID") != getWeaponByItem(itemid)) return SCMASS(playerid, "Возьмите в руки %s!", WeaponNames[getWeaponByItem(itemid)]);
			if(itemid == 66) ServerGivePlayerWeapon(playerid, GetPVarInt(playerid, "GUN_ID"), 1);
			else ServerGivePlayerWeapon(playerid, GetPVarInt(playerid, "GUN_ID"), quantity);
			RemoveItem(playerid, itemid, quantity);
		}
	case 10..17, 59..62, 71..72:
		{
			switch(itemid)
			{
			case 11, 59..60: if(GetPlayerWeaponSlot(playerid, 2)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			case 10, 61, 72: if(GetPlayerWeaponSlot(playerid, 3)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			case 15..17: if(GetPlayerWeaponSlot(playerid, 4)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			case 12..13: if(GetPlayerWeaponSlot(playerid, 5)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			case 14, 71: if(GetPlayerWeaponSlot(playerid, 6)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			case 62: if(GetPlayerWeaponSlot(playerid, 7)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			}
			new check = 0;
			if(check) check = 0;
			for(new z = 0; z < INVENTORY_USE; z++)
			{
				if(!user_items[playerid][z][item_id]) continue;
				if(user_items[playerid][z][item_id] != getAmmoByWeapon(itemid)) continue;
				if(user_items[playerid][z][item_id] != 62 && user_items[playerid][z][item_quantity] > 0)
				{
					if(user_items[playerid][z][item_quantity] < 1) continue;
				}
				if(user_items[playerid][z][item_id] == 66) ServerGivePlayerWeapon(playerid, GetItemWeapon(itemid), 1);
				else ServerGivePlayerWeapon(playerid, GetItemWeapon(itemid), user_items[playerid][z][item_quantity]);
				RemoveItem(playerid, user_items[playerid][z][item_id], user_items[playerid][z][item_quantity]);
				RemoveItem(playerid, itemid, quantity);
				// protect_gun[GetWeaponSlot(GetItemWeapon(itemid))] = GetItemWeapon(itemid);
				SCMG(playerid, "Вы зарядили оружие %s.", WeaponNames[GetItemWeapon(itemid)]);
				check = 1;
				break;
			} 
			if(!check) return SCMASS(playerid, "У вас нет патронов для %s.", WeaponNames[GetItemWeapon(itemid)]);
		}
	case 26:
		{
			if(GetPlayerWeaponSlot(playerid, 1)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			ServerGivePlayerWeapon(playerid, 5, 1);
			server_accept(playerid, "Вы использовали Биту");
			RemoveItem(playerid, itemid, quantity);
		}
	case 27:
		{
			if(GetPlayerWeaponSlot(playerid, 1)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			ServerGivePlayerWeapon(playerid, 8, 1);
			server_accept(playerid, "Вы использовали Катану");
			RemoveItem(playerid, itemid, quantity);
		}
	case 28:
		{
			if(GetPlayerWeaponSlot(playerid, 1)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			ServerGivePlayerWeapon(playerid, 6, 1);
			server_accept(playerid, "Вы использовали Лопату");
			RemoveItem(playerid, itemid, quantity);
		}
	case 29:
		{
			if(GetPlayerWeaponSlot(playerid, 1)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			ServerGivePlayerWeapon(playerid, 4, 1);
			server_accept(playerid, "Вы использовали Нож");
			RemoveItem(playerid, itemid, quantity);
		}
	case 30:
		{
			if(GetPlayerWeaponSlot(playerid, 1)) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			ServerGivePlayerWeapon(playerid, 3, 1);
			server_accept(playerid, "Вы использовали Дубинку");
			RemoveItem(playerid, itemid, quantity);
		}
	case 31: // Бинты;
		{
			if(!users[playerid][u_damage][0]) return server_error(playerid, "Вам не нужна перевязка.");
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"CASINO","cards_pick_01", 4.1, 0, 1, 1, 1, 1);//бинты
			progress_bar(playerid, "CASINO", "cards_pick_01");
			users[playerid][u_damage][0] = 0;
			server_accept(playerid, "Вы перебинтовали себе Раны.");
			RemoveItem(playerid, itemid, quantity);
		}
	case 32:
		{
			if(users[playerid][u_infected] < 1) return server_error(playerid, "Вы не нуждаетесь в Антибиотиках");
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"CARRY","putdwn05", 5.5, 0, 1, 1, 1, 1);//перелить кровь
			progress_bar(playerid, "CARRY", "putdwn05");
			if(users[playerid][u_infected] < 5) users[playerid][u_infected] = 0;
			else 
			{
				SetPVarInt(playerid, "ANTIVIRUS_USE", 10);
				server_message(playerid, "Вы приняли антибиотики, уровень заражения в крови понижен и на время остановлен.");
				users[playerid][u_infected] -= 1 + random(25);
			}
			if(users[playerid][u_infected] < 1) 
			{
				users[playerid][u_infected] = 0;
				server_message(playerid, "Вы приняли антибиотики, вы полностью вылечилась от заражения.");
				DeletePVar(playerid, "ANTIVIRUS_USE");
			}
			RemoveItem(playerid, itemid, quantity);
		}
	case 33: // Морфин;
		{
			if(!users[playerid][u_damage][1]) return server_error(playerid, "Вы не нуждаетесь в Морфине.");
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"CARRY", "putdwn05", 5.5, 0, 1, 1, 1, 1);// перелить кровь;
			progress_bar(playerid, "CARRY", "putdwn05");
			server_accept(playerid, "Вы приняли Морфин");
			RemoveItem(playerid, itemid, quantity);
			users[playerid][u_damage][1] = 0;
		}
	case 35: // Аптечка;
		{
			new Float: health;
			GetPlayerHealth(playerid, health);
			if(health > 95) return server_error(playerid, "Вам не требуется аптечка.");
			progress_bar(playerid, "CASINO", "cards_pick_01");
			GivePlayerHealth(playerid, 50.0);
			users[playerid][u_damage][0] = 0;
			server_accept(playerid, "Вы использовали Аптечку.");
			RemoveItem(playerid, itemid, quantity);
		}
	case 38: //Бронежилет 
		{
			// users[playerid][u_armour] = 100.0;
			SetPlayerArmour(playerid, quantity);
			RemoveItem(playerid, itemid, quantity);
			// RemovePlayerAttachedObject(playerid, temp[playerid][armour_object]);
			if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) RemovePlayerAttachedObject(playerid, 8);
			SetPlayerAttachedObject(playerid, 8, 19142, 1,  0.067999, 0.062999, 0.000000,  0.000000, 0.000000, 0.000000,  1.025000, 1.543997, 1.139000);
			server_accept(playerid, "Вы надели Бронежилет.");
		}
	case 39:
		{
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы не должны находиться в транспортном средстве!");
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов!");
			for(new i = 1; i < MAX_VEHICLES; i++) 
			{	
				new Float: x, Float: y, Float: z;
				GetVehiclePos(i, x, y, z);
				if(IsPlayerInRangeOfPoint(playerid, 2.0, x, y, z)) 
				{
					switch(GetCarWheels(i))
					{
					case 0: return server_error(playerid, "На это т/с нельзя установить колесо.");
					}
					if(!TransportTires(i)) return server_error(playerid, "Все колеса уже установлены!");
					static Float: boot_pos[3], Float: bonnet_pos[3];
					GetCoordBootVehicle(i, boot_pos[0], boot_pos[1], boot_pos[2]);
					GetCoordBonnetVehicle(i, bonnet_pos[0], bonnet_pos[1], bonnet_pos[2]);
					if(IsPlayerInRangeOfPoint(playerid, 1.0, boot_pos[0], boot_pos[1], boot_pos[2]) && IsPlayerInRangeOfPoint(playerid, 1.0, bonnet_pos[0], bonnet_pos[1], bonnet_pos[2])) 
						return server_error(playerid, "Чтобы прикрутить колесо подойдите к месту колеса т/с!");
					switch(GetCarWheels(i))
					{
					case 2:
						{
							if(!CarInfo[i][car_tires][0]) CarInfo[i][car_tires][0] = 1;
							else if(!CarInfo[i][car_tires][1]) CarInfo[i][car_tires][1] = 1;
						}
					case 4:
						{
							if(!CarInfo[i][car_tires][0]) CarInfo[i][car_tires][0] = 1;
							else if(!CarInfo[i][car_tires][1]) CarInfo[i][car_tires][1] = 1;
							else if(!CarInfo[i][car_tires][2]) CarInfo[i][car_tires][2] = 1;
							else if(!CarInfo[i][car_tires][3]) CarInfo[i][car_tires][3] = 1;
						}
					}
					server_accept(playerid,"Вы установили Колесо");
					RemoveItem(playerid, itemid, quantity);
					break;
				}
			}
		}
	case 40:
		{
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы не должны находиться в транспортном средстве!");
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов!");
			for(new i = 1; i < MAX_VEHICLES; i++) 
			{
				new Float: x, Float: y, Float: z;
				GetVehiclePos(i, x, y, z);
				if(IsPlayerInRangeOfPoint(playerid, 4.0, x, y, z)) 
				{
					switch(GetCarWheels(i))
					{
					case 0: return server_error(playerid, "C этого т/с нельзя снимать колеса!");
					}
					static Float: boot_pos[3], Float: bonnet_pos[3];
					GetCoordBootVehicle(i, boot_pos[0], boot_pos[1], boot_pos[2]);
					GetCoordBonnetVehicle(i, bonnet_pos[0], bonnet_pos[1], bonnet_pos[2]);
					if(IsPlayerInRangeOfPoint(playerid, 1.0, boot_pos[0], boot_pos[1], boot_pos[2]) && IsPlayerInRangeOfPoint(playerid, 1.0, bonnet_pos[0], bonnet_pos[1], bonnet_pos[2])) return server_error(playerid, "Чтобы открутить колесо подойдите к колесу т/с!");
					if(GetTires(i) == GetCarWheels(i) && GetTiresFail(i) == GetCarWheels(i)) return server_error(playerid, "На т/с уже сняли все колеса.");
					if(users[playerid][u_slots]  >= users[playerid][u_backpack]*10) return server_error(playerid,  "Ваш инвентарь полон, выбросите что-нибудь!");
					server_accept(playerid, "Вы сняли колесо.");
					switch(GetCarWheels(i))
					{
					case 2, 4:
						{
							if(CarInfo[i][car_tires][0]) 
							{
								switch(CarInfo[i][car_tires][0])
								{
								case 1: AddItem(playerid, 39, 1);
								case 2: AddItem(playerid, 112, 1);
								}
								CarInfo[i][car_tires][0] = 0;
							}
							else if(CarInfo[i][car_tires][1]) 
							{
								switch(CarInfo[i][car_tires][1])
								{
								case 1: AddItem(playerid, 39, 1);
								case 2: AddItem(playerid, 112, 1);
								}
								CarInfo[i][car_tires][1] = 0;
							}
							else if(CarInfo[i][car_tires][2]) 
							{
								switch(CarInfo[i][car_tires][2])
								{
								case 1: AddItem(playerid, 39, 1);
								case 2: AddItem(playerid, 112, 1);
								}
								CarInfo[i][car_tires][2] = 0;
							}
							else if(CarInfo[i][car_tires][3]) 
							{
								switch(CarInfo[i][car_tires][3])
								{
								case 1: AddItem(playerid, 39, 1);
								case 2: AddItem(playerid, 112, 1);
								}
								CarInfo[i][car_tires][3] = 0;
							}
						}
					}
					break;
				}
			}
		}
	case 41:
		{
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы не должны находиться в транспортном средстве!");
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов!");
			for(new i = 1; i < MAX_VEHICLES; i++) 
			{
				new Float: x, Float: y, Float: z;
				GetVehiclePos(i, x, y, z);
				if(IsPlayerInRangeOfPoint(playerid, 4.0, x, y, z)) 
				{
					if(IsABycicle(i)) return true;
					RepairVehicle(i);
					SetHealthVehicle(i, 1000.0);
					RemoveItem(playerid, itemid, quantity);
					server_accept(playerid, "Транспорт отремонтирован.");
					break;
				}
			}
		}
	case 42:
		{
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы не должны находиться в транспортном средстве!");
			for(new i = 1; i < MAX_VEHICLES; i++) 
			{
				new Float: x, Float: y, Float: z;
				GetVehiclePos(i, x, y, z);
				if(IsPlayerInRangeOfPoint(playerid, 4.0, x, y, z)) 
				{
					if(IsABycicle(i)) return true;
					if(CarInfo[i][car_fuel] == InfoOfFuel(i)) return server_error(playerid, "В т/с полный бак топлива.");
					if(CarInfo[i][car_fuel] > (InfoOfFuel(i)-10)) return server_error(playerid, "В т/с полно топлива, попробуйте попозже.");
					CarInfo[i][car_fuel] += 20;
					if(CarInfo[i][car_fuel] > InfoOfFuel(i)) CarInfo[i][car_fuel] = InfoOfFuel(i);
					AddItem(playerid, 43, 1);
					RemoveItem(playerid, itemid, quantity);
					server_accept(playerid, "Вы залили топливо из канистры в автомобиль.");
					break;
				}
			}
		}
	case 43:
		{
			if(!IsPlayerOnGasStation(playerid, 10)) return server_error(playerid, "Вы не на заправке.");
			AddItem(playerid, 42, 1);
			RemoveItem(playerid, itemid, quantity);
			server_accept(playerid, "Вы наполнили Канистру.");
		}
	case 44:
		{
			// ClearAnimLoop(playerid);
			// LoopingAnim(playerid,"BAR","dnk_stndM_loop", 4.1, 0, 1, 1, 1, 1);
			progress_bar(playerid, "BAR", "dnk_stndM_loop");
			GivePlayerHealth(playerid, 5.0);
			SetPlayerNeed(playerid, 0, 60);
			server_accept(playerid, "Вы выпили Воду.");
			AddItem(playerid, 45, 1);
			RemoveItem(playerid, itemid, quantity);
		}
	case 45: server_error(playerid, "Вода набирается автоматически при входе в воду.");
	case 46..48, 67, 68, 79..105, 111:
	{
		if(SkinToItem(GetPlayerSkin(playerid)) != 255) AddItem(playerid, SkinToItem(GetPlayerSkin(playerid)), 1);
		SetPlayerSkin(playerid, ItemToSkin(itemid,users[playerid][u_gender]));
		users[playerid][u_skin] = ItemToSkin(itemid, users[playerid][u_gender]);
		// ClearAnimLoop(playerid);
		// LoopingAnim(playerid,"CLOTHES","CLO_Buy", 4.1, 0, 1, 1, 1, 1);
		progress_bar(playerid, "CLOTHES", "CLO_Buy");
		RemoveItem(playerid, itemid, quantity);
		server_accept(playerid, "Вы переодели одежду.");
	}
	case 49: //Маленький рюкзак
		{
			if(users[playerid][u_slots] >= 2*10) return server_error(playerid, "Этот рюкзак слишком мал, выбросите что-нибудь");
			switch(users[playerid][u_backpack])
			{
			case 1, 2: AddItem(playerid, 49, 1);
			case 3: AddItem(playerid, 50, 1);
			case 4: AddItem(playerid, 69, 1);
			case 5: AddItem(playerid, 70, 1);
			}
			RemoveItem(playerid, itemid, quantity);
			users[playerid][u_backpack] = 2;
			RemovePlayerAttachedObject(playerid, users[playerid][u_backpack_object]);
			users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid, 0, 3026, 1, -0.158000, -0.097999, -0.010000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);//маленький
			server_accept(playerid, "Вы надели {7bc078}маленький рюкзак");
		}
	case 50: //Средний рюкзак
		{
			if(users[playerid][u_slots] >= 3*10) return server_error(playerid, "Этот рюкзак слишком мал, выбросите что-нибудь");
			switch(users[playerid][u_backpack])
			{
			case 1, 2: AddItem(playerid, 49, 1);
			case 3: AddItem(playerid, 50, 1);
			case 4: AddItem(playerid, 69, 1);
			case 5: AddItem(playerid, 70, 1);
			}
			RemoveItem(playerid, itemid, quantity);
			users[playerid][u_backpack] = 3;
			RemovePlayerAttachedObject(playerid, users[playerid][u_backpack_object]);
			users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid, 0, 371, 1, 0.056000, -0.116000, -0.004999, 2.300001, 87.000030, -0.300001, 1.000000, 0.733999, 1.058000);//ср
			server_accept(playerid, "Вы надели {7bc078}средний рюкзак");
		}
	case 52: return server_message(playerid, "GPS работает.");
	case 54: return server_message(playerid, "Время отображается в верхнем правом углу.");
	case 55, 56:
		{
			if(IsPlayerInWater(playerid)) return server_error(playerid, "Вы не можете разжечь костёр в воде.");
			if(!GetItem(playerid, 56)) return server_error(playerid, "Вы не можете разжечь кострёр без дров.");
			if(!GetItem(playerid, 55)) return server_error(playerid, "Вы не можете разжечь кострёр без спичек.");
			progress_bar(playerid, "BD_FIRE", "wash_up");
			CreateFire(playerid);
			server_message(playerid, "Вы разожгли костёр, используйте клавишу 'H' для использования.");
			RemoveItem(playerid, 56, quantity);
			RemoveItem(playerid, 55, quantity);
		}
	case 58:
		{
			switch(random(3))
			{
			case 1:
				{
					server_message(playerid, "Вы употребили из банки что-то съедобное.");
					// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
					progress_bar(playerid, "FOOD", "EAT_Burger");
					GivePlayerHealth(playerid, (1.3 + random(5)));
				}
			default: 
				{
					server_error(playerid, "Вы употребили из банки что-то не съедобное, получено отравление!");
					// LoopingAnim(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 1, 1, 1, 1);
					progress_bar(playerid, "FOOD", "EAT_Vomit_P", 6);
					RemovePlayerHealth(playerid, (1.3 + random(5)));
				}
			}
			RemoveItem(playerid, itemid, quantity);
		}
	case 69: //Большой рюкзак
		{
			if(users[playerid][u_slots] >= 4*10) return server_error(playerid, "Этот рюкзак слишком мал, выбросите что-нибудь");
			switch(users[playerid][u_backpack])
			{
			case 1, 2: AddItem(playerid, 49, 1);
			case 3: AddItem(playerid, 50, 1);
			case 4: AddItem(playerid, 69, 1);
			case 5: AddItem(playerid, 70, 1);
			}
			RemoveItem(playerid, itemid, quantity);
			users[playerid][u_backpack] = 4;
			RemovePlayerAttachedObject(playerid, users[playerid][u_backpack_object]);
			users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid, 0, 1310, 1, -0.098999, -0.170999, 0.000000, -3.200003, 87.799934, 2.499999, 1.000000, 0.741999, 1.000000);//большой
			server_accept(playerid, "Вы надели {7bc078}большой рюкзак");
		}
	case 70: //Очень большой рюкзак
		{
			if(users[playerid][u_slots] >= 5*10) return server_error(playerid, "Этот рюкзак слишком мал, выбросите что-нибудь");
			switch(users[playerid][u_backpack])
			{
			case 1, 2: AddItem(playerid, 49, 1);
			case 3: AddItem(playerid, 50, 1);
			case 4: AddItem(playerid, 69, 1);
			case 5: AddItem(playerid, 70, 1);
			}
			RemoveItem(playerid, itemid, quantity);
			users[playerid][u_backpack] = 5;
			RemovePlayerAttachedObject(playerid, users[playerid][u_backpack_object]);
			users[playerid][u_backpack_object] = SetPlayerAttachedObject(playerid, 0, 19559, 1, 0.056000, -0.096000, -0.004999, -3.200003, 87.799934, 2.499999, 1.000000, 1.046000, 1.184999);//оч большой
			server_accept(playerid, "Вы надели {7bc078}очень большой рюкзак");
		}
	case 73:
		{
			if(GetPlayerWeaponSlot(playerid, 8) == 18) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			ServerGivePlayerWeapon(playerid, 16, 1);
			server_accept(playerid, "Вы использовали Гранату");
			RemoveItem(playerid, itemid, quantity);
		}
	case 74:
		{
			if(GetPlayerWeaponSlot(playerid, 8) == 16) return server_error(playerid, "Слот оружия уже испльзуется другим оружием.");
			ServerGivePlayerWeapon(playerid, 18, 1);
			server_accept(playerid, "Вы использовали Коктель Молотова");
			RemoveItem(playerid, itemid, quantity);
		}
	case 77:
		{
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы Не должны находиться в транспортном средстве!");
			if(IsPlayerInWater(playerid)) return server_error(playerid, "Вы Не должны находиться в воде!");
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов.");
			// if(IsPlayerToCube(playerid, -872.3362, 2005.8126, 45.8325, -958.0191, 2027.3754, 75.4132) || 
			// IsPlayerToCube(playerid, -2394.9941, 2541.2268, 7.6683, -2527.1462, 2474.6292, 28.1215)) return server_error(playerid, "В этом месте запрещено ставить ящики");
			if(IsPlayerInRangeOfPoint(playerid, 50.0, -912.8105, 2010.2269, 60.9141) ||
			IsPlayerInRangeOfPoint(playerid, 90.0, -2466.2231, 2502.9683, 16.6739)) return server_error(playerid, "В этом месте запрещено ставить ящики.");
			for(new x = 1; x < MAX_BOX; x++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 3, box[x][box_xyzf][0], box[x][box_xyzf][1], box[x][box_xyzf][2]) && box[x][box_id]) return server_error(playerid, "Ставить ящик близко к другому нельзя!");
			}
			switch(IsGuardBase(playerid))
			{
			case 1: return server_error(playerid, "[Защита]: Чтобы поставить ящик, необходимо один раз открыть ворота.");
			case 2: return server_error(playerid, "[Защита]: Вы не состоите в клане владельца базы.");
			}
			new Float: pos_xyzf[4];
			GetPlayerPos(playerid, pos_xyzf[0], pos_xyzf[1], pos_xyzf[2]);
			GetPlayerFacingAngle(playerid, pos_xyzf[3]);
			RemoveItem(playerid, itemid, quantity);
			GetXYBehindPoint(playerid, pos_xyzf[0], pos_xyzf[1], 2.0);
			addbox(playerid, 0, pos_xyzf[0], pos_xyzf[1], pos_xyzf[2]-1, pos_xyzf[3]);
			server_accept(playerid, "Нажмите ''H'' чтобы открыть ящик");
		}
	case 78:
		{
			if(users[playerid][u_helmet]) return server_error(playerid, "У вас уже надет шлем.");
			users[playerid][u_helmet] = 1;
			RemoveItem(playerid, itemid, quantity);
			if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
			SetPlayerAttachedObject(playerid, 9, 19141, 2,  0.116999, 0.006000, 0.000000,  0.000000, 0.000000, 0.000000,  1.115001, 1.145001, 1.104000);
			server_accept(playerid, "Вы надели шлем");
		}
	case 108:
		{
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов.");
			if(!GetItem(playerid, 108)) return server_error(playerid, "У вас нету кодового замка.");
			for(new b = 1; b < MAX_BOX; b++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.5, box[b][box_xyzf][0], box[b][box_xyzf][1], box[b][box_xyzf][2]) && box[b][box_id])
				{
					if(strcmp(box[b][box_pass], "NoBoxPass1234"))
					{
						SCMASS(playerid, "%s уже находится под паролем!", boxname[box[b][box_type]][box_name]);
						break;
					}
					show_dialog(playerid, d_box_castle, DIALOG_STYLE_MSGBOX, !"Кодовый замок", !"\nВы точно хотите установить кодовый замок?\n", !"Да", !"Нет");
				}
			}
		}
	case 109:
		{
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы Не должны находиться в транспортном средстве!");
			if(IsPlayerInWater(playerid)) return server_error(playerid, "Вы Не должны находиться в воде!");
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов.");
			// if(IsPlayerToCube(playerid, -872.3362, 2005.8126, 45.8325, -958.0191, 2027.3754, 75.4132) || 
			// IsPlayerToCube(playerid, -2394.9941, 2541.2268, 7.6683, -2527.1462, 2474.6292, 28.1215)) return server_error(playerid, "В этом месте запрещено ставить ящики");
			if(IsPlayerInRangeOfPoint(playerid, 50.0, -912.8105, 2010.2269, 60.9141) ||
			IsPlayerInRangeOfPoint(playerid, 90.0, -2466.2231, 2502.9683, 16.6739)) return server_error(playerid, "В этом месте запрещено ставить ящики.");
			for(new x = 1; x < MAX_BOX; x++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 3, box[x][box_xyzf][0], box[x][box_xyzf][1], box[x][box_xyzf][2]) && box[x][box_id]) return server_error(playerid, "Ставить ящик близко к другому нельзя!");
			}
			switch(IsGuardBase(playerid))
			{
			case 1: return server_error(playerid, "[Защита]: Чтобы поставить ящик, необходимо один раз открыть ворота.");
			case 2: return server_error(playerid, "[Защита]: Вы не состоите в клане владельца базы.");
			}
			new Float: pos_xyzf[4];
			GetPlayerPos(playerid, pos_xyzf[0], pos_xyzf[1], pos_xyzf[2]);
			GetPlayerFacingAngle(playerid, pos_xyzf[3]);
			RemoveItem(playerid, itemid, quantity);
			GetXYBehindPoint(playerid, pos_xyzf[0], pos_xyzf[1], 2.0);
			addbox(playerid, 1, pos_xyzf[0], pos_xyzf[1], pos_xyzf[2]-1, pos_xyzf[3]);
			server_accept(playerid, "Нажмите H чтобы открыть ящик");
		}
	case 110:
		{
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов.");
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы Не должны находиться в транспортном средстве!");
			if(IsPlayerInWater(playerid)) return server_error(playerid, "Вы Не должны находиться в воде!");
			// if(IsPlayerToCube(playerid, -872.3362, 2005.8126, 45.8325, -958.0191, 2027.3754, 75.4132) || 
			// IsPlayerToCube(playerid, -2394.9941, 2541.2268, 7.6683, -2527.1462, 2474.6292, 28.1215)) return server_error(playerid, "В этом месте запрещено ставить ящики");
			if(IsPlayerInRangeOfPoint(playerid, 50.0, -912.8105, 2010.2269, 60.9141) ||
			IsPlayerInRangeOfPoint(playerid, 90.0, -2466.2231, 2502.9683, 16.6739)) return server_error(playerid, "В этом месте запрещено ставить ящики.");
			for(new x = 1; x < MAX_BOX; x++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 3, box[x][box_xyzf][0], box[x][box_xyzf][1], box[x][box_xyzf][2]) && box[x][box_id]) return server_error(playerid, "Ставить ящик близко к другому нельзя!");
			}
			switch(IsGuardBase(playerid))
			{
			case 1: return server_error(playerid, "[Защита]: Чтобы поставить ящик, необходимо один раз открыть ворота.");
			case 2: return server_error(playerid, "[Защита]: Вы не состоите в клане владельца базы.");
			}
			new Float: pos_xyzf[4];
			GetPlayerPos(playerid, pos_xyzf[0], pos_xyzf[1], pos_xyzf[2]);
			GetPlayerFacingAngle(playerid, pos_xyzf[3]);
			RemoveItem(playerid, itemid, quantity);
			GetXYBehindPoint(playerid, pos_xyzf[0], pos_xyzf[1], 2.0);
			addbox(playerid, 2, pos_xyzf[0], pos_xyzf[1], pos_xyzf[2]-1, pos_xyzf[3]);
			server_accept(playerid, "Нажмите H чтобы открыть ящик");
		}
	case 112:
		{
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы не должны находиться в транспортном средстве!");
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов!");
			for(new i = 1; i < MAX_VEHICLES; i++) 
			{	
				new Float: x, Float: y, Float: z;
				GetVehiclePos(i, x, y, z);
				if(IsPlayerInRangeOfPoint(playerid, 2.0, x, y, z)) 
				{
					switch(GetCarWheels(i))
					{
					case 0: return server_error(playerid, "На это т/с нельзя установить колесо.");
					}
					if(!TransportTires(i)) return server_error(playerid, "Все колеса уже установлены!");
					static Float: boot_pos[3], Float: bonnet_pos[3];
					GetCoordBootVehicle(i, boot_pos[0], boot_pos[1], boot_pos[2]);
					GetCoordBonnetVehicle(i, bonnet_pos[0], bonnet_pos[1], bonnet_pos[2]);
					if(IsPlayerInRangeOfPoint(playerid, 1.0, boot_pos[0], boot_pos[1], boot_pos[2]) && IsPlayerInRangeOfPoint(playerid, 1.0, bonnet_pos[0], bonnet_pos[1], bonnet_pos[2])) 
						return server_error(playerid, "Чтобы прикрутить колесо подойдите к месту колеса т/с!");
					switch(GetCarWheels(i))
					{
					case 2:
						{
							if(!CarInfo[i][car_tires][0]) CarInfo[i][car_tires][0] = 2;
							else if(!CarInfo[i][car_tires][1]) CarInfo[i][car_tires][1] = 2;
						}
					case 4:
						{
							if(!CarInfo[i][car_tires][0]) CarInfo[i][car_tires][0] = 2;
							else if(!CarInfo[i][car_tires][1]) CarInfo[i][car_tires][1] = 2;
							else if(!CarInfo[i][car_tires][2]) CarInfo[i][car_tires][2] = 2;
							else if(!CarInfo[i][car_tires][3]) CarInfo[i][car_tires][3] = 2;
						}
					}
					server_accept(playerid,"Вы установили Пробиток колесо.");
					RemoveItem(playerid, itemid, quantity);
					break;
				}
			}
		}
	case 113:
		{
			show_dialog(playerid, d_none, DIALOG_STYLE_MSGBOX, !"Инструкция", !"\
			В данной инструкции Вы сможете узнать как изготавливать определенные вещи.\n\
			Ниже приведены примеры изготовления вещей, если следовать примерам, то у вас получится изготовить определенную вещь.\n\n\
			{fffff0}Ткань {ffffff}+ {fffff0}Необработаное железо {ffffff}= {fffff0}Кевлар{ffffff}.\n\
			{fffff0}Любая одежда {ffffff}= {fffff0}Ткань{ffffff}.\n\
			{fffff0}Необработанное железо {ffffff}+ {fffff0}Необработанное железо {ffffff}= {fffff0}Запчасти{ffffff}.\n\
			{fffff0}Ткань {ffffff}+ {fffff0}Ткань {ffffff}= {fffff0}Случайная одежда{ffffff}.\n\
			{fffff0}Доски {ffffff}= {fffff0}Спички{ffffff}.\n\
			{fffff0}Ткань {ffffff}= {fffff0}Бинты{ffffff}.\n\
			{fffff0}Бинты {ffffff}+ {fffff0}Бинты {ffffff}= {fffff0}Ткань{ffffff}.\n\
			{fffff0}Сломанная циркулярка {ffffff}+ {fffff0}Необработаное железо {ffffff}= {fffff0}Целая циркулярка{ffffff}.\n\
			{fffff0}Железная пластина {ffffff}+ {fffff0}Необработаное железо {ffffff}= {fffff0}Циркулярка{ffffff}.\n\
			{fffff0}Аптечка {ffffff}+ {fffff0}Аптечка {ffffff}= {fffff0}Военная аптечка{ffffff}.\n\n\
			{cccccc}Издание за 03.05.1998", "Закрыть", "");
		}
			// {fffff0}Кевлар {ffffff}+ {fffff0}Сломанный бронежилет {ffffff}= {fffff0}целый Бронежилет{ffffff}.\n
	case 114: // Военная аптечка;
		{
			new Float: health;
			GetPlayerHealth(playerid, health);
			if(health > 95 && users[playerid][u_damage][0] != 1 && users[playerid][u_damage][1] != 1) return server_error(playerid, "Вам не требуется лечение.");
			GivePlayerHealth(playerid, 100.0);
			users[playerid][u_damage][0] = 0;
			users[playerid][u_damage][1] = 0;
			server_accept(playerid, "Вы использовали Военную аптечку.");
			RemoveItem(playerid, itemid, quantity);
		}
	/*case 118:
		{
			if(!GetItem(playerid, 125)) return server_error(playerid, "У вас нет железной пластины!");
			if(IsPlayerInAnyVehicle(playerid)) return server_error(playerid, "Вы не должны находиться в транспортном средстве!");
			if(IsPlayerInWater(playerid)) return server_error(playerid, "Вы Не должны находиться в воде!");
			if(!GetItem(playerid, 40)) return server_error(playerid, "У вас нет набора инструментов.");
			for(new i = 1; i < MAX_VEHICLES; i++) 
			{	
				new Float: x, Float: y, Float: z;
				GetVehiclePos(i, x, y, z);
				if(IsPlayerInRangeOfPoint(playerid, 4.0, x, y, z)) 
				{
					new chack_ = 0;
					for(new slots = 0; slots < car_slot; slots++)
					{
						if(CarInfo[i][car_protection][slots]) continue;
						chack_ = slots;
					}
					if(chack_ == 0) return server_error(playerid, "На автомобиле уже установлено максимальное кол-во брони.");
					car_object[playerid] = CreateDynamicObject(19844, x, y+2, z-0.5, 0.0, 0.0, 0.0);
					SetPVarInt(playerid, "CarID", i);
					SetPVarInt(playerid, "EditObjectToCar", 1);
					SetPVarInt(playerid, "ItemObjectCarID", itemid);
					SetPVarInt(playerid, "SetObjectCarID", 19844);
					SetPVarInt(playerid, "SetObjectCarQuantity", quantity);
					EditDynamicObject(playerid, car_object[playerid]);
					server_accept(playerid, "Отрегулируйте место положение пластины на автомобиле.");
					break;
				}
			}

		}*/
	case 125:
		{
			switch(random(3))
			{
			case 1:
				{
					server_message(playerid, "Вы выпили грязную воду.");
					// LoopingAnim(playerid,"FOOD","EAT_Burger", 4.1, 0, 1, 1, 1, 1);
					progress_bar(playerid, "BAR", "dnk_stndM_loop");
					GivePlayerHealth(playerid, (1.0 + random(4)));
					SetPlayerNeed(playerid, 0, random(30));
				}
			default: 
				{
					server_error(playerid, "Вы выпили грязную воду, получено отравление!");
					// LoopingAnim(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 1, 1, 1, 1);
					progress_bar(playerid, "FOOD", "EAT_Vomit_P", 6);
					RemovePlayerHealth(playerid, (1.3 + random(5)));
					SetPlayerNeed(playerid, 0, random(10));
				}
			}
			// GivePlayerHealth(playerid, 5.0);
			AddItem(playerid, 45, 1);
			RemoveItem(playerid, itemid, quantity);
		}
	}
	if(itemid == 34)//Пакет с кровью
	{
		if(GetPlayerNearPlayer(playerid) == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_RED," {ff0000}Поблизости никого нет");
		// ClearAnimLoop(playerid);
		// LoopingAnim(playerid,"CARRY","putdwn05", 4.1, 0, 1, 1, 1, 1);//перелить кровь
		progress_bar(playerid, "CARRY", "putdwn05");
		GivePlayerHealth(GetPlayerNearPlayer(playerid), 100);
		users[playerid][u_karma]++;
		SCMG(playerid, "Вы залили пакет крови игроку %s", users[GetPlayerNearPlayer(playerid)][u_name]);
		SCMG(GetPlayerNearPlayer(playerid), "%s залил Вам пакет крови", users[playerid][u_name]);
		RemoveItem(playerid, itemid, quantity);
		//printf("GetPlayerNearPlayer = %d",GetPlayerNearPlayer(playerid));
	}
	if(itemid == 36)//Болеутоляющие
	{
		if(GetPlayerDrunkLevel(playerid) == 0) return SendClientMessage(playerid,COLOR_GRAD," {ff0000}Вы не испытываете боль");
		SendClientMessage(playerid,COLOR_GRAD," {ffffff}Вы приняли Болеутоляющие");
		SetPlayerDrunkLevel(playerid, 0);
		RemoveItem(playerid, itemid, quantity);
	}
	if(itemid == 37)//Грелка
	{
		if(users[playerid][u_temperature] < 34) return SendClientMessage(playerid,COLOR_GRAD,"* Вам не требуется грелка");
		SendClientMessage(playerid,COLOR_GRAD," {ffffff}Температура сбита до 36.6");
		// ClearAnimLoop(playerid);
		// LoopingAnim(playerid,"CRIB","PED_Console_Loop", 4.1, 0, 1, 1, 1, 1);//грелка
		progress_bar(playerid, "CRIB", "PED_Console_Loop");
		users[playerid][u_temperature] = 36.6;
		RemoveItem(playerid, itemid, quantity);
	}
	if(itemid == 51)  {
		if(!temp[playerid][temp_use_map]) {
			TextDrawShowForPlayer(playerid, Mapen_S),temp[playerid][temp_use_map] = true;
			for(new i; i<sizeof(MapLine); i++) TextDrawShowForPlayer(playerid, MapLine[i]);
			for(new i; i<CountIcon; i++) TextDrawShowForPlayer(playerid, MapIcon[i]);
			SendClientMessage(playerid,0xFFFFFFFF,"Чтобы закрыть карту используйте её еще раз."); }
		else {
			TextDrawHideForPlayer(playerid, Mapen_S),temp[playerid][temp_use_map] = false;
			for(new i; i<sizeof(MapLine); i++) TextDrawHideForPlayer(playerid, MapLine[i]);
			for(new i; i<CountIcon; i++) TextDrawHideForPlayer(playerid, MapIcon[i]); } }
	if(itemid == 57) { }//Пустые банки
	if(itemid == 106) {
		SendClientMessage(playerid,COLOR_RED,"{ffffff}Вы взяли Детонатор"),ServerGivePlayerWeapon(playerid,40,1);
		RemoveItem(playerid, itemid, quantity);
	}
	if(itemid == 107) { }
	return 1; 
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch(weaponid)
	{
		case WEAPON_HEATSEEKER, WEAPON_FLAMETHROWER, WEAPON_MINIGUN: TKICK(playerid, "Вы использовали запрещенное оружие!");
	}
	new weapon, ammo;
	GetPlayerWeaponData(playerid, GetWeaponSlot(weaponid), weapon, ammo);
	if(protect_ammo[playerid][GetWeaponSlot(weaponid)] > ammo) protect_ammo[playerid][GetWeaponSlot(weaponid)] = ammo;
	protect_ammo[playerid][GetWeaponSlot(weaponid)]--;
	// protect_ammo[playerid][GetWeaponSlot(weaponid)]--;
	// SCMG(playerid, "protect_ammo[playerid]: %i, GetPlayerWeaponData: %i", protect_ammo[playerid][GetWeaponSlot(weaponid)], ammo);
    if(hittype == BULLET_HIT_TYPE_PLAYER && GetPVarInt(hitid, "AFK") > 1)
    {
		if(!admin[hitid][admin_level] && !admin[hitid][u_a_dostup])
		{
			users[hitid][u_newgame] = 1;	
			DropItems(hitid);
			SCMAF(COLOR_BROWN, "Игрок %s был кикнут сервером. Причина: AFK во время боя", users[hitid][u_name]);
			AddMessage(users[hitid][u_id], "Вы были в AFK во время боя, ваш лут утерен.");
			server_error(hitid, "Вы были кикнуты с сервера и все ваши вещи утеряны за AFK во время боя!");
			TKICK(hitid, "Вас кикнула система за АФК во время боя.");
		}
    }  
	/*if(hittype == BULLET_HIT_TYPE_OBJECT)
	{
		server_error(playerid, "++");
		for(new slots = 0; slots < car_slot; slots++)
		{
			if(CarInfo[hitid][car_protection][slots]) continue;
			// CarInfo[GetPVarInt(playerid, "CarID")][car_protection][slots];
			CarInfo[hitid][car_protection_quantity][slots] -= random(10);
			if(CarInfo[hitid][car_protection_quantity][slots] < 1)
			{
				CarInfo[hitid][car_protection][slots] = 0;
				CarInfo[hitid][car_protection_quantity][slots] = 0;
				DestroyDynamicObject(CarInfo[hitid][car_protection_object][slots]);
			}
			break;
		}
	}*/
	/*if(hittype == BULLET_HIT_TYPE_OBJECT)
	{
		new done_ = 0;
		for(new i = 1; i != MAX_VEHICLES; i++) // <
		{	
			server_error(playerid, "Поиск авто;");
			for(new z = 0; z < car_slot+1; z++)
			{ 
				server_error(playerid, "Поиск объекта на автомобиле;");
				if(!CarInfo[i][car_protection][z]) continue;
				server_error(playerid, "Объект найден;");
				if(CarInfo[i][car_protection_object][z] != hitid) continue;
				server_error(playerid, "Объект найден 2;");
				CarInfo[i][car_protection_quantity][z] -= random(10);
				server_error(playerid, "Вычитает хп;");
				if(CarInfo[i][car_protection_quantity][z] < 1)
				{
					server_error(playerid, "Броня в минус;");
					CarInfo[i][car_protection][z] = 0;
					CarInfo[i][car_protection_quantity][z] = 0;
					DestroyDynamicObject(CarInfo[i][car_protection_object][z]);
				}
				done_++;
			}
			if(done_) break;
		}
	}*/
	if(hittype == BULLET_HIT_TYPE_VEHICLE && hitid != INVALID_VEHICLE_ID)
	{
		static Float: get_car_health;
		GetVehicleHealth(hitid, get_car_health);
		SetVehicleHealth(hitid, get_car_health-random(5));
		GetAttackTrires(hitid);
	}
	if(hittype == BULLET_HIT_TYPE_PLAYER && hitid != INVALID_PLAYER_ID)
	{
		if(users[playerid][u_achievement][3] == 1) PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
		/*if(admin[hitid][admin_level] && admin[hitid][u_a_dostup]) return true;
		if(GetPVarInt(hitid, "AFK") > 1) return true;
		if(IsPlayerNPC(hitid)) return true;
		if(!AntiFlood(playerid, "AntiFloodGoodMode"))
		{
			static 
				Float: ac_health, 
				Float: ac_armour, 
				Float: count_health_and_armour;
			GetPlayerHealth(hitid, ac_health);
			GetPlayerArmour(hitid, ac_armour);
			count_health_and_armour = ac_health + ac_armour;
			if(count_health_and_armour < 0) count_health_and_armour = 0;
			SetTimerEx("@AntiGoodMode", 200, false, "if", hitid, count_health_and_armour);
		}*/
	}
    return true;
}
/*@AntiGoodMode(playerid, Float: value);
@AntiGoodMode(playerid, Float: value)
{  
	if(GetPlayerState(playerid) != 1) return true;
	if(admin[playerid][admin_level] && admin[playerid][u_a_dostup]) return true;
	if(GetPVarInt(playerid, "AFK") > 1) return true;
	static 
		Float: ac_health, 
		Float: ac_armour, 
		Float: count_health_and_armour;
	GetPlayerHealth(playerid, ac_health);
	GetPlayerArmour(playerid, ac_armour);
	count_health_and_armour = ac_health + ac_armour;
	if(count_health_and_armour < 0) count_health_and_armour = 0;
	if(floatround(count_health_and_armour) >= floatround(value))
	{
		AntiFlood(playerid, "AntiFloodGoodMode", 2);
		AdminChatF("[A]{F4A460}[Anti-Cheat]{ffffff} Игрок %s подозревается в использовании ГМ (Good Mode). {cccccc}(тест, возможно ложный)", users[playerid][u_name], playerid);
	}
	return true;
}*/
public OnRconLoginAttempt(ip[], password[], success)
{
	switch(success)
	{
	case 0, 1: 
		{
			new GetIP[16];
			foreach(Player, i)
			{
				GetPlayerIp(i, GetIP, sizeof(GetIP)); 
				if(!strcmp(ip, GetIP, true))
				{
					TKICK(i, "Ошибочка! Прощайте, возникли трудности с соединением!");
					break;
				}
			}
		}
	}
	return true;
}

CMD:test ( playerid )
{
	for ( new i = 0; i < sizeof ( stats__global ); i ++ )
	{
		SendClientMessage ( playerid, -1, "" );
		TextDrawShowForPlayer ( playerid, stats__global [ i ] );
	}
	
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 0 ], TranslateText ( "Игровой ник" ) );
	
	new ___ [ 60 ];
	
	format ( ___, sizeof ___, "%s", users [ playerid ] [ u_name ] );
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 1 ], TranslateText ( ___ ) );
	
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 2 ], TranslateText ( "Статус" ) );
	
	format ( ___, sizeof ___, "%s", ( admin [ playerid ] [ admin_level ] == 0 )?("Игрок"):("Админ") );
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 3 ], TranslateText ( ___ ) );
	
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 4 ], TranslateText ( "Батлпас" ) );
	
	format ( ___, sizeof ___, "Неактивен" );
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 5 ], TranslateText ( ___ ) );
	
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 6 ], TranslateText ( "Баланс" ) );
	
	format ( ___, sizeof ___, "%i", users [ playerid ] [ u_money ] );
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 7 ], ___ );
	
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 8 ], TranslateText ( "Ид_аккаунта" ) );
	
	format ( ___, sizeof ___, "#%i", users [ playerid ] [ u_id ] );
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 9 ], TranslateText ( ___ ) );
	
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 10 ], TranslateText ( "Рейтинг" ) );
	
	format ( ___, sizeof ___, "0" );
	PlayerTextDrawSetString ( playerid, stats__player [ playerid ] [ 11 ], TranslateText ( ___ ) );
	
	for ( new i = 0; i < 24; i ++ )
		PlayerTextDrawShow ( playerid, stats__player [ playerid ] [ i ] );
	
	
	SelectTextDraw ( playerid, 0xFFFFFF00 );
	
	/*for ( new i = 0; i < sizeof ( users_panel_td ); i ++ )
		TextDrawHideForPlayer ( playerid, users_panel_td [ i ] );
	
	TextDrawHideForPlayer(playerid, HideMap_TD[0]);
	TextDrawHideForPlayer(playerid, HideMap_TD[1]);
	
	for ( new i = 0; i < 9; i ++ )
		PlayerTextDrawHide ( playerid, users_panel_ptd [ playerid ] [ i ] );
	*/
	//users_panel_ptd
	return 1;
}

CMD:test_hide ( playerid )
{
	
	return 1;
}

//Модули:
#include 									"modules/core/commands_player.pwn"

#include 									"modules/core/commands_admin.pwn"
#include 									"modules/core/system_clan.pwn"
#include 									"modules/core/admins_functions.pwn"
#include 									"modules/core/functions.pwn"
#include									"modules/core/timers.pwn"
#include 									"modules/core/dialogs.pwn"
#include 									"modules/core/dialog.pwn" //NEW
#include 									"modules/core/publics.pwn"
#include 									"modules/maps/RemoveObject.pwn"

public OnGameModeInit()
{
	CA_Init();
	CreateMediksBox();
	CreateGlobalTextDraws();
	//==========================================================================
	GreenZone_Protect = CreateDynamicCircle(-2456.0, 2502.0, 90.0);
	GreenZone = GZ_ShapeCreate(CIRCLE, -2456.0, 2502.0, 90.0); // GreenZone;
	BLACKZONE = GangZoneCreate(-3000.0, -3000.0, 3000.0, 3000.0);//черная карта GPS
	actor[0] = CreateActor(128, -927.7538,2037.1860,60.9141,224.9287); // Актер в магазине
	actor[3] = CreateActor(159, -2518.2231,2513.0098,18.8129,269.9800); // Актер на greenzone Леша
	//==========================================================================
	for(new i = 0; i != MAX_PICKUP; i++)
	{
	    switch(i)
	    {
		case 0..1: CreateDynamicPickup(1274, 1, PickXYZ[i][0][0], PickXYZ[i][0][1], PickXYZ[i][0][2], PickWorld[i][0][0]); // Магазин на домбе ("$");
		}
		PickManager[i] = CreateDynamicSphere(PickXYZ[i][0][0], PickXYZ[i][0][1], PickXYZ[i][0][2], 1.0, PickWorld[i][0][0]);
	}
	#include "modules/maps/save1.pwn"
	#include "modules/maps/map.pwn"
	return false;
}

public OnGameModeExit() 
{
	GZ_ShapeDestroyAll();
	DestroyAllDynamicAreas();
	for(new ac = 0; ac < sizeof(actor); ac++) DestroyActor(actor[ac]);
	for(new m; m<sizeof(MapLine); m++) { TextDrawHideForAll(MapLine[m]),TextDrawDestroy(MapLine[m]); }
	for(new a; a<CountIcon; a++) { TextDrawHideForAll(MapIcon[a]),TextDrawDestroy(MapIcon[a]); }
	TextDrawHideForAll(ZVision),TextDrawDestroy(ZVision),TextDrawHideForAll(Mapen_S),TextDrawDestroy(Mapen_S);
	for(new a = 0; a < MAX_LOOT; a++) {
		if(LootInfo[a][LPos][0] != 0.0) { DestroyDynamicObject(LootInfo[a][LIndexObj]); } }
	return 1; 
}

stock SendClientMessageEx(playerid, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 12)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 12); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string
		#emit PUSH.C args
		#emit SYSREQ.C format

		SendClientMessage(playerid, color, string);

		#emit LCTRL 5
		#emit SCTRL 4
		#emit RETN
	}
	return SendClientMessage(playerid, color, str);
}