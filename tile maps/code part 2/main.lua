require "map"

SCREEN_WIDTH = 1080
SCREEN_HEIGHT = 840

local tiles = {
    1,2,2,2,2,2,2,3,
    9,10,10,10,10,10,10,11,
    9,10,4,5,5,6,10,11,
    9,10,12,13,13,14,10,11,
    9,10,20,21,21,22,10,11,
    17,18,18,18,18,18,18,19,
}

local gMap = Map:New(tiles,8,6)

function CreateQuads(texture,tileWidth,tileHeight)
    local quads = {}

    local rows = texture:getHeight() / tileHeight
    local cols = texture:getWidth() / tileWidth

    for j=0,rows-1 do
        for i=0, cols-1 do
            local quad = love.graphics.newQuad(i*tileWidth,j*tileHeight,tileWidth,tileHeight,texture:getDimensions())
            table.insert(quads,quad)
        end
    end

    return quads
end

tileTexture = love.graphics.newImage("textures2/tilesheet01.png")
tileQuads = CreateQuads(tileTexture,64,64)


function love.load()
    love.window.setMode(SCREEN_WIDTH,SCREEN_HEIGHT,{vsync=true, fullscreen=false})

    

    --gMap:SetTile(1,1,2)
    
end

function love.update(dt)
    
end

function love.draw()
    gMap:Render()

end