Enemy = Entity:New()
Enemy.__index = Enemy

--I'm loading the textures external to the classes to avoid loading them more than once.
local EnemyTexture = love.graphics.newImage("assets/enemyBlue5.png")

function Enemy:New(x,y)
    local this = Entity:New(x,y)
    setmetatable(this,self)

    this.dx = 200
    this.dy = 0
    this.texture = EnemyTexture
    this.timer = 0

    return this
end

function Enemy:LookForPlayer()
end

function Enemy:Shoot()
end

function Enemy:Update(dt)

    self.timer = self.timer + dt

    if self.timer > 1 then
        self.timer = 0
        self.dx = -self.dx
    end

    Entity.Update(self,dt)

end