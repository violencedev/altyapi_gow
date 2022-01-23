local db = exports.database:getConn()

-- Utils Functions

function findFactionByID(factionID)
    for _,j in pairs(getElementsByType('team')) do 
        if tonumber(j:getID()) == tonumber(factionID) then 
            return j
        end 
    end 
end 

function getRanks(factionID)
    for _,j in pairs(getElementsByType('team')) do 
        if tonumber(j:getID()) == tonumber(factionID) then 
            return (j:getData('settings').birlikRutbeleri);
        end 
    end 
end 


-- Birlik oluşturma

local function makeFaction(player, command, factionType, ...)
    if (player:getData('admin:Level') or 0) < 3 then return player:outputChat('Bu islem icin yetkiniz yetersiz!') end
    if not tonumber(factionType) then return player:outputChat('Birlik tipini girmediniz.[1: Hükümet Birliği, 2: Çete Birliği, 3: Mafya Birliği, 4: Serbest Birlik]', 255, 0, 0) end 
    factionType = tonumber(factionType)
    if factionType > 4 or factionType < 1 then return player:outputChat('Birlik tipi hatali.[1: Hükümet Birliği, 2: Çete Birliği, 3: Mafya Birliği, 4: Serbest Birlik]') end
    local birlikAdi = table.concat({...}, ' ')
    if #birlikAdi < 3 then return player:outputChat('Birlik adini girmediniz.', 255, 0, 0) end 
    if getTeamFromName(birlikAdi) then return player:outputChat('Boyle bir birlik zaten var!', 255, 0, 0) end 
    local birlik = createTeam(birlikAdi, 255, 255, 255)
    if birlik then
        local birlikRutbeleri = {}
        local birlikMaaslari = {}
        for i = 1, 10 do 
            table.insert(birlikRutbeleri, "Tanımsız Rütbe")
            if factionType == 1 then 
                table.insert(birlikMaaslari, 100)
            end 
        end 
        birlik:setData('settings', {
            birlikTipi = factionType,
            birlikRutbeleri = birlikRutbeleri,
            birlikMaaslari = birlikMaaslari,
            birlikAraclari = toJSON({}),
            birlikMOTD = "Yeni birliğe hoş geldin kullanıcı!"
        })
        local execution = dbExec(db, 'INSERT INTO birlikler(birlikAdi, birlikTipi, birlikRutbeleri, birlikMaaslari, birlikAraclari, birlikMOTD) VALUES(?, ?, ?, ?, ?, ?)', birlikAdi, factionType, toJSON(birlikRutbeleri), toJSON(birlikMaaslari), toJSON({}), "Yeni birliğe hoş geldin oyuncu!")
        if execution == true then 
            player:outputChat('Basariyla birlik olusturuldu! [' .. birlikAdi .. ']', 0, 255, 0)
            dbQuery(function(queryHandle)   
                local results = dbPoll(queryHandle, 0)
                local myResult = results[1]
                birlik:setID(tostring(myResult.id))
            end, db, 'SELECT id FROM birlikler ORDER BY id DESC LIMIT 1')
        else
            player:outputChat('Sunucu kaynakli bir sorundan dolayi birlik olusturulamadi!', 255, 0, 0)
        end 
    else 
        player:outputChat('Bilinmeyen bir hata meydana geldi!', 255, 0, 0)
    end
end 
addCommandHandler('makeFaction', makeFaction, false, false)

-- Birliğe Atma

local function setFaction(player, command, targetPlayer, factionID)
    if (player:getData('admin:Level') or 0) < 2 then return player:outputChat('Bu islem icin yetkiniz yetersiz!') end
    if not targetPlayer then return player:outputChat('Oyuncuyu girmediniz.') end
    if not getPlayerFromName(targetPlayer) then return player:outputChat('Oyuncu bulunamadi.') end 
    if not tonumber(factionID) then return player:outputChat('Birlik ID\'sini giriniz.') end 
    if tonumber(factionID) == 0 then return setPlayerTeam(getPlayerFromName(targetPlayer), nil), player:outputChat('Basariyla oyuncunun birligi kaldirildi.'), getPlayerFromName(targetPlayer):outputChat('Bulunduğunuz birlikten alindiniz!') end
    local faction = findFactionByID(factionID)
    if faction then 
        local targetPlayer, targetPlayerName = getPlayerFromName(targetPlayer), targetPlayer
        if getPlayerTeam(targetPlayer) == faction then return player:outputChat('Bu oyuncu zaten bu birlikte!', 255, 0, 0) end 
        local change = setPlayerTeam(targetPlayer, faction)
        if change == true then 
            dbExec(db, 'UPDATE karakterler SET factid = ?, factrank = ? WHERE id = ?', tonumber(factionID), 1, targetPlayer:getData('charid'))
            player:outputChat(targetPlayerName .. ' isimli oyuncu basariyla ' .. getTeamName(faction) .. ' isimli birlige aktarildi!', 0, 255, 0)
            targetPlayer:outputChat('Bir yetkili tarafindan ' .. getTeamName(faction) .. ' isimli birlige aktarildiniz!', 0, 255, 0)
            targetPlayer:setData('faction', tonumber(factionID))
            targetPlayer:setData('rank', 1)
        else
            player:outputChat('Bilinmeyen bir hata meydana geldi!', 255, 0, 0)
        end 
    else 
        player:outputChat('Birlik bulunamadi!')
    end 
end 
addCommandHandler('setFaction', setFaction, false, false)

-- Birlik Render

addEventHandler('onResourceStart', resourceRoot, function()
    dbQuery(function(qH)
        local results = dbPoll(qH, 0)
        if #results > 0 then 
            for _,j in pairs(results) do 
                local birlik = createTeam(j.birlikAdi, 255, 255, 255)
                birlik:setData('settings', {
                    birlikTipi = j.birlikTipi,
                    birlikRutbeleri = fromJSON(j.birlikRutbeleri),
                    birlikMaaslari = fromJSON(j.birlikMaaslari),
                    birlikAraclari = fromJSON(j.birlikAraclari),
                    birlikMOTD = j.birlikMOTD
                })
                birlik:setID(j.id)
            end 
            for _,j in pairs(getElementsByType('player')) do 
                if j:getData('faction') >= 1 then 
                    for _,x in pairs(getElementsByType('team')) do 
                        if tonumber(x:getID()) == j:getData('faction') then 
                            setPlayerTeam(j, x)
                        end 
                    end 
                end 
            end 
        end 
    end, db, 'SELECT * FROM birlikler')
end)