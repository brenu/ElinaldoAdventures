tempo = 0
escolha = 0
fim = 0
perdeu = 0
fase = 0
vida = 3
tema = love.audio.newSource("sons/tema.mp3","stream")
temaFinal = love.audio.newSource("sons/tema_final.mp3","stream")
volume = 1

function love.load()
    Object = require "classic"
    require "game"
    require "tutorial"
	  require "entity"
    require "player"
    require "wall"
    require "dirt"
    require "grass"
    require "nether"
    require "endblock"
    require "box"
    require "star"
    require "bandeira"
    require "inimigo"
    require "menu"
    require "ranking"
    love.window.setTitle("Elinaldo Adventures")
    fonte = love.graphics.newFont("8bit.TTF", 16)
    love.graphics.setFont(fonte)
    passou = love.audio.newSource("sons/passou.mp3", "static")
    somZerou = love.audio.newSource("sons/baby_zerou.mp3","static")
    somPerdeu = love.audio.newSource("sons/perdeu.mp3","static")
    somMatou = love.audio.newSource("sons/matou.ogg","static")
    somCheck = love.audio.newSource("sons/check.ogg","static")
    somPunch = love.audio.newSource("sons/punch.ogg","static")
    stMenu = love.audio.newSource("sons/menu.mp3","stream")
    stAnimada = love.audio.newSource("sons/tutoranking.mp3","stream")
    passos = love.audio.newSource("sons/passos.ogg","static")
    salto = love.audio.newSource("sons/yah.ogg","static")
    temaZerou = love.audio.newSource("sons/zerou.mp3","stream")
    if volume >= 0.20 then
      stAnimada:setVolume(volume-0.11)
      passou:setVolume(volume)
      somZerou:setVolume(volume)
      somPerdeu:setVolume(volume)
      somMatou:setVolume(volume)
      somCheck:setVolume(volume)
      somPunch:setVolume(volume)
      passos:setVolume(volume)
      salto:setVolume(volume)
      tema:setVolume(volume)
      temaFinal:setVolume(volume) 
      temaZerou:setVolume(volume)
    else
      stAnimada:setVolume(0)
      passou:setVolume(0)
      somZerou:setVolume(0)
      somPerdeu:setVolume(0)
      somMatou:setVolume(0)
      somCheck:setVolume(0)
      somPunch:setVolume(0)
      passos:setVolume(0)
      salto:setVolume(0)
      tema:setVolume(0)
      temaFinal:setVolume(0) 
      temaZerou:setVolume(0)
    end
    menu = nil
    game = nil
    tutorial = nil
    ranking = nil
    if escolha == 0 then
      love.audio.play(stMenu)
      if volume > 0.2 then  
        stMenu:setVolume(volume)
      else
        stMenu:setVolume(0)
      end
    	menu = Menu()
    elseif escolha == 1 then
      if fase == 7 then
        love.audio.stop(tema)
        love.audio.play(temaFinal)
      else
        love.audio.play(tema) 
      end
        game = Game()
	elseif escolha == 2 then
      love.audio.play(stAnimada)
    	tutorial = Tutorial()
   	elseif escolha == 3 then
      love.audio.play(stAnimada)
   		ranking = Ranking()
   	end
    if fase == 1 then tempo = 0 end
end

function love.update(dt)
	if escolha == 0 then
		menu:update(dt)
	elseif escolha == 1 then
		game:update(dt)
	elseif escolha == 2 then
		tutorial:update(dt)
	elseif escolha == 3 then
		ranking:update(dt)
	end
end


function love.draw()
	if escolha == 0 then
		menu:draw()
	elseif escolha == 1 then
		game:draw()
	elseif escolha == 2 then
		tutorial:draw()
	elseif escolha == 3 then
		ranking:draw()
	end
end

function arquivoExiste(arq)
  local f = io.open(arq, "r")
  if f then f:close() end
  return f ~= nil
end
