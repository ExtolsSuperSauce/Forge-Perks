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

local function getPlayerEntity()
    local players = EntityGetWithTag("player_unit")
    if #players == 0 then return end

    return players[1]
end

local function setInternalVariableValue(entity_id, variable_name, variable_type, new_value)

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

local function getInternalVariableValue(entity_id, variable_name, variable_type)
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

local function getCurrentlyEquippedWandId()
    local i2c_id = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "Inventory2Component")
    local wand_id = ComponentGetValue2( i2c_id, "mActiveItem" )
    if(EntityHasTag(wand_id, "wand")) then
        return wand_id
    else
        return nil
    end
end

local function getCurrentlyEquippedPartId()
	local yada = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "Inventory2Component")
    local broken_part = ComponentGetValue2( yada, "mActiveItem" )
    if(EntityHasTag(broken_part, "forge_wand_part")) then
        return broken_part
    else
        return nil
    end
end

local function moddedWandSpellBreaker()
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

local function make_random_card( x, y )
	
	SetRandomSeed( GameGetFrameNum(), x + y )
	
	local item = ""
	local valid = false
	
	local rand = Random( 1, 69 )
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
		print( "No valid action entity found!?" )
	end
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local alch_perk = GameHasFlagRun("Perk_Wand_Killer")
local mast_perk = GameHasFlagRun("Perk_Wand_Master")
local mach_perk = GameHasFlagRun("Perk_Wand_Crafter")
SetRandomSeed( GameGetFrameNum(), y - x )
function interacting(entity_who_interacted, entity_interacted, interactable_name)
	local current_part = getCurrentlyEquippedPartId()
	if current_part ~= nil then
		EntityRemoveTag(current_part, "forge_wand_part")
		wand_forge_builder()
	elseif alch_perk then
		local current_wand = getCurrentlyEquippedWandId()
		if current_wand ~= nil then
			moddedWandSpellBreaker()
			local card_rnd = Random(0,3)
			local card_counter = 0
			local px, py = EntityGetTransform(entity_who_interacted)
			while card_counter <= card_rnd do
				make_random_card(px,py)
				card_counter = card_counter + Random(1,2)
			end
			EntityKill(current_wand)
			local part_rnd = Random(1,#rand_part_table)
			EntityLoad(rand_part_table[part_rnd], px, py)
		end
	elseif mast_perk then
		local current_wand = getCurrentlyEquippedWandId()
		if current_wand == nil then return end
		local AC_id = EntityGetFirstComponentIncludingDisabled( current_wand, "AbilityComponent" )
		local mat_god = EntityGetWithName("bhybkd")
		local vsc_id = EntityGetFirstComponentIncludingDisabled(mat_god, "VariableStorageComponent")
		local basic_mat = ComponentGetValue2(vsc_id, "value_int")
		local capacity = ComponentObjectGetValue2(AC_id, "gun_config", "deck_capacity")
		if capacity < 30 then
			capacity = math.min(capacity + basic_mat, 30)
			ComponentObjectSetValue2(AC_id, "gun_config", "deck_capacity", capacity)
		end
		local spread = ComponentObjectGetValue2(AC_id, "gunaction_config", "spread_degrees")
		ComponentObjectSetValue2(AC_id, "gunaction_config", "spread_degrees", math.max(spread - (basic_mat * 2), -30))
		local action_count = ComponentObjectGetValue2(AC_id, "gun_config", "actions_per_round")
		action_count = math.min(action_count + basic_mat, capacity)
		ComponentObjectSetValue2(AC_id, "gun_config", "actions_per_round", action_count)
		local better_mat = ComponentGetValue2(vsc_id, "value_float")
		action_count = math.max(action_count - (better_mat * 2), 1)
		ComponentObjectSetValue2(AC_id, "gun_config", "actions_per_round", action_count)
		local cast_delay = ComponentObjectGetValue2(AC_id, "gunaction_config", "fire_rate_wait")
		ComponentObjectSetValue2(AC_id, "gunaction_config", "fire_rate_wait", cast_delay - (better_mat * 2))
		local recharge = ComponentObjectGetValue2(AC_id, "gun_config", "reload_time")
		recharge = recharge - (better_mat * 20)
		ComponentObjectSetValue2(AC_id, "gunaction_config", "reload_time", recharge)
		local best_mat = tonumber(ComponentGetValue2(vsc_id, "value_string"))
		best_mat = best_mat or 0
		ComponentObjectSetValue2(AC_id, "gunaction_config", "reload_time", recharge + (best_mat * 3))
		local manamax = ComponentGetValue2(AC_id, "mana_max")
		ComponentSetValue2(AC_id, "mana_max", manamax + (best_mat * 15))
		local charge_speed = ComponentGetValue2( AC_id, "mana_charge_speed" )
		ComponentSetValue2(AC_id, "mana_charge_speed", charge_speed + (best_mat * 25))
		local unknown = tonumber(ComponentGetValue2(vsc_id, "name"))
		unknown = unknown or 0
		local power_trip = ComponentObjectGetValue2(AC_id, "gun_config", "shuffle_deck_when_empty")
		local stored_power = ComponentObjectGetValue2(AC_id, "gunaction_config", "speed_multiplier")
		if power_trip == 1 then
			ComponentObjectSetValue2(ability_component_id, "gun_config", "shuffle_deck_when_empty", 0)
			unknown = unknown - 1
			ComponentObjectSetValue2(ability_component_id, "gunaction_config", "speed_multiplier", math.min(stored_power + (unknown * 0.15), 50))
		else
			ComponentObjectSetValue2(ability_component_id, "gunaction_config", "speed_multiplier", math.min(stored_power + (unknown * 0.15), 50))
		end
		ComponentObjectSetValue2(ability_component_id, "gunaction_config", "speed_multiplier", math.min(stored_power + unknown * 0.3, 50))
		ComponentSetValue2(vsc_id, "name", "0")
		ComponentSetValue2(vsc_id, "value_string", "0")
		ComponentSetValue2(vsc_id, "value_float", 0)
		ComponentSetValue2(vsc_id, "value_int", 0)
	elseif mach_perk then
		local mat_god = EntityGetWithName("bhybkd")
		local vsc_id = EntityGetFirstComponentIncludingDisabled(mat_god, "VariableStorageComponent")
		local basic_mat = ComponentGetValue2(vsc_id, "value_int")
		for i = 1, basic_mat do
			if i >=5 then
				break
			end
			local loaded_wand = EntityLoad("data/entities/items/wand_level_04_better.xml", Random(-10000,10000), Random(-10000, 10000))
			EntityApplyTransform(loaded_wand, x - (i * 5), y - 3)
			ComponentSetValue2(vsc_id, "value_int", basic_mat - i)
		end
		local better_mat = ComponentGetValue2(vsc_id, "value_float")
		for i = 1, better_mat do
			if i >=5 then
				break
			end
			local loaded_wand = EntityLoad("data/entities/items/wand_level_05_better.xml", Random(-10000,10000), Random(-10000, 10000))
			EntityApplyTransform(loaded_wand, x - (i * 5), y - 6)
			ComponentSetValue2(vsc_id, "value_int", better_mat - i)
		end
		local best_mat = tonumber(ComponentGetValue2(vsc_id, "value_string"))
		for i = 1, best_mat do
			if i >=5 then
				break
			end
			local loaded_wand = EntityLoad("data/entities/items/wand_level_06_better.xml", Random(-10000,10000), Random(-10000, 10000))
			EntityApplyTransform(loaded_wand, x - (i * 5), y - 9)
			ComponentSetValue2(vsc_id, "value_int", best_mat - i)
		end
		local unknown = tonumber(ComponentGetValue2(vsc_id, "name"))
		for i = 1, best_mat do
			if i >=5 then
				break
			end
			local loaded_wand = EntityLoad("data/entities/items/wand_level_10.xml", Random(-10000,10000), Random(-10000, 10000))
			EntityApplyTransform(loaded_wand, x - (i * 5), y - 12)
			ComponentSetValue2(vsc_id, "value_int", unknown - i)
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