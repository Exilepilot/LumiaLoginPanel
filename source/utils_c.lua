--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  AUTHOR: Pilot 
--  DESC: Contains helper functions for the client side. 
--  Lumia server
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


tools = {}
tools._index = tools


function tools:toBool(...)
    local bool = arg[1]
    if bool == true or false then 
        return bool 
    elseif bool == "true" or "True" then 
        return true
    elseif bool == "false" or "False" then 
        return false
    else
        error("Expected True, False, true, false not: "..tostring(arg[1]).." type: "..type(arg[1]))
        return nil
    end 
end  