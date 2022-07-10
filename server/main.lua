CreateThread(function()
    LocFnc:Init()
end)

RegisterNetEvent("plouffe_location:sendConfig",function()
    local playerId = source
    local registred, key = Auth:Register(playerId)
    
    while not Server.Init do
        Wait(100)
    end
    
    if registred then
        local cbArray = Loc
        cbArray.Utils.MyAuthKey = key
        TriggerClientEvent("plouffe_location:getConfig",playerId,cbArray)
    else
        TriggerClientEvent("plouffe_location:getConfig",playerId,nil)
    end
end)

RegisterNetEvent("plouffe_location:rent_vehicle",function(model,time,authkey)
    local playerId = source
    if Auth:Validate(playerId,authkey) then
        if Auth:Events(playerId,"plouffe_location:rent_vehicle") then
            LocFnc:RentVehicle(playerId,model,time)
        end
    end
end)
    
Callback:RegisterServerCallback("plouffe_location:getMyLocations", function(source, cb, authkey)
    if Auth:Validate(source,authkey) then
        if Auth:Events(source,"plouffe_location:getMyLocations") then
            local xPlayer = exports.ooc_core:getPlayerFromId(source)
            MySQL.query("SELECT daily_price, duration, model FROM rented_vehicles WHERE state_id = @state_id",{
                state_id = xPlayer.state_id
            }, function(res)
                cb(res)
            end)
        end
    end
end)