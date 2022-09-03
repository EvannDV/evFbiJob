ESX = nil

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

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)


-- Menu --
local open = false
local MenuCoffreEv = RageUI.CreateMenu("Armurerie", "Made by evann™")

MenuCoffreEv.Closed = function()
    open = false
end

function OpenMenuArmurerie()
    local menuTest = RageUI.CreateMenu("Armurerie", "Made by evann™")

    RageUI.Visible(menuTest, not RageUI.Visible(menuTest))

    while menuTest do
        
        Citizen.Wait(0)

        RageUI.IsVisible(menuTest,true,true,true,function()

            RageUI.Separator("~p~↓     Armes     ↓")
        
            RageUI.ButtonWithStyle("Adp",nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                if Selected then    
                    local ped = GetPlayerPed(-1)
                    local id = PlayerPedId()
                    local weapon = "weapon_combatpdw"
                    local weaponHash = GetHashKey(weapon)
                    GiveWeaponToPed(ped , weaponHash, 250, true, true)
                    RageUI.CloseAll()
                end
            end)  

            

            RageUI.ButtonWithStyle("Fusil à Pompe",nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local ped = GetPlayerPed(-1)
                    local id = PlayerPedId()
                    local weapon1 = "weapon_pumpshotgun"
                    local weaponHash1 = GetHashKey(weapon1)
                    GiveWeaponToPed(ped , weaponHash1, 250, true, true)
                    RageUI.CloseAll()   
                end
            end)
            
            
            RageUI.ButtonWithStyle("Carabine M4",nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local ped = GetPlayerPed(-1)
                    local id = PlayerPedId()
                    local weapon2 = "weapon_carbinerifle"
                    local weaponHash2 = GetHashKey(weapon2)
                    GiveWeaponToPed(ped , weaponHash2, 250, true, true)
                    RageUI.CloseAll()   
                end
            end)

            RageUI.ButtonWithStyle("Grenade Fumigène",nil, {RightLabel = "~g~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local ped = GetPlayerPed(-1)
                    local id = PlayerPedId()
                    local weapon3 = "weapon_smokegrenade"
                    local weaponHash3 = GetHashKey(weapon3)
                    GiveWeaponToPed(ped , weaponHash3, 250, true, true)
                    RageUI.CloseAll()   
                end
            end)

            RageUI.Separator("~r~↓     Retirer Armes     ↓")

            RageUI.ButtonWithStyle("Rendre l'équipement",nil, {RightLabel = "~r~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local ped = GetPlayerPed(-1)
                    RemoveAllPedWeapons(ped, true)
                    RageUI.CloseAll()   
                end
            end)

        
        end, function()
        end)

        if not RageUI.Visible(menuTest) then
            menuTest=RMenu:DeleteType("Delete", true)
        end

    end

end



Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then
				for k in pairs {vector3(153.976, -765.970, 258.152)} do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local pos = {vector3(153.976, -765.970, 258.152)}
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

				if dist <= 6 then
					wait = 0
					DrawMarker(41, 153.976, -765.970, 258.152, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.7, 0.7, 0.7, 0, 0, 0, 180, true, true, p19, true)  
				end

				if dist <= 1.0 then
					wait = 0
					
					AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le menu")
                    DisplayHelpTextThisFrame("HELP", false)
					if IsControlJustPressed(1,51) then
						OpenMenuArmurerie()
					end
				end
			end
		end
    Citizen.Wait(wait)
    end
end)