--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  AUTHOR: Pilot 
--  DESC: The client side of the script 'Welcome'. 
--  Lumia server
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


------------------------------------------------------------------
--  GUI declaration/initialization
------------------------------------------------------------------

gui = {
    button = {},
    window = {},
    edit = {},
    label = {},
    welcome_message = "Welcome to the server, please login or register.",
    register_message = "Please register with an appropriate username.",
}

gui._index = gui

gui.window[1] = guiCreateWindow(0.34, 0.33, 0.33, 0.34, "Welcome to the server", true)
guiWindowSetMovable(gui.window[1], false)
guiWindowSetSizable(gui.window[1], false)
guiSetAlpha(gui.window[1], 0.96)

gui.label[1] = guiCreateLabel(0.03, 0.09, 0.92, 0.12, gui.welcome_message, true, gui.window[1])
guiSetFont(gui.label[1], "default-bold-small")
guiLabelSetColor(gui.label[1], 18, 246, 7)
guiLabelSetHorizontalAlign(gui.label[1], "center", false)
guiLabelSetVerticalAlign(gui.label[1], "center")
gui.edit[1] = guiCreateEdit(0.38, 0.36, 0.56, 0.10, "", true, gui.window[1])
gui.edit[2] = guiCreateEdit(0.38, 0.49, 0.56, 0.10, "", true, gui.window[1])
guiSetProperty(gui.edit[2], "MaskText", "True")
gui.edit[3] = guiCreateEdit(0.38, 0.63, 0.56, 0.10, "", true, gui.window[1])
guiSetProperty(gui.edit[3], "MaskText", "True")
gui.label[2] = guiCreateLabel(0.04, 0.38, 0.32, 0.08, "Username ", true, gui.window[1])
guiSetFont(gui.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(gui.label[2], "center", false)
gui.label[3] = guiCreateLabel(0.04, 0.51, 0.32, 0.08, "Password", true, gui.window[1])
guiSetFont(gui.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(gui.label[3], "center", false)
gui.label[4] = guiCreateLabel(0.04, 0.65, 0.32, 0.08, "Repeat password", true, gui.window[1])
guiSetFont(gui.label[4], "default-bold-small")
guiLabelSetHorizontalAlign(gui.label[4], "center", false)
gui.button[1] = guiCreateButton(0.04, 0.85, 0.29, 0.11, "Guest", true, gui.window[1])
guiSetProperty(gui.button[1], "NormalTextColour", "FFAAAAAA")
gui.button[2] = guiCreateButton(0.36, 0.85, 0.29, 0.11, "Login", true, gui.window[1])
guiSetProperty(gui.button[2], "NormalTextColour", "FFAAAAAA")
gui.button[3] = guiCreateButton(0.67, 0.85, 0.29, 0.11, "Register", true, gui.window[1])
guiSetProperty(gui.button[3], "NormalTextColour", "FFAAAAAA")
guiSetVisible(gui.window[1], false)
guiSetVisible(gui.edit[3], false)   -- Register editbox
guiSetVisible(gui.label[4], false )

function gui:note(msg)
    local mode = guiGetVisible(self.edit[3])
    local message = nil
    if mode then 
        message = self.register_message
    else
        message = self.welcome_message
    end
    if type(msg) == "string" then 
        guiSetText(self.label[1], msg)
        setTimer(
        function() 
            guiSetText(self.label[1],message)
        end, 3000, 1)
        outputDebugString("Successful note: "..msg)
    end 
end
 
addEvent("gui:note",true)
addEventHandler("gui:note",getRootElement(),
function(msg)
    gui:note(msg)    
end)

-- Set gui panel visible or invisible. 
-- Depending on argument given. 
function gui:setVisible(bool)
    local visible = guiGetVisible(self.window[1])
    if type(bool) == "boolean" then 
        if not visible == bool then
            if bool == true then 
                guiSetInputMode("no_binds")
            else
                guiSetInputMode("allow_binds")
            end  
            local result = guiSetVisible(self.window[1], bool)
            showCursor(bool)
            return result
        else
            outputDebugString("Window's visibility is: "..tostring(visible).." and the requested visibility is: "..tostring(bool))
            return false
        end
    else
        outputDebugString("Expected boolean got "..type(bool))
        return false
    end 
end 

function gui:toggle( )
    if guiGetVisible(self.window[1]) then 
        guiSetVisible(self.window[1], false)
        showCursor(false)
        guiSetInputMode("allow_binds")
    else
        guiSetVisible(self.window[1], true)
        showCursor(true)
        guiSetInputMode("no_binds")
    end
end

addEvent("gui:setVisible", true)
addEventHandler("gui:setVisible", getRootElement(), 
function (bool) 
    gui:setVisible(bool)
end)

-- Set panel in registering mode 
function gui:setRegisterMode()
    local mode = guiGetVisible(self.edit[3])
    local visible = guiGetVisible(self.window[1])
    if visible then 
        if not mode then 
            for i = 1, 3 do 
                guiSetText(self.edit[i], "")
                outputDebugString("Cleared edit box "..i)
            end 
            setTimer(
            function()
                guiSetText(self.label[1], self.register_message)    -- Set to register message
                guiSetVisible(self.edit[3], true)
                guiSetVisible(self.label[4], true )
                guiSetProperty(self.button[3], 'Disabled', 'True')
                guiSetText(self.button[2], "Create account")
                guiSetText(self.button[1], "Back")  -- Use guest button as a back
            end, 500, 1)
            return true 
        end 
    else
        outputDebugString("Error: Register button was pressed without gui window being opened.")
        return 
    end 
end

addEventHandler("onClientGUIClick", gui.button[3],
function()
    gui:setRegisterMode()
end,false)

-- We use this function for setting
-- a guest mode and going back to login mode. 

function gui:guestMode()
    local mode = guiGetVisible(self.edit[3])
    local visible = guiGetVisible(self.window[1])
    if visible then 
        if not mode then 
            -- TODO
        else
            for i = 1, 3 do
                guiSetText(self.edit[i], "")
                outputDebugString("Cleared edit box "..i)
            end 
            setTimer(
            function ()
                guiSetVisible(self.edit[3], false)
                guiSetVisible(self.label[4], false)
                guiSetProperty(self.button[3], 'Disabled', 'False')
                guiSetText(self.button[2], "Login")
                guiSetText(self.button[1], "Guest")  -- Use guest button as a back
                guiSetText(self.label[1], self.welcome_message)    
            end,500,1)
            return true 
        end 
    else
        outputDebugString("Guest button was pressed without gui window being opened.")
        return 
    end
end
addEventHandler("onClientGUIClick", gui.button[1],
function ( ... )
    gui:guestMode()
end,false)

-- Reset the panel back to how it was when previously opened. 
function gui:resetMode()
    local mode = guiGetVisible(self.edit[3])
    if guiGetVisible(self.window[1]) then 
        if mode then
            guiSetVisible(self.edit[3], false)
            guiSetVisible(self.label[4], false)
            guiSetProperty(self.button[3], 'Disabled', 'False')
            guiSetText(self.button[2], "Login")
            guiSetText(self.button[1], "Guest")  -- Use guest button as a back
            guiSetText(self.label[1], self.welcome_message)     
            outputDebugString("Reset mode")
        end 
    end 
end
addEvent("gui:resetMode",true)
addEventHandler("gui:resetMode",getRootElement(), 
function( )
    gui:resetMode()
end)

-- Function used for two things, logging in and
-- creating an account if client is in register mode.

function gui:Login()
    local visible = guiGetVisible(self.window[1])
    local mode = guiGetVisible(self.edit[3])
    if visible then 
        if not mode then 
            local username = guiGetText(self.edit[1])
            local password = guiGetText(self.edit[2])
            local repeat_password = guiGetText(self.edit[3])
            triggerServerEvent("server:login", getLocalPlayer(), username, password)
        else
            -- Creating an account 
            local username = guiGetText(self.edit[1])
            local password = guiGetText(self.edit[2])
            local rep = guiGetText(self.edit[3])
            if #username >= 3 then 
                if #password >= 6 then 
                    if rep == password then 
                        triggerServerEvent("server:createAccount", getLocalPlayer(), username, password)
                    else
                        gui:note("Please make sure both passwords are the same.")
                    end
                    return true 
                else
                    self:note("Your password needs to be six characters or more")
                    return
                end
            else
                self:note("Your username needs to be 3 characters or more.")
                return 
            end 
        end
    else
        outputDebugString("Login button was pressed without gui window being opened")
        return 
    end 
end

addEventHandler("onClientGUIClick", gui.button[2],
function ( ... )
    gui:Login()
end,false)

bindKey("F4", "down", 
function()
    gui:toggle()
    gui:resetMode()
end)

-- addEventHandler("onClientRender", root,
--     function()
--         dxDrawRectangle(0, 736, 1366, 32, tocolor(0, 0, 0, 160), false)
--         dxDrawText("Click for more info about this server", 554, 741, 819, 763, tocolor(245, 21, 21, 251), 1.00, "default-bold", "center", "center", false, false, true, false, false)
--     end
-- )
