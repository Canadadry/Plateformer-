require 'math'
require("lib/lovetoys/lib/middleclass")


Vec2 = class("Vec2")

function Vec2:initialize(x,y)
  self.x = x or 0
  self.y = y or 0
end

function Vec2:add(v)
  self.x = self.x + v.x
  self.y = self.y + v.y
end

function Vec2:sum(v)
  return Vec2(self.x + v.x, self.y + v.y)
end

function Vec2:sub(v)
  self.x = self.x - v.x
  self.y = self.y - v.y
end

function Vec2:diff(v)
  return Vec2(self.x - v.x, self.y - v.y)
end

function Vec2:mult(s)
  self.x = self.x * s
  self.y = self.y * s
end

function Vec2:product(s)
  return Vec2(self.x * s , self.y * s)
end




function Vec2:set(x, y)
  self.x = x
  self.y = y
end

function Vec2:cpy(v)
  self.x = v.x
  self.y = v.y
end

function Vec2:__tostring()
  return 'x = ' .. self.x  .. ', y = ' .. self.y
end

