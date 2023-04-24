/*
    Описание: ТекстДравы;
    Автор: zummore;
*/
#if defined _textdraws_included
	#endinput
#endif
#define _textdraws_included

#define TD_COLOR_REGISTER_PANEL_1 0xA52A2AFF//-2147483393
#define TD_COLOR_REGISTER_PANEL_2 0x000000AA//-1523963137

#define TD_COLOR_THEME_BACKGROUND_0	0x222831FF//0x080403FF//0x312f30FF//707605247
#define TD_COLOR_THEME_BACKGROUND_1	0x393E46FF//0x150b09FF//0x7c7678FF//1397903615
#define TD_COLOR_THEME_TEXT	0xbebbbcFF//0x8a8584FF//0xbebbbcFF//-1347440641

new Text: PlayersInfo_TD,
	// Text: InfoPanel_TD[20],
	Text: LoadingPlayer_TD[3],
	Text: PanelReconAdmin_TD[15], 
	Text: Speedomitr_TD[13],
	Text: GPS_TD[6],
	Text: craft_pila_TD[13],
	Text: craft_stol_TD[12],
	Text: craft_pech_TD[14],
	Text: drop_items_TD,
	Text: progressbar_TD[2],
	Text:stats__global [ 24 ],
	Text: inventory_TD;

#define MAX_INV_TD		171
new 
	PlayerText: PanelReconAdmin_PTD[MAX_PLAYERS][2],
	// PlayerText: InfoPanel_PTD[MAX_PLAYERS][9],
	PlayerText: Speedomitr_PTD[MAX_PLAYERS][4],
	PlayerText: GPS_PTD[MAX_PLAYERS][1],
	PlayerText: craft_pila_PTD[MAX_PLAYERS][3],
	PlayerText: craft_stol_PTD[MAX_PLAYERS][3],
	PlayerText: craft_pech_PTD[MAX_PLAYERS][3],
	PlayerText: progressbar_PTD[MAX_PLAYERS][1],
	PlayerText:stats__player [ MAX_PLAYERS ] [ 22 ],
	PlayerText:regiser__menu[MAX_PLAYERS][13],
	PlayerText:inventory__TD [ MAX_PLAYERS ] [ MAX_INV_TD ];

