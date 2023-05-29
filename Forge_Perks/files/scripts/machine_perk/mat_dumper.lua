local eid = GetUpdatedEntityID()
local vsc = EntityGetFirstComponentIncludingDisabled(eid, "VariableStorageComponent")
local mat_id = ComponentGetValue2(vsc, "value_int")
local mic = EntityGetFirstComponentIncludingDisabled(eid, "MaterialInventoryComponent")
local mat_list = ComponentGetValue2(mic, "count_per_material_type")
if mat_list[mat_id] == 0 or mat_list[mat_id] == nil then
	ComponentSetValue2(vsc, "value_bool", true)
end