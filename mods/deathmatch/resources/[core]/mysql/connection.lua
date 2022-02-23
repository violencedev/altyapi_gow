local conn 

local credentials = {
    ["username"] = 'root',
    ["database"] = 'dbname',
    ["host"] = 'localhost',
    ["charset"] = 'utf8',
    ['password'] = 'sifre'
}

-- bağlanma eventi 

addEventHandler('onResourceStart', resourceRoot, function()
    conn = dbConnect('mysql', "dbname=" .. credentials['database'] .. ';host='.. credentials['host'] .. ';charset=' .. credentials['charset'], credentials['username'], credentials['password'])
    local current_Resource = getResourceName(getThisResource())
    if conn then 
        outputDebugString(current_Resource .. ': basariyla ' .. credentials['database'] .. ' veritabanina baglanildi!')
    else 
        outputDebugString(current_Resource .. ': ' .. credentials['database'] .. ' veritabanina baglanilirken bir sorun cikti.')
    end 
end)

function getConn() return conn or false end 
