local QBCore = exports['qb-core']:GetCoreObject()

-- TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

players = {}

RegisterServerEvent("qb-zombies:newplayer")
AddEventHandler("qb-zombies:newplayer", function(id)
    players[source] = id
    TriggerClientEvent("qb-zombies:playerupdate", -1, players)
end)

AddEventHandler("playerDropped", function(reason)
    players[source] = nil
    TriggerClientEvent("qb-zombies:clear", source)
    TriggerClientEvent("qb-zombies:playerupdate", -1, players)
end)

AddEventHandler("onResourceStop", function()
	 TriggerClientEvent("qb-zombies:clear", -1)
end)

RegisterServerEvent('qb-zombies:moneyloot')
AddEventHandler('qb-zombies:moneyloot', function()
    local Player = QBCore.Functions.GetPlayer(source)
	local random = math.random(10, 100)
    Player.Functions.AddMoney("cash",random,"zombie-loot")
    TriggerClientEvent("QBCore:Notify", source, 'You found $' .. random .. ' dollars','success')
end)

RegisterServerEvent('qb-zombies:itemloot')
AddEventHandler('qb-zombies:itemloot', function(item)
    local Player = QBCore.Functions.GetPlayer(source)
	local random = math.random(1,3)
    Player.Functions.AddItem(item, random)
    TriggerClientEvent("QBCore:Notify", source, 'You found' .. random .. ' ' .. item .. '(s)','success')
	--TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[random], "add")
end)


entitys = {}

RegisterServerEvent("RegisterNewZombie")
AddEventHandler("RegisterNewZombie", function(entity)
	TriggerClientEvent("ZombieSync", -1, entity)
	table.insert(entitys, entity)
end)
