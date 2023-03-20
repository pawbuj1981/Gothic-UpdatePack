var c_Item armor;
var c_Item meleeweap;
var c_Item rangedweapon;
var c_Item weapon;
func void Npc_ClearInventoryLoop (var c_npc npc, var int category)
{
   	//PrintScreen	(ConcatStrings("Czyszczenie eq: ", npc.name), yposition,yaposition,"FONT_OLD_10_WHITE.TGA",timep);	//dla testu
	// print(ConcatStrings("Czyszczenie eq: ", npc.name);
        var int amount;
        amount = Npc_GetInvItemBySlot (npc, category, 0);
        armor = Npc_GetEquippedArmor(npc);
        //meleeweap = Npc_GetEquippedMeleeWeapon(npc);
        weapon = Npc_GetEquippedMeleeWeapon(npc);
        rangedweapon = Npc_GetEquippedRangedWeapon(npc);
       	// print(ConcatStrings(item.name, IntToString(amount));

       	
        if (amount>0)
        //&& (Hlp_GetInstanceID(item) != Hlp_GetInstanceID(weapon))
        && (Hlp_GetInstanceID(item) != Hlp_GetInstanceID(armor))
        //&& (Hlp_GetInstanceID(item) != Hlp_GetInstanceID(rangedweapon))        
        {
                NPC_RemoveInvItems (npc, Hlp_GetInstanceID (item), amount);
               
                Npc_ClearInventoryLoop(npc, category);
        }
        else if (category < INV_CAT_MAX-1)
        {
                //print(ConcatStrings("Zmiana kategorii na: ", IntToString(category+1));
                Npc_ClearInventoryLoop(npc, category+1);
        };
        AI_PrintScreen_Ext		(ConcatStrings(self.name," traci ekwipunek (kara za pobicie)"), -1,43,"font_old_10_white.tga",_TIME_MESSAGE_LEVELUP);
};


func void Npc_ClearInventory (var c_npc npc)
{	
	
	Npc_ClearInventoryLoop(npc, 0);	
};

func void Npc_MoveInventoryLoop (var c_npc npc, var int category)
{
   	//PrintScreen	(ConcatStrings("Przenoszenie eq: ", npc.name), yposition,yaposition,"FONT_OLD_10_WHITE.TGA",timep);	//dla testu
	// print(ConcatStrings("Czyszczenie eq: ", npc.name);
        var int amount;
        amount = Npc_GetInvItemBySlot (npc, category, 0);
       // print(ConcatStrings(item.name, IntToString(amount));
        if (amount>0)
        {
             	Mob_CreateItems	("CHEST", Hlp_GetInstanceID (item), amount) ; 
             	Mob_CreateItems	( "OC_CHEST_LARGE2", Hlp_GetInstanceID (item), amount) ; 
             	 
	        	NPC_RemoveInvItems (npc, Hlp_GetInstanceID (item), amount);
                
                Npc_MoveInventoryLoop(npc, category);
        }
        else if (category < INV_CAT_MAX-1)
        {
                //print(ConcatStrings("Zmiana kategorii na: ", IntToString(category+1));
                Npc_MoveInventoryLoop(npc, category+1);
                
        };
};


func void Npc_MoveInventory (var c_npc npc)
{	
	
	Npc_MoveInventoryLoop(npc, 0);	
};
