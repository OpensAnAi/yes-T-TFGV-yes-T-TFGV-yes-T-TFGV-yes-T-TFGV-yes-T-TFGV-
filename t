
-- Variable to hold connections
local animationConnections = {}

local TweenService = game:GetService("TweenService")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local color = Color3.new(0, 0.482353, 1)
local color2 = Color3.new(0, 0.0666667, 1)
local colorSequence = ColorSequence.new(color, color2)

local function stopSoundById(soundId)
	for _, sound in ipairs(workspace:GetDescendants()) do
		if sound:IsA("Sound") and sound.SoundId == soundId then
			if sound.Playing then
				sound:Stop() -- Stops the sound if it is currently playing
			end
		end
	end
end

local function setupArmEffects(arm, start)
	print("setupArmEffects called with start =", start)

	-- Check if ArmEffects already exists
	local armEffects = arm:FindFirstChild("ArmEffects") -- Adjust based on your hierarchy
	if not armEffects then
		-- Clone the arm effects from ReplicatedStorage
		armEffects = game.ReplicatedStorage.Resources.FiveSeasonsFX["CharFX"].ArmEnabled:Clone()
		armEffects.Name = "ArmEffects" -- Set a name for future reference
		armEffects.Parent = arm
	end

	-- Iterate through the particle emitters in ArmEffects
	for _, child in ipairs(armEffects:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			print("Found ParticleEmitter:", child.Name)
			
			child.Color = colorSequence

			-- Start or stop emissions based on the start flag
			if start then
				if child.Name == "a1" or child.Name == "CE1Spread" then
					if child.Rate == 0 then
						print("Starting particle emission for:", child.Name)
						child.Rate = 20 -- Set the rate to emit particles
						child.Color = colorSequence -- Assuming colorSequence is defined elsewhere
						child:Emit(20) -- Emit 20 particles
					end
				else
					print("Destroying child:", child.Name)
					child:Destroy() -- Destroy other particle emitters
				end
			else
				if child.Name == "a1" or child.Name == "CE1Spread" then
					if child.Rate > 0 then
						print("Stopping particle emission for:", child.Name)
						child.Rate = 0 -- Stop emitting particles
						
						child.Color = colorSequence
						print("Rate set to 0 for:", child.Name) -- Debug the rate
					end
				else
					print("Destroying child:", child.Name)
					child:Destroy() -- Destroy other particle emitters
				end
			end
		end
	end
end



local function spawnMangaBillboard(player, message)
	-- Get the player's character
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

	-- Create a new BillboardGui
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 100, 0, 150) -- Fixed size in pixels
	billboard.Adornee = humanoidRootPart
	billboard.StudsOffset = Vector3.new(4.2, -25, 0) -- Start position at ground level
	billboard.AlwaysOnTop = true

	-- Create a frame for the outline
	local outline = Instance.new("Frame", billboard)
	outline.Size = UDim2.new(1, 1, 1, 1) -- Slightly larger for the outline
	outline.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black color
	outline.BorderSizePixel = 1 -- No border

	-- Create a frame for the content
	local frame = Instance.new("Frame", billboard)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White background
	frame.BackgroundTransparency = 0 -- Ensure it's fully opaque

	-- Add UICorner for rounded corners
	local uiCorner = Instance.new("UICorner", frame)
	uiCorner.CornerRadius = UDim.new(0, 2) -- Corner radius for the frame

	-- Create a TextLabel for displaying text
	local textLabel = Instance.new("TextLabel", frame)
	textLabel.Size = UDim2.new(1, 0, 1, 0) -- Full size
	textLabel.Text = message -- Set the text to the passed message
	textLabel.BackgroundTransparency = 1 -- Make the background transparent
	textLabel.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text color
	textLabel.TextScaled = false -- Disable text scaling
	textLabel.Font = Enum.Font.SourceSansItalic -- Change this to your desired italic font
	textLabel.TextSize = 24 -- Set the text size as needed
	textLabel.TextStrokeTransparency = 0.5 -- Optional: Add a stroke for better visibility
	textLabel.TextWrapped = true

	-- Parent the BillboardGui to the Workspace
	billboard.Parent = workspace

	-- Tween the billboard to rise up to the player's height
	local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local tweenInfo2 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tween = TweenService:Create(billboard, tweenInfo, {StudsOffset = Vector3.new(4.2, 1.2, 0)})

	-- Start the tween
	tween:Play()


	tween.Completed:Connect(function()
		wait(3.5)
		local downTween = TweenService:Create(billboard, tweenInfo2, {StudsOffset = Vector3.new(4.2, -25, 0)})
		downTween:Play()
		downTween.Completed:Connect(function()
			billboard:Destroy()
		end)

	end)
end


local function spawnMangaBillboard2(player, message)
	-- Get the player's character
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

	-- Create a new BillboardGui
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 100, 0, 150) -- Fixed size in pixels
	billboard.Adornee = humanoidRootPart
	billboard.StudsOffset = Vector3.new(-4.2, 25, 0) -- Start position at ground level
	billboard.AlwaysOnTop = true

	-- Create a frame for the outline
	local outline = Instance.new("Frame", billboard)
	outline.Size = UDim2.new(1, 1, 1, 1) -- Slightly larger for the outline
	outline.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black color
	outline.BorderSizePixel = 1 -- No border

	-- Create a frame for the content
	local frame = Instance.new("Frame", billboard)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White background
	frame.BackgroundTransparency = 0 -- Ensure it's fully opaque

	-- Add UICorner for rounded corners
	local uiCorner = Instance.new("UICorner", frame)
	uiCorner.CornerRadius = UDim.new(0, 2) -- Corner radius for the frame

	-- Create a TextLabel for displaying text
	local textLabel = Instance.new("TextLabel", frame)
	textLabel.Size = UDim2.new(1, 0, 1, 0) -- Full size
	textLabel.Text = message -- Set the text to the passed message
	textLabel.BackgroundTransparency = 1 -- Make the background transparent
	textLabel.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text color
	textLabel.TextScaled = false -- Disable text scaling
	textLabel.Font = Enum.Font.SourceSansItalic -- Change this to your desired italic font
	textLabel.TextSize = 24 -- Set the text size as needed
	textLabel.TextStrokeTransparency = 0.5 -- Optional: Add a stroke for better visibility
	textLabel.TextWrapped = true

	-- Parent the BillboardGui to the Workspace
	billboard.Parent = workspace

	-- Tween the billboard to rise up to the player's height
	local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local tweenInfo2 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tween = TweenService:Create(billboard, tweenInfo, {StudsOffset = Vector3.new(-4.2, -1.2, 0)})

	-- Start the tween
	tween:Play()


	tween.Completed:Connect(function()
		wait(3.5)
		local downTween = TweenService:Create(billboard, tweenInfo2, {StudsOffset = Vector3.new(-4.2, 25, 0)})
		downTween:Play()
		downTween.Completed:Connect(function()
			billboard:Destroy()
		end)

	end)
end



local function updateWalkSpeed(speed)
	local position = character.PrimaryPart.Position -- Get the character's position

	-- Change walkspeed based on the Y coordinate
	if position.Y > 50 then
		humanoid.WalkSpeed = speed -- Faster speed
	elseif position.Y > 20 then
		humanoid.WalkSpeed = speed -- Normal speed
	else
		humanoid.WalkSpeed = speed -- Slower speed
	end
end


local RunService = game:GetService("RunService")

local function CameraShake(intensity, duration)
	local player = game.Players.LocalPlayer
	local camera = workspace.CurrentCamera
	local startTime = tick()

	local connection
	connection = RunService.RenderStepped:Connect(function()
		local elapsedTime = tick() - startTime
		if elapsedTime > duration then
			connection:Disconnect() -- Stop shaking after duration
			camera.CFrame = camera.CFrame -- Reset the camera
		else
			local shakeMagnitude = intensity * (1 - (elapsedTime / duration)) -- Fade out shake over time
			local offset = Vector3.new(
				math.random() * shakeMagnitude - shakeMagnitude / 2,
				math.random() * shakeMagnitude - shakeMagnitude / 2,
				math.random() * shakeMagnitude - shakeMagnitude / 2
			)
			camera.CFrame = camera.CFrame * CFrame.new(offset) -- Apply shake offset
		end
	end)
end


local TweenService = game:GetService("TweenService")
local camera = game.Workspace.CurrentCamera


local function tweenFOV(targetFOV, duration)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
	local tween = TweenService:Create(camera, tweenInfo, { FieldOfView = targetFOV })
	tween:Play()
end	


local heartbeatConnection -- Variable to store the connection

local function StartWS(speed)
	if not heartbeatConnection then
		heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
			updateWalkSpeed(speed)
		end)
	end
end

local function StopWS()
	if heartbeatConnection then
		heartbeatConnection:Disconnect()
		heartbeatConnection = nil -- Reset the connection variable
	end
end

