--// SPEED + INFINITE JUMP + SAVE/TELEPORT
--// Đặt LocalScript này vào StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local savedCFrame = nil
local infiniteJump = false

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "PlayerUtilityMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- HÀM KÉO GUI
--==================================================

local function makeDraggable(object)
	local dragging = false
	local dragStart
	local startPos

	object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end

		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			object.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

--==================================================
-- ICON NHỎ
--==================================================

local icon = Instance.new("TextButton")
icon.Name = "OpenIcon"
icon.Size = UDim2.new(0, 55, 0, 55)
icon.Position = UDim2.new(0, 20, 0.5, -27)
icon.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
icon.Text = "☰"
icon.TextColor3 = Color3.fromRGB(255,255,255)
icon.TextSize = 25
icon.Font = Enum.Font.GothamBold
icon.AutoButtonColor = true
icon.Parent = gui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

makeDraggable(icon)

--==================================================
-- MENU CHÍNH
--==================================================

local main = Instance.new("Frame")
main.Name = "MainMenu"
main.Size = UDim2.new(0, 280, 0, 330)
main.Position = UDim2.new(0.5, -140, 0.5, -165)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Visible = false
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

makeDraggable(main)

--==================================================
-- TIÊU ĐỀ
--==================================================

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 45)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Player Menu"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

--==================================================
-- NÚT ĐÓNG
--==================================================

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 35, 0, 35)
close.Position = UDim2.new(1, -42, 0, 8)
close.BackgroundColor3 = Color3.fromRGB(170,50,50)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255,255,255)
close.TextSize = 25
close.Font = Enum.Font.GothamBold
close.Parent = main

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = close

--==================================================
-- SPEED
--==================================================

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, -30, 0, 25)
speedLabel.Position = UDim2.new(0, 15, 0, 60)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "WalkSpeed"
speedLabel.TextColor3 = Color3.fromRGB(220,220,220)
speedLabel.TextSize = 16
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = main

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(1, -30, 0, 40)
speedBox.Position = UDim2.new(0, 15, 0, 88)
speedBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
speedBox.Text = "16"
speedBox.PlaceholderText = "Nhập tốc độ..."
speedBox.TextColor3 = Color3.fromRGB(255,255,255)
speedBox.TextSize = 17
speedBox.Font = Enum.Font.Gotham
speedBox.ClearTextOnFocus = false
speedBox.Parent = main

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speedBox

local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(1, -30, 0, 38)
speedButton.Position = UDim2.new(0, 15, 0, 135)
speedButton.BackgroundColor3 = Color3.fromRGB(55,110,200)
speedButton.Text = "Áp dụng Speed"
speedButton.TextColor3 = Color3.fromRGB(255,255,255)
speedButton.TextSize = 16
speedButton.Font = Enum.Font.GothamBold
speedButton.Parent = main

local speedCorner2 = Instance.new("UICorner")
speedCorner2.CornerRadius = UDim.new(0, 8)
speedCorner2.Parent = speedButton

speedButton.MouseButton1Click:Connect(function()
	local value = tonumber(speedBox.Text)

	if value then
		local character = player.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")

			if humanoid then
				humanoid.WalkSpeed = value
			end
		end
	end
end)

--==================================================
-- INFINITE JUMP
--==================================================

local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(1, -30, 0, 40)
jumpButton.Position = UDim2.new(0, 15, 0, 185)
jumpButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
jumpButton.Text = "Infinite Jump: OFF"
jumpButton.TextColor3 = Color3.fromRGB(255,255,255)
jumpButton.TextSize = 16
jumpButton.Font = Enum.Font.GothamBold
jumpButton.Parent = main

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0, 8)
jumpCorner.Parent = jumpButton

jumpButton.MouseButton1Click:Connect(function()
	infiniteJump = not infiniteJump

	if infiniteJump then
		jumpButton.Text = "Infinite Jump: ON"
		jumpButton.BackgroundColor3 = Color3.fromRGB(60,150,80)
	else
		jumpButton.Text = "Infinite Jump: OFF"
		jumpButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
	end
end)

UserInputService.JumpRequest:Connect(function()
	if not infiniteJump then return end

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

--==================================================
-- SAVE POSITION
--==================================================

local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(0.47, 0, 0, 40)
saveButton.Position = UDim2.new(0, 15, 0, 240)
saveButton.BackgroundColor3 = Color3.fromRGB(70,120,180)
saveButton.Text = "📍 Lưu vị trí"
saveButton.TextColor3 = Color3.fromRGB(255,255,255)
saveButton.TextSize = 15
saveButton.Font = Enum.Font.GothamBold
saveButton.Parent = main

local saveCorner = Instance.new("UICorner")
saveCorner.CornerRadius = UDim.new(0, 8)
saveCorner.Parent = saveButton

saveButton.MouseButton1Click:Connect(function()
	local character = player.Character

	if character then
		local root = character:FindFirstChild("HumanoidRootPart")

		if root then
			savedCFrame = root.CFrame
			saveButton.Text = "✓ Đã lưu!"
		end
	end
end)

--==================================================
-- TELEPORT
--==================================================

local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0.47, 0, 0, 40)
teleportButton.Position = UDim2.new(0.53, 0, 0, 240)
teleportButton.BackgroundColor3 = Color3.fromRGB(80,160,100)
teleportButton.Text = "🚀 Dịch chuyển"
teleportButton.TextColor3 = Color3.fromRGB(255,255,255)
teleportButton.TextSize = 15
teleportButton.Font = Enum.Font.GothamBold
teleportButton.Parent = main

local teleportCorner = Instance.new("UICorner")
teleportCorner.CornerRadius = UDim.new(0, 8)
teleportCorner.Parent = teleportButton

teleportButton.MouseButton1Click:Connect(function()
	if not savedCFrame then
		teleportButton.Text = "Chưa lưu vị trí!"
		task.wait(1)
		teleportButton.Text = "🚀 Dịch chuyển"
		return
	end

	local character = player.Character

	if character then
		local root = character:FindFirstChild("HumanoidRootPart")

		if root then
			root.CFrame = savedCFrame + Vector3.new(0, 3, 0)
		end
	end
end)

--==================================================
-- MỞ / ĐÓNG MENU
--==================================================

icon.MouseButton1Click:Connect(function()
	main.Visible = true
	icon.Visible = false
end)

close.MouseButton1Click:Connect(function()
	main.Visible = false
	icon.Visible = true
end)

--==================================================
-- GIỮ SPEED SAU KHI RESPAWN
--==================================================

player.CharacterAdded:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")

	local value = tonumber(speedBox.Text)

	if value then
		humanoid.WalkSpeed = value
	end
end)
