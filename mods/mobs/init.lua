local path = minetest.get_modpath("mobs")

-- Mob Api

dofile(path.."/api.lua")

-- Animals

dofile(path.."/cow.lua") -- KrupnoPavel
dofile(path.."/rat.lua") -- PilzAdam
--dofile(path.."/ghast.lua") -- azekill_DIABLO

-- Monsters


dofile(path.."/sandmonster.lua")
dofile(path.."/stonemonster.lua")
dofile(path.."/spider.lua") -- AspireMint

print ("[MOD] Mobs Redo loaded")