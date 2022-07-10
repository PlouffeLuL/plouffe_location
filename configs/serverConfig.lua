Auth = exports.plouffe_lib:Get("Auth")
Callback = exports.plouffe_lib:Get("Callback")

Server = {
	Init = false
}

Loc = {}
LocFnc = {} 

Loc.Player = {}

Loc.zones = {
    atla_street_vehicles_location = {
		name = "atla_street_vehicles_location",
		coords = vector3(-348.89569091797, -874.05780029297, 31.318021774292),
		maxDst = 2.0,
		isZone = true,
		nuiLabel = "Service de locations",
		aditionalParams = {fnc = "RentMenu", index = "atla_street_vehicles_location"},
        keyMap = {
			checkCoordsBeforeTrigger = true,
			onRelease = true,
			releaseEvent = "plouffe_location:from_zones",
			key = "E"
	  	},
		pedInfo = {
			coords = vector3(-348.89569091797, -874.05780029297, 31.318021774292),
			heading = 184.66165161132812,
			model = 'cs_carbuyer', 
			scenario = 'WORLD_HUMAN_COP_IDLES',
		}
	}
}

Loc.Prices = {
    sultan = 1000,
    panto = 250,
    windsor = 750,
    flatbed = 750,
    guardian = 1500
}

Loc.Menu = {
	rent = {
        {
            id = 1,
            header = "Voir vos locations",
            txt = "Vous montre toutes vos locations active",
            params = {
                event = "",
                args = {
                    fnc = "ShowLocationHistory"
                }
            }
        },

        {
            id = 2,
            header = "Prendre une location",
            txt = "Vous permet de louer un véhicule",
            params = {
                event = "",
                args = {
                    fnc = "LocationList"
                }
            }
        }
    },

    timeSelect = {
        {
            id = 1,
            header = "1 Jour",
            txt = "Votre location sera d'un duré de 1 jour",
            params = {
                event = "",
                args = {
                    fnc = "ShowCarSpecific",
                    time = 1
                }
            }
        },

        {
            id = 2,
            header = "2 Jour",
            txt = "Votre location sera d'un duré de 2 jour",
            params = {
                event = "",
                args = {
                    fnc = "ShowCarSpecific",
                    time = 2
                }
            }
        },

        {
            id = 3,
            header = "3 Jour",
            txt = "Votre location sera d'un duré de 3 jour",
            params = {
                event = "",
                args = {
                    fnc = "ShowCarSpecific",
                    time = 3
                }
            }
        },

        {
            id = 4,
            header = "4 Jour",
            txt = "Votre location sera d'un duré de 4 jour",
            params = {
                event = "",
                args = {
                    fnc = "ShowCarSpecific",
                    time = 4
                }
            }
        },

        {
            id = 5,
            header = "5 Jour",
            txt = "Votre location sera d'un duré de 5 jour",
            params = {
                event = "",
                args = {
                    fnc = "ShowCarSpecific",
                    time = 5
                }
            }
        },

        {
            id = 6,
            header = "6 Jour",
            txt = "Votre location sera d'un duré de 6 jour",
            params = {
                event = "",
                args = {
                    fnc = "ShowCarSpecific",
                    time = 6
                }
            }
        },

        {
            id = 7,
            header = "7 Jour",
            txt = "Votre location sera d'un duré de 7 jour",
            params = {
                event = "",
                args = {
                    fnc = "ShowCarSpecific",
                    time = 7
                }
            }
        },
    },

    accessiblesLocations = {
        {
            id = 1,
            header = "Sultan",
            txt = "Louer une sultan",
            params = {
                event = "",
                args = {
                    fnc = "SelectTime",
                    model = "sultan"
                }
            }
        },

        {
            id = 2,
            header = "Panto",
            txt = "Louer une panto",
            params = {
                event = "",
                args = {
                    fnc = "SelectTime",
                    model = "panto"
                }
            }
        },

        {
            id = 3,
            header = "Windsor",
            txt = "Louer une windsor",
            params = {
                event = "",
                args = {
                    fnc = "SelectTime",
                    model = "windsor"
                }
            }
        },

        {
            id = 4,
            header = "Remorqueuse",
            txt = "Louer une remorqueuse",
            params = {
                event = "",
                args = {
                    fnc = "SelectTime",
                    model = "flatbed"
                }
            }
        },

        {
            id = 5,
            header = "Guardian",
            txt = "Louer un guardian",
            params = {
                event = "",
                args = {
                    fnc = "SelectTime",
                    model = "guardian"
                }
            }
        }
    }
}

Loc.Utils = {
	ped = 0,
	pedCoords = vector3(0,0,0)
}