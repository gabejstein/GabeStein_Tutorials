require "map"

SCREEN_WIDTH = 1080
SCREEN_HEIGHT = 840

local tiles = {
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,1,0,
    0,0,1,1,0,0,1,0,
    0,0,1,1,0,0,1,0,
    0,0,0,0,0,0,0,0,
    0,0,2,2,2,1,1,0,
}

local gMap = Map:New(tiles,8,6)

function love.load()
    love.window.setMode(SCREEN_WIDTH,SCREEN_HEIGHT,{vsync=true, fullscreen=false})

    gMap:SetTile(1,1,2)
    
end

function love.update(dt)
    
end

function love.draw()
    gMap:Render()

end