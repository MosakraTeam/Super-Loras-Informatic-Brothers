
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

local trawaSheet = graphics.newImageSheet( "images/Ground.png", trawaSheetOptions )

local loras
local trawa

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

    trawa = display.newImage( mainGroup, trawaSheet, 1, display.actualContentWidth/2, display.actualContentHeight-100) 

	loras = display.newSprite(mainGroup, lorasSheet, lorasSequences)
	loras.x = 640--250
	loras.y = 360

    physics.addBody(loras)
    physics.addBody(trawa,"static")

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

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

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
