require("lib/lovetoys/lib/middleclass")
require "vec2"
require "math"

AABB = class("AABB")

function AABB:initialize(center,halfSize)
    self.center = center or Vec2.new()
    self.halfSize = halfSize or Vec2.new()
end

function AABB:Overlaps(other)
    if ( math.abs(self.center.x - other.center.x) > self.halfSize.x + other.halfSize.x ) then
    	return false
    end
    if ( math.abs(self.center.y - other.center.y) > self.halfSize.y + other.halfSize.y ) then 
    	return false
    end
    return true
end