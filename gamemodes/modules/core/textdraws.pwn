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
	Text: users_panel_td[31],
	Text: progressbar_TD[2],
	Text:stats__global [ 24 ];

new 
	PlayerText: PanelReconAdmin_PTD[MAX_PLAYERS][2],
	// PlayerText: InfoPanel_PTD[MAX_PLAYERS][9],
	PlayerText: Speedomitr_PTD[MAX_PLAYERS][4],
	PlayerText: GPS_PTD[MAX_PLAYERS][1],
	PlayerText: craft_pila_PTD[MAX_PLAYERS][3],
	PlayerText: craft_stol_PTD[MAX_PLAYERS][3],
	PlayerText: craft_pech_PTD[MAX_PLAYERS][3],
	PlayerText: users_panel_ptd[MAX_PLAYERS][9],
	PlayerText: progressbar_PTD[MAX_PLAYERS][1],
	PlayerText:stats__player [ MAX_PLAYERS ] [ 22 ],
	PlayerText:regiser__menu[MAX_PLAYERS][13];

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
   	for(new td = 0; td < 31; td++) TextDrawDestroy(Text: users_panel_td[td]);
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
   	for(new td = 0; td < 31; td++) TextDrawHideForPlayer(playerid, Text: users_panel_td[td]);

	// Индивидуальные ТекстДравы:
	for(new ptd = 0; ptd < 2; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: PanelReconAdmin_PTD[playerid][ptd]);
	// for(new td = 0; td < 9; td++) PlayerTextDrawDestroy(playerid, PlayerText: InfoPanel_PTD[playerid][td]);
	for(new ptd = 0; ptd < 4; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: Speedomitr_PTD[playerid][ptd]);
	for(new ptd = 0; ptd < 3; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: craft_pila_PTD[playerid][ptd]);
	for(new ptd = 0; ptd < 3; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: craft_stol_PTD[playerid][ptd]);
	for(new ptd = 0; ptd < 3; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: craft_pech_PTD[playerid][ptd]);
	PlayerTextDrawDestroy(playerid, PlayerText: progressbar_PTD[playerid][0]);
	PlayerTextDrawDestroy(playerid, PlayerText: GPS_PTD[playerid][0]);
	for(new ptd = 0; ptd < 9; ptd++) PlayerTextDrawDestroy(playerid, PlayerText: users_panel_ptd[playerid][ptd]);
	return true;
}
stock CreateTextDraws()
{
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

	
	/*users_panel_td[0] = TextDrawCreate(499.4328, 6.0370, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[0], 103.0000, 103.5299);
	TextDrawColor(users_panel_td[0], 255);

	users_panel_td[1] = TextDrawCreate(491.1329, 2.9481, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[1], 18.0000, 19.0000);
	TextDrawColor(users_panel_td[1], 255);

	users_panel_td[2] = TextDrawCreate(593.9143, 2.9481, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[2], 18.0000, 19.0000);
	TextDrawColor(users_panel_td[2], 255);

	users_panel_td[3] = TextDrawCreate(494.1325, 12.4370, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[3], 114.8397, 92.3898);
	TextDrawColor(users_panel_td[3], 255);

	users_panel_td[4] = TextDrawCreate(492.4331, 4.4481, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[4], 18.0000, 19.0000);
	TextDrawColor(users_panel_td[4], -2139062017);

	users_panel_td[5] = TextDrawCreate(592.5147, 4.3481, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[5], 18.0000, 18.7098);
	TextDrawColor(users_panel_td[5], -2139062017);

	users_panel_td[6] = TextDrawCreate(502.6329, 7.7368, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[6], 98.2696, 83.9300);
	TextDrawColor(users_panel_td[6], -2139062017);

	users_panel_td[7] = TextDrawCreate(495.5327, 13.0368, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[7], 112.0400, 79.0000);
	TextDrawColor(users_panel_td[7], -2139062017);

	users_panel_td[8] = TextDrawCreate(496.4999, 20.0000, "Health:~n~Armour:~n~Kills:~n~Humanity:~n~Temperature:~n~Time:~n~Money:~n~Alive_time:~n~"); // Health:~n~Armour:~n~Kills:~n~Humanity:~n~Temperature:~n~Time:~n~Money:~n~Alive_time:~n~
	TextDrawLetterSize(users_panel_td[8], 0.1973, 0.8406);
	TextDrawAlignment(users_panel_td[8], 1);
	TextDrawColor(users_panel_td[8], -1);
	TextDrawBackgroundColor(users_panel_td[8], 255);
	TextDrawFont(users_panel_td[8], 1);
	TextDrawSetProportional(users_panel_td[8], 1);
	TextDrawSetShadow(users_panel_td[8], 0);

	users_panel_td[9] = TextDrawCreate(494.7998, 18.8999, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[9], 113.8795, 1.5398);
	TextDrawColor(users_panel_td[9], 255);

	users_panel_td[10] = TextDrawCreate(494.7998, 88.8991, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[10], 113.8795, 1.5398);
	TextDrawColor(users_panel_td[10], 255);

	users_panel_td[11] = TextDrawCreate(491.2330, 93.9470, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[11], 18.0000, 19.0000);
	TextDrawColor(users_panel_td[11], 255);

	users_panel_td[12] = TextDrawCreate(593.9143, 93.8470, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[12], 18.0000, 19.0000);
	TextDrawColor(users_panel_td[12], 255);

	users_panel_td[13] = TextDrawCreate(492.5331, 92.0473, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[13], 18.0000, 19.0000);
	TextDrawColor(users_panel_td[13], -2139062017);

	users_panel_td[14] = TextDrawCreate(592.6146, 92.0473, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[14], 18.0000, 18.7098);
	TextDrawColor(users_panel_td[14], -2139062017);

	users_panel_td[15] = TextDrawCreate(495.5327, 91.8359, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[15], 111.8097, 10.0000);
	TextDrawColor(users_panel_td[15], -2139062017);

	users_panel_td[16] = TextDrawCreate(502.6329, 92.1361, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[16], 98.6603, 15.6198);
	TextDrawColor(users_panel_td[16], -2139062017);

	users_panel_td[17] = TextDrawCreate(493.1997, 87.5998, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[17], 20.0000, 23.0000);
	TextDrawColor(users_panel_td[17], 100);

	users_panel_td[18] = TextDrawCreate(509.2008, 87.5998, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[18], 20.0000, 23.0000);
	TextDrawColor(users_panel_td[18], 100);

	users_panel_td[19] = TextDrawCreate(525.1978, 87.5998, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[19], 20.0000, 23.0000);
	TextDrawColor(users_panel_td[19], 100);

	users_panel_td[20] = TextDrawCreate(541.0938, 87.5998, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[20], 20.0000, 23.0000);
	TextDrawColor(users_panel_td[20], 100);

	users_panel_td[21] = TextDrawCreate(557.4899, 87.5998, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[21], 20.0000, 23.0000);
	TextDrawColor(users_panel_td[21], 100);

	users_panel_td[22] = TextDrawCreate(573.6859, 87.5998, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[22], 20.0000, 23.0000);
	TextDrawColor(users_panel_td[22], 100);

	users_panel_td[23] = TextDrawCreate(589.7821, 87.5998, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[23], 20.0000, 23.0000);
	TextDrawColor(users_panel_td[23], 100);

	users_panel_td[24] = TextDrawCreate(491.0328, 105.6470, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[24], 25.0000, 29.0000);
	TextDrawColor(users_panel_td[24], 255);

	users_panel_td[25] = TextDrawCreate(503.0000, 110.5998, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[25], 95.1912, 19.1399);
	TextDrawColor(users_panel_td[25], 255);

	users_panel_td[26] = TextDrawCreate(587.5159, 105.6470, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[26], 25.0000, 29.0000);
	TextDrawColor(users_panel_td[26], 255);

	users_panel_td[27] = TextDrawCreate(493.6332, 108.2470, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[27], 18.0000, 23.7800);
	TextDrawColor(users_panel_td[27], -2139062017);

	users_panel_td[28] = TextDrawCreate(503.0000, 112.1997, "LD_SPAC:white"); // пусто
	TextDrawTextSize(users_panel_td[28], 97.5118, 15.9699);
	TextDrawColor(users_panel_td[28], -2139062017);

	users_panel_td[29] = TextDrawCreate(591.9146, 108.2470, "LD_BEAT:chit"); // пусто
	TextDrawTextSize(users_panel_td[29], 18.0000, 23.7800);
	TextDrawColor(users_panel_td[29], -2139062017);

	users_panel_td[30] = TextDrawCreate(607.5949, 12.8000, "Reloot:_03:15"); // пусто
	TextDrawLetterSize(users_panel_td[30], 0.1219, 0.6334);
	TextDrawTextSize(users_panel_td[30], -7.0000, 0.0000);
	TextDrawAlignment(users_panel_td[30], 3);
	TextDrawColor(users_panel_td[30], -1);
	TextDrawBackgroundColor(users_panel_td[30], 255);
	TextDrawFont(users_panel_td[30], 1);
	TextDrawSetProportional(users_panel_td[30], 1);
	TextDrawSetShadow(users_panel_td[30], 0);
	for(new td = 0; td < 31; td++)
	{
		switch(td)
		{
		case 8, 30: continue;
		}
		TextDrawAlignment(users_panel_td[td], 1);
		TextDrawBackgroundColor(users_panel_td[td], 255);
		TextDrawFont(users_panel_td[td], 4);
		TextDrawSetProportional(users_panel_td[td], 0);
		TextDrawSetShadow(users_panel_td[td], 0);
	}*/
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
	
	/*
	users_panel_ptd[playerid][0] = CreatePlayerTextDraw(playerid, 550.7993, 8.3000, "_"); // Miguel_Carter_(105)
	PlayerTextDrawLetterSize(playerid, users_panel_ptd[playerid][0], 0.1634, 0.9279);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][0], 2);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][0], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][0], 0);

	users_panel_ptd[playerid][1] = CreatePlayerTextDraw(playerid, 604.6782, 20.0000, "99~n~12000~n~100~n~0~n~1000~n~36.6~n~12:22:05~n~1000000~n~10:45:03~n~"); // пусто
	PlayerTextDrawLetterSize(playerid, users_panel_ptd[playerid][1], 0.1973, 0.8406);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][1], 3);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][1], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][1], 0);

	users_panel_ptd[playerid][2] = CreatePlayerTextDraw(playerid, 498.2001, 93.0000, "hud:radar_centre"); // пусто
	PlayerTextDrawTextSize(playerid, users_panel_ptd[playerid][2], 10.0000, 12.0000);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][2], 1);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][2], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][2], 0);

	users_panel_ptd[playerid][3] = CreatePlayerTextDraw(playerid, 515.8001, 94.1997, "hud:radar_datedrink"); // пусто
	PlayerTextDrawTextSize(playerid, users_panel_ptd[playerid][3], 7.3298, 10.0000);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][3], 1);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][3], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][3], 0);

	users_panel_ptd[playerid][4] = CreatePlayerTextDraw(playerid, 531.0963, 93.9000, "hud:radar_dateFood"); // пусто
	PlayerTextDrawTextSize(playerid, users_panel_ptd[playerid][4], 8.3100, 10.5798);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][4], 1);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][4], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][4], 0);

	users_panel_ptd[playerid][5] = CreatePlayerTextDraw(playerid, 596.5805, 94.4999, "hud:radar_thetruth"); // пусто
	PlayerTextDrawTextSize(playerid, users_panel_ptd[playerid][5], 7.1999, 9.6297);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][5], 1);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][5], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][5], 0);

	users_panel_ptd[playerid][6] = CreatePlayerTextDraw(playerid, 579.6845, 93.4000, "hud:radar_locosyndicate"); // пусто
	PlayerTextDrawTextSize(playerid, users_panel_ptd[playerid][6], 8.1998, 11.5398);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][6], 1);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][6], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][6], 0);

	users_panel_ptd[playerid][7] = CreatePlayerTextDraw(playerid, 532.3001, 112.5998, "Gun:_Sniper_Rifle~n~Ammo:_550"); // пусто
	PlayerTextDrawLetterSize(playerid, users_panel_ptd[playerid][7], 0.1613, 0.7796);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][7], 1);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][7], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][7], 0);

	users_panel_ptd[playerid][8] = CreatePlayerTextDraw(playerid, 546.6660, 94.4073, "hud:radar_zero"); // пусто
	PlayerTextDrawTextSize(playerid, users_panel_ptd[playerid][8], 9.2700, 9.5298);
	PlayerTextDrawAlignment(playerid, users_panel_ptd[playerid][8], 1);
	PlayerTextDrawColor(playerid, users_panel_ptd[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, users_panel_ptd[playerid][8], 255);
	PlayerTextDrawFont(playerid, users_panel_ptd[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, users_panel_ptd[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, users_panel_ptd[playerid][8], 0);
	
	progressbar_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 274.5998, 360.6184, "LD_SPAC:white"); // пусто
	PlayerTextDrawTextSize(playerid, progressbar_PTD[playerid][0], 0.0, 15.0598); // 86.4996
	PlayerTextDrawAlignment(playerid, progressbar_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, progressbar_PTD[playerid][0], -2139062017);
	PlayerTextDrawBackgroundColor(playerid, progressbar_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, progressbar_PTD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, progressbar_PTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, progressbar_PTD[playerid][0], 0);*/
	return true;
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