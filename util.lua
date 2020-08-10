
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
gav.u.rolo_SETTINGNAMES = {"setting_SIZE"}
gav.u.rolo_CYCLE = {{8, 16, 32, 64, 80}} -- Size
--------------------------


-- Game flow functions

gav.u.cycle = function()
end

--------------------------

-- Team functions


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

gav.u.easel_rolo = function(pos)
    local meta = minetest.get_meta(pos)
    local data = {
        cur = meta:get_int("easel_rolo"),
    }
    local nex = data and data.cur and data.cur + 1 <= gav.u.rolo_MAX and data.cur + 1 or 1
    meta:set_int("easel_rolo", nex)
end

gav.u.easelc = function(pos)
return minetest.get_meta(pos):get_int("easel_rolo")
end

gav.u.easelcc = function(pos)
return gav.u.easelc(pos) and minetest.get_meta(pos):get_int(gav.u.rolo_SETTINGNAMES[gav.u.easelcc(pos)])
end

gav.u.easel_setting = function(pos)
    local ind = gav.u.easelc(pos)
    local meta = minetest:get_meta(pos)
    local data = {
        cur = meta:get_int(gav.u.rolo_SETTINGNAMES[ind])
    }
    local nex = data.cur and data.cur + 1 <= #gav.u.rolo_CYCLE[ind] and data.cur + 1 or 1
    meta:set_int(gav.u.rolo_SETTINGNAMES[ind], nex)
end

--------------------------