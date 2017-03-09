
-- Stone Monster by PilzAdam

mobs:register_mob("mobs:ghast", {
	type = "monster",
	passive = false,
	attack_type = "dogshoot",
	reach = 1,
	shoot_interval = 2,
	arrow = "mobs:fireball",
	hp_min = 30,
	hp_max = 35,
	armor = 80,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "character.b3d",
	textures = {
		{"ghast.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_stonemonster",
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	floats = 2,
	view_range = 30,
	drops = {
		{name = "default:torch",
		chance = 2, min = 3, max = 5},
		{name = "default:iron_lump",
		chance=5, min=1, max=2},
		{name = "default:coal_lump",
		chance=3, min=1, max=3},
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	},
})

mobs:register_spawn("mobs:ghast", {""}, 7, 0, 7000, 2, 0)

mobs:register_egg("mobs:ghast", "Ghast", "default_stone.png", 1)

-- fireball (weapon)
mobs:register_arrow("mobs:fireball", {
visual = "sprite",
visual_size = {x = 0.5, y = 0.5},
textures = {"fire.png"},
	velocity = 6,

	-- direct hit, no fire... just plenty of pain
	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	-- node hit, bursts into flame
	hit_node = function(self, pos, node)
		mobs:explosion(pos, 1, 1, 0)
	end
})
