

modn = minetest.get_current_modname()
local path = minetest.get_modpath(modn)
gav = {
    u = {},
    m = {},
    f = {},
    players = {names = {}, teams = {}},
    flow = { cycle = {}},
    SETTINGS = {}
}




dofile(path.."/node.lua")
dofile(path.."/flow.lua")
dofile(path.."/util.lua")

minetest.register_on_generated(function(minp, maxp) -- Generates initial area on new world construction.

local vm = minetest.get_mapgen_object("voxelmanip")
local va = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
local is_origin = va:contains(0,0,0)

if(is_origin)then
vm:set_node_at({x=0,y=0,z=0}, {name = "gav:tile"})
minetest.after(5, function() minetest.punch_node({x=0,y=0,z=0})end)
else end
vm:write_to_map()


end)