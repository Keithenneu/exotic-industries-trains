ei_trains_lib = require("lib/lib-data")

--====================================================================================================
--ITEMS
--====================================================================================================

data:extend({
    {
        name = "ei_em-locomotive-temp",
        type = "item",
        icon = ei_trains_item_path.."em-locomotive-temp.png",
        icon_size = 64,
        subgroup = "transport",
        order = "x1",
        place_result = "ei_em-locomotive-temp",
        stack_size = 50
    },
	{
        name = "ei_em-wagon-temp",
        type = "item",
        icon = ei_trains_item_path.."em-wagon-temp.png",
        icon_size = 64,
        subgroup = "transport",
        order = "x3",
        place_result = "ei_em-wagon-temp",
        stack_size = 50
    },
	{
        name = "ei_em-cargo-wagon",
        type = "item",
        icon = ei_trains_item_path.."em-cargo-wagon.png",
        icon_size = 64,
        subgroup = "transport",
        order = "x2",
        place_result = "ei_em-cargo-wagon",
        stack_size = 50
    },
})

--====================================================================================================
--RECIPES
--====================================================================================================

data:extend({
    {
        name = "ei_em-locomotive-temp",
        type = "recipe",
        category = "crafting",
        energy_required = 1,
        ingredients = {},
        result = "ei_em-locomotive-temp",
        result_count = 1,
        enabled = true,
        always_show_made_in = true,
        main_product = "ei_em-locomotive-temp",
    },
	{
        name = "ei_em-wagon-temp",
        type = "recipe",
        category = "crafting",
        energy_required = 1,
        ingredients = {},
        result = "ei_em-wagon-temp",
        result_count = 1,
        enabled = true,
        always_show_made_in = true,
        main_product = "ei_em-wagon-temp",
    },
	{
        name = "ei_em-cargo-wagon",
        type = "recipe",
        category = "crafting",
        energy_required = 1,
        ingredients = {},
        result = "ei_em-cargo-wagon",
        result_count = 1,
        enabled = true,
        always_show_made_in = true,
        main_product = "ei_em-cargo-wagon",
    },
})

--====================================================================================================
--TECHS
--====================================================================================================

--[[
data:extend({
    {
        name = "ei_advanced-port",
        type = "technology",
        icon = ei_robots_tech_path.."advanced-port.png",
        icon_size = 256,
        prerequisites = {"space-science-pack"},
        effects = {
            {
                type = "unlock-recipe",
                recipe = "ei_advanced-port"
            },
        },
        unit = {
            count = 600,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"utility-science-pack", 1},
                {"space-science-pack", 1},
                {"production-science-pack", 1},
            },
            time = 60
        },
        age = "quantum-age",
    },
})
]]

--====================================================================================================
--ENTITIES
--====================================================================================================

