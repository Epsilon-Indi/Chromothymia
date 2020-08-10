

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
dofile(path.."/visuals.lua")

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

minetest.register_on_joinplayer(function(player) -- Add player name to list on login
table.insert(gav.players.names, player:get_player_name())
local props = player:get_properties()
props.textures[1] = props.textures[1]-- To modify later
player:set_properties(props)
minetest.after(3, function() gav.u.sh(player:get_properties()) end)
end)

minetest.register_on_leaveplayer(function(player, timed_out) -- Remove playername from list on logout
    local name = player:get_player_name()
 for n = 1, #gav.players.names do
    if(gav.players.names[n] == name)then
        gav.players.names[n] = nil
    else end
end
end)