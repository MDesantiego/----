//Штурмовик
#define MAX_STAMINA_SHTURM		200.0
#define STAMINA_SHTUMR_P		20
#define KD_SHTURM_GRANATA		2
#define KD_SHTURM_BAZYKA		10
/*
	Штурмовик:
	Стамина - 200 (Стандарт 100), Увелеченное восстановление стамины - 20/s (стандарт 10/s) 
	Создание гранаты (КД 2 минуты) - без компонентов
	Создать базуку (КД 10 минут) - без компонентов
*/

/*
new PlayerText:LobbyStats[MAX_PLAYERS][5]; // Текстдравы для статистики
new PlayerText:LobbySkin[MAX_PLAYERS][4]; // Текстдравы скинов
new Text:Lobby[39]; // Основные текстдравы

CMD:for__ ( playerid )
{
	test__ ( playerid );
	return 1;
}

stock test__ ( playerid )
{
    Lobby[0] = TextDrawCreate(490.527130, 124.083396, "box");
    TextDrawLetterSize(Lobby[0], 0.000000, 6.860908);
    TextDrawTextSize(Lobby[0], 619.000000, 0.000000);
    TextDrawAlignment(Lobby[0], 1);
    TextDrawColor(Lobby[0], -1);
    TextDrawUseBox(Lobby[0], 1);
    TextDrawBoxColor(Lobby[0], 1166189055);
    TextDrawBackgroundColor(Lobby[0], 255);
    TextDrawFont(Lobby[0], 1);
    TextDrawSetProportional(Lobby[0], 1);

    Lobby[1] = TextDrawCreate(490.995635, 124.666778, "box");
    TextDrawLetterSize(Lobby[1], 0.000000, 1.379212);
    TextDrawTextSize(Lobby[1], 619.000000, 0.000000);
    TextDrawAlignment(Lobby[1], 1);
    TextDrawColor(Lobby[1], -1);
    TextDrawUseBox(Lobby[1], 1);
    TextDrawBoxColor(Lobby[1], 1048090367);
    TextDrawBackgroundColor(Lobby[1], 255);
    TextDrawFont(Lobby[1], 1);
    TextDrawSetProportional(Lobby[1], 1);

    Lobby[2] = TextDrawCreate(510.204986, 124.666656, "Выберите персонажа");
    TextDrawLetterSize(Lobby[2], 0.195721, 1.244166);
    TextDrawTextSize(Lobby[2], 880.000000, 0.000000);
    TextDrawAlignment(Lobby[2], 1);
    TextDrawColor(Lobby[2], -1);
    TextDrawBackgroundColor(Lobby[2], 255);
    TextDrawFont(Lobby[2], 2);
    TextDrawSetProportional(Lobby[2], 1);

    Lobby[3] = TextDrawCreate(494.743835, 149.750045, "box");
    TextDrawLetterSize(Lobby[3], 0.000000, 3.534408);
    TextDrawTextSize(Lobby[3], 616.000000, 0.000000);
    TextDrawAlignment(Lobby[3], 1);
    TextDrawColor(Lobby[3], -1);
    TextDrawUseBox(Lobby[3], 1);
    TextDrawBoxColor(Lobby[3], 1048090367);
    TextDrawBackgroundColor(Lobby[3], 255);
    TextDrawFont(Lobby[3], 1);
    TextDrawSetProportional(Lobby[3], 1);

    Lobby[4] = TextDrawCreate(490.995574, 192.916748, "box");
    TextDrawLetterSize(Lobby[4], 0.000000, 22.556364);
    TextDrawTextSize(Lobby[4], 619.000000, 0.000000);
    TextDrawAlignment(Lobby[4], 1);
    TextDrawColor(Lobby[4], -1);
    TextDrawUseBox(Lobby[4], 1);
    TextDrawBoxColor(Lobby[4], 1166189055);
    TextDrawBackgroundColor(Lobby[4], 255);
    TextDrawFont(Lobby[4], 1);
    TextDrawSetProportional(Lobby[4], 1);

    Lobby[5] = TextDrawCreate(490.995635, 193.500152, "box");
    TextDrawLetterSize(Lobby[5], 0.000000, 1.379212);
    TextDrawTextSize(Lobby[5], 619.000000, 0.000000);
    TextDrawAlignment(Lobby[5], 1);
    TextDrawColor(Lobby[5], -1);
    TextDrawUseBox(Lobby[5], 1);
    TextDrawBoxColor(Lobby[5], 1048090367);
    TextDrawBackgroundColor(Lobby[5], 255);
    TextDrawFont(Lobby[5], 1);
    TextDrawSetProportional(Lobby[5], 1);

    Lobby[6] = TextDrawCreate(530.820129, 194.083328, "статистика");
    TextDrawLetterSize(Lobby[6], 0.195721, 1.244166);
    TextDrawTextSize(Lobby[6], 880.000000, 0.000000);
    TextDrawAlignment(Lobby[6], 1);
    TextDrawColor(Lobby[6], -1);
    TextDrawBackgroundColor(Lobby[6], 255);
    TextDrawFont(Lobby[6], 2);
    TextDrawSetProportional(Lobby[6], 1);

    Lobby[7] = TextDrawCreate(494.275390, 220.916748, "box");
    TextDrawLetterSize(Lobby[7], 0.000000, 18.808198);
    TextDrawTextSize(Lobby[7], 616.000000, 0.000000);
    TextDrawAlignment(Lobby[7], 1);
    TextDrawColor(Lobby[7], -1);
    TextDrawUseBox(Lobby[7], 1);
    TextDrawBoxColor(Lobby[7], 1048090367);
    TextDrawBackgroundColor(Lobby[7], 255);
    TextDrawFont(Lobby[7], 1);
    TextDrawSetProportional(Lobby[7], 1);

    Lobby[8] = TextDrawCreate(495.680847, 223.250061, "box");
    TextDrawLetterSize(Lobby[8], 0.000000, 1.004394);
    TextDrawTextSize(Lobby[8], 544.000000, 0.000000);
    TextDrawAlignment(Lobby[8], 1);
    TextDrawColor(Lobby[8], 1166189055);
    TextDrawUseBox(Lobby[8], 1);
    TextDrawBoxColor(Lobby[8], 1166189055);
    TextDrawBackgroundColor(Lobby[8], 255);
    TextDrawFont(Lobby[8], 1);
    TextDrawSetProportional(Lobby[8], 1);

    Lobby[9] = TextDrawCreate(495.480804, 237.083450, "box");
    TextDrawLetterSize(Lobby[9], 0.000000, 1.613471);
    TextDrawTextSize(Lobby[9], 615.000000, 0.000000);
    TextDrawAlignment(Lobby[9], 1);
    TextDrawColor(Lobby[9], 1166189055);
    TextDrawUseBox(Lobby[9], 1);
    TextDrawBoxColor(Lobby[9], 1166189055);
    TextDrawBackgroundColor(Lobby[9], 255);
    TextDrawFont(Lobby[9], 1);
    TextDrawSetProportional(Lobby[9], 1);

    Lobby[10] = TextDrawCreate(495.512176, 258.166778, "box");
    TextDrawLetterSize(Lobby[10], 0.000000, 1.144950);
    TextDrawTextSize(Lobby[10], 546.000000, 0.000000);
    TextDrawAlignment(Lobby[10], 1);
    TextDrawColor(Lobby[10], 1166189055);
    TextDrawUseBox(Lobby[10], 1);
    TextDrawBoxColor(Lobby[10], 1166189055);
    TextDrawBackgroundColor(Lobby[10], 255);
    TextDrawFont(Lobby[10], 1);
    TextDrawSetProportional(Lobby[10], 1);

    Lobby[11] = TextDrawCreate(495.180816, 271.683593, "box");
    TextDrawLetterSize(Lobby[11], 0.000000, 1.613471);
    TextDrawTextSize(Lobby[11], 615.000000, 0.000000);
    TextDrawAlignment(Lobby[11], 1);
    TextDrawColor(Lobby[11], 1166189055);
    TextDrawUseBox(Lobby[11], 1);
    TextDrawBoxColor(Lobby[11], 1166189055);
    TextDrawBackgroundColor(Lobby[11], 255);
    TextDrawFont(Lobby[11], 1);
    TextDrawSetProportional(Lobby[11], 1);

    Lobby[12] = TextDrawCreate(495.443664, 292.583465, "box");
    TextDrawLetterSize(Lobby[12], 0.000000, 1.144950);
    TextDrawTextSize(Lobby[12], 546.399902, 0.000000);
    TextDrawAlignment(Lobby[12], 1);
    TextDrawColor(Lobby[12], 1166189055);
    TextDrawUseBox(Lobby[12], 1);
    TextDrawBoxColor(Lobby[12], 1166189055);
    TextDrawBackgroundColor(Lobby[12], 255);
    TextDrawFont(Lobby[12], 1);
    TextDrawSetProportional(Lobby[12], 1);

    Lobby[13] = TextDrawCreate(495.212249, 307.333557, "box");
    TextDrawLetterSize(Lobby[13], 0.000000, 1.472916);
    TextDrawTextSize(Lobby[13], 615.000000, 0.000000);
    TextDrawAlignment(Lobby[13], 1);
    TextDrawColor(Lobby[13], 1166189055);
    TextDrawUseBox(Lobby[13], 1);
    TextDrawBoxColor(Lobby[13], 1166189055);
    TextDrawBackgroundColor(Lobby[13], 255);
    TextDrawFont(Lobby[13], 1);
    TextDrawSetProportional(Lobby[13], 1);

    Lobby[14] = TextDrawCreate(495.606536, 326.633514, "box");
    TextDrawLetterSize(Lobby[14], 0.000000, 1.191802);
    TextDrawTextSize(Lobby[14], 548.899780, 0.000000);
    TextDrawAlignment(Lobby[14], 1);
    TextDrawColor(Lobby[14], 1166189055);
    TextDrawUseBox(Lobby[14], 1);
    TextDrawBoxColor(Lobby[14], 1166189055);
    TextDrawBackgroundColor(Lobby[14], 255);
    TextDrawFont(Lobby[14], 1);
    TextDrawSetProportional(Lobby[14], 1);

    Lobby[15] = TextDrawCreate(494.837890, 339.833404, "box");
    TextDrawLetterSize(Lobby[15], 0.000000, 1.566619);
    TextDrawTextSize(Lobby[15], 615.000000, 0.000000);
    TextDrawAlignment(Lobby[15], 1);
    TextDrawColor(Lobby[15], 1166189055);
    TextDrawUseBox(Lobby[15], 1);
    TextDrawBoxColor(Lobby[15], 1166189055);
    TextDrawBackgroundColor(Lobby[15], 255);
    TextDrawFont(Lobby[15], 1);
    TextDrawSetProportional(Lobby[15], 1);

    Lobby[16] = TextDrawCreate(495.037902, 360.000183, "box");
    TextDrawLetterSize(Lobby[16], 0.000000, 1.285506);
    TextDrawTextSize(Lobby[16], 550.000000, 0.000000);
    TextDrawAlignment(Lobby[16], 1);
    TextDrawColor(Lobby[16], 1166189055);
    TextDrawUseBox(Lobby[16], 1);
    TextDrawBoxColor(Lobby[16], 1166189055);
    TextDrawBackgroundColor(Lobby[16], 255);
    TextDrawFont(Lobby[16], 1);
    TextDrawSetProportional(Lobby[16], 1);

    Lobby[17] = TextDrawCreate(495.574951, 375.416748, "box");
    TextDrawLetterSize(Lobby[17], 0.000000, 1.566619);
    TextDrawTextSize(Lobby[17], 615.000000, 0.000000);
    TextDrawAlignment(Lobby[17], 1);
    TextDrawColor(Lobby[17], 1166189055);
    TextDrawUseBox(Lobby[17], 1);
    TextDrawBoxColor(Lobby[17], 1166189055);
    TextDrawBackgroundColor(Lobby[17], 255);
    TextDrawFont(Lobby[17], 1);
    TextDrawSetProportional(Lobby[17], 1);

    Lobby[18] = TextDrawCreate(497.086456, 239.000000, "0x3E7896FF");
    TextDrawLetterSize(Lobby[18], 0.000000, 1.144950);
    TextDrawTextSize(Lobby[18], 614.000000, 0.000000);
    TextDrawAlignment(Lobby[18], 1);
    TextDrawColor(Lobby[18], -1);
    TextDrawUseBox(Lobby[18], 1);
    TextDrawBoxColor(Lobby[18], 1048090367);
    TextDrawBackgroundColor(Lobby[18], 255);
    TextDrawFont(Lobby[18], 1);
    TextDrawSetProportional(Lobby[18], 1);

    Lobby[19] = TextDrawCreate(496.949462, 273.250000, "0x3E7896FF");
    TextDrawLetterSize(Lobby[19], 0.000000, 1.144950);
    TextDrawTextSize(Lobby[19], 614.000000, 0.000000);
    TextDrawAlignment(Lobby[19], 1);
    TextDrawColor(Lobby[19], -1);
    TextDrawUseBox(Lobby[19], 1);
    TextDrawBoxColor(Lobby[19], 1048090367);
    TextDrawBackgroundColor(Lobby[19], 255);
    TextDrawFont(Lobby[19], 1);
    TextDrawSetProportional(Lobby[19], 1);

    Lobby[20] = TextDrawCreate(496.486419, 308.133239, "0x3E7896FF");
    TextDrawLetterSize(Lobby[20], 0.000000, 1.144950);
    TextDrawTextSize(Lobby[20], 614.100219, 0.000000);
    TextDrawAlignment(Lobby[20], 1);
    TextDrawColor(Lobby[20], -1);
    TextDrawUseBox(Lobby[20], 1);
    TextDrawBoxColor(Lobby[20], 1048090367);
    TextDrawBackgroundColor(Lobby[20], 255);
    TextDrawFont(Lobby[20], 1);
    TextDrawSetProportional(Lobby[20], 1);

    Lobby[21] = TextDrawCreate(496.317932, 341.483276, "0x3E7896FF");
    TextDrawLetterSize(Lobby[21], 0.000000, 1.098098);
    TextDrawTextSize(Lobby[21], 614.000000, 0.000000);
    TextDrawAlignment(Lobby[21], 1);
    TextDrawColor(Lobby[21], -1);
    TextDrawUseBox(Lobby[21], 1);
    TextDrawBoxColor(Lobby[21], 1048090367);
    TextDrawBackgroundColor(Lobby[21], 255);
    TextDrawFont(Lobby[21], 1);
    TextDrawSetProportional(Lobby[21], 1);

    Lobby[22] = TextDrawCreate(498.023559, 377.149932, "0x3E7896FF");
    TextDrawLetterSize(Lobby[22], 0.000000, 1.098098);
    TextDrawTextSize(Lobby[22], 614.299926, 0.000000);
    TextDrawAlignment(Lobby[22], 1);
    TextDrawColor(Lobby[22], -1);
    TextDrawUseBox(Lobby[22], 1);
    TextDrawBoxColor(Lobby[22], 1048090367);
    TextDrawBackgroundColor(Lobby[22], 255);
    TextDrawFont(Lobby[22], 1);
    TextDrawSetProportional(Lobby[22], 1);

    Lobby[23] = TextDrawCreate(498.023651, 223.833328, "ИМЯ");
    TextDrawLetterSize(Lobby[23], 0.245856, 0.829999);
    TextDrawAlignment(Lobby[23], 1);
    TextDrawColor(Lobby[23], -1);
    TextDrawBackgroundColor(Lobby[23], 255);
    TextDrawFont(Lobby[23], 2);
    TextDrawSetProportional(Lobby[23], 1);

    Lobby[24] = TextDrawCreate(498.023712, 259.416687, "Уровень");
    TextDrawLetterSize(Lobby[24], 0.214465, 0.818332);
    TextDrawAlignment(Lobby[24], 1);
    TextDrawColor(Lobby[24], -1);
    TextDrawBackgroundColor(Lobby[24], 255);
    TextDrawFont(Lobby[24], 2);
    TextDrawSetProportional(Lobby[24], 1);

    Lobby[25] = TextDrawCreate(499.497802, 294.016601, "Работа");
    TextDrawLetterSize(Lobby[25], 0.232268, 0.759998);
    TextDrawTextSize(Lobby[25], -29.000000, 0.000000);
    TextDrawAlignment(Lobby[25], 1);
    TextDrawColor(Lobby[25], -1);
    TextDrawBackgroundColor(Lobby[25], 255);
    TextDrawFont(Lobby[25], 2);
    TextDrawSetProportional(Lobby[25], 1);

    Lobby[26] = TextDrawCreate(499.497741, 327.850006, "ДЕНЬГИ");
    TextDrawLetterSize(Lobby[26], 0.219150, 0.812497);
    TextDrawAlignment(Lobby[26], 1);
    TextDrawColor(Lobby[26], -1);
    TextDrawBackgroundColor(Lobby[26], 255);
    TextDrawFont(Lobby[26], 2);
    TextDrawSetProportional(Lobby[26], 1);

    Lobby[27] = TextDrawCreate(498.092224, 361.683288, "ЧАСОВ В ИГРЕ");
    TextDrawLetterSize(Lobby[27], 0.171360, 0.864997);
    TextDrawTextSize(Lobby[27], 812.000000, 0.000000);
    TextDrawAlignment(Lobby[27], 1);
    TextDrawColor(Lobby[27], -1);
    TextDrawBackgroundColor(Lobby[27], 255);
    TextDrawFont(Lobby[27], 2);
    TextDrawSetProportional(Lobby[27], 1);

    Lobby[28] = TextDrawCreate(248.751113, 385.833343, "");
    TextDrawTextSize(Lobby[28], 133.000000, 24.000000);
    TextDrawAlignment(Lobby[28], 1);
    TextDrawColor(Lobby[28], -1);
    TextDrawBackgroundColor(Lobby[28], 1048090282);
    TextDrawFont(Lobby[28], 5);
    TextDrawSetProportional(Lobby[28], 0);
    TextDrawSetSelectable(Lobby[28], true);
    TextDrawSetPreviewModel(Lobby[28], 123);
    TextDrawSetPreviewRot(Lobby[28], 0.000000, 0.000000, 0.000000, 31.000000);

    Lobby[29] = TextDrawCreate(277.170379, 391.049957, TranslateText("НАЧАТЬ ИГРУ"));
    TextDrawLetterSize(Lobby[29], 0.400000, 1.600000);
    TextDrawTextSize(Lobby[29], 400.000000, 0.000000);
    TextDrawAlignment(Lobby[29], 1);
    TextDrawColor(Lobby[29], -1);
    TextDrawBackgroundColor(Lobby[29], 255);
    TextDrawFont(Lobby[29], 1);
    TextDrawSetProportional(Lobby[29], 1);

    Lobby[30] = TextDrawCreate(31.376304, 157.916671, "box");
    TextDrawLetterSize(Lobby[30], 0.000000, 7.704246);
    TextDrawTextSize(Lobby[30], 176.000000, 0.000000);
    TextDrawAlignment(Lobby[30], 1);
    TextDrawColor(Lobby[30], -1);
    TextDrawUseBox(Lobby[30], 1);
    TextDrawBoxColor(Lobby[30], 1166189055);
    TextDrawBackgroundColor(Lobby[30], 255);
    TextDrawFont(Lobby[30], 2);
    TextDrawSetProportional(Lobby[30], 1);

    Lobby[31] = TextDrawCreate(31.376295, 157.333374, "box");
    TextDrawLetterSize(Lobby[31], 0.000000, 1.285506);
    TextDrawTextSize(Lobby[31], 176.000000, 0.000000);
    TextDrawAlignment(Lobby[31], 1);
    TextDrawColor(Lobby[31], -1);
    TextDrawUseBox(Lobby[31], 1);
    TextDrawBoxColor(Lobby[31], 1048090367);
    TextDrawBackgroundColor(Lobby[31], 255);
    TextDrawFont(Lobby[31], 1);
    TextDrawSetProportional(Lobby[31], 1);

    Lobby[32] = TextDrawCreate(66.983886, 158.499969, TranslateText("ДОБРО ПОЖАЛОВАТЬ"));
    TextDrawLetterSize(Lobby[32], 0.179793, 1.057499);
    TextDrawTextSize(Lobby[32], 363.000000, 0.000000);
    TextDrawAlignment(Lobby[32], 1);
    TextDrawColor(Lobby[32], -1);
    TextDrawBackgroundColor(Lobby[32], 255);
    TextDrawFont(Lobby[32], 2);
    TextDrawSetProportional(Lobby[32], 1);

    Lobby[33] = TextDrawCreate(32.781833, 175.416671, "box");
    TextDrawLetterSize(Lobby[33], 0.000000, 5.502195);
    TextDrawTextSize(Lobby[33], 174.000000, 0.000000);
    TextDrawAlignment(Lobby[33], 1);
    TextDrawColor(Lobby[33], -1);
    TextDrawUseBox(Lobby[33], 1);
    TextDrawBoxColor(Lobby[33], 1048090367);
    TextDrawBackgroundColor(Lobby[33], 255);
    TextDrawFont(Lobby[33], 1);
    TextDrawSetProportional(Lobby[33], 1);

    Lobby[34] = TextDrawCreate(36.998573, 181.249984, TranslateText("Мы рады видеть вас. Чтобы начать играть, выберите себе персонажа"));
    TextDrawLetterSize(Lobby[34], 0.202750, 1.016666);
    TextDrawTextSize(Lobby[34], 161.000000, 0.000000);
    TextDrawAlignment(Lobby[34], 1);
    TextDrawColor(Lobby[34], -1);
    TextDrawBackgroundColor(Lobby[34], 255);
    TextDrawFont(Lobby[34], 1);
    TextDrawSetProportional(Lobby[34], 1);

    Lobby[35] = TextDrawCreate(249.070465, 411.666534, "");
    TextDrawTextSize(Lobby[35], 64.000000, 11.000000);
    TextDrawAlignment(Lobby[35], 1);
    TextDrawColor(Lobby[35], -1);
    TextDrawBackgroundColor(Lobby[35], 2041007103);
    TextDrawFont(Lobby[35], 5);
    TextDrawSetProportional(Lobby[35], 0);
    TextDrawSetSelectable(Lobby[35], true);
    TextDrawSetPreviewModel(Lobby[35], 123);
    TextDrawSetPreviewRot(Lobby[35], 0.000000, 0.000000, 0.000000, 123.000000);

    Lobby[36] = TextDrawCreate(252.986434, 412.250030, TranslateText("______Начать игру"));
    TextDrawLetterSize(Lobby[36], 0.181669, 1.010833);
    TextDrawTextSize(Lobby[36], 767.000000, 0.000000);
    TextDrawAlignment(Lobby[36], 1);
    TextDrawColor(Lobby[36], -1);
    TextDrawBackgroundColor(Lobby[36], 255);
    TextDrawFont(Lobby[36], 1);
    TextDrawSetProportional(Lobby[36], 1);

    Lobby[37] = TextDrawCreate(317.474670, 411.666534, "");
    TextDrawTextSize(Lobby[37], 64.000000, 11.000000);
    TextDrawAlignment(Lobby[37], 1);
    TextDrawColor(Lobby[37], -1);
    TextDrawBackgroundColor(Lobby[37], -764782934);
    TextDrawFont(Lobby[37], 5);
    TextDrawSetProportional(Lobby[37], 0);
    TextDrawSetSelectable(Lobby[37], true);
    TextDrawSetPreviewModel(Lobby[37], 123);
    TextDrawSetPreviewRot(Lobby[37], 0.000000, 0.000000, 0.000000, 123.000000);

    Lobby[38] = TextDrawCreate(339.663085, 412.250000, TranslateText("___<<"));
    TextDrawLetterSize(Lobby[38], 0.181669, 1.010833);
    TextDrawTextSize(Lobby[38], 767.000000, 0.000000);
    TextDrawAlignment(Lobby[38], 1);
    TextDrawColor(Lobby[38], -1);
    TextDrawBackgroundColor(Lobby[38], 255);
    TextDrawFont(Lobby[38], 1);
    TextDrawSetProportional(Lobby[38], 1);

    for(new i; i != sizeof(Lobby); i++) TextDrawSetShadow(Lobby[i], 0);
  
  
    // Текстдравы для игрока
    LobbyStats[playerid][0] = CreatePlayerTextDraw(playerid, 528.477661, 240.166656, "Bob_Diller");
    PlayerTextDrawSetShadow(playerid, LobbyStats[playerid][0], 0);
    PlayerTextDrawLetterSize(playerid, LobbyStats[playerid][0], 0.245856, 0.829999);
    PlayerTextDrawAlignment(playerid, LobbyStats[playerid][0], 1);
    PlayerTextDrawColor(playerid, LobbyStats[playerid][0], -1061109505);
    PlayerTextDrawBackgroundColor(playerid, LobbyStats[playerid][0], 255);
    PlayerTextDrawFont(playerid, LobbyStats[playerid][0], 2);
    PlayerTextDrawSetProportional(playerid, LobbyStats[playerid][0], 1);

    LobbyStats[playerid][1] = CreatePlayerTextDraw(playerid, 553.309387, 275.166778, "21");
    PlayerTextDrawSetShadow(playerid, LobbyStats[playerid][1], 0);
    PlayerTextDrawLetterSize(playerid, LobbyStats[playerid][1], 0.245856, 0.829999);
    PlayerTextDrawAlignment(playerid, LobbyStats[playerid][1], 1);
    PlayerTextDrawColor(playerid, LobbyStats[playerid][1], -1061109505);
    PlayerTextDrawBackgroundColor(playerid, LobbyStats[playerid][1], 255);
    PlayerTextDrawFont(playerid, LobbyStats[playerid][1], 2);
    PlayerTextDrawSetProportional(playerid, LobbyStats[playerid][1], 1);

    LobbyStats[playerid][2] = CreatePlayerTextDraw(playerid, 516.833435, 309.183197, "Police LS / CHERIFF");
    PlayerTextDrawSetShadow(playerid, LobbyStats[playerid][2], 0);
    PlayerTextDrawLetterSize(playerid, LobbyStats[playerid][2], 0.213994, 0.853331);
    PlayerTextDrawTextSize(playerid, LobbyStats[playerid][2], 936.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, LobbyStats[playerid][2], 1);
    PlayerTextDrawColor(playerid, LobbyStats[playerid][2], -1061109505);
    PlayerTextDrawBackgroundColor(playerid, LobbyStats[playerid][2], 255);
    PlayerTextDrawFont(playerid, LobbyStats[playerid][2], 2);
    PlayerTextDrawSetProportional(playerid, LobbyStats[playerid][2], 1);

    LobbyStats[playerid][3] = CreatePlayerTextDraw(playerid, 555.720703, 342.433074, "$650");
    PlayerTextDrawSetShadow(playerid, LobbyStats[playerid][3], 0);
    PlayerTextDrawLetterSize(playerid, LobbyStats[playerid][3], 0.213994, 0.853331);
    PlayerTextDrawTextSize(playerid, LobbyStats[playerid][3], 0.000000, 936.000000);
    PlayerTextDrawAlignment(playerid, LobbyStats[playerid][3], 2);
    PlayerTextDrawColor(playerid, LobbyStats[playerid][3], -1061109505);
    PlayerTextDrawBackgroundColor(playerid, LobbyStats[playerid][3], 255);
    PlayerTextDrawFont(playerid, LobbyStats[playerid][3], 2);
    PlayerTextDrawSetProportional(playerid, LobbyStats[playerid][3], 1);

    LobbyStats[playerid][4] = CreatePlayerTextDraw(playerid, 556.657775, 377.433105, "61");
    PlayerTextDrawSetShadow(playerid, LobbyStats[playerid][4], 0);
    PlayerTextDrawLetterSize(playerid, LobbyStats[playerid][4], 0.213994, 0.853331);
    PlayerTextDrawTextSize(playerid, LobbyStats[playerid][4], 0.000000, 931.000000);
    PlayerTextDrawAlignment(playerid, LobbyStats[playerid][4], 2);
    PlayerTextDrawColor(playerid, LobbyStats[playerid][4], -1061109505);
    PlayerTextDrawBackgroundColor(playerid, LobbyStats[playerid][4], 255);
    PlayerTextDrawFont(playerid, LobbyStats[playerid][4], 2);
    PlayerTextDrawSetProportional(playerid, LobbyStats[playerid][4], 1);


    LobbySkin[playerid][0] = CreatePlayerTextDraw(playerid, 494.480895, 150.233337, " ");
    PlayerTextDrawTextSize(playerid, LobbySkin[playerid][0], 29.000000, 30.000000);
    PlayerTextDrawAlignment(playerid, LobbySkin[playerid][0], 1);
    PlayerTextDrawColor(playerid, LobbySkin[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, LobbySkin[playerid][0], 1166189055);
    PlayerTextDrawFont(playerid, LobbySkin[playerid][0], 5);
    PlayerTextDrawSetProportional(playerid, LobbySkin[playerid][0], 0);
    PlayerTextDrawSetSelectable(playerid, LobbySkin[playerid][0], true);
    PlayerTextDrawSetPreviewRot(playerid, LobbySkin[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);

    LobbySkin[playerid][1] = CreatePlayerTextDraw(playerid, 525.197875, 150.333343, " ");
    PlayerTextDrawTextSize(playerid, LobbySkin[playerid][1], 29.000000, 30.000000);
    PlayerTextDrawAlignment(playerid, LobbySkin[playerid][1], 1);
    PlayerTextDrawColor(playerid, LobbySkin[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, LobbySkin[playerid][1], 1166189055);
    PlayerTextDrawFont(playerid, LobbySkin[playerid][1], 5);
    PlayerTextDrawSetProportional(playerid, LobbySkin[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, LobbySkin[playerid][1], 20000);
    PlayerTextDrawSetSelectable(playerid, LobbySkin[playerid][1], true);
    PlayerTextDrawSetPreviewRot(playerid, LobbySkin[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);

    LobbySkin[playerid][2] = CreatePlayerTextDraw(playerid, 555.851806, 150.333328, " ");
    PlayerTextDrawTextSize(playerid, LobbySkin[playerid][2], 29.000000, 30.000000);
    PlayerTextDrawAlignment(playerid, LobbySkin[playerid][2], 1);
    PlayerTextDrawColor(playerid, LobbySkin[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, LobbySkin[playerid][2], 1166189055);
    PlayerTextDrawFont(playerid, LobbySkin[playerid][2], 5);
    PlayerTextDrawSetProportional(playerid, LobbySkin[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid, LobbySkin[playerid][2], true);
    PlayerTextDrawSetPreviewRot(playerid, LobbySkin[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

    LobbySkin[playerid][3] = CreatePlayerTextDraw(playerid, 586.431030, 150.333343, " ");
    PlayerTextDrawTextSize(playerid, LobbySkin[playerid][3], 29.000000, 30.000000);
    PlayerTextDrawAlignment(playerid, LobbySkin[playerid][3], 1);
    PlayerTextDrawColor(playerid, LobbySkin[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, LobbySkin[playerid][3], 1166189055);
    PlayerTextDrawFont(playerid, LobbySkin[playerid][3], 5);
    PlayerTextDrawSetProportional(playerid, LobbySkin[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid, LobbySkin[playerid][3], true);
    PlayerTextDrawSetPreviewRot(playerid, LobbySkin[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);


	//PlayerTextDrawShow
	for ( new i = 0; i < 4; i ++ )
	{
		PlayerTextDrawShow ( playerid, LobbySkin [ playerid ] [ i ] );
	}

	for ( new i = 0; i < 5; i ++ )
	{
		PlayerTextDrawShow ( playerid, LobbyStats [ playerid ] [ i ] );
	}

	for ( new i = 0; i < 39; i ++ )
	{
		TextDrawShowForPlayer ( playerid, Lobby [ i ] );
	}
	SelectTextDraw ( playerid, 0xFFFFFF00 );
	return 1;
}
*/


