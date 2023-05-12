local active = false
local time = 0
local firstSpawn = true

CreateThread(function()
    while true do
        local wait = 500
        if active then
            local id = math.random(1000, 9999)
            local text = labelText("notify_alert", time)
            if time < 5 then
                text = labelText("notify_alert_soon")
            end
            exports["mythic_notify"]:PersistentAlert("start", id, "inform", text)
            Wait(wait)
            exports["mythic_notify"]:PersistentAlert("end", id)
        end
        Wait(wait)
    end
end)

AddEventHandler("playerSpawned", function()
    if not firstSpawn then
        return
    end
    firstSpawn = false
    local status, min = lib.callback.await("xc_vehiclewipe:status")
    active = status
    time = min * 60
    saved = {}
end)

RegisterNetEvent("xc_vehiclewipe:status", function(status, min)
    active = status
    time = min * 60
    saved = active and saved or {}
    if active and time < 2 then
        active = false
        time = 0
    end
end)

lib.onCache("vehicle", function(vehicle)
    local playerPed = PlayerPedId()
    if not active then
        return
    end
    if not vehicle then
        return
    end
    if not NetworkGetEntityIsNetworked(vehicle) then
        return
    end
    local net = NetworkGetNetworkIdFromEntity(vehicle)
    if saved[net] then
        return
    end
    local count = 0
    while GetVehiclePedIsIn(playerPed) == vehicle do
        count += 1
        Wait(1000)
        if count >= 3 then
            saved[net] = true
            if IsPedInVehicle(playerPed, vehicle, false) then
				PlayVehicleDoorCloseSound(vehicle, 1)
			end
			SetVehicleLights(vehicle, 2)
			Wait(150)
			SetVehicleLights(vehicle, 0)
			Wait(150)
			SetVehicleDoorsShut(vehicle, false)
            TriggerServerEvent("xc_vehiclewipe:collect", net)
            break
        end
    end
end)