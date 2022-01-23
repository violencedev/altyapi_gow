local sx, sy = guiGetScreenSize()
local w, h = 325, 325
local x, y = (sx-w)/2, (sy-h)/2
local yx = (sy-h)/1

local fontazzardo = exports.fonts:getFont("Azzardo-Regular",20)
local fontawesome = exports.fonts:getFont("FontAwesome",20)
local fontroboto = exports.fonts:getFont("Roboto",10)

function factionSystemCar()

	roundedRectangle(x,y,w,h,tocolor(24,24,24,220)) -- ana rounded
	
	roundedRectangle(x,y,w,37,tocolor(24,24,24,200)) -- üstdeki rounded 45 h
	roundedRectangle(x,yx+210,w,35,tocolor(24,24,24,200)) -- alttaki rounded 45 h

	dxDrawText("",x+290,y+2,w,h,tocolor(220,220,220,220),1,fontawesome)

	dxDrawText("Birlik Araclari",x+95,y,w,h,white,1,fontazzardo)
	dxDrawText("Birliğinizde olan araçlar burada tam liste gözükecektir.",x+10,yx+220,w,h,white,1,fontroboto)

	roundedRectangle(x+10,y+50,303,230,tocolor(24,24,24,220))
	dxDrawRectangle(x+10,y+80,303,1,tocolor(0,0,0))
	dxDrawText("",x+20,yx-20,w,h,white,0.50,fontawesome)
	dxDrawText("Araç Markası",x+45,yx-19,w,h,white,1,fontroboto)
	dxDrawText("ID-12",x+265,yx-19,w,h,white,1,fontroboto)

	if isCursorOnElement(x+290,y+2,30,30) then 
		dxDrawText("",x+290,y+2,w,h,tocolor(220,0,0),1,fontawesome)
	end
end
--addEventHandler("onClientRender",root,factionSystemCar)

function isCursorOnElement (x,y,w,h)
	local mx,my = getCursorPosition()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
	if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
	 return true
	else
	 return false
	end
end 

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
    if (x and y and w and h) then
        if (not borderColor) then
            borderColor = tocolor(0, 0, 0, 200);
        end      
        if (not bgColor) then
            bgColor = borderColor;
        end
        dxDrawRectangle(x, y, w, h, bgColor, postGUI);
        dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI); -- top
        dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI); -- bottom
        dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI); -- left
        dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI); -- right
    end
end