local function add_crosshair(player)
    return player:hud_add({
        hud_elem_type = "image",
        position = {x = 0.5, y = 0.5},
        scale = {x = 1, y = 1},
        text = "mobile_crosshair.png",
    })
end

minetest.register_on_joinplayer(function(player)
    local meta = player:get_meta()
    local crosshair = tonumber(meta:get("mobile_crosshair"))
    if minetest.is_singleplayer() or crosshair then
        meta:set_int("mobile_crosshair", add_crosshair(player))
    end
end)

minetest.register_chatcommand("crosshair", {
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player then
            local meta = player:get_meta()
            local crosshair = tonumber(meta:get("mobile_crosshair"))
            if crosshair then
                player:hud_remove(crosshair)
                meta:set_string("mobile_crosshair", "")
            else
                meta:set_int("mobile_crosshair", add_crosshair(player))
            end
        end
    end
})
