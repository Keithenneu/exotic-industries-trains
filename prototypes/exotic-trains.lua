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
    {type="item", name="locomotive", amount=1},
	{type="item", name="ei_carbon-structure", amount=25},
	{type="item", name="ei_clean-plating", amount=25},
	{type="item", name="ei_advanced-motor", amount=20},
	{type="item", name="ei_em-fielder", amount=14},
}

data.raw.recipe["ei_em-cargo-wagon"].ingredients = {
    {type="item", name="cargo-wagon", amount=1},
	{type="item", name="ei_carbon-structure", amount=15},
	{type="item", name="ei_clean-plating", amount=15},
	{type="item", name="ei_em-fielder", amount=8},
}

data.raw.recipe["ei_em-fluid-wagon"].ingredients = {
    {type="item", name="fluid-wagon", amount=1},
	{type="item", name="ei_carbon-structure", amount=15},
	{type="item", name="ei_clean-plating", amount=15},
	{type="item", name="ei_em-fielder", amount=8},
}

data.raw.recipe["ei_em-fielder"].ingredients = {
    {type="item", name="energy-shield-mk2-equipment", amount=1},
    {type="item", name="ei_eu-magnet", amount=2},
    {type="item", name="ei_superior-data", amount=6},
}

data.raw.recipe["ei_charger"].ingredients = {
    {type="item", name="ei_copper-beacon", amount=6},
    {type="item", name="processing-unit", amount=25},
    {type="item", name="ei_em-fielder", amount=2},
}