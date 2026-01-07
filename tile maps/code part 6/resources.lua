gTileTextures = {
    ["tilesheet01"] = love.graphics.newImage("textures/tilemap_packed.png")
}

gTileQuads ={
    ["tilesheet01"] = CreateQuads(gTileTextures["tilesheet01"],64,64)
}

gTextures = {
    ["coin"] = love.graphics.newImage("textures/coin.png")
}

gMapDef = require "maps.city_map"