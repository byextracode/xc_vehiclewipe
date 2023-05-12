fx_version "cerulean"
lua54 "yes"
game "gta5"

name "xc_vehiclewipe"
version "1.0.0"
description "Periodically wipes vehicles on server"
author "wibowo#7184"

shared_scripts {
    "@ox_lib/init.lua"
}

shared_script "config.lua"
client_script "**/cl_*.lua"
server_script "**/sv_*.lua"

dependencies {
    "ox_lib",
    "mythic_notify"
}