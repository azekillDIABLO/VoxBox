-- Parameters

local TTUN = 0.02 -- Tunnel width
local TMAG = 0.01 -- Magma channel width
local LUX = true -- Enable luxore
local LUXCHA = 1 / 9 ^ 3 -- Luxore chance per stone node.

-- 3D noise a

local np_weba = {
	offset = 0,
	scale = 1,
	spread = {x = 192, y = 192, z = 192},
	seed = 5900033,
	octaves = 3,
	persist = 0.5
}

-- 3D noise b

local np_webb = {
	offset = 0,
	scale = 1,
	spread = {x = 191, y = 191, z = 191},
	seed = 33,
	octaves = 3,
	persist = 0.5
}

-- 3D noise c

local np_webc = {
	offset = 0,
	scale = 1,
	spread = {x = 190, y = 190, z = 190},
	seed = -18000001,
	octaves = 3,
	persist = 0.5
}

-- 3D noise d

local np_webd = {
	offset = 0,
	scale = 1,
	spread = {x = 384, y = 384, z = 384},
	seed = -181,
	octaves = 3,
	persist = 0.4
}

-- 3D noise e

local np_webe = {
	offset = 0,
	scale = 1,
	spread = {x = 383, y = 383, z = 383},
	seed = 1022081,
	octaves = 3,
	persist = 0.4
}

-- 3D noise for biomes

local np_biome = {
	offset = 0,
	scale = 1,
	spread = {x = 384, y = 384, z = 384},
	seed = 89114,
	octaves = 1,
	persist = 0
}

-- Nodes

