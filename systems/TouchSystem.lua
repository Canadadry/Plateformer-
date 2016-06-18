
function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function inBox(x,y, xbox,ybox,wbox,hbox)
    return checkCollision(x,y,0,0,xbox,ybox,wbox,hbox)
end

Touch = {}

TouchSystem = class("TouchSystem",System)
function TouchSystem:update()
    touches = love.touch.getTouches( )
    for index,entity in pairs(self.targets) do
        local pos = entity:get("PositionComponent")
        local touchC = entity:get("TouchableComponent")
        
        Touch[touchC.name] = false
        for index,touch in pairs(touches) do
            x, y = love.touch.getPosition( touch )
            if inBox(x,y,pos.x,pos.y,touchC.width,touchC.height) then 
                Touch[touchC.name] = true
            end
        end

        -- mouse fallback
        if  love.mouse.isDown( 1 ) then  
            x, y = love.mouse.getPosition( )
            if inBox(x,y,pos.x,pos.y,touchC.width,touchC.height) then 
                Touch[touchC.name] = true
            end
        end
    end
end
    
function TouchSystem:requires()
    return {"PositionComponent","TouchableComponent"}
end
