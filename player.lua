Player = Entity:extend()
local j = 0

function Player:new(x, y)
    Player.super.new(self, x, y, "sprites/eli_walk_dir_1.png", 5)
    self.strength = 10
    self.pula = -350
    self.quadroAtual = 1
    self.quadrosTotal = 1
    const = 10
    self.xAnterior = x
    self.yAnterior = y
    self.canJump = false
    self.lastPos = "direita"
    self.vidaImg = love.graphics.newImage("imagens/coracao.png")
    self.quadros = {}
    table.insert(self.quadros,love.graphics.newImage("sprites/eli_walk_dir_1.png"))
    self.pulou = false

end

function Player:update(dt)
    Player.super.update(self, dt)
    self.yAnterior = self.y

    self.quadroAtual = self.quadroAtual + const*dt
    if self.quadroAtual > self.quadrosTotal then
        self.quadroAtual = 1
    end
    const = 10
    if love.keyboard.isDown("up") and love.keyboard.isDown("right") and perdeu == 0 and fim == 0 then
        if self.pulou == false and self.canJump then love.audio.play(salto) end
        self.pulou = true
        self.lastPos = "direita"
        self.quadrosTotal = 1
        self.quadros[1] = love.graphics.newImage("sprites/eli_walk_dir_1.png")
    elseif love.keyboard.isDown("up") and love.keyboard.isDown("left") and perdeu == 0 and fim == 0 then
        if self.pulou == false and self.canJump then love.audio.play(salto) end
        self.pulou = true
        self.lastPos = "esquerda"
        self.quadrosTotal = 1
        self.quadros[1] = love.graphics.newImage("sprites/eli_walk_esq_1.png")
    elseif love.keyboard.isDown("right") and perdeu == 0 and fim == 0 then
        self.pulou = false
        love.audio.play(passos)
        self.lastPos = "direita"
        self.quadrosTotal = 5
        for i=1, self.quadrosTotal do
            self.quadros[i] = love.graphics.newImage("sprites/eli_walk_dir_"..i..".png")
        end
    elseif love.keyboard.isDown("left") and perdeu == 0 and fim == 0 then
        self.pulou = false
        love.audio.play(passos)
        self.lastPos = "esquerda"
        self.quadrosTotal = 5
        for i=1, self.quadrosTotal do
            self.quadros[i] = love.graphics.newImage("sprites/eli_walk_esq_"..i..".png")
        end 
    elseif love.keyboard.isDown("up") then
        if self.pulou == false and self.canJump then
            love.audio.play(salto)
            self.pulou = true
        end
    else
        self.pulou = false
        const = 3
        if love.audio.play(passos) then love.audio.stop(passos) end
        if self.lastPos == "direita" then
            self.quadrosTotal = 5
            for i=1, self.quadrosTotal do
                self.quadros[i] = love.graphics.newImage("sprites/eli_walk_dir_i"..i..".png")
            end 
        else
            self.quadrosTotal = 5
            for i=1, self.quadrosTotal do
                self.quadros[i] = love.graphics.newImage("sprites/eli_walk_esq_i"..i..".png")
            end
        end
    end

    if love.keyboard.isDown("left") then
        if perdeu == 0 and fim == 0 then
            self.x = self.x - 200 * dt
        end
    elseif love.keyboard.isDown("right") then
        if perdeu == 0 and fim == 0 then
            self.x = self.x + 200 * dt
        end
    end

    if self.x + 50 >= love.graphics.getWidth() then
        self.x = self.x - 10
    elseif self.x <= 0 then
        self.x = self.x + 10
    end
    if self.y <= -300 then
        self.y = self.y + 10
    elseif self.y > love.graphics.getHeight() then
        perdeu = 1
    end

    if perdeu == 0 and fim == 0 then
        if self.last.y ~= self.y then
            self.canJump = false
        else
            self.canJump = true
        end
    end

    self.y = self.yAnterior
end


function Player:draw()
    love.graphics.draw(self.quadros[math.floor(self.quadroAtual)],self.x,self.y)
    if (escolha == 1 or escolha == 2) and fim == 0 then
        for i=1,vida do
            love.graphics.draw(self.vidaImg,105+j,50)
            j = j + 20
        end
        j = 0
    end
end

function Player:jump()
    if self.canJump then
        self.gravity = self.pula
    end
end

function Player:collide(e, direction)
    Player.super.collide(self, e, direction)
    if direction == "bottom" then
        if perdeu == 0 and fim == 0 then
            self.canJump = true
        end
    end
end

function Player:checkResolve(e, direction)
    if e:is(Box) then
        if tutorial ~= nil and tocou == 0 then
            tutoTempo = 0
            tocou = 1
            etapa = 5
        end
        if direction == "bottom" then
            return true
        elseif direction == "right" or direction == "left" then
            return true
        else
            return false
        end
    elseif e:is(Star) then
        love.audio.play(somCheck)
        contaBonus = contaBonus + 10
        for i in pairs(objects) do
            if objects[i] == e then
                objects[i].last.x = 5000
            end
        end
        return false
    elseif e:is(Bandeira) then
        if estrela1.x >= 4900 and estrela2.x >= 4900 and estrela3.x >= 4900 then
            self.x = self.x - 10
            if fase ~= 7 then
                cont = #objects
                for i,v in ipairs(objects) do objects[i] = nil end
                cont = #map
                for i,v in ipairs(map) do map[i] = nil end
                cont = #walls
                for i,v in ipairs(walls) do walls[i] = nil end
                love.audio.play(passou)
                fase = fase + 1
                love.load()
            else
                self.contaBonus = 0
                love.audio.play(somZerou)
                fim = 1
            end
        end
        return false
    elseif e:is(Inimigo) then
        if direction == "bottom" or self.y + 100 < e.y + 15  then
            love.audio.play(somMatou)
            self.gravity = -50
            self.y = self.y - 15
            e.vida = e.vida - 1
            if e.vida <= 0 then
                e.x = 6000
            end
            return false
        elseif direction == "right" or direction == "left" then
            love.audio.play(somPunch)
            vida = vida - 1
            if direction == "right" then
                self.x = self.x - 50
                if self.x + 50 > love.graphics.getWidth() then self.x = 550 end
                e.tempoMov = 0
            else
                self.x = self.x + 50
                if self.x < 0 then self.x = 0 end
                e.tempoMov = 3
            end
            if vida <= 0 then
                perdeu = 1
            end
            return false
        else
            return false
        end
        return false
    end
    return true
end