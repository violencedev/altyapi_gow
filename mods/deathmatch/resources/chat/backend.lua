-- writting by arsenic - time: 01:54 - 22.01.2022

function getNearbyPlayers(thePlayer,range)
	--burasi alinti.
    local x,y,z = getElementPosition(thePlayer)
    local interior = getElementInterior(thePlayer)
    local dimension = getElementDimension(thePlayer)
    if not range then range = 20 end
    local nearbyPlayers = {}
    for index, player in ipairs(getElementsByType("player")) do 
        if getDistanceBetweenPoints3D(x, y, z, getElementPosition(player)) <= range and getElementDimension(player) == getElementDimension(thePlayer) and getElementInterior(player) == getElementInterior(thePlayer) then
            nearbyPlayers[#nearbyPlayers + 1] = player
        end 
    end 
    return nearbyPlayers 
end

function chatJoinFalse()
	-- yeni bir oyuncu sunucuya girdiginde chate mesaj gondertme..
	local loggedin = getElementData(source, "loggedin")
	if loggedin == 0 then cancelEvent() return end
end
addEventHandler("onPlayerChat",root,chatJoinFalse)

function mesajYolla(message,messageType)
	local loggedin = getElementData(source,"loggedin")
	if loggedin == 0 then cancelEvent() return end

		if messageType == 0 then 
			cancelEvent()
		  for k,v in pairs(getNearbyPlayers(source)) do
		  	playerAdi = getPlayerName(source):gsub("_"," ")
		  	r,g,b = 255,255,255
		  	-- chate mesaj yollayacaksin..
		  	mesaj = message:gsub("^%l",string.upper) -- uzun ugraslar duzeltildi..
		  	outputChatBox(playerAdi.." diyor ki: "..mesaj,v,r,g,b)
	end
	elseif messageType == 1 then 
	meAction(source, "me", message)
		cancelEvent()
	end
end
addEventHandler("onPlayerChat",root,mesajYolla)

function oocChat(thePlayer,commandName,...)
	local loggedin = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
	if (loggedin) then
		local message = table.concat({...}, " ")
		local x, y, z = getElementPosition(thePlayer)
		for index, nearbyPlayer in ipairs(getElementsByType("player")) do
			if isElement(nearbyPlayer) and getDistanceBetweenPoints3D(x, y, z, getElementPosition(nearbyPlayer)) < ( 20 ) then
				--ooc mesaj yollayacaksin, sikmeyim gotunu.	
				r,g,b = 180,180,180
				outputChatBox("[OOC] "..string.gsub(getPlayerName(thePlayer),"_", " ")..": (( " ..message.. " ))",nearbyPlayer,r,g,b)
			end
		end 
	end
end	
addCommandHandler("b",oocChat)
addCommandHandler("OOC", oocChat)


function doAction(thePlayer,commandName,...)
	local loggedin = getElementData(thePlayer, "loggedin")
	if (loggedin) then
		local action = table.concat({...}, " ")
		local x, y, z = getElementPosition(thePlayer)
		for index, nearbyPlayer in ipairs(getElementsByType("player")) do
			if isElement(nearbyPlayer) and getDistanceBetweenPoints3D(x, y, z, getElementPosition(nearbyPlayer)) < ( 20 ) then
				outputChatBox("* "..action.." (( " ..string.gsub(getPlayerName(thePlayer),"_", " ").. " ))",nearbyPlayer,203, 82, 183)
			end
		end 
	end
end	
addCommandHandler("do",doAction)

function meAction(thePlayer,commandName,...)
	local loggedin = getElementData(thePlayer, "loggedin")
	if (loggedin) then
		local action = table.concat({...}, " ")
		local x, y, z = getElementPosition(thePlayer)
		for index, nearbyPlayer in ipairs(getElementsByType("player")) do
			if isElement(nearbyPlayer) and getDistanceBetweenPoints3D(x, y, z, getElementPosition(nearbyPlayer)) < ( 20 ) then
				outputChatBox("* " ..string.gsub(getPlayerName(thePlayer), "_", " ").. " " ..action,nearbyPlayer,203, 82, 183)
			end
		end 
	end
end	
addCommandHandler("Me",meAction)


--util
function str2obj(str, formatterFx)
    local obj = {}
    for i=1, #str
    do
        local char = string.sub(str, i, i)
        if formatterFx then
            char = formatterFx(char)
        end 
        obj[char] = true
    end
    return obj
end


function getPlayerByPartialNick(nick)
    local player, playernick;

    local nickObj = str2obj(nick, string.lower)
    local players = getElementsByType "player"
    local maxFoundCharsCount = 0
    for i=1, #players
    do
        local _player = players[i]

        playernick = getPlayerName(_player)
        local foundCharsCount = 0
        for i=1, #playernick
        do
            local char = string.sub(playernick, i, i):lower()
            if nickObj[char] then
                foundCharsCount = foundCharsCount + 1
            end
        end

        if foundCharsCount > maxFoundCharsCount then
            maxFoundCharsCount = foundCharsCount
            player = _player
        end
    end
    
    return player, playernick
end
--util bitişi


addCommandHandler("pm", function(player, cmd, target, ...)
local loggedin = getElementData(target, "loggedin")
   if not target then
    outputChatBox("[!]#ffffff Oyuncu bulunamadı.", player, 255, 0, 0, true)
     return end
 if not (...) then
    outputChatBox("[!]#ffffff Mesajın bir içeriği olmalı.", player, 255, 0, 0, true)
 return end
   local target = getPlayerByPartialNick(target)
    local id = getElementData(target, "id")
     local mesaj = table.concat({...}, " ")
      outputChatBox(">> Gönderilen PM (" ..id..") " ..getPlayerName(target):gsub("_", " ").. ": " ..mesaj, player, 255, 255, 0, true)
      outputChatBox("<< Gelen PM ("..id..") " ..getPlayerName(player):gsub("_", " ").. ": " ..mesaj, target, 255, 255, 0, true)
 end
)
 

 

