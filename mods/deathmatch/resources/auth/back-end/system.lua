komutEkle = addCommandHandler
local db = exports.database:getConn()

addEvent('kayitol', true)
addEventHandler('kayitol', root, function(username, password)
    player = client
    if not username or not password then return outputChatBox('Kullanici adi ve sifre girmelisiniz.', player, 255, 0, 0) end
    if isAccountExists(username) == true then return outputChatBox('Boyle bir hesap zaten kayitlarda mevcut.', player, 255, 0, 0) end
    if not isAltsValid(username, password) == true then return outputChatBox('Girilen bilgiler uygun degil.', player, 255, 0, 0) end
    outputChatBox('Basariyla hesabiniz olusturuldu! [isim: ' .. username .. ' sifre:' .. nonShowPass(password) .. ']', player, 0, 255, 0)
    dbExec(db, 'INSERT INTO hesaplar(ad, email, characters, sifre, serial) VALUES(?, ?, ?, ?, ?)', username, "","", password, getPlayerSerial(player))
    executeTable(username, password, getPlayerSerial(player), "")
end)

addEvent('girisyap', true)
addEventHandler('girisyap', root, function(username, password)
    player = client
    if not username or not password then return outputChatBox('Kullanici adi ve sifre girmelisiniz.', player, 255, 0, 0) end
    if not isAccountExists(username) == true then return outputChatBox('Boyle bir hesap zaten kayitlarda mevcut degil.', player, 255, 0, 0) end
    if not isAltsMatching(username, password) == true then return outputChatBox('Bu hesaba ait girilen bilgiler yanlis.', player, 255, 0, 0) end
    if not getPlayerSerial(player) == getAccountSerial(username, password) then return outputChatBox('Bu hesaba ait serial bu degil, bir hata oldugunu dusunuyorsaniz yetkililere ulasiniz...', player, 255, 0, 0) end
    outputChatBox('Basariyla hesabiniza giris yaptiniz! [isim: ' .. username .. ']', player, 0, 255, 0)
    setElementData(player, 'panel', false)
    triggerClientEvent('update:Alpha', player)
    triggerClientEvent('charOkut', player)
    setElementData(player, 'account:username', username)
    showCursor(player, true)
    transferData(player)
    --triggerClientEvent('char:Update', player, characterRetrieved(player, username))
end)

addEvent('hesaba:Giris', true)
addEventHandler('hesaba:Giris', root, function()
    setElementData(client, 'karakter:Sec', false)
    showCursor(false)
    setCameraTarget(client, client)
end)

addEvent('cikisyap', true)
addEventHandler('cikisyap', root, function()
    kickPlayer(client)
end)

addEvent('changePass', true)
addEventHandler('changePass', root, function(prePass, newPass)
    if isAltsMatching((getElementData(client, 'account:username') or ""), prePass) == true then 
        if not isAltsValid(getElementData(client, 'account:username'), newPass) == true then return outputChatBox('Girilen bilgiler uygun degil.', player, 255, 0, 0) end
        local executionProc = dbExec(db, 'UPDATE hesaplar SET sifre = ? WHERE serial = ?', newPass, getAccountSerial(getElementData(client, 'account:username'), prePass))
        if not executionProc == true then return outputChatBox('Sunucu tarafli bir hata meydana geldi!', client, 255, 0, 0) end
        outputChatBox('Sifreniz basariyla degistirildi! Yeni sifreniz : [' .. newPass .. ']', client, 0, 255, 0)
        table.remove(accounts, getRowFromSerial(getAccountSerial(getElementData(client, 'account:username'))))
        executeTable(getElementData(client, 'account:username'), newPass, getAccountSerial(getElementData(client, 'account:username')), "")
    else
        outputChatBox('Bilgileriniz yanlis!', client, 255, 0, 0)
    end 
end)


