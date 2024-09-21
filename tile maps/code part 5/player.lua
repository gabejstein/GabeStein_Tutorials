Player = {}
Player.__index = Player

function Player:New(x,y)
    local this = {
        x = x,
        y = y,
        texture = gTileTextures["tilesheet01"],
        frames = {
           ["up"] = gTileQuads["tilesheet01"][26],
           ["down"] = gTileQuads["tilesheet01"][25],
           ["left"] = gTileQuads["tilesheet01"][24],
           ["right"] = gTileQuads["tilesheet01"][27],
        },
        body = love.physics.newBody(gWorld,x,y,"dynamic"),
    }
    setmetatable(this,self)

    this.shape = love.physics.newCircleShape(32,32,32)
    this.fixture = love.physics.newFixture(this.body,this.shape)
    this.body:setFixedRotation(true)

    this.currentFrame = this.frames["down"]
    
    return this
end

function Player:Update(dt)
    local speed = 400

    local dx,dy = 0,0
    if love.keyboard.isDown("w")then
        dy = -speed

        self.currentFrame = self.frames["up"]
    elseif love.keyboard.isDown("s")then
        dy = speed

        self.currentFrame = self.frames["down"]
    end

    if love.keyboard.isDown("a")then
        dx = -speed

        self.currentFrame = self.frames["left"]
    elseif love.keyboard.isDown("d")then
        dx = speed

        self.currentFrame = self.frames["right"]
    end

    self.body:setLinearVelocity(dx,dy)
    self.x,self.y = self.body:getPosition()
end

function Player:Render()
    local sx = math.floor(self.x - gCamera.x)
    local sy = math.floor(self.y - gCamera.y)
    
    love.graphics.draw(self.texture,self.currentFrame,sx,sy)
end

function Player:DebugRender()
    local sx,sy = self.body:getWorldCenter()
    sx = sx - gCamera.x
    sy = sy - gCamera.y
    love.graphics.circle("line",sx,sy,self.shape:getRadius())
end