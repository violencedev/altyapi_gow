-- utils

function getVehicleFromPlateText(plateText)
    for _,j in pairs(getElementsByType('vehicle')) do 
        if j:getPlateText() == plateText then 
            return j 
        end     
    end 
end 

-- utils 


aracPaneli = {
    isShowing = false,

    _panel = function()
        aracPaneli.isShowing = not aracPaneli.isShowing 
        showCursor(aracPaneli.isShowing)
        if aracPaneli.isShowing == true then 
            addEventHandler('onClientGUIClick', getRootElement(), aracPaneli._click)
            panel = GuiWindow((1920 - 550) / 2, (1080 - 400) / 2, 550, 400, 'Los Santos Cop Chase - Vehicle Panel', false)

            infoLabel = GuiLabel(10, 25, 530, 30, 'Çıkarmak istediğiniz aracı aşağıdan seçip, çıkar butonuna tıklayın veya araçların hepsini çıkarma butonuna tıklayın. Eğer arayüzü kapatmak istiyorsanız, arayüzü kapat butonuna tıklayın.', false, panel)
            infoLabel:setHorizontalAlign('center', true)

            aracListesi = GuiGridList(10, 70, 530, 265, false, panel)
            aracListesi:addColumn('Model ID', 0.23) -- model id, arac konumu, arac aktif durumu, aracplakası
            aracListesi:addColumn('Konum', 0.23)
            aracListesi:addColumn('Plaka', 0.23)
            aracListesi:addColumn('Aktiflik Durum', 0.31)

            for k,j in pairs(getElementsByType('vehicle')) do 
                if j:getData('aktif') == false then aktiflikDurumu = 'Aktif Değil' elseif j:getData('aktif') == true then aktiflikDurumu = 'Aktif' else aktiflikDurumu = 'Aktif Değil' end 
                aracListesi:addRow(getElementModel(j), getZoneName(getElementPosition(j)), getVehiclePlateText(j), aktiflikDurumu)
                if aktiflikDurumu == 'Aktif' then guiGridListSetItemColor(aracListesi, k - 1, 4, 0, 255, 0) else guiGridListSetItemColor(aracListesi, k - 1, 4, 255, 0, 0) end 
            end 

            aracGetir = GuiButton(10, 345, 245, 120, 'Aracın Aktifliğini Değiş', false, panel)
            arayuzKapat = GuiButton(295, 345, 245, 120, 'Arayüzü Kapat', false, panel)
        else 
            panel:destroy()
            removeEventHandler('onClientGUIClick', getRootElement(), aracPaneli._click)
        end 
    end,

    _click = function()
        if source == arayuzKapat then 
            showCursor(false)
            aracPaneli.isShowing = false 
            panel:destroy()
            removeEventHandler('onClientGUIClick', getRootElement(), aracPaneli._click)
        elseif source == aracGetir then 
            local row, col = guiGridListGetSelectedItem(aracListesi)
            if row > -1 and col > -1 then 
                -- araç seçildi
                local vehObject = getVehicleFromPlateText(guiGridListGetItemText(aracListesi, row, 3)) 
                if not vehObject then return end 
                local aktiflikDurumu = vehObject:getData('aktif') or false 
                if aktiflikDurumu == false then 
                    -- araç spawnla
                    local x, y, z = getElementPosition(localPlayer)
                    x = x + 3
                    setElementDimension(vehObject, getElementDimension(localPlayer))
                    setElementPosition(vehObject, x, y, z)
                    outputChatBox('Başarıyla araç getirildi', 0 ,255, 0)
                    guiGridListSetItemText(aracListesi, row, 4, 'Aktif', false, false)
                    guiGridListSetItemColor(aracListesi, row, 4, 0, 255, 0)
                else 
                    -- aracı yok et
                    setElementDimension(vehObject, 3169)
                    outputChatBox('Araç başarıyla götürüldü', 255, 0, 0)
                    guiGridListSetItemText(aracListesi, row, 4, 'Aktif Değil', false, false)
                    guiGridListSetItemColor(aracListesi, row, 4, 255, 0, 0)
                end 
                setElementData(vehObject, 'aktif', not getElementData(vehObject, 'aktif'))
            else
                outputChatBox('Bu işlem için bir araç seçmelisiniz.', 255, 0, 0)
            end 
        end 
    end, 

    _index = function(self)
        bindKey('F5', 'down', self._panel)
    end 
}

instance = aracPaneli 
instance:_index()