-- SCRIPTED BY ZITUNDRA FOR KAELONGA TECHNOLOGIES GROUP ON ROBLOX


local Swing = {}

function Swing:Beta(DoorModel)
	-- SÐTTINGS
	--print(DoorModel)
	local Settings = require(DoorModel.Configuration)
	local AnimStyle = Settings.DoorAnimStyle
	local OpenDuration = Settings.DoorAnimTime
	local CustomTweenBool = Settings.CustomTween
	local CustomTweenOpen = Settings.TweenOpen or nil
	local CustomTweenClose = Settings.TweenClose or nil
	local OpenDeg = Settings.OpenDegrees
	
	local ClickDetector = Settings.ClickDetector
	local CDMaxActivationDistance = Settings.MaxActivationDistance
	
	local PromptActionText = Settings.ActionText
	local ClickablePrompt = Settings.ClickablePrompt
	local PromptGamepadKeyCode = Settings.GamepadKeyCode
	local PromptHoldDuration = Settings.HoldDuration
	local PromptKeyboardKeyCode = Settings.KeyboardKeyCode
	local PromptMaxActivationDistance = Settings.PromptMaxActivationDistance
	local PromptObjectText = Settings.ObjectText
	
	local function GeneratePrompt(Parent)
		local Prompt = Instance.new("ProximityPrompt")
		Prompt.ActionText = PromptActionText
		Prompt.ClickablePrompt = ClickablePrompt
		Prompt.GamepadKeyCode = PromptGamepadKeyCode
		Prompt.HoldDuration = PromptHoldDuration
		Prompt.KeyboardKeyCode = PromptKeyboardKeyCode
		Prompt.MaxActivationDistance = PromptMaxActivationDistance
		Prompt.ObjectText = PromptObjectText
		
		if Parent then
			Prompt.Parent = Parent
		end
	end
	
	local function GenerateClickDetector(Parent)
		local CDetector = Instance.new("ClickDetector")
		CDetector.MaxActivationDistance = CDMaxActivationDistance
		
		if Parent then 
			CDetector.Parent = Parent 
		end
	end

	--INSTANCES
	local RightDoor = DoorModel:FindFirstChild("RightDoor") or nil
	local RightHinge
	local RightHingeCF
	local RightHandleIn
	local RightHandleOut
	

	local LeftDoor = DoorModel:FindFirstChild("LeftDoor") or nil
	local LeftHinge
	local LeftHingeCF
	local LeftHandleIn
	local LeftHandleOut
	
	if RightDoor ~= nil then
		RightHinge = RightDoor.Hinge
		RightHingeCF = RightHinge.CFrame
		RightHandleIn = RightDoor:FindFirstChild("HandleIn") or nil
		RightHandleOut = RightDoor:FindFirstChild("HandleOut") or nil
		if RightHandleIn ~= nil then
			if ClickDetector == false then
				GeneratePrompt(RightHandleIn)
			else
				GenerateClickDetector(RightHandleIn)
			end
		end
		if RightHandleOut ~= nil then
			if ClickDetector == false then
				GeneratePrompt(RightHandleOut)
			else
				GenerateClickDetector(RightHandleOut)
			end
		end
		for _, v in pairs(RightDoor:GetChildren()) do
			if v:IsA("BasePart") and v.Name ~= "Hinge" then
				local w = Instance.new("WeldConstraint")
				w.Name = "Weld"
				w.Part0 = RightHinge
				w.Part1 = v
				w.Parent = RightHinge
				v.Anchored = false
			end
		end
	end
	
	if LeftDoor ~= nil then
		LeftHinge = LeftDoor.Hinge
		LeftHingeCF = LeftHinge.CFrame
		LeftHandleIn = LeftDoor:FindFirstChild("HandleIn") or nil
		LeftHandleOut = LeftDoor:FindFirstChild("HandleOut") or nil
		if LeftHandleIn ~= nil then
			if ClickDetector == false then
				GeneratePrompt(LeftHandleIn)
			else
				GenerateClickDetector(LeftHandleIn)
			end
		end
		if LeftHandleOut ~= nil then
			if ClickDetector == false then
				GeneratePrompt(LeftHandleOut)
			else
				GenerateClickDetector(LeftHandleOut)
			end
		end
		for _, v in pairs(LeftDoor:GetChildren()) do
			if v:IsA("BasePart") and v.Name ~= "Hinge" then
				local w = Instance.new("WeldConstraint")
				w.Name = "Weld"
				w.Part0 = LeftHinge
				w.Part1 = v
				w.Parent = LeftHinge
				v.Anchored = false
			end
		end
	end

	--Unique door id and event 
	local Letters = {"A", "B", "C", "D", "E", "F", "G", "L", "N", "T"}
	local Val -- = Instance.new("StringValue")
	--Val.Parent = DoorModel
	Val--[[.Value]] = Letters[math.random(1, 8)]..math.random(100, 1000)
	local event = Instance.new("BindableEvent")
	event.Parent = DoorModel
	
	DoorModel:AddTag(Val)

	--warn("rDoor "..Val.." Has been setted up successfuly")

	--Door status
	local DoorLocked = true
	local DoorStatus = "Closed"

	--CardReaders and Buttons
	local RNBFolder = DoorModel.BtnsNReaders
	local CardReaderIn = RNBFolder.In.Readers:FindFirstChildOfClass("Model") or nil
	local CardReaderOut = RNBFolder.Out.Readers:FindFirstChildOfClass("Model") or nil
	local ButtonIn = RNBFolder.In.Buttons:FindFirstChildOfClass("Model") or nil
	local ButtonOut = RNBFolder.Out.Buttons:FindFirstChildOfClass("Model") or nil
	--print(CardReaderIn, CardReaderOut, ButtonIn, ButtonOut)
	--
	local tweenInfoOpen
	local tweenInfoClose
	if CustomTweenBool == false then
		if string.lower(AnimStyle) == "stopandgo" then
			tweenInfoOpen = TweenInfo.new(
				OpenDuration/1.2,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out,
				0,
				false,
				-1
			)
			tweenInfoClose = TweenInfo.new(
				OpenDuration*1.5,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.InOut,
				0,
				false,
				-1
			)
		end
	elseif CustomTweenBool == true then
		if CustomTweenOpen ~= nil then
			tweenInfoOpen = CustomTweenOpen
		end
		if CustomTweenClose ~= nil then
			tweenInfoClose = CustomTweenClose
		end
	end
	local tweenOpenRight
	local tweenCloseRight
	local tweenOpenLeft
	local tweenCloseLeft
	
	if RightDoor ~= nil then
		tweenOpenRight = game:GetService("TweenService"):Create(RightHinge, tweenInfoOpen, {CFrame = RightHingeCF*CFrame.Angles(math.rad(OpenDeg), 0, 0)})
		tweenCloseRight = game:GetService("TweenService"):Create(RightHinge, tweenInfoClose, {CFrame = RightHingeCF})
	end
	if LeftDoor ~= nil then
		tweenOpenLeft = game:GetService("TweenService"):Create(LeftHinge, tweenInfoOpen, {CFrame = LeftHingeCF*CFrame.Angles(math.rad(-OpenDeg), 0, 0)})
		tweenCloseLeft = game:GetService("TweenService"):Create(LeftHinge, tweenInfoClose, {CFrame = LeftHingeCF})
	end
	--Functions
	local function DoorOpen(Side, Door)
		if Door == "Right" then
			if Side == "In" then
				if CardReaderIn == nil and ButtonIn == nil then
					tweenOpenRight:Play()
					DoorStatus = "Opening"
					tweenOpenRight.Completed:Connect(function()

						tweenCloseRight:Play()

						tweenCloseRight.Completed:Connect(function()

							if tweenOpenRight.PlaybackState ~= Enum.PlaybackState.Playing then
								DoorStatus = "Closed"
							end

						end)
					end)
				else
					if DoorLocked == false or DoorStatus ~= "Closed" then
						tweenOpenRight:Play()
						DoorStatus = "Opening"
						tweenOpenRight.Completed:Connect(function()

							tweenCloseRight:Play()
							tweenCloseRight.Completed:Connect(function()

								if tweenOpenRight.PlaybackState ~= Enum.PlaybackState.Playing then
									DoorStatus = "Closed"
								end

							end)
						end)
					end
				end
			elseif Side == "Out" then
				if CardReaderOut == nil and ButtonOut == nil then
					tweenOpenRight:Play()
					DoorStatus = "Opening"
					tweenOpenRight.Completed:Connect(function()

						tweenCloseRight:Play()
						tweenCloseRight.Completed:Connect(function()

							if tweenOpenRight.PlaybackState ~= Enum.PlaybackState.Playing then
								DoorStatus = "Closed"
							end

						end)
					end)
				else
					if DoorLocked == false or DoorStatus ~= "Closed" then
						tweenOpenRight:Play()
						DoorStatus = "Opening"
						tweenOpenRight.Completed:Connect(function()

							tweenCloseRight:Play()
							tweenCloseRight.Completed:Connect(function()

								if tweenOpenRight.PlaybackState ~= Enum.PlaybackState.Playing then
									DoorStatus = "Closed"
								end

							end)
						end)
					end
				end
			end
		elseif Door == "Left" then
			if Side == "In" then
				if CardReaderIn == nil and ButtonIn == nil then
					tweenOpenLeft:Play()
					DoorStatus = "Opening"
					tweenOpenLeft.Completed:Connect(function()

						tweenCloseLeft:Play()

						tweenCloseLeft.Completed:Connect(function()

							if tweenOpenLeft.PlaybackState ~= Enum.PlaybackState.Playing then
								DoorStatus = "Closed"
							end

						end)
					end)
				else
					if DoorLocked == false or DoorStatus ~= "Closed" then
						tweenOpenLeft:Play()
						DoorStatus = "Opening"
						tweenOpenLeft.Completed:Connect(function()

							tweenCloseLeft:Play()
							tweenCloseLeft.Completed:Connect(function()

								if tweenOpenLeft.PlaybackState ~= Enum.PlaybackState.Playing then
									DoorStatus = "Closed"
								end

							end)
						end)
					end
				end
			elseif Side == "Out" then
				if CardReaderOut == nil and ButtonOut == nil then
					tweenOpenLeft:Play()
					DoorStatus = "Opening"
					tweenOpenLeft.Completed:Connect(function()

						tweenCloseLeft:Play()
						tweenCloseLeft.Completed:Connect(function()

							if tweenOpenLeft.PlaybackState ~= Enum.PlaybackState.Playing then
								DoorStatus = "Closed"
							end

						end)
					end)
				else
					if DoorLocked == false or DoorStatus ~= "Closed" then
						tweenOpenLeft:Play()
						DoorStatus = "Opening"
						tweenOpenLeft.Completed:Connect(function()

							tweenCloseLeft:Play()
							tweenCloseLeft.Completed:Connect(function()

								if tweenOpenLeft.PlaybackState ~= Enum.PlaybackState.Playing then
									DoorStatus = "Closed"
								end

							end)
						end)
					end
				end
			end
		end
	end

	pcall(function()RightHandleIn.ProximityPrompt.Triggered:Connect(function() DoorOpen("In", "Right") end) end)
	pcall(function()RightHandleOut.ProximityPrompt.Triggered:Connect(function() DoorOpen("Out", "Right") end) end)
	pcall(function()LeftHandleIn.ProximityPrompt.Triggered:Connect(function() DoorOpen("In", "Left") end) end)
	pcall(function()LeftHandleOut.ProximityPrompt.Triggered:Connect(function() DoorOpen("Out", "Left") end) end)
	pcall(function()RightHandleIn.ClickDetector.MouseClick:Connect(function() DoorOpen("In", "Right") end) end)
	pcall(function()RightHandleOut.ClickDetector.MouseClick:Connect(function() DoorOpen("Out", "Right") end) end)
	pcall(function()LeftHandleIn.ClickDetector.MouseClick:Connect(function() DoorOpen("In", "Left") end) end)
	pcall(function()LeftHandleOut.ClickDetector.MouseClick:Connect(function() DoorOpen("Out", "Left") end) end)

	event.Event:Connect(function(doorId, openDuration, todo, test)
		--print(doorId)
		if Val == doorId and test == false then
			--print(todo)
			DoorLocked = false
			wait(OpenDuration)
			DoorLocked = true
		end
	end)

