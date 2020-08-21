
-- Game agnostic functions
gav.u.ch = function(v)
    minetest.chat_send_all(v)
    return true end

gav.u.sh = function(v)
return type(v) == "string" and gav.u.ch(v) or minetest.chat_send_all(minetest.serialize(v))
end

gav.u.s = function(v)
return minetest.serialize(v)
end

gav.u.pl = function(v)
return type(v) == "string" and minetest.get_player_by_name(v) or v
end

gav.u.pln = function(v)
return type(v) == "userdata" and v:get_player_name() or type(v) == "string" and v
end
--------------------------


-- Utilfunction constants

gav.u.rolo_MAX = 5

gav.u.rolo_SETTINGNAMES = {"setting_SIZE","has_GUARDRAIL","spawn_DIST","item_DIST","turn_TIME","ishihara"}

gav.u.rolo_SETTINGS = {{8, 16, 32, 64, 80}, {"Present", "Absent"}, {"uniform","randomform","coliform"}, {"default","looty","guerilla","guiacol"},{},{false, true}} -- Size
for n = 1, 30 do
    table.insert(gav.u.rolo_SETTINGS[5],n)
end
gav.u.flow_QUEUE = {teams = {}, board = { locked = { poses = {}, incrs = {}}}}

--------------------------


-- Game flow functions
gav.u.commence = function(order)
    gav.flow.GAME_IO = true
    gav.u.team_shore(order)
    local function pregame_HUD_clear()
        for k,v in pairs(gav.players.huds)do
            for n = 1, #v do
            gav.u.pl(k):hud_remove(v[n])
            end
        end
    end

    pregame_HUD_clear()
    gav.u.sh(gav.players.huds)
end

gav.f.board_wane = function()
    if(gav.m.corners)then
    local field = minetest.find_nodes_in_area(gav.m.corners[1],gav.m.corners[2],"group:gav_color_tick")
    for n = 1, #field do
        gav.f.lock_wane(field[n])
    end
else end
end

gav.u.cycle_shift = function() -- Changes "turn". Invoking all functions at turn change.
    local prev,nex = gav.flow.cycle.prev, gav.flow.cycle.nex
        if(prev)then gav.u.mob_set_team(prev, false) else  end 
        gav.flow.cycle.prev = nex
        gav.u.mob_set_team(nex, true)
        gav.u.sh("turn shifted. Current active team is "..nex)
        gav.u.sh("Team at this position is "..gav.players.teams2[nex].id) -- *REMINDER replace with message function.
        
        gav.flow.cycle.nex = nex + 1 <= #gav.players.teams2 and nex + 1 or 1
    return true
end

gav.u.cycle_progress = function(color)
    local color = color and #gav.players.teams2[color] or 5
    gav.flow.cycle.counter = gav.flow.cycle.counter + 1
    local function counterclear()
        gav.flow.cycle.counter = 0
        return true
    end

    return gav.flow.cycle.counter >= color and counterclear() and gav.u.cycle_shift() and gav.f.board_wane() or true
end

gav.u.flow_cycle = function()
    gav.u.flow_QUEUE[1]()
end

gav.u.flow_QUEUE_add = function(elemdef)

end
--------------------------

-- Team functions


gav.u.team_set = function(name, team) -- Set team of player
    gav.players.teams[name] = team  -- team is an int from 1 to 12 denoting color of team
    return table.insert(gav.players.teams2[team],name) and true
end

gav.u.team_clear = function(name) -- Clear team of player
    local team = gav.players.teams[name]
    local ind = false
    gav.players.teams[name] = nil
    for n = 1, #gav.players.teams2[team] do
        if(gav.players.teams2[team][n] == name)then
            table.remove(gav.players.teams2[team],n)
            ind = true
        else end
    end
    return ind
