minetest.register_node(modn..":tile",{
    description = "Tile",
    paramtype = "light",
    tiles = {"tile.png^[multiply:#863598"},
    groups = {crumbly = 1},
    on_punch = function(pos)
    minetest.set_node(pos, {name = "air"})
    end
})
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
    gav.u.teambubble(pos)
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