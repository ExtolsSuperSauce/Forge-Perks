 dofile_once("data/scripts/lib/utilities.lua")

-- NOTE( Petri ): 
-- There is a mods/nightmare potion.lua which overwrites this one.

materials_standard = 
{
	{
		material="lava",
		cost=300,
	},
	{
		material="water",
		cost=200,
	},
	{
		material="blood",
		cost=200,
	},
	{
		material="alcohol",
		cost=200,
	},
	{
		material="oil",
		cost=200,
	},
	{
		material="slime",
		cost=200,
	},
	{
		material="acid",
		cost=400,
	},
	{
		material="swamp",
		cost=300,
	},
	{
		material="gunpowder_unstable",
		cost=400,
	},
	{
		material="blood_cold",
		cost=400,
	},
	{
		material="liquid_fire",
		cost=400,
	},
		{
		material="swamp",
		cost=300,
	},
	{
		material="swamp",
		cost=300,
	},
}

materials_magic = 
{
	{
		material="magic_liquid_unstable_teleportation",
		cost=500,
	},
	{
		material="magic_liquid_polymorph",
		cost=500,
	},
	{
		material="magic_liquid_random_polymorph",
		cost=500,
	},
	{
		material="magic_liquid_berserk",
		cost=500,
	},
	{
		material="magic_liquid_charm",
		cost=800,
	},
	{
		material="magic_liquid_invisibility",
		cost=800,
	},
	{
		material="material_confusion",
		cost=800,
	},
	{
		material="magic_liquid_movement_faster",
		cost=800,
	},
	{
		material="magic_liquid_faster_levitation",
		cost=800,
	},
	{
		material="magic_liquid_worm_attractor",
		cost=800,
	},
	{
		material="magic_liquid_protection_all",
		cost=800,
	},
	{
		material="magic_liquid_mana_regeneration",
		cost=500,
	},
	{
		material="magic_liquid_faster_levitation_and_movement",
		cost=500,
	},
}

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
	SetRandomSeed( day + temp2, y + temp3 ) 
	local potion_material = "water"

	if( Random( 0, 100 ) <= 75 ) then
		-- 0.05% chance of magic_liquid_
		if( Random( 0, 100000 ) <= 250 ) then
			potion_material = "magic_liquid_hp_regeneration"
		elseif( Random( 200, 100000 ) <= 250 ) then
			potion_material = "purifying_powder"
		elseif( Random(1, 10000) <= 75) then
			potion_material = "magic_liquid_hp_regeneration_unstable"
		else
			potion_material = random_from_array( materials_magic )
			potion_material = potion_material.material
		end
	else
		potion_material = random_from_array( materials_standard )
		potion_material = potion_material.material
	end

	-- load the material from VariableStorageComponent

	local total_capacity = tonumber( GlobalsGetValue( "EXTRA_POTION_CAPACITY_LEVEL", "1000" ) ) or 1000
	if ( total_capacity > 1000 ) then
		local comp = EntityGetFirstComponentIncludingDisabled( entity_id, "MaterialSuckerComponent" )
			
		if ( comp ~= nil ) then
			ComponentSetValue( comp, "barrel_size", total_capacity )
		end
		
		EntityAddTag( entity_id, "extra_potion_capacity" )
	end

	AddMaterialInventoryMaterial( entity_id, potion_material, total_capacity )
end