local CHECK_DISTANCE = 10

function isVehicleReversing(theVehicle)
    local getMatrix = getElementMatrix (theVehicle)
    local getVelocity = Vector3 (getElementVelocity(theVehicle))
    local getVectorDirection = (getVelocity.x * getMatrix[2][1]) + (getVelocity.y * getMatrix[2][2]) + (getVelocity.z * getMatrix[2][3])
    if (getVectorDirection < 0) then
        return true
    end
    return false
end



addEventHandler('onClientRender', root, function()
    local veh = getPedOccupiedVehicle(localPlayer);
    if veh then 
        if isVehicleReversing(veh) == true then 
            local ex_x, ex_y, ex_z = getVehicleComponentPosition(veh, 'exhaust_ok', 'world');
            local clearness = isLineOfSightClear(ex_x, ex_y, ex_z, ex_x, ex_y-(CHECK_DISTANCE), ex_z, true, false, false, true, false)
            print(clearness)
        end 
    end 
end)

