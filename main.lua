--[[
    A simple Snake game
    The code comes from CS50's Twitch live stream:
    https://www.youtube.com/watch?v=ld_xcXdRez4
]]
require "src/dependencies"

local snakeX = 1
local snakeY = 1
local snakeMoving = "right"
local tileGrid = {}

function love.load()
    print("running...")
    love.window.setTitle("Snake Game")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false
    })
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if (key == "left") or (key == "h") then
        snakeMoving = "left"
    elseif (key == "right") or (key == "l") then
        snakeMoving = "right"
    elseif (key == "up") or (key == "k") then
        snakeMoving = "up"
    elseif (key == "down") or (key == "j") then
        snakeMoving = "down"
    end
end

function love.update(dt)
    if snakeMoving == "left" then
        snakeX = snakeX - SNAKE_SPEED * dt
    elseif snakeMoving == "right" then
        snakeX = snakeX + SNAKE_SPEED * dt
    elseif snakeMoving == "up" then
        snakeY = snakeY - SNAKE_SPEED * dt
    elseif snakeMoving == "down" then
        snakeY = snakeY + SNAKE_SPEED * dt
    end

end

function love.draw()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.rectangle("fill", snakeX, snakeY, SNAKE_SIZE, SNAKE_SIZE)
end
