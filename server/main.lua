local QBCore = exports['qb-core']:GetCoreObject()

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
AddEventHandler('qb-zombies:itemloot', function(listKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local random = math.random(1,5) 
    local item = math.random(1, #Config.Items)
    for k,v in pairs(Config.Items) do
        if item == k then
		Player.Functions.AddItem(v, Config.ItemAmount)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v], 'add')
		TriggerClientEvent("QBCore:Notify", source, 'You found ' .. random .. ' ' .. v .. '(s)','success')
        end
    end
	
    if Config.AddtionalItem then
        local Luck = math.random(1, 8)
        local Odd = math.random(1, 8)
        if Luck == Odd then
            Player.Functions.AddItem(Config.AddItem, Config.AddItemAmount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.AddItem], 'add')
        end
    end
end)

entitys = {}

RegisterServerEvent("RegisterNewZombie")
AddEventHandler("RegisterNewZombie", function(entity)
	TriggerClientEvent("ZombieSync", -1, entity)
	table.insert(entitys, entity)
end)
