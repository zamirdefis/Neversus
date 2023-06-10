local plrs = game:GetService("Players")
local run = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local plr = plrs.LocalPlayer

local Mouse = plr:GetMouse()

-- временные
LegitbotTeamCheck = true
LegitbotAimPart = "Head"
LegitbotDeathCheck = true
--
local SilentAimLegitbot = {target = nil}
local FOVCircle = Drawing.new("Circle")

local VectorMID = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2  - (game:GetService("GuiService"):GetGuiInset().Y/2))

local Hitboxes = {
	["Head"] = {"Head"},
	["Chest"] = {"Torso"},
	["Arms"] = {"Left Arm", "Right Arm"},
	["Legs"] = {"Left Leg", "Right Leg"}
}

local library = loadstring(game:HttpGet("https://pastebin.com/raw/Wcbjw7vH"))()

local Window = library:CreateWindow(Vector2.new(500, 500), Vector2.new((workspace.CurrentCamera.ViewportSize.X/2)-250, (workspace.CurrentCamera.ViewportSize.Y/2)-250))

local function Teleport(position)
	plr.Character.HumanoidRootPart.CFrame = CFrame.new(position)
end

local function GetSrcCenter()
	return Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2  - (game:GetService("GuiService"):GetGuiInset().Y/2))
end

local function ScreenPointToVector3Pos(x, y, length, params)
	length = length or 10000
	local unit = Camera:ScreenPointToRay(x, y)
	local result
	if params then
		result = workspace:Raycast(unit.Origin, unit.Direction*length, params)
	else
		result = workspace:Raycast(unit.Origin, unit.Direction*length)
	end
	if result then
		return result.Position 
	else
		return false
	end
end

local function IsAlive(plr)
	if plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
		return true
	end

	return false
end

local function IsVisible(pos, ignoreList)
	return #workspace.CurrentCamera:GetPartsObscuringTarget({plr.Character.Head.Position, pos}, ignoreList) == 0 and true or false
end

local function SrcIsVisible(player)
	if player.Character and player.Character.Head then
		local _, visible = Camera:WorldToScreenPoint(player.Character.Head.Position)
		return visible
	end
end

local function GetTeam(plr)
	return game.Teams[plr.Team.Name]
end

local function GetClosestPlayerLegitbot()
	local target,oldval = nil,math.huge
	for i,v in pairs(game.Players:GetPlayers()) do
		if SrcIsVisible(v) then
			if not library.pointers.LegitTabCategoryLegitbotDeathCheck.value or IsAlive(v) and v ~= plr and not v.Character:FindFirstChild("ForceField") then
				if library.pointers.LegitTabCategoryLegitbotTeamCheck.value == false or GetTeam(v) ~= GetTeam(plr) then
					if library.pointers.LegitTabCategoryLegitbotVisibilityCheck.value == false or IsVisible(v.Character.Head.Position, {v.Character, plr.Character, workspace.CurrentCamera}) == true then
						local Vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
						local FOV = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Vector.X, Vector.Y)).magnitude
						if FOV <= library.pointers.LegitTabCategoryLegitbotFOV.value or library.pointers.LegitTabCategoryLegitbotFullScreenFOV.value then
							if math.floor((plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude) < library.pointers.LegitTabCategoryLegitbotDistance.value or library.pointers.LegitTabCategoryLegitbotInfDistance.value then
								if library.pointers.LegitTabCategoryLegitbotTargetPriority.value == "FOV" then
									local Vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
									local FOV = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Vector.X, Vector.Y)).magnitude
									if FOV < oldval then
										target = v
										oldval = FOV
									end
								elseif library.pointers.LegitTabCategoryLegitbotTargetPriority.value == "Distance" then
									local Distance = math.floor((v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude)

									if Distance < oldval then
										target = v
										oldval = Distance
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if target ~= nil then
		return target
	end

	return nil
end

local function GetLegitbotHitbox(plr)
	local target,oldval = nil,math.huge

	for i,v in pairs(library.pointers.LegitTabCategoryLegitbotHitbox.value) do
		for i2,v2 in pairs(Hitboxes[v]) do
			local targetpart = plr.Character:FindFirstChild(v2)

			if targetpart ~= nil then
				if library.pointers.LegitTabCategoryLegitbotHitboxPriority.value == "FOV" then
					local Vector, onScreen = workspace.CurrentCamera:WorldToScreenPoint(targetpart.Position)
					local FOV = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Vector.X, Vector.Y)).magnitude
					if FOV < oldval then
						target = targetpart
						oldval = FOV
					end
				elseif library.pointers.LegitTabCategoryLegitbotHitboxPriority.value == "Distance" then
					local Distance = math.floor((targetpart.Position - plr.Character.HumanoidRootPart.Position).magnitude)

					if Distance < oldval then
						target = targetpart
						oldval = Distance
					end
				end
			end
		end
	end

	if target ~= nil then
		return target
	end

	return nil