addEventHandler('onResourceStart', resourceRoot, function()
    dbQuery(function(qH)
        local results = dbPoll(qH, 0)
        for _,v in pairs(results) do 
            table.insert(accounts, {acid=v.id, acname=v.ad, characters=v.characters, unHashedPassword=v.sifre, serial=v.serial, email=v.email})    
        end 
    end, db, 'SELECT * FROM hesaplar')
    dbQuery(function(qH)
        local results = dbPoll(qH, 0)
        for _,v in pairs(results) do 
            table.insert(characters,{charName=v.charName, weight=v.weight, height=v.height, age=v.age, irk=v.irk, sex=v.sex, skinid=v.skinid, x=v.x, y=v.y, z=v.z, money=v.money, account=v.account})
        end 
    end, db, 'SELECT * FROM karakterler')
end)

function getAccountSerial(username, password)
    for _,v in pairs(accounts) do 
        if v.acname == username then 
            if v.unHashedPassword == password then 
                return v.serial
            end 
        end 
    end 
end 


function getRowFromSerial(serial)
    for k,v in pairs(accounts) do 
        if v.serial == serial then 
            return k 
        end 
    end 
end 

function updateTable(newPass, serial) 
    for _,v in pairs(accounts) do 
        if v.serial == serial then 
            v.unHashedPassword = newPass
        end 
    end 
end 

function executeTable(username, pass, serial, email)
    dbQuery(function(queryHandle)
        local results = dbPoll(queryHandle, 0)
        local result = results[1]
        table.insert(accounts, {acid=tonumber(result.id), acname=username, characters="", unHashedPassword=pass, serial=serial, email=email})     
    end, db, 'SELECT * FROM hesaplar ORDER BY id DESC LIMIT 1')
end 

