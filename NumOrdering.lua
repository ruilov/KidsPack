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
    local marginX,marginY = 20,20
    local w = (WIDTH - (self.nx+1)*marginX)/self.nx
    local h = (HEIGHT - topMargin - (self.ny+1)*marginY)/self.ny
    for i = 1,#puzzle do
        local x = (i-1)%self.nx
        x = (x+1) * marginX + x * w
        
        local y = math.floor((i-1)/self.nx)
        y = (y+1) * marginY + y * h
        
        local button = TextButton(puzzle[i].."",x,y,w,h,{type="round"})
        button.setUnpressed = function(b) end
        button.onEnded = function(b,t)
            b.active = false
        end
        self:add(button)
    end
end

function NumOrdering:tick()
    self.time = self.time + DeltaTime
    self.title.text = self.time .. ""
end

-- makes a random array of the integers from 1 to n
function NumOrdering.makePuzzle(n)
    -- unused are the integers that we haven't used yet
    local unused = {}
    for i = 1,n do table.insert(unused,i) end
    
    local ans = {}
    for i = 1,n do
        local idx = math.random(#unused)
        table.insert(ans,unused[idx])
        table.remove(unused,idx)
    end
    return ans
end