local function createCloneTrail(secs, timer)
	local player = game.Players.LocalPlayer
	local character = player.Character

	if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
		-- Remove the player's face if they are invisible
		local head = character:FindFirstChild("Head")
		if head then
			local face = head:FindFirstChild("face")
			if face then
				face:Destroy()
			end
		end

		for i = 1, 10 do
			spawn(function()
				local clone = character:Clone()
				clone.Parent = workspace

				-- Remove all accessories
				for _, accessory in pairs(clone:GetChildren()) do
					if accessory:IsA("Accessory") or accessory:IsA("Hat") then
						accessory:Destroy()
					end
				end

				-- Remove the face from the clone
				head = clone:FindFirstChild("Head")
				if head then
					local face = head:FindFirstChild("face")

					if face then
						face:Destroy()
					end
				end

				clone:FindFirstChild("Hitbox_LeftArm"):Destroy()
				clone:FindFirstChild("Hitbox_RightArm"):Destroy()
				clone:FindFirstChild("Hitbox_LeftLeg"):Destroy()
				clone:FindFirstChild("Hitbox_RightLeg"):Destroy()

				local debris = character:FindFirstChild("Small Debris")
				local debris2 = character:FindFirstChild("UsedDash")

				if debris then
					game.Debris:AddItem(debris, 0)
				end

				if debris2 then
					game.Debris:AddItem(debris2, 0)
				end

				-- Remove nametags
				for _, descendant in pairs(clone:GetDescendants()) do
					if descendant:IsA("BillboardGui") or descendant:IsA("TextLabel") then
						descendant:Destroy()
					end
				end

				-- Set all parts to have no collision
				for _, part in pairs(clone:GetDescendants()) do
					if part:IsA("BasePart") then
						part.Anchored = true
						part.CanCollide = false
						part.Transparency = 0.4
						part.CastShadow = false
						part.Color = Color3.new(0.654902, 0.654902, 0.654902)
						part.Material = Enum.Material.Neon
					end
				end

				-- Set the HumanoidRootPart to have no collision
				local humanoidRootPart = clone:FindFirstChild("HumanoidRootPart")
				if humanoidRootPart then
					humanoidRootPart.Anchored = true
					humanoidRootPart.CanCollide = false
					humanoidRootPart.Transparency = 1
					humanoidRootPart.CastShadow = false
				end

				-- Remove the Humanoid
				local humanoid = clone:FindFirstChild("Humanoid")
				if humanoid then
					humanoid:Destroy()
				end

				local tweenService = game:GetService("TweenService")
				local tweenInfo = TweenInfo.new(secs, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
				for _, part in pairs(clone:GetDescendants()) do
					if part:IsA("BasePart") then
						local tween = tweenService:Create(part, tweenInfo, {Transparency = 1})
						tween:Play()
					end
				end

				game:GetService("Debris"):AddItem(clone, 3)

			end)
			wait(timer)
		end
	end
end




local player = game.Players.LocalPlayer
local character = player.Character
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local hitbox = Instance.new("Part")
hitbox.Size = Vector3.new(10, 5, 10)
hitbox.Anchored = false
hitbox.Massless = true
hitbox.CanCollide = false
hitbox.Transparency = 1
hitbox.Parent = workspace

-- Position the hitbox relative to the HumanoidRootPart
hitbox.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, -1.5)

-- Create and attach the weld constraint
local weld = Instance.new("WeldConstraint")
weld.Part0 = humanoidRootPart
weld.Part1 = hitbox
weld.Parent = hitbox

local target = nil
local maxDistance = 60 -- Maximum distance to consider a target "near"

-- Function to check if a part is a valid target
local function isValidTarget(part)
	return part.Parent and part.Parent:FindFirstChild("Humanoid") and part.Parent ~= character
end

-- Function to update the target
local function updateTarget()
	local closestDistance = maxDistance
	local closestTarget = nil

	for _, part in ipairs(workspace:GetPartsInPart(hitbox)) do
		if isValidTarget(part) then
			local distance = (part.Position - humanoidRootPart.Position).Magnitude
			if distance < closestDistance then
				closestDistance = distance
				closestTarget = part.Parent
			end
		end
	end

	target = closestTarget
end

-- Update target periodically
game:GetService("RunService").Heartbeat:Connect(function()
	updateTarget()
	-- You can use the 'target' variable here or in other parts of your code
	if target then
		-- HAS TARGET
	else
		-- NO TARGET)
	end
end)

local uis = game:GetService("UserInputService")
local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Lapse Blue [E]")

local wantsthescriptagain = false





local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local hotbar = playerGui:FindFirstChild("Hotbar")
if hotbar then
	local backpack = hotbar:FindFirstChild("Backpack")
	if backpack then
		local hotbarFrame = backpack:FindFirstChild("Hotbar")

		-- Change Tool Names
		function changeToolName(slot, newName)
			local baseButton = hotbarFrame:FindFirstChild(tostring(slot)) and hotbarFrame[tostring(slot)].Base
			if baseButton then
				local ToolName = baseButton:FindFirstChild("ToolName")
				if ToolName then
					ToolName.Text = newName
				end
			end
		end

		changeToolName(1, "Reversal Red")
		changeToolName(2, "Lapse BeatDown")
		changeToolName(3, "Raw Strength")
		changeToolName(4, "Lapse Combo")
	end
end


-- Function to handle animation with optional start time
function onAnimation(id, func, startTime)
	local id = tostring(id):gsub("rbxassetid://", "")
	local char = game.Players.LocalPlayer.Character
	local humanoid = char and char:WaitForChild("Humanoid", 1)

	if char and humanoid then
		humanoid.AnimationPlayed:Connect(function(v)
			local vID = v.Animation.AnimationId:gsub("rbxassetid://", "")
			if id == vID then
				if startTime then
					-- Skip to the specific time in the animation
					v.TimePosition = startTime
				end
				func(v)
			end
		end)
	end
end

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")








