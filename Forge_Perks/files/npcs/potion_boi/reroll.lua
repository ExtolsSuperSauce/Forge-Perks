dofile_once("data/scripts/lib/utilities.lua")
function random_from_weight( tbl )
	local weight_sum = 0.0
	for i, weight in pairs(tbl) do
		weight_sum = weight_sum + weight
	end
	local rnd = Randomf( 0.0, weight_sum)
	for i, weight in pairs(tbl) do
		weight_sum = weight_sum - weight
		if weight_sum <= rnd then
			return i
		end
	end
end

local magic_mats = {
	["creepy_liquid"] = 0.01,
	["magic_liquid_protection_all"] = 0.1,
	["magic_liquid_hp_regeneration_unstable"] = 0.001,
	["magic_liquid_hp_regeneration"] = 0.005,
	["blood_worm"] = 1.3,
	["urine"] = 0.02,
	["purifying_powder"] = 0.2,
	["magic_liquid_unstable_teleportation"] = 1.5,
	["magic_liquid_teleportation"] = 0.8,
	["material_confusion"] = 0.8,
	["magic_liquid_polymorph"] = 1,
	["magic_liquid_movement_faster"] = 0.7,
	["magic_liquid_mana_regeneration"] = 1.4,
	["gold_molten"] = 0.1,
	["magic_liquid_worm_attractor"] = 1.3,
	["magic_liquid_faster_levitation"] = 0.4,
	["plasma_fading"] = 0.5,
	["magic_liquid_charm"] = 0.5,
	["magic_liquid_invisibility"] = 0.8,
	["magic_liquid_berserk"] = 0.8,
	["magic_liquid_unstable_polymorph"] = 0.5,
	["magic_liquid_random_polymorph"] = 0.6,
	["magic_liquid_faster_levitation_and_movement"] = 0.5,
	["material_rainbow"] = 0.001,
	["material_darkness"] = 0.002,
	["magic_liquid"] = 0.0001,
	["blood_cold"] = 0.2,
	["void_liquid"] = 0.05,
	["cursed_liquid"] = 0.02,
	["liquid_fire"] = 0.5,
	["liquid_fire_weak"] = 0.7
}

local normal_mats = {
	["swamp"] = 1.4,
	["water_swamp"] = 0.4,
	["blood"] = 1.15,
	["salt"] = 0.45,
	["water_salt"] = 0.75,
	["oil"] = 1.5,
	["acid"] = 1.25,
	["alcohol"] = 0.7,
	["juhannussima"] = 0.25,
	["sima"] = 0.3,
	["midas_precursor"] = 0.001,
	["water_ice"] = 0.05,
	["water"] = 0.1,
	["radioactive_liquid"] = 0.3,
	["peat"] = 0,
	["slime"] = 0.2,
	["slime_green"] = 0.15,
	["cement"] = 0.1,
	["poo"] = 0.001,
	["steel_molten"] = 0.75,
	["brass_molten"] = 0.2,
	["copper_molten"] = 0.3,
	["silver_molten"] = 0.35,
	["radioactive_liquid_yellow"] = 0,
	["poison"] = 0.2,
	["lava"] = 0.2
}

local mats_list = {
	["creepy_liquid"] = 0.01,
	["magic_liquid_protection_all"] = 0.1,
	["magic_liquid_hp_regeneration_unstable"] = 0.001,
	["magic_liquid_hp_regeneration"] = 0.005,
	["blood_worm"] = 1.3,
	["urine"] = 0.02,
	["purifying_powder"] = 0.2,
	["magic_liquid_unstable_teleportation"] = 1.5,
	["magic_liquid_teleportation"] = 0.8,
	["material_confusion"] = 0.8,
	["magic_liquid_polymorph"] = 1,
	["magic_liquid_movement_faster"] = 0.7,
	["magic_liquid_mana_regeneration"] = 1.4,
	["gold_molten"] = 0.1,
	["magic_liquid_worm_attractor"] = 1.3,
	["magic_liquid_faster_levitation"] = 0.4,
	["plasma_fading"] = 0.5,
	["magic_liquid_charm"] = 0.5,
	["magic_liquid_invisibility"] = 0.8,
	["magic_liquid_berserk"] = 0.8,
	["magic_liquid_unstable_polymorph"] = 0.5,
	["magic_liquid_random_polymorph"] = 0.6,
	["magic_liquid_faster_levitation_and_movement"] = 0.5,
	["material_rainbow"] = 0.001,
	["material_darkness"] = 0.002,
	["magic_liquid"] = 0.0001,
	["blood_cold"] = 0.2,
	["void_liquid"] = 0.05,
	["cursed_liquid"] = 0.02,
	["liquid_fire"] = 0.5,
	["liquid_fire_weak"] = 0.7,
	["swamp"] = 1.4,
	["water_swamp"] = 0.4,
	["blood"] = 1.15,
	["salt"] = 0.45,
	["water_salt"] = 0.75,
	["oil"] = 1.5,
	["acid"] = 1.25,
	["alcohol"] = 0.7,
	["juhannussima"] = 0.25,
	["sima"] = 0.3,
	["midas_precursor"] = 0.001,
	["water_ice"] = 0.05,
	["water"] = 0.1,
	["radioactive_liquid"] = 0.3,
	["peat"] = 0,
	["slime"] = 0.2,
	["slime_green"] = 0.15,
	["cement"] = 0.1,
	["poo"] = 0.001,
	["steel_molten"] = 0.75,
	["brass_molten"] = 0.2,
	["copper_molten"] = 0.3,
	["silver_molten"] = 0.35,
	["radioactive_liquid_yellow"] = 0,
	["poison"] = 0.2,
	["lava"] = 0.2
}

