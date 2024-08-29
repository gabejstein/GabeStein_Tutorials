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
        }
    }
    setmetatable(this,self)

    this.currentFrame = this.frames["down"]
    
    return this
end

function Player:Update(dt)
    local speed = 400

    if love.keyboard.isDown("w")then
        self.y = self.y - speed * dt

        self.currentFrame = self.frames["up"]
    elseif love.keyboard.isDown("s")then
        self.y = self.y + speed * dt

        self.currentFrame = self.frames["down"]
    end

    if love.keyboard.isDown("a")then
        self.x = self.x - speed * dt

        self.currentFrame = self.frames["left"]
    elseif love.keyboard.isDown("d")then
        self.x = self.x + speed * dt

        self.currentFrame = self.frames["right"]
    end
end

function Player:Render()
    local sx = math.floor(self.x - gCamera.x)
    local sy = math.floor(self.y - gCamera.y)
    
    love.graphics.draw(self.texture,self.currentFrame,sx,sy)
end