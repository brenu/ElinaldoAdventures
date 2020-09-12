Ranking = Object:extend()
local yRecordes = 210

function Ranking:new()
	fundo = love.graphics.newImage("imagens/wallpaper.png")
    rankingImg = love.graphics.newImage("imagens/ranking.png")
    medalhaPrimeiro = love.graphics.newImage("imagens/primeiro.png")
    medalhaSegundo = love.graphics.newImage("imagens/segundo.png")
    medalhaTerceiro = love.graphics.newImage("imagens/terceiro.png")
    opcao = 1
    fim = 1
    perdeu = 0
    recordes = {}
    recordes = getRecordes("recordes.txt")

    walls = {}
    objects = {}

    map = {
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }

    player = Player(375, 445)
    table.insert(objects,player)

    for i,v in ipairs(map) do
        for j,w in ipairs(v) do
            if w == 1 then
                -- Add all the walls to the walls table instead.
                ---- CHANGE THIS
                table.insert(walls, Wall((j-1)*50, (i-1)*50))
                -------------
            end
        end
    end       
end

function Ranking:update(dt)
    yRecordes = 210
	for i,v in ipairs(objects) do
        v:update(dt)
    end
    for i,v in ipairs(walls) do
        v:update(dt)
    end

	local loop = true
    local limit = 0

    while loop do
        loop = false

        limit = limit + 1
        if limit > 100 then
            break
        end

        for i=1,#objects-1 do
            for j=i+1,#objects do
                if objects[i] ~= nil and objects[j] ~= nil then
                    local collision = objects[i]:resolveCollision(objects[j])
                end
                if collision then
                    loop = true
                elseif objects[i] == nil and objects[j] == nil then
                    loop = true
                end
            end
        end

        -- For each object check collision with every wall.
        ---- ADD THIS
        for i,wall in ipairs(walls) do
            for j,object in ipairs(objects) do
                local collision = object:resolveCollision(wall)
                if collision then
                    loop = true
                end
            end
        end
        -------------
    end
end

function Ranking:draw()
    love.graphics.draw(fundo,0,0,0,0.5,0.5)
    love.graphics.draw(rankingImg,100,0)
    love.graphics.setColor(0,0,0,0.2)
    love.graphics.rectangle("fill",305,190,170,210)
    love.graphics.setColor(0,0,0,0.3)
    love.graphics.rectangle("fill",315,200,150,190)
    love.graphics.setColor(1,1,1)
    for i = 1,#recordes do
        love.graphics.print(recordes[i],375,yRecordes)
        yRecordes = yRecordes + 50
    end
    if #recordes >= 1 then
        love.graphics.draw(medalhaPrimeiro,345,208,0,0.65,0.65)
    end
    if #recordes >= 2 then
        love.graphics.draw(medalhaSegundo,345,258,0,0.65,0.65)
    end
    if #recordes >= 3 then
        love.graphics.draw(medalhaTerceiro,345,308,0,0.65,0.65)
    end
    for i,v in ipairs(objects) do
        v:draw()
    end
    for i,v in ipairs(walls) do
        v:draw()
    end
end



function getRecordes(arq)
    if not arquivoExiste(arq) then return {} end
    linhas = {}
    for linha in io.lines(arq) do
        linhas[#linhas + 1] = linha
    end
    return linhas
end