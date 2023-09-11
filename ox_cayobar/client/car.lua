local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false

Options = {}



for i = 1, #Config.cars do
    if i == 1 then
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'ksx_cayobar:delCar'}
    else
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'ksx_cayobar:spawnCar'}
    end
end
    lib.registerContext({
        id = 'opengaragestar',
        title = 'Garage',
        options = Options,
    })

RegisterNetEvent('ksx_cayobar:opengaragestar')
AddEventHandler('ksx_cayobar:opengaragestar',function()
	lib.showContext('opengaragestar')
end)

function createCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.cayobar.SpawnVeh, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('ksx_cayobar:spawnCar', function(data)
    createCar(data)
end)

RegisterNetEvent('ksx_cayobar:delCar')
AddEventHandler('ksx_cayobar:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

--- veh done 