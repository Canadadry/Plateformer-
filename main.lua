-- Lib and Helper
require("lib/lovetoys/lovetoys")
require("systems/TileDisplaySystem")
require("systems/TileMapDisplaySystem")
require("systems/PhysicsSystem")
require("systems/InputSystem")
require("systems/StateSystem")
require("utils/Vec2")


PositionComponent  = Component.create("PositionComponent",{"current","old"})
BodyComponent      = Component.create("BodyComponent",{"cx","cy","half_w","half_h","offset_x","offset_y"},{25,25,50,50,0,0})
SpeedComponent     = Component.create("SpeedComponent",{"current","old"},{0})
SpriteComponent    = Component.create("SpriteComponent",{"texture"})
TouchableComponent = Component.create("TouchableComponent",{"width","height","name"},{50,50,"default"})
TileComponent      = Component.create("TileComponent",{"color","w","h"},{{255,0,0},50,50})
TileMapComponent   = Component.create("TileMapComponent",{"map","w","h","tw","th"},{nil,0,0,50,50})
InputComponent     = Component.create("InputComponent",{"l_button","r_button","d_button","j_button","GoLeft","GoRight","GoDown","Jump"})
StateComponent     = Component.create("StateComponent",{
                                            "current", --  Stand,Walk,Jump,GrabLedge,
                                            "pushedRightWall",
                                            "pushesRightWall",
                                            "pushedLeftWall",
                                            "pushesLeftWall",
                                            "wasOnGround",
                                            "onGround",
                                            "wasAtCeiling",
                                            "atCeiling"})

function love.load()
    
    engine = Engine()
    engine:addSystem(TileDisplaySystem())
    physicSystem = PhysicsSystem()
    engine:addSystem(physicSystem())
    engine:addSystem(StateSystem())
    engine:addSystem(InputSystem())

    local entity = Entity()
    entity:add(PositionComponent(Vec2(100,100),Vec2(100,100)))
    entity:add(BodyComponent(25,25,50,50,0,0))
    entity:add(TileComponent({255,0,0},50,50))
    entity:add(InputComponent("left","right","down","space",false,false,false,false))
    entity:add(SpeedComponent(Vec2(0,0),Vec2(0,0)))
    entity:add(StateComponent("jump",false,false,false,false,false,false,false,false))
    engine:addEntity(entity)

    position = entity:get("PositionComponent")
    speed = entity:get("SpeedComponent")
    state = entity:get("StateComponent")

    local tileMapEntity = Entity()    
    tileMapEntity:add(PositionComponent(Vec2(0,0),Vec2(0,0)))
    tileMapEntity:add(TileMapComponent({1,1,1,1,1,1,1,1,1,1,
                                        1,0,0,0,0,0,0,0,0,1,
                                        1,0,0,0,0,0,0,0,0,1,
                                        1,1,1,1,0,0,0,0,0,1,
                                        1,0,0,0,0,0,0,0,0,1,
                                        1,0,0,0,0,0,0,0,0,1,
                                        1,1,1,1,1,1,1,1,1,1},10,7,50,50))
    engine:addEntity(tileMapEntity)
    physicSystem:setTilemap(tileMapEntity)
end

function love.update(dt)
    engine:update(dt)
end

function love.draw()    
    love.graphics.setColor(255,255,255)
    love.graphics.print("position " .. position.current.y,10,10)
    love.graphics.print("speed " .. speed.current.y,10,30)
    love.graphics.print("state " .. state.current,10,50)

    love.graphics.origin()
    love.graphics.scale(1,-1)
    love.graphics.translate(0,-love.graphics.getHeight())
    engine:draw()
end


