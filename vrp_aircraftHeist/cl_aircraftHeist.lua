aircraftHeist_wave1 = false
startedHacking = false
aircraftHeist_ready = false
collected = false

RegisterNetEvent('aircraftHeist:addBlip')
AddEventHandler('aircraftHeist:addBlip', function(pos)
	blip = AddBlipForCoord(pos.x, pos.y, pos.z)
end)

RegisterNetEvent('aircraftHeist:helpText')
AddEventHandler('aircraftHeist:helpText', function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)
        local startJobPos = Config.startJobPos
        local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, startJobPos.x, startJobPos.y, startJobPos.z)

        if distance < 300 and not aircraftHeist_wave1 and aircraftHeist_ready then
            TriggerEvent('aircraftHeist:addBlip', startJobPos)
            spawnPeds_wave1()
        end

        if distance < 0.5 and not startedHacking then
            TriggerServerEvent('aircraftHeist:canHack')
            if IsControlJustReleased(0, 38) and not startedHacking then
                RemoveBlip(blip)
                startedHacking = true
                FreezeEntityPosition(PlayerPedId(), true)
                RequestAnimDict("missheist_jewel@hacking")
                TaskPlayAnim(PlayerPedId(), "missheist_jewel@hacking", "hack_loop", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                Citizen.Wait(6000)
                TriggerServerEvent('aircraftHeist:startedHacking', true)
                spawnPeds_wave2()
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedSecondaryTask(PlayerPedId())
			end
		end
	end
end)

RegisterNetEvent('aircraftHeist:collectPackage')
AddEventHandler('aircraftHeist:collectPackage', function(pickupLoc)
    Citizen.CreateThread(function()
        collected = false
        while not collected do
            Citizen.Wait(1)
            local playerPos = GetEntityCoords(PlayerPedId(), true)
            local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, pickupLoc.x, pickupLoc.y, pickupLoc.z)
            local msg = 'Hit ~INPUT_CONTEXT~ to pickup package'
            
            if distance < 0.5 then
                TriggerEvent('aircraftHeist:helpText', msg)
                if IsControlJustReleased(0, 38) then
                    RemoveBlip(blip)
                    TriggerServerEvent('aircraftHeist:collected')
                    collected = true
                end
            end
        end
    end)
end)

RegisterNetEvent('aircraftHeist:reset')
AddEventHandler('aircraftHeist:reset', function()
    print("resetting wave 1, startedhacking, collected and ready")
    aircraftHeist_wave1 = false
    startedHacking = false
    aircraftHeist_ready = false
    collected = false
    ClearAreaOfPeds(Config.startJobPos.x, Config.startJobPos.y, Config.startJobPos.z, 10000, 1)
end)

RegisterNetEvent('aircraftHeist:ready')
AddEventHandler('aircraftHeist:ready', function()
    --print("setting to ready")
    aircraftHeist_ready = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        TriggerServerEvent('aircraftHeist:isTimerUp')
        TriggerServerEvent('aircraftHeist:isCompleted')
	end
end)

