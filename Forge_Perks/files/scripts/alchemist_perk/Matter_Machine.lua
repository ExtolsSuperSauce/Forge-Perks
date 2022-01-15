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

function spawn_wands()
	local max_rand = 53
	local loop_var = -27
	local entity_id = EntityGetWithName("Extol'sBirdCounter")
	local x, y = EntityGetTransform( entity_id )
	y = y -10
	SetRandomSeed( GameGetFrameNum(), x + y )
	local material_machine = getInternalVariableValue(entity_id, "stored_count", "value_int")
	GamePrint("error: ".. material_machine * 2 .. " too many wands spawned")
	local material_machine = material_machine * 3
	if GameHasFlagRun("First_print") == false then
		GamePrint("01001101 01111001 00100000 01010000 01101000 01101111 01100101 01101110 01101001 01111000")
		GameAddFlagRun("First_print")
	end
	for i = 1, material_machine do
		local rando_y = Random( 1, 40 )
		local rando_x = Random( 1, max_rand )
		if max_rand >= 173 then
			local max_rand = 53
			local loop_var = loop_var + 60
			if loop_var < -200 then
				loop_var = -27
				GamePrint("ERRORERRORERRORERRORERRORERRORERRORERROR")
			end
			EntityLoad("data/entities/items/wand_level_10.xml", x, y )
			GamePrint("LUAError in Matter_Machine.lua: Attempt to do arithmetic local variable x. Number was expected, but recieved nil.")
		else
			max_rand = max_rand + 3
			loop_var = loop_var + -4
		end
		setInternalVariableValue (entity_id, "stored_count", "value_int", 0)
		EntityLoad("data/entities/items/wand_level_10.xml", x  + loop_var - rando_x, y - rando_y )
	end
end