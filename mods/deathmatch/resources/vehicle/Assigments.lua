local db = exports.database:getConn()

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


-- util
function getVehicleFromID(vehicleId)
 for _, vehicle in pairs(getElementsByType('vehicle')) do
  if (tonumber(getElementData(vehicle, 'id')) == tonumber(vehicleId)) then
  return vehicle
 end 
end
 return nil
end


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

addEventHandler('onResourceStart', resourceRoot, function()
    dbQuery(function(qh)
        local results = dbPoll(qh, -1)
        for index, key in pairs(results) do 
		 local id = key.id
		 local model = key.model
		 local x = key.x
		 local y = key.y
		 local z = key.z
		 local owner = key.owner
		 local plaka = key.plaka
		 local r = key.r
		 local g = key.g
		 local b = key.b
         local vehicle = createVehicle(model, x+2, y+1, z+1, 0, 0, r, plaka)
		 setElementData(vehicle, "sahip", owner)
		 setElementData(vehicle, "id", id)
		 setVehicleColor(vehicle, r, g, b)
        end 
    end, db, 'SELECT * FROM araclar ORDER BY id')
end)
