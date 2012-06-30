function setup()
    smooth()
    screen = NumOrdering()
end

function draw()
    background(0)
    screen:tick()
    screen:draw()
end

function touched(t)
    screen:touched(t)
end

--import "GitClient"
