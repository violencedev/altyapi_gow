local sx, sy = guiGetScreenSize()
local w, h = 500, 33
local x, y = (sx-w)/2, (sy-h)/2

local scx, scy = (sx-w)/1, (sy-h)/1

local robotomed = exports.fonts:getFont("RobotoMed",10)
local robotomed2 = exports.fonts:getFont("RobotoMed",11)
local awesome = exports.fonts:getFont("FontAwesome",13)

local robotomed3 = exports.fonts:getFont("RobotoMed",20)

local fontawesome = exports.fonts:getFont("FontAwesome",55)

local erkekicon = exports.fonts:getIcon("fa-male")
local kadinicon = exports.fonts:getIcon("fa-female")

local usericon = exports.fonts:getIcon("fa-user")

local playicon = exports.fonts:getIcon("fa-play-circle")
local closeicon = exports.fonts:getIcon("fa-xing")
local ayarlaricon = exports.fonts:getIcon("fa-share-square")

local fad1, fad2, fad3, fad4, fad5, fad5 = 220, 200, 255, 0, 0, 0

function arayuz()
	dxDrawText(usericon,x+210,y-165,w,h,tocolor(255, 255, 255, alphaa3),1,fontawesome) -- user iconu büyük olan
	dxDrawText("gowmta",x+195,y-75,w,h,tocolor(255, 255, 255, alphaa3),1,robotomed3) -- gowmta yazısı

	roundedRectangle(x+150,y-33,200,h,tocolor(14,14,14,alphaa),5) -- eski şifre roundedi
	dxDrawText(isTyping_prepass or "Eski Şifre",x+160,y-25,w,h,tocolor(220,220,220,alphaa),1,robotomed2)

	roundedRectangle(x+150,y+7,200,h,tocolor(14,14,14,alphaa),5) -- yeni şifre roundedi
	dxDrawText(isTyping_newpass or "Yeni Şifre",x+160,y+15,w,h,tocolor(220,220,220,alphaa),1,robotomed2)

	roundedRectangle(x+183,y+45,130,30,tocolor(24,24,24,alphaa3),5) -- buton roundedi
	dxDrawText("Onayla",x+220,y+50,w,h,tocolor(220,220,220,alphaa),1,robotomed2)

	roundedRectangle(scx+330,scy-67,100,h,tocolor(5,5,5,alphaa),7) -- geri dön roundedi
	dxDrawText(ayarlaricon,scx+335,scy-62,w,h,tocolor(200,200,200,alphaa2),1,awesome) -- geri dön iconu
	dxDrawText("Geri Dön",scx+360,scy-59,w,h,tocolor(200,200,200,alphaa2),1,robotomed) -- geri dön texti

	roundedRectangle(scx+330,scy-30,135,h,tocolor(5,5,5,alphaa),7) -- suncuudan cık roundedi
	dxDrawText(closeicon,scx+335,scy-25,w,h,tocolor(200,200,200,alphaa2),1,awesome) -- suncuudan cık iconu
	dxDrawText("Sunucudan Çık",scx+360,scy-22,w,h,tocolor(200,200,200,alphaa2),1,robotomed) -- suncuudan cık texti
end 

function character2()
		arayuz()
		if isCursorOnElement(x+220,y+50,50,20) then 
			dxDrawText("Onayla",x+220,y+50,w,h,tocolor(0,220,0,alphaa),1,robotomed2)
		end
	
		if isCursorOnElement(scx+335,scy-62,40,20) then 
			dxDrawText(ayarlaricon,scx+335,scy-62,w,h,tocolor(220,0,0, alphaa3),1,awesome) -- geri dön iconu
			dxDrawText("Geri Dön",scx+360,scy-59,w,h,tocolor(220,0,0, alphaa3),1,robotomed) -- geri dön texti
		end
	
		if isCursorOnElement(scx+335,scy-25,60,20) then 
			dxDrawText(closeicon,scx+335,scy-25,w,h,tocolor(220,0,0, alphaa3),1,awesome) -- suncuudan cık iconu
			dxDrawText("Sunucudan Çık",scx+360,scy-22,w,h,tocolor(220,0,0, alphaa3),1,robotomed) -- sunucudan cık texti
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

addEventHandler('onClientClick', root, function(btn, st)
	if (st == 'down') and (btn == 'left') then
		if not fadedOut == true then
			if isCursorOnElement(scx+335,scy-62,70,20) then 
				if isEventHandlerAdded('onClientRender', root, character2) then
				-- ayarlara gir..
				removeEventHandler('onClientRender', root, character2)
				triggerEvent('charOkut', localPlayer)
				end
			elseif isCursorOnElement(scx+335,scy-25,90,20) then 
				if isEventHandlerAdded('onClientRender', root, character2) then
					-- svden cik
					removeEventHandler('onClientRender', root, character2)
					triggerServerEvent('cikisyap', localPlayer)
				end
			end 
		end

	end
end)

addEvent('changePass', true)
addEventHandler('changePass', root, function()
	fadedOut = true
    start = getTickCount()
    addEventHandler("onClientRender",root,character2)
	setTimer(function()
		fadedOut = false
	end, 1200, 1)
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

addEventHandler('onClientClick', root, function(btn, st)
	if isEventHandlerAdded('onClientRender', root, character2) then 
		if (st == 'down') and (btn == 'left') then
			if isCursorOnElement(x+210,y-25,w,h) == true then 
				-- yazıcaksın seni gidi orospu cocugu, anladin mi.
				isTyping_prepass = ""
				secilen = 'prepass'
			elseif isCursorOnElement(x+210,y+15,w,h) == true then
				-- şifreyi gireceksin, ananı duvardan duvara vururum..
				isTyping_newpass= ""
				secilen = 'newpass'
			elseif isCursorOnElement(x+220,y+50,50,20) == true then 
				-- girişyap,skrm
				secilen = 'onay'
				triggerServerEvent('changePass', getLocalPlayer(), isTyping_prepass, isTyping_newpass)
			end 
		end
	end 
end)

bindKey('tab', 'down', function()
	if secilen == 'prepass' then  
		secilen = 'newpass'
	else
		secilen = 'prepass'
		--if (isTyping_pass:len() or 0) < 3 then isTyping_pass = '' end
	end
end)


bindKey('enter', 'down', function()
	if (getElementData(getLocalPlayer(), 'panel') or false) == true then 
		secilen = 'onay'
		--triggerServerEvent('girisyap', getLocalPlayer(), isTyping_Name, isTyping_pass)
	end 
end)

bindKey('backspace', 'down', function() 
	if secilen == 'prepass' then 
		isTyping_prepass = isTyping_prepass:sub(0, #isTyping_prepass - 1) 
	end
	if secilen == 'newpass' then 
		isTyping_newpass = isTyping_newpass:sub(0, #isTyping_newpass - 1) 
	end 
end)

addEventHandler('onClientCharacter', root, function(char)
	if secilen == 'prepass' then
		if dxGetTextWidth(isTyping_prepass, 1, robotomed2) <= 200 then 
			isTyping_prepass = isTyping_prepass .. char 
		end 
	end
	if secilen == 'newpass' then
		if dxGetTextWidth(isTyping_newpass, 1, robotomed2) <= 185 then 
			isTyping_newpass = isTyping_newpass .. char 
		end 
	end
end)