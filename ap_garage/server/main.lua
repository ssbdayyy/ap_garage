ESX = exports['es_extended']:getSharedObject()
ESX.RegisterServerCallback('ap_garage:VehiclesParking', function(source, cb)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
MySQL.query('SELECT * FROM owned_vehicles WHERE owner = ?', {xPlayer.identifier}, function(result)
if result[1] then
local vehicles = {}
for i = 1, #result, 1 do
local currenType = result[i].type
if currenType == 'helicopter' or currenType == 'airplane' then currenType = 'aircraft' end                
if result[i].parking then
table.insert(vehicles, {vehicle = json.decode(result[i].vehicle), vehNames = result[i].custom_name, plate = result[i].plate, parking = result[i].parking, key_share = result[i].shared_key, vehType = currenType, stored = result[i].stored})
end
end
cb(vehicles)
end
end)
end)
ESX.RegisterServerCallback('ap_garage:GetPlayerMoney', function(source, cb, ngapain, harga)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
local duit = xPlayer.getInventoryItem('money').count
local duit_Transfer = xPlayer.getAccount('bank').money
if ngapain == 'gantinama' then
if duit >= harga * AP.FeeCustomName then
cb(true)
else
cb(false)
end
elseif ngapain == 'hapusnama' then
if duit >= harga * AP.FeeResetName then
cb(true)
else
cb(false)
end
elseif ngapain == 'transferkendaraan' then
if duit_Transfer >= harga * AP.TaxTransferVeh then
cb(true)
else
cb(false)
end
end
end)
ESX.RegisterServerCallback('ap_garage:CheckOwnedVehicle', function(source, cb, plate)
local xPlayer = ESX.GetPlayerFromId(source)
MySQL.query('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate}, function(result)
local data = {}
if result[1] then
if result[1].owner == xPlayer.identifier then
local currenType = result[1].type
if currenType == 'helicopter' or currenType == 'airplane' then currenType = 'aircraft' end
if result[1].type and result[1].stored == 0 then
table.insert(data, {
owner = true,
vehType = currenType
})
cb(data)
end
end
else
cb(false)
end
end)
end)
ESX.RegisterServerCallback('ap_garage:CheckOwnedCar', function(source, cb, plate)
local xPlayer = ESX.GetPlayerFromId(source)
MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE (owner = @owner OR shared_key = @owner) AND plate = @plate', {
['@owner'] = xPlayer.identifier,
['@plate'] = plate
}, function(result)
cb(result[1] ~= nil)
end)
end)
RegisterNetEvent('ap_garage:CheckingVehicle')
AddEventHandler('ap_garage:CheckingVehicle', function(Check, tipeuang)
local xPlayer = ESX.GetPlayerFromId(source)
local vehicles = GetAllVehicles()
local canSpawn = false
if vehicles[1] ~= nil then
for i = 1, #vehicles, 1 do
if ESX.Math.Trim(GetVehicleNumberPlateText(vehicles[i])) == Check.vehicle.plate then
TriggerClientEvent('ap_garage:ShowTextuiAgain', source, Check.garageLabel)
TriggerClientEvent('ap_garage:Notify', source, 'error', AP.Strings[AP.Translate].veh_outside)
return TriggerClientEvent('ap_garage:SetGps', source, GetEntityCoords(vehicles[i]))
end
end
end
if tipeuang == 'money' then
moneytipe = xPlayer.getInventoryItem('money').count
uang = 'Cash'
elseif tipeuang == 'bank' then
moneytipe = xPlayer.getAccount('bank').money
uang = 'Bank'
end
if moneytipe >= Check.price then
if Check.notFree then
xPlayer.removeAccountMoney(tipeuang, Check.price)
TriggerClientEvent('ap_garage:Notify', source, 'inform', (AP.Strings[AP.Translate].pay_parking):format(ESX.Math.GroupDigits(Check.price), uang))
end
canSpawn = true
else
TriggerClientEvent('ap_garage:Notify', xPlayer.source, 'error', AP.Strings[AP.Translate].no_money)
TriggerClientEvent('ap_garage:ShowTextuiAgain', source, Check.garageLabel)
end
if canSpawn then
TriggerClientEvent('ap_garage:SpawnVehicle', xPlayer.source, Check)
end
end)
RegisterServerEvent('ap_garage:PerTransferan')
AddEventHandler('ap_garage:PerTransferan', function(data)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
local xTarget = ESX.GetPlayerFromId(data.id)
if xTarget == nil or xPlayer == nil then
TriggerClientEvent('ap_garage:ShowTextuiAgain', src, data.GarageName)
return TriggerClientEvent('ap_garage:Notify', src, 'error', (AP.Strings[AP.Translate].id_offline):format(data.id))
end
if xTarget.source == xPlayer.source then
TriggerClientEvent('ap_garage:ShowTextuiAgain', src, data.GarageName)
return TriggerClientEvent('ap_garage:Notify', src, 'error', AP.Strings[AP.Translate].send_to_source)
end
TriggerClientEvent('ap_garage:KirimAlertSebelumAnu', src, data)
end)
RegisterServerEvent('ap_garage:GasTransfer')
AddEventHandler('ap_garage:GasTransfer', function(Target, plate, lokasi, giveType, harga)
local src = source
local tgt = Target
local xPlayer = ESX.GetPlayerFromId(src)
local xTarget = ESX.GetPlayerFromId(tgt)
local xidentifier = xPlayer.identifier
local tidentifier = xTarget.identifier
if giveType == 'kirimkunci' then
MySQL.Async.execute('UPDATE owned_vehicles SET shared_key = ? WHERE owner = ? AND plate = ?', {xTarget.identifier, xPlayer.identifier, plate}, function(affectedRows)
TriggerClientEvent('ap_garage:Notify', xPlayer.source, 'success', (AP.Strings[AP.Translate].notif_source_key):format(plate, xTarget.getName()))
TriggerClientEvent('ap_garage:Notify', xTarget.source, 'inform', (AP.Strings[AP.Translate].notif_target_key):format(plate, xPlayer.getName()))
if AP.UseLogData then
LogToDiscord(src, (AP.Strings[AP.Translate].log_transfer_key):format(plate, GetPlayerName(Target), xTarget.identifier), '15844367')
end
end)
elseif giveType == 'kirimkendaraan' then
MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', {xidentifier,  plate}, function(result)
if result[1] ~= nil then
MySQL.Sync.execute('UPDATE owned_vehicles SET owner = ?, shared_key = NULL WHERE plate = ?', {tidentifier, plate})
TriggerClientEvent('ap_garage:Notify', xPlayer.source, 'success', (AP.Strings[AP.Translate].notif_source_veh):format(plate, xTarget.getName()))
TriggerClientEvent('ap_garage:Notify', xTarget.source, 'inform', (AP.Strings[AP.Translate].notif_target_veh):format(plate, xPlayer.getName()))
xPlayer.removeAccountMoney('bank', harga)
if AP.UseLogData then
LogToDiscord(src, (AP.Strings[AP.Translate].log_transfer_veh):format(plate, GetPlayerName(Target), xTarget.identifier), '15844367')
end
else
TriggerClientEvent('ap_garage:Notify', xPlayer.source, 'error', (AP.Strings[AP.Translate].not_veh_plate):format(plate))
end
end)
end
TriggerClientEvent('ap_garage:ShowTextuiAgain', src, lokasi)
end)
RegisterServerEvent('ap_garage:ChangeNameVeh')
AddEventHandler('ap_garage:ChangeNameVeh', function(newName, plate, lokasi, tipenya, bayar)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
if tipenya == 'gantinama' then
MySQL.update('UPDATE owned_vehicles SET custom_name = ? WHERE plate = ? AND owner = ?', {newName, plate, xPlayer.identifier})
TriggerClientEvent('ap_garage:Notify', src, 'success', (AP.Strings[AP.Translate].success_cus_name):format(newName))
if AP.UseLogData then
LogToDiscord(src, (AP.Strings[AP.Translate].log_customname_veh):format(plate), '3066993')
end
elseif tipenya == 'hapusnama' then
MySQL.update('UPDATE owned_vehicles SET custom_name = NULL WHERE plate = ? AND owner = ?', {plate, xPlayer.identifier})
TriggerClientEvent('ap_garage:Notify', src, 'success', AP.Strings[AP.Translate].success_del_cus_name)
if AP.UseLogData then
LogToDiscord(src, (AP.Strings[AP.Translate].log_resetname_veh):format(plate), '3066993')
end
end
xPlayer.removeAccountMoney('money', bayar)
TriggerClientEvent('ap_garage:ShowTextuiAgain', src, lokasi)
end)
RegisterNetEvent('ap_garage:DeleteTransferKey')
AddEventHandler('ap_garage:DeleteTransferKey', function(plate, lokasi)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
MySQL.Async.execute('UPDATE owned_vehicles SET shared_key = NULL WHERE owner = ? AND plate = ?', {xPlayer.identifier, plate}, function(affectedRows)
TriggerClientEvent('ap_garage:Notify', xPlayer.source, 'success', (AP.Strings[AP.Translate].delete_transfer_key):format(plate))
end)
TriggerClientEvent('ap_garage:ShowTextuiAgain', src, lokasi)
if AP.UseLogData then
LogToDiscord(src, (AP.Strings[AP.Translate].log_delete_key):format(plate), '15548997')
end
end)
RegisterServerEvent('ap_garage:UpdateOwnedVehicle')
AddEventHandler('ap_garage:UpdateOwnedVehicle', function(stored, parking, vehicleProps)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
MySQL.update('UPDATE owned_vehicles SET stored = ?, parking = ?, vehicle = ? WHERE plate = ? AND owner = ?', {stored, parking, json.encode(vehicleProps), vehicleProps.plate, xPlayer.identifier})
TriggerClientEvent('ap_garage:Notify', src, 'success', AP.Strings[AP.Translate].success_save)
end)
RegisterNetEvent('ap_garage:UpdateStoredVehicle')
AddEventHandler('ap_garage:UpdateStoredVehicle', function(stored, parking, plate)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
MySQL.update('UPDATE owned_vehicles SET stored = ?, parking = ? WHERE plate = ? AND owner = ?', {stored, parking, plate, xPlayer.identifier})
end)
RegisterServerEvent('ap_garage:UpdateVehicleProperties')
AddEventHandler('ap_garage:UpdateVehicleProperties', function(plate, vehicleProps)
MySQL.update('UPDATE owned_vehicles SET vehicle = ? WHERE plate = ?', {json.encode(vehicleProps), vehicleProps.plate})
end)
RegisterNetEvent('ap_garage:FilterVehiclesType')
AddEventHandler('ap_garage:FilterVehiclesType', function()
MySQL.query('SELECT type, vehicle FROM owned_vehicles WHERE parking IS NULL', {}, function(result)
if result then
for i = 1, #result, 1 do
local tempType = result[i].type
if tempType == 'helicopter' or tempType == 'airplane' then tempType = 'aircraft' end
for impoundName, impound in pairs(AP.Impound) do
if tempType == impound.Type then
if impound.IsDefaultImpound then
MySQL.update('UPDATE owned_vehicles SET stored = 0, parking = ? WHERE type = ? AND parking IS NULL', {impoundName, result[i].type})
end
end
end
end
end
end)
end)
AddEventHandler('onResourceStart', function(resourceName)
if (GetCurrentResourceName() ~= resourceName) then return end
TriggerEvent('ap_garage:FilterVehiclesType')
end)
function LogToDiscord(source, message, color)
if AP.UseLogData and AP.Webhook ~= 'WEBHOOK_HERE' then
local xPlayer = ESX.GetPlayerFromId(source)
local connect = {{['color'] = color, ['title'] = GetPlayerName(source)..' ('.. xPlayer.identifier ..')', ['description'] = message, ['footer'] = { ['text'] = os.date('%H:%M - %d. %m. %Y', os.time()), ['icon_url'] = 'https://cdn.discordapp.com/attachments/1105255852279070772/1113876383203069984/ap.png'}}}
PerformHttpRequest(AP.Webhook, function(err, text, headers) end, 'POST', json.encode({username = AP.ServerName, embeds = connect}), { ['Content-Type'] = 'application/json' })
end
end
