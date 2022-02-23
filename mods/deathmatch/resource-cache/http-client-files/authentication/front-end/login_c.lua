
function login()
end 

addEvent('login:Interface', true)
addEventHandler('login:Interface', root, function()
    _G.tick = getTickCount()
    _G.delay = 10000
    addEventHandler('onClientRender', root, function()
        local progress = (getTickCount() - tick) / delay -- 1237.0743408203 -129.66000366211 94.121299743652 1237.0157470703 -130.65170288086 94.006858825684
        local bakis = interpolateBetween(0, 0, 0, 360, 0, 0, progress, 'OutBack') 
        x, y, z = interpolateBetween(985.74102783203, -1067.8654785156, 96.230598449707, 1468.8785400391, -919.25317382813, 100.153465271, progress, 'OutBack') -- 1419.7435302734 -622.83367919922 122.90209960938 1418.9949951172 -623.48150634766 122.76054382324
        fx, fy, fz = interpolateBetween(986.59106445312, -1067.3763427734, 96.035140991211, 1468.388671875, -918.42474365234, 99.881813049316, progress, 'OutBack')
        setCameraMatrix(x, y, z, fx, fy, fz, bakis) --    1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316
    end)
    setTimer(function()
        setCameraTarget(localPlayer,localPlayer)
    end, 11000, 1)
end)



addCommandHandler('f', function()
    local x, y, z, fx, fy, fz, cam, fov = getCameraMatrix()
    outputChatBox(x .. " " .. y .. " " .. z .. " " .. fx .. " " .. fy .. " " .. fz .. " " .. cam .. " " .. fov);
end)