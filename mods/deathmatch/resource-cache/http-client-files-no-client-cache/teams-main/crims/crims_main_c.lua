shopperSkins = {[100] = {robbing=false}}

local isRobbing = false 

addEventHandler('onClientPlayerTarget', getRootElement(), function(targetElement) 
    if not targetElement then return end
    if (getPedTask(source, "secondary", 0) == "TASK_SIMPLE_USE_GUN") and (getElementType(targetElement) == 'ped') and (shopperSkins[getElementModel(targetElement)]) then 
        -- the player is aiming right now, we have to launch a robbery.
        if isRobbing == false and (getElementData(targetElement, 'beingRobbed') or false) == false then 
            setElementData(targetElement, 'beingRobbed', true)
            setElementData(source, 'howManyTimesDidIRobThere')
            outputChatBox('You started a shop robbery')
            setPedAnimation(targetElement, 'ped', 'handsup', -1, false, true)
            isRobbing = true 
            shopperSkins[getElementModel(targetElement)].robbing = true 
            --print(shopperSkins[getElementModel(targetElement)].robbing)
        else
            outputChatBox('This shop is already being robbed.')
        end 
    end 
end) -- 