function nonShowPass(pass)
    passTable = {}
    for i = 1, #pass do 
        table.insert(passTable, pass:sub(i, i))
    end 
    -- ilk üç karakter gizlencek
    local i = 0 
    local range = math.ceil((40 * #pass) / 100) 
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

function isAltsValid(username, password)
    if string.len(username) < 3 then return false end  
    if string.len(password) < 6 then return false end
    return checkPass(password)
end 
function checkPass(pass) passTablosu = {} for i = 1, #pass do table.insert(passTablosu, pass:sub(i,i)) end for _,v in pairs(passTablosu) do if v:upper() == v then durum = true end if durum == true then if tonumber(v) then return true end end end end 

function isAccountExists(username)
    for _,v in pairs(accounts) do 
        if username == v.acname then 
            return true 
        end 
    end 
end 

function isAltsMatching(username, password)
    for _,v in pairs(accounts) do 
        if username == v.acname then 
            if password == v.unHashedPassword then 
                return true 
            end
        end 
    end 
end 


-- Sound Algorithm by violence

function shuffleSounds(affectedGuy, current)
    if not current then current = "" end 
    sounds = {"1-Pop Smoke-Element", "2-Pop Smoke-Get Back", "3-GTA-Arabesque"};
    local pickedSound = math.random(1, 3)
    if current == (sounds[pickedSound] .. '.mp3') then
        shuffleSounds(affectedGuy, current) 
    else
    local soundPath = sounds[pickedSound] .. '.mp3'
    triggerClientEvent('music:callBack', affectedGuy, soundPath)
    end
end 
addEvent('call:ServerMusic', true)
addEventHandler('call:ServerMusic', root, shuffleSounds)

-- Character creation proc by violence.

function createCharacterAttempt(charName, weight, height, age, irk, sex, skinid)
    weight, height, age = tonumber(weight), tonumber(height), tonumber(age)
	local splitted = string.match(charName, "_")
    if not splitted then return outputChatBox('İsimler arasında alt cizgi bulunmali.', client, 255, 0, 0) end 
    if isExists(charName) == true then  return outputChatBox('Boyle bir karakter mevcut.', client, 255, 0, 0) end
    if not tonumber(weight) or not tonumber(height) or not tonumber(age) then return outputChatBox('İfadelerde yazim hataniz mevcut.', client, 255, 0, 0) end
    if (((age < 15) or (age > 100)) or ((weight < 40) or (weight > 140)) or ((height < 150) or (height > 205))) then return outputChatBox('Birim degerlerinde mantik hatasi mevcut.', client, 255, 0, 0) end 
    

    -- Create char
    setElementData(client, 'loggedin', 1)
    -- server-side'da oturan ibne, bu hesabi olusturucaksin yoksa hem kullaniciy hem de seni sikerim!
    setCameraTarget(client, client)
    showCursor(client, false)
    showChat(client, true)
    setPlayerName(client, charName)
    if getElementData(client, 'ped:') then destroyElement(getElementData(client, 'ped:')) end
    setElementModel(client, tonumber(skinid))
    setElementData(client, 'charSettings', {
        name = charName, 
        weight = weight,
        height = height, 
        age = age, 
        irk = irk, 
        sex = sex, 
        skinid = skinid
    })
    setElementData(client, 'money', 100)
    table.insert(characters,{charName=charName, weight=weight, height=height, age=age, irk=irk, sex=sex, skinid=skinid, x=0, y=0, z=5, money=100, account=getElementData(client, 'account:username')})
    local sql = dbExec(db, 'INSERT INTO karakterler(charName, weight, height, age, irk, sex, skinid, x, y, z, money, account) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', charName, weight, height, age, irk, sex, skinid, 0, 0, 5, 100, getElementData(client, 'account:username'))
    local sql2 = dbExec(db, 'UPDATE hesaplar SET characters = ? WHERE ad = ?', retrieveCharacters(getElementData(client, 'account:username')), getElementData(client, 'account:username'))
    getID(client, charName)
    triggerClientEvent('deactivate:Interface', client)
    triggerClientEvent('stop:Music', client)
end 
addEvent('charAttempt', true)
addEventHandler('charAttempt', root, createCharacterAttempt)


function isExists(charName)
    for _,v in pairs(characters) do 
        if v.charname == charName then 
            return true
        end 
    end 
    return false
end 

function retrieveCharacters(accountName) 
    characters2 = {}
    for _,v in pairs(characters) do 
        if v.account == accountName then 
            table.insert(characters2, v.charname)
        end 
    end 
    return characters2
end 

function getID(pl, charName)
        dbQuery(function(qH)
            local results = dbPoll(qH, 0) 
            local result_id = results[1]
            setElementData(pl, 'charid', result_id)
        end, db, 'SELECT id FROM karakterler WHERE charName = ?', charName)
end 


function transferData(pl)
    triggerClientEvent('transfer:Data', pl, characters)
end 

addEvent('fix:ped', true)
addEventHandler('fix:ped', root, function()
    if isElement(getElementData(client, 'ped:')) == false then return end
    setElementVisibleTo(getElementData(client, 'ped:'), root, false)
    setElementVisibleTo(getElementData(client, 'ped:'), client, true)
end)

addEvent('redirect:EnterChar', true)
addEventHandler('redirect:EnterChar', root, function(char)
    setElementData(client, 'loggedin', 1)
    -- server-side'da oturan ibne, bu hesaba giriceksin yoksa hem kullaniciy hem de seni sikerim!
    setCameraTarget(client, client)
    showCursor(client, false)
    showChat(client, true)
    if getElementData(client, 'ped:') then destroyElement(getElementData(client, 'ped:')) end
    setPlayerName(client, tostring(char["charName"]))
    setElementModel(client, tonumber(char.skinid))
    setElementData(client, 'charSettings', {
        name = char.charName, 
        weight = char.weight,
        height = char.height, 
        age = char.age, 
        irk = char.irk, 
        sex = char.sex, 
        skinid = char.skinid
    })
	setElementData(client, 'money', char.money)
    getID(client, charName)
    triggerClientEvent('stop:Music', client)
end)

