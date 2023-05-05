Config  = {}

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

function labelText(text, ...)
    local library = Config.translation[Config.Locale]
    if library == nil then
        return ("Translation [%s] does not exist"):format(Config.Locale)
    end
    if library[text] == nil then
        return ("Translation [%s][%s] does not exist"):format(Config.Locale, text)
    end
    return library[text]:format(...) 
end