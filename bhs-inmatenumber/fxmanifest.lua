fx_version "cerulean";
game "gta5";
lua54 "yes";

shared_scripts {
"@ox_lib/init.lua",
"config.lua"
}

server_scripts{
    "oxmysql/lib/MySQL.lua",
    "server.lua"
}

client_script "client.lua"

dependencies{
    'oxmysql',
    'ox_lib'
}