
local composer = require( "composer" )

local scene = composer.newScene()

--[[
    greataxe_offsets:
    1. 44x 14y
    2. 44x 14y
    3. 3x 44y
    4. 15x 2y
    5. 15x 2y
    6. 15x 2y
    7. 15x 2y
]]

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

-- Configure image sheets

local greatAxeSheetOptions = {
    frames = {
        {   -- 1. greatAxe 1
            x = 1,
            y = 1,
            width = 62,
            height = 20,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 2. greatAxe 2
            x = 1,
            y = 1,
            width = 62,
            height = 20,
			sourceX = -1,
            sourceY = 0,
            sourceWidth = 65,
            sourceHeight = 20
        },
        {   -- 3. greatAxe 3
            x = 64,
            y = 1,
            width = 21,
            height = 63,
			sourceX = 82,
            sourceY = 5,
            sourceWidth = 100,
            sourceHeight = 100
        },
        {   -- 4. greatAxe 4
            x = 86,
            y = 1,
            width = 62,
            height = 20,
			sourceX = 500,
            sourceY = 500,
            sourceWidth = 562,
            sourceHeight = 520
        },
        {   -- 5. greatAxe 5
            x = 86,
            y = 1,
            width = 62,
            height = 20,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 6. greatAxe 6
            x = 86,
            y = 1,
            width = 62,
            height = 20,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        },
        {   -- 7. greatAxe 7
            x = 86,
            y = 1,
            width = 62,
            height = 20,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 0,
            sourceHeight = 0
        }
    }
}

local mosakSheetOptions = {
    frames =
    {
		{   -- 1. idle 1
            x = 3,
            y = 6,
            width = 25,
            height = 54,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 25,
            sourceHeight = 54
        },
        {   -- 2. idle 2
            x = 40,
            y = 6,
            width = 25,
            height = 54,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 25,
            sourceHeight = 54
        },
        {   -- 3. idle 3
            x = 76,
            y = 6,
            width = 25,
            height = 54,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 25,
            sourceHeight = 54
        },
        {   -- 4. swordAxeAttack 1
            x = 9,
            y = 293,
            width = 33,
            height = 58,
			sourceX = 3,
            sourceY = 0,
            sourceWidth = 56,
            sourceHeight = 58
        },
        {   -- 5. swordAxeAttack 2
            x = 56,
            y = 293,
            width = 36,
            height = 58,
			sourceX = 0,
            sourceY = 0,
            sourceWidth = 56,
            sourceHeight = 58
        },
        {   -- 6. swordAxeAttack 3
            x = 103,
            y = 293,
            width = 31,
            height = 58,
			sourceX = 5,
            sourceY = 0,
            sourceWidth = 56,
            sourceHeight = 58
        },
        {   -- 7. swordAxeAttack 4
            x = 146,
            y = 293,
            width = 55,
            height = 58,
			sourceX = 1,
            sourceY = 0,
            sourceWidth = 56,
            sourceHeight = 58
        },
        {   -- 8. swordAxeAttack 5
            x = 218,
            y = 293,
            width = 53,
            height = 58,
			sourceX = 1,
            sourceY = 0,
            sourceWidth = 56,
            sourceHeight = 58
        },
        {   -- 9. swordAxeAttack 6
            x = 279,
            y = 293,
            width = 53,
            height = 58,
			sourceX = 1,
            sourceY = 0,
            sourceWidth = 56,
            sourceHeight = 58
        },
        {   -- 10. swordAxeAttack 7
            x = 339,
            y = 293,
            width = 36,
            height = 58,
			sourceX = 5,
            sourceY = 0,
            sourceWidth = 56,
            sourceHeight = 58
        }
    },
}

local greatAxeSheet = graphics.newImageSheet( "greataxe.png", greatAxeSheetOptions )
local mosakSheet = graphics.newImageSheet( "mosakSheet.png", mosakSheetOptions )

-- Configure image sequences
local mosakSequences = {
    -- non-consecutive frames sequence
    {
        name = "idle",
        frames = { 1,2,3,2 },
        time = 2000,
        loopCount = 0,
        loopDirection = "forward"
    },
	{
        name = "swordAxeAttack",
        frames = { 4,5,6,7,8,9,10 },
        time = 1000,
        loopCount = 1,
        loopDirection = "forward"
    }
}

local greatAxeSequences = {
    -- non-consecutive frames sequence
    {
        name = "attack",
        frames = { 1,2,3,4,5,6,7 },
        time = 2000,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- Initialize variables

local mosak
local greatAxe
local isAttacking = true
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

--mosakAttackListener()
function mosakAttackListener( event )

	if ( event.phase == "began" ) then 
		isAttacking = false
	elseif ( event.phase == "ended" ) then 
		isAttacking = true
		mosak.y = mosak.y + 25
		mosak.x = mosak.x - 10
        mosak:setSequence( "idle" )  -- switch to "idle" sequence
        mosak:play()  -- play the new sequence
		mosak:removeEventListener("sprite",mosakAttackListener)
    end

    print(mosak.x)
    print(mosak.y)

end

--attackFunction()
function attackFunction()
	if isAttacking then

		mosak.y = mosak.y - 25
		mosak.x = mosak.x + 10
		mosak:setSequence( "swordAxeAttack" )  -- switch to "swordAxeAttack" sequence
		--mosak:play()  -- play the new sequence
        mosak:setFrame(4)
        greatAxe:setFrame(4)
		mosak:addEventListener("sprite",mosakAttackListener)
        isAttacking = false
	end

end

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
	local background = display.newImageRect( backGroup, "game_bg.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background.width = display.actualContentWidth
    background.height = display.actualContentHeight

	mosak = display.newSprite(mainGroup, mosakSheet, mosakSequences)
	mosak:scale(10,10)
	mosak.x = 520--250
	mosak.y = 1325

    greatAxe = display.newSprite(mainGroup, greatAxeSheet, greatAxeSequences)
	greatAxe:scale(10,10)
	greatAxe.x = mosak.x - 360
	greatAxe.y = mosak.y - 290

    greatAxe:setSequence( "attack" )

	mosak:setSequence( "idle" )  -- switch to "idle" sequence
    mosak:play()  -- play the new sequence
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		--gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
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
		--Runtime:removeEventListener( "collision", onCollision )
		physics.pause()
		composer.removeScene( "game" )
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

Runtime:addEventListener( "touch", attackFunction )
-- -----------------------------------------------------------------------------------

return scene
