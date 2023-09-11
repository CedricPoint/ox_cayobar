ESX = exports["es_extended"]:getSharedObject()


local PlayerData = {}

Citizen.CreateThread(function()

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer 
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	Citizen.Wait(10)
end)

exports.qtarget:AddBoxZone("cayobarBilling", vector3(4905.3076, -4941.3999, 3.3795), 2.2, 1, {
	name="cayobarBilling",
	heading=33.0090,
	debugPoly=false,
	minZ=110.10,
	maxZ=110.60,
	}, {
		options = {
			{
				event = "cayobar:bill",
				icon = "fas fa-cube",
				label = "Menu Facture",
				job = "cayobar",
			},
		},
		distance = 2.5
})

RegisterNetEvent('cayobar:bill')
AddEventHandler('cayobar:bill', function()
      local input = lib.inputDialog('Facture cayobar', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_cayobar', 'Facture cayobar', amount)
			end
		end
    end
end)

exports.qtarget:AddBoxZone("cayobarBoss", vector3(4908.3057, -4895.6577, 5.1011), 2.2, 1, {
	
	name="cayobarBoss",
	heading=265.4050,
	debugPoly=false,
	minZ=110.3,
	maxZ=111.0,
	}, {
		options = {
			{
				event = "cayobar:boss",
				icon = "fas fa-cube",
				label = "Menu Patron",
				job = "cayobar",
			},
		},
		distance = 2.5
})

RegisterNetEvent('cayobar:boss')
AddEventHandler('cayobar:boss', function()
	TriggerEvent('esx_society:openBossMenu', 'cayobar', function(data, menu)
		menu.close()
		end, { wash = false })
end)

exports.qtarget:AddBoxZone("cayobarDrinks", vector3(4904.1899, -4944.9077, 3.3883), 2.4, 1, {
	name="cayobarDrinks",
	heading=186.3928,
	debugPoly=false,
	minZ=109.80,
	maxZ=110.60,
	}, {
		options = {
			{
				event = "cayobar:drinks",
				icon = "fas fa-cube",
				label = "Menu Boisson",
				job = "cayobar",
			},
		},
		distance = 2.5
})



exports.qtarget:AddBoxZone("cayobarCook", vector3(4907.2041, -4943.3320, 3.3799), 1.5, 1.5, {
	name="cayobarCook",
	heading=236.2383,
	debugPoly=false,
	minZ = 109.01,
	maxZ = 114.01,
	}, {
		options = {
			{
				event = "cayobar:cookmenu",
				icon = "fas fa-cube",
				label = "Menu Cuisson",
				job = "cayobar",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("ksxFridge", vector3(4901.7480, -4945.2319, 3.3856), 1.6, 1, {
	name="ksxFridge",
	heading=190.5289,
	debugPoly=false,
	minZ=109.90,
	maxZ=110.60,
	}, {
		options = {
			{
				event = "cayobar:stash",
				icon = "fas fa-cube",
				label = "Action Frigidaire",
				job = "cayobar",
			},
		},
		distance = 2.5
})



exports.qtarget:AddBoxZone("cayobarBossStash", vector3(4904.7490, -4896.7168, 4.9804), 2.2, 1, {
	name="cayobarBossStash",
	heading=128.7629,
	debugPoly=false,
	minZ=110.3,
	maxZ=111.0,
	}, {
		options = {
			{
				event = "cayobar:bossstash",
				icon = "fas fa-cube",
				label = "Coffre Patron",
				job = "cayobar",
			},
		},
		distance = 2.5
})

RegisterNetEvent('cayobar:bossstash')
AddEventHandler('cayobar:bossstash', function()
	if ESX.PlayerData.job.name == 'cayobar' and ESX.PlayerData.job.grade_name == 'boss' then
	OpenBosscayobarStash()
else
    ESX.ShowNotification('Tu a pas access a ce coffre!')
    end
end)






local reward = math.random(Config.Reward.Min, Config.Reward.Max)
local reward = math.random(Config.Reward.Min, Config.Reward.Max)
local times = 3

RegisterNetEvent('cayobar:cookmenu')
AddEventHandler('cayobar:cookmenu', function()
    lib.registerContext({
        id = 'cayobar:cookmenu',
        title = 'Actions Cuisson',
        onExit = function()
        end,
        options = {
            {
                title = 'Frite',
                description = 'Faire un barquet de Frite',
                onSelect = function(args)
                    loadDict("anim@amb@business@coc@coc_unpack_cut@")
                    TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, times, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(7500, math.random(5, 7))
                    end
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'fritemdco')
                    ESX.ShowNotification('[Entreprise] Frite bien préparé.')
                end,
            },

            {
                title = 'Pistache',
                description = 'Pistache',
                onSelect = function(args)
                    loadDict("anim@amb@business@coc@coc_unpack_cut@")
                    TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, times, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(7500, math.random(5, 7))
                    end
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_pistache')
                    ESX.ShowNotification('[Entreprise] Pistache faite.')
                end,
            },

            {
                title = 'Pop Corn',
                description = 'Pop Corn',
                onSelect = function(args)
                    loadDict("anim@amb@business@coc@coc_unpack_cut@")
                    TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, times, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(7500, math.random(5, 7))
                    end
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_popcorn')
                    ESX.ShowNotification('[Entreprise] Pop corn faite.')
                end,
            },

            {
                title = 'Donut',
                description = 'Donut',
                onSelect = function(args)
                    loadDict("anim@amb@business@coc@coc_unpack_cut@")
                    TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, times, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(7500, math.random(5, 7))
                    end
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_donut')
                    ESX.ShowNotification('[Entreprise] Donut faite.')
                end,
            },

            {
                title = 'Banane',
                description = 'Banane',
                onSelect = function(args)
                    loadDict("anim@amb@business@coc@coc_unpack_cut@")
                    TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, times, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(7500, math.random(5, 7))
                    end
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_banana')
                    ESX.ShowNotification('[Entreprise] Banane faite.')
                end,
            },

        },
    })
    lib.showContext('cayobar:cookmenu')
end)


RegisterNetEvent('cayobar:drinks')
AddEventHandler('cayobar:drinks', function()
    lib.registerContext({
        id = 'cayobar:drinks',
        title = 'Actions Boisson',
        onExit = function()
        end,
        options = {
            {
                title = 'Cafe',
                description = 'Cafe',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_coffee')
                    ESX.ShowNotification('[cayobar] Success.')
                   -- TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Coca',
                description = 'Coca',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_coke')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Cappuccino',
                description = 'Cappuccino',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_frappuccino')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Limonade',
                description = 'Limonade',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_limonade')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Absynthe',
                description = 'Absynthe',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_absinthe')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Biere blonde',
                description = 'Biere blonde',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_beer')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Biere brune',
                description = 'Biere brune',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_biere_brun')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Absynthe cannabis',
                description = 'Absynthe cannabis',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_cannabis-absinthe')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Rhum',
                description = 'Rhum',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_rum')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Sake',
                description = 'Sake',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_sake')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Vodka',
                description = 'Vodka',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_vodka')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
            {
                title = 'Whiskey',
                description = 'Whiskey',
                onSelect = function(args)
                    loadDict("anim@mp_player_intupperspray_champagne")
                    TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
                    for i = 1, 2, 1 do
                        local finished = exports["ksx_skillbar"]:taskBar(3500, math.random(5, 7))
                    end
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('ksx_cayobar:add', 'item', 3, 'dg_whiskey')
                    ESX.ShowNotification('[cayobar] Success.')
                    --TriggerServerEvent('ksx_cayobar:add', 'money', reward)
                    TriggerEvent('cayobar:coke')
                end,
            },
        },
    })
    lib.showContext('cayobar:drinks')
end)



RegisterNetEvent('cayobar:orderstash')
AddEventHandler('cayobar:orderstash', function()
	OpenOrdercayobar()
end)

function OpenOrdercayobar()
	exports.ox_inventory:openInventory('stash', {id='cayobarOrderStash', owner= false})
end

RegisterNetEvent('cayobar:stash')
AddEventHandler('cayobar:stash', function()
	OpencayobarStash()
end)	

function OpenBosscayobarStash()

	exports.ox_inventory:openInventory('stash', {id='cayobarBossStash', owner= false})
end

function OpencayobarStash()
	exports.ox_inventory:openInventory('stash', {id='cayobarStash', owner= false, job = cayobar})
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

Citizen.CreateThread(function()

    local blipMarker = Config.Blips.cayobar
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("cayobar")
    EndTextCommandSetBlipName(blipCoord)


end)




if Config.Target then 
    exports.qtarget:Player({
        options = {
            {
                icon = Config.DragonTarget.IconFacture,
                label = Config.DragonTarget.Facture,
                event = "ksx_ambulance:sendbill",
                job = 'ambulance'
            }
        },
        distance = 2.0
    })
end




















