
function bhDebug(text, ...)
	print(text, ...)
end

function clearStage()
	local numChildren=stage:getNumChildren()
	for i=1,numChildren do
		stage:getChildAt(1):removeFromParent()
	end
end

function showFields()
	-- This is our demo function, written as normal Gideros Lua code
	local font=TTFont.new("tahoma.ttf", 15)
	local tf=TextField.new(font, "Hello")
	stage:addChild(tf)
	tf:setPosition(100, 100)
	
	local tf2=TextField.new(font, "")
	stage:addChild(tf2)
	tf2:setPosition(200, 100)
	tf2:setText(string.format("Goodbye %s", "Andy"))
end

local taps=0

local function onMouseDown()
	taps=(taps+1) % 4
	clearStage()
	if taps==1 then
		-- Just show with no locale
		showFields()
	end
	if taps==2 then
		-- Show with US locale forced
		BhLocale.new("en_US")
		showFields()
	end
	if taps==3 then
		-- Show with French locale forced
		BhLocale.new("fr_FR")
		showFields()
	end
	if taps==0 then
		-- Show with default locale installed
		BhLocale.new()
		showFields()
	end
	if BhLocale.current then
		print(string.format("Set locale to %s", BhLocale.current.descriptor))
	end
end

stage:addEventListener(Event.MOUSE_DOWN, onMouseDown)


