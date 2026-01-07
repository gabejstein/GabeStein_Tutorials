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
        entities = {},
        player = nil,
    }
    setmetatable(this,self)

    this.screenWidth = this.width * this.cellSize
    this.screenHeight = this.height * this.cellSize

    this.tileTexture = gTileTextures[this.tileSet]
    this.tileQuads = gTileQuads[this.tileSet]

    for i,v in ipairs(mapDef.layers[3].objects) do
        this:CreateWall(v.x,v.y,v.width,v.height)
    end

    for i,v in ipairs(mapDef.layers[4].objects) do
        local e
        if v.name == "player" then
            e = Player:New(v.x,v.y)
            this.player = e
        elseif v.name == "coin" then
            e = {
                x = v.x,
                y = v.y,
                w = 32,
                h = 32,
                isActive = true,
                texture = gTextures["coin"],
                Render = function(self)
                    love.graphics.draw(self.texture,self.x-gCamera.x,self.y-gCamera.y)
                end,
                
            }
            e.body = love.physics.newBody(gWorld,v.x,v.y,"static")
            --Note: Before I forgot to offset the coin collider from the center with half the width/height
            e.shape = love.physics.newRectangleShape(16,16,32,32)
            e.fixture = love.physics.newFixture(e.body,e.shape)
            e.fixture:setUserData(e)
            e.fixture:setSensor(true)
            
        end

        if e ~= nil then
            table.insert(this.entities,e)
        end
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

function Map:Update(dt)
    for i,e in ipairs(self.entities)do
        if e.isActive then
            if e.Update then
                e:Update(dt)
            end
        end
    end
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

    table.sort(self.entities,function(a,b) return a.y < b.y end)

    for i,e in ipairs(self.entities)do
        if e.isActive then
            if e.Render then
                e:Render() 
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

    --This wasn't in the video, but I've gone ahead and
    --given the map the responsibility of debug rendering each object.
    for i,e in ipairs(self.entities)do
        if e.isActive then
            if e.DebugRender then
                e:DebugRender()
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