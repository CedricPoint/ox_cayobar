ESX = exports["es_extended"]:getSharedObject()



TriggerEvent('esx_society:registerSociety', 'cayobar', 'cayobar', 'society_cayobar', 'society_cayobar', 'society_cayobar', {type = 'public'})

--START OF BURGER--
local cayobarstash = {
    id = 'cayobarStash',
    label = 'Coffre Employer',
    slots = 90,
    weight = 100000,
    owner = 'steam:'
}

local cayobarorderstash = {
    id = 'cayobarOrderStash',
    label = 'Menu Commandes',
    slots = 90,
    weight = 100000,
    owner = 'steam:'
}

local cayobarboss = {
    id = 'cayobarBossStash',
    label = 'Coffre Patron',
    slots = 90,
    weight = 100000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
        exports.ox_inventory:RegisterStash(cayobarstash.id, cayobarstash.label, cayobarstash.slots, cayobarstash.weight, cayobarstash.owner)
		exports.ox_inventory:RegisterStash(cayobarorderstash.id, cayobarorderstash.label, cayobarorderstash.slots, cayobarorderstash.weight, cayobarorderstash.owner)
        exports.ox_inventory:RegisterStash(cayobarboss.id, cayobarboss.label, cayobarboss.slots, cayobarboss.weight, cayobarboss.owner)
    end
end)


RegisterServerEvent('ksx_cayobar:add')
AddEventHandler('ksx_cayobar:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', source, 'You recieved $'..amount, 'warn', 5000)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)
RegisterServerEvent('ksx_cayobar:remove')
AddEventHandler('ksx_cayobar:remove', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)

	if type == 'money' then
		xPlayer.removeMoney(amount)
	elseif type == 'item' then
		xPlayer.removeInventoryItem(name, amount)
	end
end)