Game = Object:extend()

function Game:new()
    collectgarbage("stop")
    contaBonus = 0
    perdeu = 0
    fim = 0
    pontuou = 0
    aumentouVida = 0
    variaConfete = 1
    estadoConfete = "descendo"
    yConfete = -150

    if fase == 7 then
        fundoFinal = love.graphics.newImage("imagens/endBackground.png")
        hospital = love.graphics.newImage("imagens/hospital.png")
        confete = love.graphics.newImage("imagens/confete.png")
    end
--Create the walls table
    ---- ADD THIS
    walls = {}
    -------------
    if fase == 1 then
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
    elseif fase == 2 then
        mapTwo = {
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
        }
    elseif fase == 3 then
        mapThree = {
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
            {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
        }
    elseif fase == 4 then
        mapFour = {
            {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {2,0,0,0,0,0,0,0,0,0,0,3,0,0,0,3},
            {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2},
            {2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2},
            {2,0,0,0,0,0,0,0,0,0,0,0,0,0,3,2},
            {2,0,0,0,0,0,0,0,0,0,0,3,3,3,2,2},
            {2,0,0,0,0,0,0,0,0,0,3,2,2,2,2,2},
            {2,0,0,0,0,0,3,3,3,3,2,2,2,2,2,2},
            {2,0,0,0,0,3,2,2,2,2,2,2,2,2,2,2},
            {2,0,0,0,3,2,2,2,2,2,2,2,2,2,2,2},
            {2,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2}
        }
    elseif fase == 5 then
        mapFive = {
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1},
            {1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1}
        }
    elseif fase == 6 then
        mapSix = {
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
            {5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5}
        }
    elseif fase == 7 then
        mapSeven = {
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
            {6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6}
        }
    end
    
    if fase == 1 then
        player = Player(100, 450)
        box = Box(450, 350)
    end
    if fase == 1 then
        player = Player(100, 450)
        mapa = map
        estrela1 = Star(60,70)
        estrela2 = Star(60,370)
        estrela3 = Star(60,520)
        bandeira = Bandeira(750,100)
    elseif fase == 2 then
        player = Player(100, 450)
        mapa = mapTwo
        estrela1 = Star(60,110)
        estrela2 = Star(750,-30)
        estrela3 = Star(60,520)
        bandeira = Bandeira(750,50)
    elseif fase == 3 then
        player = Player(100, 450)
        mapa = mapThree
        inimigo = Inimigo(250,505)
        estrela1 = Star(60,310)
        estrela2 = Star(60,520)
        estrela3 = Star(710,520)
        bandeira = Bandeira(750,300)
    elseif fase == 4 then
        player = Player(100, 450)
        mapa = mapFour
        estrela1 = Star(300,360)
        estrela2 = Star(60,520)
        estrela3 = Star(710,100)
        bandeira = Bandeira(750,0)
    elseif fase == 5 then
        player = Player(3, 250)
        mapa = mapFive
        estrela1 = Star(60,160)
        estrela2 = Star(400,300)
        estrela3 = Star(610,460)
        bandeira = Bandeira(750,400)
    elseif fase == 6 then
        player = Player(100, 450)
        mapa = mapSix
        inimigo1 = Inimigo(250,505)
        inimigo2 = Inimigo(500,505)
        estrela1 = Star(300,360)
        estrela2 = Star(60,520)
        estrela3 = Star(760,-30)
        bandeira = Bandeira(750,450)
    elseif fase == 7 then
        player = Player(100, 450)
        mapa = mapSeven
        inimigo = Inimigo(350,505)
        estrela1 = Star(300,360)
        estrela2 = Star(450,360)
        estrela3 = Star(760,360)
        bandeira = Bandeira(2000,450)
    end

    for i,v in ipairs(mapa) do
        for j,w in ipairs(v) do
            if w == 1 then
                -- Add all the walls to the walls table instead.
                ---- CHANGE THIS
                table.insert(walls, Wall((j-1)*50, (i-1)*50))
                -------------
            elseif w == 2 then
                table.insert(walls, Dirt((j-1)*50,(i-1)*50))
            elseif w == 3 then
                table.insert(walls, Grass((j-1)*50,(i-1)*50))
            elseif w == 5 then
                table.insert(walls, Nether((j-1)*50,(i-1)*50))
            elseif w == 6 then
                table.insert(walls, EndBlock((j-1)*50,(i-1)*50))
            end
        end
    end

    objects = {}
    table.insert(objects,estrela1)
    table.insert(objects,estrela2)
    table.insert(objects,estrela3)
    table.insert(objects, player)    
    table.insert(objects,bandeira)
    if fase == 1 then
        table.insert(objects, box)
    elseif fase == 3 then
        table.insert(objects,inimigo)
    elseif fase == 6 then
        table.insert(objects,inimigo1)
        table.insert(objects,inimigo2)
    elseif fase == 7 then
        table.insert(objects,inimigo)
    end
end

function Game:update(dt)
   -- if fase ~= 7 and not love.audio.play(tema) then 
   --     love.audio.rewind(tema)
    --elseif fase == 7 and not love.audio.play(temaFinal) then 
  --      love.audio.rewind(temaFinal) 
    --end
    if perdeu <  1 then
        if fim ~= 1 then tempo = tempo + 1*dt end
        if contaBonus > 0 then
            contaBonus = contaBonus - dt
            player.pula = -355
        else
            player.pula = -250
            contaBonus = 0
        end

        if fase ~= 7 then
            for i,v in ipairs(objects) do
                v:update(dt)
            end
        else
            for i,v in ipairs(objects) do
                if not v:is(Bandeira) then
                    v:update(dt)
                elseif inimigo.x > 3000 then
                    v.x = 350
                    v:update(dt)
                end
            end
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
            if fim == 1 then
                love.audio.stop(temaFinal)
                love.audio.play(temaZerou)
		    	if arquivoExiste("recordes.txt") then
					if contaLinhas("recordes.txt") <= 4 and pontuou == 0 then
						verificaRecordes("recordes.txt",math.ceil(tempo))
						pontuou = 1
					end
		    	elseif pontuou == 0 then
		    		aux = io.open("recordes.txt","w")
		    		aux:write(math.ceil(tempo))
		    		aux:close()
		    		pontuou = 1
                end
                if variaConfete >= 1 then
                    estadoConfete = "descendo"
                elseif variaConfete <= 0.8 then
                    estadoConfete = "subindo"
                end
                if estadoConfete == "subindo" then
                    variaConfete = variaConfete + 0.08*dt
                    yConfete = yConfete + 10*dt
                elseif estadoConfete == "descendo" then
                    variaConfete = variaConfete - 0.08*dt
                    yConfete = yConfete - 10*dt
                end
            end
        end
        if aumentouVida == 0 and estrela1.x >= 4900 and estrela2.x >= 4900 and estrela3.x >= 4900 then
            vida = vida + 1
            aumentouVida = 1
        end
    end
    collectgarbage("restart")
end

function love.keypressed(key)
    -- Let the player jump when the up-key is pressed
    if key == "up" then
        player:jump()
        if menu ~= nil and game == nil then
        	opcao = opcao - 1
        end
    elseif key == "down" then
    	if menu ~= nil and game == nil then
    		opcao = opcao + 1
    	end
    elseif key == "escape" then
        love.event.quit()
    elseif key == "return" then
        love.audio.stop(stMenu)
        love.audio.stop(stAnimada)
        love.audio.stop(tema)
        love.audio.stop(temaFinal)
        love.audio.stop(temaZerou)
        if ranking ~= nil and escolha == 3 then
            cont = #objects
            for i,v in ipairs(objects) do objects[i] = nil end
            cont = #map
            for i,v in ipairs(map) do map[i] = nil end
            cont = #walls
            for i,v in ipairs(walls) do walls[i] = nil end
	   		escolha = 0
	   		love.load()
        elseif game ~= nil and escolha == 1 then
            cont = #objects
            for i,v in ipairs(objects) do objects[i] = nil end
            cont = #map
            for i,v in ipairs(map) do map[i] = nil end
            cont = #walls
            for i,v in ipairs(walls) do walls[i] = nil end
            fase = 1
            vida = 3
	        escolha = 0
	        love.load()
        elseif menu ~= nil then
            cont = #objects
            for i,v in ipairs(objects) do objects[i] = nil end
            cont = #map
            for i,v in ipairs(map) do map[i] = nil end
            cont = #walls
            for i,v in ipairs(walls) do walls[i] = nil end
            if opcao == 1 then
	    		escolha = 1
	    		love.load()
	    	elseif opcao == 2 then
	    		escolha = 2
	    		love.load()
	    	elseif opcao == 3 then
	    		escolha = 3
	    		love.load()
	    	elseif opcao == 4 then
	    		love.event.quit()
            end    
        else
            love.load()
        end
    elseif key == "=" then
        if(volume<1.0) then
            volume = volume + 0.2
        end 
        passou:setVolume(volume)
        somZerou:setVolume(volume)
        somPerdeu:setVolume(volume)
        somMatou:setVolume(volume)
        somCheck:setVolume(volume)
        somPunch:setVolume(volume)
        stMenu:setVolume(volume)
        stAnimada:setVolume(volume)
        tema:setVolume(volume)
        temaFinal:setVolume(volume)
        temaZerou:setVolume(volume)
        passos:setVolume(volume)
        salto:setVolume(volume)
    elseif key == "-" then
        if(volume>0) then
            volume = volume - 0.2
            if volume == 0 then
                volume = 0.01
            end
        end 
        passou:setVolume(volume)
        somZerou:setVolume(volume)
        somPerdeu:setVolume(volume)
        somMatou:setVolume(volume)
        somCheck:setVolume(volume)
        somPunch:setVolume(volume)
        stMenu:setVolume(volume)
        stAnimada:setVolume(volume)
        tema:setVolume(volume)
        temaFinal:setVolume(volume)
        temaZerou:setVolume(volume)
        passos:setVolume(volume)
        salto:setVolume(volume) 
    elseif key == "f" then
        if perdeu >= 1 and vida > 3 then
            vida = vida - 3
            love.load()
        end
    end
end

function Game:draw()
    if fase ~= 6 then
        love.graphics.setBackgroundColor(52/255, 189/255, 235/255)
        if fase == 7 then
            love.graphics.draw(fundoFinal,0,0)
        elseif fim == 1 then
            love.graphics.setBackgroundColor(0,0,0)
        end
    else
        love.graphics.setBackgroundColor(69/255, 11/255, 7/255)
    end
    if perdeu >= 1 then
        if perdeu == 1 then
            love.audio.play(somPerdeu)
            perdeu = perdeu+1
        end
            love.graphics.print("Perdeu",love.graphics.getWidth()/2-50,love.graphics.getHeight()/2-7)
        if vida > 3 then
            love.graphics.print("Aperte F para tentar novamente",love.graphics.getWidth()/2-225,love.graphics.getHeight()/2+20)
        end
    end
    
    --Desenhando o hospital
    if fase == 7 and inimigo.x >= 3000 then
        love.graphics.draw(hospital,370,495,0,0.11,0.11)
    end

    if fase ~= 7 then
        for i,v in ipairs(objects) do
            v:draw()
        end
    else
        for i,v in ipairs(objects) do
            if not v:is(Bandeira) then
                v:draw()
            elseif inimigo.x > 3000 then
                v:draw()
            end
        end
    end

    -- Draw the walls
    ---- ADD THIS
    for i,v in ipairs(walls) do
        v:draw()
    end
    -------------

    if fim == 1 then
        love.graphics.draw(confete,-135,yConfete,0,1,variaConfete)
        love.graphics.setColor(0,0,0,0.7)
        love.graphics.rectangle("fill",240,220,330,140)
        love.graphics.setColor(1,1,1,1)
        love.graphics.print("parabens",love.graphics.getWidth()/2-60,love.graphics.getHeight()/2-60)
        love.graphics.print("liz chegou ao hospital",love.graphics.getWidth()/2-150,love.graphics.getHeight()/2-40)
        love.graphics.print("seu tempo",love.graphics.getWidth()/2-70,love.graphics.getHeight()/2)
        love.graphics.print(math.ceil(tempo).." segundos",love.graphics.getWidth()/2-77,love.graphics.getHeight()/2+20)
    end

    if contaBonus > 0 then
        love.graphics.setColor(50/255,50/255,50/255,0.3)
        love.graphics.rectangle("fill",love.graphics.getWidth()/2-10,13,45,30)
        love.graphics.setColor(1,1,1)
        love.graphics.print(math.ceil(contaBonus),love.graphics.getWidth()/2,20)
    end
    if fim ~= 1 then
        love.graphics.setColor(0.2,0.2,0.2,0.3)
        love.graphics.rectangle("fill",100,13,200,30)
        love.graphics.setColor(1,1,1)
        love.graphics.print("tempo "..math.ceil(tempo),110,20)
    end
end

function contaLinhas(arq)
	if not arquivoExiste(arq) then return {} end
	local numero = 0
	for linhas in io.lines(arq) do
		numero = numero + 1
	end
	return numero
end

function verificaRecordes(arq, pontos)
	if not arquivoExiste(arq) then return {} end
	linhas = {}
	for linha in io.lines(arq) do 
	linhas[#linhas + 1] = linha
	end
	for i = 1,#linhas,1 do
		linhas[i] = tonumber(linhas[i])
	end
	linhas[#linhas + 1] = pontos
	table.sort(linhas)
	aux = io.open(arq,"w")
	if #linhas >= 4 then
		for i = 1,4,1 do
			aux:write(linhas[i].."\n")
		end
	else
		for i = 1,#linhas,1 do
			aux:write(linhas[i].."\n")
		end
	end
	  aux:close()
end