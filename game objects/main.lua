require "entity"
require "player"
require "enemy"
require "super_enemy"
require "powerup"

local background = love.graphics.newImage("assets/405-0.png")

local entities = {}

function love.load()
    love.window.setTitle("Game Objects")
    love.window.setMode(820,816,{fullscreen=false,vsync=true})

    table.insert(entities,Player:New(400,400))
    table.insert(entities,Enemy:New(50,50))
    table.insert(entities,Enemy:New(350,50))
    table.insert(entities,Enemy:New(550,150))
    table.insert(entities,SuperEnemy:New(550,550))
    
    table.insert(entities,Powerup:New(10,10))
    table.insert(entities,Powerup:New(250,30))
    table.insert(entities,Powerup:New(600,200))
end

function love.update(dt)
    --update objects
   
    for i,v in ipairs(entities)do
        v:Update(dt)
    end

end

function love.draw()
    --draw background
    love.graphics.setColor(1,1,1,0.2)
    love.graphics.draw(background,0,0)
    love.graphics.setColor(1,1,1,1)

    --draw objects
    for i,v in ipairs(entities)do
        v:Render()
    end
    
end