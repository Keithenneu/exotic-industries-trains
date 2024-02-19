-- retrun if exotic industries is not present
if not mods["exotic-industries"] then return end

ei_trains_lib = require("lib/lib-data")

--====================================================================================================
--TRAIN CHANGES
--====================================================================================================

-- additional tech prerequisits
data.raw.technology["ei_em-trains"].prerequisites = {"ei_clean-plating", "energy-shield-mk2-equipment", "fluid-wagon", "ei_copper-beacon"}

-- recipe changes
data.raw.recipe["ei_em-locomotive"].ingredients = {
    {"locomotive", 1},
	{"ei_carbon-structure", 25},
	{"ei_clean-plating", 25},
	{"ei_advanced-motor", 20},
	{"ei_em-fielder", 14},
}

data.raw.recipe["ei_em-cargo-wagon"].ingredients = {
    {"cargo-wagon", 1},
	{"ei_carbon-structure", 15},
	{"ei_clean-plating", 15},
	{"ei_em-fielder", 8},
}

data.raw.recipe["ei_em-fluid-wagon"].ingredients = {
    {"fluid-wagon", 1},
	{"ei_carbon-structure", 15},
	{"ei_clean-plating", 15},
	{"ei_em-fielder", 8},
}

data.raw.recipe["ei_em-fielder"].ingredients = {
    {"energy-shield-mk2-equipment", 1},
    {"ei_eu-magnet", 2},
    {"ei_superior-data", 6},
}

data.raw.recipe["ei_charger"].ingredients = {
    {"ei_copper-beacon", 6},
    {"processing-unit", 25},
    {"ei_em-fielder", 2},
}