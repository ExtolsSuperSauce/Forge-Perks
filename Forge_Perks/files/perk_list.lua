table.insert (perk_list,
	{
		id = "FORGE_MACHINE",
		ui_name = "$forge_perk_FORGE_MACHINE",
		ui_description = "$forge_perk_FORGE_MACHINEdesc",
		not_in_default_perk_pool = true,
		ui_icon = "mods/Forge_perks/files/perk_icons/Machinery.png",
		perk_icon = "mods/Forge_perks/files/perks/Machinery.png",
		func = function( entity_perk_item, entity_who_picked, item_name, pickup_count )
		GameAddFlagRun( "Perk_Wand_Crafter" )
		local entity_id = GetUpdatedEntityID()
		local x,y = EntityGetTransform(entity_id)
		EntityLoad("mods/Forge_perks/files/items/book_machine.xml", x+15, y)
		local near_perk = EntityGetInRadiusWithTag( x, y, 75, "item_perk" )
			for i,kill_me in ipairs(near_perk) do
				EntityKill(kill_me)
			end
			GamePrint("Way of the Machine")
		end
	}
)

table.insert (perk_list,
	{
        id = "FORGE_MASTER",
        ui_name = "$forge_perk_FORGE_MASTER",
        ui_description = "$forge_perk_FORGE_MASTERdesc",
        not_in_default_perk_pool = true,
        ui_icon = "mods/Forge_perks/files/perk_icons/Mastery.png",
        perk_icon = "mods/Forge_perks/files/perks/Mastery.png",
        func = function( entity_perk_item, entity_who_picked, item_name, pickup_count )
        GameAddFlagRun( "Perk_Wand_Master" )
		local entity_id = GetUpdatedEntityID()
		local x,y = EntityGetTransform(entity_id)
		EntityLoad("mods/Forge_perks/files/items/book_master.xml", x+15, y)
		local near_perk = EntityGetInRadiusWithTag( x, y, 75, "item_perk" )
			for i,kill_me in ipairs(near_perk) do
				EntityKill(kill_me)
			end
			GamePrint("Way of the Master")
        end
    }
)

table.insert (perk_list,
	{
        id = "FORGE_ALCHEMIST",
        ui_name = "$forge_perk_FORGE_ALCHEMIST",
        ui_description = "$forge_perk_FORGE_ALCHEMISTdesc",
        not_in_default_perk_pool = true,
        ui_icon = "mods/Forge_perks/files/perk_icons/Alchemistry.png",
        perk_icon = "mods/Forge_perks/files/perks/Alchemistry.png",
        func = function( entity_perk_item, entity_who_picked, item_name, pickup_count )
        GameAddFlagRun( "Perk_Wand_Killer" )
		local entity_id = GetUpdatedEntityID()
		local x,y = EntityGetTransform(entity_id)
		EntityLoad("mods/Forge_perks/files/items/book_alchemist.xml", x+15, y)
		local near_perk = EntityGetInRadiusWithTag( x, y, 75, "item_perk" )
			for i,kill_me in ipairs(near_perk) do
				EntityKill(kill_me)
			end
			GamePrint("Way of the Alchemst")
        end
    }
)

