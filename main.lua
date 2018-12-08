--[[
    A simple Snake game
    The code comes from CS50's Twitch live stream:
    https://www.youtube.com/watch?v=ld_xcXdRez4
]]
require "src/dependencies"

local snake
local state
local tileGrid = {}

function love.load()
    print("running...")
    love.window.setTitle("Snake Game")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false
    })
    snake = Snake(1, 1, "right")
    state = State(STATE_GAME_OVER)
    initializeGrid()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if state:getState() == STATE_PLAYING then
        if (key == "left") or (key == "h") then
            snake.direction = "left"
        elseif (key == "right") or (key == "l") then
            snake.direction = "right"
        elseif (key == "up") or (key == "k") then
            snake.direction = "up"
        elseif (key == "down") or (key == "j") then
            snake.direction = "down"
        end
    elseif state:getState() == STATE_GAME_OVER then
        if key == "space" then
            state:changeState(STATE_PLAYING)
            snake = Snake(1, 1, "right") -- make a new snake
        end
    end
end

function love.update(dt)
    if state:getState() == STATE_PLAYING then
        snake:update(dt, state)
    end
end

function love.draw()
    if state:getState() == STATE_GAME_OVER then
        love.graphics.setColor(1, 1, 1, 1)
        renderTitleScreen()
    elseif state:getState() == STATE_PLAYING then
        love.graphics.setColor(0, 1, 0, 1)
        drawGrid()
        snake:render()
    end
end

function drawGrid()
    for y = 1, MAX_TILES_Y do
        for x = 1, MAX_TILES_X do
            love.graphics.rectangle("line", (x-1) * TILE_SIZE_X, (y-1) * TILE_SIZE_Y, 
                TILE_SIZE_X, TILE_SIZE_Y)
        end
    end
end

function initializeGrid()
    for y = 1, MAX_TILES_Y do
        table.insert(tileGrid, {})
        for x = 1, MAX_TILES_X do
            table.insert(tileGrid[y], TILE_EMPTY)
        end
    end
end

function renderTitleScreen()
    love.graphics.rectangle("line", 90, 90, WINDOW_WIDTH-180, WINDOW_HEIGHT-180)
    love.graphics.printf("Snake Game, v0.0.1", 
        WINDOW_WIDTH/2 - 150, 120, 150, "center", 0, 2, 2)
    love.graphics.printf("Push 'enter' to start the game.", 
        WINDOW_WIDTH/2 - 150, 180, 150, "center", 0, 2, 2)
    love.graphics.printf("github.com/DanielSchuette/snake", 
        WINDOW_WIDTH/2 - 250, 280, 250, "center", 0, 2, 2)
end
