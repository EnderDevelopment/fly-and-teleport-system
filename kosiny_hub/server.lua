local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('kosiny_hub:getSettings', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT * FROM kosiny_hub_settings WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            cb(result[1])
        else
            MySQL.Async.execute('INSERT INTO kosiny_hub_settings (identifier) VALUES (@identifier)', {
                ['@identifier'] = identifier
            }, function()
                cb({fly_enabled = false, climb_enabled = false, hub_color = Config.DefaultHubColor})
            end)
        end
    end)
end)

RegisterServerEvent('kosiny_hub:updateSetting')
AddEventHandler('kosiny_hub:updateSetting', function(setting, value)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('UPDATE kosiny_hub_settings SET ' .. setting .. ' = @value WHERE identifier = @identifier', {
        ['@value'] = value,
        ['@identifier'] = identifier
    })
end)

RegisterServerEvent('kosiny_hub:teleportToPlayer')
AddEventHandler('kosiny_hub:teleportToPlayer', function(targetPlayer)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(targetPlayer)

    if targetXPlayer then
        local targetPed = GetPlayerPed(targetPlayer)
        local targetCoords = GetEntityCoords(targetPed)

        TriggerClientEvent('kosiny_hub:teleport', source, targetCoords)
    else
        xPlayer.showNotification('Player not found')
    end
end)