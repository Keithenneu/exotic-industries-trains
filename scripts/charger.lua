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

    if not global.ei_emt.buffs then
        global.ei_emt.buffs = {
            charger_range = 32,
            acc_buff = 1,
            max_speed_buff = 1
        }
    end

end


--UPDATE
------------------------------------------------------------------------------------------------------

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

end


function model.highlight_range(charger, fade)

    fade = fade or false

    if not model.entity_check(charger) then
        return
    end

    local radius = global.ei_emt.buffs.charger_range

    if not fade then
        return rendering.draw_circle{
            color = {r = 0.1, g = 0.83, b = 0.87},
            radius = radius,
            width = 16,
            filled = false,
            target = charger,
            surface = charger.surface
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
    local segments = math.floor(radius*32 / width)

    for i=1, segments do
        local color = {
            r = 0.1 + (0.7-0.1) * (i/segments),
            g = 0.83,
            b = 0.87
        }

        rendering.draw_circle{
            color = color,
            radius = i * width,
            width = width,
            filled = false,
            target = charger,
            surface = charger.surface,
            time_to_live = 60
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
        rail_count = 0
    }

    model.update_charger(entity, true)

end


function model.unregister_charger(entity)

    model.check_global()

    local charger_id = entity.unit_number
    global.ei_emt.chargers[charger_id] = nil

end

--HANDLERS 
------------------------------------------------------------------------------------------------------

function model.updater()

    model.check_global()

end


function model.on_built_entity(entity)

    if not model.entity_check(entity) then
        return
    end

    if entity.name == "ei_charger" then
        model.register_charger(entity)
        model.highlight_range(entity, true)
    end

end


function model.on_destroyed_entity(entity)

    if not model.entity_check(entity) then
        return
    end

    if entity.name == "ei_charger" then
        model.unregister_charger(entity)
    end

end


return model