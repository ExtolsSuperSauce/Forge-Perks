
RegisterSpawnFunction( 0xff96fff6, "modded_spawn_forge_check" )
RegisterSpawnFunction( 0xff9627f9, "extols_reasonable_namez" )
RegisterSpawnFunction( 0xff4cacaa, "Spawn_Sprite_God" )
RegisterSpawnFunction( 0xff1E1E56, "SpawnExtolMatDump")
function modded_spawn_forge_check(x, y)
	EntityLoad( "mods/Forge_Perks/files/scripts/alchemist_perk/Wand_Breaker.xml", x, y+2 )
end

function extols_reasonable_namez(x, y)
	EntityLoad( "mods/Forge_Perks/files/scripts/machine_perk/forge_check.xml", x, y )
end

function Spawn_Sprite_God(x, y)	
	EntityLoad( "mods/Forge_Perks/files/scripts/alchemist_perk/Sprite_Combine.xml", x, y )
end

function SpawnExtolMatDump(x,y)
	EntityLoad("mods/Forge_Perks/files/scripts/machine_perk/mat_dump.xml", x, y )
end
