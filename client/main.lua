local ConfigTuto = {}
local IsTutoStart, PointLocation, PointChantier, PointPermis, PointShop = false, false, false, false, false
local blip, veh = nil, nil
ConfigTuto.DrawDistance = 30.0
ConfigTuto.Size   = {x = 5.5, y = 2.0, z = 5.5}
ConfigTuto.Color  = {r = 166, g = 0, b = 255}
ConfigTuto.Type   = 6

local zoneDeSpawn = {
    {pos = vector3(-514.66479492188,-993.33703613281,23.546703338623), heading = 1.05},
    {pos = vector3(-514.32263183594, -1006.9337158203, 23.55456161499), heading = 16.15},
    {pos = vector3(-520.92846679688,-1004.9130249023,23.335039138794), heading = 275.74},
    {pos = vector3(-520.96459960938,-1000.4593505859,23.389726638794), heading = 272.75},
    {pos = vector3(-520.53363037109,-996.46771240234,23.42751121521), heading = 272.51},
    {pos = vector3(-520.51251220703,-992.55871582031,23.436527252197), heading = 269.57},
    {pos = vector3(-520.47857666016,-988.36206054688,23.438066482544), heading = 272.1},
    {pos = vector3(-520.72344970703,-984.22625732422,23.438470840454), heading = 272.63},
    {pos = vector3(-520.66668701172,-979.79925537109,23.453590393066), heading = 271.81},
    {pos = vector3(-504.26364135742,-970.34234619141,23.574897766113), heading = 92.17},
    {pos = vector3(-503.89907836914,-966.01702880859,23.575487136841), heading = 83.24},
    {pos = vector3(-503.22534179688,-961.33209228516,23.679382324219), heading = 83.26},
}

local zoneDeSpawn2 = {
    {pos = vector3(-1229.7202148438,-897.72454833984,12.27082824707), heading = 301.29},
    {pos = vector3(-1234.7844238281,-901.17919921875,12.072542190552), heading = 308.34},
    {pos = vector3(-1239.5212402344,-904.43811035156,11.878547668457), heading = 302.61},
    {pos = vector3(-1244.9255371094,-908.13983154297,11.658886909485), heading = 303.69},
    {pos = vector3(-1250.6492919922,-911.98364257812,11.44554901123), heading = 303.36},
}

local zoneDeSpawn3 = {
    {pos = vector3(-488.59301757812,-252.86502075195,35.678218841553), heading = 110.29},
    {pos = vector3(-493.89608764648,-255.10336303711,35.623184204102), heading = 113.31},
    {pos = vector3(-499.20156860352,-257.28179931641,35.568580627441), heading = 110.81},
    {pos = vector3(-504.35534667969,-259.33801269531,35.54386138916), heading = 110.95},
    {pos = vector3(-510.10955810547,-261.62551879883,35.464958190918), heading = 109.37},
    {pos = vector3(-515.40856933594,-263.92233276367,35.409423828125), heading = 110.65},
    {pos = vector3(-520.76403808594,-266.03695678711,35.32897567749), heading = 111.77},
    {pos = vector3(-526.57196044922,-268.46124267578,35.266738891602), heading = 111.76},
    {pos = vector3(-532.38452148438,-270.73742675781,35.205986022949), heading = 111.17},
    {pos = vector3(-500.22, -175.12, 38.01), heading = 230.99},
    {pos = vector3(-496.46, -182.67, 37.87), heading = 230.99},
    {pos = vector3(-491.69, -190.73, 37.62), heading = 230.99},
    {pos = vector3(-487.67, -198.36, 37.39), heading = 230.99},
}

Citizen.CreateThread(function()
    while ESX == nil do Citizen.Wait(1) end
    while true do
        local _Wait = 500
        if not IsTutoStart then
            local PlayerPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(PlayerPed)
            local Coords = vector3(-241.16, -335.85, 29)
            local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
            if pDst < ConfigTuto.DrawDistance then
                DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
                _Wait = 1
                if pDst <= 3.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer le tuto")
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent("ad_tuto:Start")
                    end
                end
            end
        end
        Citizen.Wait(_Wait)
    end
end)

