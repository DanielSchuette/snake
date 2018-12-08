--[[
    A simple Snake game
    The code comes from CS50's Twitch live stream:
    https://www.youtube.com/watch?v=ld_xcXdRez4
]]
require "src/dependencies"

local snake
local tileGrid = {}

function love.load()
    print("running...")
    love.window.setTitle("Snake Game")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false
    })
    snake = Snake(1, 1, "right")
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if (key == "left") or (key == "h") then
        snake.direction = "left"
    elseif (key == "right") or (key == "l") then
        snake.direction = "right"
    elseif (key == "up") or (key == "k") then
        snake.direction = "up"
    elseif (key == "down") or (key == "j") then
        snake.direction = "down"
    end
end

function love.update(dt)
    snake:update(dt)
end

function love.draw()
    love.graphics.setColor(0, 1, 0, 1)
    for y = 1, MAX_TILES_Y do
        for x = 1, MAX_TILES_X do
            love.graphics.rectangle("line", (x-1) * TILE_SIZE_X, (y-1) * TILE_SIZE_Y, 
                TILE_SIZE_X, TILE_SIZE_Y)
        end
    end
    snake:render()
end
