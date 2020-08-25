resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Grapeseed Heist'

version '0.0.1'

server_scripts {
	--'@mysql-async/lib/MySQL.lua',
	"@vrp/lib/utils.lua",
	'aircraftHeist_config.lua',
	'sv_aircraftHeist.lua'
}

client_scripts {
	'aircraftHeist_config.lua',
	'cl_aircraftHeist.lua'
}

dependencies {
	
}