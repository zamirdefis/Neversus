local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()
local char = game.Players.LocalPlayer.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local phrp = char:WaitForChild("HumanoidRootPart")
local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")
local hgui = plr.PlayerGui:WaitForChild("Hack")
local uidz = hgui:WaitForChild("main")
local camera = game.Workspace:WaitForChild("Camera")
local run = game:GetService("RunService")
local main2 = uidz:WaitForChild("main2")
local categories = main2:WaitForChild("categories")
local CATLine = categories:WaitForChild("ctline")
local CATLegitBot = categories:WaitForChild("LegitBot")
local CATMisc = categories:WaitForChild("Misc")
local CATRageBot = categories:WaitForChild("RageBot")
local CATSettings = categories:WaitForChild("Settings")
local CATVisuals = categories:WaitForChild("Visuals")
local main3 = main2:WaitForChild("main3")
local SFVisuals= main3:WaitForChild("Visuals")
local SFMisc= main3:WaitForChild("Misc")
local SFRageBot= main3:WaitForChild("RageBot")
local SFLegitBot= main3:WaitForChild("LegitBot")
local SFSettings= main3:WaitForChild("Settings")
local sec_WallHack = SFVisuals:WaitForChild("sec_WallHack")
local WHsecMain = sec_WallHack:WaitForChild("secMain")
local ColorSwitchGUI = plr.PlayerGui:WaitForChild("ColorSwitch")
local ColorSwitch = ColorSwitchGUI:WaitForChild("ColorSwitch")
local CSAssets = ColorSwitchGUI:WaitForChild("Assets")
local CSAmain = CSAssets:WaitForChild("Frame")
local CSTitle = CSAmain:WaitForChild("Title")
local CSch = CSAmain:WaitForChild("ch")
local CSchUpper = CSch:WaitForChild("upper")
local CSteamCheck = CSAmain:WaitForChild("TeamCheck")
local CSlocalCheck = CSAmain:WaitForChild("LocalCheck")
local CSslider = CSAssets:WaitForChild("Slider")
local CSsliderButt = CSslider:WaitForChild("sldbutton")
local ColorPicker = ColorSwitchGUI:WaitForChild("ColorPicker")
local ctCloseButt = ColorPicker:WaitForChild("close")
local ctRed = ColorPicker:WaitForChild("red")
local ctGreen = ColorPicker:WaitForChild("green")
local ctBlue =  ColorPicker:WaitForChild("blue")
local ctTransp = ColorPicker:WaitForChild("transparency")
local ctColorFromT = ColorPicker:WaitForChild("colorFromT")
local tb_Highlight = WHsecMain:WaitForChild("tb_Highlight")
local tb_Chams = WHsecMain:WaitForChild("tb_Chams")
local sch_Highlight = WHsecMain:WaitForChild("sch_Highlight")
local sch_Chams = WHsecMain:WaitForChild("sch_Chams")	

local tcOffColor = Color3.fromRGB(194, 39, 11)
local tcOnColor = Color3.fromRGB(1, 147, 110)
local lcOffColor = Color3.fromRGB(194, 39, 11)
local lcOnColor = Color3.fromRGB(1, 147, 110)
local CheckOffColor = Color3.fromRGB(24, 24, 24)
local CheckOnColor = Color3.fromRGB(207, 159, 198)
--
local CLines = {207, 159, 198}
local CCSLines = {207, 159, 198}
local CFInmate= {255, 255, 255}
local CFGuard = {255, 255, 255}
local CFCriminals= {255, 255, 255}
local COInmate = {255, 255, 255}
local COGuard = {0, 255, 0}
local COCriminals = {255, 255, 255}
local CChamsC = {255, 255, 255}
local CChamsI = {255, 255, 255}
local CChamsG = {255, 255, 255}
--
local TFInmate = {0}
local TFGuard = {0}
local TFCriminals= {0}
local TOInmate= {0}
local TOGuard = {0}
local TOCriminals = {0}
--
local TCFInmate = {false}
local TCFGuard = {false}
local TCFCriminals= {false}
local TCOInmate= {false}
local TCOGuard = {false}
local TCOCriminals = {false}
--
local LCFInmate = {false}
local LCFGuard = {false}
local LCFCriminals= {false}
local LCOInmate= {false}
local LCOGuard = {false}
local LCOCriminals = {false}