end
gav.u.team_rolo = function(name)
    
    if(gav.flow.GAME_IO)then return else
        local function rolo_insert(name)
        local ind = gav.players.teams[name]
        ind = ind and ind <= #gav.u.colors and ind + 1 or 2
        if(ind > 2)then
            gav.u.team_clear(name)
        else end
        gav.players.teams[name] = ind
        return gav.players.teams2[ind] and gav.u.team_set(name,ind)
        end
        rolo_insert(name)
    end
end
gav.u.team_shore = function(order) -- Meant for consolidation of teams
    local first = math.random(1, #gav.players.teams2)
    local function cull()
        for n = 1, #gav.players.teams2 do
            if(#gav.players.teams2[n] > 0)then
            else gav.players.teams2[n] = nil 
            end
        end
    end
    cull()
    local eph = {}
    local num2 = 0
    for k,v in pairs(gav.players.teams2)do
        num2 = num2 + 1
    eph[num2] = v; eph[#eph].id = k
    end
    gav.u.sh(eph)
    gav.players.teams2 = eph; eph = nil
    
    local function shuffle(order)
        if(order)then
            if(order == "random")then
                local v = {}
                local count = #gav.players.teams2
                for k,_ in pairs(gav.players.teams2)do
                    table.insert(v,k)
                end

                for n = 1, #gav.players.teams2 - 1 do
                    local num = math.random(1,count)
                    local v, v2 = gav.players.teams2[num],gav.players.teams2[n]
                    gav.players.teams2[n] = v
                    gav.players.teams2[num] = v2
                end
            elseif(order == "reverse")then
            else end
        else end
        end
    cull()
    shuffle("random")
end


gav.u.assign_piece = function(name, num)
    gav.u.players.figs[name] = gav.u.players.figs[name] or num
end



gav.u.mob_set_team = function(color, tf) -- Alter mobility state of an entire team, by color.
    if(gav.players.teams2[color])then
        local function invert_mesh(player)
            local props = player:get_properties()
            props.visual_size = {x = 0, y = 0}
            player:set_properties(props)
        end


        local function attach_piece(player)
        local ent = minetest.add_entity(player:get_pos(),modn..":pawn", nil)
            --ent:set_attach(player, "Head", {x=0,y=0,z=0},{x=0,y=0,z=0})
        end
    for n = 1, #gav.players.teams2[color] do
        
        
        local player = gav.u.pl(gav.players.teams2[color][n])
        invert_mesh(player)
        attach_piece(player)
        gav.u.sh(player:get_player_name())
    end
else end
end

gav.u.gear_set = function(color, tf) -- Alter gear of an entire team, by color.

end
--------------------------

-- Easel Logic

gav.u.easel_rolo = function(pos) -- Rolls up easel selection
    local meta = minetest.get_meta(pos)
    local data = {
        cur = meta:get_int("easel_rolo"),
    }
    local nex = data.cur and data.cur + 1 <= #gav.u.rolo_SETTINGNAMES and data.cur + 1 or 1
    meta:set_int("easel_rolo", nex)
end

gav.u.easelc = function(pos) -- Returns easel roll value
return minetest.get_meta(pos):get_int("easel_rolo")
end

gav.u.easelcc = function(pos) -- Returns easel roll value value
return gav.u.easelc(pos) and minetest.get_meta(pos):get_int(gav.u.rolo_SETTINGNAMES[gav.u.easelcc(pos)])
end

gav.u.easel_setting = function(pos) -- Uses current rolo position to set choice from within rolo
    local ind = gav.u.easelc(pos) 
    local meta = minetest.get_meta(pos)
    local data = {
        cur = meta:get_int(gav.u.rolo_SETTINGNAMES[ind])
    }
    local nex = data.cur + 1 <= #gav.u.rolo_SETTINGS[ind] and data.cur + 1 or 1
    meta:set_int(gav.u.rolo_SETTINGNAMES[ind], nex)
    gav.SETTINGS[ind] = nex
end

--------------------------

-- Item Logic

gav.u.brushbuild = function(pointed_thing, tf)
    local pos = pointed_thing.under
    local bsize = 32
        local node = minetest.get_node(pos)
        local fpos = {x = pos.x - (bsize/2), y = pos.y - bsize/4, z = pos.z + bsize/2}
        if(node.name == modn..":easel_full" and tf)then
            gav.f.board_construct(fpos, bsize)
        else gav.f.board_destruct(fpos, bsize) end
end

gav.u.paint = function(pos, painter)
    local painter = gav.u.pln(painter)
    local teamc = gav.players.teams[painter] or 1
    return pos and minetest.get_node(pos).name == modn..":tile1" and minetest.set_node(pos, {name = modn..":tile"..teamc.."b"})
end

--------------------------

-- HUD functions

gav.u.hud_s = function(n, tf)
    local name = gav.players.names[n]
    if(tf and not gav.players.huds[name][1])then
        gav.players.huds[name][1] =
    gav.u.pl(name):hud_add({
    hud_elem_type = "image",
    position = {x=0.05, y=0.7},
    name = "<name>",
    scale = {x = 1.5, y = 1.5},
    text = "icon_hud_setting0.png",
    number = 1,
    item = 1,
    direction = 0,
    alignment = {x=0, y=0},
    offset = {x=-30, y=-10},
    size = {x=2, y=2},
})
elseif(not tf and not gav.players.huds[name][2])then
    
    local strings = {}
    for n = 1, #gav.SETTINGS do
        strings[n] = gav.u.s(gav.SETTINGS[n])
    end

    local ftext = table.concat(strings)
    minetest.wrap_text(ftext, 1, false)
gav.players.huds[name][2] =
    gav.u.pl(name):hud_add({
    hud_elem_type = "text",
    position = {x=0.1, y=0.7},
    name = "",
    scale = {x = 2, y = 2},
    text = ftext,
    number = "0xFFFFFF",
    item = 1,
    direction = 0,
    alignment = {x=0, y=0},
    offset = {x=0, y=0},
    size = {x=2, y=2},
})

else end
end

gav.u.hud_c = function(n)
    local name = gav.players.names[n]
    if(gav.players.huds[name][2])then
    
        local strings = {}
        for n = 1, #gav.SETTINGS - 2 do
            strings[n] = gav.u.rolo_SETTINGS[n][gav.SETTINGS[n]] and tostring(gav.u.rolo_SETTINGS[n][gav.SETTINGS[n]]).."\n" or ""
        end
        local ftext = table.concat(strings)
        minetest.wrap_text(ftext, 1, false)
        gav.u.pl(name):hud_change(gav.players.huds[name][2], "text", ftext)
    else end
end

--------------------------


-- Schema

n1 = { name = "air", prob = 0 }
n2 = { name = "gav:atile" }
n3 = { name = "gav:inkwell" }
n4 = { name = "gav:easel_blank", param2 = 1 }

gav.u.gav_start = {
	yslice_prob = {
		
	},
	size = {
		y = 5,
		x = 12,
		z = 9
	}
,
	data = {
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n2, n2, n3, n2, n2, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n2, n2, n2, n1, n1, n1, n1, n1, n1, n1, n2, 
n2, n1, n1, n1, n2, n2, n2, n2, n2, n2, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n2, n1, 
n2, n2, n2, n2, n2, n2, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n2, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n2, n2, n2, n1, n1, n1, n1, n1, n1, n1, n1, n2, n2, n1, n2, n2, n1, 
n1, n1, n1, n1, n1, n2, n2, n1, n1, n1, n2, n2, n2, n2, n2, n1, n2, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n4, n2, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n2, 
n1, n2, n2, n2, n2, n2, n2, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n2, n2, n2, n1, n1, n1, n1, n1, n1, 
n1, n2, n2, n1, n1, n1, n2, n2, n2, n2, n2, n2, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n2, n2, n3, n2, n2, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, 

}
}