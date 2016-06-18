TileDisplaySystem = class("TileDisplaySystem", System)

function TileDisplaySystem:draw()
    for index, entity in pairs(self.targets) do
        local position = entity:get("PositionComponent").current
        local tile     = entity:get("TileComponent")
        love.graphics.setColor(tile.color)
        love.graphics.rectangle("fill", position.x, position.y, tile.w, tile.h)
    end
end

function TileDisplaySystem:requires()
    return {"PositionComponent", "TileComponent"}
end 
