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
    for row=0,self.height-1 do
        for col=0, self.width-1 do
            local sx = col * self.cellSize - gCamera.x
            local sy = row * self.cellSize - gCamera.y
            local tile = self:GetTile(col,row,1)
            
            if tile > 0 then
                love.graphics.draw(self.tileTexture,self.tileQuads[tile],sx,sy)
            end

            tile = self:GetTile(col,row,2)
            
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