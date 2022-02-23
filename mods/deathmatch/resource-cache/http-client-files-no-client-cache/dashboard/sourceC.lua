
tabs = {
    {tabName = 'Sunucu Hakkında', tabContent = 'Anan Yani Sen'},
    {tabName = 'Güncellemeler', tabContent = 'Anan Yani Sen'},
    {tabName = 'LV Puanları', tabContent = 'Anan Yani Sen'},
    {tabName = 'Bugünkü En İyiler', tabContent = 'Anan Yani Sen'},
    {tabName = 'Oyuncular', tabContent = 'Anan Yani Sen'},
    {tabName = 'Polis', tabContent = 'Anan Yani Sen'},
    {tabName = 'Suçlu', tabContent = 'Anan Yani Sen'},
    {tabName = 'Sivil', tabContent = 'Anan Yani Sen'},
    {tabName = 'PvP Rütbeleri', tabContent = 'Anan Yani Sen'},
    {tabName = 'Mevsimler', tabContent = 'Anan Yani Sen'},
}

dashBoard = {
    isShowing = false, 

    _panel = function()
        dashBoard.isShowing = not dashBoard.isShowing 
        showCursor(dashBoard.isShowing)
        if dashBoard.isShowing == true then 
            outputChatBox('Arayuz panelini açtınız!', 0, 255, 0)
            arayuz = GuiWindow((1920 - 800) / 2, (1080 - 550) / 2, 800, 550, 'Los Santos Cop Chase | Dashboard', false)
            arayuz:setSizable(false)
            tabPanel = GuiTabPanel(5, 30, 785, 510, false, arayuz)
            triggerServerEvent('get:Updates', localPlayer, localPlayer)
            for i = 1, #tabs do 
                outputChatBox(root:getData('updates:Async'))
                local myTab = GuiTab(tabs[i].tabName, tabPanel)
                local myMemo = guiCreateMemo(5, 5, 770, 475, tabs[i].tabContent, false, myTab)
                myMemo:setReadOnly(true)
            end 

        else 
            arayuz:destroy()
        end 
    end,

    _index = function(self)
        bindKey('F1', 'down', dashBoard._panel)
    end 
}

addEvent('update:Insert', true)
addEventHandler('update:Insert', root, function(updatedGuy)
    for i = 1, #tabs do 
        if tabs[i].tabName == 'Güncellemeler' then 
            table.remove(tabs, i)
            table.insert(tabs, i, {tabName='Güncellemeler', tabContent=updatedGuy})
        end 
    end 
    --guiSetText(memoWillBeUpdated, updatedGuy)
end)

instance = dashBoard
instance:_index()