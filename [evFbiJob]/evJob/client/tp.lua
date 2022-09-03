Citizen.CreateThread(function()
    while true do
        local waiting = 750
        local plyCoords2 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, 139.038, -762.579, 45.752)
        
        if dist2 <= 10.0 then
            waiting = 0
            DrawMarker(42, 139.038, -762.579, 45.752, -0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0, 200)
        end

        if dist2 <= 1.0 then
                waiting = 0
            RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour descendre au garage", time_display = 1 })
            if IsControlJustPressed(1,51) then
                DoScreenFadeOut(100)
                Citizen.Wait(750)
                ESX.Game.Teleport(PlayerPedId(), {x=65.543,y=-749.62,z=31.634})
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
        local dist2 = Vdist(plyCoords2.x, plyCoords2.y, plyCoords2.z, 65.543, -749.62, 31.634)

        if dist2 <= 10.0 then
            waiting = 0
        DrawMarker(42, 65.543, -749.620, 31.634, -0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0, 200)

        end

        if dist2 <= 1.0 then
            waiting = 0
            RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour ~b~remonter", time_display = 1 })
            if IsControlJustPressed(1,51) then
                DoScreenFadeOut(100)
                Citizen.Wait(750)
                ESX.Game.Teleport(PlayerPedId(), {x=139.038,y=-762.579,z=45.752})
                DoScreenFadeIn(100)
            end   
        end
        Citizen.Wait(waiting)
    end
end)