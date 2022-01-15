 dofile_once("data/scripts/lib/utilities.lua")

-- NOTE( Petri ): 
-- There is a mods/nightmare potion.lua which overwrites this one.

potions = 
{
	{
		material="creepy_liquid",
		cost=300,
	},
	{
		material="magic_liquid_hp_regeneration_unstable",
		cost=300,
	},
	{
		material="blood_worm",
		cost=300,
	},
	{
		material="gold",
		cost=300,
	},
	{
		material="snow",
		cost=300,
	},
	{
		material="cement",
		cost=300,
	},
	{
		material="salt",
		cost=300,
	},
	{
		material="urine",
		cost=300,
	},
	{
		material="purifying_powder",
		cost=300,
	},
	{
		material="magic_liquid_unstable_teleportation",
		cost=500,
	},
	{
		material="meat_polymorph_protection",
		cost=500,
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
		material="porridge",
		cost=800,
	},
	{
		material="plasma_fading",
		cost=800,
	},
	{
		material="gold_molten",
		cost=800,
	},
	{
		material="honey",
		cost=800,
	},
	{
		material="glue",
		cost=800,
	},
}

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
	SetRandomSeed( day + temp2, y + temp3 ) 
	if Random(1, 50000) >= 50 then
		local potion = random_from_array( potions )
		AddMaterialInventoryMaterial( entity_id, potion.material, 1000 )
	else
		if Random(1, 100) > 49 then
			AddMaterialInventoryMaterial( entity_id, "midas", 1000 )
		else
			AddMaterialInventoryMaterial( entity_id, "midas_precursor", 1000 )
		end
	end
end