enum en_Debug
{
	bool:stamina,
	bool:rad,
};
new debug_player [ MAX_PLAYERS ] [ en_Debug ];

CMD:perk_debug ( playerid )
{
	debug_player [ playerid ] [ stamina ] = (debug_player [ playerid ] [ stamina ]==true)?(false):(true);
}

stock ShowPerkPlayerCraft ( playerid )
{
	new str_ [ 224 ];

	if ( users [ playerid ] [ u_perk ] == 1 )
	{
		format ( str_, sizeof str_, "{cccccc}- {fffff0}Создание гранаты" );
		if ( temp [ playerid ] [ perk_KD ] [ 0 ] != 0 )
			format ( str_, sizeof str_, "%s {FFFF00}[KD: %i минут]", str_, temp [ playerid ] [ perk_KD ] [ 0 ] );

		format ( str_, sizeof str_, "%s\n{cccccc}- {fffff0}Создание РПГ", str_ );
		if ( temp [ playerid ] [ perk_KD ] [ 1 ] != 0 )
			format ( str_, sizeof str_, "%s {FFFF00}[KD: %i минут]", str_, temp [ playerid ] [ perk_KD ] [ 1 ] );
	}



	Dialog_Show ( playerid, perk_craft, DIALOG_STYLE_LIST, !"Изготовление", str_, "Далее", "Назад" );
	return 1;
}

CMD:testperk ( playerid, params[] )
{
	Dialog_Show ( playerid, dialog_perk_select, DIALOG_STYLE_LIST, "????? ?????", "\
		1. Штурмовик\n\
		2. ?????\n\
		3. ???????? ????\n\
		4. ???????\n\
		5. ?????\n\
		6. ??????", "?????", !"" );
	//users [ playerid ] [ u_perk ] = param;
	return 1;
}