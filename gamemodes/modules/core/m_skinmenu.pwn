alias:skinlist("slist");

#define MAX_SKIN    300
//#define TABLE_SKIN  "skin_menu"

enum ENUM_SKIN_PLAYER
{
    eID,
    eName [ 32 ],
    eSkinID,
    eSkinProtect,
}
new SkinMenu [ MAX_SKIN ] [ ENUM_SKIN_PLAYER ];

forward LoadDynamicSkin ();
public LoadDynamicSkin ()
{
    new rows = cache_num_rows(),
	    time = GetTickCount(),
		total;

	if ( !rows )
	{
	    print ( "[DynamicSkin] Записи не найдены." );
	    return 1;
	}

	for ( new i; i < rows; i++ )
	{
		cache_get_value_name_int ( i, "id", SkinMenu [ i ] [ eID ] );

        cache_get_value_name_int ( i, "eSkinID", SkinMenu [ i ] [ eSkinID ] );
        cache_get_value_name_int ( i, "eProtect", SkinMenu [ i ] [ eSkinProtect ] );

        cache_get_value_name ( i, "eName", SkinMenu [ i ] [ eName ] );
    
		total++;
	}
	printf ( "[DynamicSkin] Строк - %i. Загружено - %i. Затрачено: %i ms.", rows, total, GetTickCount()-time );
    return 1;
}


forward OnPlayerCreateSkin ( playerid );
public OnPlayerCreateSkin ( playerid )
{
    for ( new i = 0 ; i < MAX_SKIN; i ++ )
    {
        if ( SkinMenu [ i ] [ eID ] != 0 )
            continue;
        
        SkinMenu [ i ] [ eID ] = cache_insert_id();
        strcat ( SkinMenu [ i ] [ eName ], "Отсутствует" );

        ShowPlayerSkinMenu ( playerid );
        return 1;
    }

    SEM ( playerid, "Обнаружена ошибка #0001-1 (No empty SLOT)" );
    return 1;
}

Dialog:SKIN_SETTING ( params_dialog )
{
    if ( !response )
    {
        temp [ playerid ] [ tSelect_1 ] = 0;
        return 1;
    }

    switch ( listitem )
    {
        case 0:
        {
            if ( ( temp [ playerid ] [ tSelect_1 ] ++ )*50 > MAX_SKIN )
                temp [ playerid ] [ tSelect_1 ] --;

            ShowPlayerSkinMenu ( playerid );
        }
        case 1:
        {
            if ( temp [ playerid ] [ tSelect_1 ] -- < 0 )
                temp [ playerid ] [ tSelect_1 ] = 0;

            ShowPlayerSkinMenu ( playerid );
        }
        case 2:
        {
            new query [ 128 ];
            m_format ( query, sizeof query, "INSERT INTO "TABLE_SKIN" (`eName`, eSkinID, eProtect) VALUES ('Отсутствует',0,0)" );
            m_tquery ( query, "OnPlayerCreateSkin", "i", playerid );
        
            SSM ( playerid, "Происходит создание скина, подождите..." );
        }
        default:
        {
            temp [ playerid ] [ tSelect ] = temp [ playerid ] [ tSelect_1 ] * 50 + (listitem-3);
            ShowPlayerSkinSetting ( playerid );
        }
    }
    return 1;
}

stock ShowPlayerSkinMenu ( playerid )
{
    new _list = temp [ playerid ] [ tSelect_1 ] * 50,
        str_ [ 1200 ] = "#\tназвание\n>>\tследущая страница\n<<\tПредыдущая странциа\n+\tСоздать новый скин";
    
    for ( new i = _list; i < 50+_list; i ++ )
    {
        if ( SkinMenu [ i ] [ eID ] == 0 )
            break;
        else
            format ( str_, sizeof str_, "%s\n%i.\t%s", str_, i + 1, SkinMenu [ i ] [ eName ] );
    }

    Dialog_Show ( playerid, SKIN_SETTING, DIALOG_STYLE_TABLIST_HEADERS, !"Управление скинами", str_, "Далее", "Выход" );
    return 1;
}

Dialog:SKIN_EDIT_0 ( params_dialog )
{
    if ( !response )
    {
        ShowPlayerSkinSetting ( playerid );
        return 1;
    }

    if ( !strlen ( inputtext ) || strlen ( inputtext ) < 2 || strlen ( inputtext ) > 32 )
        return Dialog_Show ( playerid, SKIN_EDIT_0, DIALOG_STYLE_INPUT, !"Управление скинами", "Введите название для скина", "Далее", "Назад" );

    new id = temp [ playerid ] [ tSelect ];
    
    SkinMenu [ id ] [ eName ] = EOS;
    strcat ( SkinMenu [ id ] [ eName ], inputtext );
    
    new query [ 128 ];
    m_format ( query, sizeof query, "UPDATE "TABLE_SKIN" SET eName=%s WHERE id = %i",
        inputtext,
        SkinMenu [ id ] [ eID ]
    );
    m_tquery ( query );

    SSM ( playerid, "Настройка успешно сохранена!" );

    ShowPlayerSkinSetting ( playerid );
    return 1;
}