local TChamsC = {0}
local TChamsI = {0}
local TChamsG = {0}
local TeamI = "Inmate"
local TeamG = "Guard"
local TeamC = "Criminals"
local TeamN = "Neutral"
local lineType = "lineType"
local titleType = "titleType"
local secType = "secType"
local UsingEspNow = {}
local DragMousePosition
local FramePosition
local UpdateESPFuc 
local glowFuc
local params


local db = false
local dragg = false



local tb_OLglowT = false
local tb_FglowT = false
local tb_ChamsT = false



local glowing = false

--local function UpdateESP()
--	task.spawn(function()
--		UpdateESPFuc = run.Heartbeat:Connect(function()
--			for	_, v in pairs(plrs:GetPlayers()) do
--				if v == plr then
--					if v.Character:FindFirstChild("HumanoidRootPart") then
--						local hrp = v.Character.HumanoidRootPart
--						if v.Team.Name == "Inmate" then
--							if not hrp:FindFirstChild("glow") then
--								if tb_ChamsT then
--									for _, z in pairs(v.Character:GetChildren()) do
--										if z:IsA("MeshPart") then
--											if not z:FindFirstChild("Cham") then
--												local cham = Instance.new("BoxHandleAdornment")
--												cham.Name = "Cham"
--												cham.Parent = z
--												cham.Adornee = z
--												cham.AlwaysOnTop = true
--												cham.ZIndex = 10
--												cham.Size = z.Size + Vector3.new(0.04, 0.04, 0.04)
--												cham.Color3 = Color3.fromRGB(CChamsI[1], CChamsI[2], CChamsI[3])
--												cham.Transparency = TChamsI[1]
--											end
--										end
--									end
--								end
--								if glowing then
--									local glowON = Instance.new("Highlight")
--									glowON.Name = "glow"
--									if tb_OLglowT then
--										glowON.OutlineColor = Color3.fromRGB(InmateOColor[1], InmateOColor[2], InmateOColor[3])
--										glowON.OutlineTransparency = InmateOTransparency[1]
--										if not tb_FglowT then
--											glowON.FillTransparency = 1
--										end
--									end
--									if tb_FglowT then
--										glowON.FillColor = Color3.fromRGB(InmateFColor[1], InmateFColor[2], InmateFColor[3])
--										glowON.FillTransparency = InmateFTransparency[1]
--										if not tb_OLglowT then
--											glowON.OutlineTransparency = 1
--										end
--									end
--										glowON.Adornee = hrp.Parent
--										glowON.Parent = hrp
--								end
--							end
--						elseif v.Team.Name == "Guard" then
--							if not hrp:FindFirstChild("glow") then
--								local glowON = Instance.new("Highlight")
--								glowON.Name = "glow"
--								if tb_OLglowT then
--									glowON.OutlineColor = Color3.fromRGB(GuardOColor[1], GuardOColor[2], GuardOColor[3])
--									glowON.OutlineTransparency = GuardOTransparency[1]
--									if not tb_FglowT then
--										glowON.FillTransparency = 1
--									end
--								end
--								if tb_FglowT then
--									glowON.FillColor = Color3.fromRGB(GuardFColor[1], GuardFColor[2], GuardFColor[3])
--									glowON.FillTransparency = GuardFTransparency[1]
--									if not tb_OLglowT then
--										glowON.OutlineTransparency = 1
--									end
--								end
--								glowON.Adornee = hrp.Parent
--								glowON.Parent = hrp
--							end
--						elseif v.Team.Name == "Criminals" then
--							if not hrp:FindFirstChild("glow") then
--								local glowON = Instance.new("Highlight")
--								glowON.Name = "glow"
--								if tb_OLglowT then
--									glowON.OutlineColor = Color3.fromRGB(CriminalsOColor[1], CriminalsOColor[2], CriminalsOColor[3])
--									glowON.OutlineTransparency = CriminalsOTransparency[1]
--									if not tb_FglowT then
--										glowON.FillTransparency = 1
--									end
--								end
--								if tb_FglowT then
--									glowON.FillColor = Color3.fromRGB(CriminalsFColor[1], CriminalsFColor[2], CriminalsFColor[3])
--									glowON.FillTransparency = CriminalsFTransparency[1]
--									if not tb_OLglowT then
--										glowON.OutlineTransparency = 1
--									end
--								end
--								glowON.Adornee = hrp.Parent
--								glowON.Parent = hrp
--							end
--						end
--					end
--				end
--			end
--		end)
--	end)
--end

