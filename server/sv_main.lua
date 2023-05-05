local time = 0
local savedvehicles = {}
local collecting = false

local function wipes(num)
    savedvehicles = {}
    collecting = true
    time = (tonumber(num) or 5) * 60
    local iterate = time
    for i = 1, iterate do
        TriggerClientEvent("xc_vehiclewipe:status", -1, collecting, time/60)
        Wait(1000)
        time -= 1
    end
    local allvehicles = GetAllVehicles()
    local count = 0
    for k, v in pairs(allvehicles) do
        local net = NetworkGetNetworkIdFromEntity(v)
        if not savedvehicles[net] then
            DeleteEntity(v)
            count += 1
        end
    end
    collecting = false
    TriggerClientEvent("xc_vehiclewipe:status", -1, collecting, time/60)
    Wait(5000)
    print(labelText("wiped_vehicle", count))
    TriggerClientEvent("mythic_notify:client:SendAlert", -1, {type = "inform", text = labelText("wiped_vehicle", count), length = 10000})
end

lib.callback.register("xc_vehiclewipe:status", function(source)
    return collecting, time
end)

RegisterNetEvent("xc_vehiclewipe:collect", function(net)
    if savedvehicles[net] then
        return
    end
    savedvehicles[net] = true
end)

RegisterCommand(Config.commandname, function(source, args, raw)
    if collecting then
        return
    end
    wipes(args[1])
end, true)

for i = 1, #Config.period do
    local h = Config.period[i].h-1
    local m = Config.period[i].m+55
    if m >= 60 then
        h += 1
        m -= 60
    end
    lib.cron.new(("%s %s * * *"):format(m, h), wipes)
end