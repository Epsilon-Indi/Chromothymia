

modn = minetest.get_current_modname()
local path = minetest.get_modpath(modn)
gav = {
    u = { colors = {"#f2f2f2","#ff6f5e","#228b22","#2c3d63","#ac67ef","#0e7fa7","#fdd66d","#8b8378","#addcca","#ff721a","#662f6d","#905f3b","#b62828"}},
    m = {},
    f = {},
    players = {names = {}, teams = {}, teams2 = {}, teams3 = {}, huds = {}, figs = {}}, -- names (all players), teams (names, but with team values to name keys), teams2 (teams but grouped and inverted), teams3 (teams but with a bool for readiness as value instead of team)
    flow = {GAME_IO = false, cycle = {counter = 0, order = nil, nex = 1}},
    SETTINGS = {}
}
for n = 1, #gav.u.colors do
gav.players.teams2[n] = {id = n}
end
minetest.after(5, function() 
for n = 2, 64 do
    gav.players.names[n] = gav.players.names[1]
end
end)
gav.SETTINGS[5] = 5

dofile(path.."/entity.lua")
dofile(path.."/node.lua")
dofile(path.."/flow.lua")
dofile(path.."/util.lua")
dofile(path.."/visuals.lua")
dofile(path.."/gboard.lua")

minetest.register_on_generated(function(minp, maxp) -- Generates initial area on new world construction.

local vm = minetest.get_mapgen_object("voxelmanip")
local va = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
local is_origin = va:contains(0,0,0)

if(is_origin)then
vm:set_node_at({x=0,y=0,z=0}, {name = modn..":ltbg"})
minetest.after(1, function() minetest.punch_node({x=0,y=0,z=0})end)
else end
vm:write_to_map()


end)

minetest.register_on_joinplayer(function(player) -- Add player name to list on login
local name = gav.u.pln(player)
table.insert(gav.players.names, name)
gav.players.huds[name] = {}
gav.u.hud_s(#gav.players.names, true)
end)

minetest.register_on_leaveplayer(function(player, timed_out) -- Remove playername from list on logout
    local name = player:get_player_name()
 for n = 1, #gav.players.names do
    if(gav.players.names[n] == name)then
        gav.players.names[n] = nil
    else end
end
end)

-- Commands
minetest.register_chatcommand("cyclet", {
    params = "<name> <privilege>", 
    description = "Remove privilege from player", 
    privs = {privs=true},
    func = function(name, param)
        gav.u.sh(gav.u.table_crawl())
    end
})
minetest.register_chatcommand("startt", {
    params = "<name> <privilege>", 
    description = "Remove privilege from player", 
    privs = {privs=true},
    func = function(name, param)
        gav.u.commence("random")
    end
})
minetest.register_chatcommand("selectt", {
    params = "<name> <privilege>", 
    description = "Remove privilege from player", 
    privs = {privs=true},
    func = function(name, param)
       gav.f.spawn_select("randomform")
    end
})