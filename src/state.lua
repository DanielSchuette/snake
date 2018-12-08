--[[
    Game state class
]]

State = Class{}

function State:init(state)
    self.state = state
end

function State:changeState(newState)
    self.state = newState
end

function State:getState()
    return self.state
end