function interacting( entity_who_interacted, entity_interacted, interactable_name )
	local year, month, day, hour, minute, sec = GameGetDateAndTimeLocal()
	SetRandomSeed(GameGetRealWorldTimeSinceStarted(), year - month + day / hour + minute )
	local wallet = EntityGetFirstComponentIncludingDisabled( entity_who_interacted, "WalletComponent" )
	local dolla = ComponentGetValue2( wallet, "money" ) 
	local spent = ComponentGetValue2( wallet, "money_spent" )
	local pboi_vsc = EntityGetFirstComponentIncludingDisabled( entity_interacted, "VariableStorageComponent" )
	local reroll_count = ComponentGetValue2( pboi_vsc, "value_float" )
	local use_count = ComponentGetValue2( pboi_vsc, "value_int" )
	if dolla >= 2 ^ reroll_count * (use_count * 5) then
		ComponentSetValue2( wallet, "money", dolla - (2 ^ reroll_count) * (use_count * 5) )
		ComponentSetValue2( pboi_vsc, "value_float", reroll_count + 1)
		local txt_sprt = EntityGetFirstComponentIncludingDisabled( entity_interacted, "SpriteComponent", "TEXT_SPRITE" )
		local rr_cost = 2 ^ (reroll_count + 1) * (use_count * 5)
		ComponentSetValue2( txt_sprt, "text", rr_cost )
		local offsetx = 6
		local text = tostring(rr_cost)
		local textwidth = 0
		for i=1,#text do
			local l = string.sub( text, i, i )
		
			if ( l ~= "1" ) then
				textwidth = textwidth + 6
			else
				textwidth = textwidth + 3
			end
		end
		offsetx = textwidth * 0.5 - 0.5
		ComponentSetValue2( txt_sprt, "offset_x", offsetx )
		EntityRefreshSprite( entity_interacted, txt_sprt )
		local mat_type = ComponentGetValue2( pboi_vsc, "value_string" )
		local temp_pots = EntityGetWithTag( "extol_temp_pot" )
		if mat_type == "magic" then
			for i, potion in ipairs(temp_pots) do
				local pot_mic = EntityGetFirstComponentIncludingDisabled( potion, "MaterialInventoryComponent" )
				EntityRemoveComponent( potion, pot_mic )
				EntityAddComponent( potion, "MaterialInventoryComponent", {drop_as_item="0",leak_pressure_min="0.07",leak_on_damage_percent="1",min_damage_to_leak="0.0",death_throw_particle_velocity_coeff="0.5"})
				if Random(1,6) ~= 5 then
					AddMaterialInventoryMaterial( potion, random_from_weight( magic_mats ), 1000 )
				else
					AddMaterialInventoryMaterial( potion, random_from_weight( mats_list ), 1000 )
				end
			end
		elseif mat_type == "nature" then
			for i, potion in ipairs(temp_pots) do
				local pot_mic = EntityGetFirstComponentIncludingDisabled( potion, "MaterialInventoryComponent" )
				EntityRemoveComponent( potion, pot_mic )
				EntityAddComponent( potion, "MaterialInventoryComponent", {drop_as_item="0",leak_pressure_min="0.07",leak_on_damage_percent="1",min_damage_to_leak="0.0",death_throw_particle_velocity_coeff="0.5"})
				if Random(0,1) == 0 then 
					AddMaterialInventoryMaterial( potion, random_from_weight( normal_mats ), 1000 )
				else
					AddMaterialInventoryMaterial( potion, random_from_weight( mats_list ), 1000 )
				end
			end
		else
			for i, potion in ipairs(temp_pots) do
				local pot_mic = EntityGetFirstComponentIncludingDisabled( potion, "MaterialInventoryComponent" )
				EntityRemoveComponent( potion, pot_mic )
				EntityAddComponent( potion, "MaterialInventoryComponent", {drop_as_item="0",leak_pressure_min="0.07",leak_on_damage_percent="1",min_damage_to_leak="0.0",death_throw_particle_velocity_coeff="0.5"})
				local rand_materials = CellFactory_GetAllLiquids( false )
				if Random(0,1) == 1 then rand_materials = CellFactory_GetAllSands( false ) end
				local return_pot_one = random_from_array( materials )
				AddMaterialInventoryMaterial( potion, "return_pot_one", 1000 )
			end
		end
	end
end