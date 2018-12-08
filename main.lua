--[[
    A simple Snake game
    Small parts of the code come from CS50's Twitch stream:
    https://www.youtube.com/watch?v=ld_xcXdRez4
]]
require "src/dependencies"

local state
local snake
local apple
local tileGrid
local timer = 0

function love.load()
    print("running...")
    math.randomseed(os.time())
    love.window.setTitle("Snake Game")
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false
    })
    state = State(STATE_GAME_OVER)
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
            tileGrid = {} -- make an empty grid
            initializeGrid() -- initialize the grid
            snake = Snake(1, 1, "right", 1) -- make a new snake
            apple = Apple() -- make a new random apple
            apple:positionOnTile(tileGrid) -- position the apple on the grid
        end
    end
end

function love.update(dt)
    if state:getState() == STATE_PLAYING then
        timer = timer + dt
        if timer > SNAKE_SPEED then
            snake:update(dt, state)
            timer = 0
        end
    end
end

function love.draw()
    if state:getState() == STATE_GAME_OVER then
        love.graphics.setColor(1, 1, 1, 1)
        renderTitleScreen()
    elseif state:getState() == STATE_PLAYING then
        drawGrid(snake)
        drawScore(snake)
        snake:render()
    end
end

function drawGrid(snake)
    for y = 1, MAX_TILES_Y do
        for x = 1, MAX_TILES_X do
            if tileGrid[y][x] == TILE_EMPTY then
                love.graphics.setColor(1, 1, 1, 0) -- white for grid (currently invisible)
                love.graphics.rectangle("line", (x-1) * TILE_SIZE_X, (y-1) * TILE_SIZE_Y, 
                    TILE_SIZE_X, TILE_SIZE_Y)
            elseif tileGrid[y][x] == TILE_APPLE then
                love.graphics.setColor(1, 0, 0, 1) -- red for apple
                love.graphics.rectangle("fill", (x-1) * TILE_SIZE_X, (y-1) * TILE_SIZE_Y,
                    TILE_SIZE_X, TILE_SIZE_Y)
            end
        end
    end

    -- check if the current position of the snake is an apple
    local sx, sy = math.floor(snake.x/TILE_SIZE_X)+1, math.floor(snake.y/TILE_SIZE_Y)+1

    -- there seems to be an ugly bug when the snake leave the window at the top
    -- or the bottom; the reason is probably that the y coodinate becomes to big/
    -- small and indexes the table out of bounds; the following fixes that (ugly)
    -- TODO: actually fix this bug with more than a work-around like below
    if (sy < 1) then
        sy = 1
    end
    if (sy > #tileGrid) then
        sy = #tileGrid
    end

    -- now, continue with the logic to grow the snake if it eats an apple
    if tileGrid[sy][sx] == TILE_APPLE then 
        snake:grow(snake)               -- grow the snake
        tileGrid = {}                   -- make an empty grid
        initializeGrid()                -- initialize the grid
        apple = Apple()                 -- make a new random apple
        apple:positionOnTile(tileGrid)  -- position the apple on the grid
    end
end

function drawScore(snake)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(string.format("Score: %d", snake.length-1), 10, 10, 0, 2, 2)
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
