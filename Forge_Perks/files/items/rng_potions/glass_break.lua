function kill_all_potions()
	local eid = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform(eid)
	local nearby_potions = EntityGetInRadiusWithTag( pos_x, pos_y, 50, "potion")
	if #nearby_potions > 0 then
		for i, potion in ipairs(nearby_potions) do
			local pot_par = EntityGetParent(potion)
			EntityRemoveTag( potion, "extol_temp_pot" )
			if pot_par == 0 then
				EntityKill(potion)
			end
		end
	end
	local potion_boi = EntityGetWithName("extols_potion_boi")
	local pboi_vsc = EntityGetFirstComponentIncludingDisabled( potion_boi, "VariableStorageComponent" )
	ComponentSetValue2( pboi_vsc, "value_bool", false )
	local count = ComponentGetValue2( pboi_vsc, "value_int" ) + 3
	ComponentSetValue2( pboi_vsc, "value_int", count )
	local sprite_comp = EntityGetFirstComponentIncludingDisabled( potion_boi, "SpriteComponent" )
	ComponentSetValue2( sprite_comp, "rect_animation", "default" )
	local txt_sprt = EntityGetFirstComponentIncludingDisabled( potion_boi, "SpriteComponent", "TEXT_SPRITE" )
	local use_cost = 100*count
	ComponentSetValue2( txt_sprt, "text", use_cost )
	local offsetx = 6
	local text = tostring(use_cost)
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
	EntityRefreshSprite( potion_boi, txt_sprt )
	EntitySetComponentsWithTagEnabled( potion_boi, "shop_cost", false )
end

function kick()
	kill_all_potions()
end

function death()
	kill_all_potions()
end

function damage_received()
	kill_all_potions()
end