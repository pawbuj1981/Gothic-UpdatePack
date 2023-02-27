func void Ninja_AddHeroNameColor()
{
if (!STR_Len (MEM_ReadString (MEM_ReadInt (ESP+4))))
    {	
	hero.name ="Bezimienny";	
	MEM_WriteString (MEM_ReadInt (ESP+4), hero.name);
	};
};
func void Ninja_ChangeConversationColor (var int npc_color, var int hero_color)
//func void Ninja_ChangeConversationColor2 ()
{
    //NINJA_ADDNAME_FIX = STR_ToInt(MEM_GetGothOpt("UPDATEPACK","DialogHeroName_enabled"));//1 
	if (!MEM_GothOptExists("UPDATEPACK","DialogHeroName_enabled")) {
        // Add INI-entry, if not set
        MEM_SetGothOpt("UPDATEPACK", "DialogHeroName_enabled", "1");        
	 };	
	
	var c_npc npc;

    if (!InfoManager_HasFinished ())
    {
    
	    npc = _^ (MEM_InformationMan.npc);
	    
        if (Hlp_StrCmp (MEM_ReadString (MEM_ReadInt (ESP+4)), npc.name))
        {	
	    hero.name ="Bezimienny";	
		MEM_WriteString (MEM_ReadInt (ESP+4), hero.name);         	
        //MEM_WriteInt (MEM_ReadInt (ESP+16), npc_color);
        };

        if (!STR_Len (MEM_ReadString (MEM_ReadInt (ESP+4))))
        {	    
        MEM_WriteInt (MEM_ReadInt (ESP+16), hero_color);
        
        if (!STR_Len (MEM_ReadString (MEM_ReadInt (ESP+4))))
        //&& ((STR_ToInt(MEM_GetModOpt("UPDATEPACK", "DialogHeroName_enabled"))))//ddoaje imiê hero w dialogu 
		{
		//MEM_WriteInt (MEM_ReadInt (ESP+16), hero_color);
				
		hero.name ="Bezimienny";	
		MEM_WriteString (MEM_ReadInt (ESP+4), hero.name); //wystarczy to dopisaæ
				
		//MEM_WriteString (MEM_ReadInt (ESP+8), "Coœ.");//kasuje string dialogu 
		Print (IntToString (hero_color));		
			};
        };
    };    
};
/*
 * Additional focus colors
 */
func int Ninja_ColorFocusVobs_Partymember() {
    return RGBA(128, 255, 255, 255); // Blue
};


/*
 * Source: https://github.com/szapp/Ninja/wiki/Applications-and-Examples
 */
func int Ninja_ColorFocusVobs_GetAIVarSafe(var C_Npc slf, var string AIVarName, var int dflt) {
    var int symb; symb = MEM_GetParserSymbol(AIVarName);
    if (symb) {
        var int idx; idx = MEM_ReadInt(symb+zCParSymbol_content_offset);
        return MEM_ReadStatArr(slf.aivar, idx);
    } else {
        return dflt; // Return default value, e.g. 0
    };
};

var int NINJA_BOX_X;
var int NINJA_BOX_Y;
var int NINJA_BOX_FIX;

func void Ninja_SetChoiceBoxScale ()
{
   Ninja_ChangeConversationColor(-256,-256);
	
	var int ptr; ptr = MEM_ReadInt(MEMINT_oCInformationManager_Address+28);
   
   NINJA_BOX_FIX = STR_ToInt(MEM_GetGothOpt("UPDATEPACK", "choice_fix"));//1 
    
   if (!MEM_GothOptExists("UPDATEPACK","choice_x")) {
        // Add INI-entry, if not set
        MEM_SetGothOpt("UPDATEPACK", "choice_fix", "0");
        MEM_SetGothOpt("UPDATEPACK", "choice_x", "820");
        MEM_SetGothOpt("UPDATEPACK", "choice_y", "120");
        
	 };    
    
   //if (STR_ToInt(MEM_GetGothOpt("CHOICE_BOX", "choice_fix"))){
	if (NINJA_BOX_FIX){   
		
   	//MEM_WriteInt (ptr+64, STR_ToInt (MEM_GetGothOpt ("VIDEO", "zVidResFullscreenY"))); //fix skalowanie ucinanych dialogów
    //Print_GetScreenSize(); //Pobiera rozdzielczoœæ ekranu 	    
   	
   	NINJA_BOX_X = STR_ToInt(MEM_GetGothOpt("UPDATEPACK", "choice_x"));//820
	NINJA_BOX_Y = STR_ToInt(MEM_GetGothOpt("UPDATEPACK", "choice_y"));//120		
	
   	MEM_WriteInt (ptr+60, NINJA_BOX_X);//os x       
   	MEM_WriteInt (ptr+56, NINJA_BOX_Y);//oœ y    	 
   	};
};

/*
 * Source: https://github.com/szapp/Ninja/wiki/Applications-and-Examples
 */
 
func int  Ninja_ColorFocusVobs_GetNpcGuild(var C_Npc slf, var string GIL_NAME) {
    var int symb; symb = MEM_GetParserSymbol(GIL_NAME);
    if (symb) {
        var int idx; idx = MEM_ReadInt(symb+zCParSymbol_content_offset);
        return slf.guild == idx;
    } else {
        return FALSE;
    };
};


/*
 * Slightly modified version of LeGo_Focusnames (_Focusnames). Changes marked with comments
 */
func void Ninja_Focus_UpdateStatus() {
    
	Ninja_SetChoiceBoxScale ();
	//Ninja_AddHeroNameColor();
	//Ninja_CinemaScope_Init ();
    Ninja_ColorFocusVobs_UpdateStatus();    
};

func void Ninja_Focus_Funcs() 
{
HookEngineF(oCGame__UpdateStatus, 8, Ninja_Focus_UpdateStatus);//zmiana pozycji choice boxa	

};