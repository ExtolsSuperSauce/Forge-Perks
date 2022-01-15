function material_area_checker_success( pos_x, pos_y )
	if ((GameHasFlagRun("Perk_Wand_Master")) and (GameHasFlagRun("Perk_Wand_Crafter") == false)) or ((GameHasFlagRun("Perk_Wand_Master") == false) and (GameHasFlagRun("Perk_Wand_Crafter"))) then
		forger_better()
	end
end

function getPlayerEntity()
    local players = EntityGetWithTag("player_unit")
    if #players == 0 then return end

    return players[1]
end

function addNewInternalVariable(entity_id, variable_name, variable_type, initial_value)
    if(variable_type == "value_int") then
        EntityAddComponent2(entity_id, "VariableStorageComponent", {
            name=variable_name,
            value_int=initial_value
        })
    elseif(variable_type == "value_string") then
        EntityAddComponent2(entity_id, "VariableStorageComponent", {
            name=variable_name,
            value_string=initial_value
        })
    elseif(variable_type == "value_float") then
        EntityAddComponent2(entity_id, "VariableStorageComponent", {
            name=variable_name,
            value_float=initial_value
        })
	elseif(variable_type == "value_bool") then
        EntityAddComponent2(entity_id, "VariableStorageComponent", {
            name=variable_name,
            value_bool=initial_value
        })
    end
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

function forger_better()
	local count = 0
	local entity_id = GetUpdatedEntityID()
	local backup = EntityGetWithName("Extol'sMachineCounter")
	local other = EntityGetWithName("kjlbndnls")
	local run_count = getInternalVariableValue(entity_id, "stored_run_count", "value_bool")
	if (entity_id ~= -1) and (run_count == false) then 
		EntitySetComponentsWithTagEnabled(entity_id, "enabled_by_liquid", true)
		EntitySetComponentsWithTagEnabled(entity_id, "disabled_by_liquid", false)
		SetTimeOut( 1.5, "mods/Forge_Perks/files/scripts/alchemist_perk/better_timeout.lua", "IHaveBeenBad" )
		setInternalVariableValue(entity_id, "stored_run_count", "value_bool", true)
	else
		setInternalVariableValue(backup, "stored_run_count", "value_bool", false)
		setInternalVariableValue(other, "stored_run_count", "value_bool", false)
		count = getInternalVariableValue(backup, "stored_count", "value_int")
		setInternalVariableValue(backup, "stored_count", "value_int", count + 1)
		EntitySetComponentsWithTagEnabled(backup, "enabled_by_liquid", false)
		EntitySetComponentsWithTagEnabled(backup, "disabled_by_liquid", true)
		EntitySetComponentsWithTagEnabled(other, "enabled_by_liquid", false)
		EntitySetComponentsWithTagEnabled(other, "disabled_by_liquid", true)
		GamePrint("Better = " .. count + 1)
	end
end

