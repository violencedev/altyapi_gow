local sx, sy = guiGetScreenSize()

local editBoxes = {}

local function dxDrawEditBox(x, y, w, h, text)
    dxDrawRectangle(x, y, w, h, tocolor(220, 220, 220))
end 

function loginPanel()
    dxDrawEditBox(860, 100, 150, 25, 'slm')
end 
addEventHandler('onClientRender', root, loginPanel)
