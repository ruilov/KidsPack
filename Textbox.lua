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
    
    --