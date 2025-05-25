local plr = game.Players.LocalPlayer
local sc = plr.PlayerGui:WaitForChild("ColorSwitch")
local l1 = sc:WaitForChild("Assets")
local fr = l1:WaitForChild("Slider")
local butt = fr:WaitForChild("ImageButton")
local run = game:GetService("RunService")
local mouse = plr:GetMouse()
local uis = game:GetService("UserInputService")
local fp =  fr:WaitForChild("fillPart")
local camera = game.Workspace.CurrentCamera
local percent = 0

local function grac(mp, frPosX, frSizeX, mult)
	local mid = camera.ViewportSize.X - (frSizeX - frPosX)
	if mp < frPosX + ((butt.Size.X.Offset / 2) * mult) then
		return (butt.Size.X.Offset / 2) * mult
	elseif mp > (frSizeX + frPosX) - ((butt.Size.X.Offset / 2) * mult) then
		return frSizeX - ((butt.Size.X.Offset / 2) * mult)
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
		local butpos = butt.AbsolutePosition
		local butsize = butt.Size
		local buASX = butt.AbsoluteSize.X
		local frPosX = fr.AbsolutePosition.X
		local frSizeX = fr.AbsoluteSize.X
		local mult = frSizeX / fr.Size.X.Offset
		local pos = grac(mp, frPosX, frSizeX, mult)
		butt.Position = UDim2.new(0, (pos / mult) - butsize.X.Offset / 2, 0, fr.Position.Y.Offset - 1)
		fp.Size = UDim2.new(fp.Size.X.Scale, butt.Position.X.Offset + butt.Size.X.Offset / 2, fp.Size.Y.Scale, fp.Size.Y.Offset)
		percent = butt.Position.X.Offset / (fr.Size.X.Offset - butt.Size.X.Offset) * 100
	end
end)

