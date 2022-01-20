local dbConn 
addEventHandler('onResourceStart', resourceRoot, function()
    dbConn = dbConnect('sqlite', ':/global.db')
end)
getConn = function() return dbConn end