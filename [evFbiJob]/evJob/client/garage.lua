ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)





---------Emplacement + createmenu 



RMenu.Add("GarageJob", "GarageJob_main", RageUI.CreateMenu("Garage", "Made by evann™"))
RMenu:Get("GarageJob", "GarageJob_main").Closed = function()
    print("vous avez fermé le menu")

end

Citizen.CreateThread(function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then
        while true do
            local interval = 1
            local pos = GetEntityCoords(PlayerPedId())
            local dest = vector3(60.193, -748.287, 31.679)
            local distance = GetDistanceBetweenCoords(pos, dest, true)

            if distance > 30 then
                interval = 200
            else
                interval = 1
                DrawMarker(36, 60.193, -748.287, 31.679, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.5, 0.7, 0, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
                if distance < 1 then  
                    AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le menu")
                    DisplayHelpTextThisFrame("HELP", false)
                    if IsControlJustPressed(1, 51) then
                        RageUI.Visible(RMenu:Get("GarageJob","GarageJob_main"), true)
                    end
                end
            end

            Citizen.Wait(interval)
        end
    end
end)



-------------Menu


Citizen.CreateThread(function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then
        while true do
            RageUI.IsVisible(RMenu:Get("GarageJob","GarageJob_main"),true,true,true,function()
           
                RageUI.ButtonWithStyle("Cruiser Bana", nil, {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("police4")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)

            

                RageUI.ButtonWithStyle("Fbi street", nil, {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("fbi")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)

                RageUI.ButtonWithStyle("Fbi 4*4", nil, {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("fbi2")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)

                RageUI.ButtonWithStyle("Fbi Moto", nil, {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("akuma")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)


                RageUI.ButtonWithStyle("Voiture de Fonctions", nil, {RightBadge = RageUI.BadgeStyle.Car}, true,function(h,a,s)
                    if s then
                        RageUI.CloseAll()
                        local ped = PlayerPedId()
                        local model = GetHashKey("imperator")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = GetEntityCoords(PlayerPedId())
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)

                    end
            
                end)



                RageUI.ButtonWithStyle("~r~Ranger le Véhicule", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true,function(h,a,s)
                    if s then
                        local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
                        local playerPed = PlayerPedId()
                        if GetPedInVehicleSeat(Vehicle, -1) == playerPed then     
                            ESX.Game.DeleteVehicle(Vehicle)
                            ESX.ShowNotification('~g~Vehicule rangé')
                            RageUI.CloseAll()
                        end

                    end
            
                end)




            end, function()end, 1)
            Citizen.Wait(0)
        end
    end

end)