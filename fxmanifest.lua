fx_version "adamant"

games { 'gta5'}

client_scripts {
	'configs/clientConfig.lua',
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'configs/serverConfig.lua',
    'server/*.lua'
}

dependencies {
    "plouffe_lib"
}

exports {
    "OpenBossMenu"
}

server_exports {
    "SetSocietyAccountMoney",
    "AddSocietyAccountMoney",
    "RemoveSocietyAccountMoney",
    "GetSocietyAccountMoney",
    "GetSocietyAccounts",
    "DoesSocietyExist",
    "GetJobSociety",
    "TriggerJobEvent",
    "GetPlayersPerJob"
}