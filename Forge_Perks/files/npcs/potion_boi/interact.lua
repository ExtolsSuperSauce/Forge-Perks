dofile_once("mods/Forge_Perks/horscht_lib/DialogSystem/dialog_system.lua")


local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local remember_me = EntityGetFirstComponent(entity_id, "VariableStorageComponent", "hello")
local check_me = ComponentGetValue2( remember_me, "value_bool" )
local player = EntityGetInRadiusWithTag(x, y, 20, "player_unit")[1]
local wallet = EntityGetFirstComponent( player, "WalletComponent" )
local money = ComponentGetValue2( wallet, "money" )
local moneyspent = ComponentGetValue2( wallet, "money_spent" )

local first_talk = {
	name = "Fellow Alchemist",
    portrait = "mods/Forge_Perks/files/npcs/potion_boi/portrait.png",
    typing_sound = "four", 
    text = [[
      {@delay 2}Oh!{@pause 30} Hello there.{@pause 40} I've been too afraid to carry on.
      {@pause 52}Please don't tell the others#...{@pause 60} if there are any...#{@pause 105}
      I can sell you some stuff if it'll {@pause 20}{@delay 5}keep you quiet.
    ]],
    options = {
      {
        text = "Basic Potion (250 Gold)",
        func = function(dialog)
		  if money >= 250 then
          dialog.show({
            name = "Mina",
            portrait = "mods/Forge_Perks/files/npcs/mina_portrait.png",
            typing_sound = "three",
            text = "1 Basic Potion.",
          })
		  EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion_magic.xml", x + 25, y-2)
		  ComponentSetValue2( wallet, "money" , money - 250 )
		  ComponentSetValue2(wallet, "money_spent", money_spent + 250)
		  else
		  dialog.show(no_gold)
		  end
        end
      },
      {
        text = "Magic Potion (750 Gold)",
		func = function(dialog)
		 if money >= 750 then
		 dialog.show({
            name = "Mina",
            portrait = "mods/Forge_Perks/files/npcs/mina_portrait.png",
            typing_sound = "three",
            text = "I'll take a Magic Potion.",
          })
		  EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion_basic.xml", x + 25, y-2)
		  ComponentSetValue2( wallet, "money", money - 750 )
		  ComponentSetValue2(wallet, "money_spent", money_spent + 750)
		  else
		  dialog.show(no_gold)
		  end
		end
      },
	  {
		text = "Random Potion (1500 Gold)",
		func = function(dialog)
		if money >= 1500 then
		 dialog.show({
            name = "Mina",
            portrait = "mods/Forge_Perks/files/npcs/mina_portrait.png",
            typing_sound = "three",
            text = "I hope this was worth it.",
          })
		  EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion_random.xml", x + 25, y-2)
		  ComponentSetValue2( wallet, "money", money - 1500 )
		  ComponentSetValue2(wallet, "money_spent", money_spent + 1500)
		  else
		  dialog.show(no_gold)
		  end
		end
	  },
    }
}

local chit_chat = {
	name = "Fellow Alchemist",
    portrait = "mods/Forge_Perks/files/npcs/potion_boi/portrait.png",
    typing_sound = "four", 
    text = "Hello again! Looking for more potions?",
    options = {
      {
        text = "Basic Potion (250 Gold)",
        func = function(dialog)
		  if money >= 250 then
          dialog.show({
            name = "Mina",
            portrait = "mods/Forge_Perks/files/npcs/mina_portrait.png",
            typing_sound = "three",
            text = "1 Basic Potion.",
          })
		  EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion_magic.xml", x + 25, y-2)
		  ComponentSetValue2( wallet, "money", money - 250 )
		  ComponentSetValue2(wallet, "money_spent", money_spent + 250)
		  else
		  dialog.show(no_gold)
		  end
        end
      },
      {
        text = "Magic Potion (750 Gold)",
		func = function(dialog)
		 if money >= 750 then
		 dialog.show({
            name = "Mina",
            portrait = "mods/Forge_Perks/files/npcs/mina_portrait.png",
            typing_sound = "three",
            text = "I'll take a Magic Potion.",
          })
		  EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion_basic.xml", x + 25, y-2)
		  ComponentSetValue2( wallet, "money", money - 750 )
		  ComponentSetValue2(wallet, "money_spent", money_spent + 750)
		  else
		  dialog.show(no_gold)
		  end
		end
      },
	  {
		text = "Random Potion (1500 Gold)",
		func = function(dialog)
		if money >= 1500 then
		 dialog.show({
            name = "Mina",
            portrait = "mods/Forge_Perks/files/npcs/mina_portrait.png",
            typing_sound = "three",
            text = "I hope this was worth it.",
          })
		  EntityLoad("mods/Forge_Perks/files/items/rng_potions/potion_random.xml", x + 25, y-2)
		  ComponentSetValue2( wallet, "money", money - 1500 )
		  ComponentSetValue2(wallet, "money_spent", money_spent + 1500)
		  else
		  dialog.show(no_gold)
		  end
		end
	  },
    }
}

no_gold = {
	name = "Fellow Alchemist",
    portrait = "mods/Forge_Perks/files/npcs/potion_boi/portrait.png",
    typing_sound = "four", 
    text = "You don't have enough for that.",
}

function interacting(entity_who_interacted, entity_interacted, interactable_name)
	GamePlayAnimation( entity_id, "wake", 0, "default", 0 )
	if check_me and player then
		dialog = dialog_system.open_dialog(first_talk)
		ComponentSetValue2(remember_me, "value_bool", false)
	else
		dialog = dialog_system.open_dialog(chit_chat)
	end
end