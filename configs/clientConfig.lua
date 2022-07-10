Loc = {}
LocFnc = {} 
TriggerServerEvent("plouffe_location:sendConfig")

RegisterNetEvent("plouffe_location:getConfig",function(list)
	if list == nil then
		CreateThread(function()
			while true do
				Wait(0)
				Loc = nil
				LocFnc = nil
				ESX = nil
			end
		end)
	else
		Loc = list
		LocFnc:Start()
	end
end)