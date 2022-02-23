local x, y, z = 0, 0, 5
local aracSatisi = createColSphere(x, y, z, 4)
local aracMarker = createMarker(x, y, getGroundPosition(x, y, z), 'cylinder', 2.0)

araclar = {
    {id=400, fee=40000},
    {id=461, fee=10000}
}


vehicleShop = {
    showing = false, 
    tempVeh = false, 

    _interface = function()
            if isElementWithinColShape(localPlayer, aracSatisi) then 
                vehicleShop.showing = not vehicleShop.showing
                showCursor(vehicleShop.showing)
                if vehicleShop.showing == true then 
                    addEventHandler('onClientGUIClick', getRootElement(), vehicleShop._click)
                    setCameraMatrix(0.067299999296665, 4.1704998016357, 5.399799823761, 0.2817519903183, 5.0843238830566, 5.0549283027649)
                    -- arayuzu olustur
                    setPlayerHudComponentVisible('all', false)
                    arayuz = GuiWindow(1500, (1080 - 600) / 2, 400, 600, 'Los Santos Cop Chase - Vehicle Shop', false)

                    infoLabel = GuiLabel(0, 40, 400, 60, 'Merhaba oyuncu, galeriye hoş geldin!\nAşağıdaki tıkladığın araçlar önünde oluşacaktır, bol şans! \nSatın almak için en alttaki satın al, arayüzü terk etmek için kapatma butonuna tıkla.', false, arayuz)
                    infoLabel:setHorizontalAlign('center', true)

                    -- arac listesi
                    aracListesi = GuiGridList(10, 110, 380, 425, false, arayuz)
                    aracListesi:addColumn('Araç Adı', 0.5) -- araç adı, araç fiyatı
                    aracListesi:addColumn('Araç Fiyatı($)', 0.5) 
                    for i = 1, #araclar do 
                        aracListesi:addRow(getVehicleNameFromModel(araclar[i].id), string.format('%.2f', tostring(araclar[i].fee))) 
                    end 
                    aracListesi:setSelectionMode(1)
                    aracListesi:setSelectedItem(0, 1)
                    vehicleShop.tempVeh = createVehicle(araclar[1].id, 1.7680255174637, 12.21697807312, 3.1171875)
                    vehicleShop.tempVeh:setRotation(0, 0, 175)
                    --table.insert(_G.temporaryVehs, tempVeh)
                    bindKey('arrow_l', 'down', vehicleShop._rotate, 'arrow_l', -5) -- z --
                    bindKey('arrow_r', 'down', vehicleShop._rotate, 'arrow_r', 5) -- z ++

                    -- buttons

                    purchaseButton = GuiButton(10, 540, 175, 50, 'Satın Al', false, arayuz)
                    cancelButton = GuiButton(205, 540, 185, 50, 'Arayüzü Kapat', false, arayuz)
                else 
                    setCameraTarget(localPlayer, localPlayer)
                    arayuz:destroy()
                    setPlayerHudComponentVisible('all', true)
                    removeEventHandler('onClientGUIClick', getRootElement(), _click)
                    destroyElement(vehicleShop.tempVeh)
                end 
            else outputChatBox('Bu işlemi burada gerçekleştiremezsin', 255, 0, 0) end 
    end,

    _click = function()
        if source == aracListesi then
            local row, column = aracListesi:getSelectedItem() -- aynı aracı seçme bugunu fixleyek
            if row > -1 and column > -1 then 
                -- araç değiş
                if (vehicleShop.tempVeh:getModel()) ~= (araclar[row+1].id) then
                    destroyElement(vehicleShop.tempVeh)
                    vehicleShop.tempVeh = createVehicle(araclar[row+1].id, 1.7680255174637, 12.21697807312, 3.1171875)
                    vehicleShop.tempVeh:setRotation(0, 0, 175)
                else outputChatBox('farklı bişi sçe la', 255, 0, 0) end
            else outputChatBox('Bunun için bişi seçmelisin', 255, 0, 0) end 
        elseif source == cancelButton then 
            setCameraTarget(localPlayer, localPlayer)
            arayuz:destroy()
            setPlayerHudComponentVisible('all', true)
            removeEventHandler('onClientGUIClick', getRootElement(), _click)
            showCursor(false)
            vehicleShop.showing = false 
            destroyElement(vehicleShop.tempVeh)
        elseif source == purchaseButton then
            local row, column = aracListesi:getSelectedItem()
            if row > -1 and column > -1 then
                setCameraTarget(localPlayer, localPlayer)
                arayuz:destroy()
                setPlayerHudComponentVisible('all', true)
                removeEventHandler('onClientGUIClick', getRootElement(), _click)
                showCursor(false)
                vehicleShop.showing = false 
                destroyElement(vehicleShop.tempVeh)
                -- aracı satın almak için server'a istek gönder
                triggerServerEvent('purchase:Vehicle', localPlayer, araclar[row+1].id, araclar[row+1].fee)     
            else outputChatBox('Araç seçmedin bro') end
        end 
    end, 

    _rotate = function(bt)
        local tempVeh = vehicleShop.tempVeh
        if bt == 'arrow_l' then e = 5 else e = -5 end
        setTimer(function()
            local rx, ry, rz = getElementRotation(vehicleShop.tempVeh)
            if getKeyState(bt) == true then 
                tempVeh:setRotation(rx, ry, rz + e)
            end
        end, 100, 0)
    end, 

    _index = function(self) 
        addCommandHandler('vehshop', self._interface, false, false)
    end 
}

instance = vehicleShop 
instance:_index()


addCommandHandler('getmatrix', function()
    local m1, m2, m3, m4, m5, m6, m7, m8 = getCameraMatrix()
    outputChatBox(m1 .. ' - ' .. m2 .. ' - ' .. m3 .. ' - ' .. m4 .. ' - ' .. m5 .. ' - ' .. m6 .. ' - ' .. m7 .. ' - ' .. m8)
end)

addCommandHandler('getpos', function()
    local x, y, z = getElementPosition(localPlayer)
    outputChatBox(x .. ' ' .. y .. ' ' .. z)
end)

addCommandHandler('fixed', function() setCameraTarget(localPlayer, localPlayer) end)