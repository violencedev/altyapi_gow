local db = exports.database:getConn()


-- Make admin

local function makeAdministrator(player, command, targetPlayer, adminLevel)
    if player:getData('admin:Level') < 3 then return player:outputChat('Bu islem icin yetkin yetersiz.', 255, 0, 0) end
    if not targetPlayer or not tonumber(adminLevel) then return player:outputChat('Gerekli argumanlari girmediniz. [/' .. command .. ' <oyuncu> <admin seviyesi>]', 255, 0, 0) end 
    local adminLevel = tonumber(adminLevel)
    if not getPlayerFromName(targetPlayer) then return player:outputChat('Eslesen oyuncu bulunamadi.', 255, 0, 0) end 
    if not (adminLevel >= 0) or not (adminLevel <= 8) then return player:outputChat('Admin seviyesi 0 - 8 arası olabilir.', 255, 0, 0) end
    local targetPlayerName, targetPlayer = targetPlayer, getPlayerFromName(targetPlayer)
    if ((player:getData('admin:Level')) < (targetPlayer:getData('admin:Level'))) then return player:outputChat('Yetkiniz bu oyuncudan daha dusuk.', 255, 0, 0) end 
    if (player:getData('admin:Level') < adminLevel) then return player:outputChat('Yetkiniz vereceginiz yetkiden buyuk veya esit olmali.', 255, 0, 0) end
    targetPlayer:setData('admin:Level', adminLevel)
    player:outputChat(targetPlayerName .. ' isimli oyuncu basariyla ' ..  adminLevels[adminLevel] .. ' isimli yetkiye sahip edildi.', 0, 255, 0)
    targetPlayer:outputChat('Bir yetkili tarafindan yetkiniz ' .. adminLevels[adminLevel] .. ' olarak degistirildi.', 0, 255, 0)
    dbExec(db, 'UPDATE hesaplar SET adminLevel = ? WHERE ad = ?', adminLevel, targetPlayer:getData('account:username'))
end 
addCommandHandler('makeadmin', makeAdministrator, false, false)

