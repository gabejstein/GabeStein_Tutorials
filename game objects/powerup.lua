Powerup = Entity:New()
Powerup.__index = Powerup

--I'm loading the textures external to the classes to avoid loading them more than once.
local PowerupTexture = love.graphics.newImage("assets/powerupRed_star.png")

function Powerup:New(x,y)
    local this = Entity:New(x,y)
    setmetatable(this,self)

    this.texture = PowerupTexture

    return this
end