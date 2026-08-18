local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local enabled = false
local debounce = false

local gui = Instance.new("ScreenGui")
gui.Name = "LightningAutoHarvest"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(220, 100)
main.Position = UDim2.new(1, -240, 1, -140)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "⚡ AUTO HARVEST"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Parent = main

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, -20, 0, 45)
toggle.Position = UDim2.fromOffset(10, 45)
toggle.Text = "OFF"
toggle.TextScaled = true
toggle.Parent = main

toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    toggle.Text = enabled and "ON" or "OFF"
end)

local function harvest()
    print("⚡ Lightning detected -> HARVEST!")
end

local function checkObject(obj)
    if not enabled or debounce then
        return
    end

    if not obj:IsA("TextLabel") and
       not obj:IsA("TextButton") and
       not obj:IsA("TextBox") then
        return
    end

    local text = string.lower(obj.Text or "")

    local lightning =
        string.find(text, "lightning is about to strike")
        or string.find(text, "harvest immediately")

    if lightning then
        debounce = true
        harvest()

        task.delay(1, function()
            debounce = false
        end)
    end
end

for _, obj in ipairs(playerGui:GetDescendants()) do
    checkObject(obj)
end

playerGui.DescendantAdded:Connect(function(obj)
    task.defer(function()
        checkObject(obj)
    end)
end)
