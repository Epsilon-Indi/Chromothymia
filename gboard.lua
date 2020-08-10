

gav.f.board_construct =  function(pos, sidelen)
    local sidelen = sidelen or 16
    local pos2 = {x = pos.x + sidelen, y = pos.y, z = pos.z + sidelen}
    local field = minetest.find_nodes_in_area(pos, pos2, "air")
    for n = 1, #field do
        minetest.set_node(field[n], {name = modn..":tile"..1})
    end
end