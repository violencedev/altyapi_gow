

local sx, sy = guiGetScreenSize()
local w, h = 500, 325
local x, y = (sx-w)/2, (sy-h)/2
local yx = (sy-h)/1

local fontazzardo = exports.fonts:getFont("Azzardo-Regular",23)
local fontawesome = exports.fonts:getFont("FontAwesome",19)
local fontroboto = exports.fonts:getFont("Roboto",10)


factionGuys = {}

-- Useful guy

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

bindKey("m","down",function()
	showCursor(not isCursorShowing())
end)


function factionSystem()

	local teamVar = getPlayerTeam(localPlayer)
	local factionname = getTeamName(teamVar)
	local teamSettings = teamVar:getData('settings') 
	local teamnewmessage = teamSettings.birlikMOTD
	dxr,dxg,dxb = 50,50,50
	local playername = getPlayerName(localPlayer):gsub("_"," ")
	roundedRectangle(x,y,w,h,tocolor(24,24,24,220)) -- ana rounded

	roundedRectangle(x,y,w,45,tocolor(24,24,24,200)) -- üstdeki rounded 45 h
	--roundedRectangle(x,yx+200,w,45,tocolor(24,24,24,200)) -- alttaki rounded 45 h

	--birlik bilgeri kısmı--
	roundedRectangle(x+363,y+53,130,110,tocolor(24,24,24,220)) -- birlik bilgileri roundedi
	dxDrawRectangle(x+367,y+80,120,2,tocolor(dxr,dxg,dxb))
	dxDrawText("",x+370,y+59,w,h,tocolor(220,220,220,220),0.60,fontawesome)
	dxDrawText("Birlik ID: " .. getElementID(teamVar),x+390,y+60,w,h,tocolor(220,220,220,220),1,fontroboto)

	--birlik onay kısmı (yapilir mi bilmem) # yapilmaz kards
	dxDrawText("",x+370,y+85,w,h,tocolor(220,220,220,220),0.50,fontawesome)
	dxDrawText("Birlik Onayı: Yok",x+390,y+85,w,h,tocolor(220,220,220,220),1,fontroboto)
	dxDrawRectangle(x+367,y+107,120,2,tocolor(dxr,dxg,dxb))

	--toplam araç kısmı
	dxDrawText("",x+370,y+113,w,h,tocolor(220,220,220,220),0.50,fontawesome)
	dxDrawText("Toplam Araç: " .. #(teamSettings.birlikAraclari) ,x+392,y+113,w,h,tocolor(220,220,220,220),1,fontroboto)
	dxDrawRectangle(x+367,y+135,120,2,tocolor(dxr,dxg,dxb))

	dxDrawText("",x+370,y+140,w,h,tocolor(220,220,220,220),0.50,fontawesome)
	dxDrawText("Toplam Üye: " .. countPlayersInTeam(teamVar),x+392,y+140,w,h,tocolor(220,220,220,220),1,fontroboto)

	--üstüne basılan oyuncunun bilgileri--
	roundedRectangle(x+220,y+53,130,110,tocolor(24,24,24,220))
	dxDrawText("",x+227,y+58,w,h,tocolor(220,220,220,220),0.60,fontawesome)
	dxDrawText(playername,x+247,y+60,w,h,tocolor(220,220,220,220),1,fontroboto)
	dxDrawRectangle(x+225,y+80,120,2,tocolor(dxr,dxg,dxb))

	local player_Rank = (teamSettings.birlikRutbeleri)[tonumber(localPlayer:getData('rank'))]	
	ourFont = nil
	if dxGetTextWidth(player_Rank, 1, fontroboto) >= 75 then 
		ourFont = exports.fonts:getFont("Roboto", (dxGetTextWidth(player_Rank, 1, fontroboto) / 11))
		eklenecekAralik = 241
	end 
	dxDrawText("",x+231,y+85,w,h,tocolor(220,220,220,220),0.60,fontawesome)
	dxDrawText("Rütbe: " .. player_Rank,x+ (eklenecekAralik or 243),y+87,w,h,tocolor(220,220,220,220),1,ourFont or fontroboto)
	dxDrawRectangle(x+225,y+107,120,2,tocolor(dxr,dxg,dxb))

	dxDrawText("",x+230,y+113,w,h,tocolor(220,220,220,220),0.50,fontawesome)
	dxDrawText("Maaş: 110$",x+243,y+113,w,h,tocolor(220,220,220,220),1,fontroboto)
	dxDrawRectangle(x+225,y+135,120,2,tocolor(dxr,dxg,dxb))

	dxDrawText("",x+227,y+142,w,h,tocolor(220,220,220,220),0.40,fontawesome)
	dxDrawText("Statü: Üye",x+245,y+140,w,h,tocolor(220,220,220,220),1,fontroboto)
	--FİNİSH BU 

	roundedRectangle(x+7,y+55,202,215,tocolor(24,24,24))
	for _,g in pairs(getPlayersInTeam(teamVar)) do 
		local userRank = (teamSettings.birlikRutbeleri)[tonumber(g:getData('rank'))]
		dxDrawText("",x+12,y+57,w,h,tocolor(220,220,220,220),0.60,fontawesome)
		dxDrawRectangle(x+7,y+80,202,1,tocolor(0,0,0))
		dxDrawText(getPlayerName(g) .. "  | ",x+33,y+60,w,h,tocolor(220,220,220,220),1,fontroboto)
		dxDrawText(" " .. userRank,x+127,y+60,w,h,tocolor(220,220,220,220),1,fontroboto)

		table.insert(factionGuys, {
			name = getPlayerName(g),
			rank = userRank,
			state = 'Üye'
		})
	end 

	dxDrawText(factionname,x+5,y,w,h,tocolor(220,220,220,220),1,fontazzardo) -- birlik adı

	dxDrawText(teamnewmessage,x+10,y+292,w,h,tocolor(220,220,220,220),1,fontroboto) -- birlik mesajı

	dxDrawText("",x+420,y+287,w,h,tocolor(220,220,220,220),1,fontawesome) -- oyuncuyu factiona ekle icon
	dxDrawText("|",x+450,y+284,w,h,tocolor(220,220,220,220),1,fontawesome) 
	dxDrawText("",x+463,y+287,w,h,tocolor(220,220,220,220),1,fontawesome) -- oyuncu çıkar icon

	dxDrawText("",x+360,y+8,w,h,tocolor(220,220,220,220),0.8,fontawesome) -- arac icon
	dxDrawText("",x+410,y+7,w,h,tocolor(220,220,220,220),1,fontawesome) -- rütbeler icon
	dxDrawText("",x+460,y+7,w,h,tocolor(220,220,220,220),1,fontawesome) -- kapat icon
	dxDrawText("|",x+395,y+4,w,h,tocolor(220,220,220,220),1,fontawesome)
	dxDrawText("|",x+445,y+4,w,h,tocolor(220,220,220,220),1,fontawesome)

	if isCursorOnElement(x+420,y+287,25,20) then 
		dxDrawText("",x+420,y+287,w,h,tocolor(0,127,255),1,fontawesome) -- oyuncu facte ekle
	end

	if isCursorOnElement(x+463,y+287,25,20) then 
		dxDrawText("",x+463,y+287,w,h,tocolor(220,0,0),1,fontawesome) -- oyuncu factden cıkar
	end

	if isCursorOnElement(x+360,y+8,25,20) then 
		dxDrawText("",x+360,y+8,w,h,tocolor(0,127,255),0.8,fontawesome) -- arac icon
	end

	if isCursorOnElement(x+410,y+7,25,20) then 
		dxDrawText("",x+410,y+7,w,h,tocolor(0,127,0),1,fontawesome) -- rütbeler icon
	end

	if isCursorOnElement(x+460,y+7,25,20) then 
		dxDrawText("",x+460,y+7,w,h,tocolor(220,0,0),1,fontawesome) -- kapat icon
	end

end
--addEventHandler("onClientRender",root,factionSystem)

bindKey('F3', 'down', function()
	if isEventHandlerAdded('onClientRender', getRootElement(), factionSystem) == true then 
		removeEventHandler('onClientRender', getRootElement(), factionSystem)
		showCursor(false)
	elseif getPlayerTeam(localPlayer) then
		addEventHandler('onClientRender', getRootElement(), factionSystem)
		showCursor(true)
	end 
end)


function isCursorOnElement (x,y,w,h)
	local mx,my = getCursorPosition()
	if mx then
		local fullx,fully = guiGetScreenSize()
		cursorx,cursory = mx*fullx,my*fully
		if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
		return true
		else
		return false
		end
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


-- tıklama sikimleri

addEventHandler('onClientClick', getRootElement(), function()
	if isCursorOnElement(x+460,y+7,25,20) then 
		removeEventHandler('onClientRender', getRootElement(), factionSystem)
		showCursor(false)
	end 
end)