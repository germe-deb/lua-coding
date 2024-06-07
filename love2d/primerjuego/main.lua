-- My first attempt to make a game in lua
-- and
-- my first attempt to make a rhythm game

-- configuration
local songpath = "songs/datte_princess_damon_mitchiem.ogg"
local donpath = "songs/don.wav"

-- keyboard keys
-- player moving
local keyUp = "l"
local keyLeft = "s"
local keyRight = "n"
local keyDown = "h"
local keystartsong = "space"
-- rhythm keys
local keytriangulo = "u"
local keycuadrado = "a"
local keycirculo = "o"
local keyequis = "e"

-- variables
local restarttimer = false
local songstarted = false

function love.load()
    -- player = {x = 200, y = 200, m = 2}
    -- player.sprite = love.graphics.newImage("sprites/suse.png")
    songsource = love.audio.newSource(songpath, "static")
    donsound = love.audio.newSource(donpath, "static")

	-- song things
    lastbeat = 0
    lastbeat2 = 0
    bpm = 134 -- still being inaccurate, I don't know why :(
    crotchet = 60 / bpm
    offset = 72
    -- Conductor (https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/)
    conductor = {}
    conductor.beatoffset = - 6
end

function love.update(dt)
    -- some parts of the conductor has to be in the function update
    conductor.songposition = songsource:tell("seconds") + (offset * 0.001)
    conductor.beatposition = conductor.songposition * crotchet * 10
	
    -- song start!
    if love.keyboard.isDown(keystartsong) and not songstarted then
        restarttimer = true
        songstarted = true
    end
    if restarttimer and songstarted then
        restarttimer = false
        love.audio.play(songsource)
    end

	if conductor.songposition > (lastbeat + crotchet) then
		lastbeat = lastbeat + crotchet
		-- sounds()
	end
	-- attempt to make the same thing up there but at dobule the velocity
	if conductor.songposition > (lastbeat2 + (crotchet/2)) then
		lastbeat2 = lastbeat2 + (crotchet/2)
		sounds()
	end

    -- key to exit the program
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function sounds()

	love.audio.stop(donsound)
	love.audio.play(donsound)
	
end

function love.draw()
    -- draw a simple debug menu..
    -- begins here
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("this is an interface", 10, 10, 0, 2, 2)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10+25*1, 0, 2, 2)

    -- calculate the time elapsed, according to https://love2d.org/wiki/love.timer.getTime
    if songstarted then
    	-- imprime en pantalla el tiempo de la canción
        love.graphics.print("song time (seg): " .. conductor.songposition , 10, 10+25*4, 0, 2, 2)
		
		-- love.graphics.print("current beat: " .. math.floor(conductor.beatposition*10)/10 , 10, 10+25*5, 0, 2, 2)
        -- love.graphics.print(string.format("C.B: %d beat: %s", conductor.conjuntodebeats, conductor.beattempo + 1), 10, 10+25*6, 0, 2, 2)
    end
    -- exit message
    love.graphics.print("press ESCAPE to exit. press SPACE to start the song.", 10, 10+25*2, 0, 2, 2)

	love.graphics.print("bpm: " .. bpm , 10, 10+25*7, 0, 2, 2)
	love.graphics.print("crotchet: " .. crotchet , 10, 10+25*8, 0, 2, 2)
	love.graphics.print("lastbeat: " .. lastbeat , 10, 10+25*9, 0, 2, 2)
	
    -- debug menu ends here


    -- begin game interface
    -- draw some boxes every 8 beats.
    local squarepos = {y = 400} -- the position on the screen on that the boxes will show up
    squarepos.startx = 250
    squarepos.starty = 500
    squarepos.padding = 32
    squarepos.x1 = squarepos.startx + squarepos.padding*0
    squarepos.x2 = squarepos.startx + squarepos.padding*1
    squarepos.x3 = squarepos.startx + squarepos.padding*2
    squarepos.x4 = squarepos.startx + squarepos.padding*3
    squarepos.y1 = squarepos.starty
    squarepos.y2 = squarepos.starty
    squarepos.y3 = squarepos.starty
    squarepos.y4 = squarepos.starty

	-- draw a square
	local colorused = (lastbeat - conductor.songposition)*2 + 1
	love.graphics.setColor(colorused, colorused, colorused, colorused)
	love.graphics.polygon("fill", 0+squarepos.x1,0+squarepos.y1,30+squarepos.x1, 0+squarepos.y1,30+squarepos.x1, 30+squarepos.y1,0+squarepos.x1, 30+squarepos.y1)

    -- dobule
	local colorused = (lastbeat2 - conductor.songposition)*4 + 1
	love.graphics.setColor(colorused, colorused, colorused, colorused)
	love.graphics.polygon("fill", 0+squarepos.x2,0+squarepos.y2,30+squarepos.x2, 0+squarepos.y2,30+squarepos.x2, 30+squarepos.y2,0+squarepos.x2, 30+squarepos.y2)

end
