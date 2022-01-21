function goForSound(soundPath)
    local music = playSound('back-end/sounds/' .. soundPath, true, true)
    setElementData(localPlayer, 'current:Music', {object=music, path=soundPath, stopped=false}) 
end 
addEvent('music:callBack', true)
addEventHandler('music:callBack', root, goForSound)

local sx, sy = guiGetScreenSize(); 
local sikimGibiFont = exports.fonts:getFont('Roboto', 11)

addEventHandler('onClientRender', root, function()
    if (getElementData(localPlayer, 'loggedin') or 0) == 0 then 
        local musicInfo = getElementData(localPlayer, 'current:Music') or {}
        if musicInfo then
            local musicPa = split(musicInfo.path, '-')[2] .. ' - ' .. split(split(musicInfo.path, '-')[3], '.')[1]
            h, w = 40, dxGetTextWidth(musicPa, 1, sikimGibiFont);
            x, y = (sx-w) / 2, (sy-h) / 1
            dxDrawText(musicPa, x, y, w, h, white, 1, sikimGibiFont)
        end
    end 
end)

addEventHandler('onClientClick', root, function(btn, st) 
	if (getElementData(localPlayer, 'loggedin') or 0) == 0 then 
		if (st == 'down') and (btn == 'left') then
			if isCursorOnElement(x, y, w, h) == true then 
				-- durdurmazsan gotunden salyangoz cikaririm!
				local stopped = getElementData(localPlayer, 'current:Music').stopped 
                if stopped == false then sound = stopSound(getElementData(localPlayer, 'current:Music').object) else sound = playSound('back-end/sounds/' .. getElementData(localPlayer, 'current:Music').path, true, true) end
                setElementData(localPlayer, 'current:Music', {object=sound, path=getElementData(localPlayer, 'current:Music').path, stopped = not stopped}) 
            end 
        end
        if (st == 'down') and (btn == 'right') then
			if isCursorOnElement(x, y, w, h) == true then 
				-- sarki degis!
                stopSound(getElementData(localPlayer, 'current:Music').object)
                triggerServerEvent('call:ServerMusic', localPlayer, localPlayer, getElementData(localPlayer, 'current:Music').path)
            end 
        end
	end
end)

addEvent('stop:Music', true)
addEventHandler('stop:Music', root, function()
    local musicInfo = getElementData(localPlayer, 'current:Music')
    if musicInfo.object then stopSound(musicInfo.object) setElementData(localPlayer, "current:Music", nil) end
end)