local function Cleaner(name, part)
	if part ~= true then
		for _, v in pairs(plrs:GetPlayers()) do
			if v.Character:FindFirstChild(part) then
				if v.Character[part]:FindFirstChild(name) then
					v.Character[part][name]:Destroy()
				end
			end
		end
	else
		for _, v in pairs(plrs:GetPlayers()) do
			for _, z in pairs(v.Character:GetChildren()) do
				if z:FindFirstChild(name) then
					z[name]:Destroy()
				end
			end
		end
	end
end

local function ColorPickerFuc(buttc, colort, trans, cleanstate, name, part)
	local ColorP = ColorPicker:Clone()
	local np = Vector2.new(mouse.X, mouse.Y) / camera.ViewportSize
	ColorP.Position = UDim2.new(np.X, 0, np.Y, 0)
	local R = ColorP.red
	local G = ColorP.green
	local B = ColorP.blue
	local Transp = ColorP.transparency
	local colorf = ColorP.colorf
	local cft = ColorPicker.colorFromT
	local close = ColorPicker.close
	local connects = {}
	Transp.Text = trans
	R.Text = colort[1]
	G.Text = colort[2]
	B.Text = colort[3]
	colorf.BackgroundColor3 = Color3.fromRGB(colort[1], colort[2], colort[3])
	local function UpdateColor()
		buttc.BackgroundColor3 = Color3.fromRGB(colort[1], colort[2], colort[3])
		colorf.BackgroundColor3 = Color3.fromRGB(colort[1], colort[2], colort[3])
		cft.BackgroundColor3 = Color3.fromRGB(colort[1], colort[2], colort[3])
		cft.Transparency = trans
		if cleanstate then
			Cleaner(name, part)
		end
	end
	connects[1] = R.FocusLost:Connect(function()
		if tonumber(R.Text) ~= nil then
			colort[1] = R.Text
			UpdateColor()
		end
	end)
	connects[2] = G.FocusLost:Connect(function()
		if tonumber(G.Text) ~= nil then
			colort[2] = G.Text
			UpdateColor()
		end
	end)
	connects[3] = B.FocusLost:Connect(function()
		if tonumber(B.Text) ~= nil then
			colort[3] = B.Text
			UpdateColor()
		end
	end)
	connects[4] = Transp.FocusLost:Connect(function()
		if tonumber(Transp.Text) ~= nil then
			cft = Transp.Text
			UpdateColor()
		end
	end)
	connects[5] = close.MouseButton1Click:Connect(function()
		print("fsdf")
		ColorP:Destroy()
		for _, v in pairs(connects) do
			v:Disconnect()
		end
	end)
	if hgui:FindFirstChild("ColorSwitch") then
		ColorP.Parent = hgui.ColorSwitch
	else
		ColorP.Parent = hgui
	end
end


uidz.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragg = true
		DragMousePosition = Vector2.new(input.Position.X, input.Position.Y)
		FramePosition = Vector2.new(uidz.Position.X.Scale, uidz.Position.Y.Scale)
	end
end)

uidz.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragg = false
	end
end)

uis.InputChanged:Connect(function(input)
	if dragg then
		local np = FramePosition + ((Vector2.new(input.Position.X, input.Position.Y)- DragMousePosition) / camera.ViewportSize)
		uidz.Position = UDim2.new(np.X, 0, np.Y, 0)
	end
end)

