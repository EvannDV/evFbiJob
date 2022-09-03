RMenu.Add("Fbi", "Fbi_main", RageUI.CreateMenu("Rdv Fbi", "Made by evann™"))
RMenu:Get("Fbi", "Fbi_main").Closed = function()
    print("vous avez fermé le menu")

end





Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(115.375, -748.739, 45.751)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 30 then
            interval = 200
        else
            interval = 1
            DrawMarker(32, 115.375, -748.739, 45.751, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 255, 0, 0, 170, 0, 1, 2, 0, nil, nil, 0)
            if distance < 1 then  
                AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour ouvrir le menu")
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(1, 51) then
                    RageUI.Visible(RMenu:Get("Fbi","Fbi_main"), true)
                end
            end
        end

        Citizen.Wait(interval)
    end
end)



Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get("Fbi","Fbi_main"),true,true,true,function()
           
            RageUI.ButtonWithStyle("Rdv Fbi", nil, {RightLabel = "→"}, true,function(h,a,s)
                if s then
                    TriggerServerEvent('evJob:AnnonceRdv')
                    Citizen.Wait(20000)
                    RageUI.CloseAll()

                end
            
            end)




        end, function()end, 1)
        Citizen.Wait(0)
    end
    

end)