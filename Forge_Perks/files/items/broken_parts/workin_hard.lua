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

dofile_once("mods/Forge_Perks/files/items/part_list.lua")

function TagRemoval()
	local spawn = EntityGetWithTag("Extol_Freshly_Forged")
	local entity_id = EntityGetWithName("Extol'sForgedSpriteGod")
	local x, y = EntityGetTransform(entity_id)
	local new_essence = getInternalVariableValue(entity_id, "gem", "value_string")
	local essence_sprite = getInternalVariableValue(entity_id, "gem", "value_int")
	local new_head = getInternalVariableValue(entity_id, "head", "value_string")
	local head_sprite = getInternalVariableValue(entity_id, "head", "value_int")
	local new_handle = getInternalVariableValue(entity_id, "handle", "value_string")
	local handle_sprite = getInternalVariableValue(entity_id, "handle", "value_int")
	setInternalVariableValue(entity_id, "old_gem", "value_string", "nil")
	setInternalVariableValue(entity_id, "old_head", "value_string", "nil")
	setInternalVariableValue(entity_id, "old_handle", "value_string", "nil")
	ComponentSetValue2(handle_sprite, "image_file", "data/ui_gfx/empty.png")
	ComponentSetValue2(essence_sprite, "image_file", "data/ui_gfx/empty.png")
	ComponentSetValue2(head_sprite, "image_file", "data/ui_gfx/empty.png")
	EntityRefreshSprite(entity_id, essence_sprite)
	EntityRefreshSprite(entity_id, head_sprite)
	EntityRefreshSprite(entity_id, handle_sprite)
	if #spawn >= 1 then
		EntityRemoveTag(spawn[1], "Extol_Freshly_Forged" )
		setInternalVariableValue(entity_id, "handle", "value_string", "nil")
		setInternalVariableValue(entity_id, "head", "value_string", "nil")
		setInternalVariableValue(entity_id, "gem", "value_string", "nil")
		setInternalVariableValue(entity_id, "old_gem", "value_string", "nil")
		setInternalVariableValue(entity_id, "old_head", "value_string", "nil")
		setInternalVariableValue(entity_id, "old_handle", "value_string", "nil")
		GameRemoveFlagRun("Extol_ForgedWand_Check")
	else
		GamePrint("Not A Valid Combination...")
		EntityLoad(handle_return_table[tonumber(new_handle + 1)], x - 23, y + 5)
		EntityLoad(head_return_table[tonumber(new_head + 1)], x, y + 5)
		EntityLoad(gem_return_table[tonumber(new_essence + 1)], x + 23, y + 5)
		setInternalVariableValue(entity_id, "handle", "value_string", "nil")
		setInternalVariableValue(entity_id, "head", "value_string", "nil")
		setInternalVariableValue(entity_id, "gem", "value_string", "nil")
		setInternalVariableValue(entity_id, "old_gem", "value_string", "nil")
		setInternalVariableValue(entity_id, "old_head", "value_string", "nil")
		setInternalVariableValue(entity_id, "old_handle", "value_string", "nil")
		GameRemoveFlagRun("Extol_ForgedWand_Check")
	end
end