end

local LegitTab = Window:CreateTab("Legit")
local LegitTabCategoryLegitbot = LegitTab:AddCategory("Legitbot", 1)

LegitTabCategoryLegitbot:AddToggle("Enabled", false, "LegitTabCategoryLegitbotEnabled", function(val) 
	if val == true then
		LegitbotLoop = run.RenderStepped:Connect(function()
			if library.pointers.LegitTabCategoryLegitbotKeybind.value == nil or (library.pointers.LegitTabCategoryLegitbotKeybind.value.EnumType == Enum.KeyCode and uis:IsKeyDown(library.pointers.LegitTabCategoryLegitbotKeybind.value)) or (library.pointers.LegitTabCategoryLegitbotKeybind.value.EnumType == Enum.UserInputType and UserInputService:IsMouseButtonPressed(library.pointers.LegitTabCategoryLegitbotKeybind.value)) then
				local hitboxpart = GetLegitbotHitbox(plr)
				SilentAimLegitbot.target = GetClosestPlayerLegitbot()
				if SilentAimLegitbot.target then
					if library.pointers.LegitTabCategoryLegitbotSilent.value then
						
					else
						if SilentAimLegitbot.target and hitboxpart then
							Camera.CFrame = CFrame.new(Camera.CFrame.Position, SilentAimLegitbot.target.Character[hitboxpart.Name].Position)
						end
					end
				else
					if SilentAimLegitbot.target ~= nil then SilentAimLegitbot.target = nil end
				end
			else
				if SilentAimLegitbot.target ~= nil then SilentAimLegitbot.target = nil end
			end
		end)
	elseif val == false and LegitbotLoop then
		SilentAimLegitbot.target = nil
		LegitbotLoop:Disconnect()
	end
end)

LegitTabCategoryLegitbot:AddToggle("Silent", false, "LegitTabCategoryLegitbotSilent")

LegitTabCategoryLegitbot:AddToggle("Team Check", false, "LegitTabCategoryLegitbotTeamCheck")

LegitTabCategoryLegitbot:AddToggle("Death Check", false, "LegitTabCategoryLegitbotDeathCheck")

LegitTabCategoryLegitbot:AddToggle("Visibility Check", false, "LegitTabCategoryLegitbotVisibilityCheck")

LegitTabCategoryLegitbot:AddKeybind("Keybind", nil, "LegitTabCategoryLegitbotKeybind")

LegitTabCategoryLegitbot:AddMultiDropdown("Hitbox", {"Head", "Chest", "Arms", "Legs"}, {"Head"}, "LegitTabCategoryLegitbotHitbox")

LegitTabCategoryLegitbot:AddDropdown("Hitbox Priority", {"FOV", "Distance"}, "FOV", "LegitTabCategoryLegitbotHitboxPriority")

LegitTabCategoryLegitbot:AddDropdown("Target Priority", {"FOV", "Distance"}, "FOV", "LegitTabCategoryLegitbotTargetPriority")

local LegitTabCategoryLegitbot2 = LegitTab:AddCategory("Additional", 2)

LegitTabCategoryLegitbot2:AddSlider("Field of View", {0, 360, 0, 1, "°"}, "LegitTabCategoryLegitbotFOV", function(val)
	FOVCircle.Radius = val
end)

LegitTabCategoryLegitbot2:AddToggle("Full Screen FOV", false, "LegitTabCategoryLegitbotFullScreenFOV")

