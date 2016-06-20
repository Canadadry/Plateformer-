
require("../utils/Vec2")


PhysicsSystem = class("PhysicsSystem",System)

TileType = {
	"empty",
	"block",
	"oneway",
}

function PhysicsSystem:requires()
    return {"PositionComponent","SpeedComponent","StateComponent","BodyComponent"}
end

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



function PhysicsSystem:hasGround(oldPosition, position, speed, out_groundY)


end

function PhysicsSystem:setTilemap(tilemap)
	self.tilemap = tilemap
end

function PhysicsSystem::getMapTileAtPoint(x,y)
    local position = self.tilemap:get("PositionComponent").current
    local tilemap  = self.tilemap:get("TileMapComponent")

    tile_x =  math.floor( (x - position.x + tilemap.tw /2 ) / tilemap.tw + 0.5 )
    tile_y =  math.floor( (y - position.y + tilemap.th /2 ) / tilemap.th + 0.5 )

    return Vec2(tile_x,tile_y)
end

function PhysicsSystem::getMapTileXAtPoint(x)
    local position = self.tilemap:get("PositionComponent").current
    local tilemap  = self.tilemap:get("TileMapComponent")

    return  math.floor( (x - position.x + tilemap.tw /2 ) / tilemap.tw + 0.5 )
end

function PhysicsSystem::getMapTileYAtPoint(y)
    local position = self.tilemap:get("PositionComponent").current
    local tilemap  = self.tilemap:get("TileMapComponent")

    return  math.floor( (y - position.y + tilemap.th /2 ) / tilemap.th + 0.5 )
end

function PhysicsSystem::getMapTilePosition(tileIndexX,tileIndexY)
    local position = self.tilemap:get("PositionComponent").current
    local tilemap  = self.tilemap:get("TileMapComponent")

    return  Vec2(
    		(tileIndexX * tilemap.tw) + position.x,
    		(tileIndexY * tilemap.th) + position.y
    	)
end

function PhysicsSystem::getTileType(x,y)
	local tile = self.tilemap.map[x+self.tilemap.w*y+1]+1
	return TileType[tile] or TileType[1]
end 

function PhysicsSystem::isEmpty(x,y)
	return self:getTileType(x,y) == TileType[1]
end 

function PhysicsSystem::isObstacle(x,y)
	return self:getTileType(x,y) == TileType[2]
end 

function PhysicsSystem::isGround(x,y)
	local type = self:getTileType(x,y)
	return type == TileType[2] or type TileType[3]
end 




 