RegisterNetEvent("ad_tuto:Start")
AddEventHandler("ad_tuto:Start", function()
    IsTutoStart = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = "tuto", action = "popup", value = "Bienvenue à toi ! Pour commencer,</br> il te faut un véhicule… Prends une location gratuite</br> en allant parler à la personne près de la colonne."})
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
    TriggerEvent("ad_tuto:SetLocation")
    PointLocation = true
    while PointLocation do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local Coords = vector3(-244.98, -343.7, 29)
        local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
        end
        Citizen.Wait(_Wait)
    end
end)

RegisterNetEvent("ad_tuto:PasseLocation")
AddEventHandler("ad_tuto:PasseLocation", function(_veh)
    PointLocation = false
    veh = _veh
    SetNuiFocus(true, true)
    SendNUIMessage({type = "tuto", action = "popup", value = "Parfait ! Prends ton véhicule, il est temps de te faire un peu d’argent."})
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
    while true do
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            SetNuiFocus(true, true)
            SendNUIMessage({type = "tuto", action = "popup", value = "Plusieurs jobs sont disponibles, mais on va aller au plus simple : le chantier.</br> Ton gps t’indique la route pour t’y rendre."})
            SendNUIMessage({type = "tuto", action = "arrow"})
            PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
            break
        end
        Citizen.Wait(500)
    end
    blip = AddBlipForCoord(vector3(-519.61, -987.4, 22.5))
    SetBlipRoute(blip, 1)
    PointChantier = true
    while PointChantier do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local Coords = vector3(-519.61, -987.4, 22.5)
        local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
            if pDst <= 3.0 then
                if DoesEntityExist(veh) then
                    FreezeEntityPosition(veh, true)
                end
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
                SetNuiFocus(true, true)
                SendNUIMessage({type = "tuto", action = "popup", value = "La personne que tu vois te donnera du travail,</br> va lui parler pour commencer à gagner un peu d’argent."})
                PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
                break
            end
        end
        Citizen.Wait(_Wait)
    end
    
    TriggerEvent("ad_tuto:SetChantier")
    blip = AddBlipForCoord(vector3(-510.2, -1001.6, 22.6))
    SetBlipRoute(blip, 1)
    while PointChantier do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local Coords = vector3(-510.2, -1001.6, 22.6)
        local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
        end
        Citizen.Wait(_Wait)
    end
end)

RegisterNetEvent("ad_tuto:PasseChantier")
AddEventHandler("ad_tuto:PasseChantier", function()
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
    if DoesEntityExist(veh) then
        DeleteEntity(veh)
    end
    PointChantier = false
    SetNuiFocus(true, true)
    SendNUIMessage({type = "tuto", action = "popup", value = "Le chantier est juste derrière, on t’indiquera les zones où travailler à chaque fois."})
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
end)


RegisterNetEvent("ad_tuto:ChantierMessage")
AddEventHandler("ad_tuto:ChantierMessage", function()
    SetNuiFocus(true, true)
    SendNUIMessage({type = "tuto", action = "popup", value = "Le chantier c’est fatigant… essayons de trouver une mission plus originale en ville. Retourne voir le chef de chantier pour arrêter de travailler."})
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
end)