onAnimation("12510170988", function(animationTrack) -- place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://18897119503" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(1.21)

	local main = 106927012797463
	local carrier = game:GetObjects("rbxassetid://" .. main)[1]		
	carrier.Anchored = false
	carrier.Parent = game.Workspace

	local wind2 = carrier:FindFirstChild("Wind2")
	local wind3 = carrier:FindFirstChild("Wind")
	local shoot = carrier:FindFirstChild("Shoot")
	local crack = carrier:FindFirstChild("Crack")



	local thread = task.delay(0, function()
		humanoidRootPart.Anchored = true
		task.wait(1.2)
		humanoidRootPart.Anchored = false

	end)



	if target:FindFirstChild("HumanoidRootPart") and target:FindFirstChild("Humanoid").Health > 16 then


		wind2.Parent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
		wind3.Parent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
		crack.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart

		wait(.2)

		for _, child in ipairs(crack:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child.Enabled = true
			end
		end

		wait(.1)

		for _, child in ipairs(crack:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child.Enabled = false
			end
		end


		local enem = target

		local character = game.Players.LocalPlayer.Character
		local parts = character:GetDescendants()

		local h1 = character:WaitForChild("Hitbox_LeftArm")
		local h2 = character:WaitForChild("Hitbox_RightArm")
		local h3 = character:WaitForChild("Hitbox_LeftLeg")
		local h4 = character:WaitForChild("Hitbox_RightLeg")

		local humanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")


		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://4826619573"
		s.Parent = game.Players.LocalPlayer.Character
		s.Volume = 1
		s.PlaybackSpeed = 1.1

		local s3 = Instance.new("Sound")
		s3.SoundId = "rbxassetid://4826619573"
		s3.Parent = game.Players.LocalPlayer.Character
		s3.Volume = 1
		s.PlaybackSpeed = 1.1

		local s2 = Instance.new("Sound")
		s2.SoundId = "rbxassetid://8595974357"
		s2.Parent = game.Players.LocalPlayer.Character
		s2.Volume = 10




		local Hit = game.ReplicatedStorage.Resources.FiveSeasonsFX.CharFX.TP:Clone()
		Hit.Parent = character:WaitForChild("HumanoidRootPart")

		local Hit2 = game.ReplicatedStorage.Resources.FiveSeasonsFX.CharFX.TP:Clone()
		Hit2.Parent = character:WaitForChild("HumanoidRootPart")

		s3:Play()


		CameraShake(5, .6)
		wait(.3)



		for _, child in ipairs(wind2:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child.Enabled = false
			end
		end

		for _, child in ipairs(wind3:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child.Enabled = false
			end
		end

		for _, part in ipairs(parts) do
			if part:IsA("BasePart") and part ~= humanoidRootPart and part ~= h1 and part ~= h2 and part ~= h3 and part ~= h4 then
				part.Transparency = 1
				part.CanCollide = false  -- Optionally make the parts non-collidable
			end
		end




		for _, child in ipairs(Hit:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child:Emit(22.5)
				game.Debris:AddItem(Hit, .5)
			end
		end




		s:Play()

		wait(.6)

		for _, part in ipairs(parts) do
			if part:IsA("BasePart") and part ~= humanoidRootPart and part ~= h1 and part ~= h2 and part ~= h3 and part ~= h4 then
				part.Transparency = 0
				part.CanCollide = true  -- Optionally make the parts non-collidable
			end
		end




		local weld = Instance.new("WeldConstraint")
		weld.Part0 = humanoidRootPart
		weld.Part1 = enem:WaitForChild("HumanoidRootPart")
		print("ok")

		for _, child in ipairs(Hit2:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child:Emit(22.5)
				game.Debris:AddItem(Hit2, .5)
			end
		end
		humanoidRootPart.CFrame = enem:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0,1,-1)

		print("yas?!")
		-- Load and play animation
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://17838619895"
		local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
		local Point = humanoid:LoadAnimation(animation)

		-- Start animation
		Point:Play()
		s2:Play()

		-- Fast-forward the animation by adjusting the TimePosition quickly
		
		Point:AdjustSpeed(2)

		-- Wait for animation to finish
		Point.Stopped:Wait()
		game.Debris:AddItem(weld, 0)


	end
	if target:FindFirstChild("Humanoid") and target.Humanoid.Health <= 16 then





		

		
		wait(.7)
		
		local infin3 = Instance.new("Sound")
		infin3.SoundId = "rbxassetid://4459572763"
		infin3.Parent = game.Workspace
		infin3.Volume = 3
		infin3:Play()
		
		local infin1 = Instance.new("Sound")
		infin1.SoundId = "rbxassetid://17173355584"
		infin1.Parent = game.Workspace
		infin1.Volume = 3.2
		infin1:Play()

		local infin2 = Instance.new("Sound")
		infin2.SoundId = "rbxassetid://17173354974"
		infin2.Parent = game.Workspace
		infin2.Volume = 3.2
		infin2:Play()
		


		local firstHit = game.ReplicatedStorage.Resources.KJEffects.DropkickExtra.firstHit:Clone()
		firstHit.Position = target:FindFirstChild("HumanoidRootPart").Position
		firstHit.Anchored = true
		firstHit.CFrame = target:FindFirstChild("HumanoidRootPart").CFrame
		firstHit.Parent = workspace.Thrown

		-- Emit particles from all ParticleEmitters in firstHit
		for _, v in firstHit:GetDescendants() do
			if v:IsA("ParticleEmitter") then
				local emitCount = v:GetAttribute("EmitCount") or 5 -- Default to 5 if not set
				v:Emit(emitCount)
			end
		end


		CameraShake(10, .3)
		





		game.Debris:AddItem(carrier, 1)
		game.Debris:AddItem(firstHit, 1)
		game.Debris:AddItem(infin1, 1)
		game.Debris:AddItem(infin2, 1)
		game.Debris:AddItem(infin3, 1)






	end



	local startTime = 0
	newAnimTrack.TimePosition = startTime

	local animDurationInSeconds = 5
	wait(animDurationInSeconds)
	newAnimTrack:Stop()
end)

onAnimation("10479335397", function(animationTrack) -- place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://17838006839" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(2)

	local main = 104293784565105  -- Make sure this ID is correct
	local carrier = game:GetObjects("rbxassetid://" .. main)[1]


	carrier.Parent = game.Workspace

	local dashvfx = carrier:FindFirstChild("tpthing")

	dashvfx.Rate = 0
	dashvfx.Parent = humanoidRootPart
	dashvfx:Emit(10)

	task.wait(.1)





	local h1 = character:WaitForChild("Hitbox_LeftArm")
	local h2 = character:WaitForChild("Hitbox_RightArm")
	local h3 = character:WaitForChild("Hitbox_LeftLeg")
	local h4 = character:WaitForChild("Hitbox_RightLeg")
	local parts = character:GetDescendants()


	for _, part in ipairs(parts) do
		if part:IsA("BasePart") and part ~= humanoidRootPart and part ~= h1 and part ~= h2 and part ~= h3 and part ~= h4 then
			part.Transparency = 1
			part.CanCollide = false  -- Optionally make the parts non-collidable
		end
	end


	createCloneTrail(.3, 0)

	CameraShake(1, .1)

	wait(.4)

	dashvfx:Emit(10)

	for _, part in ipairs(parts) do
		if part:IsA("BasePart") and part ~= humanoidRootPart and part ~= h1 and part ~= h2 and part ~= h3 and part ~= h4 then
			part.Transparency = 0
			part.CanCollide = true  -- Optionally make the parts non-collidable
		end
	end

	game.Debris:AddItem(dashvfx, .3)
	game.Debris:AddItem(carrier, .3)





	local startTime = 0
	newAnimTrack.TimePosition = startTime

	local animDurationInSeconds = 5
	wait(animDurationInSeconds)
	newAnimTrack:Stop()
end)

onAnimation("12447707844", function(animationTrack) -- place old anim here

	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://14733282425" -- Place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	local player = game.Players.LocalPlayer
	local UserInputService = game:GetService("UserInputService")
	local StarterPlayer = game:GetService("StarterPlayer")
	local camera = workspace.CurrentCamera

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(1)

	local startTime = 3.1
	newAnimTrack.TimePosition = startTime

	spawnMangaBillboard(player, "You really thought...")
	wait(.4)
	spawnMangaBillboard2(player, "You Could Beat me?!")
	



	
	wait(.6)

	newAnimTrack:AdjustSpeed(0)

	local color = Color3.new(0, 0.482353, 1)
	local color2 = Color3.new(0, 0.0666667, 1)
	local colorSequence = ColorSequence.new(color, color2)

	-- Left Arm
	setupArmEffects(player.Character["Left Arm"], true)
	setupArmEffects(player.Character["Right Arm"], true)

	-- Get the player's head position
	local head = player.Character:FindFirstChild("Head")
	local originalCFrame = camera.CFrame

	if head then
		-- Set the camera to look at the player's face
		camera.CameraType = Enum.CameraType.Scriptable
		camera.CFrame = CFrame.new(head.Position + Vector3.new(0, 0.5, 5), head.Position) -- Adjust position as needed
	end

	-- Reset camera view after the animation
	wait(3)
	
	changeToolName(1, "Maximum Red")
	changeToolName(2, "Limitless Purple")
	changeToolName(3, "Hollow Purple")
	changeToolName(4, "?")

	setupArmEffects(player.Character["Left Arm"], false)
	setupArmEffects(player.Character["Right Arm"], false)

	player.Character.HumanoidRootPart.Anchored = false

	camera.CameraType = Enum.CameraType.Custom

	newAnimTrack:AdjustSpeed(1)


	
	game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

	local animDurationInSeconds = 5
	wait(animDurationInSeconds)
	newAnimTrack:Stop()


end)




onAnimation("10480793962", function(animationTrack) -- place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://15957361339" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(3.5)

	local character = game.Players.LocalPlayer.Character
	if not character then
		warn("Character not found")
		return
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		warn("HumanoidRootPart not found")
		return
	end

	local h1 = character:WaitForChild("Hitbox_LeftArm")
	local h2 = character:WaitForChild("Hitbox_RightArm")
	local h3 = character:WaitForChild("Hitbox_LeftLeg")
	local h4 = character:WaitForChild("Hitbox_RightLeg")
	local parts = character:GetDescendants()

	local function setParts(transparency, canCollide)
		for _, part in ipairs(parts) do
			if part:IsA("BasePart") and part ~= humanoidRootPart and part ~= h1 and part ~= h2 and part ~= h3 and part ~= h4 then
				part.Transparency = transparency
				part.CanCollide = canCollide
			end
		end
	end

	setParts(1, false)
	CameraShake(1, .1)

	local main = 104293784565105  -- Make sure this ID is correct
	local carrier = game:GetObjects("rbxassetid://" .. main)[1]

	if carrier then
		carrier.Parent = game.Workspace

		local dashvfx = carrier:FindFirstChild("tpthing")
		if dashvfx then
			dashvfx.Rate = 0
			dashvfx.Parent = humanoidRootPart
			dashvfx:Emit(10)

			task.wait(.1)

			setParts(0, true)

			game.Debris:AddItem(dashvfx, .3)
		else
			warn("tpthing not found in carrier")
		end
	else
		warn("Failed to load asset")
	end



	local startTime = 0
	newAnimTrack.TimePosition = startTime

	local animDurationInSeconds = .3
	wait(animDurationInSeconds)
	newAnimTrack:Stop()
end)




onAnimation("10480796021", function(animationTrack) -- place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://15957361339" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(3.5)

	local character = game.Players.LocalPlayer.Character
	if not character then
		warn("Character not found")
		return
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		warn("HumanoidRootPart not found")
		return
	end

	local h1 = character:WaitForChild("Hitbox_LeftArm")
	local h2 = character:WaitForChild("Hitbox_RightArm")
	local h3 = character:WaitForChild("Hitbox_LeftLeg")
	local h4 = character:WaitForChild("Hitbox_RightLeg")
	local parts = character:GetDescendants()

	local function setParts(transparency, canCollide)
		for _, part in ipairs(parts) do
			if part:IsA("BasePart") and part ~= humanoidRootPart and part ~= h1 and part ~= h2 and part ~= h3 and part ~= h4 then
				part.Transparency = transparency
				part.CanCollide = canCollide
			end
		end
	end

	setParts(1, false)
	CameraShake(1, .1)

	local main = 104293784565105  -- Make sure this ID is correct
	local carrier = game:GetObjects("rbxassetid://" .. main)[1]

	if carrier then
		carrier.Parent = game.Workspace

		local dashvfx = carrier:FindFirstChild("tpthing")
		if dashvfx then
			dashvfx.Rate = 0
			dashvfx.Parent = humanoidRootPart
			dashvfx:Emit(10)

			task.wait(.1)

			setParts(0, true)

			game.Debris:AddItem(dashvfx, .3)
		else
			warn("tpthing not found in carrier")
		end
	else
		warn("Failed to load asset")
	end



	local startTime = 0
	newAnimTrack.TimePosition = startTime

	local animDurationInSeconds = .3
	wait(animDurationInSeconds)
	newAnimTrack:Stop()
end)







-- Detect animation, stop the old animation, and replace it with the new one
onAnimation("10468665991", function(animationTrack) -- place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	-- Stop the old animation
	if animationTrack then
		animationTrack:Stop()
	end



	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://13073745835" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(1.2)

	local s = Instance.new("Sound")
	s.SoundId = "rbxassetid://1177475221"
	s.Parent = game.Workspace

	s:Play()

	local blackhitframe = Instance.new("ColorCorrectionEffect")
	blackhitframe.Enabled = false
	blackhitframe.Brightness = 1
	blackhitframe.Contrast = 0
	blackhitframe.Saturation = 0
	blackhitframe.TintColor = Color3.new(0, 0, 0)
	blackhitframe.Parent = game.Lighting

	local highlights = {}
	for _, player in ipairs(game.Players:GetPlayers()) do
		local character = player.Character or player.CharacterAdded:Wait()
		local whitehitframe = Instance.new("Highlight")
		whitehitframe.Enabled = false -- Initially disabled
		whitehitframe.FillColor = Color3.new(1, 0, 0) -- White color
		whitehitframe.FillTransparency = 0 -- Fully opaque
		whitehitframe.Parent = character -- Parent it to the player's character
		-- Store the highlight in the table
		highlights[player] = whitehitframe
	end

	-- Function to enable or disable highlights
	local function setHighlightsEnabled(enabled)
		for _, highlight in pairs(highlights) do
			highlight.Enabled = enabled
		end
	end



	local freeze = game.Players.LocalPlayer.Character:FindFirstChild("Freeze")
	freeze:Destroy()


	wait(.1)


	local assetId = 135518188305031
	local assetid2 = 108600919694595

	local wind = game:GetObjects("rbxassetid://" .. assetId)[1]
	local red = game:GetObjects("rbxassetid://" .. assetid2)[1]

	local main = 106927012797463
	local carrier = game:GetObjects("rbxassetid://" .. main)[1]		
	carrier.Anchored = false
	carrier.Parent = game.Workspace

	local wind2 = carrier:FindFirstChild("Wind2")
	local wind3 = carrier:FindFirstChild("Wind")
	local shoot = carrier:FindFirstChild("Shoot")
	local crack = carrier:FindFirstChild("Crack")




	wind2.Parent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
	wind3.Parent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
	crack.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart








	local rightarm = character:WaitForChild("Right Arm")

	wind.Parent = game.Workspace
	red.Parent = game.Workspace
	wind.Anchored = false
	red.Anchored = false
	local weld = Instance.new("WeldConstraint")
	red.CFrame = player.Character:WaitForChild("Right Arm").CFrame * CFrame.new(0,-2,0)


	wind.CFrame = red.CFrame * CFrame.Angles(math.rad(-90), 0, 0)

	spawnMangaBillboard2(game.Players.LocalPlayer, "Reverse Cursed Technique")



	weld.Part0 = red
	weld.Part1 = rightarm
	weld.Parent = game.Workspace

	local weld2 = Instance.new("WeldConstraint")
	weld2.Part0 = wind
	weld2.Part1 = red
	weld2.Parent = game.Workspace




	wait(.48)

	spawnMangaBillboard(game.Players.LocalPlayer, "Red.")

	for _, child in ipairs(wind3:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end


	for _, child in ipairs(wind2:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	wait(.1)

	red:Destroy()
	wind:Destroy()
	weld:Destroy()
	weld2:Destroy()

	carrier.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, -35)
	carrier.Transparency = 1



	local WELED = Instance.new("WeldConstraint")
	WELED.Parent = game.Workspace

	WELED.Part0 = game.Players.LocalPlayer.Character.HumanoidRootPart
	WELED.Part1 = carrier	

	carrier.Anchored = true
	WELED:Destroy()


	for _, child in ipairs(wind3:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	for _, child in ipairs(shoot:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	for _, child in ipairs(crack:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	for _, child in ipairs(carrier:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	setHighlightsEnabled(true)
	blackhitframe.Enabled = true

	CameraShake(5, 1) -- Shake the camera with intensity 1 for 0.5 seconds


	wait(.1)



	setHighlightsEnabled(false)
	blackhitframe.Enabled = false


	local s2 = Instance.new("Sound")
	s2.SoundId = "rbxassetid://8625377966"
	s2.Parent = game.Workspace

	s2:Play()


	wait(.1)

	for _, child in ipairs(shoot:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end




	for _, child in ipairs(crack:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end



	wait(.2)

	for _, child in ipairs(carrier:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end









	wait(3)

	carrier:Destroy()

	wind2:Destroy()















	local startTime = 0
	newAnimTrack.TimePosition = startTime

	local animDurationInSeconds = 5
	wait(animDurationInSeconds)
	newAnimTrack:Stop()
end)

onAnimation("10471336737", function(animationTrack) -- place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)


	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://13560306510"
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)
	
	local newanim2 = Instance.new("Animation")
	newanim2.AnimationId = "rbxassetid://17859015788"
	local newAnimTrack2 = humanoid:LoadAnimation(newanim2)
	




	newAnimTrack:Play()

	newAnimTrack:AdjustSpeed(0)

	newAnimTrack.TimePosition = 0

	newAnimTrack:AdjustSpeed(1.7)






	-- Camera offset logic

	if target and target:IsA("Model") and target:FindFirstChild("Humanoid") then
	if target:FindFirstChild("Ragdoll") or target:FindFirstChild("Ragdoll Sim") then
		newAnimTrack:Stop()
		
		
		newAnimTrack2:Play()
		newAnimTrack2:AdjustSpeed(2)


		local connection
		spawn(function()
			local RunService = game:GetService("RunService")
			connection = RunService.Heartbeat:Connect(function()
				local char = game.Players.LocalPlayer.Character
				local root = char and char:WaitForChild("HumanoidRootPart", 1)
				local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
				if char and root and humanoid then
					local old = {cframe = root.CFrame, cameraoffset = humanoid.CameraOffset}
					humanoid.CameraOffset = Vector3.new(0, -4, 0)
					root.CFrame = root.CFrame * CFrame.Angles(math.rad(230),0,0)
					RunService.RenderStepped:Wait()
					root.CFrame = old.cframe
					humanoid.CameraOffset = old.cameraoffset
				end
			end)
		end)


		local stag = game.Workspace

		local Boom = Instance.new("Sound")
		Boom.SoundId = "rbxassetid://12982132788"  -- Replace with your audio ID
		Boom.Parent = stag
		Boom.Volume = 10


		local Woosh = Instance.new("Sound")
		Woosh.SoundId = "rbxassetid://9126228987"  -- Replace with your audio ID
		Woosh.Parent = stag
		Woosh.Volume = 3


		local BoomAfter = Instance.new("Sound")
		BoomAfter.SoundId = "rbxassetid://12982132685"  -- Replace with your audio ID
		BoomAfter.Parent = stag
		BoomAfter.Volume = 2





		local Normala = "rbxassetid://96871308529915"
		local Stronka = "rbxassetid://119502008988403"
		local Framea = "rbxassetid://82203786872374"
		local aftera = "rbxassetid://133722806034104"

		-- Load the assets
		local normalPart = game:GetObjects(Normala)[1] -- Load the Normal part
		local stronkPart = game:GetObjects(Stronka)[1] -- Load the Stronka part
		local framePart = game:GetObjects(Framea)[1] -- Load the Frame part
		local afterPart = game:GetObjects(aftera)[1] -- Load the after part



		local player = game.Players.LocalPlayer
		local character = player and player.Character
		local rightHand = character and (character:FindFirstChild("RightLeg") or character:FindFirstChild("Right Leg")) -- Adjust for R6 or R15
		normalPart.Parent = rightHand

		local blackhitframe = Instance.new("ColorCorrectionEffect")
		blackhitframe.Enabled = false
		blackhitframe.Brightness = 1
		blackhitframe.Contrast = 0
		blackhitframe.Saturation = 0
		blackhitframe.TintColor = Color3.new(0, 0, 0)
		blackhitframe.Parent = game.Lighting

		local highlights = {}
		for _, player in ipairs(game.Players:GetPlayers()) do
			local character = player.Character or player.CharacterAdded:Wait()
			local whitehitframe = Instance.new("Highlight")
			whitehitframe.Enabled = false -- Initially disabled
			whitehitframe.FillColor = Color3.new(1, 1, 1) -- White color
			whitehitframe.FillTransparency = 0 -- Fully opaque
			whitehitframe.Parent = character -- Parent it to the player's character
			-- Store the highlight in the table
			highlights[player] = whitehitframe
		end

		-- Function to enable or disable highlights
		local function setHighlightsEnabled(enabled)
			for _, highlight in pairs(highlights) do
				highlight.Enabled = enabled
			end
		end

		-- Example usage: enable highlights


		local taghum = target:FindFirstChild("HumanoidRootPart")



		normalPart.CFrame = rightHand.CFrame * CFrame.new(0, -rightHand.Size.Y/3, 0) -- Adjust the offset if necessary

		-- Create a weld to keep the effect attached
		local weld = Instance.new("Weld")
		weld.Part0 = rightHand
		weld.Part1 = normalPart
		weld.C0 = CFrame.new(0, -rightHand.Size.Y/28, -0.75) -- Adjust the offset if necessary
		weld.Parent = rightHand

		Woosh:Play()

		wait(0.15)

		game.Debris:AddItem(weld, 0)
		game.Debris:AddItem(normalPart, 0)

		stronkPart.Parent = rightHand


		stronkPart.CFrame = rightHand.CFrame * CFrame.new(0, -rightHand.Size.Y/3, 0) -- Adjust the offset if necessary

		-- Create a weld to keep the effect attached
		local weld2 = Instance.new("Weld")
		weld2.Part0 = rightHand
		weld2.Part1 = stronkPart
		weld2.C0 = CFrame.new(0, -rightHand.Size.Y/28, -0.75) -- Adjust the offset if necessary
		weld2.Parent = rightHand


		game.Debris:AddItem(weld2, .4)
		game.Debris:AddItem(stronkPart, .4)

		wait(.3)
		Boom:Play()
		CameraShake(10, .6)


		setHighlightsEnabled(true)

		blackhitframe.Enabled = true



		framePart.Parent = taghum


		--framePart.CFrame = taghum.CFrame * CFrame.new(0, -taghum.Size.Y/3, 0) -- Adjust the offset if necessary

		-- Create a weld to keep the effect attached
		local weld3 = Instance.new("Weld")
		weld3.Part0 = taghum
		weld3.Part1 = framePart
		weld3.Parent = taghum


		game.Debris:AddItem(weld3, .5)
		game.Debris:AddItem(framePart, .35)

		wait(.05)
		BoomAfter:Play()




		local thread = task.delay(.1, function()
			setHighlightsEnabled(false)

			blackhitframe.Enabled = false
		end)


		game.Debris:AddItem(blackhitframe, 0)


		afterPart.Parent = rightHand


		afterPart.CFrame = rightHand.CFrame * CFrame.new(0, -rightHand.Size.Y/3, 0) -- Adjust the offset if necessary

		-- Create a weld to keep the effect attached
		local weld4 = Instance.new("Weld")
		weld4.Part0 = rightHand
		weld4.Part1 = afterPart
		weld4.Parent = rightHand


		game.Debris:AddItem(weld4, .2)
		game.Debris:AddItem(afterPart, .2)





		wait(.3)

		connection:Disconnect()


		task.cancel(thread)

		wait(5)
		Woosh:Destroy()
		BoomAfter:Destroy()
		Boom:Destroy()
		
	else
		task.wait(0.5)
		newAnimTrack:Stop()

	end
	
	else
		task.wait(0.5)
		newAnimTrack:Stop()

	end

	







	local startTime = 0
	newAnimTrack.TimePosition = startTime

	local animDurationInSeconds = 5
	wait(animDurationInSeconds)
	newAnimTrack:Stop()
end)



onAnimation("10470104242", function(animationTrack) -- Place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://17838619895" -- Place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(3)
	
	wait(.2)

	-- Check if target is valid and is ragdolled
	if target and target:IsA("Model") and target:FindFirstChild("Humanoid") then
	

		local infin1 = Instance.new("Sound")
		infin1.SoundId = "rbxassetid://17173355584"
		infin1.Parent = game.Workspace
		infin1:Play()

		local infin2 = Instance.new("Sound")
		infin2.SoundId = "rbxassetid://17173354974"
		infin2.Parent = game.Workspace
		infin2:Play()

		local firstHit = game.ReplicatedStorage.Resources.KJEffects.DropkickExtra.firstHit:Clone()

		CameraShake(5, 0.4)
		
		

		local main = 117185667435879
		local carrier = game:GetObjects("rbxassetid://" .. main)[1]
		carrier.Anchored = true
		carrier.Parent = game.Workspace
		
		local punchfx = carrier:FindFirstChild("Punch")

		punchfx.Parent = target:FindFirstChild("HumanoidRootPart")

		for _, child in ipairs(punchfx:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child.Enabled = true
			end
		end

		wait(0.2)

		for _, child in ipairs(punchfx:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child.Enabled = false
			end
		end

		-- Check if HumanoidRootPart exists
		local humanoidRootPart = target:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			firstHit.Position = humanoidRootPart.Position
			firstHit.Anchored = true
			firstHit.CFrame = humanoidRootPart.CFrame
			firstHit.Parent = workspace.Thrown

			-- Emit particles from all ParticleEmitters in firstHit
			for _, v in firstHit:GetDescendants() do
				if v:IsA("ParticleEmitter") then
					local emitCount = v:GetAttribute("EmitCount") or 5 -- Default to 5 if not set
					v:Emit(emitCount)
				end
			end
		else
			warn("HumanoidRootPart not found in target.")
		end
	end
end)

onAnimation("10503381238", function(animationTrack) -- Place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://14900168720" -- Place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(0)
	newAnimTrack.TimePosition = 1.3
	newAnimTrack:AdjustSpeed(1)

	wait(.2)

	-- Check if target is valid and is ragdolled
	if target and target:IsA("Model") and target:FindFirstChild("Humanoid") then


		local infin1 = Instance.new("Sound")
		infin1.SoundId = "rbxassetid://17173355584"
		infin1.Parent = game.Workspace
		infin1:Play()

		local infin2 = Instance.new("Sound")
		infin2.SoundId = "rbxassetid://17173354974"
		infin2.Parent = game.Workspace
		infin2:Play()

		local firstHit = game.ReplicatedStorage.Resources.KJEffects.DropkickExtra.firstHit:Clone()

		CameraShake(5, 0.4)



		local main = 117185667435879
		local carrier = game:GetObjects("rbxassetid://" .. main)[1]
		carrier.Anchored = true
		carrier.Parent = game.Workspace

		local punchfx = carrier:FindFirstChild("Punch")

		punchfx.Parent = target:FindFirstChild("HumanoidRootPart")

		for _, child in ipairs(punchfx:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child.Enabled = true
			end
		end

		wait(0.2)

		for _, child in ipairs(punchfx:GetChildren()) do
			if child:IsA("ParticleEmitter") then
				child.Enabled = false
			end
		end

		-- Check if HumanoidRootPart exists
		local humanoidRootPart = target:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart then
			firstHit.Position = humanoidRootPart.Position
			firstHit.Anchored = true
			firstHit.CFrame = humanoidRootPart.CFrame
			firstHit.Parent = workspace.Thrown

			-- Emit particles from all ParticleEmitters in firstHit
			for _, v in firstHit:GetDescendants() do
				if v:IsA("ParticleEmitter") then
					local emitCount = v:GetAttribute("EmitCount") or 5 -- Default to 5 if not set
					v:Emit(emitCount)
				end
			end
		else
			warn("HumanoidRootPart not found in target.")
		end
	end
end)


------------------- <M1S> -----------------------------------



onAnimation("10469643643", function(animationTrack) -- place old anim here
	


	
	
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://18181348446" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(2)

	if target and target:IsA("Model") and target:FindFirstChild("Humanoid") and 
		(not target:FindFirstChild("Ragdoll") and not target:FindFirstChild("Ragdoll Sim")) then

		wait(.1)
		
		local infin1 = Instance.new("Sound")
		infin1.SoundId = "rbxassetid://17173355584"
		infin1.Parent = game.Workspace
		infin1:Play()
		
		local infin2 = Instance.new("Sound")
		infin2.SoundId = "rbxassetid://17173354974"
		infin2.Parent = game.Workspace
		infin2:Play()
		
		CameraShake(5, .4)


		local main = 117185667435879
		local carrier = game:GetObjects("rbxassetid://" .. main)[1]
		carrier.Anchored = true
		carrier.Parent = game.Workspace

		local punchfx = carrier:FindFirstChild("Punch")

		if punchfx then
			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
					child.Rate = 40
				end
			end
			
			local firstHit = game.ReplicatedStorage.Resources.KJEffects.DropkickExtra.firstHit:Clone()

			-- Check if Right Arm exists
			local rightArm = char:FindFirstChild("Right Arm")
			if rightArm then
				firstHit.Position = target:FindFirstChild("HumanoidRootPart").Position
				firstHit.Anchored = true
				firstHit.CFrame = target:FindFirstChild("HumanoidRootPart").CFrame
				firstHit.Parent = workspace.Thrown

				-- Emit particles from all ParticleEmitters in firstHit
				for _, v in firstHit:GetDescendants() do
					if v:IsA("ParticleEmitter") then
						local emitCount = v:GetAttribute("EmitCount") or 5 -- Default to 5 if not set
						v:Emit(emitCount)
					end
				end
			else
				warn("Right Arm not found in character.")
			end

			punchfx.Parent = target:FindFirstChild("HumanoidRootPart")

			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = true
				end
			end

			wait(0.2)

			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
				end
			end

			wait(1)
			punchfx:Destroy()
			carrier:Destroy()
			firstHit:Destroy()
		end
	end
	






end)

onAnimation("10469639222", function(animationTrack) -- place old anim here

	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://17888705432" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(1.4)

	if target and target:IsA("Model") and target:FindFirstChild("Humanoid") and 
		(not target:FindFirstChild("Ragdoll") and not target:FindFirstChild("Ragdoll Sim")) then
		


		wait(.1)
		
		local infin1 = Instance.new("Sound")
		infin1.SoundId = "rbxassetid://13064223483"
		infin1.Parent = game.Workspace
		infin1:Play()
		
		CameraShake(3, .3)

		local main = 117185667435879
		local carrier = game:GetObjects("rbxassetid://" .. main)[1]
		carrier.Anchored = true
		carrier.Parent = game.Workspace

		local punchfx = carrier:FindFirstChild("Punch")

		if punchfx then
			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
					child.Rate = 40
				end
			end

			punchfx.Parent = target:FindFirstChild("HumanoidRootPart")

			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = true
				end
			end
			



			wait(0.2)

			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
				end
			end

			wait(1)
			punchfx:Destroy()
			carrier:Destroy()
		end
	end







end)

onAnimation("10469630950", function(animationTrack) -- place old anim here

	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://13296577783" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(1.4)

	if target and target:IsA("Model") and target:FindFirstChild("Humanoid") and 
		(not target:FindFirstChild("Ragdoll") and not target:FindFirstChild("Ragdoll Sim")) then

		wait(.1)
		
		local infin1 = Instance.new("Sound")
		infin1.SoundId = "rbxassetid://13064223291"
		infin1.Parent = game.Workspace
		infin1:Play()
		
		CameraShake(3, .3)

		local main = 117185667435879
		local carrier = game:GetObjects("rbxassetid://" .. main)[1]
		carrier.Anchored = true
		carrier.Parent = game.Workspace

		local punchfx = carrier:FindFirstChild("Punch")

		if punchfx then
			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
					child.Rate = 40
				end
			end

			punchfx.Parent = target:FindFirstChild("HumanoidRootPart")

			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = true
				end
			end

			wait(0.2)

			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
				end
			end

			wait(1)
			punchfx:Destroy()
			carrier:Destroy()
		end
	end
	






end)

onAnimation("10469493270", function(animationTrack)

	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end


	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://16515503507"
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(1.4)

	if target and target:IsA("Model") and target:FindFirstChild("Humanoid") and 
		(not target:FindFirstChild("Ragdoll") and not target:FindFirstChild("Ragdoll Sim")) then
		
		wait(.1)
		
		local infin1 = Instance.new("Sound")
		infin1.SoundId = "rbxassetid://13064223399"
		infin1.Parent = game.Workspace
		infin1:Play()
		
		CameraShake(3, .3)
		local main = 117185667435879
		local carrier = game:GetObjects("rbxassetid://" .. main)[1]
		carrier.Anchored = true
		carrier.Parent = game.Workspace

		local punchfx = carrier:FindFirstChild("Punch")

		if punchfx then
			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
					child.Rate = 40
				end
			end

			punchfx.Parent = target:FindFirstChild("HumanoidRootPart")

			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = true
				end
			end

			wait(0.2)

			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
				end
			end

			wait(1)
			punchfx:Destroy()
			carrier:Destroy()
		end
	end
end)

onAnimation("12983333733", function(animationTrack)

	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end


	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://13071982935"
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(.75)
	
	local speaker = game.Players.LocalPlayer
	local char = speaker.Character


	local connection = game:GetService("RunService").RenderStepped:Connect(function()
		if char:FindFirstChild("CameraRig") then
			char:FindFirstChild("CameraRig"):Destroy()
		end
		--if char:FindFirstChild("NoRotate") then
		--char:FindFirstChild("NoRotate"):Destroy()
		--end
		--if char:FindFirstChild("Humanoid") then
		--	char:FindFirstChild("Humanoid").AutoRotate = true
		--end
	end)

	-- Unfreeze the character if applicable
	local freeze = speaker.Character:FindFirstChild("NoRotate")

	local redas = 132216835642399
	local blueas = 113552400168061

	local red = game:GetObjects("rbxassetid://" .. redas)[1]
	red.Parent = game.Workspace
	red.Anchored = true

	local blue = game:GetObjects("rbxassetid://" .. blueas)[1]
	blue.Parent = game.Workspace
	blue.Anchored = true


	local rChild = red:FindFirstChild("Summon")
	local bChild = blue:FindFirstChild("Summon")



	red.CFrame = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(-5, .25, 4)




	for _, child in ipairs(rChild:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end
	wait(.1)


	for _, child in ipairs(rChild:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end




















	wait(.5)

	for _, child in ipairs(bChild:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	blue.CFrame = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(5, .25, 4)



	wait(.1)
	for _, child in ipairs(bChild:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	wait(.9)





	local combas = 133664341581147
	local twiras = 108633043859440
	local combination = game:GetObjects("rbxassetid://" .. combas)[1]
	combination.Parent = game.Workspace
	combination.Anchored = true


	local twirlydirly = game:GetObjects("rbxassetid://" .. twiras)[1]
	twirlydirly.Parent = game.Workspace
	twirlydirly.Anchored = true




	local TweenService = game:GetService("TweenService")

	-- Set up tweening parameters
	local tweenInfo = TweenInfo.new(
		1, -- Time to complete the tween (1 second)
		Enum.EasingStyle.Linear, -- Easing style
		Enum.EasingDirection.InOut -- Easing direction
	)

	local tweenInfo13 = TweenInfo.new(
		1, -- Time to complete the tween (1 second)
		Enum.EasingStyle.Circular, -- Easing style
		Enum.EasingDirection.InOut -- Easing direction
	)

	local tweenInfo2 = TweenInfo.new(
		5, -- Time to complete the tween (1 second)
		Enum.EasingStyle.Circular, -- Easing style
		Enum.EasingDirection.InOut -- Easing direction
	)
	-- Calculate target positions for tween
	local targetRedPosition = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(-2.5, .25, 4) -- Move closer
	local targetBluePosition = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(2.5, .25, 4) -- Move closer

	local targetRedPosition2 = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, .25, 4) -- Move closer
	local targetBluePosition2 = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, .25, 4) -- Move closer

	local targetHollowPos = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 20, -999) -- Move closer


	-- Create tweens
	local tweenRed = TweenService:Create(red, tweenInfo, {CFrame = targetRedPosition})
	local tweenBlue = TweenService:Create(blue, tweenInfo, {CFrame = targetBluePosition})


	-- Create tweens
	local tweenRed2 = TweenService:Create(red, tweenInfo2, {CFrame = targetRedPosition2})
	local tweenBlue2 = TweenService:Create(blue, tweenInfo2, {CFrame = targetBluePosition2})

	-- Play the tweens
	tweenRed:Play()
	tweenBlue:Play()

	twirlydirly.CFrame = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, .25, 4)

	-- Wait for the tweens to finish
	wait(1)

	tweenRed2:Play()
	tweenBlue2:Play()

	combination.CFrame = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, .25, 4)







	wait(1.5)

	red:Destroy()
	blue:Destroy()
	combination:Destroy()

	local suk = twirlydirly:FindFirstChild("A1")


	for _, child in ipairs(suk:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	wait(.1)

	for _, child in ipairs(suk:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end








	if freeze then
		freeze:Destroy()
	end

	local hollowas = 72479224486644
	local hollow = game:GetObjects("rbxassetid://" .. hollowas)[1]
	hollow.Parent = game.Workspace

	hollow.CFrame = speaker.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, -30)

	local hollowweld = Instance.new("WeldConstraint")
	hollowweld.Part0 = speaker.Character.HumanoidRootPart
	hollowweld.Part1 = hollow
	hollowweld.Parent = game.Workspace

	hollow.Anchored = false

	hollow.Massless = true

	wait(1.5)
	hollow.Anchored = true
	hollowweld:Destroy()


	local tweenHollow = TweenService:Create(hollow, tweenInfo13, {CFrame = speaker.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 25, -999)})


	local trail = hollow:FindFirstChild("Wind")
	local trail1 = hollow:FindFirstChild("Dash")

	local aftertrail1 = hollow:FindFirstChild("Dash").LeftBeam1
	local aftertrail2 = hollow:FindFirstChild("Dash").LeftBeam2
	local aftertrail3 = hollow:FindFirstChild("Dash").RightBeam1
	local aftertrail4 = hollow:FindFirstChild("Dash").RightBeam2

	local attach1 = hollow:FindFirstChild("Dash").Attachment1

	local attach2 = hollow:FindFirstChild("Dash").Attachment2

	for _, child in ipairs(trail:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end


	aftertrail1.Enabled = true
	aftertrail2.Enabled = true
	aftertrail3.Enabled = true
	aftertrail4.Enabled = true


	for _, child in ipairs(attach1:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	for _, child in ipairs(attach2:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end



	tweenHollow:Play()

	changeToolName(1, "Reversal Red")
	changeToolName(2, "Lapse BeatDown")
	changeToolName(3, "Raw Strength")
	changeToolName(4, "Lapse Combo")





	wait(3)

	hollow:Destroy()

	twirlydirly:Destroy()

	connection:Disconnect()

	
	


end)

onAnimation("11343318134", function(animationTrack)

	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end


	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://15121659862"
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(.95)
	
	changeToolName(1, "Reversal Red")
	changeToolName(2, "Lapse BeatDown")
	changeToolName(3, "Raw Strength")
	changeToolName(4, "Lapse Combo")
	
	local main = 106927012797463
	local carrier3 = game:GetObjects("rbxassetid://" .. main)[1]		
	carrier3.Anchored = false
	carrier3.Parent = game.Workspace

	local wind2 = carrier3:FindFirstChild("Wind2")
	local wind3 = carrier3:FindFirstChild("Wind")
	local crack = carrier3:FindFirstChild("Crack")





	wind2.Parent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
	wind3.Parent = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
	crack.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart





	local main = 86087673966485 
	local carrier = game:GetObjects("rbxassetid://" .. main)[1]

	local main2 = 118776548858808 
	local carrier2 = game:GetObjects("rbxassetid://" .. main2)[1]


	carrier2.Parent = game.Workspace

	for _, child in ipairs(carrier2:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end



	carrier.Parent = game.Workspace

	carrier.Anchored = false
	carrier2.Anchored = false

	local summon = carrier:FindFirstChild("Summon")
	local orb = carrier:FindFirstChild("AttachmentA")





	local RunService = game:GetService("RunService")
	local player = game.Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	local camera = workspace.CurrentCamera
	local speaker = game.Players.LocalPlayer

	local speaker = game.Players.LocalPlayer

	workspace.CurrentCamera:remove()
	wait(.1)
	repeat wait() until speaker.Character ~= nil
	workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"
	speaker.CameraMinZoomDistance = 0.5
	speaker.CameraMaxZoomDistance = 400
	speaker.CameraMode = "Classic"
	speaker.Character.Head.Anchored = false


	RunService.RenderStepped:Connect(function()
		-- Check PlayerGui for "Death" and "Heavy VI"
		for _, child in ipairs(playerGui:GetChildren()) do
			if child.Name == "Death" or child.Name == "Heavy VI" then
				child:Destroy() -- Deletes the GUI element

			end
		end

		-- Check Character for "NoRotate"
		local character = player.Character
		if character then
			local noRotate = character:FindFirstChild("NoRotate") -- Updated name
			if noRotate then
				noRotate:Destroy() -- Deletes the "NoRotate" from Character

			end

		end
	end)

	carrier.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 1, -6.5)

	--carrier.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame * CFrame.Angles(math.rad(90), 1, -6.5)


	local weld = Instance.new("WeldConstraint")
	weld.Part0 = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
	weld.Part1 = carrier
	weld.Parent = game.Workspace


	CameraShake(1, 8)





	game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Phase,", "All")

	for _, child in ipairs(summon:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	for _, child in ipairs(wind3:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Rate = 30
			child.Enabled = true
		end
	end

	wait(1.3)
	game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Paramita,", "All")

	for _, child in ipairs(summon:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	for _, child in ipairs(orb:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end




	wait(1)


	game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Pillars of Light.", "All")
	carrier2.CFrame = carrier.CFrame * CFrame.Angles(math.rad(0), 0, 0)

	local wd = Instance.new("WeldConstraint")
	wd.Part0 = carrier2
	wd.Part1 = carrier
	wd.Parent = game.Workspace




	for _, child in ipairs(carrier2:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://13073745835"
	anim.Parent = game.Workspace

	local animationTrack = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):LoadAnimation(anim)


	newAnimTrack:Stop()
	animationTrack:Play()

	-- Slow down the animation by adjusting the TimePosition
	animationTrack.TimePosition = .8
	
	animationTrack:AdjustSpeed(0)

	wait(4)
	
	
	-- shoot

	local tweenInfo2 = TweenInfo.new(
		3, -- Time to complete the tween (1 second)
		Enum.EasingStyle.Linear, -- Easing style
		Enum.EasingDirection.InOut -- Easing direction
	)

	local tweenHollow = TweenService:Create(orb, tweenInfo2, {CFrame = CFrame.new(0, 1, 999)})

	for _, child in ipairs(wind3:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Rate = 50
			child.Enabled = true
		end
	end




	wait(1)




	for _, child in ipairs(wind3:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	for _, child in ipairs(wind2:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	for _, child in ipairs(crack:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	wait(1)





	CameraShake(99, .3)

	tweenHollow:Play()


	wind2:Destroy()
	wind3:Destroy()

	carrier:Destroy()

	carrier3.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 6, -35)
	carrier3.Transparency = 1
	
	animationTrack:Stop()



	local WELED = Instance.new("WeldConstraint")
	WELED.Parent = game.Workspace

	WELED.Part0 = game.Players.LocalPlayer.Character.HumanoidRootPart
	WELED.Part1 = carrier3	

	carrier3.Anchored = true
	WELED:Destroy()

	for _, child in ipairs(crack:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	for _, child in ipairs(carrier3:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = true
		end
	end

	wait(.3)

	animationTrack:Stop()

	for _, child in ipairs(crack:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	for _, child in ipairs(carrier3:GetChildren()) do
		if child:IsA("ParticleEmitter") then
			child.Enabled = false
		end
	end

	wait(4)
	orb:Destroy()
	carrier2:Destroy()



	wait(3)

	crack:Destroy()
	carrier3:Destroy()

	
	

end)


onAnimation("11343250001", function(animationTrack)

	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end


	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://17120750680"
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(1)
	
	wait(.4)
	
	newAnimTrack:AdjustSpeed(0)
	
	local player = game.Players.LocalPlayer
	local character = player.Character
	local camera = workspace.CurrentCamera

if character and character:FindFirstChild("HumanoidRootPart") then
		local originalPosition = character.HumanoidRootPart.CFrame

		local baseplate = Instance.new("Part")
		baseplate.Name = "TempBaseplate"
		baseplate.Size = Vector3.new(10, 1, 10)
		baseplate.Position = Vector3.new(0, -501, -1000000)
		baseplate.Anchored = true
		baseplate.Parent = workspace

		character.HumanoidRootPart.CFrame = CFrame.new(0, -500, -1000000)

		wait(2)

		character.HumanoidRootPart.CFrame = originalPosition

		camera.CameraType = Enum.CameraType.Custom
		camera.CFrame = character.HumanoidRootPart.CFrame
		
		spawnMangaBillboard(game.Players.LocalPlayer, "The Only Reason You Are The Strongest Sorcerer in History is Beacause...")
		wait(1)
		spawnMangaBillboard2(game.Players.LocalPlayer, "I Simply Was not Born yet.")

		wait(.9)

		newAnimTrack:AdjustSpeed(1)


		game.Debris:AddItem(baseplate, 3) -- Keep for 5 seconds for visibility
	else
		print("Character or HumanoidRootPart not found")
	end
	


end)













------------------- <M1S> -----------------------------------





onAnimation("15955393872", function(animationTrack) -- place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://18903642853" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(1.4)

	local TweenService = game:GetService("TweenService")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RunService = game:GetService("RunService")
	local Workspace = game:GetService("Workspace")
	local Lighting = game:GetService("Lighting")

	local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()

	-- Clone and setup WallFX
	local WallFX = ReplicatedStorage.Resources.Sorcerer.WallFX:Clone()
	WallFX:PivotTo(char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -6))
	WallFX.Parent = Workspace.Thrown

	-- Clone and setup Lighting
	local LightingEffect = ReplicatedStorage.Resources.Sorcerer.Lighting:Clone()
	LightingEffect.Parent = Lighting

	-- Clone and setup LimitlessBarrier
	local LimitlessBarrier = ReplicatedStorage.Resources.Sorcerer.LimitlessBarrier:Clone()
	LimitlessBarrier:PivotTo(char.HumanoidRootPart.CFrame)
	LimitlessBarrier.Parent = Workspace.Thrown

	-- Connection to update positions
	local connection = RunService.Heartbeat:Connect(function()
		WallFX:PivotTo(char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -6))
		LimitlessBarrier:PivotTo(char.HumanoidRootPart.CFrame)
	end)

	task.delay(7, function()
		LimitlessBarrier:Destroy()
		task.wait(2)
		WallFX:Destroy()
	end)

	local Sphere = LimitlessBarrier.Sphere

	-- Emit particles after a delay
	task.delay(0.085, function()
		for _, emitter in pairs(WallFX.FirstSlam:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter:Emit(emitter:GetAttribute("EmitCount"))
			end
		end
	end)

	task.delay(0.9, function()
		task.spawn(function()
			local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
			ColorCorrectionEffect.Name = "cloned"
			ColorCorrectionEffect.Parent = Lighting

			local BarrierScreen = LightingEffect.BarrierScreen
			TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Brightness = BarrierScreen.Brightness,
				Contrast = BarrierScreen.Contrast,
				Saturation = BarrierScreen.Saturation,
				TintColor = BarrierScreen.TintColor
			}):Play()

			task.wait(2)
			TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Brightness = 0,
				Contrast = 0,
				Saturation = 0
			}):Play()

			task.wait(1)
			ColorCorrectionEffect:Destroy()
		end)

		task.spawn(function()
			WallFX.Final.BarrierCrater.Transparency = 0
			WallFX.Final.FinalCrater.Transparency = 0
			WallFX.Final.FinalCrater.Color3 = Color3.fromRGB(100, 600, 2000)

			TweenService:Create(WallFX.Final.FinalCrater, TweenInfo.new(4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
				Color3 = Color3.fromRGB(0, 0, 0),
				Transparency = 1
			}):Play()

			task.wait(5)
			TweenService:Create(WallFX.Final.BarrierCrater, TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
				Transparency = 1
			}):Play()
		end)

		task.spawn(function()
			local Camera = Workspace.CurrentCamera
			TweenService:Create(Camera, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				FieldOfView = 80
			}):Play()

			task.wait(2.14)
			TweenService:Create(Camera, TweenInfo.new(1.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				FieldOfView = 65
			}):Play()
		end)

		-- Emit particles for the core effects
		local Appear = LimitlessBarrier.Core.Appear
		for _, emitter in pairs(Appear:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter:Emit(emitter.Name)
			end
		end

		local BarrierFX = LimitlessBarrier.Core.BarrierFX
		for _, emitter in pairs(BarrierFX:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter.Enabled = true
			end
		end

		task.delay(1, function()
			for _, emitter in pairs(BarrierFX:GetDescendants()) do
				if emitter:IsA("ParticleEmitter") then
					emitter.Enabled = false
				end
			end
		end)

		local BeamRings = LimitlessBarrier.Core.BeamRings
		for _, beam in pairs(BeamRings:GetDescendants()) do
			if beam:IsA("Beam") then
				beam.Enabled = true
				TweenService:Create(beam, TweenInfo.new(2.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Brightness = 0
				}):Play()
			end
		end

		-- Function to handle wind rings
		local function createWindRing()
			local WindRing = LimitlessBarrier.WindRing:Clone()
			local randomRotation = math.random(0, 360)
			WindRing:SetPrimaryPartCFrame(WindRing.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(randomRotation), 0))

			local StartPart = WindRing.Start
			local EndPart = WindRing.End
			local ClonedMesh = StartPart:Clone()
			ClonedMesh.Name = "ClonedMesh"
			ClonedMesh.Parent = LimitlessBarrier.CurrentTweens

			TweenService:Create(ClonedMesh.Decal, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Transparency = 0.9
			}):Play()

			TweenService:Create(ClonedMesh, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = EndPart.Size,
				CFrame = EndPart.CFrame
			}):Play()

			TweenService:Create(ClonedMesh.Mesh, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Scale = EndPart.Mesh.Scale
			}):Play()

			task.wait(0.2)
			TweenService:Create(ClonedMesh.Decal, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Transparency = 1
			}):Play()

			task.wait(1.2)
			ClonedMesh:Destroy()
		end

		-- Function to handle sphere appearance
		local function createSphere()
			local randomSize = math.random(24, 26)
			local ClonedSphere = Sphere:Clone()
			ClonedSphere.Name = "Cloned"
			ClonedSphere.Parent = LimitlessBarrier.CurrentTweens

			TweenService:Create(ClonedSphere, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Size = Vector3.new(randomSize, randomSize, randomSize),
				Transparency = 3.65
			}):Play()

			task.wait(0.2)
			TweenService:Create(ClonedSphere, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
				Size = Vector3.new(0, 0, 0),
				Transparency = 1
			}):Play()

			task.wait(0.2)
			ClonedSphere:Destroy()
		end

		-- Spawn effects
		task.spawn(function()
			for _ = 1, 13 do
				spawn(createSphere)
				task.wait(0.15)
			end
		end)

		for _ = 1, 13 do
			spawn(createWindRing)
			task.wait(0.15)
		end
	end)

	task.delay(2.65, function()
		local EndEmit = LimitlessBarrier.Core.EndEmit
		for _, emitter in pairs(EndEmit:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter:Emit(emitter:GetAttribute("EmitCount"))
			end
		end

		local Final = WallFX.Final
		for _, emitter in pairs(Final:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter:Emit(emitter:GetAttribute("EmitCount"))
			end
		end

		task.spawn(function()
			local ImpactFrameWhite = LightingEffect.ImpactFrameWhite
			ImpactFrameWhite.Enabled = true
			task.wait(0.045)
			ImpactFrameWhite.Enabled = false
			ImpactFrameWhite.Enabled = true
			task.wait(0.045)
			ImpactFrameWhite.Enabled = false

			local BarrierFinal = LightingEffect.BarrierFinal:Clone()
			BarrierFinal.Name = "cloned2"
			BarrierFinal.Parent = Lighting

			TweenService:Create(BarrierFinal, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Brightness = 0,
				Contrast = 0,
				Saturation = 0,
				TintColor = Color3.fromRGB(255, 255, 255)
			}):Play()

			connection:Disconnect()
			task.wait(1)
			BarrierFinal:Destroy()
		end)

		task.spawn(function()
			local Camera = Workspace.CurrentCamera
			TweenService:Create(Camera, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				FieldOfView = 98
			}):Play()
			task.wait(0.2)
			TweenService:Create(Camera, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				FieldOfView = 70
			}):Play()
		end)

		task.spawn(function()
			local WindRing = LimitlessBarrier.WindRing:Clone()
			local randomRotation = math.random(0, 360)
			WindRing:SetPrimaryPartCFrame(WindRing.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(randomRotation), 0))

			local StartPart = WindRing.Start
			local EndPart = WindRing.End2
			local ClonedMesh = StartPart:Clone()
			ClonedMesh.Name = "ClonedMesh"
			ClonedMesh.Parent = LimitlessBarrier.CurrentTweens

			TweenService:Create(ClonedMesh.Decal, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Transparency = 0.9
			}):Play()

			TweenService:Create(ClonedMesh, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Size = EndPart.Size,
				CFrame = EndPart.CFrame
			}):Play()

			TweenService:Create(ClonedMesh.Mesh, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
				Scale = EndPart.Mesh.Scale
			}):Play()

			task.wait(0.2)
			TweenService:Create(ClonedMesh.Decal, TweenInfo.new(5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				Transparency = 1
			}):Play()

			task.wait(5.2)
			ClonedMesh:Destroy()
		end)

		-- Function to create a glowing sphere effect
		local function createGlowingSphere()
			local randomSize = Random.new():NextNumber(55, 50)
			local ClonedSphere = Sphere:Clone()
			ClonedSphere.Name = "Cloned"
			ClonedSphere.Transparency = 0.01
			ClonedSphere.Material = Enum.Material.Neon
			ClonedSphere.Color = Color3.fromRGB(84, 150, 194)
			ClonedSphere.Parent = LimitlessBarrier.CurrentTweens

			TweenService:Create(ClonedSphere, TweenInfo.new(0.1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Size = Vector3.new(randomSize, randomSize, randomSize),
				Transparency = 1
			}):Play()

			task.wait(0.1)
			ClonedSphere:Destroy()



		end


		for _ = 1, 5 do
			spawn(createGlowingSphere)
			task.wait(0.065)
		end

		wait(.4)

		spawnMangaBillboard(player, "Next.")

	end)


	local startTime = 0
	newAnimTrack.TimePosition = startTime

	local animDurationInSeconds = 5
	wait(animDurationInSeconds)
	newAnimTrack:Stop()
end)

-- Connect to character added to setup the animation listener
local function setupAnimationListener()
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.Died:Connect(function()
			for _, connection in ipairs(animationConnections) do
				connection:Disconnect() -- Disconnect all animation connections
			end
			animationConnections = {} -- Clear the table
			if heartbeatConnection then
				heartbeatConnection:Disconnect() -- Disconnect the heartbeat connection
			end
		end)

		-- Setup animation listener
		for _, animId in ipairs({"10468665991", "10471336737"}) do
			onAnimation(animId, function() end)
		end
	else
		warn("Humanoid not found!") -- Debugging information
	end
end

local move2Active = false


onAnimation("10466974800", function(animationTrack) -- place old anim here
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")

	if animationTrack then
		animationTrack:Stop()
	end

	local delayBeforeNewAnim = 0
	wait(delayBeforeNewAnim)

	local newAnimation = Instance.new("Animation")
	newAnimation.AnimationId = "rbxassetid://13560306510" -- place new anim here
	local newAnimTrack = humanoid:LoadAnimation(newAnimation)

	newAnimTrack:Play()
	newAnimTrack:AdjustSpeed(3.5)


	local fov = camera.FieldOfView



	tweenFOV(100, .5)
	
	if target and target:IsA("Model") and target:FindFirstChild("Humanoid") then
		
		
		local thread = task.delay(0, function()
			

			local main = 117185667435879
			local carrier = game:GetObjects("rbxassetid://" .. main)[1]
			carrier.Anchored = true
			carrier.Parent = game.Workspace

			local punchfx = carrier:FindFirstChild("Punch")

			punchfx.Parent = target:FindFirstChild("HumanoidRootPart")


			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = true
				end
			end
			
			wait(1.3)


			for _, child in ipairs(punchfx:GetChildren()) do
				if child:IsA("ParticleEmitter") then
					child.Enabled = false
				end
			end

			wait(1)

			punchfx:Destroy()

			carrier:Destroy()




			
			
			
			
			
			
			
		end)

		

		
		
	end











	local RunService = game:GetService("RunService")

	local Players = game:GetService("Players")
	local player = Players.LocalPlayer


	if not move2Active then
		move2Active = true  -- Set flag to true to prevent re-triggering the move

		-- Use RenderStepped to continuously check for the freeze effects
		local connection
		connection = RunService.RenderStepped:Connect(function()
			local plr = game.Players.LocalPlayer.Character

			local freeze  = plr:FindFirstChild("Freeze")
			local freeze2 = plr:FindFirstChild("StopRunning")
			local freeze3 = plr:FindFirstChild("Slowed")

			-- Remove each effect if found
			if freeze then
				game.Debris:AddItem(freeze, 0)
			end
			if freeze2 then
				game.Debris:AddItem(freeze2, 0)
			end
			if freeze3 then
				game.Debris:AddItem(freeze3, 0)
			end
		end)

		spawnMangaBillboard(player, "You Cryin'?")

		-- Use a coroutine to handle the wait and clean up afterwards
		coroutine.wrap(function()
			wait(1.3)  -- Wait for the duration of the move
			if connection then
				tweenFOV(fov, .5)


				connection:Disconnect()  -- Disconnect the RenderStepped connection
			end
			move2Active = false  -- Reset flag after move deactivates
			

		end)()
	end





	local startTime = 0
	newAnimTrack.TimePosition = startTime

	local animDurationInSeconds = 5
	wait(animDurationInSeconds)
	newAnimTrack:Stop()
end)



game.Players.LocalPlayer.CharacterAdded:Connect(setupAnimationListener)
setupAnimationListener() -- Call the function to set up the listener for the current character


local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Local Player
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Color tweening function
local function tweenColor(imageLabel, startColor, endColor, duration)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
	local goal = {ImageColor3 = endColor}
	local tween = TweenService:Create(imageLabel, tweenInfo, goal)
	tween:Play()
end

-- GUI and color adjustment function
local function updateBarColor()
	-- Find the ScreenGui on the screen
	local screenGui = playerGui:FindFirstChild("ScreenGui")
	if not screenGui then return end

	-- Find the MagicHealth Frame
	local magicHealthFrame = screenGui:FindFirstChild("MagicHealth")
	if not magicHealthFrame then return end

	-- Find the Health Frame
	local healthFrame = magicHealthFrame:FindFirstChild("Health")
	if not healthFrame then return end

	-- Find the Bar Frame
	local barFrame = healthFrame:FindFirstChild("Bar")
	if not barFrame then return end

	-- Find the ImageLabel with ImageColor3 property inside the Bar Frame
	local imageLabel = barFrame:FindFirstChild("Bar")
	if not imageLabel or not imageLabel:IsA("ImageLabel") then return end

	-- Set initial color to yellow
	imageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255) -- Yellow

	-- Smooth transition from yellow to white
	tweenColor(imageLabel, Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 229, 255), 10)
end


updateBarColor()

local function findGuiAndSetText()
	local screenGui = playerGui:FindFirstChild("ScreenGui")
	if screenGui then
		local magicHealthFrame = screenGui:FindFirstChild("MagicHealth")
		if magicHealthFrame then
			local textLabel = magicHealthFrame:FindFirstChild("TextLabel")
			if textLabel then
				textLabel.Text = "THE STRONGEST OF TODAY"
			end
		end
	end
end


findGuiAndSetText()

local infin = Instance.new("Sound")
infin.SoundId = "rbxassetid://13064703816"
infin.Parent = game.Workspace
infin:Play()

local delayBeforeNewAnim = 0
wait(delayBeforeNewAnim)

local newAnimation = Instance.new("Animation")
newAnimation.AnimationId = "rbxassetid://17325160621" -- Place new anim here
local newAnimTrack = humanoid:LoadAnimation(newAnimation)

newAnimTrack:Play()
newAnimTrack:AdjustSpeed(1.4)

local startTime = 3
newAnimTrack.TimePosition = startTime

