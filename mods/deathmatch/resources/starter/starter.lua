addEventHandler('onResourceStart', resourceRoot, function()
    outputDebugString('gowmta: sistemler calistiriliyor...')
    index = 0
    for _,v in pairs(getResources()) do 
        startResource(v)
        outputDebugString('gowmta: ' .. getResourceName(v) .. ' isimli sistem calistirildi!')
        index = index + 1
    end 
    outputDebugString('gowmta: sistemlerin calistirilmasi bitti [toplam calistirilan : ' .. index .. ']')
end)