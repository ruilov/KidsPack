NumOrdering = class(Panel)

function NumOrdering:init()
    Panel.init(self,0,0)
    self.nx,self.ny = 2,2
    self:makeButtons()
    self.time = 0
    self.title = TextElem("Time",WIDTH/2,HEIGHT-100,{fontSize=100,textMode=CENTER})
    self:add(self.title)
    self.next = 1
    self.on = true -- whether the game is on
    self.times = {}    -- to keep track of when the player got each number
end

function NumOrdering:makeButtons() 
    local puzzle = NumOrdering.makePuzzle(self.nx*self.ny)    
    local topMargin = 200
    local marginX,marginY = 10,10
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
            
            local thisNum = b.banner.textElem.text
            if thisNum ~= self.next.."" then
                self:lost()
            else
                self.times[self.next] = self.time
                self.next = self.next + 1
                if self.next > self.nx * self.ny then
                    screen = NumOrderingEnd(true,self.times)
                end
            end
        end
        self:add(button)
    end
end

function NumOrdering:lost()
    self.on = false
    self.title.text = "WRONG!"
end

function NumOrdering:won()
    self.on = false
    self.title.fontSize = 42
    self.title.text = "You count fast! From 1 to "..(self.nx * self.ny).." in "..
        string.format("%.1f",self.time)
end

function NumOrdering:tick()
    if self.on then
        self.time = self.time + DeltaTime
        self.title.text = string.format("%.1f",self.time)
    end
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

NumOrderingEnd = class(Panel)

function NumOrderingEnd:init(won,times)
    Panel.init(self,0,0)
    local elem = TextElem("You count fast!",WIDTH/2,HEIGHT-100,{fontSize=50,textMode=CENTER})
    self:add(elem)
    
    local maxTime = 0
    for _,t in pairs(times) do maxTime = math.max(maxTime,t) end
    local elem = TextElem("From 1 to "..(#times).." in "..string.format("%.1f",maxTime)..
        " secs",
        WIDTH/2,HEIGHT - 200,{fontSize=50,textMode=CENTER})
    self:add(elem)
    
    local plot = Plot({},100,150,WIDTH-200,300)
    self:add(plot)
end




