NumOrdering = class(Panel)

function NumOrdering:init()
    Panel.init(self,0,0)
    self.nx,self.ny = 5,5
    self:makeButtons()
    self.time = 0
    self.title = TextElem("Time",WIDTH/2,HEIGHT-100,