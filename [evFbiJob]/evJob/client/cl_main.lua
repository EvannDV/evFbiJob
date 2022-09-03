

TriggerServerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

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
end)

--------Blips


Citizen.CreateThread(function()
    local BLIPFBI = AddBlipForCoord(vector3(97.869, -740.351, 45.755))
    SetBlipSprite(BLIPFBI, 88)
    SetBlipColour(BLIPFBI, 57)
    SetBlipScale(BLIPFBI, 1.0)
    SetBlipAsShortRange(BLIPFBI, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Fbi")
    EndTextCommandSetBlipName(BLIPFBI)
end)











Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1,167) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then
            menuEvJob()
        end
    end

end)






etat= false


function menuEvJob()

    
    local IndexList=1

    local fbiEvJob = RageUI.CreateMenu("Fbi","Made by evann™")

    RageUI.Visible(fbiEvJob, not RageUI.Visible(fbiEvJob))

    while fbiEvJob do
        
        Citizen.Wait(0)

        RageUI.IsVisible(fbiEvJob,true,true,true,function()


          RageUI.Checkbox("~g~Prise de Service", nil, etat,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                etat = Checked
                if etat==true then
                    local ped = GetPlayerPed(-1)
                    local id = PlayerPedId()
                    local weapon = "weapon_stungun"
                    local weaponHash = GetHashKey(weapon)
                    GiveWeaponToPed(ped , weaponHash, 250, true, true)
                    local weapon1 = "weapon_combatpistol"
                    local weaponHash1 = GetHashKey(weapon1)
                    GiveWeaponToPed(ped , weaponHash1, 250, true, true)
                    ESX.ShowNotification("~g~Prise de service")
                else
                    if etat==false then
                        local ped = GetPlayerPed(-1)
                        RemoveAllPedWeapons(ped, true)
                        ESX.ShowNotification("~r~Fin de service")
                    end
                end
            end
        end)
        
            

            RageUI.Separator("↓     Intéractions     ↓")





            RageUI.ButtonWithStyle("Vehicule en fourrière", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                if Selected then    
                    local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
                    local playerPed = PlayerPedId()
                    if GetPedInVehicleSeat(Vehicle, -1) == playerPed then     
                        ESX.Game.DeleteVehicle(Vehicle)
                        ESX.ShowNotification('~g~Voiture en fourrière')
                    else
                        ESX.ShowNotification('~r~Met toi place conducteur')
                    end
                end
            end)


            RageUI.ButtonWithStyle("Cop", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then    
                    ExecuteCommand('e cop')
                end
            end)






            RageUI.Separator("~y~↓     Annonces     ↓")

            RageUI.ButtonWithStyle("~y~Annonce ~r~Prime", nil, {RightLabel = "~y~→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TriggerServerEvent('evJob:AnnonceFbi')
                
                end
            end)

            RageUI.ButtonWithStyle("~y~Annonce ~g~Recrutement", nil, {RightLabel = "~y~→"}, true, function(Hovered, Active, Selected)
              if Selected then
                  TriggerServerEvent('evJob:AnnonceFbi1')
              
              end
          end)

          RageUI.Separator("~r~↓     Factures     ↓")


          RageUI.ButtonWithStyle("~r~Facture",nil, {RightLabel = "~r~→→"}, not cooldown, function(Hovered,Active,Selected)
            local player, distance = ESX.Game.GetClosestPlayer()
            if Selected then
                local raison = ""
                local montant = 0
                AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                while (UpdateOnscreenKeyboard() == 0) do
                    DisableAllControlActions(0)
                    Wait(0)
                end
                if (GetOnscreenKeyboardResult()) then
                    local result = GetOnscreenKeyboardResult()
                    if result then
                        raison = result
                        result = nil
                        AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            result = GetOnscreenKeyboardResult()
                            if result then
                                montant = result
                                result = nil
                                if player ~= -1 and distance <= 3.0 then
                                    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_fbi', ("fbi"), montant)
                                    TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                else
                                    RageUI.Popup({message = "~r~Probleme~s~: Aucuns joueurs proche"})
                                end
                            end
                        end
                    end
                end
                cooldown = true
                Citizen.SetTimeout(5000,function()
                  cooldown = false
                end)
              end
          end)


          RageUI.Separator("↓     Problèmes     ↓")


        RageUI.ButtonWithStyle("Debug", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
            if Selected then
                ExecuteCommand('restart evJob')
                RageUI.CloseAll()    
            end
        end)




        
        end, function()
        end)

        if not RageUI.Visible(fbiEvJob) then
            fbiEvJob=RMenu:DeleteType("Delete", true)
        end

    end

end







-- badge Fbi
RegisterNetEvent('fbibadge:open')
AddEventHandler('fbibadge:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)


--------------------------------------------------------------


RegisterNetEvent('finalpolice:handcuff')
AddEventHandler('finalpolice:handcuff', function()

IsHandcuffed    = not IsHandcuffed;
local playerPed = GetPlayerPed(-1)

Citizen.CreateThread(function()

if IsHandcuffed then

	RequestAnimDict('mp_arresting')
	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(100)
	end

	TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
	DisableControlAction(2, 37, true)
	SetEnableHandcuffs(playerPed, true)
	SetPedCanPlayGestureAnims(playerPed, false)
	FreezeEntityPosition(playerPed,  true)
	DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 25, true) -- Aim
	DisableControlAction(0, 263, true) -- Melee Attack 1
	DisableControlAction(0, 37, true) -- Select Weapon
	DisableControlAction(0, 47, true)  -- Disable weapon
	DisplayRadar(false)

else

	ClearPedSecondaryTask(playerPed)
	SetEnableHandcuffs(playerPed, false)
	SetPedCanPlayGestureAnims(playerPed,  true)
	FreezeEntityPosition(playerPed, false)
	DisplayRadar(true)

end

  end)
end)

RegisterNetEvent('finalpolice:drag')
AddEventHandler('finalpolice:drag', function(cop)
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if IsHandcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)



-- Handcuff
Citizen.CreateThread(function()
    while true do
      Wait(0)
      if IsHandcuffed then
        DisableControlAction(0, 142, true) -- MeleeAttackAlternate
        DisableControlAction(0, 30,  true) -- MoveLeftRight
        DisableControlAction(0, 31,  true) -- MoveUpDown
      end
    end
  end)














