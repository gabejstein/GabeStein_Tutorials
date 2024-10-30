Player = Entity:New()
Player.__index = Player

--I'm loading the textures external to the classes to avoid loading them more than once.
local PlayerTexture = love.graphics.newImage("assets/playerShip3_green.png")

function Player:New(x,y)
    local this = Entity:New(x,y)
    setmetatable(this,self)

    this.texture = PlayerTexture

    return this
end

function Player:Update(dt)
    self.dx,self.dy = 0,0

    if love.keyboard.isDown("w")then
        self.dy = -self.speed
    elseif love.keyboard.isDown("s")then
        self.dy = self.speed
    end

    if love.keyboard.isDown("a")then
        self.dx = -self.speed
    elseif love.keyboard.isDown("d")then
        self.dx = self.speed
    end

    Entity.Update(self,dt)
end