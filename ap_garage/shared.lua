AP = {}
AP.ServerName = 'AP GARAGE' -- Title Notif and Discord Log
AP.Translate = 'en' -- Sorry, only this available 'en' and 'id'
AP.AccessType = 'textui' -- Available =  textui, radial, target. [DEFAULT = textui]
-- If you are using 'radial', you will need a qb-radialmenu that has been converted to ESX, Maybe I'll share later :)


-- ########### TEXT UI ###########
AP.TextUIPos = 'right-center' -- Available = 'right-center' or 'left-center' or 'top-center' [DEFAULT = 'right-center']
AP.TextUIColor = '#f06595' -- Change color in here : https://www.rapidtables.com/web/color/RGB_Color.html [DEFAULT = '#48BB78']
AP.TextUIColorText = 'black' -- Recommended, 'white' and 'black' [DEFAULT = 'black']

-- ########### FEATURE ###########
AP.CopyPlate = true -- Displays copy plate menu in the garage manu (false = Hide Menu). [DEFAULT = true]
AP.CustomName = true -- Displays Custom Vehicle Name menu on a garage menu (false = Hide Menu). [DEFAULT = true]
AP.SearchFeature = true -- Displays the search menu above itself in the garage menu (false = Hide Menu). [DEFAULT = true]
AP.SelectPayment = true -- Select garage payment before the vehicle is released (false = Pay directly with cash). [DEFAULT = true]
AP.TransferKey = true -- Displays transfer Key menu in garage menu (false = Hide Menu). [DEFAULT = true]
AP.UseTaxTransfer = true -- Provides taxes to Players who transfer vehicles (false = Not subject to tax). [DEFAULT = true]
AP.TransferVeh = true -- Displays transfer vehicle menu in garage menu (false = Hide Menu). [DEFAULT = true]
AP.SplitBlipsName = false -- true = name of the garage label will be separate in map according to the label you created. [DEFAULT = false]
AP.AutoTeleportToVehicle = true -- automatically get on the vehicle (false = Vehicle will spawn at the location provided). [DEFAULT = true]

-- ########### VEHICLE IMAGE IN MENU ###########
AP.ShowImageInMenu = true -- Displays vehicle image in menu (false = Hide image). [DEFAULT = true]
AP.NullImageVeh = 'https://www.pngitem.com/pimgs/m/53-534462_car-icons-pdf-car-icon-pdf-hd-png.png' -- If the vehicle does not have an image, then this image will be a replacement, change it to your taste, or better use your server logo

