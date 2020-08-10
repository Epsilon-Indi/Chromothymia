
-- Game agnostic functions

gav.u.sh = function(v)
return type(v) == "string" and minetest.chat_send_all(v) or minetest.chat_send_all(minetest.serialize(v))
end

gav.u.pl = function(v)
return type(v) == "string" and minetest.get_player_by_name(v) or type(v) == "userdata" and v
end
--------------------------


-- Utilfunction constants

gav.u.rolo_MAX = 6

gav.u.rolo_SETTINGNAMES = {"setting_SIZE","has_GUARDRAIL","spawn_DIST","item_DIST","ishihara"}

gav.u.rolo_CYCLE = {{8, 16, 32, 64, 80}, {false, true}, {"uniform","randomform","coliform"}, {"default","looty","guerilla","guiacol"},{false, true}} -- Size
--------------------------


-- Game flow functions

gav.u.cycle = function()
end

--------------------------

-- Team functions

gav.u.team_set = function(name, team) -- Set team of player
    gav.players.teams[name] = team 
end

gav.u.team_clear = function(name) -- Clear team of player
    gav.players.teams[name] = nil
end

gav.u.mob_set = function(color, tf) -- Alter mobility state of an entire team, by color.
    local phys = tf and {speed = 1, jump = 1, gravity = 1, sneak = true, sneak_glitch = false} or {speed = 0, jump = 0, gravity = 666, sneak = false, sneak_glitch = false}

    for n = 1, #gav.teams.color do
        gav.u.pl(gav.teams.color[n]):set_physics_override(phys)
    end
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
    local nex = data and data.cur and data.cur + 1 <= gav.u.rolo_MAX and data.cur + 1 or 1
    meta:set_int("easel_rolo", nex)
end

gav.u.easelc = function(pos) -- Returns easel roll value
return minetest.get_meta(pos):get_int("easel_rolo")
end

gav.u.easelcc = function(pos) -- Returns easel roll value value
return gav.u.easelc(pos) and minetest.get_meta(pos):get_int(gav.u.rolo_SETTINGNAMES[gav.u.easelcc(pos)])
end

gav.u.easel_setting = function(pos)
    local ind = gav.u.easelc(pos)
    local meta = minetest.get_meta(pos)
    local data = {
        cur = meta:get_int(gav.u.rolo_SETTINGNAMES[ind])
    }
    local nex = data.cur and data.cur + 1 <= #gav.u.rolo_CYCLE[ind] and data.cur + 1 or 1
    meta:set_int(gav.u.rolo_SETTINGNAMES[ind], nex)
end

--------------------------

-- Item Logic

gav.u.brushbuild = function(pointed_thing)
    local pos = pointed_thing.under
    local bsize = 32
        local node = minetest.get_node(pos)
        local fpos = {x = pos.x - (bsize/2), y = pos.y - bsize/4, z = pos.z + bsize/2}
        if(node.name == modn..":easel_full")then
            gav.f.board_construct(fpos, bsize)
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