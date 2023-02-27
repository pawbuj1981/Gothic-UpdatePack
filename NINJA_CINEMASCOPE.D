/* Abruf */
func void Ninja_CinemaScope_Main() {
    var int ptr;
    var int tmp;
    var int CinemaScopeAlpha;
    MEM_GAME.array_view_visible[3] = true;
    MEM_GAME.array_view_enabled[3] = true;
    MEM_Camera.cinemaScopeEnabled = true;
    MEM_Camera.cinemaScopeColor = RGBA (0, 0, 0, CinemaScopeAlpha);

    //Fade Effekt
    if (InfoManager_HasFinished())
    {
        if (CinemaScopeAlpha >= 5) {
            CinemaScopeAlpha -= 10;
        };
        if (CinemaScopeAlpha == 5) {
            CinemaScopeAlpha = 0;
        };
    } else {
        if (CinemaScopeAlpha <= 250) {
            CinemaScopeAlpha += 10;
        };
        if (CinemaScopeAlpha == 250) {
            CinemaScopeAlpha = 255;
        };
    };

    //Holen der Text Boxen
    const int GAME_VIEW_CONVERSATION = 1;
    const int GAME_VIEW_CINEMA = 3;//3

    var zCView v; v = _^ (MEM_GAME.array_view [GAME_VIEW_CONVERSATION]);
    v.owner = 0;

    v = _^ (MEM_GAME.array_view [GAME_VIEW_CINEMA]);
    v._zCInputCallBack_vtbl = 0;

    const int VIEW_VIEWPORT = 1;
    v.viewID = VIEW_VIEWPORT;

    var zCViewDialogChoice dlgChoice;
    dlgChoice = _^ (MEM_InformationMan.DlgChoice);

    dlgChoice.virtualSizeY = STR_ToInt (MEM_GetGothOpt ("VIDEO", "zVidResFullscreenX")) / 6;

    //Neu Positionierung und in Speicher schreiben
    if (Print_Screen[PS_Y] <= 768) { //low res fix
        tmp = Print_Screen[PS_Y] * 21 / 2 - ((Print_Screen[PS_Y] * 2 / 24) % 1);
        dlgChoice.textureAlpha = tmp;
        dlgChoice.texturePosition_0[1] = Print_Screen[PS_Y] - tmp;
    } else {
        tmp = Print_Screen[PS_Y] * 113 / 128;
        tmp = tmp - (tmp % 1);

        if (Print_Screen[PS_Y] - tmp > 120) {
            tmp = tmp + (Print_Screen[PS_Y] - tmp - 120) / 8; //Held Fragen Postion Y
            tmp = tmp - (tmp % 1);
            dlgChoice.textureAlpha = tmp;
            dlgChoice.texturePosition_0[1] = 120;
        } else {
            dlgChoice.textureAlpha = tmp;
            dlgChoice.texturePosition_0[1] = Print_Screen[PS_Y] - tmp;
        };
    };

    dlgChoice.durationOpen = 0;
};

var int NINJA_CINEMASCOPE;
func void Ninja_CinemaScope_Init()
	{
	NINJA_CINEMASCOPE = STR_ToInt(MEM_GetGothOpt("UPDATEPACK", "cinemascope"));
	if (!MEM_GothOptExists("UPDATEPACK","cinemascope")) {
        // Add INI-entry, if not set
        MEM_SetGothOpt("UPDATEPACK", "cinemascope", "1");
	};
	if (NINJA_CINEMASCOPE)
	{
	Ninja_CinemaScope_Main();	
	};
};