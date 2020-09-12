Bandeira = Entity:extend()

function Bandeira:new(x, y)
    Bandeira.super.new(self, x, y, "imagens/bandeira.png")
end