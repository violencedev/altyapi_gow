primary_Resources = {'mysql'} -- öncellikli olarak başlatılacak sistemler

function startAll()
    local current_Resource = getResourceName(getThisResource())
    local remained_Resources = getResources()
    local errors = 0
    table.remove(remained_Resources, findIndex(remained_Resources, current_Resource)) -- şu anki sistemi yeniden başlatmaya çalışırsak hata alırız, o yüzden
    for key, value in pairs(primary_Resources) do 
        local res = getResourceFromName(value)
        table.remove(remained_Resources, findIndex(remained_Resources, value))
        if startResource(res) == true then 
            outputDebugString(current_Resource ..' primary: basariyla ' .. value .. ' isimli sistem baslatildi!')
        else 
            errors = errors + 1
        end 
    end 


    -- primary olanları bunun içinden temizleyelim
    for key, value in pairs(remained_Resources) do 
        local resName = getResourceName(value) 
        if startResource(value) == true then 
            outputDebugString(current_Resource ..' default: basariyla ' .. resName .. ' isimli sistem baslatildi!')
        else 
            errors = errors + 1
        end 
    end     
    
    local sistemSayisi = #(getResources())
    local baslatilanlar = sistemSayisi - errors 

    local oran = (baslatilanlar * 100) / sistemSayisi

    --[[
        %100 = 10 sistem
        %x = 4 sistem
        4 * 100 / 10
    ]]

    outputDebugString(current_Resource .. ': basariyla sistem baslatma islemi bitirildi!')
    outputDebugString(current_Resource .. ': yeniden baslatilamayan sistem sayisi : ' .. errors)
    outputDebugString(current_Resource .. ': hatasiz baslatma orani : [%' .. oran .. ']')
end 
addEventHandler('onResourceStart', resourceRoot, startAll)

-- some utils 

function findIndex(tablo, targetvalue)
    for key, value in pairs(tablo) do 
        if targetvalue == value then return key end 
    end 
end 