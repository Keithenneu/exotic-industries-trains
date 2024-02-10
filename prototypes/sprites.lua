data:extend({
    {
        name = "ei_emt-logo",
        type = "sprite",
        filename = ei_trains_tech_path.."em-locomotive-temp.png",
        size = 256,
        scale = 0.25,
    },
    {
        name = "ei_emt-range",
        type = "sprite",
        filename = ei_trains_item_path.."charging.png",
        size = 64,
    },
})

if mods["exotic-industries"] then return end

local style = data.raw["gui-style"]["default"]

style.ei_subheader_frame = {
    type = "frame_style",
    parent = "subheader_frame",
    horizontally_stretchable = "on"
}

style.ei_inner_content_flow = {
    type = "vertical_flow_style",
    padding = 12
}