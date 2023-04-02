dofile_once("data/scripts/lib/utilities.lua")

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


local me = GetUpdatedEntityID()
local player = EntityGetWithTag("player_unit")[1]
local wallet_comp = EntityGetFirstComponentIncludingDisabled( player, "WalletComponent" )
local money = ComponentGetValue2( wallet_comp, "money" )
local vsc_id = EntityGetFirstComponentIncludingDisabled( me, "VariableStorageComponent")
local use_count = ComponentGetValue2( vsc_id, "value_int" )
if player ~= nil and money < 100*use_count then return end

local year, month, day, hour, minute, sec = GameGetDateAndTimeLocal()
SetRandomSeed(GameGetRealWorldTimeSinceStarted(), year - month + day / hour + minute )
local pos_x, pos_y = EntityGetTransform(me)
local pot_pos_y = pos_y + 22
local active = ComponentGetValue2(vsc_id, "value_bool")
if not active then
	local nearby_potions = EntityGetInRadiusWithTag( pos_x, pot_pos_y, 15, "potion")
	local potion_check = nil
	if #nearby_potions > 0 then
		for i, potion in ipairs(nearby_potions) do
			local pot_par = EntityGetParent(potion)
			if pot_par == 0 then
				potion_check = nearby_potions[i]
				break
			end
		end
		if potion_check == nil then return end
		local pot_mic = EntityGetFirstComponentIncludingDisabled(potion_check, "MaterialInventoryComponent" )
		local pot_mats = ComponentGetValue2( pot_mic, "count_per_material_type" )
		local pot_msc = EntityGetFirstComponentIncludingDisabled( potion_check, "MaterialSuckerComponent")
		local pot_max = ComponentGetValue2( pot_msc, "barrel_size" )
		for i, material in ipairs(pot_mats) do
			if material > pot_max * 0.85 then
				local mat_name = CellFactory_GetName( i - 1 )
				ComponentSetValue2( pot_mic, "on_death_spill", false )
				EntityKill(potion_check)
				ComponentSetValue2( wallet_comp, "money", money - 100*use_count )
				local spent = ComponentGetValue2( wallet_comp, "money_spent" )
				ComponentSetValue2( wallet_comp, "money_spent", spent + 100*use_count )
				EntitySetComponentsWithTagEnabled( me, "shop_cost", true )
				local txt_sprt = EntityGetFirstComponentIncludingDisabled( me, "SpriteComponent", "TEXT_SPRITE" )
				local reroll_count = ComponentGetValue2( vsc_id, "value_float" )
				local rr_cost = 2 ^ reroll_count * (use_count * 5)
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
				EntityRefreshSprite( me, txt_sprt )
				ComponentSetValue2(vsc_id, "value_bool", true)
				local sprite_comp = EntityGetFirstComponentIncludingDisabled( me, "SpriteComponent" )
				ComponentSetValue2( sprite_comp, "rect_animation", "powered" )
				if magic_mats[mat_name] ~= nil then
					ComponentSetValue2( vsc_id, "value_string", "magic" )
					local new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x - 8, pot_pos_y)
					AddMaterialInventoryMaterial( new_pot, random_from_weight( magic_mats ), 1000 )
					new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x, pot_pos_y)
					AddMaterialInventoryMaterial( new_pot, random_from_weight( magic_mats ), 1000 )
					new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x + 8, pot_pos_y)
					AddMaterialInventoryMaterial( new_pot, random_from_weight( magic_mats ), 1000 )
					break
				elseif normal_mats[mat_name] ~= nil then
					ComponentSetValue2( vsc_id, "value_string", "nature" )
					if Random(0,1) == 0 then 
						local new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x - 8, pot_pos_y)
						AddMaterialInventoryMaterial( new_pot, random_from_weight( normal_mats ), 1000 )
					else
						local new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x - 8, pot_pos_y)
						AddMaterialInventoryMaterial( new_pot, random_from_weight( mats_list ), 1000 )
					end
					if Random(0,1) == 0 then 
						local new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x, pot_pos_y)
						AddMaterialInventoryMaterial( new_pot, random_from_weight( normal_mats ), 1000 )
					else
						local new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x, pot_pos_y)
						AddMaterialInventoryMaterial( new_pot, random_from_weight( mats_list ), 1000 )
					end
					if Random(0,1) == 0 then 
						local new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x + 8, pot_pos_y)
						AddMaterialInventoryMaterial( new_pot, random_from_weight( normal_mats ), 1000 )
					else
						local new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x + 8, pot_pos_y)
						AddMaterialInventoryMaterial( new_pot, random_from_weight( mats_list ), 1000 )
					end
					break
				else
					ComponentSetValue2( vsc_id, "value_string", "technology" )
					local rand_materials = CellFactory_GetAllLiquids( false )
					if Random(0,1) == 1 then rand_materials = CellFactory_GetAllSands( false ) end
					local return_pot_one = random_from_array( materials )
					local new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x - 8, pot_pos_y)
					AddMaterialInventoryMaterial( new_pot, return_pot_one, 1000 )
					rand_materials = CellFactory_GetAllLiquids( false )
					if Random(0,1) == 0 then rand_materials = CellFactory_GetAllSands( false ) end
					return_pot_one = random_from_array( materials )
					new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x - 8, pot_pos_y)
					AddMaterialInventoryMaterial( new_pot, return_pot_one, 1000 )
					rand_materials = CellFactory_GetAllLiquids( false )
					if Random(0,1) == 1 then rand_materials = CellFactory_GetAllSands( false ) end
					return_pot_one = random_from_array( materials )
					new_pot = EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion.xml", pos_x - 8, pot_pos_y)
					AddMaterialInventoryMaterial( new_pot, return_pot_one, 1000 )
					break
				end
			end
		end
	end
end