Extol_actions = 
{
	{
		id          = "LIGHT_BULLET_TRIGGER_2",
		name 		= "$action_light_bullet_trigger_2",
		description = "$actiondesc_light_bullet_trigger_2",
		sprite 		= "data/ui_gfx/gun_actions/light_bullet_trigger_2.png",
		related_projectiles	= {"data/entities/projectiles/deck/light_bullet_blue.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                         = "2,3,5,6,10", -- LIGHT_BULLET_TRIGGER_2
		spawn_probability                   = "1,0.5,1,1,0.2", -- LIGHT_BULLET_TRIGGER_2
		price = 250,
		mana = 15,
		--max_uses = 100,
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 4
			c.screenshake = c.screenshake + 1
			c.damage_critical_chance = c.damage_critical_chance + 5
			add_projectile_trigger_hit_world("data/entities/projectiles/deck/light_bullet_blue.xml", 2)
		end,
	},
	{
		id          = "BLACK_HOLE",
		name 		= "$action_black_hole",
		description = "$actiondesc_black_hole",
		sprite 		= "data/ui_gfx/gun_actions/black_hole.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/black_hole_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/black_hole.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,2,4,5", -- BLACK_HOLE
		spawn_probability                 = "0.8,0.8,0.8,0.8", -- BLACK_HOLE
		price = 200,
		mana = 180,
		max_uses    = 3, 
		never_unlimited = true,
		custom_xml_file = "data/entities/misc/custom_cards/black_hole.xml",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/black_hole.xml")
			c.fire_rate_wait = c.fire_rate_wait + 80
			c.screenshake = c.screenshake + 20
		end,
	},
	{
		id          = "RUBBER_BALL",
		name 		= "$action_rubber_ball",
		description = "$actiondesc_rubber_ball",
		sprite 		= "data/ui_gfx/gun_actions/rubber_ball.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rubber_ball_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/rubber_ball.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,1,6", -- RUBBER_BALL
		spawn_probability                 = "1,1,1", -- RUBBER_BALL
		price = 60,
		mana = 5,
		--max_uses = 150,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/rubber_ball.xml")
			-- damage = 0.3
			c.fire_rate_wait = c.fire_rate_wait - 2
			c.spread_degrees = c.spread_degrees - 1.0
		end,
	},
	{
		id          = "BOMB_DETONATOR",
		name 		= "$action_bomb_detonator",
		description = "$actiondesc_bomb_detonator",
		sprite 		= "data/ui_gfx/gun_actions/pipe_bomb_detonator.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/meteor_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/bomb_detonator.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,3,4,5,6", -- PIPE_BOMB_DETONATOR
		spawn_probability                 = "1,1,1,1,1", -- PIPE_BOMB_DETONATOR
		price = 120,
		mana = 50,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/bomb_detonator.xml")
		end,
	},
	{
		id          = "CHAINSAW",
		name 		= "$action_chainsaw",
		description = "$actiondesc_chainsaw",
		sprite 		= "data/ui_gfx/gun_actions/chainsaw.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/chainsaw.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,2", -- CHAINSAW
		spawn_probability                 = "1,1", -- CHAINSAW
		price = 80,
		mana = 1,
		--max_uses = 1000,
		sound_loop_tag = "sound_chainsaw",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/chainsaw.xml")
			c.fire_rate_wait = 0
			c.spread_degrees = c.spread_degrees + 6.0
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the digger reload time back to 0
		end,
	},
	{
		id          = "LUMINOUS_DRILL",
		name 		= "$action_luminous_drill",
		description = "$actiondesc_luminous_drill",
		sprite 		= "data/ui_gfx/gun_actions/luminous_drill.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/luminous_drill.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,2", -- LUMINOUS_DRILL
		spawn_probability                 = "1,1", -- LUMINOUS_DRILL
		price = 150,
		mana = 10,
		--max_uses = 1000,
		sound_loop_tag = "sound_digger",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/luminous_drill.xml")
			c.fire_rate_wait = c.fire_rate_wait - 35
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the digger reload time back to 0
		end,
	},
	{
		id          = "HEAL_BULLET",
		name 		= "$action_heal_bullet",
		description = "$actiondesc_heal_bullet",
		sprite 		= "data/ui_gfx/gun_actions/heal_bullet.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/heal_bullet_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/heal_bullet.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "2,3,4", -- HEAL_BULLET
		spawn_probability                 = "1,1,1", -- HEAL_BULLET
		price = 60,
		mana = 15,
		max_uses = 20,
		never_unlimited = true,
		custom_xml_file = "data/entities/misc/custom_cards/heal_bullet.xml",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/heal_bullet.xml")
			c.fire_rate_wait = c.fire_rate_wait + 4
			c.spread_degrees = c.spread_degrees + 2.0
		end,
	},
	{
		id          = "PROPANE_TANK",
		name 		= "$action_propane_tank",
		description = "$actiondesc_propane_tank",
		sprite 		= "data/ui_gfx/gun_actions/propane_tank.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/propane_tank.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,1,2,3,4,5,6", -- PROPANE_TANK
		spawn_probability                 = "0,0,1,1,1,1,1", -- PROPANE_TANK
		price = 200,
		mana = 75, 
		max_uses    = 10, 
		custom_xml_file = "data/entities/misc/custom_cards/propane_tank.xml",
		action 		= function()
			add_projectile("data/entities/projectiles/propane_tank.xml")
			c.fire_rate_wait = c.fire_rate_wait + 100
		end,
	},
	{
		id          = "SUMMON_ROCK",
		name 		= "$action_summon_rock",
		description = "$actiondesc_summon_rock",
		sprite 		= "data/ui_gfx/gun_actions/summon_rock.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/rock.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,1,2,3,4,5,6", -- SUMMON_ROCK
		spawn_probability                 = "0.8,0.8,0.8,0.8,0.8,0.8,0.8", -- SUMMON_ROCK
		price = 160,
		mana = 100, 
		max_uses    = 3, 
		custom_xml_file = "data/entities/misc/custom_cards/summon_rock.xml",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/rock.xml")
		end,
	},
	{
		id          = "SUMMON_EGG",
		name 		= "$action_summon_egg",
		description = "$actiondesc_summon_egg",
		sprite 		= "data/ui_gfx/gun_actions/summon_egg.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
		related_projectiles	= {"data/entities/items/pickup/egg_monster.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,1,2,3,4,5,6", -- SUMMON_EGG
		spawn_probability                 = "0.8,0.8,0.8,0.8,0.8,0.8,0.8", -- SUMMON_EGG
		price = 220,
		mana = 100, 
		max_uses    = 2, 
		action 		= function()
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() )
			local types = {"monster","slime","red","fire"}
			local rnd = Random(1, #types)
			local egg_name = "egg_" .. tostring(types[rnd]) .. ".xml"
			add_projectile("data/entities/items/pickup/" .. egg_name)
		end,
	},
	{
		id          = "SWARM_FLY",
		name 		= "$action_swarm_fly",
		description = "$actiondesc_swarm_fly",
		sprite 		= "data/ui_gfx/gun_actions/swarm_fly.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spiral_shot_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/swarm_fly.xml",5},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,4,5,6", -- SPIRAL_SHOT
		spawn_probability                 = "0.2,0.2,0.5,0.5", -- SPIRAL_SHOT
		price = 90,
		mana = 70,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/swarm_fly.xml")
			add_projectile("data/entities/projectiles/deck/swarm_fly.xml")
			add_projectile("data/entities/projectiles/deck/swarm_fly.xml")
			add_projectile("data/entities/projectiles/deck/swarm_fly.xml")
			add_projectile("data/entities/projectiles/deck/swarm_fly.xml")
			c.spread_degrees = c.spread_degrees + 6.0
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 20
		end,
	},
	{
		id          = "SWARM_FIREBUG",
		name 		= "$action_swarm_firebug",
		description = "$actiondesc_swarm_firebug",
		sprite 		= "data/ui_gfx/gun_actions/swarm_firebug.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spiral_shot_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/swarm_firebug.xml",4},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,4,5,6", -- SPIRAL_SHOT
		spawn_probability                 = "0.2,0.2,0.5,0.5", -- SPIRAL_SHOT
		price = 100,
		mana = 80,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/swarm_firebug.xml")
			add_projectile("data/entities/projectiles/deck/swarm_firebug.xml")
			add_projectile("data/entities/projectiles/deck/swarm_firebug.xml")
			add_projectile("data/entities/projectiles/deck/swarm_firebug.xml")
			c.spread_degrees = c.spread_degrees + 12.0
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 20
		end,
	},
	{
		id          = "SWARM_WASP",
		name 		= "$action_swarm_wasp",
		description = "$actiondesc_swarm_wasp",
		sprite 		= "data/ui_gfx/gun_actions/swarm_wasp.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spiral_shot_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/swarm_wasp.xml",6},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "2,4,5,6", -- SPIRAL_SHOT
		spawn_probability                 = "0.2,0.2,0.5,0.5", -- SPIRAL_SHOT
		price = 120,
		mana = 90,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/swarm_wasp.xml")
			add_projectile("data/entities/projectiles/deck/swarm_wasp.xml")
			add_projectile("data/entities/projectiles/deck/swarm_wasp.xml")
			add_projectile("data/entities/projectiles/deck/swarm_wasp.xml")
			add_projectile("data/entities/projectiles/deck/swarm_wasp.xml")
			add_projectile("data/entities/projectiles/deck/swarm_wasp.xml")
			c.spread_degrees = c.spread_degrees + 24.0
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 20
		end,
	},
	{
		id          = "FRIEND_FLY",
		name 		= "$action_friend_fly",
		description = "$actiondesc_friend_fly",
		sprite 		= "data/ui_gfx/gun_actions/friend_fly.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spiral_shot_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/friend_fly.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "4,5,6", -- SPIRAL_SHOT
		spawn_probability                 = "0.2,0.5,0.5", -- SPIRAL_SHOT
		price = 160,
		mana = 120,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/friend_fly.xml")
			c.spread_degrees = c.spread_degrees + 24.0
			c.fire_rate_wait = c.fire_rate_wait + 80
			current_reload_time = current_reload_time + 40
		end,
	},
	{
		id          = "LONG_DISTANCE_CAST",
		name 		= "$action_long_distance_cast",
		description = "$actiondesc_long_distance_cast",
		sprite 		= "data/ui_gfx/gun_actions/long_distance_cast.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/teleport_projectile_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/long_distance_cast.xml"},
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "0,1,2,4,5,6", -- LONG_DISTANCE_CAST
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6,0.6", -- LONG_DISTANCE_CAST
		price = 90,
		mana = 0,
		action 		= function()
			add_projectile_trigger_death("data/entities/projectiles/deck/long_distance_cast.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait - 5
		end,
	},
	{
		id          = "MATERIAL_WATER",
		name 		= "$action_material_water",
		description = "$actiondesc_material_water",
		sprite 		= "data/ui_gfx/gun_actions/material_water.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/material_water_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/material_water.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5", -- MATERIAL_WATER
		spawn_probability                 = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_WATER
		price = 110,
		mana = 0,
		sound_loop_tag = "sound_spray",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/material_water.xml")
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_wet.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
		end,
	},
	{
		id          = "MATERIAL_OIL",
		name 		= "$action_material_oil",
		description = "$actiondesc_material_oil",
		sprite 		= "data/ui_gfx/gun_actions/material_oil.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/material_oil_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/material_oil.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5", -- MATERIAL_OIL
		spawn_probability                 = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_OIL
		price = 140,
		mana = 0,
		sound_loop_tag = "sound_spray",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/material_oil.xml")
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_oiled.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
		end,
	},
	-- Note( Petri ): 10.7.2019 - this could be just removed (vampirism, the limited uses in these is extremely silly)
	{
		id          = "MATERIAL_BLOOD",
		name 		= "$action_material_blood",
		description = "$actiondesc_material_blood",
		sprite 		= "data/ui_gfx/gun_actions/material_blood.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/material_blood_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/material_blood.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5", -- MATERIAL_BLOOD
		spawn_probability                 = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_BLOOD
		price = 130,
		max_uses = 250,
		mana = 0,
		sound_loop_tag = "sound_spray",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/material_blood.xml")
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_bloody.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
		end,
	},
	{
		id          = "MATERIAL_ACID",
		name 		= "$action_material_acid",
		description = "$actiondesc_material_acid",
		sprite 		= "data/ui_gfx/gun_actions/material_acid.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/material_acid_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/material_acid.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "2,3,4,5,6", -- MATERIAL_ACID
		spawn_probability                 = "0.4,0.4,0.4,0.4,0.4", -- MATERIAL_ACID
		price = 150,
		-- Note( Petri ): 10.7.2019 - removed uses. We have acid trail already
		-- max_uses = 250,
		mana = 0,
		sound_loop_tag = "sound_spray",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/material_acid.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10 -- this is a hack to get the cement reload time back to 0
		end,
	},
	{
		id          = "TOUCH_GOLD",
		name 		= "$action_touch_gold",
		description = "$actiondesc_touch_gold",
		sprite 		= "data/ui_gfx/gun_actions/touch_gold.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/touch_gold.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_GOLD
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.5", -- TOUCH_GOLD
		price = 480,
		mana = 300,
		max_uses    = 1,
		never_unlimited = true,
		action 		= function()
			add_projectile("data/entities/projectiles/deck/touch_gold.xml")
		end,
	},
	{
		id          = "TOUCH_WATER",
		name 		= "$action_touch_water",
		description = "$actiondesc_touch_water",
		sprite 		= "data/ui_gfx/gun_actions/touch_water.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/touch_water.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_WATER
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.1", -- TOUCH_WATER
		price = 420,
		mana = 280,
		max_uses    = 5, 
		action 		= function()
			add_projectile("data/entities/projectiles/deck/touch_water.xml")
		end,
	},
	{
		id          = "TOUCH_OIL",
		name 		= "$action_touch_oil",
		description = "$actiondesc_touch_oil",
		sprite 		= "data/ui_gfx/gun_actions/touch_oil.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/touch_oil.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_OIL
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.1", -- TOUCH_OIL
		price = 380,
		mana = 260,
		max_uses    = 5, 
		action 		= function()
			add_projectile("data/entities/projectiles/deck/touch_oil.xml")
		end,
	},
	{
		id          = "TOUCH_ALCOHOL",
		name 		= "$action_touch_alcohol",
		description = "$actiondesc_touch_alcohol",
		sprite 		= "data/ui_gfx/gun_actions/touch_alcohol.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/touch_alcohol.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_ALCOHOL
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.1", -- TOUCH_ALCOHOL
		price = 360,
		mana = 240,
		max_uses    = 5, 
		action 		= function()
			add_projectile("data/entities/projectiles/deck/touch_alcohol.xml")
		end,
	},
	{
		id          = "TOUCH_BLOOD",
		name 		= "$action_touch_blood",
		description = "$actiondesc_touch_blood",
		sprite 		= "data/ui_gfx/gun_actions/touch_blood.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/touch_blood.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_BLOOD
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.5", -- TOUCH_BLOOD
		price = 390,
		mana = 270,
		max_uses    = 3, 
		action 		= function()
			add_projectile("data/entities/projectiles/deck/touch_blood.xml")
		end,
	},
	{
		id          = "TOUCH_SMOKE",
		name 		= "$action_touch_smoke",
		description = "$actiondesc_touch_smoke",
		sprite 		= "data/ui_gfx/gun_actions/touch_smoke.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles	= {"data/entities/projectiles/deck/touch_smoke.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level                       = "1,2,3,4,5,6,7,10", -- TOUCH_SMOKE
		spawn_probability                 = "0,0,0,0,0.1,0.1,0.1,0.1", -- TOUCH_SMOKE
		price = 350,
		mana = 230,
		max_uses    = 5, 
		action 		= function()
			add_projectile("data/entities/projectiles/deck/touch_smoke.xml")
		end,
	},
	{
		id          = "MANA_REDUCE",
		name 		= "$action_mana_reduce",
		description = "$actiondesc_mana_reduce",
		sprite 		= "data/ui_gfx/gun_actions/mana.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5,6", -- MANA_REDUCE
		spawn_probability                 = "1,1,1,1,1,1", -- MANA_REDUCE
		price = 250,
		mana = -30,
		--max_uses = 150,
		custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
		action 		= function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			draw_actions( 1, true )
		end,
	},
	{
		id          = "BLOOD_MAGIC",
		name 		= "$action_blood_magic",
		description = "$actiondesc_blood_magic",
		sprite 		= "data/ui_gfx/gun_actions/blood_magic.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		related_extra_entities = { "data/entities/particles/blood_sparks.xml" },
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "5,6,10", -- MANA_REDUCE
		spawn_probability                 = "0.1,0.7,0.5", -- MANA_REDUCE
		price = 150,
		mana = -100,
		custom_xml_file = "data/entities/misc/custom_cards/blood_magic.xml",
		action 		= function()
			c.extra_entities = c.extra_entities .. "data/entities/particles/blood_sparks.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 20
			current_reload_time = current_reload_time - 20
			draw_actions( 1, true )
			
			local entity_id = GetUpdatedEntityID()
			
			local dcomps = EntityGetComponent( entity_id, "DamageModelComponent" )
			
			if ( dcomps ~= nil ) and ( #dcomps > 0 ) then
				for a,b in ipairs( dcomps ) do
					local hp = ComponentGetValue2( b, "hp" )
					hp = math.max( hp - 0.16, 0.04 )
					ComponentSetValue2( b, "hp", hp )
				end
			end
		end,
	},
	{
		id          = "MONEY_MAGIC",
		name 		= "$action_money_magic",
		description = "$actiondesc_money_magic",
		sprite 		= "data/ui_gfx/gun_actions/golden_punch.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		related_extra_entities = { "data/entities/particles/gold_sparks.xml" },
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "3,5,6,10", -- MANA_REDUCE
		spawn_probability                 = "0.2,0.8,0.1,0.5", -- MANA_REDUCE
		price = 200,
		mana = 30,
		custom_xml_file = "data/entities/misc/custom_cards/money_magic.xml",
		action 		= function()
			local entity_id = GetUpdatedEntityID()
			
			local dcomp = EntityGetFirstComponent( entity_id, "WalletComponent" )
			
			if ( dcomp ~= nil ) then
				local money = ComponentGetValue2( dcomp, "money" )
				local moneyspent = ComponentGetValue2( dcomp, "money_spent" )
				local damage = math.min( math.floor( money * 0.05 ), 24000 )
				
				if ( damage > 1 ) and ( money >= 10 ) then
					damage = math.max( damage, 10 )
					
					c.extra_entities = c.extra_entities .. "data/entities/particles/gold_sparks.xml,"
					
					money = money - damage
					moneyspent = moneyspent + damage
					ComponentSetValue2( dcomp, "money", money )
					ComponentSetValue2( dcomp, "money_spent", moneyspent )
					
					-- print( "Spent " .. tostring( damage ) )
					
					if ( damage < 120 ) then
						c.damage_projectile_add = c.damage_projectile_add + ( damage / 25 )
					elseif ( damage < 300 ) then
						c.damage_projectile_add = c.damage_projectile_add + ( damage / 35 )
					elseif ( damage < 500 ) then
						c.damage_projectile_add = c.damage_projectile_add + ( damage / 45 )
					else
						c.damage_projectile_add = c.damage_projectile_add + ( damage / 55 )
					end
				end
			end
			
			draw_actions( 1, true )
		end,
	},
	{
		id          = "BLOOD_TO_POWER",
		name 		= "$action_blood_to_power",
		description = "$actiondesc_blood_to_power",
		sprite 		= "data/ui_gfx/gun_actions/blood_punch.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		related_extra_entities = { "data/entities/particles/blood_sparks.xml" },
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "2,5,6,10", -- MANA_REDUCE
		spawn_probability                 = "0.2,0.8,0.1,0.5", -- MANA_REDUCE
		price = 150,
		mana = 20,
		custom_xml_file = "data/entities/misc/custom_cards/blood_to_power.xml",
		action 		= function()
			local entity_id = GetUpdatedEntityID()
			
			local dcomp = EntityGetFirstComponent( entity_id, "DamageModelComponent" )
			
			if ( dcomp ~= nil ) then
				local hp = ComponentGetValue2( dcomp, "hp" )
				local damage = math.min( hp * 0.44, 960 )
				local self_damage = hp * 0.2
				
				if ( hp >= 0.4 ) and ( self_damage > 0.2 ) then
					c.extra_entities = c.extra_entities .. "data/entities/particles/blood_sparks.xml,"
					
					EntityInflictDamage( entity_id, self_damage, "DAMAGE_CURSE", "$action_blood_to_power", "NONE", 0, 0, entity_id )
					
					-- print( "Spent " .. tostring( damage ) )
					
					c.damage_projectile_add = c.damage_projectile_add + damage
				end
			end
			
			draw_actions( 1, true )
		end,
	},
	{
		id          = "HOMING_ROTATE",
		name 		= "$action_homing_rotate",
		description = "$actiondesc_homing_rotate",
		sprite 		= "data/ui_gfx/gun_actions/homing_rotate.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		related_extra_entities = { "data/entities/misc/homing_rotate.xml", "data/entities/particles/tinyspark_white.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4,5,6", -- HOMING_ROTATE
		spawn_probability                 = "0.4,0.4,0.4,0.4,0.4", -- HOMING_ROTATE
		price = 175,
		mana = 40,
		--max_uses = 100,
		action 		= function()
			c.extra_entities = c.extra_entities .. "data/entities/misc/homing_rotate.xml,data/entities/particles/tinyspark_white.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "HOMING_SHOOTER",
		name 		= "$action_homing_shooter",
		description = "$actiondesc_homing_shooter",
		sprite 		= "data/ui_gfx/gun_actions/homing_shooter.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		related_extra_entities = { "data/entities/misc/homing_shooter.xml", "data/entities/particles/tinyspark_white.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4,5,6", -- HOMING_SHOOTER
		spawn_probability                 = "0.2,0.2,0.2,0.2,0.2", -- HOMING_SHOOTER
		price = 100,
		mana = 10,
		--max_uses = 100,
		action 		= function()
			c.extra_entities = c.extra_entities .. "data/entities/misc/homing_shooter.xml,data/entities/particles/tinyspark_white.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id          = "PIERCING_SHOT",
		name 		= "$action_piercing_shot",
		description = "$actiondesc_piercing_shot",
		sprite 		= "data/ui_gfx/gun_actions/piercing_shot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		related_extra_entities = { "data/entities/misc/piercing_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4,5,6", -- PIERCING_SHOT
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- PIERCING_SHOT
		price = 190,
		mana = 140,
		--max_uses = 100,
		action 		= function()
			c.damage_projectile_add = c.damage_projectile_add - 0.6
			c.extra_entities = c.extra_entities .. "data/entities/misc/piercing_shot.xml,"
			c.friendly_fire		= true
			draw_actions( 1, true )
		end,
	},
	{
		id          = "CLIPPING_SHOT",
		name 		= "$action_clipping_shot",
		description = "$actiondesc_clipping_shot",
		sprite 		= "data/ui_gfx/gun_actions/clipping_shot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		related_extra_entities = { "data/entities/misc/clipping_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4,5,6", -- CLIPPING_SHOT
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- CLIPPING_SHOT
		price = 200,
		mana = 160,
		--max_uses = 100,
		action 		= function()
			c.extra_entities = c.extra_entities .. "data/entities/misc/clipping_shot.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 50
			current_reload_time = current_reload_time + 40
			draw_actions( 1, true )
		end,
	},
}