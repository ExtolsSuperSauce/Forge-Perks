dofile_once("data/scripts/gun/gun_actions.lua")
dofile_once("mods/Forge_Perks/files/scripts/better_actions.lua")

local rand_part_table = {
"mods/Forge_Perks/files/items/broken_parts/wand_heads/missing_page.xml",
"mods/Forge_Perks/files/items/broken_parts/wand_heads/jungles_heart.xml",
"mods/Forge_Perks/files/items/broken_parts/wand_heads/deer_skull.xml",
"mods/Forge_Perks/files/items/broken_parts/wand_heads/mech_gear.xml",
"mods/Forge_Perks/files/items/broken_parts/wand_shafts/book.xml",
"mods/Forge_Perks/files/items/broken_parts/wand_shafts/dried_vine.xml",
"mods/Forge_Perks/files/items/broken_parts/wand_shafts/duck_spine.xml",
"mods/Forge_Perks/files/items/broken_parts/wand_shafts/mech_base.xml",
"mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/waterstone_shard.xml",
"mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/brimstone_shard.xml",
"mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/poopstone_shard.xml",
"mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/thunderstone_shard.xml",
"mods/Forge_Perks/files/items/broken_parts/broken_essence_gems/stonestone_shard.xml"
}

function getPlayerEntity()
    local players = EntityGetWithTag("player_unit")
    if #players == 0 then return end

    return players[1]
end

function setInternalVariableValue(entity_id, variable_name, variable_type, new_value)

    local components = EntityGetComponent( entity_id, "VariableStorageComponent" )    
    if ( components ~= nil ) then
        for key,comp_id in pairs(components) do 
            local var_name = ComponentGetValue2( comp_id, "name" )
            if( var_name == variable_name) then
                ComponentSetValue2( comp_id, variable_type, new_value )
            end
        end
    end
end

function getInternalVariableValue(entity_id, variable_name, variable_type)
    local value = nil
    local components = EntityGetComponent( entity_id, "VariableStorageComponent" )
    if ( components ~= nil ) then
        for key,comp_id in pairs(components) do 
            local var_name = ComponentGetValue2( comp_id, "name" )
            if(var_name == variable_name) then
                value = ComponentGetValue2(comp_id, variable_type)
            end
        end
    end
    return value
end

function getCurrentlyEquippedWandId()
    local i2c_id = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "Inventory2Component")
    local wand_id = ComponentGetValue2( i2c_id, "mActiveItem" )
    if(EntityHasTag(wand_id, "wand")) then
        return wand_id
    else
        return nil
    end
end

function getCurrentlyEquippedPartId()
	local yada = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "Inventory2Component")
    local broken_part = ComponentGetValue2( yada, "mActiveItem" )
    if(EntityHasTag(broken_part, "forge_wand_part")) then
        return broken_part
    else
        return nil
    end
end

function moddedWandSpellBreaker()
    local wand_spells = EntityGetAllChildren(getCurrentlyEquippedWandId())
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform( entity_id )
    if wand_spells == nil then return end
	for i,spell in ipairs(wand_spells) do
		if(EntityHasTag(spell, "card_action")) then
			local iac_id = EntityGetFirstComponentIncludingDisabled( spell, "ItemActionComponent" )
			local action_id = ComponentGetValue2( iac_id , "action_id")
			EntityRemoveFromParent( spell )
			EntityKill( spell )
			CreateItemActionEntity( action_id, x, y )
		end
	end
end