stock DestroyTextDraws()
{
   	// for(new td = 0; td < 20; td++) TextDrawDestroy(Text: InfoPanel_TD[td]);
   	for(new td = 0; td < 3; td++) TextDrawDestroy(Text: LoadingPlayer_TD[td]);
   	for(new td = 0; td < 15; td++) TextDrawDestroy(Text: PanelReconAdmin_TD[td]);
   	for(new td = 0; td < 13; td++) TextDrawDestroy(Text: Speedomitr_TD[td]);
   	for(new td = 0; td < 6; td++) TextDrawDestroy(Text: GPS_TD[td]);
   	for(new td = 0; td < 13; td++) TextDrawDestroy(Text: craft_pila_TD[td]);
   	for(new td = 0; td < 12; td++) TextDrawDestroy(Text: craft_stol_TD[td]);
   	for(new td = 0; td < 14; td++) TextDrawDestroy(Text: craft_pech_TD[td]);
   	for(new td = 0; td < 2; td++) TextDrawDestroy(Text: progressbar_TD[td]);
   	TextDrawDestroy(Text: PlayersInfo_TD);
   	TextDrawDestroy(Text: drop_items_TD);
	return true;
}
stock DestroyPlayerTextDraws(playerid)
{
	// Распростроненные ТекстДравы:
   	// for(new td = 0; td < 20; td++) TextDrawHideForPlayer(playerid, Text: InfoPanel_TD[td]);
   	for(new td = 0; td < 3; td++) TextDrawHideForPlayer(playerid, Text: LoadingPlayer_TD[td]);
   	for(new td = 0; td < 15; td++) TextDrawHideForPlayer(playerid, Text: PanelReconAdmin_TD[td]);
   	for(new td = 0; td < 13; td++) TextDrawHideForPlayer(playerid, Text: Speedomitr_TD[td]);
   	for(new td = 0; td < 6; td++) TextDrawHideForPlayer(playerid, Text: GPS_TD[td]);
   	for(new td = 0; td < 13; td++) TextDrawHideForPlayer(playerid, Text: craft_pila_TD[td]);
   	for(new td = 0; td < 12; td++) TextDrawHideForPlayer(playerid, Text: craft_stol_TD[td]);
   	for(new td = 0; td < 14; td++) TextDrawHideForPlayer(playerid, Text: craft_pech_TD[td]);
   	for(new td = 0; td < 2; td++) TextDrawHideForPlayer(playerid, Text: progressbar_TD[td]);
   	TextDrawHideForPlayer(playerid, Text: PlayersInfo_TD);
   	TextDrawHideForPlayer(playerid, Text: drop_items_TD);
	
	if ( temp [ playerid ] [ inventory_open ] == true ) DestroyAllInventory ( playerid );
	//for(new td = 0; td < MAX_INV_TD; td++)  PlayerTextDrawDestroy(playerid, PlayerText: inventory__TD[playerid][td]);
	// Индивидуальные ТекстДравы:
	for(new ptd = 0; ptd < 2; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: PanelReconAdmin_PTD[playerid][ptd]);
	// for(new td = 0; td < 9; td++) PlayerTextDrawDestroy(playerid, PlayerText: InfoPanel_PTD[playerid][td]);
	for(new ptd = 0; ptd < 4; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: Speedomitr_PTD[playerid][ptd]);
	for(new ptd = 0; ptd < 3; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: craft_pila_PTD[playerid][ptd]);
	for(new ptd = 0; ptd < 3; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: craft_stol_PTD[playerid][ptd]);
	for(new ptd = 0; ptd < 3; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: craft_pech_PTD[playerid][ptd]);
	PlayerTextDrawDestroy(playerid, PlayerText: progressbar_PTD[playerid][0]);
	PlayerTextDrawDestroy(playerid, PlayerText: GPS_PTD[playerid][0]);
	return true;
}
stock CreateTextDraws()
{
	inventory_TD = TextDrawCreate(-1.000000, -4.000000, "mdl-8002:bg");
	TextDrawFont(inventory_TD, 4);
	TextDrawLetterSize(inventory_TD, 0.600000, 2.000000);
	TextDrawTextSize(inventory_TD, 645.000000, 457.000000);
	TextDrawSetOutline(inventory_TD, 1);
	TextDrawSetShadow(inventory_TD, 0);
	TextDrawAlignment(inventory_TD, 1);
	TextDrawColor(inventory_TD, -1);
	TextDrawBackgroundColor(inventory_TD, 255);
	TextDrawBoxColor(inventory_TD, 50);
	TextDrawUseBox(inventory_TD, 1);
	TextDrawSetProportional(inventory_TD, 1);
	TextDrawSetSelectable(inventory_TD, 0);

	//start_stat
	stats__global[0] = TextDrawCreate(0.000000, 0.000000, "mdl-8000:bg_uk");
	TextDrawFont(stats__global[0], 4);
	TextDrawLetterSize(stats__global[0], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[0], 640.500000, 448.500000);
	TextDrawSetOutline(stats__global[0], 1);
	TextDrawSetShadow(stats__global[0], 1);
	TextDrawAlignment(stats__global[0], 1);
	TextDrawColor(stats__global[0], -1);
	TextDrawBackgroundColor(stats__global[0], 255);
	TextDrawBoxColor(stats__global[0], 50);
	TextDrawUseBox(stats__global[0], 1);
	TextDrawSetProportional(stats__global[0], 1);
	TextDrawSetSelectable(stats__global[0], 0);

	stats__global[1] = TextDrawCreate(545.000000, 12.000000, "mdl-8000:button_close");
	TextDrawFont(stats__global[1], 4);
	TextDrawLetterSize(stats__global[1], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[1], 74.000000, 26.500000);
	TextDrawSetOutline(stats__global[1], 1);
	TextDrawSetShadow(stats__global[1], 0);
	TextDrawAlignment(stats__global[1], 1);
	TextDrawColor(stats__global[1], -1);
	TextDrawBackgroundColor(stats__global[1], 255);
	TextDrawBoxColor(stats__global[1], 50);
	TextDrawUseBox(stats__global[1], 1);
	TextDrawSetProportional(stats__global[1], 1);
	TextDrawSetSelectable(stats__global[1], 0);

	stats__global[2] = TextDrawCreate(466.000000, 12.000000, "mdl-8000:button_shop");
	TextDrawFont(stats__global[2], 4);
	TextDrawLetterSize(stats__global[2], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[2], 74.000000, 26.500000);
	TextDrawSetOutline(stats__global[2], 1);
	TextDrawSetShadow(stats__global[2], 0);
	TextDrawAlignment(stats__global[2], 1);
	TextDrawColor(stats__global[2], -1);
	TextDrawBackgroundColor(stats__global[2], 255);
	TextDrawBoxColor(stats__global[2], 50);
	TextDrawUseBox(stats__global[2], 1);
	TextDrawSetProportional(stats__global[2], 1);
	TextDrawSetSelectable(stats__global[2], 0);

	stats__global[3] = TextDrawCreate(22.000000, 69.000000, "mdl-8000:ygol");
	TextDrawFont(stats__global[3], 4);
	TextDrawLetterSize(stats__global[3], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[3], 195.000000, 107.500000);
	TextDrawSetOutline(stats__global[3], 1);
	TextDrawSetShadow(stats__global[3], 0);
	TextDrawAlignment(stats__global[3], 1);
	TextDrawColor(stats__global[3], -1);
	TextDrawBackgroundColor(stats__global[3], 255);
	TextDrawBoxColor(stats__global[3], 50);
	TextDrawUseBox(stats__global[3], 1);
	TextDrawSetProportional(stats__global[3], 1);
	TextDrawSetSelectable(stats__global[3], 0);

	stats__global[4] = TextDrawCreate(30.000000, 76.000000, "mdl-8000:curcle");
	TextDrawFont(stats__global[4], 4);
	TextDrawLetterSize(stats__global[4], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[4], 70.000000, 85.000000);
	TextDrawSetOutline(stats__global[4], 1);
	TextDrawSetShadow(stats__global[4], 0);
	TextDrawAlignment(stats__global[4], 1);
	TextDrawColor(stats__global[4], -1);
	TextDrawBackgroundColor(stats__global[4], 255);
	TextDrawBoxColor(stats__global[4], 50);
	TextDrawUseBox(stats__global[4], 1);
	TextDrawSetProportional(stats__global[4], 1);
	TextDrawSetSelectable(stats__global[4], 0);

	stats__global[5] = TextDrawCreate(66.000000, 105.000000, "Yrovenb");
	TextDrawFont(stats__global[5], 3);
	TextDrawLetterSize(stats__global[5], 0.400000, 1.000000);
	TextDrawTextSize(stats__global[5], 400.000000, 17.000000);
	TextDrawSetOutline(stats__global[5], 0);
	TextDrawSetShadow(stats__global[5], 0);
	TextDrawAlignment(stats__global[5], 2);
	TextDrawColor(stats__global[5], -1);
	TextDrawBackgroundColor(stats__global[5], 255);
	TextDrawBoxColor(stats__global[5], 50);
	TextDrawUseBox(stats__global[5], 0);
	TextDrawSetProportional(stats__global[5], 1);
	TextDrawSetSelectable(stats__global[5], 0);

	stats__global[6] = TextDrawCreate(66.000000, 126.000000, "99");
	TextDrawFont(stats__global[6], 3);
	TextDrawLetterSize(stats__global[6], 0.400000, 2.000000);
	TextDrawTextSize(stats__global[6], 400.000000, 17.000000);
	TextDrawSetOutline(stats__global[6], 0);
	TextDrawSetShadow(stats__global[6], 0);
	TextDrawAlignment(stats__global[6], 2);
	TextDrawColor(stats__global[6], -1);
	TextDrawBackgroundColor(stats__global[6], 255);
	TextDrawBoxColor(stats__global[6], 50);
	TextDrawUseBox(stats__global[6], 0);
	TextDrawSetProportional(stats__global[6], 1);
	TextDrawSetSelectable(stats__global[6], 0);

	stats__global[7] = TextDrawCreate(22.000000, 69.000000, "mdl-8000:ygol");
	TextDrawFont(stats__global[7], 4);
	TextDrawLetterSize(stats__global[7], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[7], 195.000000, 107.500000);
	TextDrawSetOutline(stats__global[7], 1);
	TextDrawSetShadow(stats__global[7], 0);
	TextDrawAlignment(stats__global[7], 1);
	TextDrawColor(stats__global[7], -1);
	TextDrawBackgroundColor(stats__global[7], 255);
	TextDrawBoxColor(stats__global[7], 50);
	TextDrawUseBox(stats__global[7], 1);
	TextDrawSetProportional(stats__global[7], 1);
	TextDrawSetSelectable(stats__global[7], 0);

	stats__global[8] = TextDrawCreate(223.000000, 69.000000, "mdl-8000:ygol_small");
	TextDrawFont(stats__global[8], 4);
	TextDrawLetterSize(stats__global[8], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[8], 93.500000, 51.500000);
	TextDrawSetOutline(stats__global[8], 1);
	TextDrawSetShadow(stats__global[8], 0);
	TextDrawAlignment(stats__global[8], 1);
	TextDrawColor(stats__global[8], -1);
	TextDrawBackgroundColor(stats__global[8], 255);
	TextDrawBoxColor(stats__global[8], 50);
	TextDrawUseBox(stats__global[8], 1);
	TextDrawSetProportional(stats__global[8], 1);
	TextDrawSetSelectable(stats__global[8], 0);

	stats__global[9] = TextDrawCreate(323.000000, 69.000000, "mdl-8000:ygol_small");
	TextDrawFont(stats__global[9], 4);
	TextDrawLetterSize(stats__global[9], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[9], 93.500000, 51.500000);
	TextDrawSetOutline(stats__global[9], 1);
	TextDrawSetShadow(stats__global[9], 0);
	TextDrawAlignment(stats__global[9], 1);
	TextDrawColor(stats__global[9], -1);
	TextDrawBackgroundColor(stats__global[9], 255);
	TextDrawBoxColor(stats__global[9], 50);
	TextDrawUseBox(stats__global[9], 1);
	TextDrawSetProportional(stats__global[9], 1);
	TextDrawSetSelectable(stats__global[9], 0);

	stats__global[10] = TextDrawCreate(423.000000, 69.000000, "mdl-8000:ygol_small");
	TextDrawFont(stats__global[10], 4);
	TextDrawLetterSize(stats__global[10], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[10], 93.500000, 51.500000);
	TextDrawSetOutline(stats__global[10], 1);
	TextDrawSetShadow(stats__global[10], 0);
	TextDrawAlignment(stats__global[10], 1);
	TextDrawColor(stats__global[10], -1);
	TextDrawBackgroundColor(stats__global[10], 255);
	TextDrawBoxColor(stats__global[10], 50);
	TextDrawUseBox(stats__global[10], 1);
	TextDrawSetProportional(stats__global[10], 1);
	TextDrawSetSelectable(stats__global[10], 0);

	stats__global[11] = TextDrawCreate(523.000000, 69.000000, "mdl-8000:ygol_small");
	TextDrawFont(stats__global[11], 4);
	TextDrawLetterSize(stats__global[11], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[11], 93.500000, 51.500000);
	TextDrawSetOutline(stats__global[11], 1);
	TextDrawSetShadow(stats__global[11], 0);
	TextDrawAlignment(stats__global[11], 1);
	TextDrawColor(stats__global[11], -1);
	TextDrawBackgroundColor(stats__global[11], 255);
	TextDrawBoxColor(stats__global[11], 50);
	TextDrawUseBox(stats__global[11], 1);
	TextDrawSetProportional(stats__global[11], 1);
	TextDrawSetSelectable(stats__global[11], 0);

	stats__global[12] = TextDrawCreate(523.000000, 127.000000, "mdl-8000:ygol_small");
	TextDrawFont(stats__global[12], 4);
	TextDrawLetterSize(stats__global[12], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[12], 93.500000, 51.500000);
	TextDrawSetOutline(stats__global[12], 1);
	TextDrawSetShadow(stats__global[12], 0);
	TextDrawAlignment(stats__global[12], 1);
	TextDrawColor(stats__global[12], -1);
	TextDrawBackgroundColor(stats__global[12], 255);
	TextDrawBoxColor(stats__global[12], 50);
	TextDrawUseBox(stats__global[12], 1);
	TextDrawSetProportional(stats__global[12], 1);
	TextDrawSetSelectable(stats__global[12], 0);

	stats__global[13] = TextDrawCreate(423.000000, 127.000000, "mdl-8000:ygol_small");
	TextDrawFont(stats__global[13], 4);
	TextDrawLetterSize(stats__global[13], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[13], 93.500000, 51.500000);
	TextDrawSetOutline(stats__global[13], 1);
	TextDrawSetShadow(stats__global[13], 0);
	TextDrawAlignment(stats__global[13], 1);
	TextDrawColor(stats__global[13], -1);
	TextDrawBackgroundColor(stats__global[13], 255);
	TextDrawBoxColor(stats__global[13], 50);
	TextDrawUseBox(stats__global[13], 1);
	TextDrawSetProportional(stats__global[13], 1);
	TextDrawSetSelectable(stats__global[13], 0);

	stats__global[14] = TextDrawCreate(323.000000, 127.000000, "mdl-8000:ygol_small");
	TextDrawFont(stats__global[14], 4);
	TextDrawLetterSize(stats__global[14], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[14], 93.500000, 51.500000);
	TextDrawSetOutline(stats__global[14], 1);
	TextDrawSetShadow(stats__global[14], 0);
	TextDrawAlignment(stats__global[14], 1);
	TextDrawColor(stats__global[14], -1);
	TextDrawBackgroundColor(stats__global[14], 255);
	TextDrawBoxColor(stats__global[14], 50);
	TextDrawUseBox(stats__global[14], 1);
	TextDrawSetProportional(stats__global[14], 1);
	TextDrawSetSelectable(stats__global[14], 0);

	stats__global[15] = TextDrawCreate(223.000000, 127.000000, "mdl-8000:ygol_small");
	TextDrawFont(stats__global[15], 4);
	TextDrawLetterSize(stats__global[15], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[15], 93.500000, 51.500000);
	TextDrawSetOutline(stats__global[15], 1);
	TextDrawSetShadow(stats__global[15], 0);
	TextDrawAlignment(stats__global[15], 1);
	TextDrawColor(stats__global[15], -1);
	TextDrawBackgroundColor(stats__global[15], 255);
	TextDrawBoxColor(stats__global[15], 50);
	TextDrawUseBox(stats__global[15], 1);
	TextDrawSetProportional(stats__global[15], 1);
	TextDrawSetSelectable(stats__global[15], 0);

	stats__global[16] = TextDrawCreate(229.000000, 80.000000, "mdl-8000:icon_bank");
	TextDrawFont(stats__global[16], 4);
	TextDrawLetterSize(stats__global[16], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[16], 22.500000, 28.500000);
	TextDrawSetOutline(stats__global[16], 1);
	TextDrawSetShadow(stats__global[16], 0);
	TextDrawAlignment(stats__global[16], 1);
	TextDrawColor(stats__global[16], -1);
	TextDrawBackgroundColor(stats__global[16], 255);
	TextDrawBoxColor(stats__global[16], 50);
	TextDrawUseBox(stats__global[16], 1);
	TextDrawSetProportional(stats__global[16], 1);
	TextDrawSetSelectable(stats__global[16], 0);

	stats__global[17] = TextDrawCreate(329.000000, 80.000000, "mdl-8000:icon_teg");
	TextDrawFont(stats__global[17], 4);
	TextDrawLetterSize(stats__global[17], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[17], 22.500000, 28.500000);
	TextDrawSetOutline(stats__global[17], 1);
	TextDrawSetShadow(stats__global[17], 0);
	TextDrawAlignment(stats__global[17], 1);
	TextDrawColor(stats__global[17], -1);
	TextDrawBackgroundColor(stats__global[17], 255);
	TextDrawBoxColor(stats__global[17], 50);
	TextDrawUseBox(stats__global[17], 1);
	TextDrawSetProportional(stats__global[17], 1);
	TextDrawSetSelectable(stats__global[17], 0);

	stats__global[18] = TextDrawCreate(429.000000, 80.000000, "mdl-8000:icon_star");
	TextDrawFont(stats__global[18], 4);
	TextDrawLetterSize(stats__global[18], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[18], 22.500000, 28.500000);
	TextDrawSetOutline(stats__global[18], 1);
	TextDrawSetShadow(stats__global[18], 0);
	TextDrawAlignment(stats__global[18], 1);
	TextDrawColor(stats__global[18], -1);
	TextDrawBackgroundColor(stats__global[18], 255);
	TextDrawBoxColor(stats__global[18], 50);
	TextDrawUseBox(stats__global[18], 1);
	TextDrawSetProportional(stats__global[18], 1);
	TextDrawSetSelectable(stats__global[18], 0);

	stats__global[19] = TextDrawCreate(529.000000, 80.000000, "mdl-8000:icon_flag");
	TextDrawFont(stats__global[19], 4);
	TextDrawLetterSize(stats__global[19], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[19], 22.500000, 28.500000);
	TextDrawSetOutline(stats__global[19], 1);
	TextDrawSetShadow(stats__global[19], 0);
	TextDrawAlignment(stats__global[19], 1);
	TextDrawColor(stats__global[19], -1);
	TextDrawBackgroundColor(stats__global[19], 255);
	TextDrawBoxColor(stats__global[19], 50);
	TextDrawUseBox(stats__global[19], 1);
	TextDrawSetProportional(stats__global[19], 1);
	TextDrawSetSelectable(stats__global[19], 0);

	stats__global[20] = TextDrawCreate(229.000000, 138.000000, "mdl-8000:icon_money");
	TextDrawFont(stats__global[20], 4);
	TextDrawLetterSize(stats__global[20], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[20], 22.500000, 28.500000);
	TextDrawSetOutline(stats__global[20], 1);
	TextDrawSetShadow(stats__global[20], 0);
	TextDrawAlignment(stats__global[20], 1);
	TextDrawColor(stats__global[20], -1);
	TextDrawBackgroundColor(stats__global[20], 255);
	TextDrawBoxColor(stats__global[20], 50);
	TextDrawUseBox(stats__global[20], 1);
	TextDrawSetProportional(stats__global[20], 1);
	TextDrawSetSelectable(stats__global[20], 0);

	stats__global[21] = TextDrawCreate(329.000000, 138.000000, "mdl-8000:icon_year");
	TextDrawFont(stats__global[21], 4);
	TextDrawLetterSize(stats__global[21], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[21], 22.500000, 28.500000);
	TextDrawSetOutline(stats__global[21], 1);
	TextDrawSetShadow(stats__global[21], 0);
	TextDrawAlignment(stats__global[21], 1);
	TextDrawColor(stats__global[21], -1);
	TextDrawBackgroundColor(stats__global[21], 255);
	TextDrawBoxColor(stats__global[21], 50);
	TextDrawUseBox(stats__global[21], 1);
	TextDrawSetProportional(stats__global[21], 1);
	TextDrawSetSelectable(stats__global[21], 0);

	stats__global[22] = TextDrawCreate(429.000000, 138.000000, "mdl-8000:icon_premium");
	TextDrawFont(stats__global[22], 4);
	TextDrawLetterSize(stats__global[22], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[22], 22.500000, 28.500000);
	TextDrawSetOutline(stats__global[22], 1);
	TextDrawSetShadow(stats__global[22], 0);
	TextDrawAlignment(stats__global[22], 1);
	TextDrawColor(stats__global[22], -1);
	TextDrawBackgroundColor(stats__global[22], 255);
	TextDrawBoxColor(stats__global[22], 50);
	TextDrawUseBox(stats__global[22], 1);
	TextDrawSetProportional(stats__global[22], 1);
	TextDrawSetSelectable(stats__global[22], 0);

	stats__global[23] = TextDrawCreate(529.000000, 138.000000, "mdl-8000:icon_rang");
	TextDrawFont(stats__global[23], 4);
	TextDrawLetterSize(stats__global[23], 0.600000, 2.000000);
	TextDrawTextSize(stats__global[23], 22.500000, 28.500000);
	TextDrawSetOutline(stats__global[23], 1);
	TextDrawSetShadow(stats__global[23], 0);
	TextDrawAlignment(stats__global[23], 1);
	TextDrawColor(stats__global[23], -1);
	TextDrawBackgroundColor(stats__global[23], 255);
	TextDrawBoxColor(stats__global[23], 50);
	TextDrawUseBox(stats__global[23], 1);
	TextDrawSetProportional(stats__global[23], 1);
	TextDrawSetSelectable(stats__global[23], 0);
	//end_stat
	
	
    LoadingPlayer_TD[0] = TextDrawCreate(0.000000, 0.000000, "LD_SPAC:white");
	TextDrawLetterSize(LoadingPlayer_TD[0], 0.000000, 0.000000);
	TextDrawTextSize(LoadingPlayer_TD[0],  640.000000, 448.000000);
	TextDrawAlignment(LoadingPlayer_TD[0], 1);
	TextDrawColor(LoadingPlayer_TD[0], 0x000000FF);
	TextDrawSetShadow(LoadingPlayer_TD[0], 0);
	TextDrawSetOutline(LoadingPlayer_TD[0], 0);
	TextDrawFont(LoadingPlayer_TD[0], 4);
	
	LoadingPlayer_TD[1] = TextDrawCreate(320.2018, 410.4986, "Loading...."); // пусто
	TextDrawLetterSize(LoadingPlayer_TD[1], 0.2050, 1.4216);
	TextDrawTextSize(LoadingPlayer_TD[1], 0.0000, 255.0000);
	TextDrawAlignment(LoadingPlayer_TD[1], 2);
	TextDrawColor(LoadingPlayer_TD[1], -1);
	TextDrawBackgroundColor(LoadingPlayer_TD[1], 255);
	TextDrawFont(LoadingPlayer_TD[1], 2);
	TextDrawSetProportional(LoadingPlayer_TD[1], 1);
	TextDrawSetShadow(LoadingPlayer_TD[1], 0);

	LoadingPlayer_TD[2] = TextDrawCreate(320.2018, 200.3858, "~r~You are dead"); // пусто
	TextDrawLetterSize(LoadingPlayer_TD[2], 0.2050, 1.4216);
	TextDrawTextSize(LoadingPlayer_TD[2], 0.0000, 255.0000);
	TextDrawAlignment(LoadingPlayer_TD[2], 2);
	TextDrawColor(LoadingPlayer_TD[2], -1);
	TextDrawBackgroundColor(LoadingPlayer_TD[2], 255);
	TextDrawFont(LoadingPlayer_TD[2], 2);
	TextDrawSetProportional(LoadingPlayer_TD[2], 1);
	TextDrawSetShadow(LoadingPlayer_TD[2], 0);

	PlayersInfo_TD = TextDrawCreate(320.2018, 428.7997, "_"); // пусто
	TextDrawLetterSize(PlayersInfo_TD, 0.2050, 1.4216);
	TextDrawTextSize(PlayersInfo_TD, 0.0000, 255.0000);
	TextDrawAlignment(PlayersInfo_TD, 2);
	TextDrawColor(PlayersInfo_TD, -1);
	TextDrawBackgroundColor(PlayersInfo_TD, 255);
	TextDrawFont(PlayersInfo_TD, 2);
	TextDrawSetProportional(PlayersInfo_TD, 1);
	TextDrawSetShadow(PlayersInfo_TD, 0);
	
	PanelReconAdmin_TD[0] = TextDrawCreate(636.2999, 342.0302, "Box"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[0], 0.0000, -20.7738);
	TextDrawTextSize(PanelReconAdmin_TD[0], 539.0800, 0.0000);
	TextDrawAlignment(PanelReconAdmin_TD[0], 1);
	TextDrawColor(PanelReconAdmin_TD[0], -1);
	TextDrawUseBox(PanelReconAdmin_TD[0], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[0], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[0], 255);
	TextDrawFont(PanelReconAdmin_TD[0], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[0], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[0], 0);

	PanelReconAdmin_TD[1] = TextDrawCreate(634.5664, 340.0232, "Box"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[1], 0.0000, -20.2998);
	TextDrawTextSize(PanelReconAdmin_TD[1], 540.8308, 0.0000);
	TextDrawAlignment(PanelReconAdmin_TD[1], 1);
	TextDrawColor(PanelReconAdmin_TD[1], -1);
	TextDrawUseBox(PanelReconAdmin_TD[1], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[1],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(PanelReconAdmin_TD[1], 255);
	TextDrawFont(PanelReconAdmin_TD[1], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[1], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[1], 0);

	PanelReconAdmin_TD[2] = TextDrawCreate(564.9691, 281.7691, "<BACK"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[2], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[2], 13.0000, 39.6697);
	TextDrawAlignment(PanelReconAdmin_TD[2], 2);
	TextDrawColor(PanelReconAdmin_TD[2], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[2], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[2], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[2], 255);
	TextDrawFont(PanelReconAdmin_TD[2], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[2], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[2], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[2], true);

	PanelReconAdmin_TD[3] = TextDrawCreate(609.9581, 281.7691, "NEXT>"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[3], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[3], 13.0000, 40.6697);
	TextDrawAlignment(PanelReconAdmin_TD[3], 2);
	TextDrawColor(PanelReconAdmin_TD[3], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[3], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[3], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[3], 255);
	TextDrawFont(PanelReconAdmin_TD[3], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[3], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[3], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[3], true);

	PanelReconAdmin_TD[4] = TextDrawCreate(564.9691, 262.3681, "BAN"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[4], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[4], 13.0000, 39.6697);
	TextDrawAlignment(PanelReconAdmin_TD[4], 2);
	TextDrawColor(PanelReconAdmin_TD[4], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[4], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[4], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[4], 255);
	TextDrawFont(PanelReconAdmin_TD[4], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[4], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[4], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[4], true);

	PanelReconAdmin_TD[5] = TextDrawCreate(609.9581, 262.2680, "IBAN"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[5], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[5], 13.0000, 40.6697);
	TextDrawAlignment(PanelReconAdmin_TD[5], 2);
	TextDrawColor(PanelReconAdmin_TD[5], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[5], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[5], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[5], 255);
	TextDrawFont(PanelReconAdmin_TD[5], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[5], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[5], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[5], true);

	PanelReconAdmin_TD[6] = TextDrawCreate(564.9691, 243.0668, "MUTE"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[6], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[6], 13.0000, 39.6697);
	TextDrawAlignment(PanelReconAdmin_TD[6], 2);
	TextDrawColor(PanelReconAdmin_TD[6], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[6], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[6], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[6], 255);
	TextDrawFont(PanelReconAdmin_TD[6], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[6], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[6], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[6], true);

	PanelReconAdmin_TD[7] = TextDrawCreate(609.9581, 243.1669, "KICK"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[7], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[7], 13.0000, 40.6697);
	TextDrawAlignment(PanelReconAdmin_TD[7], 2);
	TextDrawColor(PanelReconAdmin_TD[7], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[7], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[7], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[7], 255);
	TextDrawFont(PanelReconAdmin_TD[7], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[7], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[7], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[7], true);

	PanelReconAdmin_TD[8] = TextDrawCreate(564.9691, 223.7655, "STATS"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[8], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[8], 13.0000, 39.6697);
	TextDrawAlignment(PanelReconAdmin_TD[8], 2);
	TextDrawColor(PanelReconAdmin_TD[8], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[8], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[8], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[8], 255);
	TextDrawFont(PanelReconAdmin_TD[8], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[8], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[8], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[8], true);

	PanelReconAdmin_TD[9] = TextDrawCreate(609.9581, 223.7655, "SLAP"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[9], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[9], 13.0000, 40.6697);
	TextDrawAlignment(PanelReconAdmin_TD[9], 2);
	TextDrawColor(PanelReconAdmin_TD[9], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[9], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[9], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[9], 255);
	TextDrawFont(PanelReconAdmin_TD[9], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[9], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[9], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[9], true);

	PanelReconAdmin_TD[10] = TextDrawCreate(636.2993, 222.0964, "Box"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[10], 0.0000, -0.6456);
	TextDrawTextSize(PanelReconAdmin_TD[10], 540.0000, 0.0000);
	TextDrawAlignment(PanelReconAdmin_TD[10], 1);
	TextDrawColor(PanelReconAdmin_TD[10], -1);
	TextDrawUseBox(PanelReconAdmin_TD[10], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[10], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[10], 255);
	TextDrawFont(PanelReconAdmin_TD[10], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[10], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[10], 0);

	PanelReconAdmin_TD[11] = TextDrawCreate(543.3001, 172.3963, "Health:~n~Armour:~n~Speed:~n~Car_Health:~n~Weapon_(Ammo):"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[11], 0.1649, 0.9901);
	TextDrawAlignment(PanelReconAdmin_TD[11], 1);
	TextDrawColor(PanelReconAdmin_TD[11], -1330662401);
	TextDrawBackgroundColor(PanelReconAdmin_TD[11], 255);
	TextDrawFont(PanelReconAdmin_TD[11], 2);
	TextDrawSetProportional(PanelReconAdmin_TD[11], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[11], 0);

	PanelReconAdmin_TD[12] = TextDrawCreate(636.2993, 174.0937, "Box"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[12], 0.0000, -0.6456);
	TextDrawTextSize(PanelReconAdmin_TD[12], 540.0000, 0.0000);
	TextDrawAlignment(PanelReconAdmin_TD[12], 1);
	TextDrawColor(PanelReconAdmin_TD[12], -1);
	TextDrawUseBox(PanelReconAdmin_TD[12], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[12], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[12], 255);
	TextDrawFont(PanelReconAdmin_TD[12], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[12], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[12], 0);

	PanelReconAdmin_TD[13] = TextDrawCreate(587.6992, 301.0000, "UPDATE"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[13], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[13], 13.0000, 85.0000);
	TextDrawAlignment(PanelReconAdmin_TD[13], 2);
	TextDrawColor(PanelReconAdmin_TD[13], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[13], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[13], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[13], 255);
	TextDrawFont(PanelReconAdmin_TD[13], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[13], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[13], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[13], true);

	PanelReconAdmin_TD[14] = TextDrawCreate(587.6992, 320.6011, "EXIT"); // пусто
	TextDrawLetterSize(PanelReconAdmin_TD[14], 0.2655, 1.5542);
	TextDrawTextSize(PanelReconAdmin_TD[14], 13.0000, 85.0000);
	TextDrawAlignment(PanelReconAdmin_TD[14], 2);
	TextDrawColor(PanelReconAdmin_TD[14], -1330662401);
	TextDrawUseBox(PanelReconAdmin_TD[14], 1);
	TextDrawBoxColor(PanelReconAdmin_TD[14], 707604991);
	TextDrawBackgroundColor(PanelReconAdmin_TD[14], 255);
	TextDrawFont(PanelReconAdmin_TD[14], 1);
	TextDrawSetProportional(PanelReconAdmin_TD[14], 1);
	TextDrawSetShadow(PanelReconAdmin_TD[14], 0);
	TextDrawSetSelectable(PanelReconAdmin_TD[14], true);

	Speedomitr_TD[0] = TextDrawCreate(428.0000, 399.0000, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[0], 0.0000, 2.9448);
	TextDrawTextSize(Speedomitr_TD[0], 564.1992, 0.0000);
	TextDrawAlignment(Speedomitr_TD[0], 1);
	TextDrawColor(Speedomitr_TD[0], -1);
	TextDrawUseBox(Speedomitr_TD[0], 1);
	TextDrawBoxColor(Speedomitr_TD[0], 707604991);
	TextDrawBackgroundColor(Speedomitr_TD[0], 255);
	TextDrawFont(Speedomitr_TD[0], 1);
	TextDrawSetProportional(Speedomitr_TD[0], 1);
	TextDrawSetShadow(Speedomitr_TD[0], 0);

	Speedomitr_TD[1] = TextDrawCreate(428.8001, 399.0000, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[1], 0.0000, -0.2545);
	TextDrawTextSize(Speedomitr_TD[1], 563.1994, 0.0000);
	TextDrawAlignment(Speedomitr_TD[1], 1);
	TextDrawColor(Speedomitr_TD[1], -1);
	TextDrawUseBox(Speedomitr_TD[1], 1);
	TextDrawBoxColor(Speedomitr_TD[1],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(Speedomitr_TD[1], 255);
	TextDrawFont(Speedomitr_TD[1], 1);
	TextDrawSetProportional(Speedomitr_TD[1], 1);
	TextDrawSetShadow(Speedomitr_TD[1], 0);

	Speedomitr_TD[2] = TextDrawCreate(430.1997, 401.7998, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[2], 0.0000, 2.3069);
	TextDrawTextSize(Speedomitr_TD[2], 460.0000, 0.0000);
	TextDrawAlignment(Speedomitr_TD[2], 1);
	TextDrawColor(Speedomitr_TD[2], -1);
	TextDrawUseBox(Speedomitr_TD[2], 1);
	TextDrawBoxColor(Speedomitr_TD[2],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(Speedomitr_TD[2], 255);
	TextDrawFont(Speedomitr_TD[2], 1);
	TextDrawSetProportional(Speedomitr_TD[2], 1);
	TextDrawSetShadow(Speedomitr_TD[2], 0);

	Speedomitr_TD[3] = TextDrawCreate(445.0993, 415.2000, "KM/H"); // пусто
	TextDrawLetterSize(Speedomitr_TD[3], 0.1483, 0.8033);
	TextDrawAlignment(Speedomitr_TD[3], 2);
	TextDrawColor(Speedomitr_TD[3], -1061109505);
	TextDrawBackgroundColor(Speedomitr_TD[3], 255);
	TextDrawFont(Speedomitr_TD[3], 2);
	TextDrawSetProportional(Speedomitr_TD[3], 1);
	TextDrawSetShadow(Speedomitr_TD[3], 0);

	Speedomitr_TD[4] = TextDrawCreate(463.9996, 401.7998, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[4], 0.0000, 2.3069);
	TextDrawTextSize(Speedomitr_TD[4], 493.9996, 0.0000);
	TextDrawAlignment(Speedomitr_TD[4], 1);
	TextDrawColor(Speedomitr_TD[4], -1);
	TextDrawUseBox(Speedomitr_TD[4], 1);
	TextDrawBoxColor(Speedomitr_TD[4],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(Speedomitr_TD[4], 255);
	TextDrawFont(Speedomitr_TD[4], 1);
	TextDrawSetProportional(Speedomitr_TD[4], 1);
	TextDrawSetShadow(Speedomitr_TD[4], 0);

	Speedomitr_TD[5] = TextDrawCreate(479.3999, 415.1997, "fuel"); // пусто
	TextDrawLetterSize(Speedomitr_TD[5], 0.1483, 0.8033);
	TextDrawAlignment(Speedomitr_TD[5], 2);
	TextDrawColor(Speedomitr_TD[5], -1061109505);
	TextDrawBackgroundColor(Speedomitr_TD[5], 255);
	TextDrawFont(Speedomitr_TD[5], 2);
	TextDrawSetProportional(Speedomitr_TD[5], 1);
	TextDrawSetShadow(Speedomitr_TD[5], 0);

	Speedomitr_TD[6] = TextDrawCreate(497.7998, 401.7998, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[6], 0.0000, 2.3069);
	TextDrawTextSize(Speedomitr_TD[6], 527.8001, 0.0000);
	TextDrawAlignment(Speedomitr_TD[6], 1);
	TextDrawColor(Speedomitr_TD[6], -1);
	TextDrawUseBox(Speedomitr_TD[6], 1);
	TextDrawBoxColor(Speedomitr_TD[6],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(Speedomitr_TD[6], 255);
	TextDrawFont(Speedomitr_TD[6], 1);
	TextDrawSetProportional(Speedomitr_TD[6], 1);
	TextDrawSetShadow(Speedomitr_TD[6], 0);

	Speedomitr_TD[7] = TextDrawCreate(513.8001, 414.7998, "health"); // пусто
	TextDrawLetterSize(Speedomitr_TD[7], 0.1483, 0.8033);
	TextDrawAlignment(Speedomitr_TD[7], 2);
	TextDrawColor(Speedomitr_TD[7], -1061109505);
	TextDrawBackgroundColor(Speedomitr_TD[7], 255);
	TextDrawFont(Speedomitr_TD[7], 2);
	TextDrawSetProportional(Speedomitr_TD[7], 1);
	TextDrawSetShadow(Speedomitr_TD[7], 0);

	Speedomitr_TD[8] = TextDrawCreate(565.9335, 398.9295, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[8], 0.0000, 2.9311);
	TextDrawTextSize(Speedomitr_TD[8], 564.2192, 0.0000);
	TextDrawAlignment(Speedomitr_TD[8], 1);
	TextDrawColor(Speedomitr_TD[8], -1);
	TextDrawUseBox(Speedomitr_TD[8], 1);
	TextDrawBoxColor(Speedomitr_TD[8],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(Speedomitr_TD[8], 255);
	TextDrawFont(Speedomitr_TD[8], 1);
	TextDrawSetProportional(Speedomitr_TD[8], 1);
	TextDrawSetShadow(Speedomitr_TD[8], 0);

	Speedomitr_TD[9] = TextDrawCreate(427.8997, 398.6997, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[9], 0.0000, 2.9544);
	TextDrawTextSize(Speedomitr_TD[9], 426.2000, 0.0000);
	TextDrawAlignment(Speedomitr_TD[9], 1);
	TextDrawColor(Speedomitr_TD[9], -1);
	TextDrawUseBox(Speedomitr_TD[9], 1);
	TextDrawBoxColor(Speedomitr_TD[9],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(Speedomitr_TD[9], 255);
	TextDrawFont(Speedomitr_TD[9], 1);
	TextDrawSetProportional(Speedomitr_TD[9], 1);
	TextDrawSetShadow(Speedomitr_TD[9], 0);

	Speedomitr_TD[10] = TextDrawCreate(428.9999, 427.5850, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[10], 0.0000, -0.2416);
	TextDrawTextSize(Speedomitr_TD[10], 563.6857, 0.0000);
	TextDrawAlignment(Speedomitr_TD[10], 1);
	TextDrawColor(Speedomitr_TD[10], -1);
	TextDrawUseBox(Speedomitr_TD[10], 1);
	TextDrawBoxColor(Speedomitr_TD[10],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(Speedomitr_TD[10], 255);
	TextDrawFont(Speedomitr_TD[10], 1);
	TextDrawSetProportional(Speedomitr_TD[10], 1);
	TextDrawSetShadow(Speedomitr_TD[10], 0);

	Speedomitr_TD[11] = TextDrawCreate(532.0001, 401.7000, "Box"); // пусто
	TextDrawLetterSize(Speedomitr_TD[11], 0.0000, 2.3069);
	TextDrawTextSize(Speedomitr_TD[11], 562.0001, 0.0000);
	TextDrawAlignment(Speedomitr_TD[11], 1);
	TextDrawColor(Speedomitr_TD[11], -1);
	TextDrawUseBox(Speedomitr_TD[11], 1);
	TextDrawBoxColor(Speedomitr_TD[11],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(Speedomitr_TD[11], 255);
	TextDrawFont(Speedomitr_TD[11], 1);
	TextDrawSetProportional(Speedomitr_TD[11], 1);
	TextDrawSetShadow(Speedomitr_TD[11], 0);

	Speedomitr_TD[12] = TextDrawCreate(547.9002, 414.8999, "mileage"); // пусто
	TextDrawLetterSize(Speedomitr_TD[12], 0.1483, 0.8033);
	TextDrawAlignment(Speedomitr_TD[12], 2);
	TextDrawColor(Speedomitr_TD[12], -1061109505);
	TextDrawBackgroundColor(Speedomitr_TD[12], 255);
	TextDrawFont(Speedomitr_TD[12], 2);
	TextDrawSetProportional(Speedomitr_TD[12], 1);
	TextDrawSetShadow(Speedomitr_TD[12], 0);

	GPS_TD[0] = TextDrawCreate(19.1665, 425.3226, "ld_beat:chit"); // пусто
	TextDrawLetterSize(GPS_TD[0], 0.0000, 0.0082);
	TextDrawTextSize(GPS_TD[0], 19.0000, 22.9298);
	TextDrawAlignment(GPS_TD[0], 1);
	TextDrawColor(GPS_TD[0],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(GPS_TD[0], 255);
	TextDrawFont(GPS_TD[0], 4);
	TextDrawSetProportional(GPS_TD[0], 0);
	TextDrawSetShadow(GPS_TD[0], 0);

	GPS_TD[1] = TextDrawCreate(27.8666, 428.9707, "LD_SPAC:white"); // пусто
	TextDrawLetterSize(GPS_TD[1], 0.0000, 0.0082);
	TextDrawTextSize(GPS_TD[1], 86.0000, 15.3198);
	TextDrawAlignment(GPS_TD[1], 1);
	TextDrawColor(GPS_TD[1],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(GPS_TD[1], 255);
	TextDrawFont(GPS_TD[1], 4);
	TextDrawSetProportional(GPS_TD[1], 0);
	TextDrawSetShadow(GPS_TD[1], 0);

	GPS_TD[2] = TextDrawCreate(104.7655, 425.1224, "ld_beat:chit"); // пусто
	TextDrawLetterSize(GPS_TD[2], 0.0000, 0.0082);
	TextDrawTextSize(GPS_TD[2], 19.0000, 23.1998);
	TextDrawAlignment(GPS_TD[2], 1);
	TextDrawColor(GPS_TD[2],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(GPS_TD[2], 255);
	TextDrawFont(GPS_TD[2], 4);
	TextDrawSetProportional(GPS_TD[2], 0);
	TextDrawSetShadow(GPS_TD[2], 0);

	GPS_TD[3] = TextDrawCreate(20.1665, 426.6226, "ld_beat:chit"); // пусто
	TextDrawLetterSize(GPS_TD[3], 0.0000, 0.0082);
	TextDrawTextSize(GPS_TD[3], 17.6999, 20.1200);
	TextDrawAlignment(GPS_TD[3], 1);
	TextDrawColor(GPS_TD[3],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(GPS_TD[3], 255);
	TextDrawFont(GPS_TD[3], 4);
	TextDrawSetProportional(GPS_TD[3], 0);
	TextDrawSetShadow(GPS_TD[3], 0);

	GPS_TD[4] = TextDrawCreate(27.8666, 430.0707, "LD_SPAC:white"); // пусто
	TextDrawLetterSize(GPS_TD[4], 0.0000, 0.0082);
	TextDrawTextSize(GPS_TD[4], 86.0000, 13.0898);
	TextDrawAlignment(GPS_TD[4], 1);
	TextDrawColor(GPS_TD[4],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(GPS_TD[4], 255);
	TextDrawFont(GPS_TD[4], 4);
	TextDrawSetProportional(GPS_TD[4], 0);
	TextDrawSetShadow(GPS_TD[4], 0);

	GPS_TD[5] = TextDrawCreate(105.0654, 426.6226, "ld_beat:chit"); // пусто
	TextDrawLetterSize(GPS_TD[5], 0.0000, 0.0082);
	TextDrawTextSize(GPS_TD[5], 17.6999, 20.1200);
	TextDrawAlignment(GPS_TD[5], 1);
	TextDrawColor(GPS_TD[5],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(GPS_TD[5], 255);
	TextDrawFont(GPS_TD[5], 4);
	TextDrawSetProportional(GPS_TD[5], 0);
	TextDrawSetShadow(GPS_TD[5], 0);

	craft_pila_TD[0] = TextDrawCreate(362.0000, 192.0000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pila_TD[0], 117.3898, 91.6493);
	TextDrawAlignment(craft_pila_TD[0], 1);
	TextDrawColor(craft_pila_TD[0],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pila_TD[0], 255);
	TextDrawFont(craft_pila_TD[0], 4);
	TextDrawSetProportional(craft_pila_TD[0], 0);
	TextDrawSetShadow(craft_pila_TD[0], 0);

	craft_pila_TD[1] = TextDrawCreate(363.2000, 193.6000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pila_TD[1], 115.0000, 88.4400);
	TextDrawAlignment(craft_pila_TD[1], 1);
	TextDrawColor(craft_pila_TD[1],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pila_TD[1], 255);
	TextDrawFont(craft_pila_TD[1], 4);
	TextDrawSetProportional(craft_pila_TD[1], 0);
	TextDrawSetShadow(craft_pila_TD[1], 0);

	craft_pila_TD[2] = TextDrawCreate(350.5002, 165.1000, ""); // пусто
	TextDrawTextSize(craft_pila_TD[2], 140.0000, 122.0000);
	TextDrawAlignment(craft_pila_TD[2], 1);
	TextDrawColor(craft_pila_TD[2], -1);
	TextDrawFont(craft_pila_TD[2], 5);
	TextDrawSetProportional(craft_pila_TD[2], 0);
    TextDrawBackgroundColor(craft_pila_TD[2], 0x00000000);
	TextDrawSetShadow(craft_pila_TD[2], 0);
	TextDrawSetPreviewModel(craft_pila_TD[2], 937);
	TextDrawSetPreviewRot(craft_pila_TD[2], -90.0000, 0.0000, 0.0000, 1.0000);

	craft_pila_TD[3] = TextDrawCreate(368.0000, 209.0000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pila_TD[3], 30.0000, 36.0000);
	TextDrawAlignment(craft_pila_TD[3], 1);
	TextDrawColor(craft_pila_TD[3],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pila_TD[3], 255);
	TextDrawFont(craft_pila_TD[3], 4);
	TextDrawSetProportional(craft_pila_TD[3], 0);
	TextDrawSetShadow(craft_pila_TD[3], 0);

	craft_pila_TD[4] = TextDrawCreate(368.8999, 209.8999, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pila_TD[4], 28.0000, 33.6898);
	TextDrawAlignment(craft_pila_TD[4], 1);
	TextDrawColor(craft_pila_TD[4],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pila_TD[4], 255);
	TextDrawFont(craft_pila_TD[4], 4);
	TextDrawSetProportional(craft_pila_TD[4], 0);
	TextDrawSetShadow(craft_pila_TD[4], 0);

	craft_pila_TD[5] = TextDrawCreate(440.4043, 209.0000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pila_TD[5], 30.0000, 36.0000);
	TextDrawAlignment(craft_pila_TD[5], 1);
	TextDrawColor(craft_pila_TD[5],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pila_TD[5], 255);
	TextDrawFont(craft_pila_TD[5], 4);
	TextDrawSetProportional(craft_pila_TD[5], 0);
	TextDrawSetShadow(craft_pila_TD[5], 0);

	craft_pila_TD[6] = TextDrawCreate(441.6044, 209.8999, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pila_TD[6], 28.0000, 34.0000);
	TextDrawAlignment(craft_pila_TD[6], 1);
	TextDrawColor(craft_pila_TD[6],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pila_TD[6], 255);
	TextDrawFont(craft_pila_TD[6], 4);
	TextDrawSetProportional(craft_pila_TD[6], 0);
	TextDrawSetShadow(craft_pila_TD[6], 0);

	craft_pila_TD[7] = TextDrawCreate(372.8999, 230.6999, "Use"); // пусто
	TextDrawLetterSize(craft_pila_TD[7], 0.2716, 1.4340);
	TextDrawTextSize(craft_pila_TD[7], 392.8999, 10.0000);
	TextDrawAlignment(craft_pila_TD[7], 1);
	TextDrawColor(craft_pila_TD[7],TD_COLOR_THEME_TEXT);
	TextDrawUseBox(craft_pila_TD[7], 1);
	TextDrawBoxColor(craft_pila_TD[7], 0);
	TextDrawBackgroundColor(craft_pila_TD[7], 255);
	TextDrawFont(craft_pila_TD[7], 2);
	TextDrawSetProportional(craft_pila_TD[7], 1);
	TextDrawSetShadow(craft_pila_TD[7], 0);
	TextDrawSetSelectable(craft_pila_TD[7], true);

	craft_pila_TD[8] = TextDrawCreate(445.5043, 230.6999, "Use"); // пусто
	TextDrawLetterSize(craft_pila_TD[8], 0.2716, 1.4340);
	TextDrawTextSize(craft_pila_TD[8], 465.5043, 10.0000);
	TextDrawAlignment(craft_pila_TD[8], 1);
	TextDrawColor(craft_pila_TD[8],TD_COLOR_THEME_TEXT);
	TextDrawUseBox(craft_pila_TD[8], 1);
	TextDrawBoxColor(craft_pila_TD[8], 0);
	TextDrawBackgroundColor(craft_pila_TD[8], 255);
	TextDrawFont(craft_pila_TD[8], 2);
	TextDrawSetProportional(craft_pila_TD[8], 1);
	TextDrawSetShadow(craft_pila_TD[8], 0);
	TextDrawSetSelectable(craft_pila_TD[8], true);

	craft_pila_TD[9] = TextDrawCreate(365.0000, 260.0000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pila_TD[9], 111.5699, 20.0000);
	TextDrawAlignment(craft_pila_TD[9], 1);
	TextDrawColor(craft_pila_TD[9],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pila_TD[9], 255);
	TextDrawFont(craft_pila_TD[9], 4);
	TextDrawSetProportional(craft_pila_TD[9], 0);
	TextDrawSetShadow(craft_pila_TD[9], 0);

	craft_pila_TD[10] = TextDrawCreate(366.2999, 261.6000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pila_TD[10], 109.0193, 16.6699);
	TextDrawAlignment(craft_pila_TD[10], 1);
	TextDrawColor(craft_pila_TD[10],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pila_TD[10], 255);
	TextDrawFont(craft_pila_TD[10], 4);
	TextDrawSetProportional(craft_pila_TD[10], 0);
	TextDrawSetShadow(craft_pila_TD[10], 0);

	craft_pila_TD[11] = TextDrawCreate(370.0000, 207.0000, "_"); // пусто
	TextDrawTextSize(craft_pila_TD[11], 26.0000, 33.0000);
	TextDrawAlignment(craft_pila_TD[11], 1);
	TextDrawColor(craft_pila_TD[11], -1);
	TextDrawFont(craft_pila_TD[11], 5);
	TextDrawSetProportional(craft_pila_TD[11], 0);
	TextDrawSetShadow(craft_pila_TD[11], 0);
    TextDrawBackgroundColor(craft_pila_TD[11], 0x00000000);
	TextDrawSetPreviewModel(craft_pila_TD[11], 1961);
	TextDrawSetPreviewRot(craft_pila_TD[11], 0.0000, 0.0000, 0.0000, 1.0000);

	craft_pila_TD[12] = TextDrawCreate(432.0000, 199.0000, "_"); // пусто
	TextDrawTextSize(craft_pila_TD[12], 44.0000, 44.0000);
	TextDrawAlignment(craft_pila_TD[12], 1);
	TextDrawColor(craft_pila_TD[12], -1);
	TextDrawFont(craft_pila_TD[12], 5);
	TextDrawSetProportional(craft_pila_TD[12], 0);
	TextDrawSetShadow(craft_pila_TD[12], 0);
    TextDrawBackgroundColor(craft_pila_TD[12], 0x00000000);
	TextDrawSetPreviewModel(craft_pila_TD[12], 14872);
	TextDrawSetPreviewRot(craft_pila_TD[12], 0.0000, 0.0000, 0.0000, 1.0000);

	craft_stol_TD[0] = TextDrawCreate(386.2000, 190.6999, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_stol_TD[0], 119.6196, 89.2201);
	TextDrawAlignment(craft_stol_TD[0], 1);
	TextDrawColor(craft_stol_TD[0],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_stol_TD[0], 255);
	TextDrawFont(craft_stol_TD[0], 4);
	TextDrawSetProportional(craft_stol_TD[0], 0);
	TextDrawSetShadow(craft_stol_TD[0], 0);

	craft_stol_TD[1] = TextDrawCreate(387.3999, 192.1000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_stol_TD[1], 117.0196, 86.0000);
	TextDrawAlignment(craft_stol_TD[1], 1);
	TextDrawColor(craft_stol_TD[1],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_stol_TD[1], 255);
	TextDrawFont(craft_stol_TD[1], 4);
	TextDrawSetProportional(craft_stol_TD[1], 0);
	TextDrawSetShadow(craft_stol_TD[1], 0);

	craft_stol_TD[2] = TextDrawCreate(374.7995, 164.1994, ""); // пусто
	TextDrawTextSize(craft_stol_TD[2], 142.0000, 119.0000);
	TextDrawAlignment(craft_stol_TD[2], 1);
	TextDrawColor(craft_stol_TD[2], -1);
	TextDrawFont(craft_stol_TD[2], 5);
	TextDrawSetProportional(craft_stol_TD[2], 0);
    TextDrawBackgroundColor(craft_stol_TD[2], 0x00000000);
	TextDrawSetShadow(craft_stol_TD[2], 0);
	TextDrawSetPreviewModel(craft_stol_TD[2], 937);
	TextDrawSetPreviewRot(craft_stol_TD[2], -90.0000, 0.0000, 0.0000, 1.0000);

	craft_stol_TD[3] = TextDrawCreate(391.0000, 208.1006, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_stol_TD[3], 28.0000, 29.0000);
	TextDrawAlignment(craft_stol_TD[3], 1);
	TextDrawColor(craft_stol_TD[3],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_stol_TD[3], 255);
	TextDrawFont(craft_stol_TD[3], 4);
	TextDrawSetProportional(craft_stol_TD[3], 0);
	TextDrawSetShadow(craft_stol_TD[3], 0);

	craft_stol_TD[4] = TextDrawCreate(391.8999, 209.3007, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_stol_TD[4], 25.9498, 26.5898);
	TextDrawAlignment(craft_stol_TD[4], 1);
	TextDrawColor(craft_stol_TD[4],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_stol_TD[4], 255);
	TextDrawFont(craft_stol_TD[4], 4);
	TextDrawSetProportional(craft_stol_TD[4], 0);
	TextDrawSetShadow(craft_stol_TD[4], 0);

	craft_stol_TD[5] = TextDrawCreate(421.6018, 208.1006, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_stol_TD[5], 28.0000, 29.0000);
	TextDrawAlignment(craft_stol_TD[5], 1);
	TextDrawColor(craft_stol_TD[5],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_stol_TD[5], 255);
	TextDrawFont(craft_stol_TD[5], 4);
	TextDrawSetProportional(craft_stol_TD[5], 0);
	TextDrawSetShadow(craft_stol_TD[5], 0);

	craft_stol_TD[6] = TextDrawCreate(422.5018, 209.3007, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_stol_TD[6], 25.9498, 26.5898);
	TextDrawAlignment(craft_stol_TD[6], 1);
	TextDrawColor(craft_stol_TD[6],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_stol_TD[6], 255);
	TextDrawFont(craft_stol_TD[6], 4);
	TextDrawSetProportional(craft_stol_TD[6], 0);
	TextDrawSetShadow(craft_stol_TD[6], 0);

	craft_stol_TD[7] = TextDrawCreate(404.7007, 224.4002, "Use"); // пусто
	TextDrawLetterSize(craft_stol_TD[7], 0.2343, 1.2929);
	TextDrawTextSize(craft_stol_TD[7], 10.0000, 22.0000);
	TextDrawAlignment(craft_stol_TD[7], 2);
	TextDrawColor(craft_stol_TD[7],TD_COLOR_THEME_TEXT);
	TextDrawUseBox(craft_stol_TD[7], 1);
	TextDrawBoxColor(craft_stol_TD[7], 0);
	TextDrawBackgroundColor(craft_stol_TD[7], 255);
	TextDrawFont(craft_stol_TD[7], 2);
	TextDrawSetProportional(craft_stol_TD[7], 1);
	TextDrawSetShadow(craft_stol_TD[7], 0);
	TextDrawSetSelectable(craft_stol_TD[7], true);

	craft_stol_TD[8] = TextDrawCreate(436.1026, 224.4002, "Use"); // пусто
	TextDrawLetterSize(craft_stol_TD[8], 0.2343, 1.2929);
	TextDrawTextSize(craft_stol_TD[8], 10.0000, 22.0000);
	TextDrawAlignment(craft_stol_TD[8], 2);
	TextDrawColor(craft_stol_TD[8],TD_COLOR_THEME_TEXT);
	TextDrawUseBox(craft_stol_TD[8], 1);
	TextDrawBoxColor(craft_stol_TD[8], 0);
	TextDrawBackgroundColor(craft_stol_TD[8], 255);
	TextDrawFont(craft_stol_TD[8], 2);
	TextDrawSetProportional(craft_stol_TD[8], 1);
	TextDrawSetShadow(craft_stol_TD[8], 0);
	TextDrawSetSelectable(craft_stol_TD[8], true);

	craft_stol_TD[9] = TextDrawCreate(448.0000, 206.1000, ""); // пусто
	TextDrawTextSize(craft_stol_TD[9], 57.0000, 66.0000);
	TextDrawAlignment(craft_stol_TD[9], 1);
	TextDrawColor(craft_stol_TD[9], -1);
	TextDrawFont(craft_stol_TD[9], 5);
	TextDrawSetProportional(craft_stol_TD[9], 0);
	TextDrawSetShadow(craft_stol_TD[9], 0);
    TextDrawBackgroundColor(craft_stol_TD[9], 0x00000000);
	TextDrawSetPreviewModel(craft_stol_TD[9], 19921);
	TextDrawSetPreviewRot(craft_stol_TD[9], 90.0000, 0.0000, 0.0000, 1.0000);

	craft_stol_TD[10] = TextDrawCreate(389.0000, 258.0000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_stol_TD[10], 113.7698, 18.0000);
	TextDrawAlignment(craft_stol_TD[10], 1);
	TextDrawColor(craft_stol_TD[10],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_stol_TD[10], 255);
	TextDrawFont(craft_stol_TD[10], 4);
	TextDrawSetProportional(craft_stol_TD[10], 0);
	TextDrawSetShadow(craft_stol_TD[10], 0);

	craft_stol_TD[11] = TextDrawCreate(390.0000, 259.0997, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_stol_TD[11], 112.0000, 15.5300);
	TextDrawAlignment(craft_stol_TD[11], 1);
	TextDrawColor(craft_stol_TD[11],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_stol_TD[11], 255);
	TextDrawFont(craft_stol_TD[11], 4);
	TextDrawSetProportional(craft_stol_TD[11], 0);
	TextDrawSetShadow(craft_stol_TD[11], 0);

	craft_pech_TD[0] = TextDrawCreate(379.0997, 184.3518, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[0], 128.0000, 88.0000);
	TextDrawAlignment(craft_pech_TD[0], 1);
	TextDrawColor(craft_pech_TD[0],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pech_TD[0], 255);
	TextDrawFont(craft_pech_TD[0], 4);
	TextDrawSetProportional(craft_pech_TD[0], 0);
	TextDrawSetShadow(craft_pech_TD[0], 0);

	craft_pech_TD[1] = TextDrawCreate(380.6997, 186.5518, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[1], 124.9497, 83.5196);
	TextDrawAlignment(craft_pech_TD[1], 1);
	TextDrawColor(craft_pech_TD[1],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pech_TD[1], 255);
	TextDrawFont(craft_pech_TD[1], 4);
	TextDrawSetProportional(craft_pech_TD[1], 0);
	TextDrawSetShadow(craft_pech_TD[1], 0);

	craft_pech_TD[2] = TextDrawCreate(364.3330, 141.7256, ""); // пусто
	TextDrawTextSize(craft_pech_TD[2], 154.0000, 156.0000);
	TextDrawAlignment(craft_pech_TD[2], 1);
	TextDrawColor(craft_pech_TD[2], -1);
	TextDrawFont(craft_pech_TD[2], 5);
	TextDrawSetProportional(craft_pech_TD[2], 0);
    TextDrawBackgroundColor(craft_pech_TD[2], 0x00000000);
	TextDrawSetShadow(craft_pech_TD[2], 0);
	TextDrawSetPreviewModel(craft_pech_TD[2], 943);
	TextDrawSetPreviewRot(craft_pech_TD[2], 0.0000, 0.0000, 90.0000, 1.0000);

	craft_pech_TD[3] = TextDrawCreate(389.3334, 209.7554, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[3], 31.0000, 32.1099);
	TextDrawAlignment(craft_pech_TD[3], 1);
	TextDrawColor(craft_pech_TD[3],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pech_TD[3], 255);
	TextDrawFont(craft_pech_TD[3], 4);
	TextDrawSetProportional(craft_pech_TD[3], 0);
	TextDrawSetShadow(craft_pech_TD[3], 0);

	craft_pech_TD[4] = TextDrawCreate(390.2333, 210.8556, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[4], 29.0000, 30.0000);
	TextDrawAlignment(craft_pech_TD[4], 1);
	TextDrawColor(craft_pech_TD[4],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pech_TD[4], 255);
	TextDrawFont(craft_pech_TD[4], 4);
	TextDrawSetProportional(craft_pech_TD[4], 0);
	TextDrawSetShadow(craft_pech_TD[4], 0);

	craft_pech_TD[5] = TextDrawCreate(389.6665, 198.9703, ""); // пусто
	TextDrawTextSize(craft_pech_TD[5], 30.0000, 31.0000);
	TextDrawAlignment(craft_pech_TD[5], 1);
	TextDrawColor(craft_pech_TD[5], -1);
	TextDrawFont(craft_pech_TD[5], 5);
	TextDrawSetProportional(craft_pech_TD[5], 0);
	TextDrawSetShadow(craft_pech_TD[5], 0);
    TextDrawBackgroundColor(craft_pech_TD[5], 0x00000000);
	TextDrawSetPreviewModel(craft_pech_TD[5], 19918);
	TextDrawSetPreviewRot(craft_pech_TD[5], 90.0000, 180.0000, 0.0000, 1.0000);

	craft_pech_TD[6] = TextDrawCreate(405.4674, 229.2480, "use"); // пусто
	TextDrawLetterSize(craft_pech_TD[6], 0.2450, 1.2681);
	TextDrawTextSize(craft_pech_TD[6], 10.0000, 22.0000);
	TextDrawAlignment(craft_pech_TD[6], 2);
	TextDrawColor(craft_pech_TD[6],TD_COLOR_THEME_TEXT);
	TextDrawUseBox(craft_pech_TD[6], 1);
	TextDrawBoxColor(craft_pech_TD[6], 0);
	TextDrawBackgroundColor(craft_pech_TD[6], 255);
	TextDrawFont(craft_pech_TD[6], 2);
	TextDrawSetProportional(craft_pech_TD[6], 1);
	TextDrawSetShadow(craft_pech_TD[6], 0);
	TextDrawSetSelectable(craft_pech_TD[6], true);

	craft_pech_TD[7] = TextDrawCreate(386.0000, 252.0000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[7], 34.0000, 16.0000);
	TextDrawAlignment(craft_pech_TD[7], 1);
	TextDrawColor(craft_pech_TD[7],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pech_TD[7], 255);
	TextDrawFont(craft_pech_TD[7], 4);
	TextDrawSetProportional(craft_pech_TD[7], 0);
	TextDrawSetShadow(craft_pech_TD[7], 0);

	craft_pech_TD[8] = TextDrawCreate(386.7998, 253.3000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[8], 32.1203, 13.4799);
	TextDrawAlignment(craft_pech_TD[8], 1);
	TextDrawColor(craft_pech_TD[8],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pech_TD[8], 255);
	TextDrawFont(craft_pech_TD[8], 4);
	TextDrawSetProportional(craft_pech_TD[8], 0);
	TextDrawSetShadow(craft_pech_TD[8], 0);

	craft_pech_TD[9] = TextDrawCreate(403.2343, 251.8295, "Add"); // MELT
	TextDrawLetterSize(craft_pech_TD[9], 0.2364, 1.6124);
	TextDrawTextSize(craft_pech_TD[9], 12.0000, 29.0000);
	TextDrawAlignment(craft_pech_TD[9], 2);
	TextDrawColor(craft_pech_TD[9],TD_COLOR_THEME_TEXT);
	TextDrawUseBox(craft_pech_TD[9], 1);
	TextDrawBoxColor(craft_pech_TD[9], 0);
	TextDrawBackgroundColor(craft_pech_TD[9], 255);
	TextDrawFont(craft_pech_TD[9], 2);
	TextDrawSetProportional(craft_pech_TD[9], 1);
	TextDrawSetShadow(craft_pech_TD[9], 0);
	TextDrawSetSelectable(craft_pech_TD[9], true);

	craft_pech_TD[10] = TextDrawCreate(421.7019, 252.0000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[10], 77.0000, 16.0000);
	TextDrawAlignment(craft_pech_TD[10], 1);
	TextDrawColor(craft_pech_TD[10],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pech_TD[10], 255);
	TextDrawFont(craft_pech_TD[10], 4);
	TextDrawSetProportional(craft_pech_TD[10], 0);
	TextDrawSetShadow(craft_pech_TD[10], 0);

	craft_pech_TD[11] = TextDrawCreate(422.8020, 253.3000, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[11], 74.9673, 13.4799);
	TextDrawAlignment(craft_pech_TD[11], 1);
	TextDrawColor(craft_pech_TD[11],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pech_TD[11], 255);
	TextDrawFont(craft_pech_TD[11], 4);
	TextDrawSetProportional(craft_pech_TD[11], 0);
	TextDrawSetShadow(craft_pech_TD[11], 0);

	craft_pech_TD[12] = TextDrawCreate(432.9999, 216.8076, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[12], 17.0000, 18.0000);
	TextDrawAlignment(craft_pech_TD[12], 1);
	TextDrawColor(craft_pech_TD[12],TD_COLOR_THEME_BACKGROUND_0);
	TextDrawBackgroundColor(craft_pech_TD[12], 255);
	TextDrawFont(craft_pech_TD[12], 4);
	TextDrawSetProportional(craft_pech_TD[12], 0);
	TextDrawSetShadow(craft_pech_TD[12], 0);

	craft_pech_TD[13] = TextDrawCreate(434.0000, 218.1077, "LD_SPAC:white"); // пусто
	TextDrawTextSize(craft_pech_TD[13], 14.7999, 15.6599);
	TextDrawAlignment(craft_pech_TD[13], 1);
	TextDrawColor(craft_pech_TD[13],TD_COLOR_THEME_BACKGROUND_1);
	TextDrawBackgroundColor(craft_pech_TD[13], 255);
	TextDrawFont(craft_pech_TD[13], 4);
	TextDrawSetProportional(craft_pech_TD[13], 0);
	TextDrawSetShadow(craft_pech_TD[13], 0);

	drop_items_TD = TextDrawCreate(319.6668, 401.5556-40, "Drop"); // пусто
	TextDrawLetterSize(drop_items_TD, 0.2993, 1.5999);
	TextDrawTextSize(drop_items_TD, 12.0000, 40.0000);
	TextDrawAlignment(drop_items_TD, 2);
	TextDrawColor(drop_items_TD, -1);
	TextDrawUseBox(drop_items_TD, 1);
	TextDrawBoxColor(drop_items_TD, 0);
	TextDrawSetOutline(drop_items_TD, 1);
	TextDrawBackgroundColor(drop_items_TD, 255);
	TextDrawFont(drop_items_TD, 2);
	TextDrawSetProportional(drop_items_TD, 1);
	TextDrawSetShadow(drop_items_TD, 0);
	TextDrawSetSelectable(drop_items_TD, true);

	progressbar_TD[0] = TextDrawCreate(273.6998, 359.9184, "LD_SPAC:white"); // пусто
	TextDrawTextSize(progressbar_TD[0], 88.0000, 16.7099);
	TextDrawAlignment(progressbar_TD[0], 1);
	TextDrawColor(progressbar_TD[0], 255);
	TextDrawBackgroundColor(progressbar_TD[0], 255);
	TextDrawFont(progressbar_TD[0], 4);
	TextDrawSetProportional(progressbar_TD[0], 0);
	TextDrawSetShadow(progressbar_TD[0], 0);

	progressbar_TD[1] = TextDrawCreate(274.5998, 360.6184, "LD_SPAC:white"); // пусто
	TextDrawTextSize(progressbar_TD[1], 86.0000, 15.0598);
	TextDrawAlignment(progressbar_TD[1], 1);
	TextDrawColor(progressbar_TD[1], -206);
	TextDrawBackgroundColor(progressbar_TD[1], 255);
	TextDrawFont(progressbar_TD[1], 4);
	TextDrawSetProportional(progressbar_TD[1], 0);
	TextDrawSetShadow(progressbar_TD[1], 0);
	
	return true;
}
stock CreatePlayerTextDraws(playerid)
{
	regiser__menu[playerid][0] = CreatePlayerTextDraw(playerid, -1.000000, 0.000000, "mdl-8001:bg");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][0], 647.000000, 452.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][0], 1);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][0], 0);

	regiser__menu[playerid][1] = CreatePlayerTextDraw(playerid, 140.000000, 204.000000, "mdl-8001:text");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][1], 320.000000, 35.500000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][1], 1);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][1], 0);

	regiser__menu[playerid][2] = CreatePlayerTextDraw(playerid, 500.000000, 127.000000, "mdl-8001:bg_rega");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][2], 110.000000, 173.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][2], 1);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][2], 0);

	regiser__menu[playerid][3] = CreatePlayerTextDraw(playerid, 536.000000, 279.000000, "mdl-8001:btn");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][3], 39.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][3], 1);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][3], 1);

	regiser__menu[playerid][4] = CreatePlayerTextDraw(playerid, 510.000000, 143.000000, "mdl-8001:brg");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][4], 90.000000, 27.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][4], 1);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][4], 0);

	regiser__menu[playerid][5] = CreatePlayerTextDraw(playerid, 555.000000, 131.000000, "Vvedite parolb");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][5], 0.350000, 1.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][5], 400.000000, 97.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][5], 2);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][5], 0);

	regiser__menu[playerid][6] = CreatePlayerTextDraw(playerid, 555.000000, 151.000000, "ne vvedeno");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][6], 0.350000, 1.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][6], 10.000000, 97.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][6], 2);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][6], 1);

	regiser__menu[playerid][7] = CreatePlayerTextDraw(playerid, 555.000000, 179.000000, "Vvedite parolb");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][7], 0.350000, 1.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][7], 400.000000, 97.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][7], 2);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][7], 0);

	regiser__menu[playerid][8] = CreatePlayerTextDraw(playerid, 510.000000, 191.000000, "mdl-8001:brg");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][8], 90.000000, 27.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][8], 1);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][8], 0);

	regiser__menu[playerid][9] = CreatePlayerTextDraw(playerid, 555.000000, 199.000000, "ne vvedeno");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][9], 0.350000, 1.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][9], 13.500000, 97.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][9], 2);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][9], 1);

	regiser__menu[playerid][10] = CreatePlayerTextDraw(playerid, 510.000000, 239.000000, "mdl-8001:brg");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][10], 4);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][10], 90.000000, 27.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][10], 1);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][10], 0);

	regiser__menu[playerid][11] = CreatePlayerTextDraw(playerid, 555.000000, 226.000000, "Vvedite parolb");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][11], 0.350000, 1.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][11], 400.000000, 97.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][11], 2);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][11], 0);

	regiser__menu[playerid][12] = CreatePlayerTextDraw(playerid, 555.000000, 247.000000, "ne vvedeno");
	PlayerTextDrawFont(playerid, regiser__menu[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, regiser__menu[playerid][12], 0.350000, 1.000000);
	PlayerTextDrawTextSize(playerid, regiser__menu[playerid][12], 11.500000, 69.000000);
	PlayerTextDrawSetOutline(playerid, regiser__menu[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, regiser__menu[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, regiser__menu[playerid][12], 2);
	PlayerTextDrawColor(playerid, regiser__menu[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, regiser__menu[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, regiser__menu[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, regiser__menu[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, regiser__menu[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, regiser__menu[playerid][12], 1);
	
	
	//stat_start
	stats__player[playerid][0] = CreatePlayerTextDraw(playerid, 108.000000, 81.000000, "Vas_Nickname");
	PlayerTextDrawFont(playerid, stats__player[playerid][0], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][0], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][0], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][0], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][0], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][0], 0);

	stats__player[playerid][1] = CreatePlayerTextDraw(playerid, 108.000000, 94.000000, "Moretti_Desantiego");
	PlayerTextDrawFont(playerid, stats__player[playerid][1], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][1], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][1], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][1], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][1], 0);

	stats__player[playerid][2] = CreatePlayerTextDraw(playerid, 108.000000, 114.000000, "statys");
	PlayerTextDrawFont(playerid, stats__player[playerid][2], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][2], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][2], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][2], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][2], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][2], 0);

	stats__player[playerid][3] = CreatePlayerTextDraw(playerid, 108.000000, 126.000000, "igrok");
	PlayerTextDrawFont(playerid, stats__player[playerid][3], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][3], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][3], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][3], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][3], 0);

	stats__player[playerid][4] = CreatePlayerTextDraw(playerid, 108.000000, 145.000000, "batlepass f");
	PlayerTextDrawFont(playerid, stats__player[playerid][4], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][4], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][4], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][4], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][4], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][4], 0);

	stats__player[playerid][5] = CreatePlayerTextDraw(playerid, 108.000000, 156.000000, "activen do 00.00.2025");
	PlayerTextDrawFont(playerid, stats__player[playerid][5], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][5], 0.266665, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][5], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][5], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][5], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][5], 0);

	stats__player[playerid][6] = CreatePlayerTextDraw(playerid, 255.000000, 81.000000, "bALANC");
	PlayerTextDrawFont(playerid, stats__player[playerid][6], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][6], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][6], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][6], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][6], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][6], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][6], 0);

	stats__player[playerid][7] = CreatePlayerTextDraw(playerid, 255.000000, 98.000000, "228322228");
	PlayerTextDrawFont(playerid, stats__player[playerid][7], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][7], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][7], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][7], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][7], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][7], 0);

	stats__player[playerid][8] = CreatePlayerTextDraw(playerid, 355.000000, 81.000000, "id account");
	PlayerTextDrawFont(playerid, stats__player[playerid][8], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][8], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][8], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][8], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][8], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][8], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][8], 0);

	stats__player[playerid][9] = CreatePlayerTextDraw(playerid, 354.000000, 98.000000, "#228322");
	PlayerTextDrawFont(playerid, stats__player[playerid][9], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][9], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][9], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][9], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][9], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][9], 0);

	stats__player[playerid][10] = CreatePlayerTextDraw(playerid, 456.000000, 81.000000, "global_rank");
	PlayerTextDrawFont(playerid, stats__player[playerid][10], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][10], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][10], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][10], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][10], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][10], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][10], 0);

	stats__player[playerid][11] = CreatePlayerTextDraw(playerid, 456.000000, 98.000000, "1 (4234)");
	PlayerTextDrawFont(playerid, stats__player[playerid][11], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][11], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][11], 601.500000, -229.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][11], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][11], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][11], 0);

	stats__player[playerid][12] = CreatePlayerTextDraw(playerid, 557.000000, 81.000000, "fractia");
	PlayerTextDrawFont(playerid, stats__player[playerid][12], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][12], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][12], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][12], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][12], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][12], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][12], 0);

	stats__player[playerid][13] = CreatePlayerTextDraw(playerid, 557.000000, 98.000000, "ukraina");
	PlayerTextDrawFont(playerid, stats__player[playerid][13], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][13], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][13], 601.500000, -229.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][13], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][13], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][13], 0);

	stats__player[playerid][14] = CreatePlayerTextDraw(playerid, 255.000000, 139.000000, "donate_money");
	PlayerTextDrawFont(playerid, stats__player[playerid][14], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][14], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][14], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][14], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][14], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][14], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][14], 0);

	stats__player[playerid][15] = CreatePlayerTextDraw(playerid, 255.000000, 154.000000, "228322228");
	PlayerTextDrawFont(playerid, stats__player[playerid][15], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][15], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][15], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][15], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][15], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][15], 0);

	stats__player[playerid][16] = CreatePlayerTextDraw(playerid, 355.000000, 139.000000, "oldje");
	PlayerTextDrawFont(playerid, stats__player[playerid][16], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][16], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][16], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][16], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][16], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][16], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][16], 0);

	stats__player[playerid][17] = CreatePlayerTextDraw(playerid, 355.000000, 154.000000, "4242");
	PlayerTextDrawFont(playerid, stats__player[playerid][17], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][17], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][17], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][17], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][17], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][17], 0);

	stats__player[playerid][18] = CreatePlayerTextDraw(playerid, 456.000000, 139.000000, "premium");
	PlayerTextDrawFont(playerid, stats__player[playerid][18], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][18], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][18], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][18], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][18], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][18], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][18], 0);

	stats__player[playerid][19] = CreatePlayerTextDraw(playerid, 457.000000, 154.000000, "4242");
	PlayerTextDrawFont(playerid, stats__player[playerid][19], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][19], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][19], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][19], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][19], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][19], 0);

	stats__player[playerid][20] = CreatePlayerTextDraw(playerid, 557.000000, 139.000000, "premium");
	PlayerTextDrawFont(playerid, stats__player[playerid][20], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][20], 0.224996, 1.000000);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][20], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][20], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][20], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][20], -764862721);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][20], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][20], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][20], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][20], 0);

	stats__player[playerid][21] = CreatePlayerTextDraw(playerid, 557.000000, 154.000000, "radavai");
	PlayerTextDrawFont(playerid, stats__player[playerid][21], 3);
	PlayerTextDrawLetterSize(playerid, stats__player[playerid][21], 0.308333, 1.299998);
	PlayerTextDrawTextSize(playerid, stats__player[playerid][21], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, stats__player[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, stats__player[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, stats__player[playerid][21], 1);
	PlayerTextDrawColor(playerid, stats__player[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, stats__player[playerid][21], 240);
	PlayerTextDrawBoxColor(playerid, stats__player[playerid][21], 50);
	PlayerTextDrawUseBox(playerid, stats__player[playerid][21], 0);
	PlayerTextDrawSetProportional(playerid, stats__player[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, stats__player[playerid][21], 0);
	//stat_end
	
	PanelReconAdmin_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 630.9785, 172.3963, "100.0~n~98.5~n~22.0~n~1000.0~n~31(2000)~n~"); // пусто
	PlayerTextDrawLetterSize(playerid, PanelReconAdmin_PTD[playerid][0], 0.1649, 0.9901);
	PlayerTextDrawAlignment(playerid, PanelReconAdmin_PTD[playerid][0], 3);
	PlayerTextDrawColor(playerid, PanelReconAdmin_PTD[playerid][0], -1330662401);
	PlayerTextDrawBackgroundColor(playerid, PanelReconAdmin_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, PanelReconAdmin_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, PanelReconAdmin_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, PanelReconAdmin_PTD[playerid][0], 0);

	PanelReconAdmin_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 588.7999, 158.2967, "Miguel_Carter_(101)"); // пусто
	PlayerTextDrawLetterSize(playerid, PanelReconAdmin_PTD[playerid][1], 0.1316, 1.1976);
	PlayerTextDrawAlignment(playerid, PanelReconAdmin_PTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, PanelReconAdmin_PTD[playerid][1], -1330662401);
	PlayerTextDrawBackgroundColor(playerid, PanelReconAdmin_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, PanelReconAdmin_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, PanelReconAdmin_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, PanelReconAdmin_PTD[playerid][1], 0);
	
	Speedomitr_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 445.2998, 401.0000, "1000"); // пусто
	PlayerTextDrawLetterSize(playerid, Speedomitr_PTD[playerid][0], 0.2451, 1.7158);
	PlayerTextDrawAlignment(playerid, Speedomitr_PTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, Speedomitr_PTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Speedomitr_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, Speedomitr_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, Speedomitr_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Speedomitr_PTD[playerid][0], 0);

	Speedomitr_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 478.9996, 400.7998, "60"); // пусто
	PlayerTextDrawLetterSize(playerid, Speedomitr_PTD[playerid][1], 0.2451, 1.7158);
	PlayerTextDrawAlignment(playerid, Speedomitr_PTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, Speedomitr_PTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Speedomitr_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, Speedomitr_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, Speedomitr_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Speedomitr_PTD[playerid][1], 0);

	Speedomitr_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 512.8001, 400.7998, "99"); // пусто
	PlayerTextDrawLetterSize(playerid, Speedomitr_PTD[playerid][2], 0.2451, 1.7158);
	PlayerTextDrawAlignment(playerid, Speedomitr_PTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, Speedomitr_PTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, Speedomitr_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, Speedomitr_PTD[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, Speedomitr_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Speedomitr_PTD[playerid][2], 0);

	Speedomitr_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 547.3001, 400.7998, "0"); // пусто
	PlayerTextDrawLetterSize(playerid, Speedomitr_PTD[playerid][3], 0.2222, 1.7655);
	PlayerTextDrawAlignment(playerid, Speedomitr_PTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, Speedomitr_PTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, Speedomitr_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, Speedomitr_PTD[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, Speedomitr_PTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Speedomitr_PTD[playerid][3], 0);

	GPS_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 71.6332, 429.1481, "Randolph_Industrial_Estate"); // пусто
	PlayerTextDrawLetterSize(playerid, GPS_PTD[playerid][0], 0.1453, 1.4174);
	PlayerTextDrawAlignment(playerid, GPS_PTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, GPS_PTD[playerid][0], -1381126657);
	PlayerTextDrawBackgroundColor(playerid, GPS_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, GPS_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, GPS_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, GPS_PTD[playerid][0], 0);

	craft_pila_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 420.7999, 262.0000, "_"); // PROGRESS:_99%
	PlayerTextDrawLetterSize(playerid, craft_pila_PTD[playerid][0], 0.2409, 1.5253);
	PlayerTextDrawTextSize(playerid, craft_pila_PTD[playerid][0], 12.0000, 106.0000);
	PlayerTextDrawAlignment(playerid, craft_pila_PTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, craft_pila_PTD[playerid][0],TD_COLOR_THEME_TEXT);
	PlayerTextDrawUseBox(playerid, craft_pila_PTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, craft_pila_PTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, craft_pila_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, craft_pila_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, craft_pila_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, craft_pila_PTD[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, craft_pila_PTD[playerid][0], true);

	craft_pila_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 383.8004, 218.0000, "_"); // 100%
	PlayerTextDrawLetterSize(playerid, craft_pila_PTD[playerid][1], 0.1582, 0.9818);
	PlayerTextDrawAlignment(playerid, craft_pila_PTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, craft_pila_PTD[playerid][1],TD_COLOR_THEME_TEXT);
	PlayerTextDrawBackgroundColor(playerid, craft_pila_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, craft_pila_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, craft_pila_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, craft_pila_PTD[playerid][1], 0);

	craft_pila_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 455.7048, 218.0000, "_"); // 100
	PlayerTextDrawLetterSize(playerid, craft_pila_PTD[playerid][2], 0.1582, 0.9818);
	PlayerTextDrawAlignment(playerid, craft_pila_PTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, craft_pila_PTD[playerid][2],TD_COLOR_THEME_TEXT);
	PlayerTextDrawBackgroundColor(playerid, craft_pila_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, craft_pila_PTD[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, craft_pila_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, craft_pila_PTD[playerid][2], 0);
	
	craft_stol_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 445.8999, 259.7000, "_"); // CRAFT
	PlayerTextDrawLetterSize(playerid, craft_stol_PTD[playerid][0], 0.2565, 1.5126);
	PlayerTextDrawTextSize(playerid, craft_stol_PTD[playerid][0], 12.0000, 110.0000);
	PlayerTextDrawAlignment(playerid, craft_stol_PTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, craft_stol_PTD[playerid][0],TD_COLOR_THEME_TEXT);
	PlayerTextDrawUseBox(playerid, craft_stol_PTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, craft_stol_PTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, craft_stol_PTD[playerid][0], 0x00000000);
	PlayerTextDrawFont(playerid, craft_stol_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, craft_stol_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, craft_stol_PTD[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, craft_stol_PTD[playerid][0], true);

	craft_stol_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 394.6000, 207.1369, ""); // пусто
	PlayerTextDrawTextSize(playerid, craft_stol_PTD[playerid][1], 19.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, craft_stol_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, craft_stol_PTD[playerid][1], -1);
	PlayerTextDrawFont(playerid, craft_stol_PTD[playerid][1], 5);
	PlayerTextDrawBackgroundColor(playerid, craft_stol_PTD[playerid][0], 0x00000000);
	PlayerTextDrawSetProportional(playerid, craft_stol_PTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, craft_stol_PTD[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, craft_stol_PTD[playerid][1], 1961);
	PlayerTextDrawSetPreviewRot(playerid, craft_stol_PTD[playerid][1], 0.0000, 0.0000, 0.0000, 1.0000);

	craft_stol_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 426.4020, 207.5518, ""); // пусто
	PlayerTextDrawTextSize(playerid, craft_stol_PTD[playerid][2], 19.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, craft_stol_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, craft_stol_PTD[playerid][2], -1);
	PlayerTextDrawFont(playerid, craft_stol_PTD[playerid][2], 5);
	PlayerTextDrawBackgroundColor(playerid, craft_stol_PTD[playerid][0], 0x00000000);
	PlayerTextDrawSetProportional(playerid, craft_stol_PTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, craft_stol_PTD[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, craft_stol_PTD[playerid][2], 1961);
	PlayerTextDrawSetPreviewRot(playerid, craft_stol_PTD[playerid][2], 0.0000, 0.0000, 0.0000, 1.0000);

	craft_pech_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 405.4674, 217.7890, "_"); // пусто
	PlayerTextDrawLetterSize(playerid, craft_pech_PTD[playerid][0], 0.1623, 0.9071);
	PlayerTextDrawTextSize(playerid, craft_pech_PTD[playerid][0], 0.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, craft_pech_PTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, craft_pech_PTD[playerid][0],TD_COLOR_THEME_TEXT);
	PlayerTextDrawUseBox(playerid, craft_pech_PTD[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, craft_pech_PTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, craft_pech_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, craft_pech_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, craft_pech_PTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, craft_pech_PTD[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, craft_pech_PTD[playerid][0], true);

	craft_pech_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 460.4042, 252.0000, "_"); // пусто
	PlayerTextDrawLetterSize(playerid, craft_pech_PTD[playerid][1], 0.2240, 1.5915);
	PlayerTextDrawTextSize(playerid, craft_pech_PTD[playerid][1], 12.0000, 73.0000);
	PlayerTextDrawAlignment(playerid, craft_pech_PTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, craft_pech_PTD[playerid][1],TD_COLOR_THEME_TEXT);
	PlayerTextDrawUseBox(playerid, craft_pech_PTD[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, craft_pech_PTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, craft_pech_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, craft_pech_PTD[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, craft_pech_PTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, craft_pech_PTD[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, craft_pech_PTD[playerid][1], true);

	craft_pech_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 441.6000, 219.9666, "_"); // пусто
	PlayerTextDrawLetterSize(playerid, craft_pech_PTD[playerid][2], 0.2000, 1.1561);
	PlayerTextDrawAlignment(playerid, craft_pech_PTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, craft_pech_PTD[playerid][2],TD_COLOR_THEME_TEXT);
	PlayerTextDrawBackgroundColor(playerid, craft_pech_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, craft_pech_PTD[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, craft_pech_PTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, craft_pech_PTD[playerid][2], 0);

	return true;
}

stock CreateAllInventory ( playerid )
{
	inventory__TD[playerid][0] = CreatePlayerTextDraw(playerid, 453.000000, 125.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][0], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][0], 1);

	inventory__TD[playerid][1] = CreatePlayerTextDraw(playerid, 483.000000, 125.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][1], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][1], 1);

	inventory__TD[playerid][2] = CreatePlayerTextDraw(playerid, 513.000000, 125.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][2], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][2], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][2], 1);

	inventory__TD[playerid][3] = CreatePlayerTextDraw(playerid, 543.000000, 125.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][3], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][3], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][3], 1);

	inventory__TD[playerid][4] = CreatePlayerTextDraw(playerid, 573.000000, 125.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][4], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][4], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][4], 1);

	inventory__TD[playerid][5] = CreatePlayerTextDraw(playerid, 453.000000, 155.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][5], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][5], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][5], 1);

	inventory__TD[playerid][6] = CreatePlayerTextDraw(playerid, 483.000000, 155.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][6], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][6], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][6], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][6], 1);

	inventory__TD[playerid][7] = CreatePlayerTextDraw(playerid, 513.000000, 155.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][7], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][7], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][7], 1);

	inventory__TD[playerid][8] = CreatePlayerTextDraw(playerid, 543.000000, 155.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][8], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][8], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][8], 1);

	inventory__TD[playerid][9] = CreatePlayerTextDraw(playerid, 573.000000, 155.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][9], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][9], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][9], 1);

	inventory__TD[playerid][10] = CreatePlayerTextDraw(playerid, 453.000000, 185.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][10], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][10], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][10], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][10], 1);

	inventory__TD[playerid][11] = CreatePlayerTextDraw(playerid, 483.000000, 185.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][11], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][11], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][11], 1);

	inventory__TD[playerid][12] = CreatePlayerTextDraw(playerid, 513.000000, 185.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][12], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][12], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][12], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][12], 1);

	inventory__TD[playerid][13] = CreatePlayerTextDraw(playerid, 543.000000, 185.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][13], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][13], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][13], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][13], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][13], 1);

	inventory__TD[playerid][14] = CreatePlayerTextDraw(playerid, 573.000000, 185.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][14], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][14], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][14], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][14], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][14], 1);

	inventory__TD[playerid][15] = CreatePlayerTextDraw(playerid, 453.000000, 215.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][15], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][15], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][15], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][15], 1);

	inventory__TD[playerid][16] = CreatePlayerTextDraw(playerid, 483.000000, 215.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][16], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][16], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][16], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][16], 1);

	inventory__TD[playerid][17] = CreatePlayerTextDraw(playerid, 513.000000, 215.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][17], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][17], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][17], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][17], 1);

	inventory__TD[playerid][18] = CreatePlayerTextDraw(playerid, 543.000000, 215.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][18], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][18], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][18], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][18], 1);

	inventory__TD[playerid][19] = CreatePlayerTextDraw(playerid, 573.000000, 215.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][19], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][19], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][19], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][19], 1);

	inventory__TD[playerid][20] = CreatePlayerTextDraw(playerid, 453.000000, 245.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][20], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][20], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][20], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][20], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][20], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][20], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][20], 1);

	inventory__TD[playerid][21] = CreatePlayerTextDraw(playerid, 483.000000, 245.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][21], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][21], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][21], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][21], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][21], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][21], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][21], 1);

	inventory__TD[playerid][22] = CreatePlayerTextDraw(playerid, 513.000000, 245.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][22], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][22], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][22], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][22], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][22], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][22], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][22], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][22], 1);

	inventory__TD[playerid][23] = CreatePlayerTextDraw(playerid, 543.000000, 245.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][23], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][23], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][23], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][23], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][23], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][23], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][23], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][23], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][23], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][23], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][23], 1);

	inventory__TD[playerid][24] = CreatePlayerTextDraw(playerid, 573.000000, 245.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][24], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][24], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][24], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][24], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][24], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][24], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][24], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][24], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][24], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][24], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][24], 1);

	inventory__TD[playerid][25] = CreatePlayerTextDraw(playerid, 453.000000, 275.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][25], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][25], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][25], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][25], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][25], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][25], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][25], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][25], 1);

	inventory__TD[playerid][26] = CreatePlayerTextDraw(playerid, 483.000000, 275.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][26], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][26], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][26], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][26], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][26], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][26], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][26], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][26], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][26], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][26], 1);

	inventory__TD[playerid][27] = CreatePlayerTextDraw(playerid, 513.000000, 275.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][27], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][27], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][27], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][27], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][27], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][27], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][27], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][27], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][27], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][27], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][27], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][27], 1);

	inventory__TD[playerid][28] = CreatePlayerTextDraw(playerid, 543.000000, 275.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][28], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][28], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][28], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][28], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][28], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][28], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][28], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][28], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][28], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][28], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][28], 1);

	inventory__TD[playerid][29] = CreatePlayerTextDraw(playerid, 573.000000, 275.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][29], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][29], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][29], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][29], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][29], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][29], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][29], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][29], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][29], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][29], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][29], 1);

	inventory__TD[playerid][30] = CreatePlayerTextDraw(playerid, 453.000000, 125.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][30], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][30], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][30], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][30], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][30], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][30], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][30], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][30], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][30], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][30], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][30], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][30], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][30], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][30], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][30], 1, 1);

	inventory__TD[playerid][31] = CreatePlayerTextDraw(playerid, 483.000000, 125.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][31], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][31], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][31], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][31], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][31], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][31], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][31], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][31], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][31], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][31], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][31], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][31], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][31], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][31], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][31], 1, 1);

	inventory__TD[playerid][32] = CreatePlayerTextDraw(playerid, 513.000000, 125.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][32], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][32], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][32], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][32], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][32], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][32], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][32], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][32], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][32], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][32], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][32], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][32], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][32], 1, 1);

	inventory__TD[playerid][33] = CreatePlayerTextDraw(playerid, 543.000000, 125.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][33], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][33], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][33], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][33], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][33], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][33], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][33], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][33], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][33], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][33], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][33], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][33], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][33], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][33], 1, 1);

	inventory__TD[playerid][34] = CreatePlayerTextDraw(playerid, 573.000000, 125.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][34], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][34], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][34], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][34], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][34], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][34], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][34], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][34], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][34], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][34], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][34], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][34], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][34], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][34], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][34], 1, 1);

	inventory__TD[playerid][35] = CreatePlayerTextDraw(playerid, 453.000000, 155.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][35], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][35], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][35], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][35], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][35], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][35], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][35], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][35], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][35], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][35], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][35], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][35], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][35], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][35], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][35], 1, 1);

	inventory__TD[playerid][36] = CreatePlayerTextDraw(playerid, 483.000000, 155.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][36], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][36], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][36], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][36], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][36], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][36], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][36], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][36], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][36], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][36], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][36], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][36], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][36], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][36], 1, 1);

	inventory__TD[playerid][37] = CreatePlayerTextDraw(playerid, 513.000000, 155.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][37], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][37], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][37], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][37], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][37], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][37], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][37], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][37], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][37], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][37], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][37], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][37], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][37], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][37], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][37], 1, 1);

	inventory__TD[playerid][38] = CreatePlayerTextDraw(playerid, 543.000000, 155.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][38], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][38], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][38], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][38], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][38], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][38], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][38], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][38], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][38], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][38], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][38], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][38], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][38], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][38], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][38], 1, 1);

	inventory__TD[playerid][39] = CreatePlayerTextDraw(playerid, 573.000000, 155.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][39], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][39], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][39], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][39], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][39], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][39], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][39], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][39], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][39], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][39], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][39], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][39], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][39], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][39], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][39], 1, 1);

	inventory__TD[playerid][40] = CreatePlayerTextDraw(playerid, 453.000000, 185.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][40], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][40], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][40], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][40], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][40], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][40], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][40], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][40], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][40], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][40], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][40], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][40], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][40], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][40], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][40], 1, 1);

	inventory__TD[playerid][41] = CreatePlayerTextDraw(playerid, 483.000000, 185.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][41], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][41], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][41], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][41], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][41], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][41], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][41], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][41], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][41], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][41], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][41], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][41], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][41], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][41], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][41], 1, 1);

	inventory__TD[playerid][42] = CreatePlayerTextDraw(playerid, 513.000000, 185.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][42], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][42], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][42], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][42], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][42], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][42], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][42], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][42], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][42], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][42], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][42], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][42], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][42], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][42], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][42], 1, 1);

	inventory__TD[playerid][43] = CreatePlayerTextDraw(playerid, 543.000000, 185.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][43], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][43], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][43], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][43], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][43], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][43], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][43], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][43], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][43], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][43], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][43], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][43], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][43], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][43], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][43], 1, 1);

	inventory__TD[playerid][44] = CreatePlayerTextDraw(playerid, 573.000000, 185.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][44], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][44], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][44], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][44], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][44], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][44], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][44], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][44], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][44], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][44], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][44], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][44], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][44], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][44], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][44], 1, 1);

	inventory__TD[playerid][45] = CreatePlayerTextDraw(playerid, 453.000000, 215.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][45], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][45], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][45], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][45], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][45], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][45], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][45], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][45], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][45], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][45], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][45], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][45], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][45], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][45], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][45], 1, 1);

	inventory__TD[playerid][46] = CreatePlayerTextDraw(playerid, 483.000000, 215.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][46], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][46], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][46], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][46], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][46], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][46], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][46], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][46], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][46], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][46], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][46], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][46], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][46], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][46], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][46], 1, 1);

	inventory__TD[playerid][47] = CreatePlayerTextDraw(playerid, 513.000000, 215.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][47], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][47], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][47], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][47], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][47], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][47], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][47], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][47], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][47], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][47], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][47], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][47], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][47], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][47], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][47], 1, 1);

	inventory__TD[playerid][48] = CreatePlayerTextDraw(playerid, 543.000000, 215.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][48], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][48], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][48], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][48], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][48], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][48], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][48], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][48], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][48], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][48], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][48], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][48], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][48], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][48], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][48], 1, 1);

	inventory__TD[playerid][49] = CreatePlayerTextDraw(playerid, 573.000000, 215.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][49], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][49], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][49], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][49], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][49], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][49], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][49], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][49], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][49], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][49], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][49], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][49], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][49], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][49], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][49], 1, 1);

	inventory__TD[playerid][50] = CreatePlayerTextDraw(playerid, 453.000000, 245.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][50], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][50], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][50], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][50], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][50], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][50], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][50], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][50], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][50], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][50], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][50], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][50], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][50], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][50], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][50], 1, 1);

	inventory__TD[playerid][51] = CreatePlayerTextDraw(playerid, 483.000000, 245.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][51], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][51], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][51], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][51], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][51], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][51], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][51], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][51], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][51], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][51], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][51], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][51], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][51], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][51], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][51], 1, 1);

	inventory__TD[playerid][52] = CreatePlayerTextDraw(playerid, 513.000000, 245.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][52], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][52], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][52], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][52], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][52], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][52], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][52], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][52], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][52], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][52], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][52], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][52], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][52], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][52], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][52], 1, 1);

	inventory__TD[playerid][53] = CreatePlayerTextDraw(playerid, 543.000000, 245.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][53], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][53], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][53], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][53], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][53], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][53], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][53], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][53], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][53], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][53], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][53], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][53], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][53], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][53], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][53], 1, 1);

	inventory__TD[playerid][54] = CreatePlayerTextDraw(playerid, 573.000000, 245.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][54], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][54], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][54], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][54], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][54], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][54], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][54], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][54], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][54], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][54], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][54], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][54], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][54], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][54], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][54], 1, 1);

	inventory__TD[playerid][55] = CreatePlayerTextDraw(playerid, 453.000000, 275.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][55], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][55], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][55], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][55], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][55], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][55], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][55], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][55], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][55], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][55], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][55], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][55], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][55], 2663);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][55], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][55], 1, 1);

	inventory__TD[playerid][56] = CreatePlayerTextDraw(playerid, 483.000000, 275.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][56], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][56], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][56], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][56], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][56], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][56], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][56], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][56], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][56], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][56], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][56], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][56], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][56], 355);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][56], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][56], 1, 1);

	inventory__TD[playerid][57] = CreatePlayerTextDraw(playerid, 513.000000, 275.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][57], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][57], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][57], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][57], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][57], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][57], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][57], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][57], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][57], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][57], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][57], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][57], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][57], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][57], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][57], 1, 1);

	inventory__TD[playerid][58] = CreatePlayerTextDraw(playerid, 543.000000, 275.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][58], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][58], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][58], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][58], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][58], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][58], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][58], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][58], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][58], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][58], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][58], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][58], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][58], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][58], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][58], 1, 1);

	inventory__TD[playerid][59] = CreatePlayerTextDraw(playerid, 573.000000, 275.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][59], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][59], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][59], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][59], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][59], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][59], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][59], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][59], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][59], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][59], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][59], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][59], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][59], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][59], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][59], 1, 1);

	inventory__TD[playerid][60] = CreatePlayerTextDraw(playerid, 468.000000, 130.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][60], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][60], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][60], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][60], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][60], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][60], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][60], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][60], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][60], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][60], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][60], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][60], 1);

	inventory__TD[playerid][61] = CreatePlayerTextDraw(playerid, 468.000000, 142.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][61], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][61], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][61], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][61], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][61], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][61], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][61], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][61], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][61], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][61], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][61], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][61], 1);

	inventory__TD[playerid][62] = CreatePlayerTextDraw(playerid, 498.000000, 130.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][62], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][62], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][62], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][62], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][62], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][62], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][62], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][62], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][62], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][62], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][62], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][62], 1);

	inventory__TD[playerid][63] = CreatePlayerTextDraw(playerid, 498.000000, 142.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][63], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][63], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][63], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][63], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][63], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][63], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][63], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][63], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][63], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][63], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][63], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][63], 1);

	inventory__TD[playerid][64] = CreatePlayerTextDraw(playerid, 528.000000, 130.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][64], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][64], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][64], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][64], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][64], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][64], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][64], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][64], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][64], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][64], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][64], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][64], 1);

	inventory__TD[playerid][65] = CreatePlayerTextDraw(playerid, 528.000000, 142.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][65], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][65], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][65], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][65], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][65], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][65], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][65], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][65], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][65], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][65], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][65], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][65], 1);

	inventory__TD[playerid][66] = CreatePlayerTextDraw(playerid, 558.000000, 130.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][66], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][66], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][66], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][66], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][66], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][66], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][66], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][66], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][66], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][66], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][66], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][66], 1);

	inventory__TD[playerid][67] = CreatePlayerTextDraw(playerid, 558.000000, 142.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][67], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][67], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][67], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][67], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][67], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][67], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][67], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][67], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][67], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][67], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][67], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][67], 1);

	inventory__TD[playerid][68] = CreatePlayerTextDraw(playerid, 588.000000, 130.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][68], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][68], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][68], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][68], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][68], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][68], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][68], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][68], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][68], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][68], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][68], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][68], 1);

	inventory__TD[playerid][69] = CreatePlayerTextDraw(playerid, 588.000000, 142.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][69], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][69], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][69], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][69], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][69], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][69], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][69], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][69], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][69], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][69], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][69], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][69], 1);

	inventory__TD[playerid][70] = CreatePlayerTextDraw(playerid, 468.000000, 160.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][70], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][70], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][70], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][70], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][70], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][70], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][70], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][70], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][70], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][70], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][70], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][70], 1);

	inventory__TD[playerid][71] = CreatePlayerTextDraw(playerid, 468.000000, 172.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][71], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][71], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][71], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][71], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][71], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][71], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][71], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][71], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][71], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][71], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][71], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][71], 1);

	inventory__TD[playerid][72] = CreatePlayerTextDraw(playerid, 498.000000, 160.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][72], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][72], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][72], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][72], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][72], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][72], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][72], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][72], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][72], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][72], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][72], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][72], 1);

	inventory__TD[playerid][73] = CreatePlayerTextDraw(playerid, 498.000000, 172.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][73], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][73], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][73], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][73], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][73], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][73], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][73], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][73], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][73], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][73], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][73], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][73], 1);

	inventory__TD[playerid][74] = CreatePlayerTextDraw(playerid, 528.000000, 160.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][74], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][74], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][74], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][74], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][74], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][74], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][74], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][74], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][74], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][74], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][74], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][74], 1);

	inventory__TD[playerid][75] = CreatePlayerTextDraw(playerid, 528.000000, 172.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][75], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][75], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][75], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][75], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][75], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][75], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][75], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][75], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][75], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][75], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][75], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][75], 1);

	inventory__TD[playerid][76] = CreatePlayerTextDraw(playerid, 558.000000, 160.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][76], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][76], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][76], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][76], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][76], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][76], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][76], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][76], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][76], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][76], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][76], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][76], 1);

	inventory__TD[playerid][77] = CreatePlayerTextDraw(playerid, 558.000000, 172.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][77], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][77], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][77], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][77], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][77], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][77], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][77], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][77], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][77], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][77], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][77], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][77], 1);

	inventory__TD[playerid][78] = CreatePlayerTextDraw(playerid, 588.000000, 160.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][78], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][78], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][78], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][78], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][78], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][78], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][78], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][78], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][78], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][78], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][78], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][78], 1);

	inventory__TD[playerid][79] = CreatePlayerTextDraw(playerid, 588.000000, 172.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][79], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][79], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][79], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][79], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][79], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][79], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][79], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][79], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][79], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][79], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][79], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][79], 1);

	inventory__TD[playerid][80] = CreatePlayerTextDraw(playerid, 468.000000, 190.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][80], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][80], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][80], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][80], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][80], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][80], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][80], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][80], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][80], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][80], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][80], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][80], 1);

	inventory__TD[playerid][81] = CreatePlayerTextDraw(playerid, 468.000000, 202.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][81], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][81], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][81], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][81], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][81], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][81], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][81], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][81], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][81], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][81], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][81], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][81], 1);

	inventory__TD[playerid][82] = CreatePlayerTextDraw(playerid, 498.000000, 190.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][82], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][82], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][82], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][82], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][82], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][82], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][82], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][82], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][82], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][82], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][82], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][82], 1);

	inventory__TD[playerid][83] = CreatePlayerTextDraw(playerid, 498.000000, 202.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][83], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][83], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][83], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][83], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][83], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][83], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][83], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][83], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][83], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][83], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][83], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][83], 1);

	inventory__TD[playerid][84] = CreatePlayerTextDraw(playerid, 528.000000, 190.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][84], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][84], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][84], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][84], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][84], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][84], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][84], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][84], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][84], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][84], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][84], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][84], 1);

	inventory__TD[playerid][85] = CreatePlayerTextDraw(playerid, 528.000000, 202.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][85], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][85], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][85], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][85], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][85], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][85], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][85], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][85], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][85], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][85], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][85], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][85], 1);

	inventory__TD[playerid][86] = CreatePlayerTextDraw(playerid, 558.000000, 190.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][86], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][86], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][86], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][86], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][86], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][86], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][86], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][86], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][86], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][86], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][86], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][86], 1);

	inventory__TD[playerid][87] = CreatePlayerTextDraw(playerid, 558.000000, 202.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][87], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][87], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][87], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][87], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][87], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][87], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][87], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][87], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][87], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][87], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][87], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][87], 1);

	inventory__TD[playerid][88] = CreatePlayerTextDraw(playerid, 588.000000, 190.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][88], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][88], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][88], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][88], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][88], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][88], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][88], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][88], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][88], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][88], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][88], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][88], 1);

	inventory__TD[playerid][89] = CreatePlayerTextDraw(playerid, 588.000000, 202.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][89], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][89], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][89], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][89], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][89], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][89], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][89], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][89], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][89], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][89], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][89], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][89], 1);

	inventory__TD[playerid][90] = CreatePlayerTextDraw(playerid, 468.000000, 220.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][90], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][90], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][90], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][90], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][90], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][90], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][90], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][90], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][90], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][90], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][90], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][90], 1);

	inventory__TD[playerid][91] = CreatePlayerTextDraw(playerid, 468.000000, 232.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][91], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][91], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][91], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][91], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][91], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][91], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][91], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][91], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][91], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][91], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][91], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][91], 1);

	inventory__TD[playerid][92] = CreatePlayerTextDraw(playerid, 498.000000, 220.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][92], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][92], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][92], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][92], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][92], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][92], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][92], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][92], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][92], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][92], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][92], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][92], 1);

	inventory__TD[playerid][93] = CreatePlayerTextDraw(playerid, 498.000000, 232.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][93], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][93], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][93], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][93], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][93], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][93], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][93], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][93], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][93], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][93], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][93], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][93], 1);

	inventory__TD[playerid][94] = CreatePlayerTextDraw(playerid, 528.000000, 220.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][94], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][94], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][94], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][94], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][94], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][94], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][94], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][94], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][94], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][94], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][94], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][94], 1);

	inventory__TD[playerid][95] = CreatePlayerTextDraw(playerid, 528.000000, 232.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][95], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][95], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][95], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][95], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][95], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][95], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][95], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][95], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][95], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][95], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][95], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][95], 1);

	inventory__TD[playerid][96] = CreatePlayerTextDraw(playerid, 558.000000, 220.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][96], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][96], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][96], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][96], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][96], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][96], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][96], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][96], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][96], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][96], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][96], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][96], 1);

	inventory__TD[playerid][97] = CreatePlayerTextDraw(playerid, 558.000000, 232.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][97], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][97], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][97], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][97], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][97], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][97], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][97], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][97], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][97], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][97], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][97], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][97], 1);

	inventory__TD[playerid][98] = CreatePlayerTextDraw(playerid, 588.000000, 220.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][98], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][98], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][98], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][98], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][98], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][98], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][98], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][98], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][98], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][98], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][98], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][98], 1);

	inventory__TD[playerid][99] = CreatePlayerTextDraw(playerid, 588.000000, 232.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][99], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][99], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][99], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][99], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][99], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][99], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][99], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][99], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][99], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][99], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][99], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][99], 1);

	inventory__TD[playerid][100] = CreatePlayerTextDraw(playerid, 468.000000, 250.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][100], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][100], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][100], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][100], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][100], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][100], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][100], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][100], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][100], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][100], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][100], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][100], 1);

	inventory__TD[playerid][101] = CreatePlayerTextDraw(playerid, 468.000000, 262.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][101], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][101], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][101], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][101], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][101], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][101], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][101], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][101], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][101], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][101], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][101], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][101], 1);

	inventory__TD[playerid][102] = CreatePlayerTextDraw(playerid, 498.000000, 250.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][102], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][102], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][102], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][102], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][102], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][102], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][102], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][102], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][102], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][102], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][102], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][102], 1);

	inventory__TD[playerid][103] = CreatePlayerTextDraw(playerid, 498.000000, 262.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][103], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][103], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][103], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][103], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][103], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][103], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][103], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][103], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][103], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][103], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][103], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][103], 1);

	inventory__TD[playerid][104] = CreatePlayerTextDraw(playerid, 528.000000, 250.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][104], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][104], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][104], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][104], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][104], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][104], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][104], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][104], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][104], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][104], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][104], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][104], 1);

	inventory__TD[playerid][105] = CreatePlayerTextDraw(playerid, 528.000000, 262.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][105], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][105], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][105], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][105], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][105], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][105], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][105], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][105], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][105], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][105], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][105], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][105], 1);

	inventory__TD[playerid][106] = CreatePlayerTextDraw(playerid, 558.000000, 250.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][106], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][106], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][106], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][106], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][106], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][106], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][106], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][106], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][106], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][106], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][106], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][106], 1);

	inventory__TD[playerid][107] = CreatePlayerTextDraw(playerid, 558.000000, 262.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][107], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][107], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][107], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][107], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][107], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][107], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][107], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][107], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][107], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][107], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][107], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][107], 1);

	inventory__TD[playerid][108] = CreatePlayerTextDraw(playerid, 588.000000, 250.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][108], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][108], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][108], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][108], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][108], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][108], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][108], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][108], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][108], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][108], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][108], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][108], 1);

	inventory__TD[playerid][109] = CreatePlayerTextDraw(playerid, 588.000000, 262.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][109], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][109], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][109], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][109], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][109], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][109], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][109], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][109], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][109], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][109], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][109], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][109], 1);

	inventory__TD[playerid][110] = CreatePlayerTextDraw(playerid, 468.000000, 280.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][110], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][110], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][110], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][110], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][110], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][110], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][110], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][110], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][110], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][110], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][110], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][110], 1);

	inventory__TD[playerid][111] = CreatePlayerTextDraw(playerid, 468.000000, 292.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][111], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][111], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][111], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][111], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][111], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][111], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][111], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][111], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][111], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][111], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][111], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][111], 1);

	inventory__TD[playerid][112] = CreatePlayerTextDraw(playerid, 498.000000, 280.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][112], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][112], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][112], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][112], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][112], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][112], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][112], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][112], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][112], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][112], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][112], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][112], 1);

	inventory__TD[playerid][113] = CreatePlayerTextDraw(playerid, 498.000000, 292.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][113], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][113], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][113], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][113], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][113], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][113], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][113], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][113], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][113], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][113], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][113], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][113], 1);

	inventory__TD[playerid][114] = CreatePlayerTextDraw(playerid, 528.000000, 280.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][114], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][114], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][114], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][114], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][114], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][114], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][114], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][114], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][114], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][114], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][114], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][114], 1);

	inventory__TD[playerid][115] = CreatePlayerTextDraw(playerid, 528.000000, 292.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][115], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][115], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][115], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][115], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][115], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][115], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][115], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][115], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][115], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][115], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][115], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][115], 1);

	inventory__TD[playerid][116] = CreatePlayerTextDraw(playerid, 558.000000, 280.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][116], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][116], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][116], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][116], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][116], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][116], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][116], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][116], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][116], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][116], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][116], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][116], 1);

	inventory__TD[playerid][117] = CreatePlayerTextDraw(playerid, 558.000000, 292.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][117], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][117], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][117], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][117], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][117], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][117], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][117], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][117], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][117], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][117], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][117], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][117], 1);

	inventory__TD[playerid][118] = CreatePlayerTextDraw(playerid, 588.000000, 280.000000, TranslateText( "Исп." ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][118], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][118], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][118], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][118], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][118], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][118], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][118], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][118], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][118], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][118], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][118], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][118], 1);

	inventory__TD[playerid][119] = CreatePlayerTextDraw(playerid, 588.000000, 292.000000, TranslateText( "Выбросить" ) );
	PlayerTextDrawFont(playerid, inventory__TD[playerid][119], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][119], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][119], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][119], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][119], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][119], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][119], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][119], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][119], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][119], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][119], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][119], 1);

	inventory__TD[playerid][120] = CreatePlayerTextDraw(playerid, 229.000000, 39.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][120], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][120], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][120], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][120], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][120], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][120], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][120], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][120], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][120], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][120], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][120], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][120], 1);

	inventory__TD[playerid][121] = CreatePlayerTextDraw(playerid, 259.000000, 39.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][121], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][121], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][121], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][121], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][121], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][121], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][121], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][121], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][121], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][121], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][121], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][121], 1);

	inventory__TD[playerid][122] = CreatePlayerTextDraw(playerid, 289.000000, 39.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][122], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][122], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][122], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][122], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][122], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][122], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][122], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][122], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][122], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][122], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][122], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][122], 1);

	inventory__TD[playerid][123] = CreatePlayerTextDraw(playerid, 319.000000, 39.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][123], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][123], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][123], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][123], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][123], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][123], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][123], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][123], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][123], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][123], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][123], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][123], 1);

	inventory__TD[playerid][124] = CreatePlayerTextDraw(playerid, 229.000000, 69.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][124], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][124], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][124], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][124], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][124], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][124], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][124], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][124], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][124], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][124], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][124], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][124], 1);

	inventory__TD[playerid][125] = CreatePlayerTextDraw(playerid, 259.000000, 69.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][125], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][125], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][125], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][125], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][125], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][125], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][125], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][125], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][125], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][125], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][125], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][125], 1);

	inventory__TD[playerid][126] = CreatePlayerTextDraw(playerid, 289.000000, 69.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][126], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][126], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][126], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][126], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][126], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][126], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][126], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][126], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][126], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][126], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][126], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][126], 1);

	inventory__TD[playerid][127] = CreatePlayerTextDraw(playerid, 319.000000, 69.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][127], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][127], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][127], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][127], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][127], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][127], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][127], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][127], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][127], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][127], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][127], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][127], 1);

	inventory__TD[playerid][128] = CreatePlayerTextDraw(playerid, 229.000000, 39.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][128], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][128], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][128], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][128], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][128], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][128], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][128], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][128], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][128], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][128], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][128], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][128], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][128], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][128], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][128], 1, 1);

	inventory__TD[playerid][129] = CreatePlayerTextDraw(playerid, 259.000000, 39.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][129], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][129], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][129], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][129], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][129], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][129], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][129], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][129], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][129], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][129], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][129], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][129], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][129], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][129], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][129], 1, 1);

	inventory__TD[playerid][130] = CreatePlayerTextDraw(playerid, 289.000000, 39.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][130], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][130], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][130], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][130], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][130], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][130], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][130], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][130], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][130], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][130], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][130], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][130], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][130], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][130], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][130], 1, 1);

	inventory__TD[playerid][131] = CreatePlayerTextDraw(playerid, 319.000000, 39.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][131], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][131], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][131], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][131], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][131], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][131], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][131], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][131], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][131], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][131], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][131], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][131], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][131], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][131], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][131], 1, 1);

	inventory__TD[playerid][132] = CreatePlayerTextDraw(playerid, 229.000000, 69.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][132], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][132], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][132], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][132], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][132], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][132], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][132], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][132], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][132], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][132], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][132], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][132], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][132], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][132], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][132], 1, 1);

	inventory__TD[playerid][133] = CreatePlayerTextDraw(playerid, 259.000000, 69.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][133], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][133], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][133], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][133], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][133], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][133], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][133], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][133], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][133], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][133], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][133], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][133], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][133], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][133], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][133], 1, 1);

	inventory__TD[playerid][134] = CreatePlayerTextDraw(playerid, 289.000000, 69.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][134], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][134], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][134], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][134], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][134], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][134], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][134], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][134], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][134], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][134], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][134], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][134], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][134], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][134], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][134], 1, 1);

	inventory__TD[playerid][135] = CreatePlayerTextDraw(playerid, 319.000000, 69.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][135], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][135], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][135], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][135], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][135], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][135], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][135], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][135], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][135], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][135], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][135], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][135], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][135], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][135], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][135], 1, 1);

	inventory__TD[playerid][136] = CreatePlayerTextDraw(playerid, 244.000000, 45.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][136], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][136], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][136], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][136], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][136], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][136], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][136], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][136], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][136], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][136], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][136], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][136], 1);

	inventory__TD[playerid][137] = CreatePlayerTextDraw(playerid, 244.000000, 57.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][137], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][137], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][137], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][137], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][137], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][137], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][137], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][137], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][137], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][137], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][137], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][137], 1);

	inventory__TD[playerid][138] = CreatePlayerTextDraw(playerid, 274.000000, 45.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][138], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][138], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][138], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][138], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][138], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][138], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][138], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][138], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][138], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][138], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][138], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][138], 1);

	inventory__TD[playerid][139] = CreatePlayerTextDraw(playerid, 274.000000, 57.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][139], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][139], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][139], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][139], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][139], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][139], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][139], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][139], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][139], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][139], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][139], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][139], 1);

	inventory__TD[playerid][140] = CreatePlayerTextDraw(playerid, 304.000000, 45.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][140], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][140], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][140], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][140], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][140], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][140], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][140], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][140], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][140], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][140], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][140], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][140], 1);

	inventory__TD[playerid][141] = CreatePlayerTextDraw(playerid, 304.000000, 57.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][141], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][141], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][141], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][141], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][141], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][141], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][141], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][141], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][141], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][141], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][141], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][141], 1);

	inventory__TD[playerid][142] = CreatePlayerTextDraw(playerid, 334.000000, 45.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][142], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][142], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][142], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][142], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][142], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][142], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][142], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][142], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][142], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][142], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][142], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][142], 1);

	inventory__TD[playerid][143] = CreatePlayerTextDraw(playerid, 334.000000, 57.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][143], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][143], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][143], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][143], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][143], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][143], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][143], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][143], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][143], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][143], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][143], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][143], 1);

	inventory__TD[playerid][144] = CreatePlayerTextDraw(playerid, 244.000000, 74.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][144], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][144], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][144], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][144], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][144], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][144], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][144], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][144], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][144], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][144], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][144], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][144], 1);

	inventory__TD[playerid][145] = CreatePlayerTextDraw(playerid, 244.000000, 86.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][145], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][145], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][145], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][145], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][145], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][145], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][145], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][145], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][145], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][145], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][145], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][145], 1);

	inventory__TD[playerid][146] = CreatePlayerTextDraw(playerid, 274.000000, 74.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][146], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][146], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][146], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][146], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][146], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][146], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][146], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][146], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][146], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][146], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][146], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][146], 1);

	inventory__TD[playerid][147] = CreatePlayerTextDraw(playerid, 274.000000, 86.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][147], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][147], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][147], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][147], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][147], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][147], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][147], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][147], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][147], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][147], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][147], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][147], 1);

	inventory__TD[playerid][148] = CreatePlayerTextDraw(playerid, 304.000000, 74.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][148], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][148], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][148], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][148], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][148], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][148], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][148], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][148], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][148], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][148], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][148], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][148], 1);

	inventory__TD[playerid][149] = CreatePlayerTextDraw(playerid, 304.000000, 86.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][149], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][149], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][149], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][149], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][149], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][149], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][149], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][149], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][149], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][149], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][149], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][149], 1);

	inventory__TD[playerid][150] = CreatePlayerTextDraw(playerid, 334.000000, 74.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][150], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][150], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][150], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][150], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][150], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][150], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][150], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][150], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][150], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][150], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][150], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][150], 1);

	inventory__TD[playerid][151] = CreatePlayerTextDraw(playerid, 334.000000, 86.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][151], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][151], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][151], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][151], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][151], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][151], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][151], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][151], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][151], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][151], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][151], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][151], 1);

	inventory__TD[playerid][152] = CreatePlayerTextDraw(playerid, 229.000000, 260.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][152], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][152], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][152], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][152], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][152], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][152], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][152], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][152], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][152], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][152], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][152], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][152], 1);

	inventory__TD[playerid][153] = CreatePlayerTextDraw(playerid, 259.000000, 260.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][153], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][153], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][153], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][153], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][153], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][153], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][153], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][153], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][153], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][153], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][153], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][153], 1);

	inventory__TD[playerid][154] = CreatePlayerTextDraw(playerid, 289.000000, 260.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][154], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][154], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][154], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][154], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][154], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][154], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][154], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][154], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][154], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][154], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][154], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][154], 1);

	inventory__TD[playerid][155] = CreatePlayerTextDraw(playerid, 319.000000, 260.000000, "mdl-8002:inv_bg_");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][155], 4);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][155], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][155], 30.000000, 30.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][155], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][155], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][155], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][155], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][155], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][155], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][155], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][155], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][155], 1);

	inventory__TD[playerid][156] = CreatePlayerTextDraw(playerid, 229.000000, 260.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][156], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][156], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][156], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][156], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][156], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][156], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][156], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][156], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][156], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][156], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][156], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][156], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][156], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][156], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][156], 1, 1);

	inventory__TD[playerid][157] = CreatePlayerTextDraw(playerid, 259.000000, 260.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][157], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][157], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][157], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][157], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][157], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][157], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][157], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][157], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][157], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][157], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][157], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][157], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][157], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][157], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][157], 1, 1);

	inventory__TD[playerid][158] = CreatePlayerTextDraw(playerid, 289.000000, 260.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][158], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][158], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][158], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][158], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][158], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][158], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][158], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][158], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][158], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][158], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][158], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][158], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][158], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][158], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][158], 1, 1);

	inventory__TD[playerid][159] = CreatePlayerTextDraw(playerid, 319.000000, 260.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][159], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][159], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][159], 29.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][159], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][159], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][159], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][159], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][159], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][159], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][159], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][159], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][159], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][159], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][159], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][159], 1, 1);

	inventory__TD[playerid][160] = CreatePlayerTextDraw(playerid, 244.000000, 265.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][160], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][160], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][160], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][160], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][160], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][160], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][160], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][160], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][160], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][160], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][160], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][160], 1);

	inventory__TD[playerid][161] = CreatePlayerTextDraw(playerid, 244.000000, 277.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][161], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][161], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][161], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][161], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][161], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][161], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][161], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][161], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][161], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][161], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][161], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][161], 1);

	inventory__TD[playerid][162] = CreatePlayerTextDraw(playerid, 274.000000, 265.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][162], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][162], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][162], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][162], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][162], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][162], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][162], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][162], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][162], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][162], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][162], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][162], 1);

	inventory__TD[playerid][163] = CreatePlayerTextDraw(playerid, 274.000000, 277.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][163], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][163], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][163], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][163], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][163], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][163], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][163], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][163], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][163], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][163], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][163], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][163], 1);

	inventory__TD[playerid][164] = CreatePlayerTextDraw(playerid, 304.000000, 265.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][164], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][164], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][164], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][164], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][164], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][164], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][164], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][164], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][164], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][164], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][164], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][164], 1);

	inventory__TD[playerid][165] = CreatePlayerTextDraw(playerid, 304.000000, 277.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][165], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][165], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][165], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][165], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][165], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][165], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][165], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][165], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][165], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][165], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][165], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][165], 1);

	inventory__TD[playerid][166] = CreatePlayerTextDraw(playerid, 334.000000, 265.000000, TranslateText( "Исп." ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][166], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][166], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][166], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][166], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][166], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][166], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][166], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][166], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][166], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][166], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][166], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][166], 1);

	inventory__TD[playerid][167] = CreatePlayerTextDraw(playerid, 334.000000, 277.000000, TranslateText( "Выбросить" ));
	PlayerTextDrawFont(playerid, inventory__TD[playerid][167], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][167], 0.137500, 0.800000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][167], 6.500000, 24.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][167], 0);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][167], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][167], 2);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][167], -764862721);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][167], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][167], -1962934017);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][167], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][167], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][167], 1);
	
	inventory__TD[playerid][168] = CreatePlayerTextDraw(playerid, 238.000000, 99.000000, "TextDraw");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][168], 5);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][168], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][168], 84.000000, 54.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][168], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][168], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][168], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][168], 255);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][168], 0);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][168], 12);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][168], 1);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][168], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][168], 1);
	PlayerTextDrawSetPreviewModel(playerid, inventory__TD[playerid][168], 355);
	PlayerTextDrawSetPreviewRot(playerid, inventory__TD[playerid][168], -10.000000, 0.000000, -20.000000, 1.900000);
	PlayerTextDrawSetPreviewVehCol(playerid, inventory__TD[playerid][168], 1, 1);

	inventory__TD[playerid][169] = CreatePlayerTextDraw(playerid, 307.000000, 118.000000, "50/1000");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][169], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][169], 0.350000, 1.500000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][169], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][169], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][169], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][169], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][169], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][169], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][169], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][169], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][169], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][169], 0);

	inventory__TD[playerid][170] = CreatePlayerTextDraw(playerid, 230.000000, 134.000000, "ak-47 (7,62x19)");
	PlayerTextDrawFont(playerid, inventory__TD[playerid][170], 1);
	PlayerTextDrawLetterSize(playerid, inventory__TD[playerid][170], 0.487500, 1.400000);
	PlayerTextDrawTextSize(playerid, inventory__TD[playerid][170], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, inventory__TD[playerid][170], 1);
	PlayerTextDrawSetShadow(playerid, inventory__TD[playerid][170], 0);
	PlayerTextDrawAlignment(playerid, inventory__TD[playerid][170], 1);
	PlayerTextDrawColor(playerid, inventory__TD[playerid][170], -1);
	PlayerTextDrawBackgroundColor(playerid, inventory__TD[playerid][170], 255);
	PlayerTextDrawBoxColor(playerid, inventory__TD[playerid][170], 50);
	PlayerTextDrawUseBox(playerid, inventory__TD[playerid][170], 0);
	PlayerTextDrawSetProportional(playerid, inventory__TD[playerid][170], 1);
	PlayerTextDrawSetSelectable(playerid, inventory__TD[playerid][170], 0);
	return 1;
}

