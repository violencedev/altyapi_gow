local sx, sy = guiGetScreenSize();
local w, h = 600, 350
local x, y = (sx - w) / 2, (sy - h) / 2

local titleFont = exports.fonts:getFont('RobotoB', 14)
local btnFont = exports.fonts:getFont('RobotoB', 11)
local playerFaction = 'Los Santos Police Departmanı'

addEventHandler('onClientRender', root, function()
    dxDrawRectangle(x, y, w, h, tocolor(11, 11, 10, 240))

    dxDrawText('bankacılık işlemleri', x + 15, y + 10, w, _, tocolor(255, 255, 255, 255), 1, titleFont)

    local returnedWeight = dxDrawButton(x+15, y + 45, 115, 27.5, tocolor(82, 130, 240, 255), 'Kişisel')
    dxDrawButton(x+15+returnedWeight+15, y + 45, 115, 27.5, tocolor(82, 130, 240, 255), playerFaction)
end)

dxDrawButton = function(x, y, w, h, bgColor, frText)
    if (x and y and w and h and bgColor and frText) then 
        dxDrawRoundedRectangle(x, y, dxGetTextWidth(frText, 1, btnFont) + 40, h, 6, bgColor or white, false, false)
        dxDrawText(frText, x, y, dxGetTextWidth(frText, 1, btnFont) + 40+x, h+y, white, 1, btnFont, 'center', 'center')
        return ( dxGetTextWidth(frText, 1, btnFont) + 40 ) 
    end 
end 

function dxDrawRoundedRectangle(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+radius, width-(radius*2), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end