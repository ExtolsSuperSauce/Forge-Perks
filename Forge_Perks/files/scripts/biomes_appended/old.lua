if GameHasFlagRun("Extol'sWaterLoon") == false then
	GamePrintImportant( "A New Beginning", "The Water Loon Rises Once Again!" )
	GameAddFlagRun("Extol'sWaterLoon")
end
EntityKill(GetUpdatedEntityID())
