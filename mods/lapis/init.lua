
dofile(minetest.get_modpath("lapis").."/columns.lua")

----------
--Nodes
----------

minetest.register_node( "lapis:lapis_block",  {
   description = "Lapis with Calcite",
   tiles = {"lapis_block.png"},
   paramtype = "light",
   sunlight_propagates = false,
   is_ground_content = true,
   groups = {cracky=3},
   drop = {
		max_items = 1,
		items = {
			{items = {'lapis:lapis_stone'}, rarity = 10},
			{items = {'lapis:lapis_cobble'}},
		},
	},
   sounds = default.node_sound_stone_defaults()
})

minetest.register_node( "lapis:lapis_brick",  {
   description = "Lapis Brick",
   tiles = {
   "lapis_brick_top.png",
   "lapis_brick_top.png^[transformFXR90",
   "lapis_brick_side.png",
   "lapis_brick_side.png^[transformFX",
   "lapis_brick.png^[transformFX",
   "lapis_brick.png"
   },
   paramtype = "light",
   is_ground_content = false,
   sunlight_propagates = false,
   groups = {cracky=2},
   sounds = default.node_sound_stone_defaults()
})

minetest.register_node( "lapis:lapis_cobble",  {
   description = "Cobbled Lapis",
   tiles = {
   "lapis_cobble.png",
   "lapis_cobble.png^[transformFY",
   "lapis_cobble.png^[transformFX",
   "lapis_cobble.png",
   "lapis_cobble.png^[transformFX",
   "lapis_cobble.png"
   },
   paramtype = "light",
   is_ground_content = false,
   sunlight_propagates = false,
   groups = {cracky=3},
   sounds = default.node_sound_stone_defaults()
})

minetest.register_node( "lapis:lazurite_block",  {
   description = "Lazurite",
   tiles = {"lapis_lazurite_block.png"},
   paramtype = "light",
   sunlight_propagates = false,
   is_ground_content = true,
   groups = {cracky=2},
   sounds = default.node_sound_stone_defaults()
})

minetest.register_node( "lapis:lazurite_brick",  {
   description = "Lazurite Brick",
   tiles = {
   "lapis_lazurite_brick_top.png",
   "lapis_lazurite_brick_top.png^[transformFXR90",
   "lapis_lazurite_brick_side.png",
   "lapis_lazurite_brick_side.png^[transformFX",
   "lapis_lazurite_brick.png^[transformFX",
   "lapis_lazurite_brick.png"
   },
   paramtype = "light",
   is_ground_content = false,
   sunlight_propagates = false,
   groups = {cracky=1},
   sounds = default.node_sound_stone_defaults()
})

minetest.register_node( "lapis:lapis_tile",  {
   description = "Lapis Floor Tile",
   tiles = {"lapis_tile.png" },
   is_ground_content = false,
   sunlight_propagates = false,
   paramtype = 'light',
   groups = {cracky=3},
   sounds = default.node_sound_stone_defaults()
   })

minetest.register_node( "lapis:pyrite_ore",  {
   description = "Pyrite Ore",
   tiles = {"default_stone.png^lapis_mineral_pyrite.png" },
   paramtype = "light",
   sunlight_propagates = false,
   is_ground_content = true,
   drop= 'lapis:pyrite_lump 2',
   groups = {cracky=2, not_in_creative_inventory =1},
   sounds = default.node_sound_stone_defaults() ,
})

minetest.register_node( "lapis:pyrite_block",  {
   description = "Pyrite Block",
   tiles = {
   "lapis_pyrite_sacred.png",
   "lapis_pyrite_sacred.png",
   "lapis_pyrite_block.png"
   },
   paramtype = "light",
   paramtype2 = "facedir",
   legacy_facedir_simple = true,
   is_ground_content = false,
   sunlight_propagates = false,
   groups = {cracky=2},
   sounds = default.node_sound_stone_defaults() ,
})

-------------------
--Stairs & Slabs
-------------------

	if minetest.get_modpath("stairs") then

			stairs.register_stair_and_slab("lapis_block", "lapis:lapis_block",
		{cracky=3},
		{"lapis_block.png"},
		"Lapis Stair",
		"Lapis Slab",
		default.node_sound_stone_defaults())

		stairs.register_stair_and_slab("lapis_brick", "lapis:lapis_brick",
		{cracky=3},
		{"lapis_brick.png"},
		"Lapis Brick Stair",
		"Lapis Brick Slab",
		default.node_sound_stone_defaults())

		stairs.register_stair_and_slab("lapis_cobble", "lapis:lapis_cobble",
		{cracky=3},
		{"lapis_cobble.png"},
		"Lapis Cobble Stair",
		"Lapis Cobble Slab",
		default.node_sound_stone_defaults())

		stairs.register_stair_and_slab("lazurite", "lapis:lazurite_block",
		{cracky=3},
		{"lapis_lazurite_block.png"},
		"Lazurite Stair",
		"Lazurite Slab",
		default.node_sound_stone_defaults())

		stairs.register_stair_and_slab("lazurite_brick", "lapis:lazurite_brick",
		{cracky=3},
		{"lapis_lazurite_brick.png"},
		"Lazurite Brick Stair",
		"Lazurite Brick Slab",
		default.node_sound_stone_defaults())

		end