stock set_skin_value_int ( id, row[], value )
{
	new query [ 128 ];
    
    m_format ( query, sizeof query, "UPDATE "TABLE_SKIN" SET `%s`='%i' WHERE id='%i'",
        row,
        value,
        SkinMenu [ id ] [ eID ]
    );
    m_tquery ( query );
	return 1;
}

Dialog:SKIN_EDIT_1 ( params_dialog )
{
    if ( !response )
    {
        ShowPlayerSkinSetting ( playerid );
        return 1;
    }

    if ( !strval ( inputtext ) || strval ( inputtext ) < 0 )
        return Dialog_Show ( playerid, SKIN_EDIT_1, DIALOG_STYLE_INPUT, !"Управление скинами", "Введите новый ID скина", "Далее", "Назад" ); 

    new id = temp [ playerid ] [ tSelect ];

    SkinMenu [ id ] [ eSkinID ] = strval ( inputtext );
    
    set_skin_value_int ( id, "eSkinID", strval ( inputtext ) );
    SSM ( playerid, "Настройка успешно сохранена!" );
    
    ShowPlayerSkinSetting ( playerid );
    return 1;
}

Dialog:SKIN_EDIT_2 ( params_dialog )
{
    if ( !response )
    {
        ShowPlayerSkinSetting ( playerid );
        return 1;
    }

    if ( !strval ( inputtext ) || strval ( inputtext ) < 0 )
        return Dialog_Show ( playerid, SKIN_EDIT_2, DIALOG_STYLE_INPUT, !"Управление скинами", "Введите % защиты для скина", "Далее", "Назад" );

    new id = temp [ playerid ] [ tSelect ];

    SkinMenu [ id ] [ eSkinProtect ] = strval ( inputtext );
    
    set_skin_value_int ( id, "eProtect", strval ( inputtext ) );
    SSM ( playerid, "Настройка успешно сохранена!" );
    
    ShowPlayerSkinSetting ( playerid );
    return 1;
}

Dialog:SKIN_EDIT ( params_dialog )
{
    if ( !response )
    {
        ShowPlayerSkinMenu ( playerid );
        return 1;
    }

    //new query [ 128 ];
    switch ( listitem )
    {
        case 0:
            Dialog_Show ( playerid, SKIN_EDIT_0, DIALOG_STYLE_INPUT, !"Управление скинами", "Введите название для скина", "Далее", "Назад" );

        case 1:
            Dialog_Show ( playerid, SKIN_EDIT_1, DIALOG_STYLE_INPUT, !"Управление скинами", "Введите новый ID скина", "Далее", "Назад" );      
        
        case 2:
            Dialog_Show ( playerid, SKIN_EDIT_2, DIALOG_STYLE_INPUT, !"Управление скинами", "Введите % защиты для скина", "Далее", "Назад" );
    }

    return 1;
}

stock ShowPlayerSkinSetting ( playerid )
{
    new str_ [ 250 ],
        id = temp [ playerid ] [ tSelect ];
    
    format ( str_, sizeof str_, "\
        {87CEEB}1. {FFFFFF}Название: %s (#%i)\n\
        {87CEEB}2. {FFFFFF}ID скина: %i\n\
        {87CEEB}3. {FFFFFF}Защита от урона: %i",
        SkinMenu [ id ] [ eName ], SkinMenu [ id ] [ eID ],
        SkinMenu [ id ] [ eSkinID ],
        SkinMenu [ id ] [ eSkinProtect ] 
    );
    Dialog_Show ( playerid, SKIN_EDIT, DIALOG_STYLE_LIST, !"Управление скинами", str_, "Далее", "Назад" );
    return 1;
}

CMD:skinmenu ( playerid )
{
    AdminProtect ( 7 );

    temp [ playerid ] [ tSelect_1 ] = 0;
    ShowPlayerSkinMenu ( playerid );
    return 1;
}

MSelectCreate:skin_list(playerid)
{
    //SSM ( playerid, "Вызов!" );
	new
		items_array[MAX_SKIN] = {MSELECT_INVALID_MODEL_ID, ...},
		items_count = 0;
    //SSM ( playerid, "%i", items_count );
	if (items_count == 0) {
		for (new i = 0; i <= sizeof(items_array); i++) {
			
            if ( SkinMenu [ i ] [ eID ] == 0 )
                break;

			items_array[items_count] = SkinMenu [ i ] [ eSkinID ];
			//SSM ( playerid, "%i | %i", i, SkinMenu [ i ] [ eSkinID ] );
            items_count++;
		}
	}

	MSelect_Open(playerid, MSelect:skin_list, items_array, items_count, .button = TranslateText ( "Закрыть"), .header = TranslateText("Список скинов"));
}

MSelectResponse:skin_list(playerid, MSelectType:response, itemid, modelid)
{
	new string[144];
	format(string, sizeof(string), "ID: %d | Type: %d | Item: %d | Model: %d",
	       playerid, _:response, itemid, modelid);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:skinlist ( playerid )
{
    MSelect_Show ( 0, MSelect:skin_list );
    return 1;
}