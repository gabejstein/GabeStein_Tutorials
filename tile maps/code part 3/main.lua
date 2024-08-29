require "map"

SCREEN_WIDTH = 1080
SCREEN_HEIGHT = 840

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

gTileTextures = {
    ["tilesheet01"] = love.graphics.newImage("textures/tilemap_packed.png")
}

gTileQuads ={
    ["tilesheet01"] = CreateQuads(gTileTextures["tilesheet01"],64,64)
}

local gMapDef = require "maps.city_map"

local gMap = Map:New(gMapDef)

gCamera = {x = 0, y = 0}

function UpdateCamera(dt)
    local cameraSpeed = 400

    if love.keyboard.isDown("w")then
        gCamera.y = gCamera.y - cameraSpeed * dt
    elseif love.keyboard.isDown("s")then
        gCamera.y = gCamera.y + cameraSpeed * dt
    end

    if love.keyboard.isDown("a")then
        gCamera.x = gCamera.x - cameraSpeed * dt
    elseif love.keyboard.isDown("d")then
        gCamera.x = gCamera.x + cameraSpeed * dt
    end

    gCamera.x = math.floor(gCamera.x)
    gCamera.y = math.floor(gCamera.y)
end


function love.load()
    love.window.setMode(SCREEN_WIDTH,SCREEN_HEIGHT,{vsync=true, fullscreen=false})

    
end

function love.update(dt)
    UpdateCamera(dt)
    
end

function love.draw()
    gMap:Render()

end