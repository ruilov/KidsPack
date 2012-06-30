function setup()
    smooth()
    screen = NumOrdering()
end

function draw()
    screen:draw()
end

function touched(t)
    screen:touched(t)
end

import "GitClient"
