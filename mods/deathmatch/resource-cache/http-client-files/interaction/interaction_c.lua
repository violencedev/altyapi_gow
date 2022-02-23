local font = dxCreateFont('components/font.otf', 12, false)

bindKey('m', 'down', function()
    showCursor(not isCursorShowing())
end)

setPlayerHudComponentVisible('radar', false);



-- veh speed

function getElementSpeed(theElement, unit)
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

-- get nearest guy

function getNearestVehicle(player,distance)
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	local pint = getElementInterior(player)
	local pdim = getElementDimension(player)

	for _,v in pairs(getElementsByType("vehicle")) do
		local vint,vdim = getElementInterior(v),getElementDimension(v)
		if vint == pint and vdim == pdim then
			local vx,vy,vz = getElementPosition(v)
			local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
			if dis < distance then
				if dis < lastMinDis then 
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end

-- my guy

-- icons
local F_key, E_key = false, true

addEventHandler('onClientRender', getRootElement(), function()
    if getPedOccupiedVehicle(localPlayer) then 
        --outputChatBox(getElementVelocity(getPedOccupiedVehicle(localPlayer)))
        if getElementSpeed(getPedOccupiedVehicle(localPlayer)) <= 5 then 
            F_key = true 
            if E_key == true then 
                y = 910
            end 
            dxDrawImage(60, y or 840, 65 / 1.8, 70 / 1.8, 'components/key_f.png')
            dxDrawText('Get out', 55 + (65 / 1.8) + 5, (y or 840) + ((70 / 1.8 - dxGetFontHeight(1, font)) / 2), _, _, white, 1, font, _, 'top')
        end 
    else 
        local nearestVeh = getNearestVehicle(localPlayer, 10);
        local nx, ny, nz = getElementPosition(nearestVeh)
        local dis = getDistanceBetweenPoints3D(nx, ny, nz, getElementPosition(localPlayer))
        if dis <= 2 then 
            F_key = true 
            if E_key == true then 
                y = 910
            end 
            dxDrawImage(60, y or 840, 65 / 1.8, 70 / 1.8, 'components/key_f.png')
            dxDrawText('Get in', 55 + (65 / 1.8) + 5, (y or 840) + ((70 / 1.8 - dxGetFontHeight(1, font)) / 2), _, _, white, 1, font, _, 'top')
        end 
    end 
end)