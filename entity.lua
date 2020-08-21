local turret_test =
{
    hp_max = 10000,
    physical = true,
    pointable = true,
    collide_with_objects = true,
    collisionbox = {-0.3, -0.05, -0.3, 0.3, 0.05, 0.3},
    visual = "mesh",
    mesh = "pedestal.obj",
    visual_size = {x = 6, y = 6},
    textures = {"tsukuru.png"},
    is_visible = true,
    automatic_rotate = 0,
    automatic_face_movement_dir = false,
    automatic_face_movement_max_rotation_per_sec = 0,
    glow = 0,
    backface_culling = false,
    static_save = false,
    on_activate= function(self, dtime)
        local obj = self.object
    end,
}
minetest.register_entity(modn..":pawn",turret_test)


