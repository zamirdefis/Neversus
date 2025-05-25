local plr = game.Players.LocalPlayer
local sc = plr.PlayerGui:WaitForChild("ScreenGui")
local fr = sc:WaitForChild("Frame")
local butt = fr:WaitForChild("ImageButton")
local run = game:GetService("RunService")
local mouse = plr:GetMouse()
local uis = game:GetService("UserInputService")
local fp =  fr:WaitForChild("fillPart")
local camera = game.Workspace.CurrentCamera

local function grac(mp, frPosX, frSizeX)
	local mid = camera.ViewportSize.X - (frSizeX - frPosX)
	if mp < frPosX then
		return 0
	elseif mp > frSizeX + frPosX then
		return frSizeX
	else
		return mp - frPosX
	end
end

local db = false
local bpp
butt.MouseButton1Down:Connect(function()
	db = true
end)

uis.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		db = false
	end
end)

run.RenderStepped:Connect(function()
	if db then
		local mp = uis:GetMouseLocation().X
		local butpos = butt.Position
		local butsize = butt.Size
		local frPosX = fr.AbsolutePosition.X
		local frSizeX = fr.AbsoluteSize.X
		local pos = grac(mp, frPosX, frSizeX)
		butt.Position = UDim2.new(0, pos - butsize.X.Offset / 2, 0, butpos.Y.Offset)
		fp.Size = UDim2.new(fp.Size.X.Scale, butt.Position.X.Offset + butsize.X.Offset / 2, fp.Size.Y.Scale, fp.Size.Y.Offset)
	end
end)

