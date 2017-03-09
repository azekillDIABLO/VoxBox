
-- Bird by azekill_DIABLO for VoxBox license: LGPL v2.1+

mobs:register_mob("mobs:bird", {
	type = "animal",
	passive = true,
	hp_min = 2,
	hp_max = 2,
	armor = 200,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "bird.obj",
	textures = {
		{"mobs_bird.png"},
	},
	makes_footstep_sound = false,
	walk_velocity = 2,
	jump = true,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -3,
	on_rightclick = function(self, clicker)
		mobs:capture_mob(self, clicker, 25, 80, 0, true, nil)
	end,
})

mobs:register_spawn("mobs:bird", {"default:dirt"}, 20, 10, 9000, 2, 31000, true)

mobs:register_egg("mobs:bird", "Bird Spwn-Egg", "mobs_bird_inv.png", 0)