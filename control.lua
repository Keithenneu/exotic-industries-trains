if script.active_mods["gvv"] then require("__gvv__.gvv")() end

--====================================================================================================
--REQUIREMENTS
--====================================================================================================

local ei_charger = require("scripts/charger")

ei_informatron = require("scripts/informatron")

--====================================================================================================
--EVENTS
--====================================================================================================

--ENTITY RELATED
------------------------------------------------------------------------------------------------------

script.on_event({
    defines.events.on_built_entity,
    defines.events.on_robot_built_entity,
    defines.events.script_raised_built,
    defines.events.script_raised_revive,
    --defines.events.on_entity_cloned
    }, function(e)
    on_built_entity(e)
end)


script.on_event({
    defines.events.on_entity_died,
	defines.events.on_pre_player_mined_item,
	defines.events.on_robot_pre_mined,
	defines.events.script_raised_destroy
    }, function(e)
    on_destroyed_entity(e)
end)


--UPDATER
------------------------------------------------------------------------------------------------------

script.on_event(defines.events.on_tick, function() 
    updater()
end)


--GUI RELATED
------------------------------------------------------------------------------------------------------

--====================================================================================================
--HANDLERS
--====================================================================================================

function updater()

    for i=0, settings.startup["ei_trains_max_updates_per_tick"].value do
        ei_charger.updater()
    end

end


function on_built_entity(e)
    if not e["created_entity"] and e["entity"] then
        e["created_entity"] = e["entity"]
    end

    if not e["created_entity"] then
        return
    end

    ei_charger.on_built_entity(e["created_entity"])

end


function on_destroyed_entity(e)
    if not e["entity"] then
        return
    end

    ei_charger.on_destroyed_entity(e["entity"])

end

-- stuff https://github.com/magu5026/ElectricTrain/blob/master/control.lua#L22