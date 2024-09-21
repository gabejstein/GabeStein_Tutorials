Map = {}
Map.__index = Map


function Map:New(mapDef)
    local this ={
        tiles = {mapDef.layers[1].data, mapDef.layers[2].data},
        width = mapDef.width,
        height = mapDef.height,
        cellSize = mapDef.tilewidth,
        tileSet = mapDef.tilesets[1].name,
        body = love.physics.newBody(gWorld,0,0,"static"),
        walls = {},
    }
    setmetatable(this,self)

    this.screenWidth = this.width * this.cellSize
    this.screenHeight = this.height * this.cellSize

    this.tileTexture = gTileTextures[this.tileSet]
    this.tileQuads = gTileQuads[this.tileSet]

    for i,v in ipairs(mapDef.layers[3].objects) do
        this:CreateWall(v.x,v.y,v.width,v.height)
    end

    return this
end

function Map:CreateWall(x,y,w,h)
    local wall = {
        shape = love.physics.newRectangleShape(x + w * 0.5,y + h*0.5,w,h)
    }

    wall.fixture = love.physics.newFixture(self.body,wall.shape)

    table.insert(self.walls,wall)
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

function Map:DebugRender()
    for i=1,#self.walls do
        local points = {self.walls[i].shape:getPoints()}
        local transformedPoints = {}
        for j=1,#points,2 do
            table.insert(transformedPoints,points[j] - gCamera.x)
            table.insert(transformedPoints,points[j+1] - gCamera.y)
        end
        love.graphics.polygon("line",transformedPoints)
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