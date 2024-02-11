local model = {}

-- DOC

-- Charger gets registered when placed
-- Charger properties: Has x-tiles range, consumes energy proportional to rails in range
-- charger range can be increased by research
-- trains in range get charged with fuel that has certain acc and max speed buffs
-- those buffs can be increased by research
-- clicking on a charger shows a gui that displays the current stats and rails it charges

--====================================================================================================
--MAIN
--====================================================================================================

model.trains = {
    ["ei_em-locomotive-temp"] = true
}

--UTIL
------------------------------------------------------------------------------------------------------

function model.entity_check(entity)

    if entity == nil then
        return false
    end

    if not entity.valid then
        return false
    end

    return true
end


function model.check_global()

    if not global.ei_emt then
        global.ei_emt = {}
    end

    if not global.ei_emt.chargers then
        global.ei_emt.chargers = {}
    end

    if not global.ei_emt.trains then
        global.ei_emt.trains = {}
    end

    if not global.ei_emt.gui then
        global.ei_emt.gui = {}
    end

    if not global.ei_emt.buffs then
        global.ei_emt.buffs = {
            charger_range = 96, -- max: 512
            charger_efficiency = 0.1, -- max: 1
            
            acc_level = 0, -- max: 5
            speed_level = 0 -- max: 5
        }
    end

    -- here the power draw for each rail in charger range is calculated
    -- from ~eff*(acc_level + max_speed_level)

end


--UPDATE
------------------------------------------------------------------------------------------------------

function model.update_trains()

end


function model.update_charger_from_rail(rail, sign)

    if not model.entity_check(rail) then
        return
    end

    local radius = global.ei_emt.buffs.charger_range
    local chargers = rail.surface.find_entities_filtered({
        position = rail.position,
        radius = radius,
        name = "ei_charger"
    })

    for _, charger in ipairs(chargers) do
        -- only update rail count
        local charger_id = charger.unit_number
        global.ei_emt.chargers[charger_id].rail_count = global.ei_emt.chargers[charger_id].rail_count + sign
    end

end


function model.update_charger(charger)

    visual = visual or false -- should highlight counted rails?

    -- charger stil exists/vaild?
    if not model.entity_check(charger) then
        model.unregister_charger(charger) return
    end

    local radius = global.ei_emt.buffs.charger_range
    local rail_count = charger.surface.count_entities_filtered({
        position = charger.position,
        radius = radius,
        type = {"straight-rail", "curved-rail"}
    })

    local charger_id = charger.unit_number
    global.ei_emt.chargers[charger_id].rail_count = rail_count

end


function model.animate_range(charger, fade, player)

    fade = fade or false
    player = {player} or nil

    if not model.entity_check(charger) then
        return
    end

    local radius = global.ei_emt.buffs.charger_range

    if not fade then
        --[[
        return rendering.draw_circle{
            color = {r = 0.1, g = 0.83, b = 0.87},
            radius = radius,
            width = 8,
            filled = false,
            target = charger,
            surface = charger.surface,
            draw_on_ground = true,
        }
        ]]

        return rendering.draw_sprite{
            sprite = "ei_emt-radius_big",
            x_scale = radius / 16,
            y_scale = radius / 16,
            target = charger,
            surface = charger.surface,
            draw_on_ground = true,
            players = player
        }
    end

    --[[
    rendering.draw_circle{
        color = {r = 0.1, g = 0.83, b = 0.87},
        radius = radius+1,
        width = 8,
        filled = false,
        target = charger,
        surface = charger.surface,
        time_to_live = 60
    }
    ]]

    -- 1 tile == 32 pixels
    -- make circles with 8 pixel width, and color fade
    -- {r = 0.1, g = 0.83, b = 0.87} -> r = 0.7

    local width = 8
    local width_delta = 0
    local segments = math.floor(radius*32 / width)
    local animation_time_per_segment = 0.5

    for i=1, segments do
        local color = {
            r = 0.1 + (0.7-0.1) * (i/segments),
            g = 0.36,
            b = 0.45,
            a = 0.1
        }

        rendering.draw_circle{
            color = color,
            radius = i * width / 32,
            width = width + width_delta,
            filled = false,
            target = charger,
            surface = charger.surface,
            time_to_live = math.floor(1 + animation_time_per_segment * i),
            draw_on_ground = true,
            players = player
        }
    end

end

--REGISTER
------------------------------------------------------------------------------------------------------

function model.register_charger(entity)

    model.check_global()

    local charger_id = entity.unit_number
    global.ei_emt.chargers[charger_id] = {
        entity = entity,
        rail_count = 0,
        surface = entity.surface
    }

    model.update_charger(entity, true)

end


function model.unregister_charger(entity)

    model.check_global()

    local charger_id = entity.unit_number
    global.ei_emt.chargers[charger_id] = nil

end


function model.register_train(entity)

    model.check_global()

    local train_id = entity.unit_number
    global.ei_emt.trains[train_id] = {
        entity = entity,
        surface = entity.surface
    }

end


function model.unregister_train(entity)

    model.check_global()

    local train_id = entity.unit_number
    global.ei_emt.trains[train_id] = nil

end


--GUI RELATED
------------------------------------------------------------------------------------------------------

function model.fix_toggle_range()

    for _, player in pairs(game.players) do
        
        local player_index = player.index
        if global.ei_emt.gui[player_index] then
            model.toggle_range_highlight(player) -- remove all
            model.toggle_range_highlight(player) -- draw new
        end

    end

end


function model.toggle_range_highlight(player)

    model.check_global()

    local player_index = player.index

    if global.ei_emt.gui[player_index] then
        
        -- remove all renderings
        for key,_ in pairs(global.ei_emt.gui[player_index]) do
            rendering.destroy(key)
        end

        global.ei_emt.gui[player_index] = nil
        return
    end

    global.ei_emt.gui[player_index] = {}

    for id,charger in pairs(global.ei_emt.chargers) do
        local render_id = model.animate_range(charger.entity, false, player)
        if render_id then global.ei_emt.gui[player_index][render_id] = true end
    end

end

--HANDLERS 
------------------------------------------------------------------------------------------------------

function model.updater()

    model.check_global()
    model.update_trains()

end


function model.on_built_entity(entity)

    if not model.entity_check(entity) then
        return
    end

    if entity.name == "ei_charger" then
        model.register_charger(entity)
        model.animate_range(entity, true, nil)
        model.fix_toggle_range()
        ei_gui.mark_dirty()
    end

    if entity.name == "straight-rail" or entity.name == "curved-rail" then
        model.update_charger_from_rail(entity, 1)
        ei_gui.mark_dirty()
    end

    if model.trains[entity.name] then
        model.register_train(entity)
        ei_gui.mark_dirty()
    end

end


function model.on_destroyed_entity(entity)

    if not model.entity_check(entity) then
        return
    end

    if entity.name == "ei_charger" then
        model.unregister_charger(entity)
        ei_gui.mark_dirty()
    end

    if entity.name == "straight-rail" or entity.name == "curved-rail" then
        model.update_charger_from_rail(entity, -1)
        ei_gui.mark_dirty()
    end

    if model.trains[entity.name] then
        model.unregister_train(entity)
        ei_gui.mark_dirty()
    end

end


return model