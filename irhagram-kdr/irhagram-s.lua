
print('^1[^9irhagram^1]^3|----------------------------------anoni4m-----------------------------------------|')
print('^1[^9irhagram^1]^3|                     Script Rasio KD Made by Roy/anoni4m 2021                     |')
print('^1[^9irhagram^1]^3|                              versi anoni-1.3                                     |')
print('^1[^9irhagram^1]^3| selalu cek versi yang paling baru ya di https://github.com/irhagram/irhagram-kdr |')
print('^1[^9irhagram^1]^3|----------------------------------anoni4m-----------------------------------------|')
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX.RegisterServerCallback('irhagram-kdr:getPlayerKD', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = xPlayer.identifier

	-- Event untuk mendapatkan Rasio Kill/Death
	MySQL.Async.fetchAll('SELECT * FROM users WHERE @identifier=identifier LIMIT 1', {
    ['@identifier'] = identifier
    }, function(result)
        if result[1] then
        	local pkd = ""
        	if string.len(tostring(result[1].bunuh / result[1].mati)) > 2 then
        		pkd = tostring(result[1].bunuh / result[1].mati)
        		pkd = string.sub(pkd, 1, 4) 
        	else
        		pkd = tostring(result[1].bunuh / result[1].mati)
        	end
        	cb(pkd)
        else
        	cb('1.0')
        end
    end)
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5000)
-- 		if IsDead then
-- 			TriggerEvent('irhagram-events:playerMati')
-- 		end
-- 	end
-- end)

-- Event ketika Terbunuh
RegisterServerEvent('irhagram-events:playerMati')
AddEventHandler('irhagram-events:playerMati', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Sync.execute("UPDATE users SET mati = mati + 1 WHERE identifier=@identifier", {
        ['@identifier'] = identifier
    })
end)

	
-- Event ketika Membunuh (Experimental 1)
RegisterServerEvent('irhagram-events:playerKilled')
AddEventHandler('irhagram-events:playerKilled', function(killerID, deathData)
	local identifier = GetPlayerIdentifiers(killerID)[1]
	"onMySQLReady",

    MySQL.Sync.execute("UPDATE users SET bunuh = bunuh + 1 WHERE identifier=@identifier", {
        ['@identifier'] = identifier
    })


end)

-- Event ketika Membunuh (Experimental 2)
-- RegisterServerEvent('irhagram-events:playerKilled')
-- AddEventHandler('irhagram-events:playerKilled', function(killerID, deathData)
--     local _source, pembunuh = source, killerID
--     local xPlayer, xPembunuh  = ESX.GetPlayerFromId(_source), ESX.GetPlayerFromId(pembunuh)

-- MySQL.Async.fetchAll('SELECT bunuh FROM users WHERE @identifier=identifier LIMIT 1', {
-- 	['@identifier'] = xPembunuh.identifier
-- }, function(result)
-- 	if result[1] then
-- 		local currentBunuh = result[1].bunuh
-- 		local newBunuh = currentBunuh + 1
-- 		MySQL.Async.execute('UPDATE users SET bunuh = @newBunuh WHERE identifier = @identifier', {
-- 			['@newBunuh'] = newBunuh,
-- 			['@identifier'] = xPembunuh.identifier
-- 		}, function(rowsChanged)
-- 		end)
-- 	end
-- end)

-- end)