end


function Swing:Scanner(ScannerModel)
	--SETTINGS
	local Settings = require(ScannerModel.Configuration)
	local ReqCardLevel = Settings.ReqCardLevel
	--local StColor = Settings.StColor
	--local ScColor = Settings.ScColor
	--local ErrColor = Settings.ErrColor
	local OpenDuration = Settings.OpenDuration
	
	--INSTANCES
	local Sensor = ScannerModel.Sensor
	local LEDS = ScannerModel.Case.LEDS
	----print(StColor, ScColor, ErrColor)
	--LED.BrickColor = BrickColor.new("White")
	
	
	
	local db = false
	local function onTouch(hit)
		local DoorId = ScannerModel:FindFirstAncestor("BtnsNReaders").Parent:GetTags()[1]
		local event = ScannerModel:FindFirstAncestor("BtnsNReaders").Parent:FindFirstChildOfClass("BindableEvent")
		if hit.Parent:FindFirstChild("Configuration") then
			Sensor.CanTouch = false
			--print(Sensor.CanTouch)
			local CardSettings = require(hit.Parent.Configuration)
			local CardLevel = CardSettings.CardLevel
			local Sound = Instance.new("Sound")
			Sound.Parent = ScannerModel
			Sound.SoundId = "rbxassetid://8120936755"
			Sound.RollOffMaxDistance = 10
			Sound:Play()
			if CardLevel >= ReqCardLevel then
				
				for _, LED in pairs(LEDS:GetChildren()) do
					game:GetService("TweenService"):Create(LED, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {Color = Color3.fromRGB(77, 255, 0)}):Play()
					task.wait(0.1)
				end
				event:Fire(DoorId, OpenDuration, "Unlock", false)
				task.wait(OpenDuration)
				for _, LED in pairs(LEDS:GetChildren()) do
					game:GetService("TweenService"):Create(LED, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {Color = Color3.fromRGB(0, 0, 0)}):Play()
					task.wait(0.1)
				end	
			else
				for _, LED in pairs(LEDS:GetChildren()) do
					game:GetService("TweenService"):Create(LED, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {Color = Color3.fromRGB(255, 0, 4)}):Play()
					task.wait(0.1)
				end
				task.wait(OpenDuration)
				for _, LED in pairs(LEDS:GetChildren()) do
					game:GetService("TweenService"):Create(LED, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {Color = Color3.fromRGB(0, 0, 0)}):Play()
					task.wait(0.1)
				end
			end
			Sound:Destroy()
			Sensor.CanTouch = true
		end
	end
	
	Sensor.Touched:Connect(function(hit) 
		onTouch(hit)
	end)
	
