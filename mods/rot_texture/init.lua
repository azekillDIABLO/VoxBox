nodes = {
	"default:dirt",
	"default:dirt_with_grass",
	"default:dirt_with_snow",
	"default:sand",
	"default:desert_sand",
	"default:gravel",
}

for _, node_name in ipairs(nodes) do
	minetest.override_item(node_name, {paramtype2 = "facedir"})
	minetest.override_item(node_name, {after_place_node = 
		function(pos)
			local facedir = math.random(0,3)
			minetest.set_node(pos, {name=node_name, param2 = facedir})
		end
	})

	minetest.register_on_generated(function(minp, maxp, seed)
		for z = minp.z, maxp.z, 1 do
		for x = minp.x, maxp.x, 1 do
			-- Find ground level (0...15)
			local ground_y = nil
			for y = maxp.y, minp.y, -1 do
				local nn = minetest.get_node({x=x, y=y, z=z}).name
				if nn ~= "air" and nn~= "ignore" then
					local is_leaves = minetest.registered_nodes[nn].groups.leaves
					if is_leaves == nil or is_leaves == 0 then
						ground_y = y
						break
					end
				end
			end
			if not ground_y then break end
			local p = {x = x, y = ground_y, z = z}
			if minetest.get_node(p).name == node_name then
				local facedir = math.random(0,3)
				minetest.set_node(p, {name=node_name, param2=facedir})
			end
		end
		end
	end)
end
