-- ayarlar 

maleskins = {1, 2, 7, 15, 16, 17, 18, 19, 20, 21, 22, 26, 27, 28}
femaleskins = {9, 10, 11, 12, 13, 31, 40, 211}

-- ayarlar 

local x, y = guiGetScreenSize()
local w, h = 260, 530

local k, c = 220, 30
local b, a = 100, 30

local screenx, screeny = (x-w)/3, (y-h)/2

local fontroboto = exports.fonts:getFont("Roboto",10)
local fontawesome = exports.fonts:getFont("FontAwesome",13)
local erkekicon = exports.fonts:getIcon("fa-male")
local kadinicon = exports.fonts:getIcon("fa-female")
local usericon = exports.fonts:getIcon("fa-user")
local arrowlefticon = exports.fonts:getIcon("fa-arrow-left")
local arrowrighticon = exports.fonts:getIcon("fa-arrow-right")

function characterCreate()

    roundedRectangle(screenx-340, screeny, w, 75, tocolor(13,13,13,220), 17) -- üst rounded
    roundedRectangle(screenx-340,screeny,w,h,tocolor(15,15,15,220), 20) -- ana rounded

    roundedRectangle(screenx-340, screeny+495, w, 35, tocolor(13,13,13,220), 17) -- en alttaki rounded

    dxDrawImage(screenx-260,screeny-13,105,105, "images/logo.png") -- logo

    dxDrawText("Cinsiyet Seçimi:",screenx-330,screeny+80,w,h,tocolor(220,220,220,220), 1, fontroboto)

    roundedRectangle(screenx-320, screeny+100, b, a, tocolor(13,13,13,220), 10) -- cinsiyet erkek rounded
    dxDrawText("Erkek",screenx-285,screeny+107,w,h,tocolor(220,220,220,220), 1, fontroboto)
    dxDrawText(erkekicon,screenx-305,screeny+103,w,h,tocolor(220,220,220,220), 1, fontawesome)
   
    roundedRectangle(screenx-218, screeny+100, b, a, tocolor(13,13,13,220), 10) -- cinsiyet kadın rounded
    dxDrawText("Kadın",screenx-185,screeny+107,w,h,tocolor(220,220,220,220), 1, fontroboto)
    dxDrawText(kadinicon,screenx-205,screeny+103,w,h,tocolor(220,220,220,220), 1, fontawesome)

    dxDrawText("Karakter Adı:",screenx-330,screeny+135,w,h,tocolor(220,220,220,220), 1, fontroboto)
    
    roundedRectangle(screenx-320, screeny+155, k, c, tocolor(13,13,13,220), 10) -- karakter adı rounded 
    dxDrawText(usericon,screenx-312,screeny+160,w,h,tocolor(220,220,220,220), 1, fontawesome)
    dxDrawText(isTyping_CharName or "Örnek: Deshaquen Lawrance",screenx-290,screeny+163,w,h,tocolor(220,220,220,220), 1, fontroboto)

    roundedRectangle(screenx-320, screeny+210, b, a, tocolor(13,13,13,220), 10) -- kıyafet seçimi sol tarafdaki icon roundedi
    roundedRectangle(screenx-218, screeny+210, b, a, tocolor(13,13,13,220), 10) -- kıyafet seçimi sağ tarafdaki icon roundedi
    dxDrawText(arrowlefticon,screenx-280,screeny+213,w,h,tocolor(220,220,220,220), 1, fontawesome)
    dxDrawText(arrowrighticon,screenx-180,screeny+213,w,h,tocolor(220,220,220,220), 1, fontawesome)
    dxDrawText("Kıyafet Seçimi:",screenx-330,screeny+190,w,h,tocolor(220,220,220,220), 1, fontroboto)

    roundedRectangle(screenx-218, screeny+270, b, a, tocolor(13,13,13,220), 10) -- ırk seçimi sağ tarafdaki icon roundedi
    roundedRectangle(screenx-320, screeny+270, b, a, tocolor(13,13,13,220), 10) -- ırk seçimi sol tarafdaki icon roundedi
    dxDrawText("Irk Seçimi:",screenx-330,screeny+245,w,h,tocolor(220,220,220,220), 1, fontroboto)
    dxDrawText("Siyahi",screenx-290,screeny+277,w,h,tocolor(220,220,220,220), 1, fontroboto)
    dxDrawText("Beyaz",screenx-187,screeny+277,w,h,tocolor(220,220,220,220), 1, fontroboto)

    roundedRectangle(screenx-320, screeny+325, k, c, tocolor(13,13,13,220), 10) -- kilo text roundedi
    dxDrawText(usericon,screenx-312,screeny+328,w,h,tocolor(220,220,220,220), 1, fontawesome)
    dxDrawText("Kilo:",screenx-330,screeny+305,w,h,tocolor(220,220,220,220), 1, fontroboto)
    dxDrawText(isTyping_weight or "Örnek: 50-120 kg",screenx-290,screeny+332,w,h,tocolor(150,150,150,220), 1, fontroboto)
    
    roundedRectangle(screenx-320, screeny+385, k, c, tocolor(13,13,13,220), 10) -- boy text roundedi
    dxDrawText(usericon,screenx-312,screeny+388,w,h,tocolor(220,220,220,220), 1, fontawesome)
    dxDrawText("Boy:",screenx-330,screeny+360,w,h,tocolor(220,220,220,220), 1, fontroboto)
    dxDrawText(isTyping_height or "Örnek: 110-190 cm",screenx-290,screeny+392,w,h,tocolor(150,150,150,220), 1, fontroboto)

    roundedRectangle(screenx-320, screeny+440, k, c, tocolor(13,13,13,220), 10) -- yaş text roundedi
    dxDrawText(usericon,screenx-312,screeny+443,w,h,tocolor(220,220,220,220), 1, fontawesome)
    dxDrawText("Yaş:",screenx-330,screeny+417,w,h,tocolor(220,220,220,220), 1, fontroboto)
    dxDrawText(isTyping_age or "Örnek: 18-65",screenx-290,screeny+447,w,h,tocolor(150,150,150,220), 1, fontroboto)
    if sex == 'erkek' then 
        dxDrawText("Erkek",screenx-285,screeny+107,w,h,tocolor(0,127,255,220), 1, fontroboto)
        dxDrawText(erkekicon,screenx-305,screeny+103,w,h,tocolor(0,127,255,220), 1, fontawesome)
    elseif sex == 'kadın' then 
        dxDrawText("Kadın",screenx-185,screeny+107,w,h,tocolor(255,86,170,220), 1, fontroboto)
        dxDrawText(kadinicon,screenx-205,screeny+103,w,h,tocolor(255,86,170,220), 1, fontawesome)     
    end
    if isCursorOnElement(screenx-305,screeny+105,60,20) then 
        dxDrawText("Erkek",screenx-285,screeny+107,w,h,tocolor(0,127,255,220), 1, fontroboto)
        dxDrawText(erkekicon,screenx-305,screeny+103,w,h,tocolor(0,127,255,220), 1, fontawesome)
    end

    if isCursorOnElement(screenx-205,screeny+107,60,20) then 
      dxDrawText("Kadın",screenx-185,screeny+107,w,h,tocolor(255,86,170,220), 1, fontroboto)
      dxDrawText(kadinicon,screenx-205,screeny+103,w,h,tocolor(255,86,170,220), 1, fontawesome)
    end

    if isCursorOnElement(screenx-280,screeny+213,25,20) then  
        dxDrawText(arrowlefticon,screenx-280,screeny+213,w,h,tocolor(0,127,255,220), 1, fontawesome) -- sol geri skin icon
    end

    if isCursorOnElement(screenx-180,screeny+213,25,20) then  
        dxDrawText(arrowrighticon,screenx-180,screeny+213,w,h,tocolor(0,127,255,220), 1, fontawesome)
    end

    if irk == 'siyahi' then 
        dxDrawText("Siyahi",screenx-290,screeny+277,w,h,tocolor(0,127,255,220), 1, fontroboto)
    elseif irk == 'beyaz' then 
        dxDrawText("Beyaz",screenx-187,screeny+277,w,h,tocolor(0,127,255,220), 1, fontroboto)
    end 

    if isCursorOnElement(screenx-290,screeny+277,30,20) then  
        dxDrawText("Siyahi",screenx-290,screeny+277,w,h,tocolor(0,127,255,220), 1, fontroboto)
    end

    if isCursorOnElement(screenx-187,screeny+277,30,20) then  
        dxDrawText("Beyaz",screenx-187,screeny+277,w,h,tocolor(0,127,255,220), 1, fontroboto)
    end
    dxDrawText("life as you wish.",screenx-270,screeny+500,w,h,tocolor(150,150,150,200),1,fontawesome)

    if isCursorOnElement(screenx-280,screeny+500,120,20) then 
        dxDrawText("life as you wish.",screenx-270,screeny+500,w,h,tocolor(math.random(0,255), math.random(0,255), math.random(0,255)),1,fontawesome)
    end


    -- curs


    if secilen == 'charName' then 
        dxDrawText('|', screenx-290 + 1 + dxGetTextWidth(isTyping_CharName, 1, fontroboto) + 1,screeny+163,w,h,tocolor(191, 190, 185,220),1,fontroboto)
    end 
    if secilen == 'weight' then 
        dxDrawText('|', screenx-290 + 1 + dxGetTextWidth(isTyping_weight, 1, fontroboto) + 1,screeny+332,w,h,tocolor(191, 190, 185,220),1,fontroboto)
    end 
    if secilen == 'height' then 
        dxDrawText('|', screenx-290 + 1 + dxGetTextWidth(isTyping_height, 1, fontroboto) + 1,screeny+392,w,h,tocolor(191, 190, 185,220),1,fontroboto)
    end 
    if secilen == 'age' then 
        dxDrawText('|', screenx-290 + 1 + dxGetTextWidth(isTyping_age, 1, fontroboto) + 1,screeny+447,w,h,tocolor(191, 190, 185,220),1,fontroboto)
    end 
