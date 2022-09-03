Citizen.CreateThread(function()
    while true do
        local waiting = 750
        local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, 151.354, -762.006, 258.151)
        
        if dist2 <= 10.0 then
            waiting = 0
            DrawMarker(42, 151.354, -762.006, 258.151, -0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0, 200)
        end

        if dist2 <= 1.0 then
                waiting = 0
            RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder à l'armurerie", time_display = 1 })
            if IsControlJustPressed(1,51) then
                DoScreenFadeOut(100)
                Citizen.Wait(750)
                ESX.Game.Teleport(PlayerPedId(), {x=151.003,y=-763.447,z=258.151})
                DoScreenFadeIn(100)
            end   
        end
        Citizen.Wait(waiting)
    end
end)

Citizen.CreateThread(function()
    while true do
        local waiting = 750
        local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, 151.003, -763.447, 258.151)

        if dist2 <= 10.0 then
            waiting = 0
        DrawMarker(42, 151.003, -763.447, 258.151, -0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0, 200)

        end

        if dist2 <= 1.0 then
            waiting = 0
            RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour ~b~sortir", time_display = 1 })
            if IsControlJustPressed(1,51) then
                DoScreenFadeOut(100)
                Citizen.Wait(750)
                ESX.Game.Teleport(PlayerPedId(), {x=151.354,y=-762.006,z=258.151})
                DoScreenFadeIn(100)
            end   
        end
        Citizen.Wait(waiting)
    end
end)