function make_random_card( x, y )
	
	SetRandomSeed( GameGetFrameNum(), x + y )
	
	local item = ""
	local valid = false
	
	local rand = Random( 1, 50 )
	if rand == 21 then
		item = "regeneration_field"
	elseif rand == 19 then
		item = "summon_wandghost"
	end
	
	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x, y )
	end

	while ( valid == false ) do
		local itemno = Random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		
		if ( thisitem.spawn_requires_flag ~= nil ) then
			local flag_name = thisitem.spawn_requires_flag
			local flag_status = HasFlagPersistent( flag_name )
			
			if flag_status then
				valid = true
			end

			if( thisitem.spawn_probability == "0" ) then 
				valid = false
			end
			
		else
			valid = true
		end
	end
	
	if Random( 1, 3 ) == 2 then
		local thisitem = Random( 1, #Extol_actions )
		item = string.lower(thisitem.id)
	end
	
	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x, y )
		return card_entity
	else
		print( "No valid action entity found!" )
	end
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local alch_perk = ((GameHasFlagRun("Perk_Wand_Killer")) and (GameHasFlagRun("Perk_Wand_Crafter") == false ) and (GameHasFlagRun("Perk_Wand_Master") == false ))
local mast_perk = ((GameHasFlagRun("Perk_Wand_Master")) and (alch_perk == false))
local mach_perk = ((GameHasFlagRun("Perk_Wand_Crafter")) and (mast_perk == false))
local mat_mast_basic = 0
local mat_mast_better = 0
local mat_mast_best = 0
local materia_master = 0
local mat_mach_basic = 0
local mat_mach_better = 0
local mat_mast_best = 0
local material_machine = 0
local rando_y = 0
local rando_x = 0
local loop_var = -27
local max_rand = 53
SetRandomSeed( GameGetFrameNum(), x + y )
function interacting(entity_who_interacted, entity_interacted, interactable_name)
	local current_wand = getCurrentlyEquippedWandId()
	local current_part = getCurrentlyEquippedPartId()
	alch_perk = ((GameHasFlagRun("Perk_Wand_Killer")) and (GameHasFlagRun("Perk_Wand_Crafter") == false ) and (GameHasFlagRun("Perk_Wand_Master") == false ))
	mast_perk = ((GameHasFlagRun("Perk_Wand_Master")) and (alch_perk == false) and (GameHasFlagRun("Perk_Wand_Crafter") == false ))
	mach_perk = ((GameHasFlagRun("Perk_Wand_Crafter")) and (mast_perk == false))
	if (current_part ~= nil) and (GameHasFlagRun("forge_assemble_activation") == false) then
		EntityRemoveTag(current_part, "forge_wand_part")
		wand_forge_builder()
	elseif (( alch_perk == true ) and ( current_wand ~= nil ) ) then
		local px, py = EntityGetTransform( entity_who_interacted )
		moddedWandSpellBreaker()			
		local spell_vary = Random( 1, 3 )
		if spell_vary == (2) then
			make_random_card(px, py)
		end
		spell_vary = Random( 1, #rand_part_table )
		EntityLoad(rand_part_table[spell_vary], x - 15, y )
		EntityRemoveFromParent( current_wand )
		EntityKill( current_wand )
	elseif ( mast_perk == true ) then
		GamePrint("Materials:")
		local mast_basic_id = EntityGetWithName("Extol'sNatureCounter")
		local mast_better_id = EntityGetWithName("Extol'sMachineCounter")
		local mast_best_id = EntityGetWithName("Extol'sMagicCounter")
		local bird_counter = EntityGetWithName("Extol'sBirdCounter")
		mat_mast_basic = getInternalVariableValue(mast_basic_id, "stored_count", "value_int")
		mat_mast_better = getInternalVariableValue(mast_better_id, "stored_count", "value_int")
		mat_mast_best = getInternalVariableValue(mast_best_id, "stored_count", "value_int")
		materia_master = getInternalVariableValue(bird_counter, "stored_count", "value_int")
		if (mat_mast_basic ~= nil) then
			GamePrint("Basic: " .. mat_mast_basic)
		end
		if (mat_mast_better ~= nil) then
			GamePrint("Better: " .. mat_mast_better)
		end
		if (mat_mast_best ~= nil) then
			GamePrint("Best: " .. mat_mast_best)
		end
		if (materia_master ~= nil) then
			GamePrint("???: " .. materia_master)
		end
		local ability_component_id = EntityGetFirstComponentIncludingDisabled(current_wand, "AbilityComponent")
		if (mat_mast_basic ~= nil) then
			if ( current_wand ~= nil ) and (mat_mast_basic >= 1) then
				GamePrint("Basic Used: " .. mat_mast_basic)
				for i = 1, mat_mast_basic do
					local deck_capacity = ComponentObjectGetValue2(ability_component_id, "gun_config", "deck_capacity")
					local spells_per = ComponentObjectGetValue2(ability_component_id, "gun_config", "actions_per_round")
					local shot_spread = ComponentObjectGetValue2(ability_component_id, "gunaction_config", "spread_degrees")
					if (deck_capacity <= 35) then
						ComponentObjectSetValue2(ability_component_id, "gun_config", "deck_capacity", deck_capacity + 2)
					end
					if (spells_per <= 36) then
						ComponentObjectSetValue2(ability_component_id, "gun_config", "actions_per_round", spells_per + 1)
					end
					if (shot_spread >= -359) then
						ComponentObjectSetValue2(ability_component_id, "gunaction_config", "spread_degrees", shot_spread - 10)
					end
				end
				setInternalVariableValue(mast_basic_id, "stored_count", "value_int", 0)
			end
		end
		if (mat_mast_better ~= nil) then
			if ( current_wand ~= nil ) and (mat_mast_better >= 1) then
				GamePrint("Better Used: " .. mat_mast_better)
				for i = 1, mat_mast_better do
					local spells_per = ComponentObjectGetValue2(ability_component_id, "gun_config", "actions_per_round")
					local castDelay = ComponentObjectGetValue2(ability_component_id, "gunaction_config", "fire_rate_wait")
					local rechargeTime = ComponentObjectGetValue2(ability_component_id, "gun_config", "reload_time")
					if (spells_per >= 3) then
						ComponentObjectSetValue2(ability_component_id, "gun_config", "actions_per_round", spells_per - 2)
					end
					if (castDelay >= -1000) then
						ComponentObjectSetValue2(ability_component_id, "gunaction_config", "fire_rate_wait", castDelay - 15)
					end
					if (rechargeTime >= -1000) then
						ComponentObjectSetValue2(ability_component_id, "gun_config", "reload_time", rechargeTime - 15)
					end
				end
				setInternalVariableValue(mast_better_id, "stored_count", "value_int", 0)
			end
		end
		if (mat_mast_best ~= nil) then
			if (current_wand ~= nil ) and (mat_mast_best >= 1) then
				GamePrint("Best Used: " .. mat_mast_best)
				for i = 1, mat_mast_best do
					local manaMax = ComponentGetValue2(ability_component_id, "mana_max")
					local manaChargeSpeed = ComponentGetValue2(ability_component_id, "mana_charge_speed")
					local rechargeTime = ComponentObjectGetValue2(ability_component_id, "gun_config", "reload_time")
					if manaMax <= 4999 then
						ComponentSetValue2(ability_component_id, "mana_max", manaMax + 75)
					end
					if manaChargeSpeed <= 1999 then
						ComponentSetValue2(ability_component_id, "mana_charge_speed", manaChargeSpeed + 50)
					end
					if rechargeTime <= 600 then
						ComponentObjectSetValue2(ability_component_id, "gun_config", "reload_time", rechargeTime + 3)
					end
				end
				setInternalVariableValue(mast_best_id, "stored_count", "value_int", 0)
			end
		end
		if (materia_master ~= nil) then
			if (current_wand ~= nil) and (materia_master >= 1) then
			GamePrint("The Phoenix Rises Again")
				for i = 1, materia_master do
					local power_trip = ComponentObjectGetValue2(ability_component_id, "gun_config", "shuffle_deck_when_empty")
					local speed_up = ComponentObjectGetValue2(ability_component_id, "gunaction_config", "speed_multiplier")
					ComponentObjectSetValue2(ability_component_id, "gun_config", "actions_per_round", 1)
					if power_trip == 1 then
						ComponentObjectSetValue2(ability_component_id, "gun_config", "shuffle_deck_when_empty", 0)
					else
						ComponentObjectSetValue2(ability_component_id, "gunaction_config", "speed_multiplier", speed_up + 0.5)
					end
					if speed_up <= 250 then
						ComponentObjectSetValue2(ability_component_id, "gunaction_config", "speed_multiplier", speed_up + 1)
					end
				end
				setInternalVariableValue(bird_counter, "stored_count", "value_int", 0)
			end
		end
	elseif ( mach_perk == true ) then
		local mach_basic_id = EntityGetWithName("Extol'sNatureCounter")
		local mach_better_id = EntityGetWithName("Extol'sMachineCounter")
		local mach_best_id = EntityGetWithName("Extol'sMagicCounter")
		local bird_counter = EntityGetWithName("Extol'sBirdCounter")
		mat_mach_basic = getInternalVariableValue(mach_basic_id, "stored_count", "value_int")
		mat_mach_better = getInternalVariableValue(mach_better_id, "stored_count", "value_int")
		mat_mach_best = getInternalVariableValue(mach_best_id, "stored_count", "value_int")
		material_machine = getInternalVariableValue(bird_counter, "stored_count", "value_int")
		if ((mat_mach_basic ~= nil) and (mat_mach_basic > 0)) then
			GamePrint("Basic made: ".. mat_mach_basic)
			for i = 1, mat_mach_basic do
				rando_y = Random( 2, 50 )
				rando_x = Random( 0, 50 )
				loop_var = loop_var + 1
				EntityLoad("data/entities/items/wand_level_05_better.xml", x - 25 + rando_x, y - rando_y )
			end
			loop_var = 0
			setInternalVariableValue(mach_basic_id, "stored_count", "value_int", 0)
		end
		if ((mat_mach_better ~= nil) and (mat_mach_better > 0)) then
			GamePrint("Better made: ".. mat_mach_better)
			for i = 1, mat_mach_better do
				rando_y = Random( 2, 55 )
				rando_x = Random( 0, 55 )
				loop_var = loop_var + 1
				EntityLoad("data/entities/items/wand_level_06_better.xml", x - 25 + rando_x, y - rando_y )
			end
			loop_var = 0
			setInternalVariableValue(mach_better_id, "stored_count", "value_int", 0)
		end
		if ((mat_mach_best ~= nil) and (mat_mach_best > 0)) then
			GamePrint("Best made: ".. mat_mach_best)
			for i = 1, mat_mach_best do
				rando_y = Random( 2, 60 )
				rando_x = Random( 0, 65 )
				EntityLoad("data/entities/items/wand_level_10.xml", x - 25 + rando_x, y - rando_y )
			end
			setInternalVariableValue(mach_best_id, "stored_count", "value_int", 0)
		end
		if ((material_machine ~= nil) and (material_machine > 0)) then
			SetTimeOut( 1 , "mods/Forge_Perks/files/scripts/alchemist_perk/Matter_Machine.lua", "spawn_wands" )
		end
	end
end

function wand_forge_builder()
	local sprite_manager_id = EntityGetWithName("Extol'sForgedSpriteGod")
	local inv_comp = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "Inventory2Component")
    local part_check = ComponentGetValue2( inv_comp, "mActiveItem" )
	if (EntityHasTag(part_check, "forge_wand_essence")) then
		EntityRemoveTag(part_check, "forge_wand_essence")
		local essence_id = EntityGetName(part_check)
		local old_essence = getInternalVariableValue(sprite_manager_id, "gem", "value_string")
		if essence_id ~= old_essence then
			setInternalVariableValue(sprite_manager_id, "gem", "value_string", essence_id)
			EntityKill(part_check)
		else
			EntityAddTag(part_check, "forge_wand_essence")
			EntityAddTag(part_check, "forge_wand_part")
		end
	elseif (EntityHasTag(part_check, "forge_wand_head")) then
		EntityRemoveTag(part_check, "forge_wand_head")
		local head_id = EntityGetName(part_check)
		local old_head = getInternalVariableValue(sprite_manager_id, "head", "value_string")
		if head_id ~= old_head then
			setInternalVariableValue(sprite_manager_id, "head", "value_string", head_id)
			EntityKill(part_check)
		else
			EntityAddTag(part_check, "forge_wand_head")
			EntityAddTag(part_check, "forge_wand_part")
		end
	elseif (EntityHasTag(part_check, "forge_wand_handle")) then
		EntityRemoveTag(part_check, "forge_wand_handle")
		local handle_id = EntityGetName(part_check)
		local old_handle = getInternalVariableValue(sprite_manager_id, "handle", "value_string")
		if handle_id ~= old_handle then
			setInternalVariableValue(sprite_manager_id, "handle", "value_string", handle_id)
			EntityKill(part_check)
		else
			EntityAddTag(part_check, "forge_wand_handle")
			EntityAddTag(part_check, "forge_wand_part")
		end
	end
end