end


addEvent('redirect:Creation', true)
addEventHandler('redirect:Creation', root, function()
    addEventHandler("onClientRender",root,characterCreate)
    setCameraMatrix(1908.7744140625, -1410.859375, 14.222739219666, 520.09375, -1849.947265625, 4.968677997)
    setElementData(localPlayer, 'ped:', createPed(1,1903.3544921875, -1412.71484375, 13.76549148559, 267.78210449219, false))
    triggerServerEvent('fix:ped', localPlayer)
    irk = 'beyaz'
    sex = 'erkek'
end)

addEvent('deactivate:Interface', true)
addEventHandler('deactivate:Interface', root, function()
    removeEventHandler('onClientRender', root, characterCreate)
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
	if isEventHandlerAdded('onClientRender', root, characterCreate) then
		if (st == 'down') and (btn == 'left') then
			if isCursorOnElement(screenx-290,screeny+163,170,20) == true then 
				-- yazıcaksın seni gidi orospu cocugu, anladin mi.
				isTyping_CharName = ""
				secilen = 'charName'
			elseif isCursorOnElement(screenx-290,screeny+332, 170, 20) == true then
				-- şifreyi gireceksin, ananı duvardan duvara vururum..
				isTyping_weight = ""
				secilen = 'weight'
			elseif isCursorOnElement(screenx-290,screeny+392, 170, 20) == true then 
				-- girişyap,skrm
                isTyping_height = ""
				secilen = 'height'
			elseif isCursorOnElement(screenx-290,screeny+447, 170, 20) == true then 
				-- kayıtol skrm
                isTyping_age = ""
				secilen = 'age'
            elseif isCursorOnElement(screenx-305,screeny+105,60,20) == true then 
                -- sexuality
                sex = 'erkek'
                local ped = getElementData(localPlayer, 'ped:')
                setElementModel(ped, maleskins[1])
            elseif isCursorOnElement(screenx-205,screeny+107,60,20) == true then 
                -- sexuality 2 
                sex = 'kadın'
                local ped = getElementData(localPlayer, 'ped:')
                setElementModel(ped, femaleskins[1])
            elseif isCursorOnElement(screenx-290,screeny+277,30,20) == true then 
                irk = 'siyahi'
            elseif isCursorOnElement(screenx-187,screeny+277,30,20) == true then 
                irk = 'beyaz'
            elseif isCursorOnElement(screenx-280,screeny+213,25,20) == true then 
                -- önceki skin
                local ped = getElementData(localPlayer, 'ped:')
                local pedMod = getElementModel(ped) 
                pedMod = getPreIndex(pedMod) 
                setElementModel(ped, pedMod)
            elseif isCursorOnElement(screenx-180,screeny+213,25,20) == true then 
                -- sonraki skin
                local ped = getElementData(localPlayer, 'ped:')
                local pedMod = getElementModel(ped)
                pedMod = getAfterIndex(pedMod) 
                --outputChatBox(pedMod)
                setElementModel(ped, pedMod) 
            else
                secilen = nil
            end 
		end
	end
end)

