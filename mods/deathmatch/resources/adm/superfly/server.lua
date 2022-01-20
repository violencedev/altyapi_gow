function flyOnline(thePlayer)
    triggerClientEvent(thePlayer,"flyOnlineEt",thePlayer)
end
addCommandHandler("fly",flyOnline)