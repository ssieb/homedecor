-- Various kinds of shingles

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
	use_texture_alpha = true,
	walkable = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 }
	}
})

minetest.register_node('homedecor:skylight_frosted', {
	description = S("Frosted Glass Skylight"),
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

-- Corner shingle nodes, courtesy Bas080

homedecor_detail_level = 256

homedecor_register_outer_corner = function(modname, subname, groups, images, description)
	local slopeboxedge = {}
	local detail = homedecor_detail_level
	for i = 0, detail-1 do
		slopeboxedge[i+1]={-0.5, -0.5+(4/detail), (i/detail)-0.5, 0.5-(i/detail), (i/detail)-0.5+(5/detail), 0.5}
	end
	minetest.register_node(modname..":shingle_outer_corner_" .. subname, {
		description = S(description.. " (outer corner)"),
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
				{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
				{-0.5,     0,     0,     0,  0.25, 0.5},
				{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5},
			}
		},
		node_box = {
			type = "fixed",
			fixed = slopeboxedge,
		},
		groups = groups,
	})
end

homedecor_register_inner_corner = function(modname, subname, groups, images, description)
	local slopeboxedge = {}
	local detail = homedecor_detail_level
	for i = 0, detail-1 do
		slopeboxedge[i+1]={-0.5, -0.5+(4/detail), -0.5, 0.5-(i/detail), (i/detail)-0.5+(5/detail), 0.5}
		slopeboxedge[i+detail+1]={-0.5, -0.5+(4/detail), (i/detail)-0.5, 0.5, (i/detail)-0.5+(5/detail), 0.5}
	end
	minetest.register_node(modname..":shingle_inner_corner_" .. subname, {
		description = S(description.. " (inner corner)"),
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
		node_box = {
			type = "fixed",
			fixed = slopeboxedge,
		},
		groups = groups,
	})
end

homedecor_register_slope = function(modname, subname, recipeitem, groups, images, description)
	local slopeboxedge = {}
	local detail = homedecor_detail_level
	for i = 0, detail-1 do
		slopeboxedge[i+1]={-0.5, -0.5+(4/detail), (i/detail)-0.5, 0.5, (i/detail)-0.5+(5/detail), 0.5}
	end
	minetest.register_node(modname..":shingle_side_" .. subname, {
		description = S(description),
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
				{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
				{-0.5,     0,     0, 0.5,  0.25, 0.5},
				{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5},
			}
		},
		node_box = {
			type = "fixed",
			fixed = slopeboxedge,
		},
		groups = groups,
	})

	minetest.register_craft({
		output = modname..':shingle_outer_corner_'..subname..' 2',
		recipe = {
			{recipeitem, recipeitem},    
		},
	})

	minetest.register_craft({
		output = modname..':shingle_inner_corner_'..subname..' 3',
		recipe = {
			{recipeitem, ""},
			{recipeitem, recipeitem},    
		},
	})

	minetest.register_craft({
		output = modname..':shingles_'..subname..' 3',
		recipe = {
			{recipeitem, recipeitem, recipeitem},    
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe = { modname..':shingle_outer_corner_'..subname }
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem,
		recipe = { modname..':shingle_inner_corner_'..subname }
	})
end


minetest.register_craft( {
        output = 'homedecor:shingle_side_asphalt 6',
        recipe = {
                { 'default:dirt', 'group:dye,basecolor_black', 'default:dirt' },
                { 'default:sand', 'group:dye,basecolor_black', 'default:sand' },
                { 'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting' },
        },
	replacements = {
			{'unifieddyes:black', 'vessels:glass_bottle'},
			{'unifieddyes:black', 'vessels:glass_bottle'},
	}
})

minetest.register_craft( {
        output = 'homedecor:shingle_side_asphalt 6',
        recipe = {
                { 'default:dirt', 'default:coal_lump', 'default:dirt' },
                { 'default:sand', 'default:coal_lump', 'default:sand' },
                { 'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting', 'homedecor:plastic_sheeting' },
        },
})

minetest.register_craft( {
        output = 'homedecor:shingle_side_wood 12',
        recipe = {
                { 'default:stick', 'default:wood'},
                { 'default:wood', 'default:stick'},
        },
})

minetest.register_craft( {
        output = 'homedecor:shingle_side_wood 12',
        recipe = {
                { 'default:wood', 'default:stick'},
                { 'default:stick', 'default:wood'},
        },
})

minetest.register_craft({
        type = 'fuel',
        recipe = 'homedecor:shingle_side_wood',
        burntime = 30,
})

minetest.register_craft( {
        output = 'homedecor:shingle_side_terracotta',
        recipe = {
                { 'homedecor:roof_tile_terracotta', 'homedecor:roof_tile_terracotta'},
                { 'homedecor:roof_tile_terracotta', 'homedecor:roof_tile_terracotta'},
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = 'homedecor:roof_tile_terracotta 4',
        recipe = { 'homedecor:shingle_side_terracotta' },
})


minetest.register_craft( {
        output = 'homedecor:skylight 9',
        recipe = { 
		{ 'default:glass', 'default:glass' },
		{ 'default:glass', 'default:glass' },
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = 'homedecor:skylight_frosted',
        recipe = { "homedecor:skylight" }
})

minetest.register_craft( {
	type = "shapeless",
        output = 'homedecor:skylight',
        recipe = { "homedecor:skylight_frosted" }
})

homedecor_register_roof = function(modname, subname, groups, images , description)
	homedecor_register_outer_corner(modname, subname, groups, images, description)
	homedecor_register_inner_corner(modname, subname, groups, images, description)
end

-- corners

homedecor_register_roof("homedecor", "wood", 
	{ snappy = 3 }, 
	{
		"homedecor_shingles_wood_c_t.png",
		"homedecor_shingles_wood_c_x.png",
		"homedecor_shingles_wood_c_x.png",
		"homedecor_shingles_wood_c_x.png",
		"homedecor_shingles_wood_c_z.png",
		"homedecor_shingles_wood_c_z.png",
	}, 
	"Wood Shingles"
)

homedecor_register_roof("homedecor", "asphalt", 
	{ snappy = 3 }, 
	{
		"homedecor_shingles_asphalt_c_t.png",
		"homedecor_shingles_asphalt_c_x.png",
		"homedecor_shingles_asphalt_c_x.png",
		"homedecor_shingles_asphalt_c_x.png",
		"homedecor_shingles_asphalt_c_z.png",
		"homedecor_shingles_asphalt_c_z.png",
	}, 
	"Asphalt Shingles"
)

homedecor_register_roof("homedecor", "terracotta", 
	{ snappy = 3 }, 
	{
		"homedecor_shingles_terracotta_c_t.png",
		"homedecor_shingles_terracotta_c_x.png",
		"homedecor_shingles_terracotta_c_x.png",
		"homedecor_shingles_terracotta_c_x.png",
		"homedecor_shingles_terracotta_c_z.png",
		"homedecor_shingles_terracotta_c_z.png",
	},
	"Terracotta Shingles"
)

-- slopes

homedecor_register_slope("homedecor", "wood", 
	"homedecor:shingle_side_wood", 
	{ snappy = 3 }, 
	{
		"homedecor_shingles_wood_s_t.png",
		"homedecor_shingles_wood_s_z.png",
		"homedecor_shingles_wood_s_z.png",
		"homedecor_shingles_wood_s_z.png",
		"homedecor_shingles_wood_s_z.png",
		"homedecor_shingles_wood_s_z.png",
	}, 
	"Wood Shingles"
)

homedecor_register_slope("homedecor", "asphalt", 
	"homedecor:shingle_side_asphalt", 
	{ snappy = 3 }, 
	{
		"homedecor_shingles_asphalt_s_t.png",
		"homedecor_shingles_asphalt_s_z.png",
		"homedecor_shingles_asphalt_s_z.png",
		"homedecor_shingles_asphalt_s_z.png",
		"homedecor_shingles_asphalt_s_z.png",
		"homedecor_shingles_asphalt_s_z.png",
	}, 
	"Asphalt Shingles"
)

homedecor_register_slope("homedecor", "terracotta", 
	"homedecor:shingle_side_terracotta", 
	{ snappy = 3 }, 
	{
		"homedecor_shingles_terracotta_s_t.png",
		"homedecor_shingles_terracotta_s_z.png",
		"homedecor_shingles_terracotta_s_z.png",
		"homedecor_shingles_terracotta_s_z.png",
		"homedecor_shingles_terracotta_s_z.png",
		"homedecor_shingles_terracotta_s_z.png",
	},
	"Terracotta Shingles"
)

-- Legacy nodes

minetest.register_node('homedecor:shingles_wood', {
	description = S("Wood Shingles (flat)"),
	drawtype = 'raillike',
	tiles = { 'homedecor_shingles_wood_s_t.png' },
	wield_image = "homedecor_shingles_wood_s_t.png",
	inventory_image = "homedecor_shingles_wood_inv.png",
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
	description = S("Asphalt Shingles (flat)"),
	drawtype = 'raillike',
	tiles = { 'homedecor_shingles_asphalt_s_t.png' },
	wield_image = "homedecor_shingles_asphalt_s_t.png",
	inventory_image = "homedecor_shingles_asphalt_inv.png",
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
	description = S("Terracotta Roofing (flat)"),
	drawtype = 'raillike',
	tiles = { 'homedecor_shingles_terracotta_s_t.png' },
	wield_image = "homedecor_shingles_terracotta_s_t.png",
	inventory_image = "homedecor_shingles_terracotta_inv.png",
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

minetest.register_craft( {
	type = "shapeless",
        output = 'homedecor:shingle_side_terracotta',
        recipe = { 'homedecor:shingles_terracotta' },
})

minetest.register_craft( {
	type = "shapeless",
        output = 'homedecor:shingle_side_asphalt',
        recipe = { 'homedecor:shingles_asphalt' },
})

minetest.register_craft( {
	type = "shapeless",
        output = 'homedecor:shingle_side_wood',
        recipe = { 'homedecor:shingles_wood' },
})


