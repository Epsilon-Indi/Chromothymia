for n = 1, #gav.u.colors do
minetest.register_node(modn..":tile"..n,{
    description = "Tile",
    paramtype = "light",
    tiles = {"tile.png^[multiply:"..gav.u.colors[n]},
    groups = {crumbly = 1},
    on_punch = function(pos)
    minetest.set_node(pos, {name = "air"})
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
    on_punch = function(pos)
    --minetest.set_node(pos, {name = "air"})
    gav.u.teambubble(pos, gav.u.colors[math.random(1, #gav.u.colors)])
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
    drawtype = "mesh",
    mesh = "easel.obj",
    tiles = {"bricks1.png"},
    groups = {crumbly = 1},
    on_punch = function(pos)
    minetest.set_node(pos, {name = modn..":easel_full"})
    end
})
minetest.register_node(modn..":easel_full",{
    description = "Tile",
    paramtype = "light",
    drawtype = "mesh",
    mesh = "easel_full.obj",
    tiles = {"bricks1.png"},
    groups = {crumbly = 1},
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