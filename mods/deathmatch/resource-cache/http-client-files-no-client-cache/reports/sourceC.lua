reportPanel = {
    isShowing = false,

    _panel = function()
        reportPanel.isShowing = not isCursorShowing()
        showCursor(reportPanel.isShowing)
        if reportPanel.isShowing == true then 
            addEventHandler('onClientGUIClick', getRootElement(), reportPanel._click)
            arayuz = GuiWindow((1920 - 500) / 2, (1080 - 165) / 2, 500, 165, 'Los Santos Cop Chase | Report Panel', false)
            arayuz:setSizable(false)
            infoLabel = GuiLabel(0, 35, 500, 45, 'Merhaba oyuncu, eğer desteğe ihtiyacın olursa, aşağıdaki beyaz kutucuğa sorunu ya da sorununu yazabilirsin. Destek talepleri discord üzerinden iletilmektedir.', false, arayuz)
            infoLabel:setHorizontalAlign('center', true)
            editBox = GuiEdit(10, 70, 490, 40, '', false, arayuz)

            sendButton = GuiButton(10, 115, 220, 40, 'Destek Talebini Gönder', false, arayuz)
            closeButton = GuiButton(270, 115, 220, 40, 'Arayüzü Kapat', false, arayuz)
            guiSetInputMode('NO_BINDS_WHEN_EDITING')
        else     
            arayuz:destroy()
            removeEventHandler('onClientGUIClick', getRootElement(), reportPanel._click)
        end 
    end,

    _click = function()
        if source == closeButton then 
            arayuz:destroy()
            showCursor(false)
            reportPanel.isShowing = false
            removeEventHandler('onClientGUIClick', getRootElement(), reportPanel._click)
        elseif source == sendButton then 
            if #(split(editBox:getText(), ' ')) >= 4 then 
                table.insert(activeReports, {gonderen = localPlayer:getName(), content = editBox:getText()});
                exports["discord-webhook"]:callServer(localPlayer:getName(), #activeReports, editBox:getText());
                outputChatBox('Raporunuz başarıyla yetkili ekibine discord platformu üzerinden iletildi.', 0, 255, 0)
            else 
                outputChatBox('En az dört kelimelik rapor içeriği olmalıdır.', 255, 0, 0)
            end 
        end 
    end,

    _index = function(self)
        bindKey('F2', 'down', self._panel)
    end 
}

instance = reportPanel 
instance:_index()