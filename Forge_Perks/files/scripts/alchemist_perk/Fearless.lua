local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
function interacting(entity_who_interacted, entity_interacted, interactable_name)
	if GameHasFlagRun("Extol_ESB_Intro") == false then
		if GameHasFlagRun("Perk_Wand_Killer") then
			GamePrint("You sense a strange power to this rock. Maybe this is the Elemental Stone Breaker?")
		else
			GamePrint("You sense a strange power to this rock. Seems important....")
		end
		GameAddFlagRun("Extol_ESB_Intro")
	end
	local i2c_id = EntityGetFirstComponentIncludingDisabled(entity_who_interacted, "Inventory2Component")
	local stone_id = ComponentGetValue2( i2c_id, "mActiveItem" )
	local stone_check = (EntityHasTag(stone_id, "brimstone"))
	if stone_check == true then
		EntityRemoveFromParent( stone_id )
		EntityKill( stone_id )
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/brimstone_shard.xml", x+3, y)
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/brimstone_shard.xml", x-3, y)
	end
	stone_check = (EntityHasTag(stone_id, "stonestone"))
	if stone_check == true then
		EntityRemoveFromParent( stone_id )
		EntityKill( stone_id )
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/stonestone_shard.xml", x+3, y)
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/stonestone_shard.xml", x-3, y)
	end
	stone_check = (EntityHasTag(stone_id, "waterstone"))
	if stone_check == true then
		EntityRemoveFromParent( stone_id )
		EntityKill( stone_id )
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/waterstone_shard.xml", x+3, y)
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/waterstone_shard.xml", x-3, y)
	end
	stone_check = (EntityHasTag(stone_id, "thunderstone"))
	if stone_check == true then
		EntityRemoveFromParent( stone_id )
		EntityKill( stone_id )
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/thunderstone_shard.xml", x+3, y)
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/thunderstone_shard.xml", x-3, y)
	end
	stone_check = (EntityHasTag(stone_id, "poopstone"))
	if stone_check == true then
		EntityRemoveFromParent( stone_id )
		EntityKill( stone_id )
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/poopstone_shard.xml", x+3, y)
		EntityLoad("mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/poopstone_shard.xml", x-3, y)
	end
end

