Plot = class(Panel)

function Plot:init(data,x,y,w,h)
    Panel.init(self,x,y)
    self.w = w
    self.h = h
end

function Plot:draw()
    pushStyle()
    pushMatrix()
    translate(self.x,self.y)
    strokeWidth(8)
    stroke(255,255,255)
    lineCapMode(PROJECT)
    
    -- x-axis
    local arrowSize = 10
    line(0,0,self.w,0)
    line(self.w+3,0,self.w-arrowSize,-arrowSize)
    line(self.w+3,0,self.w-arrowSize,arrowSize)
    
    -- y-axis
    local arrowSize = 10
    line(0,0,0,self.h)
    line(0,self.h+3,-arrowSize,self.h-arrowSize)
    line(0,self.h+3,arrowSize,self.h-arrowSize)
    
    popStyle()
    popMatrix()
end

