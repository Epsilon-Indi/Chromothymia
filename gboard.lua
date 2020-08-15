

gav.f.board_construct =  function(pos, sidelen)
    local sidelen = sidelen or 16
    local pos2 = {x = pos.x + sidelen, y = pos.y, z = pos.z + sidelen}
    local field = minetest.find_nodes_in_area(pos, pos2, "air")
    field = field and #field > 0 and field or minetest.find_nodes_in_area(pos, pos2, "group:gav_color")
    gav.m.corners = {pos,pos2}
    for n = 1, #field do
        minetest.set_node(field[n], {name = modn..":tile"..1})
    end
end

gav.f.board_destruct =  function(pos, sidelen)
    local sidelen = sidelen or 16
    local pos2 = {x = pos.x + sidelen, y = pos.y, z = pos.z + sidelen}
    local field = minetest.find_nodes_in_area(pos, pos2, "group:gav_color")
    gav.m.corners = {pos,pos2}
    for n = 1, #field do
        minetest.remove_node(field[n])
    end
end

gav.f.lock_wane = function(pos)
    local meta = minetest.get_meta(pos)
    if(meta:get_int("lock_count")>1)then
        meta:set_int("lock_count",meta:get_int("lock_count")-1)
    else
    local name = minetest.get_node(pos).name
    local name = string.gsub(name,"b","")
    minetest.set_node(pos, {name = name})
    end
end