data:extend({
    {
		type = "locomotive",
		name = "ei_em-locomotive-temp",
		icon = ei_trains_item_path.."em-locomotive-temp.png",
        icon_size = 64,
		flags = {"placeable-neutral", "player-creation", "placeable-off-grid", },
		minable = 
        {
            mining_time = 1,
            result = "ei_em-locomotive-temp"
        },
		mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
		max_health = 800,
		corpse = "medium-remnants",
		dying_explosion = "medium-explosion",

		collision_box = {{-0.6, -2.6}, {0.6, 2.6}},
		selection_box = {{-1, -3}, {1, 3}},
		drawing_box = {{-1, -4}, {1, 3}},
		connection_distance = 3,
        joint_distance = 4,		

		weight = 4000,
		max_speed = 0.625,
		max_power = "800kW",
		reversing_power_modifier = 0.6,
		braking_force = 8,
		friction_force = 0.003,
		-- this is a percentage of current speed that will be subtracted
		air_resistance = 0.003,
		vertical_selection_shift = -0.5,
		energy_per_hit_point = 5,
		resistances =
		{
			{type = "fire", decrease = 15, percent = 50 },
			{type = "physical", decrease = 15, percent = 30 },
			{type = "impact",decrease = 50,percent = 60},
			{type = "explosion",decrease = 15,percent = 30},
			{type = "acid",decrease = 10,percent = 20}
		},
		burner =
		{
			fuel_category = "ei_emt-fuel",
			effectivity = 1,
			fuel_inventory_size = 1,
		},		
		front_light =
		{
			{
				type = "oriented",
				minimum_darkness = 0.3,
				picture =
				{
					filename = "__core__/graphics/light-cone.png",
					priority = "medium",
					scale = 2,
					width = 200,
					height = 200
				},
				shift = {-0.6, -16},
				size = 2,
				intensity = 0.6
			},
			{
				type = "oriented",
				minimum_darkness = 0.3,
				picture =
				{
					filename = "__core__/graphics/light-cone.png",
					priority = "medium",
					scale = 2,
					width = 200,
					height = 200
				},
				shift = {0.6, -16},
				size = 2,
				intensity = 0.6
			}
		},
		--back_light = rolling_stock_back_light(),
		--stand_by_light = rolling_stock_stand_by_light(),
		
		pictures =
		{
			layers = {
				{
					priority = "very-low",
					width = 512,
					height = 512,
					direction_count = 128,
					filenames =
					{
						ei_trains_entity_path.."em-locomotive_1.png",
						ei_trains_entity_path.."em-locomotive_2.png"
					},
					line_length = 8,
					lines_per_file = 8,
		    		shift = {0, -0.5},
					scale = 0.58,
				},
				{
					priority = "very-low",
					width = 512,
					height = 512,
					direction_count = 128,
					draw_as_shadow = true,
					filenames =
					{
						ei_trains_entity_path.."em-locomotive_1_shadow.png",
						ei_trains_entity_path.."em-locomotive_2_shadow.png"
					},
					line_length = 8,
					lines_per_file = 8,
		    		shift = {0, -0.5},
					scale = 0.58,
				}
			}
		},
		minimap_representation =
		{
		  filename = "__base__/graphics/entity/diesel-locomotive/diesel-locomotive-minimap-representation.png",
		  flags = {"icon"},
		  size = {20, 40},
		  scale = 0.5
		},
		selected_minimap_representation =
		{
		  filename = "__base__/graphics/entity/diesel-locomotive/diesel-locomotive-selected-minimap-representation.png",
		  flags = {"icon"},
		  size = {20, 40},
		  scale = 0.5
		},
  
		wheels = standard_train_wheels,
		rail_category = "regular",

		stop_trigger =
		{
			-- left side
			{
				type = "create-trivial-smoke",
				repeat_count = 75,
				smoke_name = "smoke-train-stop",
				initial_height = 0,
				-- smoke goes to the left
				speed = {-0.03, 0},
				speed_multiplier = 0.75,
				speed_multiplier_deviation = 1.1,
				offset_deviation = {{-0.75, -2.7}, {-0.3, 2.7}}
			},
			-- right side
			{
				type = "create-trivial-smoke",
				repeat_count = 75,
				smoke_name = "smoke-train-stop",
				initial_height = 0,
				-- smoke goes to the right
				speed = {0.03, 0},
				speed_multiplier = 0.75,
				speed_multiplier_deviation = 1.1,
				offset_deviation = {{0.3, -2.7}, {0.75, 2.7}}
			},
			{
				type = "play-sound",
				sound =
				{
					{
						filename = "__base__/sound/train-breaks.ogg",
						volume = 0.6
					},
				}
			},
		},
		drive_over_tie_trigger = drive_over_tie(),
		tie_distance = 50,
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
		working_sound =
		{
			sound =
			{
				filename = "__base__/sound/steam-engine-90bpm.ogg",
				volume = 0.8
			},
			match_speed_to_activity = true,
		},
		open_sound = { filename = "__base__/sound/car-door-open.ogg", volume=0.7 },
		close_sound = { filename = "__base__/sound/car-door-close.ogg", volume = 0.7 },
		sound_minimum_speed = 0.2;
	},
	{
		type = "cargo-wagon",
		name = "ei_em-wagon-temp",
		icon = ei_trains_item_path.."em-wagon-temp.png",
        icon_size = 64,
		flags = {"placeable-neutral", "player-creation", "placeable-off-grid", },
		inventory_size = 20,
		minable = {
            mining_time = 1,
            result = "ei_em-wagon-temp"
        },
		mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
		max_health = 600,
		corpse = "medium-remnants",
		dying_explosion = "medium-explosion",
		
		collision_box = {{-0.6, -2.4}, {0.6, 2.4}},
		selection_box = {{-1.0, -2.7}, {1, 3.3}},		
		connection_distance = 3, joint_distance = 4,
		
		weight = 1000,
		max_speed = 1.2,
		braking_force = 2,
		friction_force = 0.0015,
		air_resistance = 0.002,
		energy_per_hit_point = 5,    
		resistances =
		{
			{type = "fire", decrease = 15, percent = 50 },
			{type = "physical", decrease = 15, percent = 30 },
			{type = "impact",decrease = 50,percent = 60},
			{type = "explosion",decrease = 15,percent = 30},
			{type = "acid",decrease = 10,percent = 20}
		},
		vertical_selection_shift = -0.8,
		--back_light = rolling_stock_back_light(),
		--stand_by_light = rolling_stock_stand_by_light(),
		pictures =
		{
			layers = {
				{
					priority = "very-low",
					width = 512,
					height = 512,
					direction_count = 128,
					filenames =
					{
						ei_trains_entity_path.."em-wagon_1.png",
						ei_trains_entity_path.."em-wagon_2.png"
					},
					line_length = 8,
					lines_per_file = 8,
		    		shift = {0, -0.5},
					scale = 0.58,
				},
				{
					priority = "very-low",
					width = 512,
					height = 512,
					direction_count = 128,
					draw_as_shadow = true,
					filenames =
					{
						ei_trains_entity_path.."em-wagon_1_shadow.png",
						ei_trains_entity_path.."em-wagon_2_shadow.png"
					},
					line_length = 8,
					lines_per_file = 8,
		    		shift = {0, -0.5},
					scale = 0.58,
				}
			}
		},
		minimap_representation = {
			filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-minimap-representation.png",
			flags = {"icon"},
			size = {20, 40},
			scale = 0.5
		},
		selected_minimap_representation = {
			filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-selected-minimap-representation.png",
			flags = {"icon"},
			size = {20, 40},
			scale = 0.5
		},

		wheels = standard_train_wheels,
		rail_category = "regular",
		drive_over_tie_trigger = drive_over_tie(),
		tie_distance = 50,
		working_sound =
		{
			sound =
			{
				filename = "__base__/sound/train-wheels.ogg",
				volume = 0.5
			},
			match_volume_to_activity = true,
		},
		crash_trigger = crash_trigger(),
		open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
		close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
		sound_minimum_speed = 0.5;
		vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
	},
	{
		type = "cargo-wagon",
		name = "ei_em-cargo-wagon",
		icon = ei_trains_item_path.."em-cargo-wagon.png",
        icon_size = 64,
		flags = {"placeable-neutral", "player-creation", "placeable-off-grid", },
		inventory_size = 20,
		minable = {
            mining_time = 1,
            result = "ei_em-cargo-wagon"
        },
		mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
		max_health = 600,
		corpse = "medium-remnants",
		dying_explosion = "medium-explosion",
		
		collision_box = {{-0.6, -2.4}, {0.6, 2.4}},
		selection_box = {{-1.0, -2.7}, {1, 3.3}},		
		connection_distance = 3, joint_distance = 4,
		
		weight = 1000,
		max_speed = 1.2,
		braking_force = 2,
		friction_force = 0.0015,
		air_resistance = 0.002,
		energy_per_hit_point = 5,    
		resistances =
		{
			{type = "fire", decrease = 15, percent = 50 },
			{type = "physical", decrease = 15, percent = 30 },
			{type = "impact",decrease = 50,percent = 60},
			{type = "explosion",decrease = 15,percent = 30},
			{type = "acid",decrease = 10,percent = 20}
		},
		vertical_selection_shift = -0.8,
		--back_light = rolling_stock_back_light(),
		--stand_by_light = rolling_stock_stand_by_light(),
		pictures =
		{
			layers = {
				{
					priority = "very-low",
					width = 512,
					height = 512,
					direction_count = 128,
					filenames =
					{
						ei_trains_entity_path.."em-cargo-wagon_1.png",
						ei_trains_entity_path.."em-cargo-wagon_2.png"
					},
					line_length = 8,
					lines_per_file = 8,
		    		shift = {0, -0.5},
					scale = 0.58,
				},
				{
					priority = "very-low",
					width = 512,
					height = 512,
					direction_count = 128,
					draw_as_shadow = true,
					filenames =
					{
						ei_trains_entity_path.."em-wagon_1_shadow.png",
						ei_trains_entity_path.."em-wagon_2_shadow.png"
					},
					line_length = 8,
					lines_per_file = 8,
		    		shift = {0, -0.5},
					scale = 0.58,
				}
			}
		},
		minimap_representation = {
			filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-minimap-representation.png",
			flags = {"icon"},
			size = {20, 40},
			scale = 0.5
		},
		selected_minimap_representation = {
			filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-selected-minimap-representation.png",
			flags = {"icon"},
			size = {20, 40},
			scale = 0.5
		},

		wheels = standard_train_wheels,
		rail_category = "regular",
		drive_over_tie_trigger = drive_over_tie(),
		tie_distance = 50,
		working_sound =
		{
			sound =
			{
				filename = "__base__/sound/train-wheels.ogg",
				volume = 0.5
			},
			match_volume_to_activity = true,
		},
		crash_trigger = crash_trigger(),
		open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
		close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
		sound_minimum_speed = 0.5;
		vehicle_impact_sound =  { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
	},
})

--====================================================================================================
--OTHER
--====================================================================================================

data:extend({
	{
		type = "fuel-category",
		name = "ei_emt-fuel"
	},
})

local foo = {
	type = "item",
	name = "ei_emt-fuel_0_0",
	icon = ei_trains_item_path.."dummy.png",
	icon_size = 64,
	stack_size = 1,
	fuel_category = "ei_emt-fuel",
	flags = {"hidden"},
	fuel_value = "1MJ",
	fuel_acceleration_multiplier = 1,
	fuel_top_speed_multiplier = 1,
}

for i=0,20 do
	for j=0,20 do
		local bar = table.deepcopy(foo)
		bar.name = "ei_emt-fuel_"..i.."_"..j
		bar.fuel_acceleration_multiplier = 1 + (0.1*i)
		bar.fuel_top_speed_multiplier = 1 + (0.1*j)
		data:extend({bar})
	end
end