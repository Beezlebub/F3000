--	Formula 3000
--	Made by Beelz

require 'lib.mod.func'
local MENU 		= require 'lib.states.menu'
local PAUSE 	= require 'lib.states.pause'
local GAME 		= require 'lib.states.game'
local OPTIONS 	= require 'lib.states.options'
HINT 		= require 'lib.mod.hint'

states = {}

local active = "menu"
prev = "nil"
_playAudio = true
_showDebug = false

font14 = love.graphics.newFont("lib/mod/HelvetiPixel.ttf", 14)
font20 = love.graphics.newFont("lib/mod/HelvetiPixel.ttf", 20)
font36 = love.graphics.newFont("lib/mod/HelvetiPixel.ttf", 36)
font48 = love.graphics.newFont("lib/mod/HelvetiPixel.ttf", 48)

function love.load()
	states = {
		menu = MENU.init(),
		pause = PAUSE.init(),
		game = GAME.init(),
		options = OPTIONS.init()
	}

	states.game.load()

end

function love.update(dt)
	states[active].update(dt)
end

function love.draw()
	states[active].draw()
end

function love.keypressed(k)
	states[active].keypressed(k)
end

function love.keyreleased(k)
	states[active].keyreleased(k)
end

function love.mousepressed(x, y)
	states[active].mousepressed(x, y)
end

function stateActivate(new)
    states[active].deactivate()
    prev = active
    active = new
    states[active].activate()
end