stock DestroyAllInventory ( playerid )
{
	for(new td = 0; td < MAX_INV_TD; td++)  PlayerTextDrawDestroy(playerid, PlayerText: inventory__TD[playerid][td]);
	return 1;
}

stock UpdateTD ( playerid, PlayerText:td )
{
	PlayerTextDrawHide ( playerid, td );
	PlayerTextDrawShow ( playerid, td );

	return 1;
}

/*

	OnPlayerConnect;

*/
public OnPlayerConnect(playerid)
{
	CreatePlayerTextDraws(playerid);
	#if defined TD_OnPlayerConnect
		return TD_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect TD_OnPlayerConnect

#if defined TD_OnPlayerConnect
    forward TD_OnPlayerConnect(playerid);
#endif
/*

	OnPlayerDisconnect;

*/
public OnPlayerDisconnect(playerid, reason)
{
	DestroyPlayerTextDraws(playerid);
	#if defined TD_OnPlayerDisconnect
		return TD_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect TD_OnPlayerDisconnect

#if defined TD_OnPlayerDisconnect
    forward TD_OnPlayerDisconnect(playerid, reason);
#endif
/*

	OnGameModeInit;

*/
public OnGameModeInit()
{
	CreateTextDraws();
#if defined TD_OnGameModeInit
    return TD_OnGameModeInit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit TD_OnGameModeInit
#if defined   TD_OnGameModeInit
	forward TD_OnGameModeInit();
#endif 
/*

	OnGameModeExit;

*/
public OnGameModeExit()
{
	DestroyTextDraws();
#if defined TD_OnGameModeExit
    return TD_OnGameModeExit();
#else
    return 1;
#endif
}
#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit TD_OnGameModeExit
#if defined   TD_OnGameModeExit
	forward TD_OnGameModeExit();
#endif 