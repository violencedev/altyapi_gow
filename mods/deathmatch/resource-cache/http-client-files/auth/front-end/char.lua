local sx, sy = guiGetScreenSize()
local w, h = 500, 33
local x, y = (sx-w)/2, (sy-h)/3

local scx, scy = (sx-w)/1, (sy-h)/1

local robotomed = exports.fonts:getFont("RobotoMed",10)
local awesome = exports.fonts:getFont("FontAwesome",13)

local erkekicon = exports.fonts:getIcon("fa-male")
local kadinicon = exports.fonts:getIcon("fa-female")

local playicon = exports.fonts:getIcon("fa-play-circle")
local olusturicon = exports.fonts:getIcon("fa-plus-circle")
local ayarlaricon = exports.fonts:getIcon("fa-gear")


function determineSex(sex)
	if sex == 'kadın' then return kadinicon end 
	if sex == 'erkek' then return erkekicon end
end 

playIcons = {

}

function panel()
	roundedRectangle(x,y-75,w,h,tocolor(14,14,14,alpkha),10) -- ana rounded

	dxDrawText("Karakter Adı",x+13,y-67,w,h,tocolor(200,200,200,alpkha2),1,robotomed) -- karakter adı
	dxDrawText("Son Görülme",x+170,y-67,w,h,tocolor(200,200,200,alpkha2),1,robotomed) -- son görülme yeri
	dxDrawText("Cinsiyet",x+330,y-67,w,h,tocolor(200,200,200,alpkha2),1,robotomed) -- cinsiyet

	if karakterler[1] then
		for k,v in pairs(karakterler) do 
			roundedRectangle(x,y-130 + (k * 100),w,h,tocolor(17,17,17,alpkha2),10) -- 1.karakter rounded
			dxDrawText(v.charName,x+13,y-122 + (k * 100) ,w,h,tocolor(200,200,200,alpkha2),1,robotomed) -- 1. karakter adı
			dxDrawText(getZoneName(v.x, v.y, v.z),x+170,y-122 + (k * 100),w,h,tocolor(200,200,200,alpkha2),1,robotomed) -- 1. karakter son görülme yeri
			dxDrawText(determineSex(v.sex),x+347,y-123 + (k * 100),w,h,tocolor(200,200,200,alpkha2),1,awesome) -- 1. karakter cinsiyet iconlu
			dxDrawText(playicon,x+460,y-24,w,h,tocolor(200,200,200,alpkha2),1,awesome) -- 1. karakter oyna icon
			table.insert(playIcons, {pos={x+460,y-24,w,h}, char=v})
		end 
	else
		roundedRectangle(x,y-30,w,h,tocolor(17,17,17,alpkha2),10) 
		dxDrawText('Hiçbir karakteriniz yok :( Oluşturman için sağ altta bir buton var, ona tıkla!', x+16, y-22.5, w+x, h+y, tocolor(200, 200, 200, alphka2), 1, robotomed)
	end
	roundedRectangle(scx+330,scy-30,150,h,tocolor(5,5,5,alpkha2),7) -- karakter oluştur rounded

	dxDrawText(olusturicon,scx+335,scy-25,w,h,tocolor(200,200,200,alpkha2),1,awesome) -- karakter oluştur icon
	dxDrawText("Karakter Oluştur",scx+360,scy-22,w,h,tocolor(200,200,200,alpkha2),1,robotomed) -- karakter oluştur text

	roundedRectangle(scx+330,scy-67,90,h,tocolor(5,5,5,alpkha2),7) -- ayarlar rounded
	dxDrawText(ayarlaricon,scx+335,scy-62,w,h,tocolor(200,200,200,alpkha2),1,awesome) -- ayarlar icon
	dxDrawText("Ayarlar",scx+360,scy-59,w,h,tocolor(200,200,200,alpkha2),1,robotomed) -- ayarlar text

end 

function character()
		alpkha, alpkha2, alpkha3 = 220, 200, 255
		--outputDebugString(posX .. ' - ' .. posY .. ' - ' .. posZ)

		panel()
		if isCursorOnElement(scx+335,scy-62,70,20) then 
			dxDrawText(ayarlaricon,scx+335,scy-62,w,h,tocolor(220,0,0),1,awesome) -- ayarlar icon
			dxDrawText("Ayarlar",scx+360,scy-59,w,h,tocolor(220,0,0),1,robotomed) -- ayarlar text
		end

		if isCursorOnElement(scx+335,scy-25,130,20) then 
			dxDrawText(olusturicon,scx+335,scy-25,w,h,tocolor(220,0,0),1,awesome) -- karakter oluştur icon
			dxDrawText("Karakter Oluştur",scx+360,scy-22,w,h,tocolor(220,0,0),1,robotomed) -- karakter oluştur text
		end

		for k,v in pairs(playIcons) do 
			if isCursorOnElement(x+460,y-124 + (k * 100),20,20) then 
				dxDrawText(playicon,x+460,y-24,w,h,tocolor(0,200,0,200),1,awesome) -- 1. karakter oyna icon
			end
		end 
end

addEvent('charOkut', true)
addEventHandler('charOkut', root, function()
	--fadeOut3 = true
	addEventHandler("onClientRender",root,character)
end)

addEvent('transfer:Data', true)
addEventHandler('transfer:Data', root, function(chars)
	karakterler = {}
	for _,j in pairs(chars) do 
		if j.account == getElementData(localPlayer, 'account:username') then 
			table.insert(karakterler, j)
		end 
	end 
end)

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

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
	    local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
	return false
end


function roundedRectangle(x, y, rx, ry, color, radius)
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
    end
end

addEventHandler('onClientClick', root, function(btn, st)
	if (st == 'down') and (btn == 'left') then
		if isCursorOnElement(scx+335,scy-62,70,20) then 
			if isEventHandlerAdded('onClientRender', root, character) then
			-- ayarlara gir..
			removeEventHandler('onClientRender', root, character)
			start = getTickCount()
			triggerEvent('changePass', localPlayer)
			setElementData(localPlayer, 'fadeOutt2', true)
			end
		end 
		if isCursorOnElement(scx+335,scy-25,130,20) then 
			if isEventHandlerAdded('onClientRender', root, character) then
			-- karakter oluştura gir.
			removeEventHandler('onClientRender', root, character)
			triggerEvent('redirect:Creation', localPlayer)
			end
		end
		for _,v in pairs(playIcons) do 
			if isCursorOnElement(unpack(v.pos)) then 
				if isEventHandlerAdded('onClientRender', root, character) then
					-- karaktere gir
					removeEventHandler('onClientRender', root, character)
					triggerServerEvent('redirect:EnterChar', localPlayer, v.char)
				end 
			end 
		end 
	end
end)