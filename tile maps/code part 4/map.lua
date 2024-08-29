Map = {}
Map.__index = Map


function Map:New(mapDef)
    local this ={
        tiles = {mapDef.layers[1].data, mapDef.layers[2].data},
        width = mapDef.width,
        height = mapDef.height,
        cellSize = mapDef.tilewidth,
        tileSet = mapDef.tilesets[1].name
    }
    setmetatable(this,self)

    this.screenWidth = this.width * this.cellSize
    this.screenHeight = this.height * this.cellSize

    this.tileTexture = gTileTextures[this.tileSet]
    this.tileQuads = gTileQuads[this.tileSet]

    return this
end

function Map:Render()
    for row=0,15 do
        for col=0, 20 do
            local tx = math.floor(gCamera.x / self.cellSize)
            local ty = math.floor(gCamera.y / self.cellSize)
            tx = tx + col
            ty = ty + row
            local sx = col * self.cellSize - (gCamera.x % self.cellSize)
            local sy = row * self.cellSize - (gCamera.y % self.cellSize)
            local tile = self:GetTile(tx,ty,1)
            
            if tile > 0 then
                love.graphics.draw(self.tileTexture,self.tileQuads[tile],sx,sy)
            end

            tile = self:GetTile(tx,ty,2)
            
            if tile > 0 then
                love.graphics.draw(self.tileTexture,self.tileQuads[tile],sx,sy)
            end

        end
    end
end

function Map:GetTile(x,y,layer)
    layer = layer or 1
    if x < 0 or y < 0 or x >self.width-1 or y > self.height-1 then
        return 0
    end
    return self.tiles[layer][y * self.width + x + 1]
end

function Map:SetTile(x,y,tileType, layer)
    layer = layer or 1
    if x < 0 or y < 0 or x >self.width-1 or y > self.height-1 then
        return false
    end
    self.tiles[layer][y * self.width + x + 1] = tileType
    return true
end