function spawnPeds_wave1()
    aircraftHeist_wave1 = true

    AddRelationshipGroup('aircraftPeds')
    RequestModel(-1275859404)
    ---- FIRST PART OF GROUND LAYER/WEST ----

    Citizen.Wait(5000)

    carrierPed1a = CreatePed(30, -1275859404, 3086.49, -4712.45, 15.26, 197.71, true, false)
    SetPedArmour(carrierPed1a, 100)
    SetPedAsEnemy(carrierPed1a, true)
    SetPedRelationshipGroupHash(carrierPed1a, 'aircraftPeds')
    GiveWeaponToPed(carrierPed1a, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed1a, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed1a, 75)
    SetPedDropsWeaponsWhenDead(carrierPed1a, false)

    carrierPed1b = CreatePed(30, -1275859404, 3089.69, -4725.52, 15.26, 196.34, true, false)
    SetPedArmour(carrierPed1b, 100)
    SetPedAsEnemy(carrierPed1b, true)
    SetPedRelationshipGroupHash(carrierPed1b, 'aircraftPeds')
    GiveWeaponToPed(carrierPed1b, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed1b, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed1b, 75)
    SetPedDropsWeaponsWhenDead(carrierPed1b, false)

    carrierPed1c = CreatePed(30, -1275859404, 3087.4, -4723.74, 15.26, 109.34, true, false)
    SetPedArmour(carrierPed1c, 100)
    SetPedAsEnemy(carrierPed1c, true)
    SetPedRelationshipGroupHash(carrierPed1c, 'aircraftPeds')
    GiveWeaponToPed(carrierPed1c, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed1c, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed1c, 75)
    SetPedDropsWeaponsWhenDead(carrierPed1c, false)

    carrierPed1d = CreatePed(30, -1275859404, 3080.8, -4705.13, 15.26, 111.86, true, false)
    SetPedArmour(carrierPed1d, 100)
    SetPedAsEnemy(carrierPed1d, true)
    SetPedRelationshipGroupHash(carrierPed1d, 'aircraftPeds')
    GiveWeaponToPed(carrierPed1d, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed1d, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed1d, 75)
    SetPedDropsWeaponsWhenDead(carrierPed1d, false)

    ---- SECOND PART OF GROUND LAYER/EAST ----

    carrierped2a = CreatePed(30, -1275859404, 3086.49, -4712.45, 15.26, 197.71, true, false)
    SetPedArmour(carrierped2a, 100)
    SetPedAsEnemy(carrierped2a, true)
    SetPedRelationshipGroupHash(carrierped2a, 'aircraftPeds')
    GiveWeaponToPed(carrierped2a, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped2a, GetPlayerPed(-1))
    SetPedAccuracy(carrierped2a, 75)
    SetPedDropsWeaponsWhenDead(carrierped2a, false)

    carrierped2b = CreatePed(30, -1275859404, 3089.69, -4725.52, 15.26, 196.34, true, false)
    SetPedArmour(carrierped2b, 100)
    SetPedAsEnemy(carrierped2b, true)
    SetPedRelationshipGroupHash(carrierped2b, 'aircraftPeds')
    GiveWeaponToPed(carrierped2b, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped2b, GetPlayerPed(-1))
    SetPedAccuracy(carrierped2b, 75)
    SetPedDropsWeaponsWhenDead(carrierped2b, false)

    carrierped2c = CreatePed(30, -1275859404, 3087.4, -4723.74, 15.26, 109.34, true, false)
    SetPedArmour(carrierped2c, 100)
    SetPedAsEnemy(carrierped2c, true)
    SetPedRelationshipGroupHash(carrierped2c, 'aircraftPeds')
    GiveWeaponToPed(carrierped2c, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped2c, GetPlayerPed(-1))
    SetPedAccuracy(carrierped2c, 75)
    SetPedDropsWeaponsWhenDead(carrierped2c, false)

    carrierped2d = CreatePed(30, -1275859404, 3080.8, -4705.13, 15.26, 111.86, true, false)
    SetPedArmour(carrierped2d, 100)
    SetPedAsEnemy(carrierped2d, true)
    SetPedRelationshipGroupHash(carrierped2d, 'aircraftPeds')
    GiveWeaponToPed(carrierped2d, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped2d, GetPlayerPed(-1))
    SetPedAccuracy(carrierped2d, 75)
    SetPedDropsWeaponsWhenDead(carrierped2d, false)

    ---- UPPER LAYER/HACKING LAYER WEST ----

    Citizen.Wait(5000)

    carrierPed3a = CreatePed(30, -1275859404, 3088.42, -4723.48, 24.26, 107.9, true, false)
    SetPedArmour(carrierPed3a, 100)
    SetPedAsEnemy(carrierPed3a, true)
    SetPedRelationshipGroupHash(carrierPed3a, 'aircraftPeds')
    GiveWeaponToPed(carrierPed3a, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed3a, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed3a, 75)
    SetPedDropsWeaponsWhenDead(carrierPed3a, false)

    carrierped3b = CreatePed(30, -1275859404, 3086.81, -4717.12, 24.26, 111.29, true, false)
    SetPedArmour(carrierped3b, 100)
    SetPedAsEnemy(carrierped3b, true)
    SetPedRelationshipGroupHash(carrierped3b, 'aircraftPeds')
    GiveWeaponToPed(carrierped3b, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped3b, GetPlayerPed(-1))
    SetPedAccuracy(carrierped3b, 75)
    SetPedDropsWeaponsWhenDead(carrierped3b, false)

    carrierped3c = CreatePed(30, -1275859404, 3082.32, -4700, 24.26, 103.37, true, false)
    SetPedArmour(carrierped3c, 100)
    SetPedAsEnemy(carrierped3c, true)
    SetPedRelationshipGroupHash(carrierped3c, 'aircraftPeds')
    GiveWeaponToPed(carrierped3c, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped3c, GetPlayerPed(-1))
    SetPedAccuracy(carrierped3c, 75)
    SetPedDropsWeaponsWhenDead(carrierped3c, false)

    carrierped3d = CreatePed(30, -1275859404, 3081.32, -4696.06, 24.26, 105.74, true, false)
    SetPedArmour(carrierped3d, 100)
    SetPedAsEnemy(carrierped3d, true)
    SetPedRelationshipGroupHash(carrierped3d, 'aircraftPeds')
    GiveWeaponToPed(carrierped3d, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped3d, GetPlayerPed(-1))
    SetPedAccuracy(carrierped3d, 75)
    SetPedDropsWeaponsWhenDead(carrierped3d, false)

    ---- UPPER LAYER/HACKING LAYER EAST ----
    
    carrierped4a = CreatePed(30, -1275859404, 3092.74, -4692.6, 24.26, 288.87, true, false)
    SetPedArmour(carrierped4a, 100)
    SetPedAsEnemy(carrierped4a, true)
    SetPedRelationshipGroupHash(carrierped4a, 'aircraftPeds')
    GiveWeaponToPed(carrierped4a, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped4a, GetPlayerPed(-1))
    SetPedAccuracy(carrierped4a, 75)
    SetPedDropsWeaponsWhenDead(carrierped4a, false)

    carrierped4b = CreatePed(30, -1275859404, 3093.99, -4697.29, 24.26, 289.11, true, false)
    SetPedArmour(carrierped4b, 100)
    SetPedAsEnemy(carrierped4b, true)
    SetPedRelationshipGroupHash(carrierped4b, 'aircraftPeds')
    GiveWeaponToPed(carrierped4b, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped4b, GetPlayerPed(-1))
    SetPedAccuracy(carrierped4b, 75)
    SetPedDropsWeaponsWhenDead(carrierped4b, false)

    carrierped4c = CreatePed(30, -1275859404, 3097.74, -4710.6, 24.26, 289.34, true, false)
    SetPedArmour(carrierped4c, 100)
    SetPedAsEnemy(carrierped4c, true)
    SetPedRelationshipGroupHash(carrierped4c, 'aircraftPeds')
    GiveWeaponToPed(carrierped4c, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped4c, GetPlayerPed(-1))
    SetPedAccuracy(carrierped4c, 75)
    SetPedDropsWeaponsWhenDead(carrierped4c, false)

    carrierped4d = CreatePed(30, -1275859404, 3099.97, -4720.61, 24.26, 286.4, true, false)
    SetPedArmour(carrierped4d, 100)
    SetPedAsEnemy(carrierped4d, true)
    SetPedRelationshipGroupHash(carrierped4d, 'aircraftPeds')
    GiveWeaponToPed(carrierped4d, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierped4d, GetPlayerPed(-1))
    SetPedAccuracy(carrierped4d, 75)
    SetPedDropsWeaponsWhenDead(carrierped4d, false)