--tb_OLglow.MouseButton1Click:Connect(function()
--	if tb_OLglowT then
--		tb_OLglowT = false
--		if UsingEspNow[1] ~= nil then
--			table.remove(UsingEspNow, 1)
--		end
--		if UsingEspNow[1] == nil then
--			glowing = false
--			UpdateESPFuc:Disconnect()
--			Cleaner("glow", "HumanoidRootPart")
--		else
--			Cleaner("glow", "HumanoidRootPart")
--		end
--		tb_OLglow.check.BackgroundColor3 = CheckOffColor
--	else
--		tb_OLglowT = true
--		if not tb_FglowT then
--			glowing = true
--		end
--		Cleaner("glow", "HumanoidRootPart")
--		tb_OLglow.check.BackgroundColor3 = CheckOnColor
--		if UsingEspNow[1] == nil then
--			UpdateESP()
--		end
--		table.insert(UsingEspNow, 1)
--	end
--end)

--tb_Fglow.MouseButton1Click:Connect(function()
--	if tb_FglowT then
--		tb_FglowT = false
--		if UsingEspNow[1] ~= nil then
--			table.remove(UsingEspNow, 1)
--		end
--		if UsingEspNow[1] == nil then
--			glowing = false
--			UpdateESPFuc:Disconnect()
--			Cleaner("glow", "HumanoidRootPart")
--		else
--			Cleaner("glow", "HumanoidRootPart")
--		end
--		tb_Fglow.check.BackgroundColor3 = CheckOffColor
--	else
--		if not tb_OLglowT then
--			glowing = true
--		end
--		Cleaner("glow", "HumanoidRootPart")
--		tb_Fglow.check.BackgroundColor3 = CheckOnColor
--		if UsingEspNow[1] == nil then
--			UpdateESP()
--		end
--		tb_FglowT = true
--		table.insert(UsingEspNow, 1)
--	end
--end)

--tb_Chams.MouseButton1Click:Connect(function()
--	if tb_ChamsT then
--		tb_ChamsT = false
--		if UsingEspNow[1] ~= nil then
--			table.remove(UsingEspNow, 1)
--		end
--		if UsingEspNow[1] == nil then
--			UpdateESPFuc:Disconnect()
--			Cleaner("Cham", true)
--		else
--			Cleaner("Cham", true)
--		end
--		tb_Chams.check.BackgroundColor3 = CheckOffColor
--	else
--		Cleaner("Cham", true)
--		tb_Chams.check.BackgroundColor3 = CheckOnColor
--		if UsingEspNow[1] == nil then
--			UpdateESP()
--		end
--		tb_ChamsT = true
--		table.insert(UsingEspNow, 1)
--	end
--end)

local function grac(mp, frPosX, frSizeX, mult, butt)
	local mid = camera.ViewportSize.X - (frSizeX - frPosX)
	if mp < frPosX + ((butt.Size.X.Offset / 2) * mult) then
		return (butt.Size.X.Offset / 2) * mult
	elseif mp > (frSizeX + frPosX) - ((butt.Size.X.Offset / 2) * mult) then
		return frSizeX - ((butt.Size.X.Offset / 2) * mult)
	else
		return mp - frPosX
	end
end

