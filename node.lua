minetest.register_node(modn..":ltbg",{
    drawtype = "airlike",
    groups = {crumbly = 1},
    on_punch = function(pos)
        local pos2 = {x = pos.x - 6, y = pos.y - 20, z = pos.z - 4}
        minetest.place_schematic(pos2, gav.u.gav_start,270)
        minetest.remove_node(pos)
    end
})

for n = 1, #gav.u.colors do
minetest.register_node(modn..":tile"..n,{
    description = "Tile",
    paramtype = "light",
    tiles = {"tile_2b.png^[multiply:"..gav.u.colors[n]},
    groups = {crumbly = 1,gav_color = 1},
    on_punch = function(pos)
    minetest.set_node(pos, {name = "air"})
    end
})
minetest.register_node(modn..":tile"..n.."b",{
    description = "Tile",
    paramtype = "light",
    tiles = {"tile_2b.png^[multiply:"..gav.u.colors[n]},
    groups = {crumbly = 1, gav_color = 2, gav_color_tick = 2},
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_int("lock_count", 8)
    minetest.get_node_timer(pos):start(1)
    end,
    on_timer = function(pos)
        gav.u.pret_au_chaud(pos, gav.u.colors[n])
        minetest.get_node_timer(pos):start(1)
    end,
    on_punch = function(pos)
        local name = modn.."tile"..n
    minetest.set_node(pos, {name = name})
    end
})
end

minetest.register_node(modn..":atile",{
    description = "Tile",
    paramtype = "light",
    tiles = {"bricks1.png"},
    groups = {crumbly = 1},
    on_punch = function(pos)
    minetest.set_node(pos, {name = "air"})
    gav.u.sh(gav.players)
    end
})
minetest.register_node(modn..":inkwell",{
    description = "Tile",
    paramtype = "light",
    drawtype = "mesh",
    mesh = "inkwell.obj",
    tiles = {"bricks1.png"},
    groups = {crumbly = 1},
    on_punch = function(pos, node, puncher)
    --minetest.set_node(pos, {name = "air"})
    gav.u.team_rolo(puncher:get_player_name())
    gav.u.teambubble(pos, gav.u.colors[gav.players.teams[puncher:get_player_name()]])
    
    gav.u.sh(gav.players.teams)
    end
})
minetest.register_node(modn..":brush",{
    description = "Tile",
    paramtype = "light",
    drawtype = "mesh",
    mesh = "brush.obj",
    tiles = {"bricks1.png"},
    groups = {crumbly = 1},
    on_punch = function(pos)
    minetest.set_node(pos, {name = "air"})
    gav.u.sh(gav.players)
    end
})
minetest.register_node(modn..":easel_blank",{
    description = "Tile",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "easel.obj",
    tiles = {"bricks1.png"},
    groups = {crumbly = 1, easel = 1},
    on_punch = function(pos)
    minetest.set_node(pos, {name = modn..":easel_full", param2 = 2})
    end
})
minetest.register_node(modn..":easel_full",{
    description = "Tile",
    paramtype = "light",
    paramtype2 = "facedir",
    drawtype = "mesh",
    mesh = "easel_full.obj",
    tiles = {"easeltest.png"},
    groups = {crumbly = 1, easel = 1},
    on_punch = function(pos)
        gav.u.easel_rolo(pos)
        gav.u.sh(minetest.get_meta(pos):get_int("easel_rolo"))
    end,
    on_rightclick = function(pos)
        local set = minetest.get_meta(pos):get_int("easel_rolo")
        gav.u.sh(set)
        gav.u.easel_setting(pos)
        gav.u.sh(minetest.get_meta(pos):get_int(gav.u.rolo_SETTINGNAMES[set]))
        

    end
})

-- craftitems

minetest.register_craftitem(modn..":filbert", { -- ADMIN BRUSH
    description = "Brush of the Cloister",
    groups = {},
    inventory_image = "default_tool_steelaxe.png",
    inventory_overlay = "overlay.png",
    wield_image = "",
    wield_overlay = "",
    wield_scale = {x = 1, y = 1, z = 1},
    stack_max = 99,
    range = 4.0,
    on_place = function(itemstack, placer, pointed_thing)
    end,
    on_secondary_use = function(itemstack, user, pointed_thing)
    end,
    on_drop = function(itemstack, dropper, pos)
    end,
    on_use = function(itemstack, user, pointed_thing)
        if(user:get_player_control().sneak)then
        gav.u.brushbuild(pointed_thing, true)
        else gav.u.brushbuild(pointed_thing, false) end
    end
})
local bbb = true
minetest.register_craftitem(modn..":brush", {
    description = "Brush",
    groups = {},
    inventory_image = "brush.png",
    inventory_overlay = "brush.png",
    wield_image = "brush.png",
    wield_overlay = "",
    wield_scale = {x = 1, y = 1, z = 1},
    stack_max = 99,
    range = 4.0,
    on_place = function(itemstack, placer, pointed_thing)
    end,
    on_secondary_use = function(itemstack, user, pointed_thing)
        return
    end,
    on_drop = function(itemstack, dropper, pos)
    end,
    on_use = function(itemstack, user, pointed_thing)
        gav.u.paint(pointed_thing.under, user)
    end
})
minetest.register_craftitem(modn..":endt", {
    description = "End Turn",
    groups = {},
    inventory_image = "icon_arrow_endturn.png",
    wield_image = nil,
    wield_overlay = nil,
    wield_scale = {x = 1, y = 1, z = 1},
    stack_max = 1,
    range = 0,
    on_place = function(itemstack, placer, pointed_thing)
    end,
    on_secondary_use = function(itemstack, user, pointed_thing)
        return
    end,
    on_drop = function(itemstack, dropper, pos)
    end,
    on_use = function(itemstack, user, pointed_thing)
        
        gav.u.cycle_progress(gav.players.teams[user:get_player_name()], true)
        gav.u.sh(gav.flow.cycle.counter)
    end
})