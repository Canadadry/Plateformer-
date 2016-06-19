PhysicsSystem = class("PhysicsSystem",System)



function PhysicsSystem:update()
	local frameduration = 0.016 -- 60 fps = 16ms per frame
	local walkspeed = 1
	local jumpspeed = 1

    for index,entity in pairs(self.targets) do
        local position = entity:get("PositionComponent")
        local speed    = entity:get("SpeedComponent")
        local state    = entity:get("StateComponent")
        local body     = entity:get("BodyComponent")

        position.old:cpy(position.current)
        speed.old:cpy(speed.current)
        state.wasOnGround     = state.onGround;
	    state.pushedRightWall = state.pushesRightWall;
	    state.pushedLeftWall  = state.pushesLeftWall;
	    state.wasAtCeiling    = state.atCeiling;

	    position.current:add(speed.current:product(frameduration));

		if (position.current.y <= 0) then
		    position.current.y = 0
		    state.onGround = true
		else
		    state.onGround = false
		end

		body.cx = position.current.x + body.offset_x
		body.cy = position.current.y + body.offset_y


    end
end

function PhysicsSystem:requires()
    return {"PositionComponent","SpeedComponent","StateComponent","BodyComponent"}
end