-- ########### FINANCE ###########
AP.FeeCustomName = 10 -- * AP.VehicleFee (Payment for changing a vehicle's name is multiplied depending on the class of the vehicle) [DEFAULT = 10]
AP.FeeResetName = 20 -- * AP.VehicleFee (Payment for changing a vehicle's name is multiplied depending on the class of the vehicle) [DEFAULT = 20]
AP.TaxTransferVeh = 500 -- * AP.VehicleFee (Payment for changing a vehicle's name is multiplied depending on the class of the vehicle) [DEFAULT = 500]
AP.PayWith = 'money' -- [money or bank] Works if (AP.SelectPayment = false) . [DEFAULT = money]

-- ########### KEY ###########
AP.KeyLock = 'G' -- To lock or unlock vehicle. [DEFAULT = G]
AP.AutoLock = true -- false = The first time the vehicle is released, it will not lock automatically. [DEFAULT = true]
AP.KeyFeature = true -- false = Turns off the keylock feature. [DEFAULT = true]
AP.LockCommand = 'lock_vehicle' -- Command for key lock. [DEFAULT = 'lock_vehicle']

-- ########### ANCHOR ###########
AP.KeyAnchor = 'X' -- To Lifting / Installing Boat Anchors. [DEFAULT = X]
AP.AnchorFeature = true -- false = Turns off the anchor feature on the boat. [DEFAULT = true]
AP.AnchorCommand = 'anchor' -- Command for Lifting / Installing Boat Anchors. [DEFAULT = 'anchor']

AP.RadiusGarage_Impound = 3.0 -- Only works when you set textui or radial. [DEFAULT = 3.0]
AP.RadiusSave_Garage = 5.0 -- Only works when you set textui or radial. [DEFAULT = 5.0]
AP.UseLogData = true -- Sending logs TRANSFER VEHICLE, TRANSFER KEY, DELETE KEY, CHANGE VEHICLE NAME AND RESET VEHICLE NAME (false = Turns off discord log). [DEFAULT = false]
AP.Webhook = 'WEBHOOK_HERE' -- Discord Webhook


-- ########### PED GARAGE AND IMPOUND ########### Change Ped in here : https://docs.fivem.net/docs/game-references/ped-models/
AP.PedsGarage = {
    'cs_floyd', -- GARAGE
    's_m_m_dockwork_01' -- IMPOUND
}

-- ########### BLIPS ###########
AP.Blips = {
    Garages = {
        aircraft = {Sprite = 359, Colour = 38, Display = 2, Scale = 0.6},
        car = {Sprite = 357, Colour = 38, Display = 2, Scale = 0.6},
        boats = {Sprite = 356, Colour = 38, Display = 2, Scale = 0.6}

    },
    Impounds = {
        aircraft = {Sprite = 359, Colour = 66, Display = 2, Scale = 0.6},
        car = {Sprite = 357, Colour = 66, Display = 2, Scale = 0.6},
        boats = {Sprite = 356, Colour = 66, Display = 2, Scale = 0.6}
    }
}

-- ########### FINANCE ###########
AP.VehicleFee = { -- Parking fee for each class
    Garages = {
        [0] = 2, -- Compacts
        [1] = 2, -- Sedans
        [2] = 2, -- SUVs
        [3] = 2, -- Coupes
        [4] = 2, -- Muscle
        [5] = 2, -- Sports Classics
        [6] = 2, -- Sports
        [7] = 2, -- Super
        [8] = 1, -- Motorcycles
        [9] = 2, -- Off-road
        [10] = 2, -- Industrial
        [11] = 2, -- Utility
        [12] = 2, -- Vans
        [13] = 0, -- Cylces
        [14] = 10, -- Boats
        [15] = 10, -- Helicopters
        [16] = 10, -- Planes
        [17] = 2, -- Service
        [18] = 0, -- Emergency
        [19] = 2, -- Military
        [20] = 2, -- Commercial
    },
    Impound = { -- Impound fee for each class
        [0] = 10, -- Compacts
        [1] = 10, -- Sedans
        [2] = 10, -- SUVs
        [3] = 10, -- Coupes
        [4] = 10, -- Muscle
        [5] = 10, -- Sports Classics
        [6] = 10, -- Sports
        [7] = 10, -- Super
        [8] = 5, -- Motorcycles
        [9] = 10, -- Off-road
        [10] = 10, -- Industrial
        [11] = 10, -- Utility
        [12] = 10, -- Vans
        [13] = 0, -- Cylces
        [14] = 25, -- Boats
        [15] = 25, -- Helicopters
        [16] = 25, -- Planes
        [17] = 10, -- Service
        [18] = 0, -- Emergency
        [19] = 10, -- Military
        [20] = 10, -- Commercial
    }
}

-- ########### GARAGE ###########
AP.Garages = {
    OlympicFreeway = { -- Garage key to be insert into [parking] database.
        Label = 'Olympic Freeway Garage', -- Label that will appear in MENU, TARGET, TEXT UI or RADIAL MENU
        Type = 'car', -- Only Works 'car', 'aircraft' and 'boats'
        Blip = true, -- Show / Hide BLIPS in map
        NotFree = true, -- false = Free
        Coords = vector4(357.1, -1169.24, 29.29, 3.6), -- Location for PED, BLIPS and access garage
        Players = { -- PRIVATE GARAGE (Leave this if you want to make this a PUBLIC GARAGE)
            -- Example If Using License: {'1234567890xxxxxxxxxxx'} or {'steam:xxxxxxxxxxxx'}
        },
        Groups = { -- JOB GARAGE (Leave this if you want to make this a PUBLIC GARAGE)
            -- Example : {'police'}, {'ambulance'}, {'mechanic'}
        },
        SpawnPoint = { -- Spawn Vehicle Point
            {Pos = vector4(359.92, -1162.78, 28.29, 82.15)},
            {Pos = vector4(359.71, -1159.58, 28.29, 97.18)},
            {Pos = vector4(359.65, -1156.63, 28.29, 90.36)},
            {Pos = vector4(359.41, -1153.69, 28.29, 91.6)},
            {Pos = vector4(346.28, -1153.9, 28.29, 271.53)},
            {Pos = vector4(346.65, -1156.84, 28.29, 272.7)},
            {Pos = vector4(346.56, -1159.99, 28.29, 278.4)},
            {Pos = vector4(346.69, -1162.9, 28.29, 273.56)},
            {Pos = vector4(346.77, -1165.87, 28.29, 272.27)},
        },
        DeletePoint = { -- Delete Vehicle Point
            {Pos = vector3(353.83, -1159.26, 29.29)}
        }
    },

    LowerPierGarage = {
        Label = 'Lower Pier Garage',
        Type = 'boats',
        Blip = true,
        NotFree = true,
        Coords = vector4(-742.43, -1508.03, 5.0, 31.19),
        Players = {},
        Groups = {},
        SpawnPoint = {
            {Pos = vector4(-796.14, -1502.17, 0.12, 111.31)}
        },
        DeletePoint = {
            {Pos = vector3(-796.14, -1502.17, 0.12)}
        }
    },

    LPAirPort = {
        Label = 'Lower Pier Plane Garage',
        Type = 'aircraft',
        Blip = true,
        NotFree = true,
        Coords = vector4(-708.66, -1462.05, 5.0, 52.06),
        Players = {},
        Groups = {
            {'police'}
        },
        SpawnPoint = {
            {Pos = vector4(-723.82, -1443.19, 5.39, 140.29)},
            {Pos = vector4(-745.35, -1468.55, 5.39, 140.29)}
        },
        DeletePoint = {
            {Pos = vector3(-723.82, -1443.19, 5.39)},
        }
    },
}

-- ########### IMPOUND ###########
AP.Impound = {
    SandyShores = {  -- Impound key to be insert into [parking] database.
        Label = 'Impound Olympic Freeway', -- Label that will appear in MENU, TARGET, TEXT UI or RADIAL MENU
        Type = 'car', -- Only Works 'car', 'aircraft' and 'boats'
        IsDefaultImpound = true, -- When Resource starts, the vehicle will enter this impound
        Blip = true, -- Show / Hide BLIPS in map
        NotFree = true, -- false = Free
        Coords = vector4(334.4, -1168.42, 29.34, 1.97), -- Location for PED, BLIPS and access impound
        SpawnPoint = { -- Location Spawn Vehicle
            {Pos = vector4(331.99, -1161.73, 29.29, 3.95)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(258.5054, 2590.7029, 44.4424, 10.3867)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(258.5054, 2590.7029, 44.4424, 10.3867)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(258.5054, 2590.7029, 44.4424, 10.3867)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(258.5054, 2590.7029, 44.4424, 10.3867)}, -- Add a spawn location here, change the coordinates
        }
    },
    
    SandyShoresBoats = {  -- Impound key to be insert into [parking] database.
        Label = 'Impound Boats Sandy Shores', -- Label that will appear in MENU, TARGET, TEXT UI or RADIAL MENU
        Type = 'boats', -- Only Works 'car', 'aircraft' and 'boats'
        IsDefaultImpound = true, -- When Resource starts, the vehicle will enter this impound
        Blip = true, -- Show / Hide BLIPS in map
        NotFree = true, -- false = Free
        Coords = vector4(917.46, 3655.27, 32.48, 9.47), -- Location for PED, BLIPS and access impound
        SpawnPoint = { -- Location Spawn Vehicle
            {Pos = vector4(930.89, 3689.0, 31.0, 345.33)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(930.89, 3689.0, 31.0, 345.33)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(930.89, 3689.0, 31.0, 345.33)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(930.89, 3689.0, 31.0, 345.33)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(930.89, 3689.0, 31.0, 345.33)}, -- Add a spawn location here, change the coordinates
        }
    },
    
    PlaneLowerPier = {  -- Impound key to be insert into [parking] database.
        Label = 'Impound Plane Lower Pier', -- Label that will appear in MENU, TARGET, TEXT UI or RADIAL MENU
        Type = 'aircraft', -- Only Works 'car', 'aircraft' and 'boats'
        IsDefaultImpound = true, -- When Resource starts, the vehicle will enter this impound
        Blip = true, -- Show / Hide BLIPS in map
        NotFree = true, -- false = Free
        Coords = vector4(-719.87, -1475.07, 5.0, 53.03), -- Location for PED, BLIPS and access impound
        SpawnPoint = { -- Location Spawn Vehicle
            {Pos = vector4(-734.37, -1457.15, 5.0, 52.37)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(-734.37, -1457.15, 5.0, 52.37)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(-734.37, -1457.15, 5.0, 52.37)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(-734.37, -1457.15, 5.0, 52.37)}, -- Add a spawn location here, change the coordinates
            -- {Pos = vector4(-734.37, -1457.15, 5.0, 52.37)}, -- Add a spawn location here, change the coordinates
        }
    }
}

-- ########### LANGUAGE ###########
AP.Strings = {
    ['id'] = { -- Indonesia
        cus_name = 'Ganti Nama Kendaraan',
        desc_cus_name = 'Klik untuk mengganti nama kendaraan',
        desc_d_cus_name = 'Masukan nama kendaraan baru :',
        max_text_cus_name = 'Nama kendaraan terlalu panjang!',
        del_cus_name = 'Reset Nama Kendaraan',
        del_desc_cus_name = 'Klik untuk mereset nama kendaraan',
        success_cus_name = 'Berhasil mengganti nama kendaaran menjadi %s',
        success_del_cus_name = 'Berhasil mereset nama kendaaran',
        nomoney_cus_name = 'Membutuhkan $%s untuk mengganti nama kendaraan ini!',
        nomoney_del_cus_name = 'Membutuhkan $%s untuk mereset nama kendaraan ini!',
        nomoney_trans_tax = 'Membutuhkan $%s untuk membayar pajak kendaraan ini!',
        search_menu = 'Cari Kendaraan',
        search_desc = 'Masukan Nama Kendaraan / Plat Nomor :',
        search_example = 'Contoh : Sanchez / ABC 123',
        not_foundsearch = 'Tidak menemukan %s',
        search_result = 'Hasil Pencarian : %s',
        transfer_alert_veh = 'Transfer Kendaraan ke ID %s ?',
        transfer_alert_key = 'Transfer kunci ke ID %s ?',
        car_name = 'Nama Kendaraan : %s',
        car_plate = 'Plat Nomor : %s',
        car_garage = 'Garasi Mobil',
        boats_garage = 'Garasi Kapal',
        air_garage = 'Garasi Helicopter',
        car_imp = 'Impound Mobil',
        boats_imp = 'Impound Kapal',
        air_imp = 'Impound Helicopter',
        select_payment = 'Pilih Pembayaran',
        fee_parking = 'Biaya Parkir $%s',
        fee_impound = 'Biaya Impound $%s',
        total_fee = 'Total Biaya $%s',
        pay_with = 'Bayar menggunakan?',
        title_takeout = 'Keluarkan Kendaraan',
        title_copy_plate = 'Salin Plat Nomor',
        desc_copy_plate = 'Klik untuk menyalin plat nomor',
        title_transfer = 'Transfer Kendaraan',
        def_tax_transfer_veh = '$%s (BANK)',
        content_tax_transfer_veh = 'Pajak : $%s (Menggunakan BANK)',
        desc_tax_transfer_veh = 'Pajak yang harus kamu tanggung : ',
        desc_transfer_key = 'Klik untuk mengirim kunci kendaraan ini',
        title_remove_transfer_key = 'Hapus Kunci yang Ditransfer',
        desc_remove_transfer_key = 'Klik untuk menghapus akses kunci kendaraan',
        alert_remove_transfer_key = 'Tekan Konfirmasi utuk menghapus akses kunci dari kendaraan ini',
        delete_transfer_key = 'Semua akses kunci dari %s telah dihapus!',
        title_transfer_key = 'Transfer Kunci Kendaraan',
        desc_transfer = 'Klik untuk mengirim kendaraan ini',
        dialog_desc_transfer = 'Masukan ID yang ingin diberi kendaraan :',
        dialog_desc_transfer_key = 'Masukan ID yang ingin diberi kunci :',
        slow_bro = 'Kurangi Kecepatan untuk menyimpan kendaraan!',
        key_locked = 'Kendaraan Terkunci',
        key_unlocked = 'Kendaraan Terbuka',
        auto_lock = 'Kendaraanmu Dikunci Otomatis',
        id_offline = 'ID %s Offline!',
        send_to_source = 'Tidak bisa mengirim ke diri sendiri!',
        not_veh_plate = 'Kendaraan dengan plat nomor %s bukan milik Kamu!',
        notif_source_veh = 'Kendaraan dengan plat nomor %s telah dikirim ke %s!',
        notif_target_veh = 'Kamu menerima Kendaraan dengan plat nomor %s, dikirim dari %s!',
        notif_source_key = 'Kunci dengan plat nomor %s telah dikirim ke %s!',
        notif_target_key = 'Kamu menerima Kunci dengan plat nomor %s, dikirim dari %s!',
        pay_parking = 'Membayar Parkir $%s, Menggunakan %s',
        success_save = 'Kendaraan tersimpan!',
        waypoint_veh = 'Kendaraan kamu ditandai pada GPS',
        stat_engine = 'Kesehatan Mesin ',
        stat_body = 'Kesehatan Body ',
        stat_fuel = 'Total Bensin ',
        not_vehicle = 'Tidak Ada Kendaraan!',
        canot_spawn_here = 'Tidak bisa mengeluarkan kendaraan disini!',
        canot_store = 'Tidak bisa menyimpan kendaraan disini!',
        not_yours_veh = 'Ini bukan kendaraan kamu!',
        copy_plate = '%s Berhasil disalin ke clipboard',
        location_blocked = 'Lokasi parkir penuh!',
        veh_outside = 'Kendaraan sudah diluar!',
        no_money = 'Tidak cukup uang!',
        download_assets = 'DOWNLOADING & LOADING Harap Tunggu...',
        save_garages = 'Simpan ke %s',
        save_vehradial = 'Simpan kendaraan',
        open_garageradial = 'Garasi',
        open_impradial = 'Impound',
        anchor_raised = 'Jangkar Diangkat',
        anchor_lowered = 'Jangkar Diturunkan',
        not_anchor = 'Tidak bisa memasang jangkar disini!',
        slow_anchor = 'Kurangi kecepatan untuk memasang jangkar',
        log_transfer_key = 'MENTRANSFER KUNCI \nPlat : %s \nTarget : %s \nLicense : %s',
        log_delete_key = 'MENGHAPUS TRANSFER KUNCI \nPlat : %s',
        log_transfer_veh = 'MENTRANSFER KENDARAAN \nPlat : %s \nTarget : %s \nLicense : %s',
        log_customname_veh = 'MENGGANTI NAMA KENDARAAN \nPlat : %s',
        log_resetname_veh = 'MERESET NAMA KENDARAAN \nPlat : %s',
        keymapping_open = 'Buka Menu Garasi / impound',
        keymapping_save = 'Simpan Kendaraan Kedalam Garasi',
        keymapping_key = 'Mengunci / Membuka Kendaraan Kamu',
        keymapping_anchor = 'Mengangkat / Memasang Jangkar Perahu',
    },
    ['en'] = { -- English
        cus_name = 'Change Vehicle Name',
        desc_cus_name = 'Click to change vehicle name',
        desc_d_cus_name = 'Enter name of the new vehicle :',
        max_text_cus_name = 'Vehicle name is too long!',
        del_cus_name = 'Reset Vehicle Name',
        del_desc_cus_name = 'Click to reset vehicle name',
        success_cus_name = 'Successfully changed vehicle name to %s',
        success_del_cus_name = 'Successfully reset the vehicle name',
        nomoney_cus_name = 'Requires $%s to change name this vehicle!',
        nomoney_del_cus_name = 'Requires $%s to reset name this vehicle!',
        nomoney_trans_tax = 'Requires $%s to pay taxes on these vehicles!',
        search_menu = 'Search Vehicle',
        search_desc = 'Enter Vehicle Name / Number plate :',
        search_example = 'Example: Sanchez / ABC 123',
        not_foundsearch = '%s Not found',
        search_result = 'Search result : %s',
        transfer_alert_veh = 'Transfer Vehicle to ID %s ?',
        transfer_alert_key = 'Transfer Key to ID %s ?',
        car_name = 'Car Name : %s',
        car_plate = 'Number plate : %s',
        car_garage = 'Car Garage',
        boats_garage = 'Boats Garage',
        air_garage = 'Helicopter Garage',
        car_imp = 'Impound Car',
        boats_imp = 'Impound Boats',
        air_imp = 'Impound Helicopter',
        select_payment = 'Select Payment',
        fee_parking = 'Parking fee $%s',
        fee_impound = 'Impound Fees $%s',
        total_fee = 'Total cost $%s',
        pay_with = 'Pay with?',
        title_takeout = 'Take Out Vehicle',
        title_copy_plate = 'Copy License Plate',
        desc_copy_plate = 'Click To Copy Number Plate',
        title_transfer = 'Transfer Vehicle',
        title_transfer_key = 'Transfer Key',
        def_tax_transfer_veh = '$%s (BANK)',
        content_tax_transfer_veh = 'Tax : $%s (Use BANK)',
        desc_tax_transfer_veh = 'Taxes You Receive : ',
        desc_transfer_key = 'Click to send this keys to person',
        title_remove_transfer_key = 'Remove Transfered Key',
        desc_remove_transfer_key = 'Click to remove vehicle key access',
        alert_remove_transfer_key = 'Press Confirm to remove key access from this vehicle',
        delete_transfer_key = 'All key access from %s has been removed!',
        desc_transfer = 'Click to send this vehicle to person',
        dialog_desc_transfer = 'Enter the ID of the person you want to transfer the vehicle to :',
        dialog_desc_transfer_key = 'Enter the ID of the person you want to give the keys to this vehicle :',
        slow_bro = 'Reduce Speed to Store your vehicle!',
        key_locked = 'Vehicle Locked',
        key_unlocked = 'Vehicle Unlocked',
        auto_lock = 'Your vehicle is automatically locked',
        id_offline = 'ID %s Offline!',
        send_to_source = 'Cannot Send to your self!',
        not_veh_plate = 'The vehicle with license plate %s is not yours!',
        notif_source_veh = 'The vehicle with license plate %s has been transferred to %s!',
        notif_target_veh = 'The vehicle with license plate %s has been transferred to you by %s!',
        notif_source_key = 'Key with license plate %s has been transferred to %s!',
        notif_target_key = 'Key with license plate %s has been transferred to you by %s!',
        pay_parking = 'Paying Parking $%s, Using %s',
        success_save = 'Vehicle stored!',
        waypoint_veh = 'Your vehicle is marked on the GPS',
        stat_engine = 'Engine Health ',
        stat_body = 'Body Health ',
        stat_fuel = 'Total Fuel ',
        not_vehicle = 'No Vehicles Found!',
        canot_spawn_here = 'Can\'t get vehicle out here!',
        canot_store = 'Cannot store vehicles in here!',
        not_yours_veh = 'This is not your vehicle!',
        copy_plate = '%s Successfully copied to clipboard',
        location_blocked = 'Parking location is full!',
        veh_outside = 'Vehicle is outside!',
        no_money = 'Not enough money!',
        download_assets = 'DOWNLOADING & LOADING Please wait...',
        save_garages = 'Store to %s',
        save_vehradial = 'Store your vehicle',
        open_garageradial = 'Garage',
        open_impradial = 'Open Impound Lot',
        anchor_raised = 'Anchor Raised',
        anchor_lowered = 'Anchor Lowered',
        not_anchor = 'You cannot anchor here',
        slow_anchor = 'Slow down to use the anchor',
        log_transfer_key = 'TRANSFER KEY \nPlate : %s \nTarget : %s \nLicense : %s',
        log_delete_key = 'REMOVED TRANSFER KEY \nPlat : %s',
        log_transfer_veh = 'TRANSFER VEHICLE \nPlate : %s \nTarget : %s \nLicense : %s',
        log_customname_veh = 'CUSTOM NAME VEHICLE \nPlate : %s',
        log_resetname_veh = 'RESET NAME VEHICLE \nPlate : %s',
        keymapping_open = 'Open Garage / Impound Menu',
        keymapping_save = 'Store vehicle in the garage',
        keymapping_key = 'Lock / Unlock Your Vehicle',
        keymapping_anchor = 'Lifting / Installing Boat Anchors',
    },
}