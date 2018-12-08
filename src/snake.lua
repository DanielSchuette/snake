--[[
    Snake class
]]
Snake = Class{}

function Snake:init(x, y, direction, length)
    self.x = x-1
    self.y = y-1
    self.direction = direction
    self.length = length
    self.body = {}
end

function Snake:update(dt, state)
    -- new position 1 in body table will be the former head
    table.insert(self.body, 1, {self.x, self.y}) 

    -- the last element of body table will be removed
    table.remove(self.body)

    -- now, the new position of the head will be calculated
    if self.direction == "left" then
        if not outOfBounds(self.x, self.y) then
            self.x = self.x - TILE_SIZE_X
        elseif SNAKE_IS_WRAPPING then
            self.x = WINDOW_WIDTH
        else
            state:changeState(STATE_GAME_OVER)
        end
    elseif self.direction == "right" then
        if not outOfBounds(self.x, self.y) then
            self.x = self.x + TILE_SIZE_X
        elseif SNAKE_IS_WRAPPING then
            self.x = 0
        else
            state:changeState(STATE_GAME_OVER)
        end
    elseif self.direction == "up" then
        if not outOfBounds(self.x, self.y) then
            self.y = self.y - TILE_SIZE_Y
        elseif SNAKE_IS_WRAPPING then
            self.y = WINDOW_HEIGHT
        else
            state:changeState(STATE_GAME_OVER)
        end
    elseif self.direction == "down" then
        if not outOfBounds(self.x, self.y) then
            self.y = self.y + TILE_SIZE_Y
        elseif SNAKE_IS_WRAPPING then
            self.y = 0
        else
            state:changeState(STATE_GAME_OVER)
        end
    end
end

function Snake:grow(state)
    self.length = self.length + 1       -- increase the snake's length
    x, y = self.x, self.y               -- save x and y values for the body
    self:update(0, state)               -- advance the head once
    table.insert(self.body, {x, y})     -- add body element where last head was
end

function Snake:render()
    love.graphics.setColor(0, 1, 0, 1) -- green for snake

    -- draw the snake's head
    love.graphics.rectangle("fill", self.x, self.y, SNAKE_SIZE_X, SNAKE_SIZE_Y)

    -- draw the snake's body
    if self.length > 1 then
        for idx = 1, (self.length-1) do -- length WITHOUT the head element
            love.graphics.rectangle("fill", self.body[idx][1], self.body[idx][2],
                SNAKE_SIZE_X, SNAKE_SIZE_Y)
        end
    end
end

function outOfBounds(x, y)
    if (x < 0) or (y < 0) or (x > (WINDOW_WIDTH-SNAKE_SIZE_X+1)) or 
        (y > (WINDOW_HEIGHT-SNAKE_SIZE_Y+1)) then
        return true
    end
    return false
end