function getPreIndex(id)
    if sex == 'kadın' then targeted = femaleskins end 
    if sex == 'erkek' then targeted = maleskins end
    for k,v in pairs(targeted) do 
        if tonumber(v) == tonumber(id) then 
            if k == 1 then return targeted[-1] else return targeted[k-1] end 
        end 
    end 
    return targeted[1]
end 

function getAfterIndex(id)
    if sex == 'kadın' then targeted = femaleskins end 
    if sex == 'erkek' then targeted = maleskins end
    for k,v in pairs(targeted) do 
        if tonumber(v) == tonumber(id) then 
            return targeted[k + 1]
        end 
    end 
    return targeted[1]
end 

bindKey('enter', 'down', function()
	if isEventHandlerAdded('onClientRender', root, characterCreate) then
		secilen = 'goForCreation'
		triggerServerEvent('charAttempt', getLocalPlayer(), isTyping_CharName, isTyping_weight, isTyping_height, isTyping_age, irk, sex, getElementModel(getElementData(localPlayer, 'ped:')))
	end 
end)

bindKey('backspace', 'down', function() 
	if secilen == 'charName' then 
		isTyping_CharName = isTyping_CharName:sub(0, #isTyping_CharName - 1) 
	end
	if secilen == 'weight' then 
		isTyping_weight = isTyping_weight:sub(0, #isTyping_weight - 1) 
	end 
    if secilen == 'height' then 
		isTyping_height = isTyping_height:sub(0, #isTyping_height - 1) 
	end 
    if secilen == 'age' then 
		isTyping_age = isTyping_age:sub(0, #isTyping_age - 1) 
	end 
end)

addEventHandler('onClientCharacter', root, function(char)
	if secilen == 'charName' then
		if dxGetTextWidth(isTyping_CharName, 1, fontroboto) <= 120 then 
			isTyping_CharName = isTyping_CharName .. char 
		end 
	end
	if secilen == 'weight' then
		if dxGetTextWidth(isTyping_weight, 1, fontroboto) <= 100 then 
			isTyping_weight = isTyping_weight .. char 
		end 
	end
    if secilen == 'height' then
		if dxGetTextWidth(isTyping_height, 1, fontroboto) <= 100 then 
			isTyping_height = isTyping_height .. char 
		end 
	end
    if secilen == 'age' then
		if dxGetTextWidth(isTyping_age, 1, fontroboto) <= 100 then 
			isTyping_age = isTyping_age .. char 
		end 
	end
end)