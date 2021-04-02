ESX = nil

local playerKD = 0

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)


Citizen.CreateThread(function()
	Citizen.Wait(500)
	while true do

    	ESX.TriggerServerCallback('irhagram-kdr:getPlayerKD', function(kd)
        	playerKD = kd
    	end)
    	
		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	while true do
		Citizen.Wait(0)
		
		drawTxt(0.165, 1.466, 0.5, false, 'K/D: ~p~' .. playerKD .. '~s~', 185, 185, 185, 255)

	end
end)

function drawTxt(x, y, s, ss , text, red, green, blue, alpha)
	SetTextFont(1)--fontId)
	SetTextProportional(1)
	SetTextScale(s, s)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	if ss then
		SetTextEdge(1, 0, 0, 0, 255)
	end
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y - 1 / 2 - 0.065)
end

AddEventHandler('esx:onPlayerDeath', function(data)
	TriggerServerEvent('irhagram-events:playerMati')
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(5000)
-- 		if IsDead then
-- 			TriggerServerEvent('irhagram-events:playerMati')
-- 		end
-- 	end
-- end)

AddEventHandler('baseevents:onPlayerKilled', function(killerID, deathData)
	TriggerServerEvent('irhagram-events:playerKilled', killerID, deathData)
end)