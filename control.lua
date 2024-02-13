if script.active_mods["gvv"] then require("__gvv__.gvv")() end

--====================================================================================================
--REQUIREMENTS
--====================================================================================================

ei_charger = require("scripts/charger")
ei_gui = require("scripts/gui")

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


script.on_event(defines.events.on_research_finished, function(e)
    ei_charger.on_research_finished(e)
end)


--UPDATER
------------------------------------------------------------------------------------------------------

script.on_event(defines.events.on_tick, function() 
    updater()
end)


--GUI RELATED
------------------------------------------------------------------------------------------------------

-- player created or when loading a save
--[[
script.on_event(defines.events.on_player_created, function(e)
    ei_gui.mark_dirty()
end)

script.on_event(defines.events.on_player_joined_game, function(e)
    ei_gui.mark_dirty()
end)

script.on_event(defines.events.on_player_respawned, function(e)
    ei_gui.mark_dirty()
end)
]]

script.on_configuration_changed(function(e)
    ei_gui.mark_dirty()
end)

script.on_init(function(e)
    ei_gui.mark_dirty()
end)

script.on_event(defines.events.on_gui_click, function(event)
    local parent_gui = event.element.tags.parent_gui
    if not parent_gui then return end

    if parent_gui == "mod_gui" then
        ei_gui.on_gui_click(event)
    elseif parent_gui == "ei_mod-gui" then
        ei_gui.on_gui_click(event)
    end


end)


--====================================================================================================
--HANDLERS
--====================================================================================================

function updater()

    for i=0, settings.startup["ei_trains_max_updates_per_tick"].value do
        ei_charger.updater()
        ei_gui.updater()
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