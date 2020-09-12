EndBlock = Entity:extend()

function EndBlock:new(x,y)
    EndBlock.super.new(self,x,y,"imagens/end.png",1)
    self.strength = 100
    self.weight = 0
end