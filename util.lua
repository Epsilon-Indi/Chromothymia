
-- Game agnostic functions

gav.u.sh = function(v)
return type(v) == "string" and minetest.chat_send_all(v) or minetest.chat_send_all(minetest.serialize(v))
end

gav.u.pl = function(v)
return v:is_player() and minetest.get_player_by_name(v) or type(v) == "userdata" and v
end
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
