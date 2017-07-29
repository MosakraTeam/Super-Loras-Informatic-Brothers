
local composer = require( "composer" )

local scene = composer.newScene()

local physics = require( "physics" )
physics.start()
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local lorasSheetOptions = {
    frames = {
        {   -- 1. loras run 1
            x = 70,
            y = 50,
            width = 70,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
		{   -- 2. loras run 2
            x = 155,
            y = 50,
            width = 70,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
		{   -- 3. loras run 3
            x = 240,
            y = 50,
            width = 70,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
		{   -- 4. loras run 4
            x = 325,
            y = 50,
            width = 70,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        }
    }
}

local lorasSheet = graphics.newImageSheet( "images/Loras.png", lorasSheetOptions )

-- Configure image sequences
local lorasSequences = {
    -- non-consecutive frames sequence
    {
        name = "run",
        frames = { 1,2,3,4 },
        time = 1000,
        loopCount = 0,
        loopDirection = "forward"
    }
}

local trawaSheetOptions = {
    frames = {
        {   -- 1. trawa 1
            x = 692,
            y = 751,
            width = 76,
            height = 77,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        }
    }
}

local guzikSheetOptions = {
    frames = {
        {   -- 1. lewo
            x = 0,
            y = 0,
            width = 100,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 1. prawo
            x = 100,
            y = 0,
            width = 100,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 1. a
            x = 200,
            y = 0,
            width = 100,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 1. b
            x = 300,
            y = 0,
            width = 100,
            height = 100,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        
    }
}

local trawaSheet = graphics.newImageSheet( "images/Ground.png", trawaSheetOptions )
local guzikSheet = graphics.newImageSheet( "images/Guziouki.png", guzikSheetOptions )

local loras
local trawa
local backGroup
local grassGroup
local mainGroup
local uiGroup

local gameLoopTimer

local goLeft = false
local goRight = false
local lastMove = 'lewo'

local goJump = false

local offset = 10

-- -----------------------------------------------------------------------------------
-- Mosaks functions
-- -----------------------------------------------------------------------------------


local function gameLoop()

    local x, y = loras:getMassLocalCenter()

    if not goLeft and not goRight and offset > 0 then
        if lastMove == 'lewo' then
            loras.x = loras.x - offset
        end

        if lastMove == 'prawo' then
            loras.x = loras.x + offset
        end

        offset = offset - 0.5
    end

	if goLeft then loras.x = loras.x - offset end
    if goRight then loras.x = loras.x + offset end

end

function makeGrass()
    for i=1,20,1 do
        trawa = display.newImage( grassGroup, trawaSheet, 1, 38 + 76*(i-1), display.actualContentHeight-40) 
        physics.addBody(trawa,"static",{bounce=0.0,friction=0})
    end
end

function makeButtons()

    guzikLewo = display.newImage( uiGroup, guzikSheet, 1, 80, display.actualContentHeight-80) 
    guzikLewo.alpha = 0.7
    guzikLewo:addEventListener( "touch", lorasIdzieWLewo )

    guzikPrawo = display.newImage( uiGroup, guzikSheet, 2, 210, display.actualContentHeight-80) 
    guzikPrawo.alpha = 0.7
    guzikPrawo:addEventListener( "touch", lorasIdzieWPrawo )

    guzikA = display.newImage( uiGroup, guzikSheet, 3, display.actualContentWidth-210, display.actualContentHeight-80) 
    guzikA.alpha = 0.7
    guzikA:addEventListener( "touch", lorasSkacze )

    guzikB = display.newImage( uiGroup, guzikSheet, 4, display.actualContentWidth-80, display.actualContentHeight-80) 
    guzikB.alpha = 0.7
    guzikB:addEventListener( "touch", lorasSzczela )

end

function lorasIdzieWLewo( event )
    if event.phase == "began" or event.phase == "moved" then
        offset = 10
        lastMove = 'lewo'
        goLeft = true
		print "lewo"
	else
        goLeft = false
	end	
end

function lorasIdzieWPrawo( event )
    if event.phase == "began" or event.phase == "moved" then
        offset = 10
        lastMove = 'prawo'
        goRight = true
		print "prawo"
	else
        goRight = false
	end	
end

function lorasSkacze( event )
    if event.phase == "began" or event.phase == "moved" then
		print "bounce"
	else

	end	
end

function lorasSzczela( event )
    if event.phase == "began" or event.phase == "moved" then
		print "jeb"
	else

	end	
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause()  -- Temporarily pause the physics engine

	-- Set up display groups
	backGroup = display.newGroup()  -- Display group for the background image
	sceneGroup:insert( backGroup )  -- Insert into the scene's view group

    grassGroup = display.newGroup()
	sceneGroup:insert( grassGroup ) 

	mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
	sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

	uiGroup = display.newGroup()    -- Display group for UI objects like the score
	sceneGroup:insert( uiGroup )    -- Insert into the scene's view group
	
	-- Load the background
	--local background = display.newImageRect( backGroup, "game_bg.png", 800, 1400 )
	--background.x = display.contentCenterX
	--background.y = display.contentCenterY
	--background.width = display.actualContentWidth
    --background.height = display.actualContentHeight

    makeGrass()
    makeButtons()

	loras = display.newSprite(mainGroup, lorasSheet, lorasSequences)
	loras.x = 640--250
	loras.y = 360

    physics.addBody(loras,"dynamic",{bounce=0.0,friction=0,density=2})

	loras:setSequence( "run" )  -- switch to "idle" sequence
    loras:play()  -- play the new sequence

    physics.start()

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
        gameLoopTimer = timer.performWithDelay( 33, gameLoop, 0 )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
        timer.cancel( gameLoopTimer )
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
