

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

gav.f.spawn_select = function(form)
    local tab = gav.m.corners

    local area = minetest.find_nodes_in_area(tab[1],tab[2], "group:gav_color")
    local num = math.sqrt(#area)
    local points = {}
    local data = {playerc = #gav.players.names}

    if(form == "uniform")then
        data.corners, data.offsets = {1,num,(num*(num-1)+1),num^2},{{1,num},{-1,num},{1,-num},{-1,-num}}
        local function ladder_subtract(n)
            local n,c = n,1
            while(n-4>0)do
                n = n - 4
                c = c + 1
            end
            return {n,c}
        end


        local function populate_table()
            for n = 1, data.playerc do
                if(n <= 4)then
                    points[n] = data.corners[n]
                elseif(n > 4)then
                    local nn = ladder_subtract(n)
                    gav.u.sh(n)
                    nn[2] = nn[2]-1
                    gav.u.sh(nn)
                    points[n] = data.corners[nn[1]] + data.offsets[nn[1]][1]*nn[2] + data.offsets[nn[1]][2]*nn[2]
                else end
            end
        end

        populate_table()
        
    elseif(form == "randomform")then
        local pulled = {}
        for n = 1, #area do
            pulled[n] = n
        end
        local count = #pulled
        for n = 1, #pulled - 1 do
            local num = math.random(1,count)
            local v, v2 = pulled[num],pulled[n]
            pulled[n] = v
            pulled[num] = v2
        end
        for n = 1,data.playerc do
            points[n] = pulled[n]
        end
    else
    end
  
    local function spawn_players()
        for n = 1, #gav.players.names do
            local sp = points[n]
            local pos = area[sp]
            gav.u.sh(sp)
            pos.y = pos.y+0.5
            minetest.add_entity(pos, modn..":pawn", nil)
        end
    end
    spawn_players()
    
end

