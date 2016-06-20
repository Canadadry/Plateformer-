TileMapDisplaySystem = class("TileMapDisplaySystem", System)

TileColor = {
	{0,0,0},
	{255,255,255},
}

function TileMapDisplaySystem:draw()
    for index, entity in pairs(self.targets) do
        local position = entity:get("PositionComponent").current
        local tilemap  = entity:get("TileMapComponent")
		for y=0, tilemap.h-1 do
        	for x=0, tilemap.w-1 do
		        love.graphics.setColor(self.getTileColor(tilemap,x,y))
		    	love.graphics.rectangle("fill", position.x+x*tilemap.tw, position.y+y*tilemap.th, tilemap.tw, tilemap.th)
		    end
		end
    end
end

function TileMapDisplaySystem:requires()
    return {"PositionComponent", "TileMapComponent"}
end 

function TileMapDisplaySystem.getTileColor(tilemap,x,y)
	local tile = tilemap.map[x+tilemap.w*y+1]+1
	return TileColor[tile] or {255,0,0}
end 
