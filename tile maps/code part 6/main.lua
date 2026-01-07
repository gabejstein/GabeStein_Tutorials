require "map"
require "player"
require "utils"
require "resources"

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 960

gDebugMode = false

gWorld = love.physics.newWorld(0,0)

gWorld:setCallbacks(function (a,b)
    
    local e1,e2 = a:getUserData(),b:getUserData()

    if(e1 and e2) then

        if(e1.OnCollision)then
            e1:OnCollision(e2)
        end
    
        if(e2.OnCollision)then
            e2:OnCollision(e1)
        end
    end    
   
end,function()end,nil,nil)

local gMap = Map:New(gMapDef)

gCamera = {x = 0, y = 0, targetX = 0, targetY = 0, t = 0}
gPlayer = gMap.player
gCamera.targetX,gCamera.targetY,gCamera.x,gCamera.y = gPlayer.x,gPlayer.y,gPlayer.x,gPlayer.y
gScore = 0

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
    love.graphics.setNewFont(60)
    
end

function love.update(dt)

    if love.keyboard.isDown("x")then
        gDebugMode = true
    elseif love.keyboard.isDown("z")then
        gDebugMode = false
    end

    gMap:Update(dt)
    gWorld:update(dt)
    UpdateCamera(dt)
    
end

function love.draw()
    gMap:Render()

    if gDebugMode then
        gMap:DebugRender()
        --gPlayer:DebugRender() --Is now being handled by the map object.
    end

    local label = string.format("$%d",gScore)
    love.graphics.print(label,10,10)
end