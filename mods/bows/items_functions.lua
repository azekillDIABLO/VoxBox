
bows.arrow_dig=function(self,pos,user,lastpos)
	minetest.node_dig(pos, minetest.get_node(pos), user)
	bows.arrow_remove(self)
	return self
end


bows.arrow_fire_object=function(self,target,hp,user,lastpos)
	bows.arrow_fire(self,lastpos,user,target:getpos())
	return self
end

bows.arrow_fire=function(self,pos,user,lastpos)
	local name=user:get_player_name()
	local node=minetest.get_node(lastpos).name
	if minetest.is_protected(lastpos, name) then
		minetest.chat_send_player(name, minetest.pos_to_string(lastpos) .." is protected")
	elseif minetest.registered_nodes[node].buildable_to then
		minetest.set_node(lastpos,{name="fire:basic_flame"})
	end
	bows.arrow_remove(self)
	return self
end

bows.arrow_build=function(self,pos,user,lastpos)
	local name=user:get_player_name()
	local node=minetest.get_node(lastpos).name
	local index=user:get_wield_index()+1
	local inv=user:get_inventory()
	local stack=inv:get_stack("main", index)
	if minetest.is_protected(lastpos, name) then
		minetest.chat_send_player(name, minetest.pos_to_string(lastpos) .." is protected")
	elseif minetest.registered_nodes[node].buildable_to
	and minetest.registered_nodes[stack:get_name()] then
		minetest.set_node(lastpos,{name=stack:get_name()})
		if bows.creative==false then
			inv:set_stack("main",index,ItemStack(stack:get_name() .. " " .. (stack:get_count()-1)))
		end
	end
	bows.arrow_remove(self)
	return self
end

bows.arrow_toxic=function(self,target,hp,user,lastpos)
	if self.object==nil or user==nil or target==nil or target:get_properties()==nil then
		bows.arrow_remove(self)
		return self
	end
	target:punch(user, 3,{full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:sword_wood", nil)
	local rnd=math.random(1,10)
	if rnd~=4 and  target:get_hp()>0 then
		minetest.after(math.random(0.5,2), function(self,target,hp,user,lastpos)
			bows.arrow_toxic(self,target,hp,user,lastpos)
		end, self,target,hp,user,lastpos)
	else
		bows.arrow_remove(self)
	end
end

bows.arrow_tetanus=function(self,target,hp,user,lastpos)
	if self.object==nil or user==nil or target==nil or target:get_properties()==nil then
		bows.arrow_remove(self)
		return self
	end
	if target:get_attach()==nil then
		self.object:set_detach()
		local col=target:get_properties().collisionbox
		self.object:set_properties({
			collisionbox=col,
			physical=true,
			visual_size={x=1,y=1},
			visual="sprite",
			textures={"bows_hidden.png"}
		})
		self.object:setpos(target:getpos())
		target:set_attach(self.object, "", {x=0,y=0,z=0},{x=0,y=0,z=0})
		self.target=target
		self.hp=self.object:get_hp()
		self.object:setvelocity({x=0, y=-3, z=0})
		self.object:setacceleration({x=0, y=-3, z=0})
		return self
	end

	local rnd=math.random(1,10)
	if rnd~=4 and  target:get_hp()>0 then
		minetest.after(math.random(4), function(self,target,hp,user,lastpos)
			bows.arrow_tetanus(self,target,hp,user,lastpos)
		end, self,target,hp,user,lastpos)
	else
		target:set_detach()
		target:setvelocity({x=0, y=4, z=0})
		target:setacceleration({x=0, y=-10, z=0})
		bows.arrow_remove(self)
	end
end

bows.arrow_admin_object=function(self,target,hp,user,lastpos)
	target:set_hp(0)
	target:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:sword_wood", nil)
	bows.arrow_remove(self)
	return self
end

bows.arrow_admin_node=function(self,pos,user,lastpos)
	bows.arrow_remove(self)
	return self
end

bows.arrow_tnt_object=function(self,target,hp,user,lastpos)
	local name=user:get_player_name()
	local node=minetest.get_node(lastpos).name
	if minetest.is_protected(lastpos, name) then
		minetest.chat_send_player(name, minetest.pos_to_string(lastpos) .." is protected")
	elseif minetest.registered_nodes[node].buildable_to then
		minetest.set_node(lastpos,{name="tnt:tnt_burning"})
	end
	bows.arrow_remove(self)
	return self
end

bows.arrow_tnt_node=function(self,pos,user,lastpos)
	local name=user:get_player_name()
	local node=minetest.get_node(lastpos).name
	if minetest.is_protected(lastpos, name) then
		minetest.chat_send_player(name, minetest.pos_to_string(lastpos) .." is protected")
	elseif minetest.registered_nodes[node].buildable_to then
		minetest.set_node(lastpos,{name="tnt:tnt_burning"})
	end
	bows.arrow_remove(self)
	return self
end