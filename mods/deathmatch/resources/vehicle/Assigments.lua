local db = exports.database:getConn()

--[[
Bu koddan sonradan kaldıracak olan utilleri en yukarı alıyorum
--]]

-- util
function getVehicleFromID(vehicleId)
 for _, vehicle in pairs(getElementsByType('vehicle')) do
  if (tonumber(getElementData(vehicle, 'id')) == tonumber(vehicleId)) then
  return vehicle
 end 
end
 return nil
end

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
-- utillerin bitişi

addCommandHandler("makeveh", function(player, command, ...)
local args = {...}
 if #args < 5 then
  return outputChatBox("[!]#ffffff Bütün parametreler doldurulmadı.", player, 255, 0, 0, true)
 end
 if not tonumber(args[1]) then
  return outputChatBox("[!]#ffffff Araç modeli belirtilmedi.", player, 255, 0, 0, true)
 end
 local model = tonumber(args[1])
 local owner = tostring(args[2])
  local r = args[3]
  local g = args[4]
  local b = args[5]
  local st1 = string.char(math.random(65,90))
  local st2 = string.char(math.random(65,90))
  local plaka = st1 .. st2 .. math.random(0, 9) .. " " .. math.random(1000, 9999)
  local x, y, z = getElementPosition(player)
  local rotX, rotY, rotZ = getElementRotation(player)
  local vehicle = createVehicle(model, x+2, y+1, z+1, 0, 0, r, plaka)
  setElementData(vehicle, "sahip", owner)
  setVehicleColor(vehicle, r, g, b)
  outputChatBox("[!]#ffffff Araç oluşturuldu | Model: " ..model.. " | Sahibi: " ..owner.. ".", player, 0, 255, 0, true)
    local aracUptade = dbExec(db, 'INSERT INTO araclar(model, x, y, z, owner, plaka, r, g, b) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)', model, x, y, z, owner, plaka, r, g, b)
end)




addCommandHandler("getveh", function(player, command, vehicleId)
  if not tonumber(vehicleId) then
   return outputChatBox("[!]#ffffff Araç ID'si belirtilmedi.", player, 255, 0, 0, true)
  end
  local arac = getVehicleFromID(vehicleId)
  if not arac then
   outputChatBox("[!]#ffffff Bu ID'ye sahip hiç bir araç yok.", player, 255, 0, 0, true)
  else
  local x,y,z = getElementPosition(player)
  setElementPosition(arac, x+2, y, z)
  outputChatBox("[!]#ffffff" ..tonumber(vehicleId).. " ID'sine sahip araç yanına getirildi.", player, 0, 255, 0, true)
  end
end)

addCommandHandler("apark", function(player, command)
 local occupied = getPedOccupiedVehicle(player)
 if not occupied then
  outputChatBox("[!]#ffffff Bu işlemi uygulamak için herhangi bir araç içerisinde olman gerek.", player, 255, 0, 0, true)
 else
 local aracData = getElementData(occupied, "id")
 local aracX, aracY, aracZ = getElementPosition(occupied)
 local posUptade = dbExec(db, 'UPDATE araclar SET x = ?, y = ?, z = ? WHERE id = ?', aracX, aracY, aracZ, aracData)
  outputChatBox("[!]#ffffff Aracın pozisyonu başarı ile değiştirildi.", player, 0, 255, 0, true)
 end
end)


addCommandHandler("fixveh", function(player, command, target)
 if not target then
  outputChatBox("[!]#ffffff Bir oyuncu ismi girmelisin.", player, 255, 0, 0, true)
 else
  local target = getPlayerByPartialNick(target)
  local veh = getPedOccupiedVehicle(target)
  if veh then
   fixVehicle(veh)
   outputChatBox("[!]#ffffff Oyuncunun aracı tamir edildi.", player, 0, 255, 0, true)
   outputChatBox("[!]#ffffff" ..getElementData(player, "account:username").. " isimli admin aracınızı tamir etti.", player, 0, 255, 0, true)
  else
   outputChatBox("[!]#ffffff Seçtiğin oyuncu herhangi bir araçta değil.", player, 255, 0, 0, true)
  end
 end
end)




addCommandHandler("delveh", function(player, command, vehicleId)
 if not tonumber(vehicleId) then
  return outputChatBox("[!]#ffffff Araç ID'si belirtilmedi.", player, 255, 0, 0, true)
 end
 local id = tonumber(vehicleId)
  local vehicle = getVehicleFromID(vehicleId)
  local dbid = getElementData(vehicle, "id")
  local sahip = getElementData(vehicle, "sahip")
  outputChatBox("[!]#ffffff Araç silindi | Veritabanı kayıt numarası: " ..dbid.. " | Sahibi: " ..sahip.. ".", player, 0, 255, 0, true)
  destroyElement(vehicle)
    local sqliteUptade = dbExec(db, 'DELETE FROM araclar WHERE id = ?', dbid)
end)

addEventHandler("onVehicleEnter", root, function(player)
 local owner = getElementData(source, "sahip")
 local id = getElementData(source, "id")
 local name = getVehicleName(source)
 outputChatBox("Bu aracın modeli: " ..name, player, 154, 154, 154, true)  
 outputChatBox("Bu aracın sahibi: " ..owner, player, 154, 154, 154, true)
 outputChatBox("Bu aracın veritabanı kayıt numarası: " ..id, player, 154, 154, 154, true)
end)


addEventHandler('onResourceStart', resourceRoot, function()
    dbQuery(function(qh)
        local results = dbPoll(qh, -1)
        for index, key in pairs(results) do 
         local vehicle = createVehicle(key.model, key.x+2, key.y+1, key.z+1, 0, 0, key.r, key.plaka)
		 setElementData(vehicle, "sahip", key.owner)
		 setElementData(vehicle, "id", key.id)
		 setVehicleColor(vehicle, key.r, key.g, key.b)
        end 
    end, db, 'SELECT * FROM araclar ORDER BY id')
end)
