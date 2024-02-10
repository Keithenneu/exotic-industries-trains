local mod_gui = require("mod-gui")
local model = {}

--====================================================================================================
--MAIN
--====================================================================================================

--MOD GUI
------------------------------------------------------------------------------------------------------

function model.make_mod_button(player)

    ei_charger.check_global()

    -- if button already exists, return
    if mod_gui.get_button_flow(player)["ei_emt_button"] then
        return
    end

    local button = mod_gui.get_button_flow(player).add{
        type = "sprite-button",
        name = "ei_emt_button",
        sprite = "ei_emt-logo",
        style = mod_gui.button_style,
        tags = {
            action = "open_mod_gui",
            parent_gui = "mod_gui"
        }
    }

end


function model.open_mod_gui(player)
    if player.gui.left["ei_mod-gui"] then
        player.gui.left["ei_mod-gui"].destroy()
        return
    end

    local left_gui = player.gui.left

    local root = left_gui.add{
        type = "frame",
        name = "ei_mod-gui",
        direction = "vertical"
    }

    local main_container = root.add{
        type = "frame",
        name = "main-container",
        direction = "vertical",
        style = "inside_shallow_frame"
    }

    do -- Chargers
        main_container.add{
            type = "frame",
            style = "ei_subheader_frame",
        }.add{
            type = "label",
            caption = {"exotic-industries-emt.mod-gui-chargers-title"},
            style = "subheader_caption_label",
        }

        local chargers_flow = main_container.add{
            type = "flow",
            name = "chargers-flow",
            direction = "vertical",
            style = "ei_inner_content_flow",
        }

        -- toggle buton
        local toggle_flow = chargers_flow.add{
            type = "flow",
            name = "toggle-flow",
            direction = "horizontal",
        }

        toggle_flow.add{
            type = "label",
            caption = {"exotic-industries-emt.mod-gui-chargers-toggle"},
        }

        local toggle_button_frame = toggle_flow.add{
            type = "frame",
            name = "toggle-button-frame",
            style = "slot_button_deep_frame"
        }

        toggle_button_frame.add{
            type = "sprite-button",
            name = "toggle-button",
            sprite = "ei_emt-range",
            tags = {
                action = "toggle_range_highlight",
                parent_gui = "ei_mod-gui"
            }
        }

    end

    do -- Trains
        main_container.add{
            type = "frame",
            style = "ei_subheader_frame",
        }.add{
            type = "label",
            caption = {"exotic-industries-emt.mod-gui-trains-title"},
            style = "subheader_caption_label",
        }

        local trains_flow = main_container.add{
            type = "flow",
            name = "trains-flow",
            direction = "vertical",
            style = "ei_inner_content_flow",
        }

        -- stats
        trains_flow.add{
            type = "label",
            name = "total-chargers-label",
            caption = {"exotic-industries-emt.total-chargers", 0},
            tooltip = {"exotic-industries-emt.total-chargers-tooltip"},
        }

        trains_flow.add{
            type = "label",
            name = "total-rails-label",
            caption = {"exotic-industries-emt.total-rails", 0},
            tooltip = {"exotic-industries-emt.total-rails-tooltip"},
        }

    end

    do -- Stats
        main_container.add{
            type = "frame",
            style = "ei_subheader_frame",
        }.add{
            type = "label",
            caption = {"exotic-industries-emt.mod-gui-stats-title"},
            style = "subheader_caption_label",
        }

        local stats_flow = main_container.add{
            type = "flow",
            name = "stats-flow",
            direction = "vertical",
            style = "ei_inner_content_flow",
        }

        -- stats
        stats_flow.add{
            type = "label",
            name = "charger-efficiency-label",
            caption = {"exotic-industries-emt.charger-efficiency", 0},
            tooltip = {"exotic-industries-emt.charger-efficiency-tooltip"},
        }

        stats_flow.add{
            type = "label",
            name = "acc-level-label",
            caption = {"exotic-industries-emt.acc-level", 0},
            tooltip = {"exotic-industries-emt.acc-level-tooltip"},
        }

        stats_flow.add{
            type = "label",
            name = "speed-level-label",
            caption = {"exotic-industries-emt.speed-level", 0},
            tooltip = {"exotic-industries-emt.speed-level-tooltip"},
        }

    end

end

--HANDLERS
------------------------------------------------------------------------------------------------------

function model.updater()

    if not global.ei_emt.gui.dirty then
        return
    end

    for _, player in pairs(game.players) do
        model.make_mod_button(player)
    end

    global.ei_emt.gui.dirty = false

end


function model.mark_dirty()

    ei_charger.check_global()

    global.ei_emt.gui.dirty = true

end


function model.on_gui_click(event)
    
    --[[
    if event.element.tags.action == "goto-informatron" then
        if game.forces["player"].technologies["ei_gate"].enabled == true then
            remote.call("informatron", "informatron_open_to_page", {
                player_index = event.player_index,
                interface = "exotic-industries-informatron",
                page_name = event.element.tags.page
            })
            return
        end
    end
    ]]

    if event.element.tags.action == "open_mod_gui" then
        model.open_mod_gui(game.get_player(event.player_index))
        return
    end

    if event.element.tags.action == "toggle_range_highlight" then
        ei_charger.toggle_range_highlight(game.get_player(event.player_index))
        return
    end
end


return model

