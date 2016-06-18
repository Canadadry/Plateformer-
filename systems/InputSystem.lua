InputSystem = class("InputSystem",System)



function InputSystem:update()

    for index,entity in pairs(self.targets) do
        local input = entity:get("InputComponent")

        input.GoLeft  = love.keyboard.isDown(input.l_button)
        input.GoRight = love.keyboard.isDown(input.r_button)
        input.GoDown  = love.keyboard.isDown(input.d_button)
        input.Jump    = love.keyboard.isDown(input.j_button)
    end
end

function InputSystem:requires()
    return {"InputComponent"}
end