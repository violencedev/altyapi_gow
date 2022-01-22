local ids = { }

function playerJoin()
	local slot = nil
	
	for i = 1, 5000 do
		if (ids[i]==nil) then
			slot = i
			break
		end
	end
	
	ids[slot] = source
	setElementData(source, "id", slot)
end
addEventHandler("onPlayerJoin", getRootElement(), playerJoin)

function playerQuit()
	local slot = getElementData(source, "id")
	if (slot) then
		ids[slot] = nil
	end
end
addEventHandler("onPlayerQuit", getRootElement(), playerQuit)

function resourceStart()
	local players = getElementsByType "player"
	for key, value in ipairs(players) do
		ids[key] = value
		setElementData(value, "id", key)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), resourceStart)

