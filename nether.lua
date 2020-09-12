Nether = Entity:extend()

function Nether:new(x,y)
    Nether.super.new(self,x,y,"imagens/nether.png",1)
    self.strength = 100
    self.weight = 0
end