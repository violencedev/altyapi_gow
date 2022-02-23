--[[addEventHandler('onClientPlayerJoin', root, function()
    outputChatBox('sa')
    local _, _, geciciData = getCameraMatrix()
    print(geciciData)
    setElementData(localPlayer, 'gecici:Data', geciciData)
end)--]]


addEvent('redirect:Client', true)
addEventHandler('redirect:Client', getRootElement(), function(serverUpdates, rememberedUname, rememberedPass)
    showChat(false)
    local x, y, z = getElementPosition(localPlayer)
    _G.geciciData = z + 2
    sikkoPanel = guiCreateWindow(603, 283, 636, 633, "LSCS : Los Santos Cop Chase", false)
    guiWindowSetSizable(sikkoPanel, false)

    sikkoYazi1 = guiCreateLabel(54, 58, 87, 18, "Hesap adı:", false, sikkoPanel)
    sikkoYazinin_SikkoEditBoxu = guiCreateEdit(145, 45, 207, 41, "", false, sikkoPanel)
    sikkoPanelin_SikkoCheckBoxu = guiCreateCheckBox(377, 47, 210, 39, "Kullanıcı adını hatırla", false, false, sikkoPanel)
    sikkoYazi2 = guiCreateLabel(54, 120, 87, 18, "Şifre:", false, sikkoPanel)
    sikkoYazinin_SikkoEditBoxu2 = guiCreateEdit(145, 107, 207, 41, "", false, sikkoPanel)
    guiEditSetMasked(sikkoYazinin_SikkoEditBoxu2, true)
    sikkoPanelin_SikkoCheckBoxu2 = guiCreateCheckBox(377, 109, 210, 39, "Şifreyi hatırla", false, false, sikkoPanel)
    signIn = guiCreateButton(21, 180, 138, 45, "Giriş", false, sikkoPanel)
    signUp = guiCreateButton(169, 180, 138, 45, "Hesap Aç", false, sikkoPanel)
    forgatPass = guiCreateButton(317, 180, 138, 45, "Şifreni mi unuttun?", false, sikkoPanel)
    Magazine = guiCreateButton(465, 180, 138, 45, "LSCS Dergisi\nYeni Sayı!", false, sikkoPanel)
    guiSetProperty(Magazine, "NormalTextColour", "FFDE8889")
    welcomeText = guiCreateLabel(0, 255, 636, 40, "Welcome to LSCS! Play fair, be nice, have fun!", false, sikkoPanel)
    guiLabelSetColor(welcomeText, 19, 159, 233)
    guiLabelSetHorizontalAlign(welcomeText, "center", false)
    tabPanel = guiCreateTabPanel(10, 295, 616, 318, false, sikkoPanel)
    updates = guiCreateTab("Güncellemeler", tabPanel)
    updatesMemo = guiCreateMemo(6, 6, 604, 278.5, serverUpdates or "Şu sıralarda pek güncelleme yok...", false, updates)
    guiSetAlpha(sikkoPanel, 0)
    guiMemoSetReadOnly(updatesMemo, true)

    _G.tick = getTickCount();
    _G.delay = 5500;
    if rememberedUname:len() >= 2 then 
        guiCheckBoxSetSelected(sikkoPanelin_SikkoCheckBoxu, true)
        guiSetText(sikkoYazinin_SikkoEditBoxu, rememberedUname)
    end 
    if rememberedPass:len() >= 2 then 
        guiCheckBoxSetSelected(sikkoPanelin_SikkoCheckBoxu2, true)
        guiSetText(sikkoYazinin_SikkoEditBoxu2, rememberedPass)
    end
    addEventHandler('onClientRender', root, logInCameraMovement)
    setTimer(function()
        _G.tick = getTickCount()
        _G.delay = 1000 
        addEventHandler('onClientRender', root, function()
            local progress = ((getTickCount() - tick) / delay)
            local alpha = interpolateBetween(0, 0, 0, 0.8, 0, 0, progress, 'InQuad')
            guiSetAlpha(sikkoPanel, alpha)
        end)
        guiSetVisible(sikkoPanel, true)
        showCursor(true);
        addEventHandler('onClientGUIClick', signIn, logInToServer)
        addEventHandler('onClientGUIClick', signUp, signUpToServer)
        removeEventHandler('onClientRender', root, logInCameraMovement)
    end, 5500, 1)
end)


