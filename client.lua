print('Boat Anchor by Abel Gaming Loaded')
local anchored = false
local boat = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)	
		if anchored then
			-- Set boat frozen
			SetBoatFrozenWhenAnchored(boat, true)
			
			-- Draw anchored text
			SetTextFont(0)
            SetTextProportional(1)
            SetTextScale(0.0, 0.3)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString("~g~BOAT ANCHORED")
            DrawText(0.005, 0.5)
			
			-- Disable Driving Forward Controls
			DisableControlAction(0, 71, true)
			DisableControlAction(0, 129, true)
			DisableControlAction(0, 232, true)
			
			-- Disable Driving Back Controls
			DisableControlAction(0, 72, true)
			DisableControlAction(0, 130, true)
			DisableControlAction(0, 233, true)
			
			-- Check for key presses
			if IsDisabledControlJustPressed(0, 71) or IsDisabledControlJustPressed(0, 129) or IsDisabledControlJustPressed(0, 232) or IsDisabledControlJustPressed(0, 72) or IsDisabledControlJustPressed(0, 130) or IsDisabledControlJustPressed(0, 233) then		
				if IsPedInAnyBoat(PlayerPedId()) then
					if Config.UseSWTNotifications then
						TriggerEvent("swt_notifications:Negative", "Boat Still Anchored", "You must unanchor your boat first!", "top", 5000, true)
					else
						ShowNotification("~r~You must unanchor your boat first!")
					end		
				end		
			end
		end
	end
end)

RegisterCommand('anchor', function(source)
	if anchored then
		anchored = false
		local boat = GetVehiclePedIsIn(PlayerPedId(), false)
		SetBoatAnchor(boat, false)
		SetBoatFrozenWhenAnchored(boat, false)
		if Config.UseSWTNotifications then
			TriggerEvent("swt_notifications:Warning", "Boat Unanchored", "Your boat has been unanchored", "right", 5000, true)
		else
			ShowNotification("~y~Your boat has been unanchored")
		end
	else
		anchored = true
		local boat = GetVehiclePedIsIn(PlayerPedId(), false)
		SetBoatAnchor(boat, true)
		SetBoatFrozenWhenAnchored(boat, true)
		if Config.UseSWTNotifications then
			TriggerEvent("swt_notifications:Success", "Boat Anchored", "Your boat has been anchored", "right", 5000, true)
		else
			ShowNotification("~g~Your boat has been anchored")
		end
	end
end, false)

function ShowNotification(message)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(message)
	DrawNotification(false, true)
end