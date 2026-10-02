local ESX = nil
local isFlying = false
local isClimbing = false
local currentHubColor = Config.DefaultHubColor

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    ESX.TriggerServerCallback('kosiny_hub:getSettings', function(settings)
        if settings then
            isFlying = settings.fly_enabled
            isClimbing = settings.climb_enabled
            currentHubColor = settings.hub_color
        end
    end)
end)

RegisterCommand('kosinyhub', function(source, args)
    if args[1] == 'fly' then
        isFlying = not isFlying
        TriggerServerEvent('kosiny_hub:updateSetting', 'fly_enabled', isFlying)
        ESX.ShowNotification('Fly mode ' .. (isFlying and 'enabled' or 'disabled'))
    elseif args[1] == 'climb' then
        isClimbing = not isClimbing
        TriggerServerEvent('kosiny_hub:updateSetting', 'climb_enabled', isClimbing)
        ESX.ShowNotification('Climb mode ' .. (isClimbing and 'enabled' or 'disabled'))
    elseif args[1] == 'color' and Config.HubColors[args[2]] then
        currentHubColor = args[2]
        TriggerServerEvent('kosiny_hub:updateSetting', 'hub_color', currentHubColor)
        ESX.ShowNotification('Hub color changed to ' .. currentHubColor)
    elseif args[1] == 'speed' and tonumber(args[2]) then
        Config.RunSpeed = tonumber(args[2])
        ESX.ShowNotification('Run speed changed to ' .. Config.RunSpeed)
    elseif args[1] == 'jump' and tonumber(args[2]) then
        Config.JumpHeight = tonumber(args[2])
        ESX.ShowNotification('Jump height changed to ' .. Config.JumpHeight)
    elseif args[1] == 'teleport' and tonumber(args[2]) then
        local targetPlayer = tonumber(args[2])
        TriggerServerEvent('kosiny_hub:teleportToPlayer', targetPlayer)
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        if isFlying then
            DisableControlAction(0, 21, true) -- Disable sprint
            DisableControlAction(0, 22, true) -- Disable jump
            if IsControlPressed(0, 32) then -- W key
                SetEntityVelocity(playerPed, 0.0, Config.FlySpeed, 0.0)
            elseif IsControlPressed(0, 33) then -- S key
                SetEntityVelocity(playerPed, 0.0, -Config.FlySpeed, 0.0)
            elseif IsControlPressed(0, 34) then -- A key
                SetEntityVelocity(playerPed, -Config.FlySpeed, 0.0, 0.0)
            elseif IsControlPressed(0, 35) then -- D key
                SetEntityVelocity(playerPed, Config.FlySpeed, 0.0, 0.0)
            elseif IsControlPressed(0, 22) then -- Space key
                SetEntityVelocity(playerPed, 0.0, 0.0, Config.FlySpeed)
            elseif IsControlPressed(0, 36) then -- Left Shift key
                SetEntityVelocity(playerPed, 0.0, 0.0, -Config.FlySpeed)
            else
                SetEntityVelocity(playerPed, 0.0, 0.0, 0.0)
            end
        else
            SetEntityVelocity(playerPed, 0.0, 0.0, 0.0)
        end

        if isClimbing then
            if IsControlPressed(0, 22) then -- Space key
                SetEntityVelocity(playerPed, 0.0, 0.0, Config.ClimbSpeed)
            end
        end

        SetRunSprintMultiplierForPlayer(PlayerId(), Config.RunSpeed)
        SetSuperJumpThisFrame(PlayerId(), Config.JumpHeight)
    end
end)

RegisterNetEvent('kosiny_hub:teleport')
AddEventHandler('kosiny_hub:teleport', function(targetCoords)
    SetEntityCoords(PlayerPedId(), targetCoords.x, targetCoords.y, targetCoords.z)
end)