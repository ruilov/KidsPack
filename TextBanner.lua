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
    self.myMesh.vertices = triangulate(self.verts)
    self:recolor()
end

-- for a translation we don't have to call moveCB so let's overwrite that
-- method. This saves a lot of speed
function TextBanner:translate(dx,dy)
    self.x = self.x + dx
    self.y = self.y + dy
end

function TextBanner:draw()
    pushMatrix()
    pushStyle()
    translate(self.x,self.y)
    
    -- draw the background
    self.myMesh:draw()

    -- draw the text
    self.textElem:draw()
    
    -- draw the border
    self:drawLines(self.verts)
    popStyle()
    popMatrix()
end

function TextBanner:createVerts()
    local w,h = self.w,self.h 
    local v = {}
    if w == 0 then return v end
    
    local r = 1    
    if self.type == "round" then    
        v[1] = vec2(w,6*r)
        v[2] = vec2(w-r,4*r)
        v[3] = vec2(w-2*r,2*r)
        v[4] = vec2(w-4*r,r)
        v[5] = vec2(w-6*r,0)
        
        v[6] = vec2(6*r,0)
        v[7] = vec2(4*r,r)
        v[8] = vec2(2*r,2*r)
        v[9] = vec2(r,4*r)
        v[10] = vec2(0,6*r)
     