Citizen.CreateThread(function()
    while true do
        local waiting = 750
        local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, 136.059, -762.028, 45.752)
        
        if dist2 <= 10.0 then
            waiting = 0
            DrawMarker(42, 136.059, -762.028, 45.752, -0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0, 200)
        end

        if dist2 <= 1.0 then
                waiting = 0
            RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder aux bureaux", time_display = 1 })
            if IsControlJustPressed(1,51) then
                DoScreenFadeOut(100)
                Citizen.Wait(750)
                ESX.Game.Teleport(PlayerPedId(), {x=117.626,y=-736.452,z=258.152})
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
        local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, 117.626, -736.452, 258.152)

        if dist2 <= 10.0 then
            waiting = 0
        DrawMarker(42, 117.626, -736.452, 258.152, -0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0, 200)

        end

        if dist2 <= 1.0 then
            waiting = 0
            RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour ~b~redescendre", time_display = 1 })
            if IsControlJustPressed(1,51) then
                DoScreenFadeOut(100)
                Citizen.Wait(750)
                ESX.Game.Teleport(PlayerPedId(), {x=136.059,y=-762.028,z=45.752})
                DoScreenFadeIn(100)
            end   
        end
        Citizen.Wait(waiting)
    end
end)