local tick = getTickCount()
local duration = 60000
addEventHandler('onClientRender', getRootElement(), function()    
    local progress = (getTickCount() - tick) / duration
    local x, y, z = interpolateBetween(0, 0, 20, 1468.8785400391, -919.25317382813, 100.153465271, progress, 'OutQuad');
    local rx, ry, rz = interpolateBetween(0, 0, 0, 1468.388671875, -918.42474365234, 99.881813049316, progress, 'OutQuad');
    local camRoll = interpolateBetween(0, 0, 0, 360, 0, 0, progress, 'SineCurve');
    setCameraMatrix(x, y, z, rx, ry, rz, camRoll)
end) 

-- 1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316