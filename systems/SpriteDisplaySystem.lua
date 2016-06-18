SpriteDisplaySystem = class("SpriteDisplaySystem",System)


function SpriteDisplaySystem:draw()
    for index,entity in pairs(self.targets) do
        local position = entity:get("PositionComponent").current
        local sprite = entity:get("SpriteComponent").texture
        love.graphics.push()
        love.graphics.translate(position.x,position.y)
        love.graphics.draw(sprite)
        love.graphics.pop()
    end
end

function SpriteDisplaySystem:requires()
    return {"PositionComponent","SpriteComponent"}
end