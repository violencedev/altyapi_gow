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
		  	outputChatBox(playerAdi.." konusmakta: "..mesaj,v,r,g,b)
	end
	elseif messageType == 1 then 
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
				outputChatBox("[OOC] "..string.gsub(getPlayerName(thePlayer),"_", " ")..": (( " ..table.concat({...}, " ").. " ))",v,r,g,b)
			end
		end 
	end
end	
addCommandHandler("b",oocChat)