minetest.register_node("intersecting:luxore", {
	description = "Lux Ore",
	tiles = {"intersecting_luxore.png"},
	paramtype = "light",
	light_source = 14,
	groups = {cracky = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("intersecting:light", {
	description = "Light",
	tiles = {"intersecting_light.png"},
	paramtype = "light",
	light_source = 14,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

-- Crafting.

minetest.register_craft({
    output = "intersecting:light 8",
    recipe = {
        {"default:glass", "default:glass", "default:glass"},
        {"default:glass", "intersecting:luxore", "default:glass"},
        {"default:glass", "default:glass", "default:glass"},
    },
})

minetest.register_craft({
    output = "intersecting:light 8",
    recipe = {
        {"default:obsidian_glass", "default:obsidian_glass", "default:obsidian_glass"},
        {"default:obsidian_glass", "intersecting:luxore", "default:obsidian_glass"},
        {"default:obsidian_glass", "default:obsidian_glass", "default:obsidian_glass"},
    },
})

-- Initialize noise objects to nil

local nobj_weba = nil
local nobj_webb = nil
local nobj_webc = nil
local nobj_webd = nil
local nobj_webe = nil
local nobj_biome = nil

-- On generated function

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y > 48 then
		return
	end

	local t1 = os.clock()
	local x1 = maxp.x
	local y1 = maxp.y
	local z1 = maxp.z
	local x0 = minp.x
	local y0 = minp.y
	local z0 = minp.z
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()
	
	local c_air = minetest.get_content_id("air")
	local c_water = minetest.get_content_id("default:water_source")
	local c_dirt = minetest.get_content_id("default:dirt")
	local c_sand = minetest.get_content_id("default:sand")
	local c_lava = minetest.get_content_id("default:lava_source")
	local c_grass = minetest.get_content_id("default:dirt_with_grass")
	local c_tree = minetest.get_content_id("default:tree")
	local c_jtree = minetest.get_content_id("default:jungletree")
	local c_stone = minetest.get_content_id("default:stone")
	local c_desertstone = minetest.get_content_id("default:desert_stone")
	local c_sandstone = minetest.get_content_id("default:sandstone")
	local c_luxore = minetest.get_content_id("intersecting:luxore")

	local sidelen = x1 - x0 + 1
	local emerlen = sidelen + 32
	local emerarea = emerlen ^ 2
	local chulens = {x = sidelen, y = sidelen, z = sidelen}
	local minposxyz = {x = x0, y = y0, z = z0}
	
	nobj_weba = nobj_weba or minetest.get_perlin_map(np_weba, chulens)
	nobj_webb = nobj_webb or minetest.get_perlin_map(np_webb, chulens)
	nobj_webc = nobj_webc or minetest.get_perlin_map(np_webc, chulens)
	nobj_webd = nobj_webd or minetest.get_perlin_map(np_webd, chulens)
	nobj_webe = nobj_webe or minetest.get_perlin_map(np_webe, chulens)
	nobj_biome = nobj_biome or minetest.get_perlin_map(np_biome, chulens)
	
	local nvals_weba = nobj_weba:get3dMap_flat(minposxyz)
	local nvals_webb = nobj_webb:get3dMap_flat(minposxyz)
	local nvals_webc = nobj_webc:get3dMap_flat(minposxyz)
	local nvals_webd = nobj_webd:get3dMap_flat(minposxyz)
	local nvals_webe = nobj_webe:get3dMap_flat(minposxyz)
	local nvals_biome = nobj_biome:get3dMap_flat(minposxyz)
	
	local cavbel = {}
	--local stobel = {}
	local nixyz = 1
	for z = z0, z1 do -- for each xy plane progressing northwards
		for y = y0, y1 do -- for each x row progressing upwards
			local ti = 1
			local vi = area:index(x0, y, z)
			local via = vi + emerlen
			local vin = vi + emerarea
			local vis = vi - emerarea
			local vie = vi + 1
			local viw = vi - 1
			for x = x0, x1 do -- for each node progressing eastwards
				local nodid = data[vi]
				local nodida = data[via]
				local nodide = data[vie]
				local nodidw = data[viw]
				local nodidn = data[vin]
				local nodids = data[vis]
				-- water adjacent
				local watadj = nodida == c_water
					or nodidw == c_water or nodide == c_water
					or nodidn == c_water or nodids == c_water
				-- lakebed material
				local surfmat = (nodid == c_sand or nodid == c_dirt
					or nodid == c_grass) and y <= 2
				if nodid ~= c_air then
					local weba = math.abs(nvals_weba[nixyz]) < TTUN
					local webb = math.abs(nvals_webb[nixyz]) < TTUN
					local webc = math.abs(nvals_webc[nixyz]) < TTUN
					local webd = math.abs(nvals_webd[nixyz]) < TMAG
					local webe = math.abs(nvals_webe[nixyz]) < TMAG
					local n_biome = nvals_biome[nixyz]
					local void
					local magma = webd and webe
					if n_biome < -0.3 then
						void = (weba and webb) or (webb and webc)
					elseif n_biome < 0.3 then
						void = (webb and webc) or (weba and webc)
					else
						void = (weba and webc) or (weba and webb)
					end
					if void or magma then
						if magma then -- magma tunnel
							if y <= 1 then
								data[vi] = c_lava
							else
								data[vi] = c_air
							end
							cavbel[ti] = 1
							--stobel[ti] = 0
						elseif (nodid == c_water or watadj) and cavbel[ti] == 1 then
							for j = -1, -16, -1 do -- water plug
								local vip = area:index(x, y + j, z)
								if data[vip] == c_air then
									data[vip] = c_stone
								end
							end
							cavbel[ti] = 0
							--stobel[ti] = 0
						elseif nodid ~= c_water and not surfmat and not watadj then
							data[vi] = c_air -- tunnel
							cavbel[ti] = 1
							--stobel[ti] = 0
						end
						-- if trunk cut remove whole trunk
						if nodid == c_tree or nodid == c_jtree then
							for j = -12, 12 do
								local vit = area:index(x, y + j, z)
								if data[vit] == c_tree or data[vit] == c_jtree then
									data[vit] = c_air
								end
							end
						end
					else -- solid or liquid
						cavbel[ti] = 0
						if nodid == c_stone or nodid == c_desertstone
								or nodid == c_sandstone then
							if LUX then
								if math.random() < LUXCHA then
									data[vi] = c_luxore
								end
							end
							--stobel[ti] = 1
						end
					end
				else -- nodid == c_air
					cavbel[ti] = 0
					--stobel[ti] = 0
				end
				nixyz = nixyz + 1
				ti = ti + 1
				vi = vi + 1
				via = via + 1
				vin = vin + 1
				vis = vis + 1
				vie = vie + 1
				viw = viw + 1
			end
		end
	end
	
	vm:set_data(data)
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	vm:write_to_map(data)

	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[intersecting] " .. chugent .. " ms")
end)
