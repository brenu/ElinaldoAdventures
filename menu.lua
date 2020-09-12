Menu = Object:extend()

function Menu:new()
    fundo = love.graphics.newImage("imagens/wallpaper.png")
    menuImg = love.graphics.newImage("imagens/menu.png")
    opcao = 1
    fim = 1
    perdeu = 0
    fase = 1

    walls = {}
    objects = {}
    estrelaMenu = {
    	x = 310,
    	y = 220,
    	width = 50,
    	height = 50,
    	img = love.graphics.newImage("sprites/estrelaMenu.png"),
    	quadros = {},
    	quadroAtual = 1,
    	tempo = 0,
    	delay = 0.15
	}
	for frame = 1, 7 do
		estrelaMenu.quadros[frame] = love.graphics.newQuad((frame-1)*estrelaMenu.width,0,
			estrelaMenu.width,estrelaMenu.height,estrelaMenu.img:getDimensions())
	end

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

function Menu:update(dt)
	if opcao == 1 then
		estrelaMenu.x = 310
		estrelaMenu.y = 220
	elseif opcao == 2 then
		estrelaMenu.x = 283
		estrelaMenu.y = 275
	elseif opcao == 3 then
		estrelaMenu.x = 290
		estrelaMenu.y = 335
	else
		if opcao > 3 then
			opcao = 4
			estrelaMenu.x = 323
			estrelaMenu.y = 393
		else
			opcao = 1
		end
	end
	estrelaMenu.tempo = estrelaMenu.tempo+dt
	if estrelaMenu.tempo > estrelaMenu.delay then
		estrelaMenu.tempo = estrelaMenu.tempo - estrelaMenu.delay
		estrelaMenu.quadroAtual = estrelaMenu.quadroAtual + 1
	end
	if estrelaMenu.quadroAtual == 7 then
		estrelaMenu.quadroAtual = 1
	end
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

function Menu:draw()
    love.graphics.draw(fundo,0,0,0,0.5,0.5)
    love.graphics.draw(menuImg,100,0)
    love.graphics.draw(estrelaMenu.img,estrelaMenu.quadros[math.floor(estrelaMenu.quadroAtual)],estrelaMenu.x,estrelaMenu.y,0,0.7,0.7)
	for i,v in ipairs(objects) do
        v:draw()
    end
    for i,v in ipairs(walls) do
        v:draw()
    end
end