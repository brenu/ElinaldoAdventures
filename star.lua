Star = Entity:extend()

function Star:new(x,y)
	Star.super.new(self,x,y,"imagens/star.png")
	self.weight = 0
end

function Star:update(dt)
	if self.last.x == 5000 then
		self.x = 5000
	end
end