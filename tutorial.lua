Tutorial = Object:extend()

function Tutorial:new()
    contaBonus = 0
    perdeu = 0
    fim = 0
    seta = love.graphics.newImage("imagens/seta.png")
    etapa = 0
    tutoTempo = 0
    tocou = 0
    variacao = 0.1
    estadoSeta = "subindo"

    walls = {}

    map = {
        {1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0},
        {1,0,1,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }

    player = Player(100, 430)
    box = Box(450, 350)
    mapa = map
    estrela1 = Star(60,70)
    estrela2 = Star(60,370)
    estrela3 = Star(60,520)
    bandeira = Bandeira(750,100)

    for i,v in ipairs(mapa) do
        for j,w in ipairs(v) do
            if w == 1 then
                -- Add all the walls to the walls table instead.
                ---- CHANGE THIS
                table.insert(walls, Wall((j-1)*50, (i-1)*50))
                -------------
            end
        end
    end

    objects = {}
    table.insert(objects,estrela1)
    table.insert(objects,estrela2)
    table.insert(objects,estrela3)
    table.insert(objects, player)    
    table.insert(objects,bandeira)
   	table.insert(objects, box)


end

function Tutorial:update(dt)
	tutoTempo = tutoTempo + 1*dt
	if tutoTempo >= 3 then
		if etapa < 2 then
			tutoTempo = 0
			etapa = etapa + 1
		elseif etapa == 3 then
			if tutoTempo >= 6 then
				tutoTempo = 0
				etapa = etapa + 1
			end
		elseif etapa >= 5 then
			tutoTempo = 0
			etapa = etapa + 1
		end
	end
	tempo = tempo + 1*dt

	-- Variação do tamanho das setas :) ---
	if variacao >= 0.12 then
		estadoSeta = "descendo"
	elseif variacao <= 0.1 then
		estadoSeta = "subindo"
	end
	if estadoSeta == "subindo" then
		variacao = variacao + 0.035*dt
	elseif estadoSeta == "descendo" then
		variacao = variacao - 0.035*dt
	end

	---------------------------------------
	if contaBonus > 0 then
        contaBonus = contaBonus - dt
        player.pula = -355
    else
        player.pula = -250
        contaBonus = 0
    end

    for i,v in ipairs(objects) do
        v:update(dt)
    end

    -- Update the walls
    ---- ADD THIS
    for i,v in ipairs(walls) do
        v:update(dt)
    end
    -------------

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
    if etapa == 0 or etapa == 1 then
    	player.x = player.xAnterior
		player.quadrosTotal = 5
		love.audio.stop(passos)
        for i=1, player.quadrosTotal do
            player.quadros[i] = love.graphics.newImage("sprites/eli_walk_dir_i"..i..".png")
        end
        player.canJump = false
    elseif etapa == 2 then
    	player.canJump = false
    elseif etapa >= 999999 then
    	escolha = 0
    	love.load()
    end
    if etapa == 2 and estrela3.x >= 4900 then
    	tutoTempo = 0
    	etapa = etapa + 1
    end
end

function Tutorial:draw()
	love.graphics.setBackgroundColor(52/255, 189/255, 235/255)
 	for i,v in ipairs(objects) do
        v:draw()
    end

    -- Draw the walls
    ---- ADD THIS
    for i,v in ipairs(walls) do
        v:draw()
    end
 	if contaBonus > 0 then
        love.graphics.setColor(50/255,50/255,50/255,0.3)
        love.graphics.rectangle("fill",love.graphics.getWidth()/2-10,13,45,30)
        love.graphics.setColor(1,1,1)
        love.graphics.print(math.ceil(contaBonus),love.graphics.getWidth()/2,20)
    end
	love.graphics.setColor(0.2,0.2,0.2,0.3)
    love.graphics.rectangle("fill",100,13,200,30)
    love.graphics.setColor(1,1,1)
    love.graphics.print("tempo "..math.ceil(tempo),110,20)
    if etapa == 0 then
   		love.graphics.print("bem vindo ao game",love.graphics.getWidth()/2-125,love.graphics.getHeight()/2)
   	elseif etapa == 1 then
   		love.graphics.print("nele tu controlas elinaldo",love.graphics.getWidth()/2-200,love.graphics.getHeight()/2)
   	elseif etapa == 2 then
   		love.graphics.print("pegue a estrela",love.graphics.getWidth()/2-110,love.graphics.getHeight()/2)
   		love.graphics.draw(seta,130,470,90,variacao,variacao)
   	elseif etapa == 3 then
   		love.graphics.print("agora podes pular mais alto por esse tempo",love.graphics.getWidth()/2-305,love.graphics.getHeight()/2)
   		love.graphics.draw(seta,320,70,37,variacao,variacao)
   	elseif etapa == 4 then
   		contaBonus = 99
		love.graphics.print("tu podes mover os blocos verdes",love.graphics.getWidth()/2-230,love.graphics.getHeight()/2+180)
 	elseif etapa == 5 then
 		contaBonus = 0
 		love.graphics.print("se cumprires todas as tarefas",love.graphics.getWidth()/2-205,love.graphics.getHeight()/2+180)
 	elseif etapa == 6 then
 		love.graphics.print("deves ir para a bandeira",love.graphics.getWidth()/2-170,love.graphics.getHeight()/2+180)
		love.graphics.draw(seta,680,100,0.2,variacao,variacao)
 	elseif etapa == 7 then
 		love.graphics.print("vamos ver se aprendeu",love.graphics.getWidth()/2-160,love.graphics.getHeight()/2+180)
     else
        love.audio.stop(stAnimada)
 		escolha = 1
 		love.load()
 	end

end