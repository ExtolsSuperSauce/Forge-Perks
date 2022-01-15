if GameHasFlagRun("Extol'sWaterLoonDeath") == false then
	GamePrintImportant( "A Bitter End", "The Water Loon Falls Once Again!" )
	GameAddFlagRun("Extol'sWaterLoonDeath")
	ConvertMaterialEverywhere( CellFactory_GetType( "blood_branch" ), CellFactory_GetType( "gunpowder_unstable" ) )
	ConvertMaterialEverywhere( CellFactory_GetType( "blood_water" ), CellFactory_GetType( "gunpowder_unstable" ) )
	ConvertMaterialEverywhere( CellFactory_GetType( "creepy_liquid" ), CellFactory_GetType( "gunpowder_unstable" ) )
	if GameHasFlagRun("Extol'sPheonixDeath") then
		ConvertMaterialEverywhere( CellFactory_GetType( "sand_ground" ), CellFactory_GetType( "magic_liquid_blood_bird" ) )
		if HasFlagPersistent( "Forge_Perks_End" ) == false then
			GamePrintImportant( "Thank You For Playing!!", "You've found all the Secrets! Great Job!" )
			AddFlagPersistent( "Forge_Perks_End" )
		end
	end
end
EntityKill(GetUpdatedEntityID())