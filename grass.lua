Grass = Entity:extend()

function Grass:new(x,y)
    Grass.super.new(self, x, y, "imagens/grass.png", 1)
    self.strength = 100
    self.weight = 0
end