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
    end
})