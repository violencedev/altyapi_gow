reportPanel = {
    isShowing = false, 

    _panel = function() 
        reportPanel.isShowing = not isCursorShowing()
        showCursor(reportPanel.isShowing)
        if reportPanel.isShowing == true then 
            addEventHandler('onClientGUIClick', getRootElement(), reportPanel._click)
            arayuz = GuiWindow((1920 - 500) / 2, (1080 - 185) / 2, 500, 185, 'Los Santos Cop Chase - Destek Paneli', false)
            arayuz:setSizable(false)
            arayuz:setMovable(true)
            infoLabel = GuiLabel(0, 35, 500, 45, 'Merhaba oyuncu, eğer desteğe ihtiyacın varsa, aşağıdaki beyaz kutucuğa sorunu ya da sorununu yazıp bize destek talebi gönderebilirsin! Destek talepleri hem oyundan hem discorddan bakılabilmektedir.', false, arayuz)
            infoLabel:setHorizontalAlign('center', true)
            editBox = GuiEdit(10, 85, 490, 40, '', false, arayuz)
            sendButton = GuiButton(10, 135, 220, 40, 'Destek Talebini Gönder', false, arayuz)
            closeButton = GuiButton(270, 135, 220, 40, 'Arayüzü Kapat', false, arayuz)
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
                table.insert(activeReports, {gonderen=localPlayer:getName(), msg=editBox:getText()});
                local id = #activeReports
                exports["discord-webhook"]:callServer(localPlayer:getName(), id, editBox:getText())
            else 
                outputChatBox('Raporunuz en az dört kelime olmalıdır.', 255, 0, 0)
            end 
        end 
    end,

    _index = function(self)
        bindKey('F2', 'down', self._panel)
    end,
}

instance = reportPanel
instance:_index()