end

function spawnPeds_wave2()

    AddRelationshipGroup('aircraftPeds')
    RequestModel(-1275859404)

    Citizen.Wait(5000)

    carrierPed5a = CreatePed(30, -1275859404, 3074.96, -4703.41, 10.74, 100.04, true, false)
    SetPedArmour(carrierPed5a, 100)
    SetPedAsEnemy(carrierPed5a, true)
    SetPedRelationshipGroupHash(carrierPed5a, 'aircraftPeds')
    GiveWeaponToPed(carrierPed5a, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed5a, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed5a, 75)
    SetPedDropsWeaponsWhenDead(carrierPed5a, false)

    carrierPed5b = CreatePed(30, -1275859404, 3082.63, -4732.03, 10.74, 109.44, true, false)
    SetPedArmour(carrierPed5b, 100)
    SetPedAsEnemy(carrierPed5b, true)
    SetPedRelationshipGroupHash(carrierPed5b, 'aircraftPeds')
    GiveWeaponToPed(carrierPed5b, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed5b, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed5b, 75)
    SetPedDropsWeaponsWhenDead(carrierPed5b, false)

    carrierPed5c = CreatePed(30, -1275859404, 3044.82, -4691.53, 6.08, 292.37, true, false)
    SetPedArmour(carrierPed5c, 100)
    SetPedAsEnemy(carrierPed5c, true)
    SetPedRelationshipGroupHash(carrierPed5c, 'aircraftPeds')
    GiveWeaponToPed(carrierPed5c, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed5c, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed5c, 75)
    SetPedDropsWeaponsWhenDead(carrierPed5c, false)

    carrierPed5d = CreatePed(30, -1275859404, 3039.5, -4673.22, 6.08, 288, true, false)
    SetPedArmour(carrierPed5d, 100)
    SetPedAsEnemy(carrierPed5d, true)
    SetPedRelationshipGroupHash(carrierPed5d, 'aircraftPeds')
    GiveWeaponToPed(carrierPed5d, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed5d, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed5d, 75)
    SetPedDropsWeaponsWhenDead(carrierPed5d, false)

    carrierPed6a = CreatePed(30, -1275859404, 3066.59, -4671.86, 10.74, 40.1, true, false)
    SetPedArmour(carrierPed6a, 100)
    SetPedAsEnemy(carrierPed6a, true)
    SetPedRelationshipGroupHash(carrierPed6a, 'aircraftPeds')
    GiveWeaponToPed(carrierPed6a, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed6a, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed6a, 75)
    SetPedDropsWeaponsWhenDead(carrierPed6a, false)

    carrierPed6b = CreatePed(30, -1275859404, 3063.89, -4639.73, 11.58, 197.44, true, false)
    SetPedArmour(carrierPed6b, 100)
    SetPedAsEnemy(carrierPed6b, true)
    SetPedRelationshipGroupHash(carrierPed6b, 'aircraftPeds')
    GiveWeaponToPed(carrierPed6b, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed6b, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed6b, 75)
    SetPedDropsWeaponsWhenDead(carrierPed6b, false)

    carrierPed6c = CreatePed(30, -1275859404, 3039.15, -4673.67, 10.74, 285.4, true, false)
    SetPedArmour(carrierPed6c, 100)
    SetPedAsEnemy(carrierPed6c, true)
    SetPedRelationshipGroupHash(carrierPed6c, 'aircraftPeds')
    GiveWeaponToPed(carrierPed6c, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed6c, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed6c, 75)
    SetPedDropsWeaponsWhenDead(carrierPed6c, false)

    carrierPed6d = CreatePed(30, -1275859404, 3043.21, -4688.11, 10.74, 278.91, true, false)
    SetPedArmour(carrierPed6d, 100)
    SetPedAsEnemy(carrierPed6d, true)
    SetPedRelationshipGroupHash(carrierPed6d, 'aircraftPeds')
    GiveWeaponToPed(carrierPed6d, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed6d, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed6d, 75)
    SetPedDropsWeaponsWhenDead(carrierPed6d, false)

    carrierPed7a = CreatePed(30, -1275859404, 3056.07, -4736.52, 10.74, 289.59, true, false)
    SetPedArmour(carrierPed7a, 100)
    SetPedAsEnemy(carrierPed7a, true)
    SetPedRelationshipGroupHash(carrierPed7a, 'aircraftPeds')
    GiveWeaponToPed(carrierPed7a, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed7a, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed7a, 75)
    SetPedDropsWeaponsWhenDead(carrierPed7a, false)

    carrierPed7b = CreatePed(30, -1275859404, 3094.65, -4753.47, 11.57, 187.64, true, false)
    SetPedArmour(carrierPed7b, 100)
    SetPedAsEnemy(carrierPed7b, true)
    SetPedRelationshipGroupHash(carrierPed7b, 'aircraftPeds')
    GiveWeaponToPed(carrierPed7b, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed7b, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed7b, 75)
    SetPedDropsWeaponsWhenDead(carrierPed7b, false)

    carrierPed7c = CreatePed(30, -1275859404, 3069.26, -4775.89, 6.08, 285.76, true, false)
    SetPedArmour(carrierPed7c, 100)
    SetPedAsEnemy(carrierPed7c, true)
    SetPedRelationshipGroupHash(carrierPed7c, 'aircraftPeds')
    GiveWeaponToPed(carrierPed7c, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed7c, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed7c, 75)
    SetPedDropsWeaponsWhenDead(carrierPed7c, false)

    carrierPed7d = CreatePed(30, -1275859404, 3075.23, -4797.03, 6.08, 351.98, true, false)
    SetPedArmour(carrierPed7d, 100)
    SetPedAsEnemy(carrierPed7d, true)
    SetPedRelationshipGroupHash(carrierPed7d, 'aircraftPeds')
    GiveWeaponToPed(carrierPed7d, GetHashKey('WEAPON_CARBINERIFLE'), 250, false, true)
    TaskCombatPed(carrierPed7d, GetPlayerPed(-1))
    SetPedAccuracy(carrierPed7d, 75)
    SetPedDropsWeaponsWhenDead(carrierPed7d, false)

end

