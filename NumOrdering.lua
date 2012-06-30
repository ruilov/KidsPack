NumOrdering = class(Panel)

function NumOrdering:init()
    Panel.init(self,0,0)
    self.nx,self.ny = 5,5
    self:makeButtons()
    self.time = 0
    self.title = TextElem("Time",WIDTH/2,HEIGHT-100,{fontSize=100,textMode=CENTER})
    self:add(self.title)
end

function NumOrdering:makeButtons() 
    local puzzle = NumOrdering.makePuzzle(self.nx*self.ny)    
    local topMargin = 200
    local mar