LegitTabCategoryLegitbot2:AddSlider("Distance", {0, 2048, 0, 1, " studs"}, "LegitTabCategoryLegitbotDistance")

LegitTabCategoryLegitbot2:AddToggle("Inf. Distance", false, "LegitTabCategoryLegitbotInfDistance")

LegitTabCategoryLegitbot2:AddSlider("Hitchance", {0, 100, 100, 1, "%"}, "LegitTabCategoryLegitbotHitchance")

LegitTabCategoryLegitbot2:AddToggle("Log Hitchance (console)", false, "LegitTabCategoryLegitbotLogHitchanceConsole")

LegitTabCategoryLegitbot2:AddToggle("FOV Circle", false, "LegitTabCategoryLegitbotFOVCircle", function(val)
	FOVCircle.Visible = val
end)

LegitTabCategoryLegitbot2:AddColorPicker("Color", Color3.new(1,1,1), "LegitTabCategoryLegitbotColor", function(val)
	FOVCircle.Color = val
end)

LegitTabCategoryLegitbot2:AddToggle("Filled", false, "LegitTabCategoryLegitbotFilled", function(val)
	FOVCircle.Filled = val
end)

LegitTabCategoryLegitbot2:AddSlider("Thickness", {1, 20, 1, 1, ""}, "LegitTabCategoryLegitbotThickness", function(val)
	FOVCircle.Thickness = val
end)

LegitTabCategoryLegitbot2:AddSlider("Transparency", {0, 1, 0, 0.01, ""}, "LegitTabCategoryLegitbotTransparency", function(val)
	FOVCircle.Transparency = 1-val
end)

LegitTabCategoryLegitbot2:AddSlider("NumSides", {0, 100, 0, 1, ""}, "LegitTabCategoryLegitbotNumSides", function(val)
	FOVCircle.NumSides = val >= 3 and val or 100
end)

local MiscTab = Window:CreateTab("Misc")

local MiscTabCategoryTeleports = MiscTab:AddCategory("Teleports", 1)

MiscTabCategoryTeleports:AddButton("Prison Rooms", function()
	Teleport(Vector3.new(943.5, 115, 2441))
end)

MiscTabCategoryTeleports:AddButton("Criminal Base", function()
	Teleport(Vector3.new(-944, 94, 2057))
end)

MiscTabCategoryTeleports:AddButton("Prison Yard", function()
	Teleport(Vector3.new(786, 98, 2461))
end)

MiscTabCategoryTeleports:AddButton("Security Room", function()
	Teleport(Vector3.new(802, 100, 2258))
end)

MiscTabCategoryTeleports:AddButton("Сafeteria", function()
	Teleport(Vector3.new(919, 100, 2290))
end)

Mouse.Move:Connect(function()
	if FOVCircle.Visible then
		FOVCircle.Position = uis:GetMouseLocation()
	end
end)

local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall

gmt.__namecall = newcclosure(function(self, ...)
	local Args = {...}
	local method = getnamecallmethod()
	if tostring(self) == "ShootEvent" and tostring(method) == "FireServer" then
		if SilentAimLegitbot.target ~= nil and library.pointers.LegitTabCategoryLegitbotEnabled.value then
			if library.pointers.LegitTabCategoryLegitbotHitchance.value and math.random(1, 100) <= library.pointers.LegitTabCategoryLegitbotHitchance.value then
				Args[1][1]["Hit"] = SilentAimLegitbot.target.Character[LegitbotAimPart]
				Args[1][1]["Cframe"] = SilentAimLegitbot.target.Character[LegitbotAimPart].CFrame
				if Args[1][2] then
					for i in ipairs(Args[1]) do
						Args[1][i]["Hit"] = SilentAimLegitbot.target.Character[LegitbotAimPart]
						Args[1][1]["Cframe"] = SilentAimLegitbot.target.Character[LegitbotAimPart].CFrame
					end
				end
			else
				if library.pointers.LegitTabCategoryLegitbotLogHitchanceConsole.value then
					print("miss due to \"Hitchance\"")
				end
			end
		end
		return self.FireServer(self, unpack(Args))
	end
	return oldNamecall(self, ...)
end)