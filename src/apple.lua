--[[
    Apple class
]]
Apple = Class{}

function Apple:init()
    self.x = math.random(MAX_TILES_X)
    self.y = math.random(MAX_TILES_Y)
end

function Apple:positionOnTile(tileGrid)
    tileGrid[self.y][self.x] = TILE_APPLE
end
