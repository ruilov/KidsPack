-- TextBanner.lua

-- TextBanner is a text elem with a background
-- supported background types are round,square,back (for back buttons),bottomRound,topRound

TextBanner = class(RectObj)

function TextBanner:init(text,x,y,w,h,args)
    RectObj.init(self,x,y,w,h)

    args = args or {}
    args.text = args.text or {}
    args.text.textMode = args.text.textMode or CENTER
    args.text.fill = args.text.fill or color(0,0,0,255)
    args.text.fontSize = args.text.fontSize or 28

    self.type = args.type or "round"
    local tx = w/2
    local ty = h/2
    
    if self.type == "back" then 
        tx = tx + 3 
        ty = ty + 2
    end

    self.textElem = TextElem(text,tx,ty,args.text)

    self.topColor = args.topColor or color(255, 255, 255, 255) 
    self.bottomColor = args.bottomColor or color(255,255,255,255)

    self.myMesh = mesh()
    self.vertColors = {}
    self:moveCB()
end

function TextBanner:moveCB()
    self.verts = self:createVerts()
    self.myMesh.vertices = triangulat