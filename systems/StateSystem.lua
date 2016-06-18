StateSystem = class("StateSystem",System)

local frameduration = 0.016 -- 60 fps = 16ms per frame
local walkspeed = 160
local jumpspeed = 410
local gravity   = -1000
local maxfallingspeed = -1000
local minjumpspeed = 200


function StateSystem:update()

    for index,entity in pairs(self.targets) do
        local position = entity:get("PositionComponent")
        local speed    = entity:get("SpeedComponent")
        local state    = entity:get("StateComponent")
        local body     = entity:get("BodyComponent")
        local input    = entity:get("InputComponent")

        f = self[state.current]

        if type(f)=="function" then
            f(position,speed,state,body,input)
        end

    end
end

function StateSystem:requires()
    return {"PositionComponent","SpeedComponent","StateComponent","BodyComponent","InputComponent"}
end


function StateSystem.stand(position,speed,state,body,input)
    speed.current.x = 0 
    speed.current.y = 0 

    if state.onGround == false then
        state.current = "jump"
        return
    end

    if input.GoRight ~= input.GoLeft then
        state.current = "walk"
    elseif input.Jump == true then
            print("jump")
            state.current = "jump"
            speed.current.y = jumpspeed;
    end
end

function StateSystem.walk(position,speed,state,body,input)
    if input.GoRight == input.GoLeft then

        state.current = "stand"   
        speed.current.x = 0 
        speed.current.y = 0   

    elseif input.GoRight == true then

        if state.pushesRightWall == true then
            speed.current.x = 0
        else
            speed.current.x = walkspeed
        end   

    elseif input.GoLeft == true then
        
        if state.pushesLeftWall == true then
            speed.current.x = 0
        else
            speed.current.x = -walkspeed
        end    

    end

    if input.Jump == true then

        state.current = "jump"
        speed.current.y = jumpspeed;

    end

    if state.onGround == false then
        state.current = "jump"
        return
    end
end

function StateSystem.jump(position,speed,state,body,input)
    speed.current:add(Vec2(0,gravity*frameduration))

    if  speed.current.y < maxfallingspeed  then
        speed.current.y = maxfallingspeed
    end

    if input.GoRight == input.GoLeft then
        speed.current.x = 0 
    elseif input.GoRight == true then

        if state.pushesRightWall == true then
            speed.current.x = 0
        else
            speed.current.x = walkspeed
        end   

    elseif input.GoLeft == true then
        
        if state.pushesLeftWall == true then
            speed.current.x = 0
        else
            speed.current.x = -walkspeed
        end    

    end

    if input.Jump == false and speed.current.y > 0 then
        speed.current.y = math.min(speed.current.y, minjumpspeed)
    end

    if state.onGround == true then 

        if input.GoRight == input.GoLeft then
            state.current = "stand"   
            speed.current.x = 0 
            speed.current.y = 0  
        else            
            state.current = "walk"  
            speed.current.y = 0 
        end 

    end

end


