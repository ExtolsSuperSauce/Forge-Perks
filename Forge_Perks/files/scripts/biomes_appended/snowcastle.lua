
RegisterSpawnFunction( 0xff96fff6, "modded_spawn_forge_check" )
RegisterSpawnFunction( 0xff9627f9, "extols_reasonable_namez" )
RegisterSpawnFunction( 0xff4cacaa, "Spawn_Sprite_God" )
RegisterSpawnFunction( 0xFFFF54B2, "Cleanup_crew" )
function modded_spawn_forge_check(x, y)
	EntityLoad( "mods/Forge_Perks/files/scripts/alchemist_perk/Wand_Breaker.xml", x, y+2 )
end

function extols_reasonable_namez(x, y)
	EntityLoad( "mods/Forge_Perks/files/scripts/machine_perk/modded_spawn_forge_check_basic.xml", x, y )
	EntityLoad( "mods/Forge_Perks/files/scripts/machine_perk/modded_spawn_forge_check_better.xml", x, y )
	EntityLoad( "mods/Forge_Perks/files/scripts/machine_perk/modded_spawn_forge_check_best.xml", x, y )
	EntityLoad( "mods/Forge_Perks/files/scripts/master_perk/basic_aftermath.xml", x, y )
	EntityLoad( "mods/Forge_Perks/files/scripts/master_perk/forge_check_better.xml", x, y )
	EntityLoad( "mods/Forge_Perks/files/scripts/master_perk/forge_check_best.xml", x, y )
	EntityLoad( "mods/Forge_Perks/files/scripts/master_perk/forge_check_best_old.xml", x, y )
	EntityLoad( "mods/Forge_Perks/files/scripts/alchemist_perk/forge_check_new.xml", x, y )
	EntityLoad( "mods/Forge_Perks/files/scripts/alchemist_perk/Cleanup.xml", x-2, y-5 )
end

function Spawn_Sprite_God(x, y)	
	EntityLoad( "mods/Forge_Perks/files/scripts/alchemist_perk/Sprite_Combine.xml", x, y )
end

function Cleanup_crew(x, y)
	EntityLoad( "mods/Forge_Perks/files/scripts/alchemist_perk/Cleanup_switch.xml", x, y+3 )
end