Config  = {}

Config.versionCheck = true -- check for updates

Config.commandname = "vehiclewipe"
Config.Locale = "en"

Config.period = {
    {
        h = 0,
        m = 0,
    },
    {
        h = 6,
        m = 0,
    },
    {
        h = 12,
        m = 0,
    },
    {
        h = 18,
        m = 45,
    },
}

Config.translation = {
    ["en"] = {
        ["notify_alert"] = "Vehicle wipes occurs in %s seconds",
        ["notify_alert_soon"] = "Vehicle wipes occurs very soon !!!",
        ["wiped_vehicle"] = "%s vehicles have been wiped"
    }
}