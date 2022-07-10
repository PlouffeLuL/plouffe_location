function LocFnc:Init()
    for car,price in pairs(Loc.Prices) do
        for _,menu in pairs(Loc.Menu.accessiblesLocations) do
            if menu.params.args.model == car then
                menu.header = menu.header.." "..tostring(price).." $"
            end
        end
    end

    TriggerEvent('cron:runAt', 6, 0, PayRents)

    Server.Init = true
end

function LocFnc:RentVehicle(playerId,model,time)
    local player = exports.ooc_core:getPlayerFromId(playerId)
    local price = Loc.Prices[model] 
    local phoneNumber = player.phone_number
    local messageData = {senderNumber = "Location", targetNumber = tostring(phoneNumber), message = ""}

    if price and player.bank >= 0 then
        local vehicleProps = {
            plate = exports.plouffe_garage:CreatePlate(),
            model = GetHashKey(model),
            engineHealth = 1000,
            fuelLevel = 100
        } 

        MySQL.query("INSERT INTO owned_vehicles (state_id, plate, vehicle, vehiclemodel) VALUES (@state_id, @plate, @vehicle, @vehiclemodel)",
        {
            ['@state_id']   = player.state_id,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@vehiclemodel']  = model
        }, function(penis)
            MySQL.query("INSERT INTO rented_vehicles (state_id, plate, daily_price, duration, model) VALUES (@state_id, @plate, @daily_price, @duration, @model)",
            {
                ['@state_id']   = player.state_id,
                ['@plate']   = vehicleProps.plate,
                ['@daily_price'] = price,
                ['@duration']  = time,
                ["@model"] = model
            }, function(penis)
                messageData.message = "Votre véhicule est a alta street et vous attend la bas, merci pour votre location."
                exports.npwd:emitMessage(messageData)
            end)
        end)
    else
        messageData.message = "Vous ne pouvez pas louer un véhicule quand votre compte est en bas de 0 $"
        exports.npwd:emitMessage(messageData)
    end
end

function LocFnc:RemovePlayerMoney(state_id,amount,cb)
    local player = exports.ooc_core:getPlayerFromStateId(state_id)

    if player then
        player.removeBank(amount)
        return cb()
    else
        MySQL.query('UPDATE users_characters SET bank = bank - :amount WHERE state_id = :state_id',
        {
            amount = amount,
            state_id = state_id,
        }, function()
            cb()
        end)
    end
end

function LocFnc:PaySpecificRent(currentIndex, lenght, rents, cb)
    if currentIndex <= lenght then
        self:RemovePlayerMoney(rents[currentIndex].state_id, rents[currentIndex].daily_price,function()
            if rents[currentIndex].duration - 1 > 0 then
                MySQL.query("UPDATE rented_vehicles SET duration = duration - 1 WHERE id = @id",{
                    ["@id"] = rents[currentIndex].id
                },function()
                    self:PaySpecificRent(currentIndex + 1, lenght, rents, cb)
                end)
            else
                MySQL.query("DELETE FROM owned_vehicles WHERE state_id = @state_id AND plate = @plate", {
                    ["@state_id"] = rents[currentIndex].state_id,
                    ["@plate"] =  rents[currentIndex].plate
                }, function()
                    MySQL.query("DELETE FROM rented_vehicles WHERE id = @id",{
                        ["@id"] = rents[currentIndex].id
                    },function()
                        self:PaySpecificRent(currentIndex + 1, lenght, rents, cb)
                    end)
                end)
            end
        end)
    else
        cb()
    end
end

function LocFnc:PayRents()
    MySQL.query("SELECT * FROM rented_vehicles", function(rents)
        self:PaySpecificRent(1,#rents,rents,function()

        end)
    end)
end

function PayRents(d, h, m)
    LocFnc:PayRents()
end

RegisterCommand("locations_force_pay", PayRents, true)