end

function Swing:Button(ButtonModel)
	-- SETTINGS
	local Settings = require(ButtonModel.Configuration)
	local MaxActivationDistance = Settings.MaxActDis
	local GroupWhitelist = Settings.GroupWhitelist
	local PeopleWhitelist = Settings.PeopleWhitelist
	local OpenDuration = Settings.OpenDuration
	
	-- INSTANCES
	local Sensor = ButtonModel.Sensor
	local Gui = ButtonModel.Case.Gui.SurfaceGui
	
	
	local ClickDetector = Instance.new("ClickDetector")
	ClickDetector.Parent = Sensor
	ClickDetector.MaxActivationDistance = MaxActivationDistance
	
	
	
	
	
	local function onClick(plr)
		local DoorId = ButtonModel:FindFirstAncestor("BtnsNReaders").Parent:GetTags()[1]
		local event = ButtonModel:FindFirstAncestor("BtnsNReaders").Parent:FindFirstChildOfClass("BindableEvent")
		if next(PeopleWhitelist) == nil and next(GroupWhitelist) == nil then
			print("nil nil")
			event:Fire(DoorId, OpenDuration, "Unlock", false)
			game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
			task.wait(OpenDuration)
			game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
			return
		end
		if next(GroupWhitelist) ~= nil then
			print("Group")
			for i, v in pairs(GroupWhitelist) do
				if plr:IsInGroup(i) and plr:GetRankInGroup(i) >= v then
					event:Fire(DoorId, OpenDuration, "Unlock", false)
					game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
					task.wait(OpenDuration)
					game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
					return
				end
			end
		end
		if next(PeopleWhitelist) ~= nil then
			print("People")
			for i, v in ipairs(PeopleWhitelist) do
				if plr.UserId == v then
					event:Fire(DoorId, OpenDuration, "Unlock", false)
					game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
					task.wait(OpenDuration)
					game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
					return
				end
			end
		end
	end
	
	ClickDetector.MouseClick:Connect(function(plr) onClick(plr) end)
end

return Swing