---------------
-- Crafts Items
---------------

minetest.register_craftitem("lapis:lapis_stone", {
	description = "Lapis Gemstone",
	inventory_image = "lapis_stone.png",
})

minetest.register_craftitem("lapis:pyrite_ingot", {
	description = "Pyrite Ingot",
	inventory_image = "lapis_pyrite_ingot.png",
})

minetest.register_craftitem("lapis:pyrite_lump", {
	description = "Fool's Gold",
	inventory_image = "lapis_pyrite_nugget.png",
})

----------
-- Crafts
----------

minetest.register_craft({
	output = 'lapis:lazurite_block',
	recipe = {
		{'lapis:lapis_stone', 'lapis:lapis_stone', 'lapis:lapis_stone'},
		{'lapis:lapis_stone', 'lapis:pyrite_lump', 'lapis:lapis_stone'},
		{'lapis:lapis_stone', 'lapis:lapis_stone', 'lapis:lapis_stone'},
	}
})

minetest.register_craft({
	output = 'lapis:lapis_stone 9',
	recipe = {
		{'lapis:lapis_block'},
	}
})

minetest.register_craft({
	output = 'lapis:lapis_brick 4',
	recipe = {
		{ 'lapis:lapis_block', 'lapis:lapis_block'},
		{ 'lapis:lapis_block', 'lapis:lapis_block'},
	}
})

minetest.register_craft({
	output = 'lapis:lazurite_brick 4',
	recipe = {
		{ '', 'lapis:lapis_brick', ''},
		{ 'lapis:lapis_brick', 'lapis:pyrite_lump', 'lapis:lapis_brick'},
		{ '', 'lapis:lapis_brick', ''},
	}
})

minetest.register_craft({
	output = 'lapis:lapis_tile 2',
	recipe = {
		{ 'lapis:lazurite_brick'},
	}
})

minetest.register_craft({
	output = 'lapis:pyrite_block',
	recipe = {
		{'lapis:pyrite_ingot', 'lapis:pyrite_ingot', 'lapis:pyrite_ingot'},
		{'lapis:pyrite_ingot', 'lapis:pyrite_ingot', 'lapis:pyrite_ingot'},
		{'lapis:pyrite_ingot', 'lapis:pyrite_ingot', 'lapis:pyrite_ingot'},
	}
})

minetest.register_craft({
	output = 'lapis:pyrite_ingot 6',
	recipe = {
		{'lapis:pyrite_block'},
	}
})

minetest.register_craft({
	output = 'dye:blue 2',
	recipe = {
		{'lapis:lapis_stone'},
	}
})

------------
-- Cooking
------------

minetest.register_craft({
	type = 'cooking',
	output = 'lapis:lapis_block',
	recipe = 'lapis:lapis_cobble',
})

minetest.register_craft({
	type = "cooking",
	output = "lapis:pyrite_ingot",
	recipe = "lapis:pyrite_lump",
})

--------------------
-- Ore Generation
--------------------

--lapis
--Sheet ore registration
minetest.register_ore({
		ore_type = "sheet",
		ore = "lapis:lapis_block",
		wherein = "default:stone",
		column_height_min = 1,
		column_height_max = 3,
		column_midpoint_factor = 0.5,
		y_min = -500,
		y_max = 200,
		noise_threshhold = 1.25,
		noise_params = {offset=0, scale=2, spread={x=20, y=20, z=10}, seed= 10 , octaves=2, persist=0.8}
	})

-- pyrite
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lapis:pyrite_ore",
		wherein      = "default:stone",
		clust_scarcity = 24 * 24 * 24,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -50,
		y_max          = -10,
	})

			minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lapis:pyrite_ore",
		wherein        = "default:stone",
		clust_scarcity = 18 * 18 * 18,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -150,
		y_max          = -51,
	})

----------
--Aliases
----------

minetest.register_alias("lapis:lapis_paver", "lapis:lapis_cobble")
minetest.register_alias("lapis:lazurite", "lapis:lapis_block")
minetest.register_alias("lapis:pyrite_sacred","lapis:pyrite_block")
minetest.register_alias("lapis:pyrite_coin","lapis:pyrite_ingot")
minetest.register_alias("lapis:sacred_ore", "lapis:lazurite_block")
