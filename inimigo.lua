Inimigo = Entity:extend()
local delay = 0.10
local tempo = 0
local tempoMov = 0

function Inimigo:new(x,y)
	Inimigo.super.new(self,x,y,"sprites/inimigo_dir.png")
	if fase == 7 then
		self.spritesDir = love.graphics.newImage("sprites/inimigo_dir_final.png")
		self.spritesEsq = love.graphics.newImage("sprites/inimigo_esq_final.png")
	else
		self.spritesDir = love.graphics.newImage("sprites/inimigo_dir.png")
		self.spritesEsq = love.graphics.newImage("sprites/inimigo_esq.png")		
	end
	self.deslocaX = 0
	self.strength = 10
	self.width = 52.5
	self.height = 44
	self.tempo = 0
	self.delay = 0.10
	self.tempoMov = love.math.random(0,6)
	if fase == 7 then
		self.vida = 30
	else
		self.vida = 1
	end

	for frame = 1, 5 do
		self.quadros[frame] = love.graphics.newQuad((frame-1)*self.width, 90, 
			self.width-1, self.height, self.spritesDir:getDimensions())
	end
end

function Inimigo:update(dt)
	self.tempo = self.tempo+dt
	self.tempoMov = self.tempoMov + dt
	if self.tempo > self.delay then
		self.tempo = self.tempo - self.delay
		self.quadroAtual = self.quadroAtual + 1
	end
	if fase == 7 then
		if self.tempoMov < 3 then
			self.deslocaX = love.math.random(0,350)
		elseif self.tempoMov < 6 then
			self.deslocaX = love.math.random(-350,0)
		else
			self.tempoMov = 0
		end
	else
		if self.tempoMov < 3 then
			self.deslocaX = 50
		elseif self.tempoMov < 6 then
			self.deslocaX = -50
		else
			self.tempoMov = 0
		end
	end
	if self.quadroAtual == 5 then
		self.quadroAtual = 1
	end

	self.x = self.x + self.deslocaX * dt
	if self.x <= 0 then
		self.x = self.x + 10
	elseif self.x + 52 >= love.graphics.getWidth() and self.x < 3000 then
		self.x = self.x - 10
	end
end

function Inimigo:draw()
	if self.tempoMov < 3 then
		love.graphics.draw(self.spritesDir,self.quadros[math.floor(self.quadroAtual)],self.x,self.y)
	else
		love.graphics.draw(self.spritesEsq,self.quadros[math.floor(self.quadroAtual)],self.x,self.y)
	end
end