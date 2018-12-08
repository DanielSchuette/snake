--[[
    Snake class
]]
Snake = Class{}

function Snake:init(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
end

function Snake:update(dt, state)
    if self.direction == "left" then
        if not outOfBounds(self.x, self.y) then
            self.x = self.x - SNAKE_SPEED * dt
        elseif SNAKE_IS_WRAPPING then
            self.x = WINDOW_WIDTH
        else
            state:changeState(STATE_GAME_OVER)
        end
    elseif self.direction == "right" then
        if not outOfBounds(self.x, self.y) then
            self.x = self.x + SNAKE_SPEED * dt
        elseif SNAKE_IS_WRAPPING then
            self.x = 0
        else
            state:changeState(STATE_GAME_OVER)
        end
    elseif self.direction == "up" then
        if not outOfBounds(self.x, self.y) then
            self.y = self.y - SNAKE_SPEED * dt
        elseif SNAKE_IS_WRAPPING then
            self.y = WINDOW_HEIGHT
        else
            state:changeState(STATE_GAME_OVER)
        end
    elseif self.direction == "down" then
        if not outOfBounds(self.x, self.y) then
            self.y = self.y + SNAKE_SPEED * dt
        elseif SNAKE_IS_WRAPPING then
            self.y = 0
        else
            state:changeState(STATE_GAME_OVER)
        end
    end
end

function Snake:render()
    love.graphics.rectangle("fill", self.x, self.y, SNAKE_SIZE_X, SNAKE_SIZE_Y)
end

function outOfBounds(x, y)
    if (x < 0) or (y < 0) or (x > WINDOW_WIDTH) or (y > WINDOW_HEIGHT) then
        return true
    end
    return false
end
