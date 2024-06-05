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
-- rythm keys
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
    bpm = 134 -- still being inaccurate, I don't know why :(
    crotchet = 60 / bpm
    offset = 0
    -- Conductor (https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/)
    conductor = {}
    conductor.beatoffset = - 6
end

function love.update(dt)
    -- some parts of the conductor has to be in the function update
    conductor.songposition = songsource:tell("seconds") - offset
    conductor.beatposition = conductor.songposition * crotchet * 10
    conductor.beattempo = (conductor.beatposition + conductor.beatoffset) % 4
    conductor.conjuntodebeats = math.floor((conductor.beatposition + conductor.beatoffset) / 4)

    -- song start!
    if love.keyboard.isDown(keystartsong) and not songstarted then
        restarttimer = true
        songstarted = true
    end
    if restarttimer and songstarted then
        restarttimer = false
        love.audio.play(songsource)
    end

    -- key to exit the program
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

	sounds()
	-- movement()
end

function sounds()
	if songstarted then
	    -- draw squares
	    if math.floor(conductor.beattempo) == 0 then
	    love.audio.play(donsound)
	    end
	    if math.floor(conductor.beattempo) == 1 then
	        
	    end
	    if math.floor(conductor.beattempo) == 2 then
		-- love.audio.play(donsound)
	    end
	    if math.floor(conductor.beattempo) == 3 then

	    end
	end
end

function love.draw()
    -- love.graphics.draw(player.sprite, player.x, player.y, 0, 2, 2 )
    
    -- draw a simple debug menu..
    -- begins here
    love.graphics.print("this is an interface", 10, 10, 0, 2, 2)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10+25*1, 0, 2, 2)

    -- calculate the time elapsed, according to https://love2d.org/wiki/love.timer.getTime
    if songstarted then
        -- local resultminute = math.floor((love.timer.getTime() - timerstart) / 60)
        -- local resultseconds = math.floor((love.timer.getTime() - timerstart) % 60 )
        --love.graphics.print(string.format("time elapsed: %d:%02d", resultminute, resultseconds), 10, 10+25*3, 0, 2, 2)
        
        love.graphics.print("song time (seg): " .. conductor.songposition , 10, 10+25*4, 0, 2, 2)
        love.graphics.print("current beat: " .. math.floor(conductor.beatposition*10)/10 , 10, 10+25*5, 0, 2, 2)
        love.graphics.print(string.format("C.B: %d beat: %s", conductor.conjuntodebeats, conductor.beattempo + 1), 10, 10+25*6, 0, 2, 2)
    end
    -- exit message
    love.graphics.print("press ESCAPE to exit. press SPACE to start the song.", 10, 10+25*2, 0, 2, 2)

	love.graphics.print("bpm: " .. bpm , 10, 10+25*7, 0, 2, 2)
	love.graphics.print("crotchet: " .. crotchet , 10, 10+25*8, 0, 2, 2)
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

    if songstarted then
        -- draw squares
        if math.floor(conductor.beattempo) == 0 then
            love.graphics.polygon("fill", 0+squarepos.x1,0+squarepos.y1,30+squarepos.x1, 0+squarepos.y1,30+squarepos.x1, 30+squarepos.y1,0+squarepos.x1, 30+squarepos.y1)
        end
        if math.floor(conductor.beattempo) == 1 then
            love.graphics.polygon("fill", 0+squarepos.x2,0+squarepos.y2,30+squarepos.x2, 0+squarepos.y2,30+squarepos.x2, 30+squarepos.y2,0+squarepos.x2, 30+squarepos.y2)
        end
        if math.floor(conductor.beattempo) == 2 then
            love.graphics.polygon("fill", 0+squarepos.x3,0+squarepos.y3,30+squarepos.x3, 0+squarepos.y3,30+squarepos.x3, 30+squarepos.y3,0+squarepos.x3, 30+squarepos.y3) 
        end
        if math.floor(conductor.beattempo) == 3 then
            love.graphics.polygon("fill", 0+squarepos.x4,0+squarepos.y4,30+squarepos.x4, 0+squarepos.y4,30+squarepos.x4, 30+squarepos.y4,0+squarepos.x4, 30+squarepos.y4)
        end
        
    end
end

function movement()
	-- movement
    if love.keyboard.isDown(keyRight) then
        player.x = player.x + (player.m * 100 *dt)
    end
    if love.keyboard.isDown(keyLeft) then
        player.x = player.x - (player.m * 100 * dt)
    end
    if love.keyboard.isDown(keyUp) then
        player.y = player.y - (player.m * 100 * dt)
    end
    if love.keyboard.isDown(keyDown) then
        player.y = player.y + (player.m * 100 * dt)
    end
end
