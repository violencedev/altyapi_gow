function chatiTemizle()
    for i = 1, 100, 1 do
        outputChatBox("")
    end
	for k in pairs (oocMessages) do
		oocMessages[k] = nil
	end
end
addCommandHandler("clearchat",chatiTemizle)
addCommandHandler("ccmy",chatiTemizle)