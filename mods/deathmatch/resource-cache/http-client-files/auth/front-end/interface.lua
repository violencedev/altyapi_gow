local sx, sy = guiGetScreenSize()
local w, h = 250, 27
local x, y = (sx-w)/2, (sy-h)/2

local fontroboto = exports.fonts:getFont("Roboto",25)
local fontroboto2 = exports.fonts:getFont("Roboto",12)
local fontroboto3 = exports.fonts:getFont("Roboto",11)
local fontawesome = exports.fonts:getFont("FontAwesome",55)
local fontawesome2 = exports.fonts:getFont("FontAwesome",14)
local usericon = exports.fonts:getIcon("fa-user")
local ileriicon = exports.fonts:getIcon("fa-long-arrow-right")
isTyping_Name = nil
local accountname = "gowmta"

addEventHandler('onClientPlayerJoin', root, function()
	outputChatBox('gowmta: hos geldiniz.')
end)

function nonShowPass(pass)
	if not pass then 
		return 'Şifre'
	end 
    passTable = {}
    for i = 1, #pass do 
        table.insert(passTable, pass:sub(i, i))
    end 
    -- ilk üç karakter gizlencek
    local i = 0 
    local range = math.ceil((100 * #pass) / 100) 
    for _,v in pairs(passTable) do  
        i = i + 1 
        if i <= range then 
            passTable[i] = "*"
        else
            passTable[i] = v 
        end 
    end 
    return table.concat(passTable, '')
end 




addEvent('update:Alpha', true)
addEventHandler('update:Alpha', root, function()
	start = getTickCount()
	setElementData(localPlayer, 'fadeOut', true)
end) 

function account()
if (getElementData(getLocalPlayer(), 'panel') or false) == true then
showCursor(true)
--dxDrawRectangle(sx-700,sy-450,1920,1080,tocolor(5,5,5))

alpha, alpha2, alpha3 = 220, 200, 255

dxDrawText(accountname,x+65,y-75,w,h,tocolor(255, 255, 255, alpha3),1,fontroboto)
dxDrawText(usericon,x+87,y-165,w,h,tocolor(255, 255, 255, alpha3),white,1,fontawesome)

dxDrawRectangle(x-3,y-23,256,33,tocolor(40,40,40,alpha2))
dxDrawRectangle(x,y-20,w,h,tocolor(220,220,220,alpha))

dxDrawRectangle(x-3,y+20,256,33,tocolor(40,40,40,alpha2))
dxDrawRectangle(x,y+23,w,h,tocolor(220,220,220,alpha))
dxDrawRectangle(x+220,y+23,30,h,tocolor(80,80,80, alpha2))
dxDrawText(ileriicon,x+224,y+24,w,h,tocolor(220,220,220,alpha2),1,fontawesome2)

if isCursorOnElement(x+224,y+24,25,25) then 
	dxDrawText(ileriicon,x+224,y+24,w,h,tocolor(20,20,20),1,fontawesome2)
end

dxDrawText("Hesabın mı yok? Oluşturalım!",x+23,y+60,w,h,tocolor(220,220,220,alpha),1,fontroboto3)

if isCursorOnElement(x+23,y+60,200,30) then 
	dxDrawText("Hesabın mı yok? Oluşturalım!",x+23,y+60,w,h,tocolor(255,194,14),1,fontroboto3)
	dxDrawText("(hesabın yok ise tıkla ve direkt oluştur.)",x-10,y+80,w,h,tocolor(220,220,220),1,fontroboto3)
end

dxDrawText(isTyping_Name or "Kullanıcı Adı",x+3,y-17,w,h,tocolor(20,20,20,alpha),1,fontroboto2)
dxDrawText(nonShowPass(isTyping_pass) or "Şifre",x+3,y+26,w,h,tocolor(20,20,20,alpha),1,fontroboto2) 

if secilen == 'name' then 
	dxDrawText('|', x+3 + dxGetTextWidth(isTyping_Name, 1, fontroboto2) + 1,y-17,w,h,tocolor(20,20,20,220),1,fontroboto2)
end 
if secilen == 'pass' then 
	dxDrawText('|', x+3 + dxGetTextWidth(nonShowPass(isTyping_pass), 1, fontroboto2) + 1,y+26,w,h,tocolor(20,20,20,220),1,fontroboto2)
end 
end


end
addEventHandler('onClientRender', root, account)
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
	if isEventHandlerAdded('onClientRender', root, account) then
		if (st == 'down') and (btn == 'left') then
			if isCursorOnElement(x+3,y-17,w,h) == true then 
				-- yazıcaksın seni gidi orospu cocugu, anladin mi.
				isTyping_Name = ""
				secilen = 'name'
			elseif isCursorOnElement(x+3,y+26,w - 30,h) == true then
				-- şifreyi gireceksin, ananı duvardan duvara vururum..
				isTyping_pass = ""
				secilen = 'pass'
			elseif isCursorOnElement(x+224,y+24,w,h) == true then 
				-- girişyap,skrm
				secilen = 'giris'
				triggerServerEvent('girisyap', getLocalPlayer(), isTyping_Name, isTyping_pass)
			elseif isCursorOnElement(x+23,y+60,w,h) == true then 
				-- kayıtol skrm
				secilen = 'kayıt'
				triggerServerEvent('kayitol', getLocalPlayer(), isTyping_Name, isTyping_pass)
			end 
		end
	end
end)

bindKey('tab', 'down', function()
	if secilen == 'pass' then  
		secilen = 'name'
	else
		secilen = 'pass'
		--if (isTyping_pass:len() or 0) < 3 then isTyping_pass = '' end
	end
end)


bindKey('enter', 'down', function()
	if (getElementData(getLocalPlayer(), 'panel') or false) == true then 
		secilen = 'giris'
		triggerServerEvent('girisyap', getLocalPlayer(), isTyping_Name, isTyping_pass)
	end 
end)

bindKey('backspace', 'down', function() 
	if secilen == 'name' then 
		isTyping_Name = isTyping_Name:sub(0, #isTyping_Name - 1) 
	end
	if secilen == 'pass' then 
		isTyping_pass = isTyping_pass:sub(0, #isTyping_pass - 1) 
	end 
end)

addEventHandler('onClientCharacter', root, function(char)
	if secilen == 'name' then
		if dxGetTextWidth(isTyping_Name, 1, fontroboto2) <= 245 then 
			isTyping_Name = isTyping_Name .. char 
		end 
	end
	if secilen == 'pass' then
		if dxGetTextWidth(isTyping_pass, 1, fontroboto2) <= 210 then 
			isTyping_pass = isTyping_pass .. char 
		end 
	end
end)

