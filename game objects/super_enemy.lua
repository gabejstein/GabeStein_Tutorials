SuperEnemy = Enemy:New()
SuperEnemy.__index = SuperEnemy

--I'm loading the textures external to the classes to avoid loading them more than once.
local SuperEnemyTexture = love.graphics.newImage("assets/enemyBlack1.png")

function SuperEnemy:New(x,y)
    local this = Enemy:New(x,y)
    setmetatable(this,self)

    this.texture = SuperEnemyTexture

    return this
end
