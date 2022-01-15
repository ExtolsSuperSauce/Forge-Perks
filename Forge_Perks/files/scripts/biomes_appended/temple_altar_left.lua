
RegisterSpawnFunction( 0xffFFCDBF , "temple_potion_shop" )

local old_init = init

function init( x, y, w, h )
	spawn_altar_top(x, y, false)
	local seed = MagicNumbersGetValue( "WORLD_SEED" )
	SetRandomSeed( seed, x+y )
	local rand = Random(1, 100)
	if rand <= 25 then
		LoadPixelScene( "mods/Forge_Perks/files/pixel_scenes/altered_altar_left.png", "data/biome_impl/temple/altar_left_visual.png", x, y-40+300, "mods/Forge_Perks/files/scripts/biomes_appended/altar_left_background_shop.png", true )
	else
		LoadPixelScene( "data/biome_impl/temple/altar_left.png", "data/biome_impl/temple/altar_left_visual.png", x, y-40+300, "data/biome_impl/temple/altar_left_background.png", true )
	end
end

function temple_potion_shop(x, y)
	EntityLoad( "mods/Forge_Perks/files/npcs/potion_boi/potion_boi.xml", x, y-3 )
end