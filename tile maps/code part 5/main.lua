require "map"
require "player"

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 960

gDebugMode = false

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

gWorld = love.physics.newWorld(0,0)

local gMapDef = require "maps.city_map"

local gMap = Map:New(gMapDef)

gCamera = {x = 0, y = 0, targetX = 0, targetY = 0, t = 0}
gPlayer = Player:New(64,256)

function LerpVector2(sx,sy,ex,ey,t)
    local dx = sx + (ex-sx) * t
    local dy = sy + (ey-sy) * t
    return dx,dy
end

function UpdateCamera(dt)
    
    gCamera.t = math.min(1, gCamera.t + dt * 0.02)

    gCamera.targetX,gCamera.targetY = LerpVector2(gCamera.targetX,gCamera.targetY, gPlayer.x,gPlayer.y, gCamera.t )

    gCamera.x = math.floor(gCamera.targetX - SCREEN_WIDTH * 0.5)
    gCamera.y = math.floor(gCamera.targetY - SCREEN_HEIGHT * 0.5)

    if gCamera.x < 0 then gCamera.x = 0 end
    if gCamera.y < 0 then gCamera.y = 0 end

    if gCamera.x > gMap.screenWidth - SCREEN_WIDTH then gCamera.x = gMap.screenWidth - SCREEN_WIDTH end
    if gCamera.y > gMap.screenHeight - SCREEN_HEIGHT then gCamera.y = gMap.screenHeight - SCREEN_HEIGHT end
end


function love.load()
    love.window.setMode(SCREEN_WIDTH,SCREEN_HEIGHT,{vsync=true, fullscreen=false})

    
end

function love.update(dt)

    if love.keyboard.isDown("x")then
        gDebugMode = true
    elseif love.keyboard.isDown("z")then
        gDebugMode = false
    end

    gWorld:update(dt)
    gPlayer:Update(dt)
    UpdateCamera(dt)
    
end

function love.draw()
    gMap:Render()
    gPlayer:Render()

    if gDebugMode then
        gMap:DebugRender()
        gPlayer:DebugRender()
    end
end