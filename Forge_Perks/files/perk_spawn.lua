dofile_once( "data/scripts/perks/perk.lua" )
local eid = GetUpdatedEntityID()
local x, y = EntityGetTransform( eid )
perk_spawn( x - 30, y, "FORGE_MACHINE", true )
perk_spawn( x, y, "FORGE_MASTER", true)
perk_spawn( x + 30, y, "FORGE_ALCHEMIST", true)
EntityKill( eid )