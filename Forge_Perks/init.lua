ModMaterialsFileAdd("mods/Forge_Perks/files/materials.xml")
ModLuaFileAppend( "data/scripts/perks/perk_list.lua", "mods/Forge_Perks/files/perk_list.lua" )
ModLuaFileAppend( "data/scripts/biomes/snowcastle.lua", "mods/Forge_Perks/files/scripts/biomes_appended/snowcastle.lua" )
ModLuaFileAppend( "data/scripts/biomes/temple_altar_left.lua", "mods/Forge_Perks/files/scripts/biomes_appended/temple_altar_left.lua" )
--dofile_once("mods/Forge_Perks/horscht_lib/DialogSystem/init.lua")("mods/Forge_Perks/horscht_lib/DialogSystem")
--ModRegisterAudioEventMappings("mods/Forge_Perks/files/monke_audio.txt")
local content = ModTextFileGetContent("data/translations/common.csv")
ModTextFileSetContent("data/translations/common.csv", content .. [[
forge_perk_FORGE_MACHINE,Machinery,,,,,,,,,,,,,
forge_perk_FORGE_MACHINEdesc,Smelt Wands from Metal or Taikaveri,,,,,,,,,,,,,
forge_perk_FORGE_MASTER,Mastery,,,,,,,,,,,,,
forge_perk_FORGE_MASTERdesc,Upgrade Wands from Magical Liquids,,,,,,,,,,,,,
forge_perk_FORGE_ALCHEMIST,Alchemistery,,,,,,,,,,,,,
mat_sandground,Antimatter,,,,,,,,,,,,,
forge_perk_FORGE_ALCHEMISTdesc,Destroy and Make Wands for Spells and from Parts.,,,,,,,,,,,,,
book_masterdesc,Blood Flows from the Essences of the World! \nOne is of the Oily Residues of Machine. \nAnother from the Blood Soaked Swamps. \nMost importantly. From the Concepts of Magic Itself, \nand The Golden Flames of the Phoenix.\n \nPress E on the Forge with a Wand in Hand to Upgrade it.,,,,,,,,,,,,,
book_machinedesc,The abundance of Metals, and the Arts of Taikaveri shall bring us Fortune! \nYet I still think there is more to this.... \nFor the Pheonix has helped us greatly. \nYet I see an Opportunity like no other. \nCan the Water Loon be this close?\n \nPress E on the Forge to make Wands Appear.,,,,,,,,,,,,,
book_alchemistdesc,Destruction is as Easy as Willing for it. \nCreation is just the same. \nTake note of the Elemental Stone Breaker. \nMay it help Forge Your path. \nPress E on the Forge with a Wand in Hand to Break it.\nPress E on the Forge with a wand part to place it. \nYou need 3 parts to make a wand. \n \nI've come to see the intentions of my peers. Find my Tome Under the Forge...,,,,,,,,,,,,,
book_descdescdescdesc,An Alchemist's Research \nThe Frogs are becoming more and more potent each passing Day.... \nJust as the Acids of Alchohol make Fury. The Basics make Charm. \nRotting Meat has also been smelling quite peculiar recently. \nI hope the Worms don't take to it... \nIt's hard to say what my Peers old Tomes quite mean. \nThough it seems this is now a Quest into the confusing ways of Magic. \nFor Mastery has the most useful info for me currently.,,,,,,,,,,,,,
TOME,Under the Stone Breaker is the Shavings from the very Walls. \nUsing this Along with the Blood of Magic and \nthe Shines of Mirrors it shall Create \nthe Power to stop Them. \nHopefully This will end the Chaos.,,,,,,,,,,,,,
]])

local nxml = dofile_once("mods/Forge_Perks/nxml.lua")
local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
local xml = nxml.parse(content)
local mBPS = xml:first_of("mBufferedPixelScenes")
mBPS:add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" background_filename="" clean_area_before="0" colors_filename="" material_filename="mods/Forge_Perks/files/pixel_scenes/Break_Room.png" pos_x="2048" pos_y="5632" skip_biome_checks="1" skip_edge_textures="0" >
    </PixelScene>
]]))

mBPS:add_child(nxml.parse([[
	<PixelScene pos_x="2225" pos_y="5870" just_load_an_entity="mods/Forge_Perks/files/scripts/alchemist_perk/Stone_Breaker.xml" />
]]))

mBPS:add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" background_filename="" clean_area_before="0" colors_filename="" material_filename="mods/Forge_Perks/files/pixel_scenes/Perk_Room.png" pos_x="1500" pos_y="5632" skip_biome_checks="1" skip_edge_textures="0" >
    </PixelScene>
]]))

mBPS:add_child(nxml.parse([[
    <PixelScene DEBUG_RELOAD_ME="0" background_filename="" clean_area_before="0" colors_filename="" material_filename="mods/Forge_Perks/files/pixel_scenes/Tome_Hole.png" pos_x="1580" pos_y="6420" skip_biome_checks="1" skip_edge_textures="0" >
    </PixelScene>
]]))

mBPS:add_child(nxml.parse([[
	<PixelScene pos_x="1870" pos_y="5865" just_load_an_entity="mods/Forge_Perks/files/perk_spawner.xml" />
]]))

mBPS:add_child(nxml.parse([[
	<PixelScene pos_x="1600" pos_y="6450" just_load_an_entity="mods/Forge_Perks/files/TOME.xml" />
]]))

mBPS:add_child(nxml.parse([[
	<PixelScene pos_x="1757" pos_y="5865" just_load_an_entity="mods/Forge_Perks/files/items/book_o_alchemy.xml" />
]]))

ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))