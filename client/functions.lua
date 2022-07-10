local Callback = exports.plouffe_lib:Get("Callback")
local Utils = exports.plouffe_lib:Get("Utils")

function LocFnc:Start()
    TriggerEvent('ooc_core:getCore', function(Core) 
        while not Core.Player:IsPlayerLoaded() do
            Wait(500)
        end

        Loc.Player = Core.Player:GetPlayerData()

        LocFnc:ExportsAllZones()
        LocFnc:RegisterAllEvents()
    end)
end

function LocFnc:ExportsAllZones()
    for k,v in pairs(Loc.zones) do
        exports.plouffe_lib:ValidateZoneData(v)
    end
end

function LocFnc:RegisterAllEvents()
    RegisterNetEvent("plouffe_location:from_zones", function(params) 
        if self[params.fnc] then
            self[params.fnc](self,params)
        end
    end)
end

function LocFnc:RentMenu(params)
    exports.ooc_menu:Open(Loc.Menu.rent,function(menuParams)
        if not menuParams then
            return
        end

        if self[menuParams.fnc] then
            self[menuParams.fnc](self,menuParams)
        end
    end)
end

function LocFnc:LocationList(passedParams)
    exports.ooc_menu:Open(Loc.Menu.accessiblesLocations,function(selectionParams)
        if not selectionParams then
            return
        end

        if self[selectionParams.fnc] then
            self[selectionParams.fnc](self,selectionParams)
        end
    end)
end

function LocFnc:ShowLocationHistory(passedParams)
     Callback:Await("plouffe_location:getMyLocations", function(rentsList)
        if #rentsList > 0 then
            local menuData = {}
            for k,v in ipairs(rentsList) do
                table.insert(menuData,{
                    id = k,
                    header = ("Véhicule: %s"):format(GetLabelText(GetDisplayNameFromVehicleModel(v.model))),
                    txt = ("Prix: %s $  Duré restante: %s jours"):format(v.daily_price,v.duration),
                    params = {
                        event = "",
                        args = {
                        }
                    }
                })
            end

            exports.ooc_menu:Open(menuData,function(fuckDavid)
            
            end)
        else
            Utils:Notify("error", "Vous n'avez pas de véhicules en location présentement")
        end
    end, Loc.Utils.MyAuthKey)
end

function LocFnc:SelectTime(passedParams)
    exports.ooc_menu:Open(Loc.Menu.timeSelect,function(selectionParams)
        if not selectionParams then
            return
        end

        if self[selectionParams.fnc] then
            self[selectionParams.fnc](self,selectionParams.time,passedParams.model)
        end
    end)
end

function LocFnc:ShowCarSpecific(time,model)
    local menuData = {
        {
            id = 1,
            header = "Terme du contract",
            txt = "Selectioner accepter pour pour prendre la location",
            params = {
                event = "",
                args = {
                }
            }
        },

        {
            id = 2,
            header = ("Prix: %s $"):format(Loc.Prices[model]),
            txt = "Ce montant vous sera charger toutes les 24 heurs pour la duré de votre location",
            params = {
                event = "",
                args = {
                }
            }
        },

        {
            id = 3,
            header = ("Durée: %s jours"):format(time),
            txt = "Ceci est la duré complète de votre location",
            params = {
                event = "",
                args = {
                }
            }
        },

        {
            id = 4,
            header = "Accepter",
            txt = "Votre véhicule de location sera envoyer au garage de alta street",
            params = {
                event = "",
                args = {
                    validate = true
                }
            }
        }
    }

    exports.ooc_menu:Open(menuData, function(anus)
        if not anus then
            return
        end

        if anus.validate then
            TriggerServerEvent("plouffe_location:rent_vehicle",model,time,Loc.Utils.MyAuthKey)
        end
    end)
end