addEvent('spawn:Player:With:Interpolation', true)
addEventHandler('spawn:Player:With:Interpolation', root, function(x, y, z, geciciData)
    _G.targetX, _G.targetY, _G.targetZ = getElementPosition(localPlayer)
    _G.cx, _G.cy, _G.cz, _G.cx2, _G.cy2, _G.cz2 = getCameraMatrix()
    _G.tick = getTickCount()
    _G.delay = 1000 
    _G.groundPos = getGroundPosition(targetX, targetY, targetZ)
    guiSetVisible(sikkoPanel, false)
    addEventHandler('onClientRender', root, cameraUp)
    setTimer(function()
        removeEventHandler('onClientRender', root, cameraUp)
        _G.tick = getTickCount()
        _G.delay = 4500 
        addEventHandler('onClientRender', root, cameraMoveLoc)
        setTimer(function()
            _G.delay = 500
            _G.tick = getTickCount()
            addEventHandler('onClientRender', root, cameraPreDown)
            removeEventHandler('onClientRender', root, cameraMoveLoc)
            setTimer(function()
                _G.delay = 800
                _G.tick = getTickCount()
                addEventHandler('onClientRender', root, cameraDown)
                removeEventHandler('onClientRender', root, cameraPreDown)
                setTimer(function()
                    removeEventHandler('onClientRender', root, cameraDown)
                    triggerServerEvent('spawn:Player:Again:And:Again', localPlayer)
                    showCursor(false)
                    showChat(true)
                end, 800, 1)
            end, 500, 1)
        end, 4500, 1)   
    end, 1000, 1)

end)

logInToServer = function()
    local usernameBox = guiGetText(sikkoYazinin_SikkoEditBoxu)
    local password = guiGetText(sikkoYazinin_SikkoEditBoxu2)
    if (usernameBox:len() >= 3) and (password:len() >= 3) then 
        local usernameRemember, passRemember = guiCheckBoxGetSelected(sikkoPanelin_SikkoCheckBoxu), guiCheckBoxGetSelected(sikkoPanelin_SikkoCheckBoxu2)
        triggerServerEvent('signIn:Attempt', localPlayer, usernameBox, password, usernameRemember, passRemember)
    end 
end 

signUpToServer = function()
    local usernameBox = guiGetText(sikkoYazinin_SikkoEditBoxu)
    local password = guiGetText(sikkoYazinin_SikkoEditBoxu2)
    if (usernameBox:len() >= 3) and (password:len() >= 3) then 
        local usernameRemember, passRemember = guiCheckBoxGetSelected(sikkoPanelin_SikkoCheckBoxu), guiCheckBoxGetSelected(sikkoPanelin_SikkoCheckBoxu2)
        triggerServerEvent('signUp:Attempt', localPlayer, usernameBox, password, usernameRemember, passRemember)
    end 
end 

function cameraUp()
    local progress = ((getTickCount() - tick) / delay)
    local cmX, cmY, cmZ = interpolateBetween(414.96923828125, -242.90187072754, 39.036483764648, 0, 0, 0, progress, 'OutQuad')
    local _, _, myZ = interpolateBetween(0, 0, 39.284999847412, 0, 0, groundPos + 30, progress, 'OutQuad')
    setCameraMatrix(cx, cy, myZ, cmX, cmY, cmZ, _, _)
end 

function logInCameraMovement()
    local progress = (getTickCount() - tick) / delay;
    local myX, myY, myZ = interpolateBetween(0, 0, 20, 414.01620483398, -242.72880554199, 39.284999847412, progress, 'InQuad')
    local myCamX, myCamY, myCamZ = interpolateBetween(0, 0, 20, 414.96923828125, -242.90187072754, 39.036483764648, progress, 'InQuad')
    local camera, _, _ = interpolateBetween(0, 0, 0, 360, 0.80, 0, progress, 'InQuad') -- enes abime özel, açık kodlar net kodlar!
    setCameraMatrix(myX, myY, myZ, myCamX, myCamY, myCamZ, camera)
end 

function cameraMoveLoc()
    local progress = ((getTickCount() - tick) / delay)
    local myX, myY, myZ = interpolateBetween(414.01620483398, -242.72880554199, groundPos + 30, targetX, targetY, groundPos + 30, progress, 'InQuad')
    setCameraMatrix(myX, myY, myZ)
end 

function cameraPreDown()
    fadeCamera(true, 1.3)
    local progress = ((getTickCount() - tick) / delay)
    local myCamX = interpolateBetween(0, 0, 0, geciciData - 1, 0, 0, progress, 'InQuad')
    setCameraMatrix(targetX, targetY, groundPos + 30, 0, 0, myCamX)
end 

function cameraDown()
    local progress = ((getTickCount() - tick) / delay)
    local myZ = interpolateBetween(groundPos + 30, 0, 0, groundPos + 2, 0, 0, progress, 'OutQuad')
    setCameraMatrix(targetX, targetY, myZ, 0, 0, geciciData - 1)   
end 
