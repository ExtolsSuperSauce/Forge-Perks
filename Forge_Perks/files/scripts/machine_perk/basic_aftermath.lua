magic = magic or CellFactory_GetType("magic_liquid_blood_magic")
diamond = diamond or CellFactory_GetType("diamond")
machine = machine or CellFactory_GetType("magic_liquid_blood_machine")
silver = silver or CellFactory_GetType("silver")
nature = nature or CellFactory_GetType("magic_liquid_blood_nature")
brass = brass or CellFactory_GetType("brass")
bird = bird or CellFactory_GetType("magic_liquid_blood_bird")
gold = gold or CellFactory_GetType("gold")
copper = copper or CellFactory_GetType("copper")
steel = steel or CellFactory_GetType("steel_sand")
table_of_indexes = table_of_indexes or {}

local eid = GetUpdatedEntityID()
local mic_id = EntityGetFirstComponentIncludingDisabled( eid, "MaterialInventoryComponent" )
local mats_list = ComponentGetValue2(mic_id, "count_per_material_type")
local mat_dump_id = EntityGetWithName("ExtolMatDump")
local dump_vsc = EntityGetFirstComponentIncludingDisabled( mat_dump_id, "VariableStorageComponent")
local check_bool = ComponentGetValue2(dump_vsc, "value_bool")
local bird_count = 0
local machine_count = 0
local magic_count = 0
local nature_count = 0
old_ui = old_ui or "HELPMEDEARGODIMTRAPPEDINANANVIL" --for real I hope no one has used this name, and also maybe don't ever use it if you see this, you mfer. I swear to god don't do it plz. It won't break anything at all I just hope that you really dont plzplzplzplzplzplzplzplzplzplzplzplzplzplzplzplzplzplzplzplzplzplzplz
if check_bool then
	for i, material_count in ipairs(mats_list) do
		local index = i-1
		if index == bird then 
			bird_count = bird_count + material_count
		elseif index == magic or index == gold or index == diamond then
			magic_count = magic_count + material_count
		elseif index == machine or index == steel or index == silver then
			machine_count = machine_count + material_count
		elseif index == nature or index == copper or index == brass then
			nature_count = nature_count + material_count
		elseif material_count > 0 then
			local mat_id = CellFactory_GetName(index)
			local ui_name = CellFactory_GetUIName(index)
			AddMaterialInventoryMaterial(mat_dump_id, mat_id, material_count)
			ComponentSetValue2( dump_vsc, "value_bool", false )
			ComponentSetValue2( dump_vsc, "value_int", i )
			check_bool = false
			if ui_name ~= old_ui then
				GamePrint("Impurity Found: " .. GameTextGetTranslatedOrNot(ui_name))
			end
			old_ui = ui_name
			AddMaterialInventoryMaterial( eid, mat_id, 0 )
			break
		end
	end
end

if not check_bool then return end

local vsc_id = EntityGetFirstComponentIncludingDisabled( eid, "VariableStorageComponent" )
local forge_storage = EntityGetFirstComponentIncludingDisabled( eid, "VariableStorageComponent", "ExtolForgeStorage" )
local bird_store = tonumber(ComponentGetValue2(forge_storage, "name"))
while bird_count >= bird_store do
	bird_store = bird_store + 12
	local current_bird = tonumber(ComponentGetValue2(vsc_id, "name")) or 0
	current_bird = current_bird + 1
	ComponentSetValue2(vsc_id, "name", tostring(current_bird))
	if bird_count < bird_store then
		GamePrint("???: " .. current_bird)
	end
end
local magic_store = tonumber(ComponentGetValue2(forge_storage, "value_string"))
while magic_count >= magic_store do
	magic_store = magic_store + 8
	local current_magic = tonumber(ComponentGetValue2(vsc_id, "value_string")) or 0
	current_magic = current_magic + 1
	ComponentSetValue2(vsc_id, "value_string", tostring(current_magic))
	if magic_count < magic_store then
		GamePrint("Best: " .. current_magic)
	end
end
local machine_store = ComponentGetValue2(forge_storage, "value_float")
while machine_count >= machine_store do
	machine_store = machine_store + 9
	local current_mach = (ComponentGetValue2(vsc_id, "value_float") + 1)
	ComponentSetValue2(vsc_id, "value_float", current_mach)
	if machine_count < machine_store then
		GamePrint("Better: " .. current_mach)
	end
end
local nature_store = ComponentGetValue2(forge_storage, "value_int")
while nature_count >= nature_store do
	nature_store = nature_store + 10
	local current_nat = ComponentGetValue2(vsc_id, "value_int") + 1
	ComponentSetValue2(vsc_id, "value_int", current_nat)
	if nature_count < nature_store then
		GamePrint("Basic: " .. current_nat)
	end
end
ComponentSetValue2( forge_storage, "name" , tostring(bird_store - bird_count))
ComponentSetValue2( forge_storage, "value_string", tostring(magic_store - magic_count))
ComponentSetValue2( forge_storage, "value_float", machine_store - machine_count)
ComponentSetValue2( forge_storage, "value_int", nature_store - nature_count)
AddMaterialInventoryMaterial( eid, "magic_liquid_blood_bird", 0 )
AddMaterialInventoryMaterial( eid, "magic_liquid_blood_machine", 0 )
AddMaterialInventoryMaterial( eid, "magic_liquid_blood_magic", 0 )
AddMaterialInventoryMaterial( eid, "magic_liquid_blood_nature", 0 )
for i, mat_info in ipairs(table_of_indexes) do
	AddMaterialInventoryMaterial( eid, CellFactory_GetName(mat_info.material_id), 0 )
end
table_of_indexes = {}
