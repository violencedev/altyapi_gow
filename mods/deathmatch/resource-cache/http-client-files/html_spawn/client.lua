local sx, sy = guiGetScreenSize();

local browser = guiCreateBrowser(0, 0, sx, sy, true, true, false)
guiSetVisible(browser, false)
local derBrowser = guiGetBrowser(browser)

addEventHandler('onClientBrowserCreated', derBrowser, function()
    loadBrowserURL(source, 'http://mta/local/index.html')
end)

function interface() 
    guiSetVisible(browser, not guiGetVisible(browser)) 
end 
addEventHandler('onClientPlayerWasted', root, interface)

addEvent('teleport', true)
addEventHandler('teleport', root, function(nx, ny, nz)
    interface() 
    triggerServerEvent('spawnPlayer', localPlayer, {nx, ny, nz})
end)