RegisterNetEvent("ad_tuto:SetPosChantier")
AddEventHandler("ad_tuto:SetPosChantier", function(coords)
    while true do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local pDst = GetDistanceBetweenCoords(coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
            if pDst <= 3.0 then
                Citizen.Wait(2000)
                SetNuiFocus(true, true)
                SendNUIMessage({type = "tuto", action = "popup", value = "Très bien ! Continue à travailler là où on a besoin de toi."})
                PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
                break
            end
        end
        Citizen.Wait(_Wait)
    end
end)

RegisterNetEvent("ad_tuto:FinalChantier")
AddEventHandler("ad_tuto:FinalChantier", function()
    SetNuiFocus(true, true)
    SendNUIMessage({type = "tuto", action = "popup", value = "Des contrats te sont proposés sur toute l’île, cependant tu auras besoin</br> de ton permis voiture… mais pour éviter de tomber de faim ou de soif,</br> commençons déjà par passer à la supérette."})
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
    if DoesEntityExist(veh) then
        DeleteEntity(veh)
    end
    local spawnCo, spawnHeading = SelectSpawnPoint("Chantier")
    if spawnCo ~= false then
        veh = CreateVehicle(GetHashKey("blista"), spawnCo, spawnHeading, true, true)
        if DoesEntityExist(veh) then
            SetEntityAsMissionEntity(veh, 1, 1)
            SetVehicleHasBeenOwnedByPlayer(veh, 1)
            SetVehicleNumberPlateText(veh, "GRATUIT")
            SetVehicleMaxSpeed(veh, 19.4)
            local pVehC = GetEntityCoords(veh)
            blip = AddBlipForCoord(vector3(pVehC))
            SetBlipRoute(blip, 1)
            local NotNear = true
            while NotNear do
                Citizen.Wait(1)
                local pVehC = GetEntityCoords(veh)
                local pCoords = GetEntityCoords(GetPlayerPed(-1))
                local dst = GetDistanceBetweenCoords(pVehC, pCoords, true)
                if dst >= 3.0 then
                    DrawMarker(0, pVehC.x, pVehC.y, pVehC.z+1.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.2, 166, 0, 255, 220, 1, 0, 2, 0, nil, nil, 0)
                else
                    if DoesBlipExist(blip) then
                        RemoveBlip(blip)
                    end
                    NotNear = false
                end
            end
        end
    else
        ESX.ShowNotification("Aucun point de sortie disponible")
    end

    blip = AddBlipForCoord(vector3(-1226.25, -902.8, 11.35))
    SetBlipRoute(blip, 1)
    while true do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local Coords = vector3(-1226.25, -902.8, 11.35)
        local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
            if pDst <= 3.0 then
                SetNuiFocus(true, true)
                SendNUIMessage({type = "tuto", action = "popup", value = "Achète quelques sandwiches et quelques boissons. Ensuite, on ira passer le permis !"})
                PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
                break
            end
        end
        Citizen.Wait(_Wait)
    end

    blip = AddBlipForCoord(vector3(-1222.25, -906.78, 11.35))
    SetBlipRoute(blip, 1)
    while true do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local Coords = vector3(-1222.25, -906.78, 11.35)
        local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
            if pDst <= 3.0 then
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
                break
            end
        end
        Citizen.Wait(_Wait)
    end

    blip = AddBlipForCoord(vector3(-1226.25, -902.8, 11.35))
    SetBlipRoute(blip, 1)
    while true do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local Coords = vector3(-1226.25, -902.8, 11.35)
        local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
            if pDst <= 3.0 then
                SetNuiFocus(true, true)
                SendNUIMessage({type = "tuto", action = "popup", value = "Retourne à la voiture, direction le permis de conduire !"})
                PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
                break
            end
        end
        Citizen.Wait(_Wait)
    end

    if DoesEntityExist(veh) then
        DeleteEntity(veh)
    end
    local spawnCo, spawnHeading = SelectSpawnPoint("Superette")
    if spawnCo ~= false then
        veh = CreateVehicle(GetHashKey("blista"), spawnCo, spawnHeading, true, true)
        if DoesEntityExist(veh) then
            SetEntityAsMissionEntity(veh, 1, 1)
            SetVehicleHasBeenOwnedByPlayer(veh, 1)
            SetVehicleNumberPlateText(veh, "GRATUIT")
            SetVehicleMaxSpeed(veh, 19.4)
            local pVehC = GetEntityCoords(veh)
            blip = AddBlipForCoord(vector3(pVehC))
            SetBlipRoute(blip, 1)
            local NotNear = true
            while NotNear do
                Citizen.Wait(1)
                local pVehC = GetEntityCoords(veh)
                local pCoords = GetEntityCoords(GetPlayerPed(-1))
                local dst = GetDistanceBetweenCoords(pVehC, pCoords, true)
                if dst >= 3.0 then
                    DrawMarker(0, pVehC.x, pVehC.y, pVehC.z+1.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.2, 166, 0, 255, 220, 1, 0, 2, 0, nil, nil, 0)
                else
                    if DoesBlipExist(blip) then
                        RemoveBlip(blip)
                    end
                    NotNear = false
                end
            end
        end
    else
        ESX.ShowNotification("Aucun point de sortie disponible")
    end

    if DoesEntityExist(veh) then
        while true do
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                break
            end
            Citizen.Wait(500)
        end
    end

    TriggerEvent("ad_tuto:SetPermis")
    blip = AddBlipForCoord(vector3(-517.58, -211.39, 37.16))
    SetBlipRoute(blip, 1)
    PointPermis = true
    while PointPermis do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local Coords = vector3(-517.58, -211.39, 37.16)
        local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
            if pDst <= 3.0 then
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
                if DoesEntityExist(veh) then
                    DeleteEntity(veh)
                end
            end
        end
        Citizen.Wait(_Wait)
    end
end)

RegisterNetEvent("ad_tuto:PassePermis")
AddEventHandler("ad_tuto:PassePermis", function(etat)
    PointPermis = false
    if etat then
        SetNuiFocus(true, true)
        SendNUIMessage({type = "tuto", action = "popup", value = "Maintenant que tu as validé ton permis, va à la mairie chercher ton justificatif de permis et profites-en pour prendre ta carte d’identité."})
        PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
        TriggerEvent('ad_tuto:SetShop', true)
        blip = AddBlipForCoord(vector3(-544.89, -204.24, 37.22))
        SetBlipRoute(blip, 1)
        PointShop = true
        while PointShop do
            local _Wait = 500
            local PlayerPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(PlayerPed)
            local Coords = vector3(-544.89, -204.24, 37.22)
            local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
            if pDst < ConfigTuto.DrawDistance then
                DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
                _Wait = 1
            end
            Citizen.Wait(_Wait)
        end
    else
        SetNuiFocus(true, true)
        SendNUIMessage({type = "tuto", action = "popup", value = "Tu as échoué à l’épreuve de conduite... Reviens passer ton permis plus tard !</br> En attendant, allons chercher ta pièce d’identité à la mairie."})
        PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
        TriggerEvent('ad_tuto:SetShop', false)
        blip = AddBlipForCoord(vector3(-544.89, -204.24, 37.22))
        SetBlipRoute(blip, 1)
        PointShop = true
        while PointShop do
            local _Wait = 500
            local PlayerPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(PlayerPed)
            local Coords = vector3(-544.89, -204.24, 37.22)
            local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
            if pDst < ConfigTuto.DrawDistance then
                DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
                _Wait = 1
            end
            Citizen.Wait(_Wait)
        end
    end
end)

RegisterNetEvent("ad_tuto:PasseShop")
AddEventHandler("ad_tuto:PasseShop", function()
    PointShop = false
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
    if DoesEntityExist(veh) then
        DeleteEntity(veh)
    end
    SetNuiFocus(true, true)
    SendNUIMessage({type = "tuto", action = "popup", value = "Il est temps d’aller chercher un contrat en ville… prends la voiture et suis le gps."})
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
    local spawnCo, spawnHeading = SelectSpawnPoint("Marie")
    if spawnCo ~= false then
        veh = CreateVehicle(GetHashKey("blista"), spawnCo, spawnHeading, true, true)
        if DoesEntityExist(veh) then
            SetEntityAsMissionEntity(veh, 1, 1)
            SetVehicleHasBeenOwnedByPlayer(veh, 1)
            SetVehicleNumberPlateText(veh, "GRATUIT")
            SetVehicleMaxSpeed(veh, 19.4)
            local pVehC = GetEntityCoords(veh)
            blip = AddBlipForCoord(vector3(pVehC))
            SetBlipRoute(blip, 1)
            local NotNear = true
            while NotNear do
                Citizen.Wait(1)
                local pVehC = GetEntityCoords(veh)
                local pCoords = GetEntityCoords(GetPlayerPed(-1))
                local dst = GetDistanceBetweenCoords(pVehC, pCoords, true)
                if dst >= 3.0 then
                    DrawMarker(0, pVehC.x, pVehC.y, pVehC.z+1.9, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.2, 166, 0, 255, 220, 1, 0, 2, 0, nil, nil, 0)
                else
                    if DoesBlipExist(blip) then
                        RemoveBlip(blip)
                    end
                    NotNear = false
                end
            end
        end
    else
        ESX.ShowNotification("Aucun point de sortie disponible")
    end

    if DoesEntityExist(veh) then
        while true do
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                break
            end
            Citizen.Wait(500)
        end
    end

    blip = AddBlipForCoord(vector3(394.73, -1635.12, 28.3))
    SetBlipRoute(blip, 1)
    TriggerEvent("ad_tuto:SetMission")
    while true do
        local _Wait = 500
        local PlayerPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(PlayerPed)
        local Coords = vector3(394.73, -1635.12, 28.3)
        local pDst = GetDistanceBetweenCoords(Coords, pCoords, true)
        if pDst < ConfigTuto.DrawDistance then
            DrawMarker(ConfigTuto.Type, Coords, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, ConfigTuto.Size.x, ConfigTuto.Size.y, ConfigTuto.Size.z, ConfigTuto.Color.r, ConfigTuto.Color.g, ConfigTuto.Color.b, 100, false, true, 2, false, false, false, false)
            _Wait = 1
            if pDst <= 3.0 then
                if DoesEntityExist(veh) then
                    DeleteEntity(veh)
                end
                if DoesBlipExist(blip) then
                    RemoveBlip(blip)
                end
                break
            end
        end
        Citizen.Wait(_Wait)
    end
end)

RegisterNetEvent("ad_tuto:PasseMission")
AddEventHandler("ad_tuto:PasseMission", function()
    SetNuiFocus(true, true)
    SendNUIMessage({type = "tuto", action = "popup", value = "Maintenant que tu as les bases, c’est à toi de jouer !</br> N’oublie pas de rejoindre le discord légal si tu souhaites</br> postuler dans une entreprise, et bon jeu !"})
    PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 1)
end)

function SelectSpawnPoint(name)
    local found = false
    if name == 'Chantier' then
        for j,t in pairs(zoneDeSpawn) do
            local clear = ESX.Game.IsSpawnPointClear(t.pos, 5.0)
            if clear and not found then
                found = true
                return t.pos, t.heading
            end
        end
        return false
    elseif name == 'Superette' then
        for j,t in pairs(zoneDeSpawn2) do
            local clear = ESX.Game.IsSpawnPointClear(t.pos, 5.0)
            if clear and not found then
                found = true
                return t.pos, t.heading
            end
        end
        return false
    elseif name == 'Marie' then
        for j,t in pairs(zoneDeSpawn3) do
            local clear = ESX.Game.IsSpawnPointClear(t.pos, 5.0)
            if clear and not found then
                found = true
                return t.pos, t.heading
            end
        end
        return false
    end
end

RegisterNUICallback('NUIFocusOff', function()
    SetNuiFocus(false, false)
end)