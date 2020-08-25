aircraftHeist_ready = false
completed = false
timer = 0

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
 
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_aircraftHeist")

RegisterServerEvent('aircraftHeist:isTimerUp')
AddEventHandler('aircraftHeist:isTimerUp', function()
    local _source = source
    if aircraftHeist_ready then
        TriggerClientEvent('aircraftHeist:ready', _source)
    end
end)

RegisterServerEvent('aircraftHeist:isCompleted')
AddEventHandler('aircraftHeist:isCompleted', function()
    local _source = source
    if completed then
        TriggerClientEvent('aircraftHeist:reset', _source)
        completed = false
    end
end)

RegisterServerEvent('aircraftHeist:canHack')
AddEventHandler('aircraftHeist:canHack', function()
    local _source = source
    local msg = 'Hit ~INPUT_CONTEXT~ to get the location of the shipment'

    while aircraftHeist_ready do
        Citizen.Wait(1)
        TriggerClientEvent('aircraftHeist:helpText', _source, msg)
    end
end)

RegisterServerEvent('aircraftHeist:startedHacking')
AddEventHandler('aircraftHeist:startedHacking', function(started)
    local _source = source
    aircraftHeist_ready = false
    pickupLoc = generate_pickupLoc()
    TriggerClientEvent('aircraftHeist:addBlip', _source, pickupLoc)
    TriggerClientEvent('aircraftHeist:collectPackage', _source, pickupLoc)
end)

RegisterServerEvent('aircraftHeist:collected')
AddEventHandler('aircraftHeist:collected', function()
    local _source = source
    --print("package has been collected and setting complete to true")
    local user_id = vRP.getUserId({_source})
    local idnames = Config.item_names
    for k, v in pairs(idnames) do
        idname = v
        amount = math.random(10,20)
        vRP.giveInventoryItem({user_id,idname,amount,notify})
        --print("added "..amount.." "..k.." db name "..idname)
    end
    completed = true

end)

function generate_pickupLoc() -- generates one of six random locations on the carrier the "package" could be
    chance = math.random(1,6)
    if chance == 1 then
        pickupLoc = Config.pickupLocs.One
    elseif chance == 2 then
        pickupLoc = Config.pickupLocs.Two
    elseif chance == 3 then
        pickupLoc = Config.pickupLocs.Three
    elseif chance == 4 then
        pickupLoc = Config.pickupLocs.Four
    elseif chance == 5 then
        pickupLoc = Config.pickupLocs.Five
    elseif chance == 6 then
        pickupLoc = Config.pickupLocs.Six
    end

    return pickupLoc
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if completed then
            aircraftHeist_ready = false
            timer = 0
            --completed = false
        end
        while not aircraftHeist_ready and timer < Config.Cooldown do
            timer = timer + 1
            if timer == Config.Cooldown then
                aircraftHeist_ready = true
                print("ready") -- just a place holder, add an event here for whatever notification system etc you use
            end
            Citizen.Wait(1000)
        end
    end
end)
