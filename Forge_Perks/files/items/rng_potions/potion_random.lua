 dofile_once("data/scripts/lib/utilities.lua")

function init( entity_id )
	local x,y = EntityGetTransform( entity_id )
	local year,month,day,temp1,temp2,temp3,jussi = GameGetDateAndTimeLocal()
	SetRandomSeed( day + temp2, y + temp3 ) 
	-- so that all the potions will be the same in every position with the same seed
	-- local potion = random_from_array( potions )
	local materials = nil
	local rand = ( Random( 0, 100 ))
	
	if rand <= 25 then
		materials = CellFactory_GetAllLiquids( false, true )
	elseif rand <= 50 then
		materials = CellFactory_GetAllSands( false, true )
	elseif rand <= 75 then
		materials = CellFactory_GetAllGases( false, true )
	elseif rand <= 85 then
		materials = CellFactory_GetAllFires( false, true )
	elseif rand <= 100 then
		materials = CellFactory_GetAllSolids( false, true )
	end

	local potion_material = random_from_array( materials )

	-- AddMaterialInventoryMaterial( entity_id, potion.material, 1000 )
	AddMaterialInventoryMaterial( entity_id, potion_material, 1000 )
end