resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

author 'irhagram'
description 'Rasio KD: Made by @irhagram | anoni4m#6817'
version '1.3'


client_scripts {
	'irhagram-c.lua'
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	'irhagram-s.lua'
}