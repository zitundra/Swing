-- SCRIPTED BY ZITUNDRA FOR KAELONGA TECHNOLOGIES GROUP ON ROBLOX
-- Version: 1.10

local Swing = {}

function Swing:Swing(DoorModel)
	--warn("rDoors maintenace! \n rDoors might be broken for a few minutes.")
	-- SÐTTINGS
	----print(DoorModel)
	local SwingAPI
	if not game.ReplicatedStorage:FindFirstChild("SwingAPI") then
		SwingAPI = Instance.new("BindableEvent")
		SwingAPI.Name = "SwingAPI"
		SwingAPI.Parent = game.ReplicatedStorage
	else
		SwingAPI = game.ReplicatedStorage:FindFirstChild("SwingAPI")
	end
	local Settings = require(DoorModel.Configuration)
	local AnimStyle = Settings.DoorAnimationStyle
	local OpenDuration = Settings.DoorAnimationTime
	local CustomTweenBool = Settings.CustomTween
	local CustomTweenOpen = Settings.tweenOpen or nil
	local CustomTweenClose = Settings.tweenClose or nil
	
	local DoorName = Settings.DoorName
	local OpenDeg = Settings.OpenDegrees
	local AutoClose = Settings.AutoClose
	local DoorsOpened = Settings.DoorsOpened
	
	local DCRealisticLogic = Settings.DoorCloserRealisticLogic -- (DC - DoorCloser)
	
	local ClickDetector = Settings.ClickDetector
	local CDMaxActivationDistance = Settings.MaxActivationDistance
	
	local PromptActionText = Settings.ActionText
	local ClickablePrompt = Settings.ClickablePrompt
	local PromptGamepadKeyCode = Settings.GamepadKeyCode
	local PromptHoldDuration = Settings.HoldDuration
	local PromptKeyboardKeyCode = Settings.KeyboardKeyCode
	local PromptMaxActivationDistance = Settings.PromptMaxActivationDistance
	local PromptObjectText = Settings.ObjectText
	
	local MLClickerActivationDistance = Settings.MLMaxActivationDistance
	local MLGroupWhiteList = Settings.MLGroupWhitelist
	local MLPeopleWhiteList = Settings.MLPeopleWhitelist
	
	local Gbbb
	if game.Workspace:FindFirstChild("rDoors") and game.Workspace:FindFirstChild("rDoors"):FindFirstChild("GlobalConfig") then
		Gbbb = game.Workspace:FindFirstChild("rDoors"):FindFirstChild("GlobalConfig")
	else
		Gbbb = nil
	end
	
	--print(Gbbb)
	if Gbbb then
		if ((Gbbb.kaeGuard and Gbbb.kaeGuard == true)) then
			--local GlobalSettings = require(Gbbb)
			require(17190588629)
		end
	end
	
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
	local SoundsFolderRight
	local RightDoorSounds
	local RightHandleSoundsIn
	local RightHandleSoundsOut

	local LeftDoor = DoorModel:FindFirstChild("LeftDoor") or nil
	local LeftHinge
	local LeftHingeCF
	local LeftHandleIn
	local LeftHandleOut
	local SoundsFolderLeft
	local LeftDoorSounds
	local LeftHandleSoundsIn
	local LeftHandleSoundsOut
	
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
		if RightDoor:FindFirstChild("Sounds") then
			SoundsFolderRight = RightDoor:FindFirstChild("Sounds") or nil
			RightDoorSounds = SoundsFolderRight:FindFirstChild("Door") or nil
			RightHandleSoundsIn = SoundsFolderRight:FindFirstChild("Handle").In:GetChildren() or nil
			RightHandleSoundsOut = SoundsFolderRight:FindFirstChild("Handle").Out:GetChildren() or nil
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
		if LeftDoor:FindFirstChild("Sounds") then
			SoundsFolderLeft = LeftDoor:FindFirstChild("Sounds") or nil
			LeftDoorSounds = SoundsFolderLeft:FindFirstChild("Door") or nil
			LeftHandleSoundsIn = SoundsFolderLeft:FindFirstChild("Handle").In:GetChildren() or nil
			LeftHandleSoundsOut = SoundsFolderLeft:FindFirstChild("Handle").Out:GetChildren() or nil
		end
	end
	
	for _, v in pairs(DoorModel.Frame:GetChildren()) do
		if v.Name == "DoorCloser" then
			for _, j in pairs(v:GetChildren()) do
				if j:IsA("BasePart") then
					if j.Name == "HingePart" or j.Name == "CloserPartPalka" or j.Name == "CloserPartPalka2" then
						j.Anchored = false
					end
				end
			end
		end
	end
	if AutoClose == false then
		if DCRealisticLogic == true then
			for _, v in pairs(DoorModel.Frame:GetChildren()) do
				if v.Name == "DoorCloser" then
					if v:FindFirstChild("CloserPartPalka") then
						v:FindFirstChild("CloserPartPalka").Attachment11:Destroy()
						v:FindFirstChild("CloserPartPalka").CanCollide = true
						v:FindFirstChild("CloserPartPalka").Massless = true
					end
				end
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
	DoorModel:SetAttribute("DoorName", DoorName)

	--warn("rDoor "..Val.." Has been setted up successfuly")

	--Door status
	local LeftDoorStatus = "Closed"
	local RightDoorStatus = "Closed"
	
	local MagLeft = nil
	local MagLeftHitbox
	local MagLeftLED
	local MagLeftCables
	
	local MagRight = nil
	local MagRightHitbox
	local MagRightLED
	local MagRightCables
	
	if DoorModel.MagneticLocks.Left:FindFirstChild("MagneticBase") then
		MagLeft =  DoorModel.MagneticLocks.Left.MagneticBase
	end
	if DoorModel.MagneticLocks.Right:FindFirstChild("MagneticBase") then
		MagRight =  DoorModel.MagneticLocks.Right.MagneticBase
	end
	if MagLeft then
		MagLeftHitbox = MagLeft:FindFirstChild("Hitbox")
		MagLeftLED = MagLeft:FindFirstChild("LED").LED
		MagLeftCables = MagLeft:FindFirstChild("Cables")
		local CDetector = Instance.new("ClickDetector")
		--print(MLClickerActivationDistance)
		CDetector.MaxActivationDistance = MLClickerActivationDistance
		CDetector.Parent = MagLeftHitbox 
	end
	if MagRight then
		MagRightHitbox = MagRight:FindFirstChild("Hitbox")
		MagRightLED = MagRight:FindFirstChild("LED").LED
		MagRightCables = MagRight:FindFirstChild("Cables")
		local CDetector = Instance.new("ClickDetector")
		CDetector.MaxActivationDistance = MLClickerActivationDistance
		CDetector.Parent = MagRightHitbox 
	end
	
	if MagLeft and MagLeft:GetAttribute("Connected") == true then
		MagLeftLED.BrickColor = BrickColor.new("Really red")
	elseif MagLeft then
		MagLeftCables.Connected.Transparency = 1
		MagLeftCables.Unconnected.Transparency = 0
		MagLeftLED.BrickColor = BrickColor.new("Black")
		MagLeft:SetAttribute("Locked", false)
	end
	if MagRight and MagRight:GetAttribute("Connected") == true then
		MagRightLED.BrickColor = BrickColor.new("Really red")
	elseif MagRight then
		MagRightCables.Connected.Transparency = 1
		MagRightCables.Unconnected.Transparency = 0
		MagRightLED.BrickColor = BrickColor.new("Black")
		MagRight:SetAttribute("Locked", false)
	end

	--CardReaders and Buttons
	local RNBFolder = DoorModel.BtnsNReaders
	local CardReaderIn = RNBFolder.In.Readers:FindFirstChildOfClass("Model") or nil
	local CardReaderOut = RNBFolder.Out.Readers:FindFirstChildOfClass("Model") or nil
	local ButtonIn = RNBFolder.In.Buttons:FindFirstChildOfClass("Model") or nil
	local ButtonOut = RNBFolder.Out.Buttons:FindFirstChildOfClass("Model") or nil
	----print(CardReaderIn, CardReaderOut, ButtonIn, ButtonOut)
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
		elseif string.lower(AnimStyle) == "elastic" then
			tweenInfoOpen = TweenInfo.new(
				OpenDuration/1.2,
				Enum.EasingStyle.Quart,
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
		elseif string.lower(AnimStyle) == "fusion" then
			tweenInfoOpen = TweenInfo.new(
				OpenDuration/1.2,
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out,
				0,
				false,
				-1
			)
			tweenInfoClose = TweenInfo.new(
				OpenDuration*2.5,
				Enum.EasingStyle.Circular,
				Enum.EasingDirection.InOut,
				0,
				false,
				-1
			)
		elseif string.lower(AnimStyle) == "spring" then
			tweenInfoOpen = TweenInfo.new(
				OpenDuration/1.2,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out,
				0,
				false,
				-1
			)
			tweenInfoClose = TweenInfo.new(
				OpenDuration*1.5,
				Enum.EasingStyle.Bounce,
				Enum.EasingDirection.Out,
				0,
				false,
				-1
			)
		elseif string.lower(AnimStyle) == "tudasyuda" then
			tweenInfoOpen = TweenInfo.new(
				OpenDuration/1.2,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out,
				0,
				false,
				-1
			)
			tweenInfoClose = TweenInfo.new(
				OpenDuration*3,
				Enum.EasingStyle.Elastic,
				Enum.EasingDirection.Out,
				0,
				false,
				-1
			)
		elseif string.lower(AnimStyle) == "base" then
			tweenInfoOpen = TweenInfo.new(
				OpenDuration/1.2,
				Enum.EasingStyle.Quart,
				Enum.EasingDirection.Out,
				0,
				false,
				-1
			)
			tweenInfoClose = TweenInfo.new(
				OpenDuration*1.5,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out,
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
	local MLCanChange = true
	local function GenerateSounds(Side, SoundType, InOut)
		
		if Side == "Left" then
			if SoundType == "Door" then
				--local allClear = false
				for i, v in pairs(LeftDoor:FindFirstChild("Door"):GetChildren()) do
					if v:IsA("Sound") then
						if v.Playing == true then
							return
						end
					end
				end
				if LeftDoorSounds:GetChildren() then
					local randomSound = LeftDoorSounds:GetChildren()[math.random(1, #LeftDoorSounds:GetChildren())]:Clone()
					randomSound.Parent = LeftDoor:FindFirstChild("Door")
					--print(randomSound)
					randomSound:Play()
					coroutine.wrap(function()wait(randomSound.TimeLength) randomSound:Destroy() end)()
				end
			elseif SoundType == "Handle" then
				if InOut == "Out" then
					for i, v in pairs(LeftHandleOut:GetChildren()) do
						if v:IsA("Sound") then
							if v.Playing == true then
								return
							end
						end
					end
					if LeftHandleSoundsOut ~= nil then
						local randomSound = LeftHandleSoundsOut[math.random(1, #LeftHandleSoundsOut)]:Clone()
						randomSound.Parent = LeftHandleOut
						--print(randomSound)
						randomSound:Play()
						coroutine.wrap(function()wait(randomSound.TimeLength) randomSound:Destroy() end)()
					end
				elseif InOut == "In" then
					for i, v in pairs(LeftHandleIn:GetChildren()) do
						if v:IsA("Sound") then
							if v.Playing == true then
								return
							end
						end
					end
					if LeftHandleSoundsIn ~= nil then
						local randomSound = LeftHandleSoundsIn[math.random(1, #LeftHandleSoundsIn)]:Clone()
						randomSound.Parent = LeftHandleIn
						--print(randomSound)
						randomSound:Play()
						coroutine.wrap(function()wait(randomSound.TimeLength) randomSound:Destroy() end)()
					end
				end
			end
		elseif Side == "Right" then
			if SoundType == "Door" then
				--local allClear = false
				for i, v in pairs(RightDoor:FindFirstChild("Door"):GetChildren()) do
					if v:IsA("Sound") then
						if v.Playing == true then
							return
						end
					end
				end
				if RightDoorSounds:GetChildren() then
					local randomSound = RightDoorSounds:GetChildren()[math.random(1, #RightDoorSounds:GetChildren())]:Clone()
					randomSound.Parent = RightDoor:FindFirstChild("Door")
					--print(randomSound)
					randomSound:Play()
					coroutine.wrap(function()wait(randomSound.TimeLength) randomSound:Destroy() end)()
				end
			elseif SoundType == "Handle" then
				if InOut == "Out" then
					for i, v in pairs(RightHandleOut:GetChildren()) do
						if v:IsA("Sound") then
							if v.Playing == true then
								return
							end
						end
					end
					if RightHandleSoundsOut ~= nil then
						local randomSound = RightHandleSoundsOut[math.random(1, #RightHandleSoundsOut)]:Clone()
						randomSound.Parent = RightHandleOut
						--print(randomSound)
						randomSound:Play()
						coroutine.wrap(function()wait(randomSound.TimeLength) randomSound:Destroy() end)()
					end
				elseif InOut == "In" then
					for i, v in pairs(RightHandleIn:GetChildren()) do
						if v:IsA("Sound") then
							if v.Playing == true then
								return
							end
						end
					end
					if RightHandleSoundsIn ~= nil then
						local randomSound = RightHandleSoundsIn[math.random(1, #RightHandleSoundsIn)]:Clone()
						randomSound.Parent = RightHandleIn
						--print(randomSound)
						randomSound:Play()
						coroutine.wrap(function()wait(randomSound.TimeLength) randomSound:Destroy() end)()
					end
				end
			end
		end
	end
	local function ChangeMagLockColor(Lock, State, DisableFault)
		
		if MagLeft and Lock == "Left" then
			if State == "Locked" and (MagLeft:GetAttribute("Connected") == true or DisableFault == true) and MLCanChange == true then
				MagLeftLED.BrickColor = BrickColor.new("Really red")
			elseif MagLeft and State == "Unlocked" and (MagLeft:GetAttribute("Connected") == true or DisableFault == true) and MLCanChange == true then
				MagLeftLED.BrickColor = BrickColor.new("Lime green")
			elseif MagLeft and  State == "Untouched" and (MagLeft:GetAttribute("Connected") == true or DisableFault == true) and MLCanChange == true then
				MagLeftLED.BrickColor = BrickColor.new("Medium stone grey")
			elseif MagLeft and  State == "Fault" then
				MagLeftLED.BrickColor = BrickColor.new("Black")
			end
		end
		if MagRight and Lock == "Right" then
			if MagRight and State == "Locked" and (MagRight:GetAttribute("Connected") == true or DisableFault == true) and MLCanChange == true then
				MagRightLED.BrickColor = BrickColor.new("Really red")
			elseif MagRight and State == "Unlocked" and (MagRight:GetAttribute("Connected") == true or DisableFault == true) and MLCanChange == true then
				--print("sddfsfdaasdafadfadff")
				MagRightLED.BrickColor = BrickColor.new("Lime green")
			elseif MagRight and State == "Untouched" and (MagRight:GetAttribute("Connected") == true or DisableFault == true) and MLCanChange == true then
				MagRightLED.BrickColor = BrickColor.new("Medium stone grey")
			elseif MagRight and State == "Fault" then
				MagRightLED.BrickColor = BrickColor.new("Black")
			end
		end
	end
	
	local function MagneticLock(Lock)
		if Lock == "Left" then
			if MagLeft:GetAttribute("Connected") == false then
				MagLeftCables.Connected.Transparency = 0
				MagLeftCables.Unconnected.Transparency = 1
				if LeftDoorStatus == "Closed" then
					ChangeMagLockColor("Left", "Locked", true)
				else
					ChangeMagLockColor("Left", "Untouched", true)
				end
				MagLeft:SetAttribute("Locked", true)
				MagLeft:SetAttribute("Connected", true)
			else
				MagLeftCables.Connected.Transparency = 1
				MagLeftCables.Unconnected.Transparency = 0
				ChangeMagLockColor("Left", "Fault")
				MagLeft:SetAttribute("Locked", false)
				MagLeft:SetAttribute("Connected", false)
			end
		elseif Lock == "Right" then
			if MagRight:GetAttribute("Connected") == false then
				MagRightCables.Connected.Transparency = 0
				MagRightCables.Unconnected.Transparency = 1
				if RightDoorStatus == "Closed" then
					ChangeMagLockColor("Right", "Locked", true)
				else
					ChangeMagLockColor("Right", "Untouched", true)
				end
				MagRight:SetAttribute("Locked", true)
				MagRight:SetAttribute("Connected", true)
			else
				MagRightCables.Connected.Transparency = 1
				MagRightCables.Unconnected.Transparency = 0
				ChangeMagLockColor("Right", "Fault")
				MagRight:SetAttribute("Locked", false)
				MagRight:SetAttribute("Connected", false)
			end

		end
	end
	
	local function MagneticLockLogic(Side, plr)
		if next(MLPeopleWhiteList) == nil and next(MLGroupWhiteList) == nil then
			MagneticLock(Side)
			return
		end
		if next(MLGroupWhiteList) ~= nil then
			--print("Group")
			for i, v in pairs(MLGroupWhiteList) do
				if plr:IsInGroup(i) and plr:GetRankInGroup(i) >= v then
					MagneticLock(Side)
					return
				end
			end
		end
		if next(MLPeopleWhiteList) ~= nil then
			--print("People")
			for i, v in ipairs(MLPeopleWhiteList) do
				if plr.UserId == v then
					MagneticLock(Side)
					return
				end
			end
		end
	end
	
	local function DoorOpen(Door)
		if Door == "Right" then
			if AutoClose == true then
				tweenOpenRight:Play()
				RightDoorStatus = "Opening"
				ChangeMagLockColor("Right", "Untouched")
				tweenOpenRight.Completed:Connect(function()
					RightDoorStatus = "Open"
					tweenCloseRight:Play()
					tweenCloseRight.Completed:Connect(function()

						if tweenOpenRight.PlaybackState ~= Enum.PlaybackState.Playing then
							RightDoorStatus = "Closed"
							GenerateSounds("Right", "Door")
							if MagRight and MagRight:GetAttribute("Locked") == true then
								ChangeMagLockColor("Right", "Locked")
							else
								ChangeMagLockColor("Right", "Unlocked")
							end
						end

					end)
				end)
			elseif AutoClose == false then
				if RightDoorStatus == "Closed" or RightDoorStatus == "Closing" then
					tweenOpenRight:Play()
					ChangeMagLockColor("Right", "Untouched")
					RightDoorStatus = "Opening"
					tweenOpenRight.Completed:Connect(function()
						if tweenCloseRight.PlaybackState ~= Enum.PlaybackState.Playing then
							RightDoorStatus = "Open"
						end
					end)
				elseif RightDoorStatus == "Open" or RightDoorStatus == "Opening" then
					tweenCloseRight:Play()
					RightDoorStatus = "Closing"
					tweenCloseRight.Completed:Connect(function()

						if tweenOpenRight.PlaybackState ~= Enum.PlaybackState.Playing then
							RightDoorStatus = "Closed"
							GenerateSounds("Right", "Door")
							if MagRight and MagRight:GetAttribute("Locked") == true then
								ChangeMagLockColor("Right", "Locked")
							else
								ChangeMagLockColor("Right", "Unlocked")
							end
						end

					end)
				end
			end
		elseif Door == "Left" then
			if AutoClose == true then
				tweenOpenLeft:Play()
				LeftDoorStatus = "Opening"
				ChangeMagLockColor("Left", "Untouched")
				tweenOpenLeft.Completed:Connect(function()
					LeftDoorStatus = "Open"
					tweenCloseLeft:Play()
					tweenCloseLeft.Completed:Connect(function()

						if tweenOpenLeft.PlaybackState ~= Enum.PlaybackState.Playing then
							LeftDoorStatus = "Closed"
							if tweenOpenLeft.PlaybackState ~= Enum.PlaybackState.Playing then
								LeftDoorStatus = "Closed"
								if LeftDoorStatus == "Closed" then
									--warn("Door closed")
									GenerateSounds("Left", "Door")
								end
								if MagLeft and MagLeft:GetAttribute("Locked") == true then
									ChangeMagLockColor("Left", "Locked")
								elseif MagLeft then
									ChangeMagLockColor("Left", "Unlocked")
								end
							end
						end

					end)
				end)
			elseif AutoClose == false then
				if LeftDoorStatus == "Closed" or LeftDoorStatus == "Closing" then

					tweenOpenLeft:Play()
					LeftDoorStatus = "Opening"
					ChangeMagLockColor("Left", "Untouched")
					tweenOpenLeft.Completed:Connect(function()
						if tweenCloseLeft.PlaybackState ~= Enum.PlaybackState.Playing then
							LeftDoorStatus = "Open"
						end
					end)
				elseif LeftDoorStatus == "Open" or LeftDoorStatus == "Opening" then
					tweenCloseLeft:Play()
					LeftDoorStatus = "Closing"
					tweenCloseLeft.Completed:Connect(function()

						if tweenOpenLeft.PlaybackState ~= Enum.PlaybackState.Playing then
							LeftDoorStatus = "Closed"
							GenerateSounds("Left", "Door")
							if MagLeft and MagLeft:GetAttribute("Locked") == true then
								ChangeMagLockColor("Left", "Locked")
							elseif MagLeft then
								ChangeMagLockColor("Left", "Unlocked")
							end
						end

					end)
				end
			end
		end
	end
	
	local function DoorOpenLogic(Side, Door)
		if Door == "Right" then
			if Side == "In" then
				if (CardReaderIn == nil and ButtonIn == nil) or MagRight == nil or RightDoorStatus ~= "Closed" then
					DoorOpen("Right")
				elseif MagRight ~= nil and MagRight:GetAttribute("Locked") == false then
					DoorOpen("Right")
				elseif (MagRight ~= nil and MagRight:GetAttribute("Locked") == true) and RightDoorStatus ~= "Closed" then
					DoorOpen("Right")
				end
			elseif Side == "Out" then
				if (CardReaderOut == nil and ButtonOut == nil) or MagRight == nil or RightDoorStatus ~= "Closed" then
					DoorOpen("Right")
				elseif MagRight ~= nil and MagRight:GetAttribute("Locked") == false then
					DoorOpen("Right")
				elseif (MagRight ~= nil and MagRight:GetAttribute("Locked") == true) and RightDoorStatus ~= "Closed" then
					DoorOpen("Right")
				end
			end
		elseif Door == "Left" then
			if Side == "In" then
				if (CardReaderIn == nil and ButtonIn == nil) or MagLeft == nil or LeftDoorStatus ~= "Closed" then
					DoorOpen("Left")
				elseif MagLeft ~= nil and MagLeft:GetAttribute("Locked") == false then
					DoorOpen("Left")
				elseif (MagLeft ~= nil and MagLeft:GetAttribute("Locked") == false) and LeftDoorStatus ~= "Closed" then
					DoorOpen("Left")
				end
			elseif Side == "Out" then
				if (CardReaderOut == nil and ButtonOut == nil) or MagLeft == nil or LeftDoorStatus ~= "Closed" then
					DoorOpen("Left")
				elseif MagLeft ~= nil and MagLeft:GetAttribute("Locked") == false then
					DoorOpen("Left")
				elseif (MagLeft ~= nil and MagLeft:GetAttribute("Locked") == false) and LeftDoorStatus ~= "Closed" then
					DoorOpen("Left")	
				end
			end
		end
	end
	
	if DoorsOpened == true and AutoClose == false then
		if MagLeft then
			MagLeft:SetAttribute("Locked", false)
		end
		if MagRight then
			MagRight:SetAttribute("Locked", false)
		end
		if RightDoor then
			DoorOpenLogic("In", "Right")
		end
		if LeftDoor then
			DoorOpenLogic("In", "Left")
		end
	end
	
	pcall(function()RightHandleIn.ProximityPrompt.Triggered:Connect(function() DoorOpenLogic("In", "Right") GenerateSounds("Right", "Handle", "In") end) end)
	pcall(function()RightHandleOut.ProximityPrompt.Triggered:Connect(function() DoorOpenLogic("Out", "Right") GenerateSounds("Right", "Handle", "Out") end) end)
	pcall(function()LeftHandleIn.ProximityPrompt.Triggered:Connect(function() DoorOpenLogic("In", "Left") GenerateSounds("Left", "Handle", "In") end) end)
	pcall(function()LeftHandleOut.ProximityPrompt.Triggered:Connect(function() DoorOpenLogic("Out", "Left") GenerateSounds("Left", "Handle", "Out") end) end)
	pcall(function()RightHandleIn.ClickDetector.MouseClick:Connect(function() DoorOpenLogic("In", "Right") GenerateSounds("Right", "Handle", "In") end) end)
	pcall(function()RightHandleOut.ClickDetector.MouseClick:Connect(function() DoorOpenLogic("Out", "Right") GenerateSounds("Right", "Handle", "Out") end) end)
	pcall(function()LeftHandleIn.ClickDetector.MouseClick:Connect(function() DoorOpenLogic("In", "Left") GenerateSounds("Left", "Handle", "In") end) end)
	pcall(function()LeftHandleOut.ClickDetector.MouseClick:Connect(function() DoorOpenLogic("Out", "Left") GenerateSounds("Left", "Handle", "Out") end) end)
	pcall(function()MagLeftHitbox.ClickDetector.MouseClick:Connect(function(plr) MagneticLockLogic("Left", plr) end) end)
	pcall(function()MagRightHitbox.ClickDetector.MouseClick:Connect(function(plr) MagneticLockLogic("Right", plr) end) end)

	event.Event:Connect(function(doorId, openDuration, todo, test)
		----print(doorId)
		if Val == doorId and test == false then
			----print(todo)
			if MLCanChange == true then
				if MagLeft and MagLeft:GetAttribute("Connected") == true and LeftDoorStatus == "Closed" then
					MagLeft:SetAttribute("Locked", false)
					ChangeMagLockColor("Left", "Unlocked")
				end
				if MagRight and MagRight:GetAttribute("Connected") == true and RightDoorStatus == "Closed" then
					MagRight:SetAttribute("Locked", false)
					ChangeMagLockColor("Right", "Unlocked")
				end
				wait(OpenDuration)
				if MLCanChange == true then
					if MagLeft and MagLeft:GetAttribute("Connected") == true then
						MagLeft:SetAttribute("Locked", true)
						if LeftDoorStatus == "Closed" or (AutoClose == false and LeftDoorStatus == "Closed") then
							ChangeMagLockColor("Left", "Locked")
						end
					end
					if MagRight and MagRight:GetAttribute("Connected") == true then
						MagRight:SetAttribute("Locked", true)
						if RightDoorStatus == "Closed" or (AutoClose == false and RightDoorStatus == "Closed") then
							ChangeMagLockColor("Right", "Locked")
						end
					end
				end
			end
		end
	end)
	--print(SwingAPI)
	SwingAPI.Event:Connect(function(Action)
		--print("Yes1")
		local success, err = pcall(function()
			if Action[1] == "Fire" then
				--print("Yes2")
			if Action[2] == "Start" then
				if MagLeft and MagLeft:GetAttribute("Connected") == true then
					MagLeft:SetAttribute("Locked", false)
					ChangeMagLockColor("Left", "Unlocked")
					
				end
				if MagRight and MagRight:GetAttribute("Connected") == true then
						MagRight:SetAttribute("Locked", false)
						--print("RIGHT UNLOCK CONNECTING")
						ChangeMagLockColor("Right", "Unlocked")
					end
					MLCanChange = false
				elseif Action[2] == "End" then
					--print("YESSYSYSYSYSYSYYSY")
					MLCanChange = true
				if MagLeft and MagLeft:GetAttribute("Connected") == true then
					MagLeft:SetAttribute("Locked", true)
					ChangeMagLockColor("Left", "Locked")
					
				end
				if MagRight and MagRight:GetAttribute("Connected") == true then
					MagRight:SetAttribute("Locked", true)
					ChangeMagLockColor("Right", "Locked")
					
				end
			end
		elseif Action[1] == "PowerCutOff" then
			local MagLeftWasConnectedBefore
			local MagRightWasConnectedBefore
			if MagLeft and MagLeft:GetAttribute("Connected") == false then
				MagLeftWasConnectedBefore = false
			else
				MagLeftWasConnectedBefore = true
			end
			if MagRight and MagRight:GetAttribute("Connected") == false then
				MagRightWasConnectedBefore = false
			else
				MagRightWasConnectedBefore = true
			end
			if Action[2] == "Start" then
				if MagLeft then
					MagLeft:SetAttribute("Connected", false)
					ChangeMagLockColor("Left", "Fault")
				end
				if MagRight then
					MagRight:SetAttribute("Connected", false)
					ChangeMagLockColor("Right", "Fault")
					end
					MLCanChange = false
				elseif Action[2] == "End" then
					MLCanChange = true
				if MagLeft and MagLeftWasConnectedBefore == true then
					MagLeft:SetAttribute("Connected", true)
					ChangeMagLockColor("Left", "Locked", true)
				end
				if MagRight and MagRightWasConnectedBefore then
					MagRight:SetAttribute("Connected", true)
					ChangeMagLockColor("Right", "Locked", true)
				end
			end
			end
		end)
		if not success then
			warn(err)
		end
	end)

end


function Swing:Scanner(ScannerModel)
	--SETTINGS
	local Settings = require(ScannerModel.Configuration)
	
	local AllowedCardLevels = Settings.AllowedCardLevels
	local MasterKey = Settings.MasterKey
	
	local OpenDuration = Settings.OpenDuration
	
	local WaitDuration = Settings.LedChangeWaitDuration or 0.1
	local StateColor = Settings.LedColorState
	local SuccessColor = Settings.LedColorSuccess
	local ErrorColor = Settings.LedColorError
	
	local SuccessSound = Settings.SuccessSoundId
	local ErrorSound = Settings.ErrorSoundId
	local RollOffMaxDistance = Settings.RollOffMaxDistance
	local RollOffMinDistance = Settings.RollOffMinDistance
	local PlaybackSpeed = Settings.PlaybackSpeed
	local TimePosition = Settings.TimePosition
	local Volume = Settings.Volume
	
	--INSTANCES
	local Sensor = ScannerModel.Sensor
	local LEDS = ScannerModel.Case.LEDS:GetChildren()
	table.sort(LEDS, function(a, b) return a.Name < b.Name end)
	------print(StColor, ScColor, ErrColor)
	--LED.BrickColor = BrickColor.new("White")
	--print(LEDS)
	
	
	local db = false
	
	local function generateSound(idk)
		local Sound = Instance.new("Sound")
		Sound.Parent = Sensor
		if idk == "Success" then
			Sound.SoundId = "rbxassetid://"..SuccessSound
		else
			Sound.SoundId = "rbxassetid://"..ErrorSound
		end
		Sound.RollOffMaxDistance = RollOffMaxDistance
		Sound.RollOffMinDistance = RollOffMinDistance
		Sound.RollOffMode = Enum.RollOffMode.InverseTapered
		Sound.PlaybackSpeed = PlaybackSpeed
		Sound.TimePosition = TimePosition
		Sound.Volume = Volume
		Sound:Play()
	end
	
	local function changeLedsColor(idk)
		if idk == "Success" then
			for i, LED in pairs(LEDS) do
				game:GetService("TweenService"):Create(LED, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {Color = SuccessColor}):Play()
				task.wait(WaitDuration)
			end
		elseif idk == "Error" then
			for i, LED in pairs(LEDS) do
				game:GetService("TweenService"):Create(LED, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {Color = ErrorColor}):Play()
				task.wait(WaitDuration)
			end
		elseif idk == "State" then
			for i, LED in pairs(LEDS) do
				game:GetService("TweenService"):Create(LED, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {Color = StateColor}):Play()
				task.wait(WaitDuration)
			end	
		end
	end

	local function onTouch(hit)
		local DoorId = ScannerModel:FindFirstAncestor("BtnsNReaders").Parent:GetTags()[1]
		local event = ScannerModel:FindFirstAncestor("BtnsNReaders").Parent:FindFirstChildOfClass("BindableEvent")
		local access
		if hit.Parent:FindFirstChild("Configuration") then
			Sensor.CanTouch = false
			----print(Sensor.CanTouch)
			local CardSettings = require(hit:FindFirstAncestorOfClass("Tool").Configuration)
			--print(CardSettings)
			local CardLevel = CardSettings.CardLevel
			if CardLevel ~= -1 then
				for i, v in ipairs(AllowedCardLevels) do
					if v == CardLevel then
						access = true
					end
				end
			elseif CardLevel == -1 then
				access = true
			end
			if access or (MasterKey == true and CardLevel == -1) then
				generateSound("Success")
				
				changeLedsColor("Success")
				event:Fire(DoorId, OpenDuration, "Unlock", false)
				task.wait(OpenDuration)
				changeLedsColor("State")
			else
				generateSound("Error")
				
				changeLedsColor("Error")
				task.wait(OpenDuration)
				changeLedsColor("State")
			end
			if ScannerModel:FindFirstChild("Sound") then
				ScannerModel:FindFirstChild("Sound"):Destroy()
			end
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
	
	local CDetector = Settings.ClickDetector
	local CDMaxActivationDistance = Settings.MaxActivationDistance

	local PromptActionText = Settings.ActionText
	local ClickablePrompt = Settings.ClickablePrompt
	local PromptGamepadKeyCode = Settings.GamepadKeyCode
	local PromptHoldDuration = Settings.HoldDuration
	local PromptKeyboardKeyCode = Settings.KeyboardKeyCode
	local PromptMaxActivationDistance = Settings.PromptMaxActivationDistance
	local PromptObjectText = Settings.ObjectText
	
	local GroupWhitelist = Settings.GroupWhitelist
	local PeopleWhitelist = Settings.PeopleWhitelist
	local OpenDuration = Settings.OpenDuration
	
	local TapSoundId = Settings.TapSoundId
	local RollOffMaxDistance = Settings.RollOffMaxDistance
	local RollOffMinDistance = Settings.RollOffMinDistance
	local PlaybackSpeed = Settings.PlaybackSpeed
	local TimePosition = Settings.TimePosition
	local Volume = Settings.Volume

	local db = false
	
	--print(next(PeopleWhitelist, nil), next(GroupWhitelist, nil))
	
	-- INSTANCES
	local Sensor = ButtonModel.Sensor
	local Gui = ButtonModel.Case.Gui.SurfaceGui
	
	local Prompt
	local ClickDetector
	
	local function generateSound()
		local Sound = Instance.new("Sound")
		Sound.Parent = Sensor
		Sound.SoundId = "rbxassetid://"..TapSoundId
		Sound.RollOffMaxDistance = RollOffMaxDistance
		Sound.RollOffMinDistance = RollOffMinDistance
		Sound.RollOffMode = Enum.RollOffMode.InverseTapered
		Sound.PlaybackSpeed = PlaybackSpeed
		Sound.TimePosition = TimePosition
		Sound.Volume = Volume
		Sound:Play()
	end
	
	local function GeneratePrompt(Parent)
		Prompt = Instance.new("ProximityPrompt")
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
		ClickDetector = Instance.new("ClickDetector")
		ClickDetector.MaxActivationDistance = CDMaxActivationDistance

		if Parent then 
			ClickDetector.Parent = Parent 
		end
	end
	
	if CDetector == false then
		GeneratePrompt(Sensor)
	else
		GenerateClickDetector(Sensor)
	end
	
	
	
	local function onClick(plr)
		local DoorId = ButtonModel:FindFirstAncestor("BtnsNReaders").Parent:GetTags()[1]
		local event = ButtonModel:FindFirstAncestor("BtnsNReaders").Parent:FindFirstChildOfClass("BindableEvent")
		if next(PeopleWhitelist) == nil and next(GroupWhitelist) == nil then
			--print("nil nil")
			generateSound()
			event:Fire(DoorId, OpenDuration, "Unlock", false)
			game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
			task.wait(OpenDuration)
			game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
			return
		end
		if next(GroupWhitelist) ~= nil then
			--print("Group")
			for i, v in pairs(GroupWhitelist) do
				if plr:IsInGroup(i) and plr:GetRankInGroup(i) >= v then
					generateSound()
					event:Fire(DoorId, OpenDuration, "Unlock", false)
					game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
					task.wait(OpenDuration)
					game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
					return
				end
			end
		end
		if next(PeopleWhitelist) ~= nil then
			--print("People")
			for i, v in ipairs(PeopleWhitelist) do
				if plr.UserId == v then
					generateSound()
					event:Fire(DoorId, OpenDuration, "Unlock", false)
					game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
					task.wait(OpenDuration)
					game:GetService("TweenService"):Create(Gui.ImageLabelPressed, TweenInfo.new(0.75, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
					return
				end
			end
		end
	end
	
	pcall(function()ClickDetector.MouseClick:Connect(function(plr) onClick(plr) end)end)
	pcall(function()Prompt.Triggered:Connect(function(plr) onClick(plr) end)end)
end

function Swing:Beta(DoorModel)
	-- SÐTTINGS
	----print(DoorModel)
	
	--[[if not game.StarterGui:FindFirstChild("rDoorsBetaEndNotify") then
		--print("aasdasd")
		local r = Instance.new("ScreenGui")
		r.IgnoreGuiInset = true
		local frame = Instance.new("Frame")
		frame.Parent = r
		frame.Size = UDim2.fromScale(1, 0.07)
		frame.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
		local text = Instance.new("TextLabel")
		text.Parent = frame
		text.Size = UDim2.fromScale(1, 1)
		text.BackgroundTransparency = 1
		text.Font = Enum.Font.Ubuntu
		text.TextScaled = true
		text.TextColor3 = Color3.fromRGB(255, 255, 255)
		text.Text = "Hey! rDoors action reqiured. Please, check our community server for more information."
		local btn = Instance.new("TextButton")
		btn.BackgroundTransparency = 1
		btn.TextTransparency = 1
		btn.Parent = frame
		btn.MouseButton1Click:Connect(function()
			r:Destroy()
		end)
		r.Name = "rDoorsBetaEndNotify"
		r.Parent = game.StarterGui
	end]]
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
	----print(CardReaderIn, CardReaderOut, ButtonIn, ButtonOut)
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
		----print(doorId)
		if Val == doorId and test == false then
			----print(todo)
			DoorLocked = false
			wait(OpenDuration)
			DoorLocked = true
		end
	end)

end

return Swing
