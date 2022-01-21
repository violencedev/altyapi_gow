local db = exports.database:getConn()

allItems = {
    [1] = {itemID=1, itemName='Sosisli Ekmek', itemDesc='Yenebilecek bir şey.', itemPic="items_pics/1.png", itemWeight=0.05},
    [2] = {itemID=2, itemName='Akıllı Telefon', itemDesc='Dokunmatik bir telefon.', itemPic="items_pics/2.png", itemWeight=0.10},
    [3] = {itemID=3, itemName='Araba Anahtarı', itemDesc='Arabayı kontrol etmeye yarar.', itemPic="items_pics/3.png", itemWeight=0.02},
    [4] = {itemID=4, itemName='Mülk Anahtarı', itemDesc='Mülklerinizi kontrol etmeye yarar.', itemPic="items_pics/4.png", itemWeight=0.02},
    [8] = {itemID=8, itemName='Sandviç', itemDesc='Yenebilecek bir şey.', itemPic="items_pics/8.png", itemWeight=0.03},
    [12] = {itemID=12, itemName='Hamburger', itemDesc='Yenebilecek bir şey.', itemPic="items_pics/12.png", itemWeight=0.03},
    [13] = {itemID=13, itemName='Donut', itemDesc='DYenebilecek bir şey.', itemPic="items_pics/13.png", itemWeight=0.03},
    [17] = {itemID=17, itemName='Kol Saati', itemDesc='Kolunuzda duran, saate bakılabilecek şey.', itemPic="items_pics/17.png", itemWeight=0.08},
    [18] = {itemID=18, itemName='Magazin', itemDesc='Okunabilecek bir şey.', itemPic="items_pics/18.png", itemWeight=0.06}
}


world_Items = {}

addCommandHandler('items', function(pl)
    for _,j in pairs(world_Items) do 
        --outputChatBox(j.itemOwner, pl)
        if j.itemOwner == getPlayerName(pl) then 
            outputChatBox(j.itemName, pl)
        end 
    end 
end)

function getLastID()
    for k,j in pairs(world_Items) do 
        if k == #world_Items then 
            return j.itemDBID
        end 
    end 
end 

addEventHandler('onResourceStart', resourceRoot, function()
    dbQuery(function(qH)
        local results = dbPoll(qH, 0)
        for _,v in pairs(results) do 
            table.insert(world_Items, {itemID=v.id, itemDBID=v.dbid, itemName=allItems[v.id]['itemName'], itemDesc=allItems[v.id]['itemDesc'], itemPic=allItems[v.id]['itemPic'], itemWeight=allItems[v.id]['itemWeight'],itemOwner=v.ownerName})
        end 
    end, db, 'SELECT * FROM items ORDER BY dbid')
end)


function giveItem(targetGuy, itemID, itemVal)
    itemID, itemVal = tonumber(itemID), tonumber(itemVal)
    for j=1, itemVal do 
        local curID = (getLastID() or 0) + 1
        table.insert(world_Items, {itemID=itemID, itemDBID=curID, itemName=allItems[itemID]['itemName'], itemDesc=allItems[itemID]['itemDesc'], itemPic=allItems[itemID]['itemPic'], itemWeight=allItems[itemID]['itemWeight'],itemOwner=getPlayerName(targetGuy)})
        local sqlUpdate = dbExec(db, 'INSERT INTO items(dbid, id, ownerName) VALUES(?, ?, ?)', curID, itemID, getPlayerName(targetGuy))
    end 
end 

function delItem(itemDBID)
    itemDBID = tonumber(itemDBID)
    for k,v in pairs(world_Items) do 
        if v.itemDBID == itemDBID then 
            table.remove(world_Items, k)
            local sqlUpdate = dbExec(db, 'REMOVE FROM items WHERE dbid = ?', itemDBID)
        end 
    end 
end 

function isItemExists(itemDBID)
    for _,j in pairs(world_Items) do 
        if j.itemDBID == itemDBID then 
            return true
        end 
    end 
end 

addCommandHandler('giveitem', function(player, cmd, targetPlayer, itemID, itemValue)
    if getElementData(player, 'account:username') == 'violence' and getElementData(player, 'loggedin') == 1 then
        if not targetPlayer then return outputChatBox('Oyuncuyu belirtmedin.', player, 255, 0,0) end
        if not getPlayerFromName(targetPlayer) then return outputChatBox('Böyle bir oyuncu bulunamadi.', player, 255, 0, 0) end 
        if not allItems[tonumber(itemID)] then return outputChatBox('Bir Item ID\'si girmelisin.', player, 255, 0, 0) end 
        if not tonumber(itemValue) then return outputChatBox('Bir miktar girmelisin.', player, 255, 0, 0) end
        giveItem(getPlayerFromName(targetPlayer), itemID, itemValue)
        outputChatBox('Basariyla kullaniciya item verildi.', player, 0, 255, 0)
        outputChatBox('Bir yetkili size item verdi.', getPlayerFromName(targetPlayer), 0, 255, 0)
    else 
        outputChatBox('Bu işlemi gerçekleştiremezsin.', player, 255, 0, 0)
    end 
end)

addCommandHandler('delitem', function(player, cmd, itemDBID)
    if getElementData(player, 'account:username') == 'violence' and getElementData(player, 'loggedin') == 1 then
        if not itemDBID then return outputChatBox('Bir Item ID\'si girmelisin.', player, 255, 0, 0) end
        if not isItemExists(tonumber(itemDBID)) == true then return outputChatBox('Böyle bir item bulunamadi.', player, 255, 0, 0) end 
        delItem(itemDBID)
        outputChatBox('Basariyla item silindi..', player, 0, 255, 0)
    else 
        outputChatBox('Bu işlemi gerçekleştiremezsin.', player, 255, 0, 0)
    end 
end)