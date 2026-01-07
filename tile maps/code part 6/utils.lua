function CreateQuads(texture,tileWidth,tileHeight)
    local quads = {}

    local rows = texture:getHeight() / tileHeight
    local cols = texture:getWidth() / tileWidth

    for j=0,rows-1 do
        for i=0, cols-1 do
            local quad = love.graphics.newQuad(i*tileWidth,j*tileHeight,tileWidth,tileHeight,texture:getDimensions())
            table.insert(quads,quad)
        end
    end

    return quads
end

function LerpVector2(sx,sy,ex,ey,t)
    local dx = sx + (ex-sx) * t
    local dy = sy + (ey-sy) * t
    return dx,dy
end