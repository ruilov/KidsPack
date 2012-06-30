-- Textbox.lua

-- for receiving input from keyboard

Textbox = class(Button)

function Textbox:init(x,y,w)
    Button.init(self,x,y,w,0) -- we don't know the height yet
    
    self.text = ""

    -- in font properties you can set fill,font,fontSize
    self.fontProperties = {font="Futura-CondensedExtraBold",fill=color(255,255,255)}   
    self.cursorColor = color(206,206,206,255)
    self.cursorWidth = 2
    self.cursorMarginY = 4
    self.align = "CENTER" -- can also be "LEFT"
    self.protected = false -- for passwords
    self.background = color(255,255,255,255)
    
    -- internal state
    self.selected = false
    self.cursorPos = 0   -- 0 means before the first letter, 1 after the first, so on
    self:setFontSize(30)
end

function Textbox:setLines(n)
    self.h = self.h * n
    textWrapWidth(self.w)
    self.multiText = true
    self:calcCoords()
end

function Textbox:setFontSize(x)
    self.fontProperties.fontSize = x
    -- calculate the height based on font properties
    pushStyle()
    self:applyTextProperties()
    local w,h = textSize("dummy")
    popStyle()
    self.h = h
    self:calcCoords()
end

-- call back for when a key is pressed
function Textbox:keyboard(key)
    -- if not active, ignore
    if not self.selected then return nil end

    if key == BACKSPACE then
        --print(self.cursorPos)
        -- note if we're already at the start, nothing to do
        if self.cursorPos > 0 then
            local prefix = self.text:sub(1,self.cursorPos-1)
            local posfix = self.text:sub(self.cursorPos+1,self.text:len())
            self.text = prefix..posfix
            self.cursorPos = self.cursorPos - 1
        end
    else
        local prefix = self.text:sub(1,self.cursorPos)
        local posfix = self.text:sub(self.cursorPos+1,self.text:len())
        local proposedText = prefix..key..posfix
        pushStyle()
        self:applyTextProperties()
        local proposedW = textSize(proposedText)
        popStyle()
        if proposedW <= self:maxX() or self.multiText then
            -- we can add the new char
            self.text = proposedText
            self.cursorPos = self.cursorPos + 1
        end
    end
    
    if self.keycallback then self.keycallback(self.text) end
    
    self:calcCoords()
end

function Textbox:displayText()
    local displayText = self.text
    if self.protected then
        displayText = ""
        for i = 1,self.text:len() do displayText = displayText.."*" end
    end

    if self.multiText then
        -- codea has a bug (feature?) that a new line at the end of the text doesn't do anything
        -- this helps us locate the cursor in the right line
        local len = displayText:len()
        if len > 0 and displayText:sub(len,len) == "\n" then
            displayText = displayText .. " "
        end
        
        -- now truncate the text to make sure we don't overflow heightwise
        pushStyle()
        self:applyTextProperties()
        local h = select(2,textSize(displayText))
        local startPos = 1
        while h > self.h - 10 do
            displayText = displayText:sub(2,displayText:len())
            startPos = startPos + 1
            h = select(2,textSize(displayText))
        end
        popStyle()
    end

    return displayText,startPos
end

function Textbox:applyTextProperties()
    textMode(CORNER)
    font(self.fontProperties.font)
    fontSize(self.fontProperties.fontSize)
    fill(self.fontProperties.fill)
end

function Textbox:maxX()
    return self.w - 10
end

function Textbox:translate(dx,dy)
    Button.translate(self,dx,dy)
    self:calcCoords()
end

function Textbox:calcCoords()
    pushStyle()

    -- the text    
    self:applyTextProperties()
    local displayText = self:displayText()
    local singleH = select(2,textSize("dummy"))
    local textW,textH = textSize(displayText)
    if textH == 0 then textH = singleH end -- for when displayText is empty
    
    local textX = self.x + (self.w - textW)/2 -- default alignment 