local function CustomColorSwitch(params)
-- после удаляения надо дисконнектнуть все функции
	local connects = {}
	local csc = ColorSwitch:Clone()
	local scroll = csc:WaitForChild("Scroll")
	local np = Vector2.new(mouse.X, mouse.Y) / camera.ViewportSize
	csc.Position = UDim2.new(np.X, 0, np.Y, 0)
	csc.Visible = true
	local vertical = 2
	for i, v in pairs(params) do
		local horizontal = 2
		if v[1] == titleType then
			local cst = CSTitle:Clone()
			cst.Position = UDim2.new(0, horizontal, 0, vertical)
			cst.Text = v[2]
			cst.Parent = scroll
		elseif v[1] == secType then
			local tableOffset = 0
			local ch = CSch:Clone()
			local chu = ch:FindFirstChild(CSchUpper.Name)
			ch.Position = UDim2.new(0, horizontal, 0, vertical)
			chu.BackgroundColor3 = Color3.fromRGB(v[2][1], v[2][2], v[2][3])
			connects[i] = ch.MouseButton1Click:Connect(function()
				ColorPickerFuc(chu, v[2], v[5][1])
			end)
			tableOffset += 1
			horizontal += 8
			if v[3] ~= nil then
				local tc = CSteamCheck:Clone()
				tc.Position = UDim2.new(0, horizontal, 0, vertical - 2)
				if v[3][1] then
					tc.ImageColor3 = tcOnColor
				else
					tc.ImageColor3 = tcOffColor
				end
				connects[i + tableOffset] = tc.MouseButton1Click:Connect(function()
					if v[3][1] then
						v[3][1] = false
						tc.ImageColor3 = tcOffColor
					else
						v[3][1] = true
						tc.ImageColor3 = tcOnColor
					end
				end)
				tc.Parent = scroll
				tableOffset += 1
				horizontal += 9
			end
			if v[4] ~= nil then
				local lc = CSlocalCheck:Clone()
				lc.Position = UDim2.new(0, horizontal, 0, vertical - 1)
				if v[4][1] then
					lc.ImageColor3 = lcOnColor
				else
					lc.ImageColor3 = lcOffColor
				end
				connects[i + tableOffset] = lc.MouseButton1Click:Connect(function()
					if v[4][1] then
						v[4][1] = false
						lc.ImageColor3 = lcOffColor
					else
						v[4][1] = true
						lc.ImageColor3 = lcOnColor
					end
				end)
				lc.Parent = scroll
				tableOffset += 1
				horizontal += 7
			end
			if v[5] ~= nil then
				local slider = CSslider:Clone()
				local sbutt = slider:FindFirstChild("sldbutton")
				local fp = slider:FindFirstChild("fillPart")
				local percent = slider:FindFirstChild("TextBox")
				local upb = slider:FindFirstChild("upb")
				upb.BackgroundColor3 = Color3.fromRGB(v[2][1], v[2][2], v[2][3])
				slider.Position = UDim2.new(0, horizontal + 22, 0, vertical)
				slider.Size = UDim2.new(slider.Size.X.Scale, (ColorSwitch.Size.X.Offset - slider.Position.X.Offset), slider.Size.Y.Scale, slider.Size.Y.Offset)
				sbutt.Position = UDim2.new(sbutt.Position.X.Scale, ((slider.Size.X.Offset - sbutt.Size.X.Offset) / (100 / (v[5][1] * 100))), sbutt.Position.Y.Scale, sbutt.Position.Y.Offset)
				percent.Text = math.ceil(v[5][1] * 100)
				fp.Size = UDim2.new(fp.Size.X.Scale, sbutt.Position.X.Offset + sbutt.Size.X.Offset / 2, fp.Size.Y.Scale, fp.Size.Y.Offset)
				connects[i + tableOffset] = sbutt.MouseButton1Down:Connect(function()
					local conn1 = run.RenderStepped:Connect(function()
						local mp = uis:GetMouseLocation().X
						local butpos = sbutt.AbsolutePosition
						local frPosX = slider.AbsolutePosition.X
						local frSizeX = slider.AbsoluteSize.X
						local mult = frSizeX / slider.Size.X.Offset
						local pos = grac(mp, frPosX, frSizeX, mult, sbutt)
						sbutt.Position = UDim2.new(0, (pos / mult) - sbutt.Size.X.Offset / 2, sbutt.Position.Y.Scale, sbutt.Position.Y.Offset)
						fp.Size = UDim2.new(fp.Size.X.Scale, sbutt.Position.X.Offset + sbutt.Size.X.Offset / 2, fp.Size.Y.Scale, fp.Size.Y.Offset)
						v[5][1] = ((sbutt.Position.X.Offset / (slider.Size.X.Offset - sbutt.Size.X.Offset) * 100) / 100)
						upb.Transparency = v[5][1]
						percent.Text = math.ceil(v[5][1] * 100)
					end)
					local conn2
					conn2 = uis.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							conn1:Disconnect()
							conn2:Disconnect()
						end
					end)
				end)
				tableOffset += 1
				connects[i + tableOffset] = percent.FocusLost:Connect(function()
					if percent ~= false then
						if tonumber(percent.Text) ~= nil then
							if tonumber(percent.Text) < 0 then
								percent.Text = 0
								v[5][1] = 0
							elseif tonumber(percent.Text) > 100 then
								percent.Text = 100
								v[5][1] = 1
							else
								v[5][1] = tonumber(percent.Text) / 100
							end
						else
							percent.Text = 0
							v[5][1] = 0
						end
						upb.Transparency = v[5][1]
						sbutt.Position = UDim2.new(sbutt.Position.X.Scale, ((slider.Size.X.Offset - sbutt.Size.X.Offset) / (100 / tonumber(percent.Text))), sbutt.Position.Y.Scale, sbutt.Position.Y.Offset)
						fp.Size = UDim2.new(fp.Size.X.Scale, sbutt.Position.X.Offset + sbutt.Size.X.Offset / 2, fp.Size.Y.Scale, fp.Size.Y.Offset)
					end
				end)
				slider.Parent = scroll
			end
			ch.Parent = scroll
		end
		vertical += 8
	end
	csc.Parent = hgui
