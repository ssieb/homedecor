-- Various kidns of shingles

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
    dofile(minetest.get_modpath("intllib").."/intllib.lua")
    S = intllib.Getter(minetest.get_current_modname())
else
    S = function ( s ) return s end
end

minetest.register_node('homedecor:skylight', {
	description = S("Glass Skylight"),
	drawtype = 'raillike',
	tiles = { 'default_glass.png' },
	wield_image = 'default_glass.png',
	inventory_image = 'homedecor_skylight_inv.png',
	paramtype = 'light',
	sunlight_propagates = true,
	walkable = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 }
	}
})

minetest.register_node('homedecor:skylight_frosted', {
	description = S("Glass Skylight"),
	drawtype = 'raillike',
	tiles = { 'homedecor_skylight_frosted.png' },
	wield_image = 'homedecor_skylight_frosted.png',
	inventory_image = 'homedecor_skylight_frosted_inv.png',
	paramtype = 'light',
	sunlight_propagates = true,
	use_texture_alpha = true,
	walkable = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 }
	}
})

minetest.register_node('homedecor:shingles_wood', {
	description = S("Wood Shingles"),
	drawtype = 'raillike',
	tiles = { 'homedecor_shingles_wood.png' },
	wield_image = 'homedecor_shingles_wood.png',
	inventory_image = 'homedecor_shingles_wood_inv.png',
	paramtype = 'light',
	sunlight_propagates = false,
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 }
	}
})

minetest.register_node('homedecor:shingles_asphalt', {
	description = S("Asphalt Shingles"),
	drawtype = 'raillike',
	tiles = { 'homedecor_shingles_asphalt.png' },
	wield_image = 'homedecor_shingles_asphalt.png',
	inventory_image = 'homedecor_shingles_asphalt_inv.png',
	paramtype = 'light',
	sunlight_propagates = false,
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 }
	}
})

minetest.register_node('homedecor:shingles_terracotta', {
	description = S("Terracotta Roofing"),
	drawtype = 'raillike',
	tiles = { 'homedecor_shingles_terracotta.png' },
	wield_image = 'homedecor_shingles_terracotta.png',
	inventory_image = 'homedecor_shingles_terracotta_inv.png',
	paramtype = 'light',
	sunlight_propagates = false,
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
        drop = 'homedecor:roof_tile_terracotta 4',
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 }
	}
})

