
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoGame()
	composer.gotoScene( "world1-1", { time=800, effect="crossFade" } )
end

local function gotoHighScores()
	composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local background = display.newImageRect( sceneGroup, "menu_bg.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	background.width = display.actualContentWidth
    background.height = display.actualContentHeight


	local title = display.newImageRect( sceneGroup, "title.png", 500, 80 )
	title.x = display.contentCenterX
	title.y = 200
	title.width = display.actualContentWidth*0.8
    title.height = display.actualContentWidth*0.8*80/500

	local playButton = display.newText( sceneGroup, "Zaczynamy!!!", display.contentCenterX, 700, native.systemFont, 88 )
	playButton:setFillColor( 0, 0, 0 )

	playButton:addEventListener( "tap", gotoGame )
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
