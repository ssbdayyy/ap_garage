local ESX = nil
local CZ, CD, radial_impound, radial_garage = nil, nil, nil, nil
local isRunningWorkaround, isDead = false, false
local target_impound, target_garage, garage_ped = {}, {}, {}
local vehClass = {[0]='Compacts',[1]='Sedans',[2]='SUVs',[3]='Coupes',[4]='Muscle',[5]='Sports Classics',[6]='Sports',[7]='Super',[8]='Motorcycles',[9]='Off-road',[10]='Industrial',[11]='Utility',[12]='Vans',[13]='Cylces',[14]='Boats',[15]='Helicopters',[16]='Planes',[17]='Service',[18]='Emergency',[19]='Military',[20]='Commercial'}
CreateThread(function()
while ESX == nil do
ESX = exports['es_extended']:getSharedObject()
Wait(10)
end
while ESX.GetPlayerData().job == nil and ESX.GetPlayerData() == nil do
Citizen.Wait(10)
end
ESX.PlayerData = ESX.GetPlayerData()
end)
CreateThread(function()
for _, v in pairs(AP.Garages) do
if v.Blip then
local blip = AddBlipForCoord(v.Coords)
for blipsType, blips in pairs(AP.Blips.Garages) do
if blipsType == v.Type then
SetBlipSprite(blip, blips.Sprite)
SetBlipColour(blip, blips.Colour)
SetBlipDisplay(blip, blips.Display)
SetBlipScale(blip, blips.Scale)
end
end
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName('STRING')
if AP.SplitBlipsName then
AddTextComponentSubstringPlayerName(v.Label)
else
if v.Type == 'car' then
AddTextComponentSubstringPlayerName(AP.Strings[AP.Translate].car_garage)
elseif v.Type == 'boats' then
AddTextComponentSubstringPlayerName(AP.Strings[AP.Translate].boats_garage)
elseif v.Type == 'aircraft' then
AddTextComponentSubstringPlayerName(AP.Strings[AP.Translate].air_garage)
end
end
EndTextCommandSetBlipName(blip)
end
if AP.AccessType == 'textui' or AP.AccessType == 'target' then   
Spawn_ped_garage(v.Coords, AP.PedsGarage[1])
end
end
for _, v in pairs(AP.Impound) do
if v.Blip then
local blip = AddBlipForCoord(v.Coords)
for blipsType, blips in pairs(AP.Blips.Impounds) do
if blipsType == v.Type then
SetBlipSprite(blip, blips.Sprite)
SetBlipColour(blip, blips.Colour)
SetBlipDisplay(blip, blips.Display)
SetBlipScale(blip, blips.Scale)
end
end
SetBlipAsShortRange(blip, true)
BeginTextCommandSetBlipName('STRING')
if AP.SplitBlipsName then
AddTextComponentSubstringPlayerName(v.Label)
else
if v.Type == 'car' then
AddTextComponentSubstringPlayerName(AP.Strings[AP.Translate].car_imp)
elseif v.Type == 'boats' then
AddTextComponentSubstringPlayerName(AP.Strings[AP.Translate].boats_imp)
elseif v.Type == 'aircraft' then
AddTextComponentSubstringPlayerName(AP.Strings[AP.Translate].air_imp)
end
end
EndTextCommandSetBlipName(blip)
end
if AP.AccessType == 'textui' or AP.AccessType == 'target' then
Spawn_ped_garage(v.Coords, AP.PedsGarage[2])
end
end
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
ESX.PlayerData.job = job
end)
AddEventHandler('esx:onPlayerDeath', function(data)
isDead = true
lib.hideTextUI()
end)
AddEventHandler('esx:onPlayerSpawn', function(data)
isDead = false
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
Wait(500)
ESX.PlayerData = xPlayer
RemoveRadialOptions()
end)
RegisterNetEvent('ap_garage:radialgetvehimpound')
AddEventHandler('ap_garage:radialgetvehimpound', function()
lib.hideTextUI()
for impoundName, impound in pairs(AP.Impound) do
local coords = GetEntityCoords(PlayerPedId())
if Vdist(coords.x, coords.y, coords.z, impound.Coords) < AP.RadiusGarage_Impound and IsPedOnFoot(PlayerPedId()) and not isDead then
local data = {vehType = impound.Type, stored = 0, parkingKey = impoundName, NotFree = impound.NotFree, spawnPoints = impound.SpawnPoint, lokasiPed = impound.Coords, labellokasi = impound.Label}
bukaImpound(data)
end
end
end)
RegisterNetEvent('ap_garage:radialgetveh')
AddEventHandler('ap_garage:radialgetveh', function()
lib.hideTextUI()
for garageName, garage in pairs(AP.Garages) do
local coords = GetEntityCoords(PlayerPedId())
if Vdist(coords.x, coords.y, coords.z, garage.Coords) < AP.RadiusGarage_Impound and HasPlayers(garageName) and HasGroups(garageName) and IsPedOnFoot(PlayerPedId()) and not isDead then
local data = {vehType = garage.Type, stored = 1, parkingKey = garageName, NotFree = garage.NotFree, spawnPoints = garage.SpawnPoint, lokasiPed = garage.Coords, labellokasi = garage.Label}
bukaGarasi(data)
end
end
end)
RegisterNetEvent('ap_garage:radialsaveveh')
AddEventHandler('ap_garage:radialsaveveh', function()
local coords = GetEntityCoords(PlayerPedId())
local vehicle = GetVehiclePedIsIn(PlayerPedId())
local speed = GetEntitySpeed(vehicle)
local kmh = speed * 3.6
for garageName, garage in pairs(AP.Garages) do
for i = 1, #garage.DeletePoint do
local lokasisave = garage.DeletePoint[i].Pos
if (GetDistanceBetweenCoords(coords, vec3(lokasisave.x, lokasisave.y,lokasisave.z), true) < AP.RadiusSave_Garage) and IsPedSittingInAnyVehicle(PlayerPedId()) and HasPlayers(garageName) and HasGroups(garageName) and not isDead then
if kmh <= 20.0 then
SimpanKendaraan(garageName, vehicle)
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].slow_bro)
end
end
end
end
end)
CreateThread(function()
while true do
Sleep = 2500
if IsPedInAnyVehicle(PlayerPedId(), false) then
Sleep = 1000
local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
TriggerServerEvent('ap_garage:UpdateVehicleProperties', vehicleProps.plate, vehicleProps)
end
Wait(Sleep)
end
end)
RegisterNetEvent('ap_garage:Notify')
AddEventHandler('ap_garage:Notify', function(tipe, text)
-- exports['mythic_notify']:SendAlert(tipe, text, 5000)
if tipe == 'error' then
icons = 'xmark'
elseif tipe == 'success' then
icons = 'fa-solid fa-thumbs-up'
elseif tipe == 'inform' then
icons = 'fa-solid fa-circle-info'
end
lib.notify({title = AP.ServerName, description = text, position = 'top', duration = 5000, type = tipe, style = {backgroundColor = '#141517', borderRadius = 10, color = '#C1C2C5', ['.description'] = {color = '#909296'}}, icon = icons})
end)
function StartWorkaroundTask()
if AP.KeyFeature then
if isRunningWorkaround then return end
local timer = 0
local playerPed = PlayerPedId()
isRunningWorkaround = true
while timer < 100 do
Citizen.Wait(0)
timer = timer + 1
local vehicle = GetVehiclePedIsTryingToEnter(playerPed)
if DoesEntityExist(vehicle) then
local lockStatus = GetVehicleDoorLockStatus(vehicle)
if lockStatus == 4 then
ClearPedTasks(playerPed)
end
end
end
isRunningWorkaround = false
end
end
function KunciKendaraan()
if AP.KeyFeature then
local playerPed = PlayerPedId()
local coords = GetEntityCoords(playerPed)
local vehicle
Citizen.CreateThread(function()
StartWorkaroundTask()
end)
if IsPedInAnyVehicle(playerPed, false) then
return
else
vehicle = GetClosestVehicle(coords, 4.0, 0, 71)
end
if not DoesEntityExist(vehicle) then
return
end
ESX.TriggerServerCallback('ap_garage:CheckOwnedCar', function(isOwnedVehicle)
if isOwnedVehicle then
lib.requestAnimDict('anim@mp_player_intmenu@key_fob@')
if not IsPedInAnyVehicle(playerPed, true) then
TaskPlayAnim(playerPed, 'anim@mp_player_intmenu@key_fob@', 'fob_click_fp', 8.0, 8.0, -1, 48, 1, false, false, false)
end
local lockStatus = GetVehicleDoorLockStatus(vehicle)
if lockStatus == 1 then
SetVehicleDoorsLocked(vehicle, 2)
PlayVehicleDoorCloseSound(vehicle, 1)
TriggerEvent('ap_garage:Notify', 'success', AP.Strings[AP.Translate].key_locked)
elseif lockStatus == 2 then 
SetVehicleDoorsLocked(vehicle, 1)
PlayVehicleDoorOpenSound(vehicle, 0)
TriggerEvent('ap_garage:Notify', 'inform', AP.Strings[AP.Translate].key_unlocked)
end
SetVehicleLights(vehicle, 2)
StartVehicleHorn(vehicle, 50, 'HELDDOWN', false)
Citizen.Wait(250)
StartVehicleHorn(vehicle, 50, 'HELDDOWN', false)
SetVehicleLights(vehicle, 0)
Citizen.Wait(250)
SetVehicleLights(vehicle, 2)
Citizen.Wait(250)
SetVehicleLights(vehicle, 0)
end
end, ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)))
end
end
RegisterNetEvent('ap_garage:SetGps')
AddEventHandler('ap_garage:SetGps', function(coords)
SetNewWaypoint(coords.x, coords.y)
TriggerEvent('ap_garage:Notify', 'success', AP.Strings[AP.Translate].waypoint_veh)
end)
RegisterNetEvent('ap_garage:ShowTextuiAgain')
AddEventHandler('ap_garage:ShowTextuiAgain', function(labellokasi)
if AP.AccessType == 'radial' or AP.AccessType == 'textui' then
ShowNamaLokasi(labellokasi, 'fa-solid fa-warehouse')
end
ClearPedTasks(PlayerPedId())
end)
RegisterNetEvent('ap_garage:KirimAlertSebelumAnu')
AddEventHandler('ap_garage:KirimAlertSebelumAnu', function(data)
local CarName = GetLabelText(GetDisplayNameFromVehicleModel(data.vehModel))
if data.giveType == 'kirimkunci' then
textheader = (AP.Strings[AP.Translate].transfer_alert_key):format(data.id)
textcontent = '\n'..(AP.Strings[AP.Translate].car_name):format(CarName)..'  \n'..(AP.Strings[AP.Translate].car_plate):format(data.plate)
elseif data.giveType == 'kirimkendaraan' then
textheader = (AP.Strings[AP.Translate].transfer_alert_veh):format(data.id)
textcontent = '\n'..(AP.Strings[AP.Translate].car_name):format(CarName)..'  \n'..(AP.Strings[AP.Translate].car_plate):format(data.plate)..'  \n'..(AP.Strings[AP.Translate].content_tax_transfer_veh):format(data.harganya)
end
local alert = lib.alertDialog({size = 'sm', header = textheader, content = textcontent, centered = true, cancel = true})
if alert == 'confirm' then
TriggerServerEvent('ap_garage:GasTransfer', data.id, data.plate, data.GarageName, data.giveType, data.harganya)
else
lib.showContext('ap_garage_menufiturgarasi')
end
end)
RegisterNetEvent('ap_garage:SpawnVehicle')
AddEventHandler('ap_garage:SpawnVehicle', function(data)
local foundSpawn, SpawnPoint = GetAvailableVehicleSpawnPoint(data.spawnPoints)
WaitForVehicleToLoad(data.vehicle.model)
ESX.Game.SpawnVehicle(data.vehicle.model, vector3(SpawnPoint.Pos.x, SpawnPoint.Pos.y, SpawnPoint.Pos.z), SpawnPoint.Pos.w, function(vehicle)
SetVehicleEngineHealth(vehicle, data.vehicle.engineHealth)
if data.vehType == 'boats' then
Entity(vehicle).state.fuel = 100
else
SetVehicleFuelLevel(vehicle, data.vehicle.fuelLevel)
end
SetVehicleBodyHealth(vehicle, data.vehicle.bodyHealth)
ESX.Game.SetVehicleProperties(vehicle, data.vehicle)
if AP.AutoTeleportToVehicle then
TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
SetVehicleEngineOn(vehicle, true, true)
else
if AP.AnchorFeature and data.vehType == 'boats' then
SetBoatAnchor(vehicle, true)
SetBoatFrozenWhenAnchored(vehicle, true)
SetForcedBoatLocationWhenAnchored(vehicle, true)
TriggerEvent('ap_garage:Notify', 'inform', AP.Strings[AP.Translate].anchor_lowered)
end
NetworkFadeInEntity(vehicle, false, true)
TriggerEvent('ap_garage:Notify', 'inform', AP.Strings[AP.Translate].auto_lock)
ClearPedTasks(PlayerPedId())
end
PlaceObjectOnGroundProperly(vehicle)
if AP.KeyFeature and AP.AutoLock and data.vehType == 'car' then
SetVehicleDoorsLocked(vehicle, 2)
end
for impoundName, impound in pairs(AP.Impound) do
if data.vehType == impound.Type then
if impound.IsDefaultImpound then
TriggerServerEvent('ap_garage:UpdateStoredVehicle', 0, impoundName, data.vehicle.plate)
end
end
end
end)
end)
RegisterNetEvent('ap_garage:cari_plate')
AddEventHandler('ap_garage:cari_plate', function (searchInput, lokasiparkir, spawnPoints, NotFree, TipeCari, kembali, labellokasi)
ESX.TriggerServerCallback('ap_garage:VehiclesParking', function(vehData)
local alpin_ = {}
for i = 1, #vehData, 1 do
if TipeCari == 'CariGarasi' then
vehStored = vehData[i].stored == 1
NextMenu = 'Garages'
elseif TipeCari == 'CariImpound' then
vehStored = vehData[i].stored == 0
NextMenu = 'Impound'
end
if AP.ShowImageInMenu then
local namamobilnya = string.lower(GetDisplayNameFromVehicleModel(vehData[i].vehicle.model))
if namamobilnya ~= 'carnotfound' then
vehimage = 'https://docs.fivem.net/vehicles/'..namamobilnya..'.webp'
else
vehimage = AP.NullImageVeh
end
else
vehimage = nil
end
if vehData[i].parking == lokasiparkir and vehStored then
local vehLabel = vehData[i].vehNames or GetLabelText(GetMakeNameFromVehicleModel(vehData[i].vehicle.model))..' - '..GetLabelText(GetDisplayNameFromVehicleModel(vehData[i].vehicle.model))
local price = AP.VehicleFee.Garages[GetVehicleClassFromName(vehData[i].vehicle.model)]
if string.match(string.lower(vehLabel), string.lower(searchInput)) or string.match(string.lower(vehData[i].plate), string.lower(searchInput)) then
alpin_[#alpin_+1] = {
title = vehData[i].vehNames or vehLabel,
description = (AP.Strings[AP.Translate].car_plate):format(vehData[i].plate),
icon = GetIcons(vehClass[GetVehicleClassFromName(vehData[i].vehicle.model)]),
image = vehimage,
arrow = true,
metadata = {
{label = AP.Strings[AP.Translate].stat_engine, value = vehData[i].vehicle.engineHealth / 10 ..' %', progress = vehData[i].vehicle.engineHealth / 10},
{label = AP.Strings[AP.Translate].stat_body, value = vehData[i].vehicle.bodyHealth / 10 ..' %', progress = vehData[i].vehicle.bodyHealth / 10},
{label = AP.Strings[AP.Translate].stat_fuel, value = vehData[i].vehicle.fuelLevel..' %', progress = vehData[i].vehicle.fuelLevel},
},
onSelect = function()
local alpin = {tipenya = NextMenu, vehType = vehData[i].vehType, menuKembali = kembali, spawnPoints = spawnPoints, vehicle = vehData[i].vehicle, price = price, parking = vehData[i].parking, parkingKey = lokasiparkir, payment = NotFree, plate = vehData[i].plate, label = vehLabel, labelG = labellokasi, CustomName = vehData[i].vehNames, kunci = vehData[i].key_share}
keluarinKendaraan(alpin)
end
}
end
end
end
if(#alpin_ == 0) then
table.insert(alpin_, {title = (AP.Strings[AP.Translate].not_foundsearch):format(searchInput), disabled = true})
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].not_vehicle)
end
lib.registerContext({
id = 'ap_garage_carimobil',
title = (AP.Strings[AP.Translate].search_result):format(searchInput),
options = alpin_,
menu = kembali,
onExit = function()
if AP.AccessType == 'radial' or AP.AccessType == 'textui' then
ShowNamaLokasi(labellokasi, 'fa-solid fa-warehouse')
end
ClearPedTasks(PlayerPedId())
end
})
lib.showContext('ap_garage_carimobil')
end)
end)
function bukaGarasi(data)
if AP.AccessType ~= 'radial' then
TaskTurnPedToFaceCoord(PlayerPedId(), data.lokasiPed, 1400)
end
ESX.TriggerServerCallback('ap_garage:VehiclesParking', function(vehData)
local alpin_ = {}
if AP.SearchFeature then
table.insert(alpin_, {
title = AP.Strings[AP.Translate].search_menu..'...',
icon = 'fa-solid fa-magnifying-glass',
arrow = true,
onSelect = function()
local input = lib.inputDialog(AP.Strings[AP.Translate].search_menu, {{type = 'input', description = AP.Strings[AP.Translate].search_desc, icon = 'fa-solid fa-magnifying-glass', placeholder = AP.Strings[AP.Translate].search_example, required = true}})
if not input then return lib.showContext('ap_garage_menugarasi') end
TriggerEvent('ap_garage:cari_plate', input[1], data.parkingKey, data.spawnPoints, data.NotFree, 'CariGarasi', 'ap_garage_menugarasi', data.labellokasi)
end
})
end
for i = 1, #vehData, 1 do
if AP.ShowImageInMenu then
local namamobilnya = string.lower(GetDisplayNameFromVehicleModel(vehData[i].vehicle.model))
if namamobilnya ~= 'carnotfound' then
vehimage = 'https://docs.fivem.net/vehicles/'..namamobilnya..'.webp'
else
vehimage = AP.NullImageVeh
end
else
vehimage = nil
end
if data.vehType == vehData[i].vehType and vehData[i].stored == 1 and vehData[i].parking == data.parkingKey then
local vehLabel = GetLabelText(GetMakeNameFromVehicleModel(vehData[i].vehicle.model))..' - '..GetLabelText(GetDisplayNameFromVehicleModel(vehData[i].vehicle.model))
local price = AP.VehicleFee.Garages[GetVehicleClassFromName(vehData[i].vehicle.model)]
alpin_[#alpin_+1] = {
title = vehData[i].vehNames or vehLabel,
description = (AP.Strings[AP.Translate].car_plate):format(vehData[i].plate),
icon = GetIcons(vehClass[GetVehicleClassFromName(vehData[i].vehicle.model)]),
image = vehimage,
arrow = true,
metadata = {
{label = AP.Strings[AP.Translate].stat_engine, value = vehData[i].vehicle.engineHealth / 10 ..' %', progress = vehData[i].vehicle.engineHealth / 10},
{label = AP.Strings[AP.Translate].stat_body, value = vehData[i].vehicle.bodyHealth / 10 ..' %', progress = vehData[i].vehicle.bodyHealth / 10},
{label = AP.Strings[AP.Translate].stat_fuel, value = vehData[i].vehicle.fuelLevel..' %', progress = vehData[i].vehicle.fuelLevel},
},
onSelect = function()
local alpin = {tipenya = 'Garages', vehType = vehData[i].vehType, menuKembali = 'ap_garage_menugarasi', spawnPoints = data.spawnPoints, vehicle = vehData[i].vehicle, price = price, parking = vehData[i].parking, parkingKey = data.parkingKey, payment = data.NotFree, plate = vehData[i].plate, label = vehLabel, labelG = data.labellokasi, CustomName = vehData[i].vehNames, kunci = vehData[i].key_share}
keluarinKendaraan(alpin)
end
}
end
end
lib.registerContext({
id = 'ap_garage_menugarasi',
title = data.labellokasi,
options = alpin_,
onExit = function()
if AP.AccessType == 'radial' or AP.AccessType == 'textui' then
ShowNamaLokasi(data.labellokasi, 'fa-solid fa-warehouse')
end
ClearPedTasks(PlayerPedId())
end
})
lib.showContext('ap_garage_menugarasi')
end)
end
function keluarinKendaraan(alpin)
local alpin_ = {}
local titleVeh = alpin.CustomName or alpin.label
if alpin.tipenya == 'Garages' then
desc = '_'..(AP.Strings[AP.Translate].fee_parking):format(alpin.price)..'_'
elseif alpin.tipenya == 'Impound' then
desc = '_'..(AP.Strings[AP.Translate].fee_impound):format(alpin.price)..'_'
end
table.insert(alpin_, {
title = AP.Strings[AP.Translate].title_takeout,
description = desc,
icon = 'fa-solid fa-right-from-bracket',
onSelect = function()
local spawnData = {type = alpin.tipenya, vehType = alpin.vehType, spawnPoints = alpin.spawnPoints, vehicle = alpin.vehicle, price = alpin.price, notFree = alpin.payment, garageLabel = alpin.labelG}
local foundSpawn, SpawnPoint = GetAvailableVehicleSpawnPoint(alpin.spawnPoints)
if AP.SelectPayment then
if foundSpawn then
local input = lib.inputDialog(AP.Strings[AP.Translate].select_payment, {{type = 'select', label = (AP.Strings[AP.Translate].total_fee):format(alpin.price), description = AP.Strings[AP.Translate].pay_with, default = 'money', options = {{value = 'money', label = 'Cash'}, {value = 'bank', label = 'Bank'}}}})
if not input then return lib.showContext('ap_garage_menufiturgarasi') end
if alpin.tipenya == 'Garages' then
if alpin.parking == alpin.parkingKey then
TriggerServerEvent('ap_garage:CheckingVehicle', spawnData, input[1])
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].canot_spawn_here)
end
elseif alpin.tipenya == 'Impound' then
if alpin.parking == alpin.parkingKey then
TriggerServerEvent('ap_garage:CheckingVehicle', spawnData, input[1])
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].canot_spawn_here)
lib.showContext('ap_garage_menufiturgarasi')
end
end
else
lib.showContext('ap_garage_menufiturgarasi')
end
else
if foundSpawn then
if alpin.tipenya == 'Garages' then
if alpin.parking == alpin.parkingKey then
TriggerServerEvent('ap_garage:CheckingVehicle', spawnData, AP.PayWith)
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].canot_spawn_here)
end
elseif alpin.tipenya == 'Impound' then
if alpin.parking == alpin.parkingKey then
TriggerServerEvent('ap_garage:CheckingVehicle', spawnData, AP.PayWith)
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].canot_spawn_here)
lib.showContext('ap_garage_menufiturgarasi')
end
end
else
lib.showContext('ap_garage_menufiturgarasi')
end
end
end
})
if alpin.tipenya ~= 'Impound' then
if AP.CustomName then
table.insert(alpin_, {
title = AP.Strings[AP.Translate].cus_name,
description = '_'..AP.Strings[AP.Translate].desc_cus_name..'_',
icon = 'fa-solid fa-pen-to-square',
onSelect = function()
ESX.TriggerServerCallback('ap_garage:GetPlayerMoney', function(money)
if money then
if alpin.CustomName then
def = alpin.CustomName
else
def = titleVeh
end
local input = lib.inputDialog(AP.Strings[AP.Translate].cus_name, {{type = 'input', default = def, description = AP.Strings[AP.Translate].desc_d_cus_name, required = true}})
if not input then return lib.showContext('ap_garage_menufiturgarasi') end
if #input[1] >= 50 then
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].max_text_cus_name)
lib.showContext('ap_garage_menufiturgarasi')
return
end 
TriggerServerEvent('ap_garage:ChangeNameVeh', input[1], alpin.plate, alpin.labelG, 'gantinama', alpin.price * AP.FeeCustomName)
else
TriggerEvent('ap_garage:Notify', 'error', (AP.Strings[AP.Translate].nomoney_cus_name):format(ESX.Math.GroupDigits(alpin.price * AP.FeeCustomName)))
lib.showContext('ap_garage_menufiturgarasi')
end
end, 'gantinama', alpin.price)
end
})
if alpin.CustomName then
table.insert(alpin_, {
title = AP.Strings[AP.Translate].del_cus_name,
description = '_'..AP.Strings[AP.Translate].del_desc_cus_name..'_',
icon = 'fa-solid fa-rotate',
onSelect = function()
ESX.TriggerServerCallback('ap_garage:GetPlayerMoney', function(money)
if money then
TriggerServerEvent('ap_garage:ChangeNameVeh', nil, alpin.plate, alpin.labelG, 'hapusnama', alpin.price * AP.FeeResetName)
else
TriggerEvent('ap_garage:Notify', 'error', (AP.Strings[AP.Translate].nomoney_del_cus_name):format(ESX.Math.GroupDigits(alpin.price * AP.FeeResetName)))
lib.showContext('ap_garage_menufiturgarasi')
end
end, 'hapusnama', alpin.price)
end
})
end
end
if AP.CopyPlate then
table.insert(alpin_, {
title = AP.Strings[AP.Translate].title_copy_plate,
description = '_'..AP.Strings[AP.Translate].desc_copy_plate..'_',
icon = 'fa-solid fa-copy',
onSelect = function()
lib.setClipboard(alpin.plate)
lib.showContext('ap_garage_menufiturgarasi')
TriggerEvent('ap_garage:Notify', 'success', (AP.Strings[AP.Translate].copy_plate):format(alpin.plate))
end
})
end
if AP.TransferKey then
if not alpin.kunci then
table.insert(alpin_, {
title = AP.Strings[AP.Translate].title_transfer_key,
description = '_'..AP.Strings[AP.Translate].desc_transfer_key..'_', 
icon = 'fa-solid fa-key',
onSelect = function()
local input = lib.inputDialog(AP.Strings[AP.Translate].title_transfer_key, {{type = 'number', description = AP.Strings[AP.Translate].dialog_desc_transfer_key, min = 1, required = true}})
if not input then return lib.showContext('ap_garage_menufiturgarasi') end
ESX.TriggerServerCallback('ap_garage:CheckOwnedCar', function(isOwnedVehicle)
if isOwnedVehicle then
local ap = { id = tonumber(input[1]), plate = alpin.plate, GarageName = alpin.labelG, vehModel = alpin.vehicle.model, harganya = alpin.price, giveType = 'kirimkunci'}
TriggerServerEvent('ap_garage:PerTransferan', ap)
end
end, alpin.plate)
end
})
else
table.insert(alpin_, {
title = AP.Strings[AP.Translate].title_remove_transfer_key,
description = '_'..AP.Strings[AP.Translate].desc_remove_transfer_key..'_', 
icon = 'fa-solid fa-user-slash',
onSelect = function()
local alert = lib.alertDialog({size = 'sm', content = AP.Strings[AP.Translate].alert_remove_transfer_key, centered = true, cancel = true})
if alert == 'confirm' then
TriggerServerEvent('ap_garage:DeleteTransferKey', alpin.plate, alpin.labelG)
else
lib.showContext('ap_garage_menufiturgarasi')
end
end
})
end
end
if AP.TransferVeh then
table.insert(alpin_, {
title = AP.Strings[AP.Translate].title_transfer,
description = '_'..AP.Strings[AP.Translate].desc_transfer..'_', 
icon = 'fa-solid fa-right-left',
onSelect = function()
ESX.TriggerServerCallback('ap_garage:GetPlayerMoney', function(money)
if money then
local alpin_ = {}
table.insert(alpin_, { type = 'number', description = AP.Strings[AP.Translate].dialog_desc_transfer, min = 1, required = true})
if AP.UseTaxTransfer then
table.insert(alpin_, { type = 'input', default = (AP.Strings[AP.Translate].def_tax_transfer_veh):format(ESX.Math.GroupDigits(alpin.price * AP.TaxTransferVeh)), description = AP.Strings[AP.Translate].desc_tax_transfer_veh, disabled = true, required = true})
end
local inputDialog = lib.inputDialog(AP.Strings[AP.Translate].title_transfer, alpin_)
if not inputDialog then return lib.showContext('ap_garage_menufiturgarasi') end
local ap = { id = tonumber(inputDialog[1]), plate = alpin.plate, GarageName = alpin.labelG, vehModel = alpin.vehicle.model, harganya = alpin.price * AP.TaxTransferVeh, giveType = 'kirimkendaraan'}
TriggerServerEvent('ap_garage:PerTransferan', ap)
else
TriggerEvent('ap_garage:Notify', 'error', (AP.Strings[AP.Translate].nomoney_trans_tax):format(ESX.Math.GroupDigits(alpin.price * AP.TaxTransferVeh)))
lib.showContext('ap_garage_menufiturgarasi')
end
end, 'transferkendaraan', alpin.price)
end
})
end
end
lib.registerContext({
id = 'ap_garage_menufiturgarasi',
title = titleVeh..' | '..alpin.plate,
options = alpin_,
menu = alpin.menuKembali,
onExit = function()
if AP.AccessType == 'radial' or AP.AccessType == 'textui' then
ShowNamaLokasi(alpin.labelG, 'fa-solid fa-key')
end
ClearPedTasks(PlayerPedId())
end
})
lib.showContext('ap_garage_menufiturgarasi')
end
function bukaImpound(data)
if AP.AccessType ~= 'radial' then
TaskTurnPedToFaceCoord(PlayerPedId(), data.lokasiPed, 1400)
end
ESX.TriggerServerCallback('ap_garage:VehiclesParking', function(vehData)
local alpin_ = {}
if AP.SearchFeature then
table.insert(alpin_, {
title = AP.Strings[AP.Translate].search_menu..'...',
icon = 'fa-solid fa-magnifying-glass',
arrow = true,
onSelect = function()
local input = lib.inputDialog(AP.Strings[AP.Translate].search_menu, {{type = 'input', description = AP.Strings[AP.Translate].search_desc, icon = 'fa-solid fa-magnifying-glass', placeholder = AP.Strings[AP.Translate].search_example, required = true}})
if not input then return lib.showContext('ap_garage_menuimpound') end
TriggerEvent('ap_garage:cari_plate', input[1], data.parkingKey, data.spawnPoints, data.NotFree, 'CariImpound', 'ap_garage_menuimpound', data.labellokasi)
end
})
end
for i = 1, #vehData, 1 do
if AP.ShowImageInMenu then
local namamobilnya = string.lower(GetDisplayNameFromVehicleModel(vehData[i].vehicle.model))
if namamobilnya ~= 'carnotfound' then
vehimage = 'https://docs.fivem.net/vehicles/'..namamobilnya..'.webp'
else
vehimage = AP.NullImageVeh
end
else
vehimage = nil
end
if data.vehType == vehData[i].vehType and vehData[i].stored == 0 then
local vehLabel = GetLabelText(GetMakeNameFromVehicleModel(vehData[i].vehicle.model))..' - '..GetLabelText(GetDisplayNameFromVehicleModel(vehData[i].vehicle.model))
local price = AP.VehicleFee.Impound[GetVehicleClassFromName(vehData[i].vehicle.model)]
alpin_[#alpin_+1] = {
title = vehData[i].vehNames or vehLabel,
description = (AP.Strings[AP.Translate].car_plate):format(vehData[i].plate),
icon = GetIcons(vehClass[GetVehicleClassFromName(vehData[i].vehicle.model)]),
image = vehimage,
arrow = true,
metadata = {
{label = AP.Strings[AP.Translate].stat_engine, value = vehData[i].vehicle.engineHealth / 10 ..' %', progress = vehData[i].vehicle.engineHealth / 10},
{label = AP.Strings[AP.Translate].stat_body, value = vehData[i].vehicle.bodyHealth / 10 ..' %', progress = vehData[i].vehicle.bodyHealth / 10},
{label = AP.Strings[AP.Translate].stat_fuel, value = vehData[i].vehicle.fuelLevel..' %', progress = vehData[i].vehicle.fuelLevel},
},
onSelect = function()
local alpin = {tipenya = 'Impound', vehType = vehData[i].vehType, menuKembali = 'ap_garage_menuimpound', spawnPoints = data.spawnPoints, vehicle = vehData[i].vehicle, price = price, parking = vehData[i].parking, parkingKey = data.parkingKey, payment = data.NotFree, plate = vehData[i].plate, label = vehLabel, labelG = data.labellokasi, CustomName = vehData[i].vehNames}
keluarinKendaraan(alpin)
end
}
end
end
lib.registerContext({
id = 'ap_garage_menuimpound',
title = data.labellokasi,
options = alpin_,
onExit = function()
if AP.AccessType == 'radial' or AP.AccessType == 'textui' then
ShowNamaLokasi(data.labellokasi, 'fa-solid fa-key')
end
ClearPedTasks(PlayerPedId())
end
})
lib.showContext('ap_garage_menuimpound')
end, data.vehType)
end
function SimpanKendaraan(garageName, vehicle)
local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
ESX.TriggerServerCallback('ap_garage:CheckOwnedVehicle', function(data)
if data and data[1].owner then
if AP.Garages[garageName].Type == data[1].vehType then
if DoesEntityExist(vehicle) then
TaskLeaveVehicle(PlayerPedId(), vehicle, 1)
RemoveRadialOptions()
lib.hideTextUI()
Wait(1500)
NetworkFadeOutEntity(vehicle, false, true)
Wait(500)
DeleteVehicle(vehicle)
TriggerServerEvent('ap_garage:UpdateOwnedVehicle', 1, garageName, vehicleProps)
end
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].canot_store)
end
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].not_yours_veh)
end
end, vehicleProps.plate)
end
function RemoveRadialOptions()
if radial_impound ~= nil then
exports['qb-radialmenu']:RemoveOption(radial_impound)
radial_impound = nil
end
if radial_garage ~= nil then
exports['qb-radialmenu']:RemoveOption(radial_garage)
radial_garage = nil
end
end
function GetIcons(vehClass)
if vehClass == 'Motorcycles' then
return 'motorcycle'
elseif vehClass == 'Cylces' then
return 'bicycle'
elseif vehClass == 'Boats' then
return 'ship'
elseif vehClass == 'Helicopters' then
return 'helicopter'
elseif vehClass == 'Planes' then
return 'plane'
else
return 'fa-solid fa-car'
end
end
function GetAvailableVehicleSpawnPoint(spawnPoints)
local found, foundSpawnPoint = false, nil
for i = 1, #spawnPoints, 1 do
if ESX.Game.IsSpawnPointClear(vec3(spawnPoints[i].Pos.x, spawnPoints[i].Pos.y, spawnPoints[i].Pos.z), 5.0) then
found, foundSpawnPoint = true, spawnPoints[i]
break
end
end
if found then
return true, foundSpawnPoint
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].location_blocked)
return false
end
end
function WaitForVehicleToLoad(modelHash)
modelHash = (type(modelHash) == 'number' and modelHash or joaat(modelHash))
RequestModel(modelHash)
BeginTextCommandBusyspinnerOn('STRING')
AddTextComponentSubstringPlayerName(AP.Strings[AP.Translate].download_assets)
EndTextCommandBusyspinnerOn(4)
while not HasModelLoaded(modelHash) do
Wait(0)
DisableAllControlActions(0)
end
BusyspinnerOff()
end
function HasPlayers(garage)
local players = AP.Garages[garage].Players[1]
if players then
for i = 1, #players, 1 do
local Player = players[i]
if ESX.PlayerData.identifier == Player then
return true
end
end
else
return true
end
end
function HasGroups(garage)
local Groups = AP.Garages[garage].Groups[1]
if Groups then
for i = 1, #Groups, 1 do
local Group = Groups[i]
if ESX.PlayerData.job.name == Group then
return true
end
end
else
return true
end
end
function Spawn_ped_garage(coords, model)
local hash = GetHashKey(model)
RequestModel(hash)
while not HasModelLoaded(hash) do
Wait(15)
end
local ped_garage = CreatePed(4, hash, coords.x, coords.y, coords.z - 1, coords.w, 3374176, false, true)
SetPedAsGroupMember(ped_garage, GetPedGroupIndex(PlayerPedId()))
TaskStartScenarioInPlace(ped_garage, 'WORLD_HUMAN_GUARD_STAND')
FreezeEntityPosition(ped_garage, true)
SetEntityInvincible(ped_garage, true)
SetBlockingOfNonTemporaryEvents(ped_garage, true)
table.insert(garage_ped, ped_garage)
end
AddEventHandler('onResourceStop', function(resource)
if resource == GetCurrentResourceName() then
for k, v in pairs(garage_ped) do
DeleteObject(v)
garage_ped[k] = nil
end
RemoveRadialOptions()
end
end)
function ShowNamaLokasi(LOKASI, ICON)
if AP.AccessType == 'target' or AP.AccessType == 'textui' then
text = '**[E] - '..LOKASI..'**'
elseif AP.AccessType == 'radial' then
text = '**[F1] - '..LOKASI..'**'
end
lib.showTextUI(text, {position = AP.TextUIPos, icon = ICON, style = {borderRadius = 10, backgroundColor = AP.TextUIColor, color = AP.TextUIColorText}})
end
if AP.AccessType == 'textui' then
RegisterKeyMapping('open_garage', AP.Strings[AP.Translate].keymapping_open, 'keyboard', 'E')
RegisterCommand('open_garage', function()
if CZ == nil or ESX.IsPlayerLoaded() == false or isDead then return end
if CZ == 'lokasi_garasi' and IsPedOnFoot(PlayerPedId()) then
TriggerEvent('ap_garage:radialgetveh')
elseif CZ == 'lokasi_impound' and IsPedOnFoot(PlayerPedId()) then
TriggerEvent('ap_garage:radialgetvehimpound')
end
end, false)
end
if AP.AccessType == 'textui' or AP.AccessType == 'target' then
RegisterKeyMapping('save_vehicle', AP.Strings[AP.Translate].keymapping_save, 'keyboard', 'E')
RegisterCommand('save_vehicle', function()
if CZ ~= 'lokasi_simpan' or ESX.IsPlayerLoaded() == false or isDead then return end
TriggerEvent('ap_garage:radialsaveveh')
end, false)
end
if AP.KeyFeature then
RegisterKeyMapping(AP.LockCommand, AP.Strings[AP.Translate].keymapping_key, 'keyboard', AP.KeyLock)
RegisterCommand(AP.LockCommand, function()
KunciKendaraan()
Citizen.Wait(300)
end, false)
end
if AP.AnchorFeature then
RegisterKeyMapping(AP.AnchorCommand, AP.Strings[AP.Translate].keymapping_anchor, 'keyboard', AP.KeyAnchor)
RegisterCommand(AP.AnchorCommand,function(source)
local ped = PlayerPedId()
if IsPedInAnyBoat(ped) and not IsPedOnFoot(ped) then
local boat = GetVehiclePedIsIn(ped)
if GetPedInVehicleSeat(boat, -1) == ped then
if GetEntitySpeed(ped) <= 10 / 3.6 then -- KM/H
if IsBoatAnchoredAndFrozen(boat) then
SetBoatAnchor(boat, false)
SetBoatFrozenWhenAnchored(boat, false)
SetForcedBoatLocationWhenAnchored(boat, false)
TriggerEvent('ap_garage:Notify', 'success', AP.Strings[AP.Translate].anchor_raised)
else
if CanAnchorBoatHere(boat) then
SetBoatAnchor(boat, true)
SetBoatFrozenWhenAnchored(boat, true)
SetForcedBoatLocationWhenAnchored(boat, true)
TriggerEvent('ap_garage:Notify', 'inform', AP.Strings[AP.Translate].anchor_lowered)
else
TriggerEvent('ap_garage:Notify', 'error', AP.Strings[AP.Translate].not_anchor)
end
end
else
TriggerEvent('ap_garage:Notify', 'inform', AP.Strings[AP.Translate].slow_anchor)
end
end
end
end, false)
CreateThread(function()
while true do
Wait(500)
local veh = GetVehiclePedIsEntering(PlayerPedId())
if IsBoatAnchoredAndFrozen(veh) then
if IsVehicleEngineOn(veh) then
SetBoatAnchor(veh, false)
SetBoatFrozenWhenAnchored(veh, false)
SetForcedBoatLocationWhenAnchored(veh, false)
TriggerEvent('ap_garage:Notify', 'success', AP.Strings[AP.Translate].anchor_raised)
end
end
end
end)
end
CreateThread(function()   
while true do
local sleep = 1000
local ped = PlayerPedId()
local coords = GetEntityCoords(ped)
for impoundName, impound in pairs(AP.Impound) do
if Vdist(coords.x, coords.y, coords.z, impound.Coords) < AP.RadiusGarage_Impound and CZ ~= 'lokasi_impound' and IsPedOnFoot(ped) and not isDead then
sleep = 1000
if AP.AccessType == 'target' then
local target_bukagarasi = exports.ox_target:addSphereZone({
coords = impound.Coords,
radius = 1,
debug = false,
options = {
{
name = 'target_impound',
icon = 'fa-solid fa-key',
label = impound.Label,
event = 'ap_garage:radialgetvehimpound',
distance = 2.5,
canInteract = function()
if IsPedInAnyVehicle(ped) or isDead or lib.progressActive() then
return false
end
return true
end
}
}
})
table.insert(target_impound, target_bukagarasi)
elseif AP.AccessType == 'radial' then
ShowNamaLokasi(impound.Label, 'fa-solid fa-key')
radial_impound = exports['qb-radialmenu']:AddOption({
id = 'open_garage_menu',
title = AP.Strings[AP.Translate].open_impradial,
icon = 'warehouse',
type = 'client',
event = 'ap_garage:radialgetvehimpound',
shouldClose = true
}, radial_impound)
elseif AP.AccessType == 'textui' then
ShowNamaLokasi(impound.Label, 'fa-solid fa-key')
end
CZ = 'lokasi_impound'
CD = impoundName
elseif Vdist(coords.x, coords.y, coords.z, impound.Coords) > AP.RadiusGarage_Impound and CZ == 'lokasi_impound' and CD == impoundName and not isDead then   
if CZ ~= nil then
if AP.AccessType == 'target' then
for k, v in pairs(target_impound) do
exports.ox_target:removeZone(v)
target_impound[k] = nil
end
elseif AP.AccessType == 'radial' then
RemoveRadialOptions()
lib.hideTextUI()
elseif AP.AccessType == 'textui' then
RemoveRadialOptions()
lib.hideTextUI()
end
end
CZ = nil
CD = nil
end
end
for garageName, garage in pairs(AP.Garages) do
if Vdist(coords.x, coords.y, coords.z, garage.Coords) < AP.RadiusGarage_Impound and CZ ~= 'lokasi_garasi' and HasPlayers(garageName) and HasGroups(garageName) and IsPedOnFoot(ped) and not isDead then
sleep = 1000
if AP.AccessType == 'target' then
local target_bukagarasi = exports.ox_target:addSphereZone({
coords = garage.Coords,
radius = 1,
debug = false,
options = {
{
name = 'target_garage',
icon = 'fa-solid fa-warehouse',
label = garage.Label,
event = 'ap_garage:radialgetveh',
distance = 2.5,
canInteract = function()
if IsPedInAnyVehicle(ped) or isDead or lib.progressActive() then
return false
end
return true
end
}
}
})
table.insert(target_garage, target_bukagarasi)
elseif AP.AccessType == 'radial' then
ShowNamaLokasi(garage.Label, 'fa-solid fa-warehouse')
radial_garage = exports['qb-radialmenu']:AddOption({
id = 'open_garage_menus',
title = AP.Strings[AP.Translate].open_garageradial,
icon = 'warehouse',
type = 'client',
event = 'ap_garage:radialgetveh',
shouldClose = true
}, radial_garage)
elseif AP.AccessType == 'textui' then
ShowNamaLokasi(garage.Label, 'fa-solid fa-warehouse')
end
CZ = 'lokasi_garasi'
CD = garageName
elseif Vdist(coords.x, coords.y, coords.z, garage.Coords) > AP.RadiusGarage_Impound and CZ == 'lokasi_garasi' and CD == garageName and not isDead then   
if CZ ~= nil then
if AP.AccessType == 'target' then
for k, v in pairs(target_garage) do
exports.ox_target:removeZone(v)
target_garage[k] = nil
end
elseif AP.AccessType == 'radial' then
RemoveRadialOptions()
lib.hideTextUI()
elseif AP.AccessType == 'textui' then
RemoveRadialOptions()
lib.hideTextUI()
end
end
CZ = nil
CD = nil
end
for i = 1, #garage.DeletePoint do
if Vdist(coords.x, coords.y, coords.z, garage.DeletePoint[i].Pos) < AP.RadiusSave_Garage and CZ ~= 'lokasi_simpan' and HasPlayers(garageName) and HasGroups(garageName) and IsPedSittingInAnyVehicle(ped) and not isDead then   
sleep = 1000
if AP.AccessType == 'target' or AP.AccessType == 'textui' then
ShowNamaLokasi((AP.Strings[AP.Translate].save_garages):format(garage.Label), 'square-parking')
elseif AP.AccessType == 'radial' then
ShowNamaLokasi((AP.Strings[AP.Translate].save_garages):format(garage.Label), 'square-parking')
radial_impound = exports['qb-radialmenu']:AddOption({
id = 'put_up_vehicle',
title = AP.Strings[AP.Translate].save_vehradial,
icon = 'square-parking',
type = 'client',
event = 'ap_garage:radialsaveveh',
shouldClose = true
}, radial_impound)
end
CZ = 'lokasi_simpan'
CD = garageName
elseif Vdist(coords.x, coords.y, coords.z, garage.DeletePoint[i].Pos) > AP.RadiusSave_Garage and CZ == 'lokasi_simpan' and CD == garageName and not isDead then
if CZ ~= nil then
if AP.AccessType == 'target'or AP.AccessType == 'textui' then
lib.hideTextUI()
elseif AP.AccessType == 'radial' then
RemoveRadialOptions()
lib.hideTextUI()
end
end
CZ = nil
CD = nil
end
end
end
Wait(sleep)
end
end)
