Map = {}
Map.__index = Map


function Map:New(data,width,height)
    local this ={
        tiles = data,
        width = width,
        height = height,
        cellSize = 64,
    }
    setmetatable(this,self)

    this.screenWidth = this.width * this.cellSize
    this.screenHeight = this.height * this.cellSize
    this.ox = SCREEN_WIDTH * 0.5 - this.screenWidth * 0.5
    this.oy = SCREEN_HEIGHT * 0.5 - this.screenHeight * 0.5

    return this
end

function Map:Render()
    for row=0,self.height-1 do
        for col=0, self.width-1 do
            local sx = col * self.cellSize + self.ox
            local sy = row * self.cellSize + self.oy
            local tile = self:GetTile(col,row)
            
            if tile > 0 then
                love.graphics.draw(tileTexture,tileQuads[tile],sx,sy)
            end

            love.graphics.rectangle("line",sx,sy,self.cellSize,self.cellSize)
        end
    end
end

function Map:GetTile(x,y)
    if x < 0 or y < 0 or x >self.width-1 or y > self.height-1 then
        return 0
    end
    return self.tiles[y * self.width + x + 1]
end

function Map:SetTile(x,y,tileType)
    if x < 0 or y < 0 or x >self.width-1 or y > self.height-1 then
        return false
    end
    self.tiles[y * self.width + x + 1] = tileType
    return true
end