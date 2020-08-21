local order = {}

gav.f.commence = function()
end
gav.f.board_wane = function()
    local field = minetest.find_nodes_in_area(gav.m.corners[1],gav.m.corners[2],"group:gav_color_tick")
    for n = 1, #field do
        gav.f.lock_wane(field[n])
    end
end

minetest.register_abm(
{
    label = "Turn timer",   
    interval = 1.0,
    nodenames = {"group:easel"},
    chance = 1,
    catch_up = false,
    action = function(pos, node, active_object_count, active_object_count_wider)
         --gav.u.sh(gav.players.teams2)
        if(gav.flow.GAME_IO)then 
        gav.u.cycle_progress()
        else
        for n = 1, #gav.players.names do
            local name = gav.players.names[n]
                if(gav.players.huds[name] and gav.players.huds[name][2])then
                    gav.u.hud_c(n)
                else gav.u.hud_s(n, false)
                end       
        end  
    end
        return
    end
})