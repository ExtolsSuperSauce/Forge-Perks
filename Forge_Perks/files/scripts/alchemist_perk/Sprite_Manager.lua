function DoubleCheck()
	local sprite_manager_id = GetUpdatedEntityID()
	local sprite_components = EntityGetComponentIncludingDisabled(sprite_manager_id, "SpriteComponent")
	for i, comp in ipairs(sprite_components) do
		local sprite_offset = ComponentGetValue2(comp, "offset_x")
		if sprite_offset == 30 then
			local offset_1 = comp
			setInternalVariableValue(sprite_manager_id, "handle", "value_int", offset_1)
		elseif sprite_offset == -15 then
			local offset_3 = comp
			setInternalVariableValue(sprite_manager_id, "gem", "value_int", offset_3)
		else
			local offset_2 = comp
			setInternalVariableValue(sprite_manager_id, "head", "value_int", offset_2)
		end
	end
	EntityRefreshSprite(sprite_manager_id, offset_1)
	EntityRefreshSprite(sprite_manager_id, offset_2)
	EntityRefreshSprite(sprite_manager_id, offset_3)
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
dofile_once("mods/Forge_Perks/files/items/part_list.lua")
DoubleCheck() -- first check
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local new_essence = getInternalVariableValue(entity_id, "gem", "value_string")
local essence_sprite = getInternalVariableValue(entity_id, "gem", "value_int")
local new_head = getInternalVariableValue(entity_id, "head", "value_string")
local head_sprite = getInternalVariableValue(entity_id, "head", "value_int")
local new_handle = getInternalVariableValue(entity_id, "handle", "value_string")
local handle_sprite = getInternalVariableValue(entity_id, "handle", "value_int")
local old_essence = getInternalVariableValue(entity_id, "old_gem", "value_string")
local old_head = getInternalVariableValue(entity_id, "old_head", "value_string")
local old_handle = getInternalVariableValue(entity_id, "old_handle", "value_string")
if new_essence ~= old_essence or new_head ~= old_head or new_handle ~= old_handle then
	if new_essence ~= old_essence and new_essence ~= "nil" and new_essence ~= nil then
		if old_essence ~= "nil" and GameHasFlagRun("GemStone_Forged") == false and old_essence ~= nil then
			EntityLoad(gem_return_table[tonumber(old_essence + 1)], x + 23, y + 5)
		elseif GameHasFlagRun("GemStone_Forged") then
			GameRemoveFlagRun("GemStone_Forged")
		end
		ComponentSetValue2(essence_sprite, "image_file", gem_table[tonumber(new_essence) + 1])
		DoubleCheck()
		setInternalVariableValue(entity_id, "old_gem", "value_string", new_essence)
	end
	if new_head ~= old_head and new_head ~= "nil" and new_head ~= nil then
		if old_head ~= "nil" and GameHasFlagRun("WandHead_Forged") == false and old_head ~= nil then
			EntityLoad(head_return_table[tonumber(old_head + 1)], x, y + 5)
		elseif GameHasFlagRun("WandHead_Forged") then
			GameRemoveFlagRun("WandHead_Forged")
		end
		ComponentSetValue2(head_sprite, "image_file", head_table[tonumber(new_head) + 1])
		DoubleCheck()
		setInternalVariableValue(entity_id, "old_head", "value_string", new_head)
	end
	if new_handle ~= old_handle and new_handle ~= "nil" and new_handle ~= nil then
		if old_handle ~= "nil" and GameHasFlagRun("WandShaft_Forged") == false and old_handle ~= nil then
			EntityLoad(handle_return_table[tonumber(old_handle + 1)], x - 23, y + 5)
		elseif GameHasFlagRun("WandShaft_Forged") then
			GameRemoveFlagRun("WandShaft_Forged")
		end
		ComponentSetValue2(handle_sprite, "image_file", handle_table[tonumber(new_handle) + 1])
		DoubleCheck()
		setInternalVariableValue(entity_id, "old_handle", "value_string", new_handle)
	end
elseif new_essence ~= "nil" and new_head ~= "nil" and new_handle ~= "nil" and new_essence ~= nil and new_head ~= nil and new_handle ~= nil and GameHasFlagRun("Extol_ForgedWand_Check") == false then
	local spawn = EntityLoad("mods/Forge_Perks/files/items/forged_wands/wand_" .. new_handle .. new_head .. new_essence .. ".xml", x - 25, y)
	GameAddFlagRun("Extol_ForgedWand_Check")
	SetTimeOut( 1 , "mods/Forge_Perks/files/items/broken_parts/workin_hard.lua", "TagRemoval" )
end
