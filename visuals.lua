gav.u.teambubble = function(pos, color)
    local color = color or ""
    minetest.add_particlespawner({
        amount = 10,
        time = 1,
        minpos = {x=pos.x-0.1, y=pos.y + 0.5, z=pos.z-0.1},
        maxpos = {x=pos.x+0.1, y=pos.y + 0.5, z=pos.z+0.1},
        minvel = {x=0, y=0.2, z=0},
        maxvel = {x=0, y=0.4, z=0},
        minacc = {x=0, y=0, z=0},
        maxacc = {x=0, y=1, z=0},
        minexptime = 0.5,
        maxexptime = 1.2,
        minsize = 1,
        maxsize = 1.6,

        collisiondetection = false,
        collision_removal = false,
        vertical = true,
        texture = "teambubble.png".."^[brighten".."^[multiply:"..color,
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 1},
        {
            type = "sheet_2d",
            frames_w = 1,
            frames_h = 20,
            frame_length = 1,
        },
        glow = 2
    })
end

gav.u.pret_au_chaud = function(pos, color)
    local color = color or ""
    minetest.add_particlespawner({
        amount = 6,
        time = 1,
        minpos = {x=pos.x-0.1, y=pos.y + 0.5, z=pos.z-0.1},
        maxpos = {x=pos.x+0.1, y=pos.y + 0.5, z=pos.z+0.1},
        minvel = {x=0, y=0.2, z=0},
        maxvel = {x=0, y=0.4, z=0},
        minacc = {x=0, y=0, z=0},
        maxacc = {x=0, y=1, z=0},
        minexptime = 1.2,
        maxexptime = 2.4,
        minsize = 1,
        maxsize = 1.6,

        collisiondetection = false,
        collision_removal = false,
        vertical = true,
        texture = "smokin.png".."^[brighten".."^[multiply:"..color,
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 1},
        {
            type = "sheet_2d",
            frames_w = 1,
            frames_h = 29,
            frame_length = 1,
        },
        glow = 2
    })
end