--[[
    Snake class
]]
Snake = Class{}

function Snake:init(x, y, direction, length)
    self.x = x-1
    self.y = y-1
    self.direction = direction
    self.length = length
end

function Snake:update(dt, state)
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

function Snake:render()
    love.graphics.setColor(0, 1, 0, 1) -- green for snake
    love.graphics.rectangle("fill", self.x, self.y, SNAKE_SIZE_X, SNAKE_SIZE_Y)
end

function outOfBounds(x, y)
    if (x < 0) or (y < 0) or (x > (WINDOW_WIDTH-SNAKE_SIZE_X+1)) or 
        (y > (WINDOW_HEIGHT-SNAKE_SIZE_Y+1)) then
        return true
    end
    return false
end
