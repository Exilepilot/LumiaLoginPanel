--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  AUTHOR: Pilot 
--  DESC: Contains the server side of the script. 
--  Lumia server
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

server = {}
server._index = server



function server:onJoin(thePlayer)
    if isElement(thePlayer) then 
        local playerName = getPlayerName(thePlayer)
        outputChatBox("#ff0000[Lumia]#ffffff Welcome "..playerName:gsub("#%x%x%x%x%x%x", "").." !", thePlayer,0,0,0,true)
        -- fadeCamera ( player thePlayer, bool fadeIn, [ float timeToFade = 1.0, int red = 0, int green = 0, int blue = 0 ] )
        spawnPlayer(thePlayer, 2500.28515625, -1677.55078125, 13.362229347229)
        setCameraMatrix(thePlayer, 1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
        fadeCamera(thePlayer, true, 3.0)
        triggerClientEvent("gui:setVisible", thePlayer, true) -- Set panel visible
    end 
end
addEventHandler("onPlayerJoin", getRootElement(), 
function ( ... )
    server:onJoin(source)
end)

function server:createAccount(thePlayer, username, password)
    if isElement(thePlayer) then 
        if isGuestAccount(getPlayerAccount(thePlayer)) then 
            local account = addAccount(username, password)
            if not account == false or nil  then 
                triggerClientEvent("gui:note", thePlayer, "Account created.")
                outputDebugString("Created account username: "..username.." and password: "..password)
            end 
        else
            triggerClientEvent("gui:note", thePlayer, "You're already logged in.")
        end 
    else
        outputDebugString("Expected player element got "..type(thePlayer))
    end 
end
addEvent("server:createAccount", true)
addEventHandler("server:createAccount", getRootElement(), 
function ( username, password )
    server:createAccount(source, username, password)
end)

function server:login(thePlayer, username, password)
    if isElement(thePlayer) then 
        local account = getAccount(username)
        if not account == false or nil then 
            local login = logIn(thePlayer, account, password)
            if login then 
                outputDebugString("Logged in player: "..getPlayerName(thePlayer))
                triggerClientEvent("gui:note", thePlayer, "Successfully logged in!")
                setTimer(
                function()
                    triggerClientEvent("gui:resetMode", thePlayer)
                    triggerClientEvent("gui:setVisible", thePlayer, false)
                    setCameraTarget(thePlayer)
                end,500,1)
            else
                triggerClientEvent("gui:note",thePlayer, "Incorrect password and/or username")
                return 
            end 
        else
            triggerClientEvent("gui:note", thePlayer, "That account doesn't exist!")
            return 
        end 
    else
        outputDebugString("Expected player element got "..type(thePlayer))
    end 
end
addEvent("server:login", true)
addEventHandler("server:login", getRootElement(), 
function ( username, password )
    server:login(source, username, password)
end)