end

sch_Highlight.MouseButton1Click:Connect(function()
	-- 1 тип ui экземпляра, 2 цвет для кнопки и возврата, 3 teamcheck, 4 проверка на локального игрока, 5 прозрачность
	params = 
		{
			{titleType, "**OutLineGlow**"},
			{titleType, ""},
			{titleType, "Criminals:"},
			{secType, COCriminals, TCOCriminals, LCFCriminals, TFCriminals},
			{titleType, "Guard:"},
			{secType, COGuard, TCOGuard, LCOGuard, TFGuard},
			{titleType, "Inmate:"},
			{secType, COInmate, TCOInmate, LCOInmate, TFInmate},
			{titleType, ""},
			{titleType, "**FillGlow**"},
			{titleType, ""},
			{titleType, "Criminals:"},
			{secType, CFCriminals, TCFCriminals, LCFCriminals, TOCriminals},
			{titleType, "Guard:"},
			{secType, CFGuard, TCFGuard, LCFGuard, TOGuard},
			{titleType, "Inmate:"},
			{secType, CFInmate, TCFInmate, LCFInmate, TOInmate},
		}
	CustomColorSwitch(params)
end)

CATMisc.MouseButton1Click:Connect(function()
	for _, v in pairs(main3:GetChildren()) do
		if v:IsA("ScrollingFrame") then
			v.Visible = false
		end
	end
	CATLine.Position = CATMisc.Position - UDim2.new(0, 3, 0, -8)
	SFMisc.Visible = true
end)

CATVisuals.MouseButton1Click:Connect(function()
	for _, v in pairs(main3:GetChildren()) do
		if v:IsA("ScrollingFrame") then
			v.Visible = false
		end
	end
	CATLine.Position = CATVisuals.Position - UDim2.new(0, 3, 0, -8)
	SFVisuals.Visible = true
end)

CATSettings.MouseButton1Click:Connect(function()
	for _, v in pairs(main3:GetChildren()) do
		if v:IsA("ScrollingFrame") then
			v.Visible = false
		end
	end
	CATLine.Position = CATSettings.Position - UDim2.new(0, 3, 0, -8)
	SFSettings.Visible = true
end)

CATLegitBot.MouseButton1Click:Connect(function()
	for _, v in pairs(main3:GetChildren()) do
		if v:IsA("ScrollingFrame") then
			v.Visible = false
		end
	end
	CATLine.Position = CATLegitBot.Position - UDim2.new(0, 3, 0, -8)
	SFLegitBot.Visible = true
end)

CATRageBot.MouseButton1Click:Connect(function()
	for _, v in pairs(main3:GetChildren()) do
		if v:IsA("ScrollingFrame") then
			v.Visible = false
		end
	end
	CATLine.Position = CATRageBot.Position - UDim2.new(0, 3, 0, -8)
	SFRageBot.Visible = true
end)

uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Insert then
		hgui.Enabled = not hgui.Enabled
	end
end)
