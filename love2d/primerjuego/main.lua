

-- configuration
local songpath = "songs/datte_princess_damon_mitchiem.ogg"

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
    player = {x = 200, y = 200, m = 2}
    player.sprite = love.graphics.newImage("sprites/suse.png")
    songsource = love.audio.newSource(songpath, "stream")

    -- Conductor (https://www.reddit.com/r/gamedev/comments/2fxvk4/heres_a_quick_and_dirty_guide_i_just_wrote_how_to/)
    lastbeat = 0
    bpm = 134
    crotchet = 60 / bpm
    offset = 0
    conductor = {}
end

function love.update(dt)

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

    -- song start!
    if love.keyboard.isDown(keystartsong) and not songstarted then
        restarttimer = true
        songstarted = true
    end

    if restarttimer and songstarted then
        timerstart = love.timer.getTime()
        restarttimer = false
        love.audio.play(songsource)
    end

    -- conductor has to be in the function update
    conductor.songposition = songsource:tell("seconds") - offset
    conductor.beatposition = conductor.songposition * crotchet * 10

    -- key to exit the program
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

end

function love.draw()
    
    -- draw a simple debug menu..
    -- begins here
    love.graphics.draw(player.sprite, player.x, player.y)
    love.graphics.print("this is an interface", 10, 10, 0, 2, 2)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10+25*1, 0, 2, 2)
    --love.graphics.circle("fill", player.x, player.y, 50)

    -- calculate the time elapsed, according to https://love2d.org/wiki/love.timer.getTime
    if songstarted then
        local resultminute = math.floor((love.timer.getTime() - timerstart) / 60)
        local resultseconds = math.floor((love.timer.getTime() - timerstart) % 60 )

        love.graphics.print(string.format("time elapsed: %d:%02d", resultminute, resultseconds),
        10, 10+25*3, 0, 2, 2)
        love.graphics.print("song time (seg): " .. conductor.songposition , 10, 10+25*4, 0, 2, 2)
        love.graphics.print("current beat: " .. math.floor(conductor.beatposition*10)/10 , 10, 10+25*5, 0, 2, 2)
    end
    -- exit message
    love.graphics.print("press ESCAPE to exit. press SPACE to start the song.", 10, 10+25*2, 0, 2, 2)
    -- debug menu ends here

    -- begin game interface
    
    -- draw some boxes every 8 beats.
    local boxoffset = -1 -- sets the number of boxes (song) to discard at the start
    local boxesstartposition = {x = 400, y = 400} -- the position on the screen on that the boxes will show up
    love.graphics.polygon("fill", 0+boxesstartposition.x, 0+boxesstartposition.y,
                                30+boxesstartposition.x, 0+boxesstartposition.y,
                                30+boxesstartposition.x, 30+boxesstartposition.y,
                                0+boxesstartposition.x, 30+boxesstartposition.y)

end