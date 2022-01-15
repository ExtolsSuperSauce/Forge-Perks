function interacting(entity_who_interacted, entity_interacted, interactable_name)
	local entity_id = EntityGetWithName("Extol's_Cleanup_Crew")
	local other_id = GetUpdatedEntityID()
	local ic_id = EntityGetFirstComponentIncludingDisabled( other_id, "InteractableComponent" )
	if GameHasFlagRun("Cleanup_on_aisle_9") then
		EntitySetComponentsWithTagEnabled( entity_id, "fire", false )
		GameRemoveFlagRun("Cleanup_on_aisle_9")
		GamePrint("Deactivated")
		ComponentSetValue2( ic_id, "ui_text", "Press E to Dump Waste" )
	else
		EntitySetComponentsWithTagEnabled( entity_id, "fire", true )
		GameAddFlagRun("Cleanup_on_aisle_9")
		GamePrint("Removing Waste Material")
		ComponentSetValue2( ic_id, "ui_text", "Press E to Stop" )
	end
end