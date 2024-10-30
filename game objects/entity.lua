Entity = {}
Entity.__index = Entity

function Entity:New(x,y)
    local this = {
        x = x,
        y = y,
        dx = 0,
        dy = 0,
        texture = nil,
        speed = 400,
    }
    setmetatable(this,self)

    return this
end

function Entity:Update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Entity:Render()
    if self.texture then
        love.graphics.draw(self.texture,self.x,self.y)
   end
end