if GameHasFlagRun("Extol'sPheonixDeath") == false then
	GamePrintImportant( "Dust to Dust", "The Pheonix's Flames Dim!" )
	GameAddFlagRun("Extol'sPheonixDeath")
	ConvertMaterialEverywhere( CellFactory_GetType( "blood_precursor" ), CellFactory_GetType( "gunpowder_unstable" ) )
	ConvertMaterialEverywhere( CellFactory_GetType( "corruption_static" ), CellFactory_GetType( "gunpowder_unstable" ) )
	if GameHasFlagRun("Extol'sWaterLoonDeath") then
		ConvertMaterialEverywhere( CellFactory_GetType( "ext_sand_ground" ), CellFactory_GetType( "magic_liquid_blood_bird" ) )
		if HasFlagPersistent( "Forge_Perks_End" ) == false then
			GamePrintImportant( "For Your Quest Is Complete", "yet at what cost?" )
			AddFlagPersistent( "Forge_Perks_End" )
		end
	end
end
EntityKill(GetUpdatedEntityID())