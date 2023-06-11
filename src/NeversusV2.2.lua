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

local function GetHRP(player)
	if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		return player.Character.HumanoidRootPart
	else
		return false
	end
end

local function Logs(text, typee)
	if typee == 1 then
		print(text)
	end
end

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
	if player.Character and player.Character:FindFirstChild("Head") then
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

LegitTabCategoryLegitbot2:AddToggle("Full Screen FOV", false, "LegitTabCategoryLegitbotFullScreenFOV", function(val)
	if val then
		FOVCircle.Visible = false
	end
end)

LegitTabCategoryLegitbot2:AddSlider("Distance", {0, 2048, 0, 1, " studs"}, "LegitTabCategoryLegitbotDistance")

LegitTabCategoryLegitbot2:AddToggle("Inf. Distance", false, "LegitTabCategoryLegitbotInfDistance")

LegitTabCategoryLegitbot2:AddSlider("Hitchance", {0, 100, 100, 1, "%"}, "LegitTabCategoryLegitbotHitchance")

LegitTabCategoryLegitbot2:AddToggle("Log Hitchance (console)", false, "LegitTabCategoryLegitbotLogHitchanceConsole")

LegitTabCategoryLegitbot2:AddToggle("FOV Circle", false, "LegitTabCategoryLegitbotFOVCircle", function(val)
	if not library.pointers.LegitTabCategoryLegitbotFullScreenFOV.value then
		FOVCircle.Visible = val
	end
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

MiscTabCategoryTeleports:AddTextBox("Tp to player ", "Target player name...", "MiscTabCategoryTeleportsTtp")

MiscTabCategoryTeleports:AddButton("Tp (execute)", function()
	if library.pointers.MiscTabCategoryTeleportsTtp.value ~= "" then
		local NameHaveCount = 0
		local player
		for _, v in ipairs(plrs:GetPlayers()) do
			if library.pointers.MiscTabCategoryTeleportsDuc.value then
				if string.lower(library.pointers.MiscTabCategoryTeleportsTtp.value) == string.lower(string.sub(v.Name, 1, #library.pointers.MiscTabCategoryTeleportsTtp.value)) or library.pointers.MiscTabCategoryTeleportsAcdn.value and string.lower(library.pointers.MiscTabCategoryTeleportsTtp.value) == string.lower(string.sub(v.DisplayName, 1, #library.pointers.MiscTabCategoryTeleportsTtp.value)) then
					NameHaveCount += 1
					player = v
				end
			else
				if library.pointers.MiscTabCategoryTeleportsTtp.value == string.sub(v.Name, 1, #library.pointers.MiscTabCategoryTeleportsTtp.value) or library.pointers.MiscTabCategoryTeleportsAcdn.value and library.pointers.MiscTabCategoryTeleportsTtp.value == string.sub(v.DisplayName, 1, #library.pointers.MiscTabCategoryTeleportsTtp.value) then
					NameHaveCount += 1
					player = v
				end
			end
		end
		if NameHaveCount > 1 then
			Logs(NameHaveCount .. " players have a similar name", 1)
		else
			if player then
				if GetHRP(player) then
					Teleport(GetHRP(player).Position)
				else
					Logs("Player HumanoidRootPart not found", 1)
				end
			else
				Logs("Player not found", 1)
			end
		end
	end
end)

MiscTabCategoryTeleports:AddToggle("Also check display name", false, "MiscTabCategoryTeleportsAcdn")

MiscTabCategoryTeleports:AddToggle("Disable uppercase check", false, "MiscTabCategoryTeleportsDuc")

MiscTabCategoryTeleports:AddToggle("Mouse Tp", false, "MiscTabCategoryTeleportsMouseTp", function(val)
	if val then
		MouseTpConnect = uis.InputBegan:Connect(function(input)
			if library.pointers.MiscTabCategoryTeleportsKeybind.value and input.KeyCode == library.pointers.MiscTabCategoryTeleportsKeybind.value or input.UserInputType == library.pointers.MiscTabCategoryTeleportsKeybind.value or not library.pointers.MiscTabCategoryTeleportsKeybind.value and input.UserInputType == Enum.UserInputType.MouseButton1 then
				if Mouse.Target then
					Teleport(Mouse.Hit.Position + Vector3.new(0, 2.5, 0))
				end
			end
		end)
	elseif MouseTpConnect then
		MouseTpConnect:Disconnect()
	end
end)

MiscTabCategoryTeleports:AddKeybind("Keybind", nil, "MiscTabCategoryTeleportsKeybind")

local MiscTabCategoryHumanoid = MiscTab:AddCategory("Humanoid", 1)

MiscTabCategoryHumanoid:AddToggle("Loop", false, "MiscTabCategoryHumanoidLoop", function(val)
	if val then
		LoopC = run.RenderStepped:Connect(function()
			if IsAlive(plr) then
				if library.pointers.MiscTabCategoryHumanoidSpeed.value then
					plr.Character.Humanoid.WalkSpeed = library.pointers.MiscTabCategoryHumanoidSpeed.value
				end
				if library.pointers.MiscTabCategoryHumanoidJumpPower.value then
					plr.Character.Humanoid.JumpPower = library.pointers.MiscTabCategoryHumanoidJumpPower.value
				end
				if library.pointers.MiscTabCategoryHumanoidHipHeight.value then
					plr.Character.Humanoid.HipHeight = library.pointers.MiscTabCategoryHumanoidHipHeight.value
				end
				if library.pointers.MiscTabCategoryHumanoidMaxSlopeAngle.value then
					plr.Character.Humanoid.MaxSlopeAngle = library.pointers.MiscTabCategoryHumanoidMaxSlopeAngle.value
				end
				if library.pointers.MiscTabCategoryHumanoidPlatformStand.value then
					plr.Character.Humanoid.PlatformStand = library.pointers.MiscTabCategoryHumanoidPlatformStand.value
				end
			end
		end)
	elseif LoopC then
		LoopC:Disconnect()
	end
end)

MiscTabCategoryHumanoid:AddSlider("Walk Speed (16)", {1, 500, 16, 1, ""}, "MiscTabCategoryHumanoidSpeed", function(val)
	if IsAlive(plr) then
		plr.Character.Humanoid.WalkSpeed = val
	end
end)

MiscTabCategoryHumanoid:AddSlider("Jump Power (50)", {1, 500, 50, 1, ""}, "MiscTabCategoryHumanoidJumpPower", function(val)
	if IsAlive(plr) then
		plr.Character.Humanoid.JumpPower = val
	end
end)

MiscTabCategoryHumanoid:AddSlider("Hip Height (0)", {0, 500, 0, 1, ""}, "MiscTabCategoryHumanoidHipHeight", function(val)
	if IsAlive(plr) then
		plr.Character.Humanoid.HipHeight = val
	end
end)

MiscTabCategoryHumanoid:AddSlider("Max Slope Angle (89)", {0, 89.9, 89, 0.1, ""}, "MiscTabCategoryHumanoidMaxSlopeAngle", function(val)
	if IsAlive(plr) then
		plr.Character.Humanoid.MaxSlopeAngle = val
	end
end)

MiscTabCategoryHumanoid:AddToggle("Platform Stand", false, "MiscTabCategoryHumanoidPlatformStand", function(val)
	if val then
		if IsAlive(plr) then
			plr.Character.Humanoid.PlatformStand = true
		end
	else
		if IsAlive(plr) then
			plr.Character.Humanoid.PlatformStand = false
		end
	end
end)

MiscTabCategoryHumanoid:AddButton("Sit", function()
	if IsAlive(plr) then
		plr.Character.Humanoid.Sit = true
	end
end)

MiscTabCategoryHumanoid:AddTextBox("Sit on the player head", "Target player name...", "MiscTabCategoryHumanoidHeadSit")

MiscTabCategoryHumanoid:AddButton("Sit on head (execute)", function()
	if library.pointers.MiscTabCategoryHumanoidHeadSit.value ~= "" then
		local NameHaveCount = 0
		local player
		for _, v in ipairs(plrs:GetPlayers()) do
			if library.pointers.MiscTabCategoryHumanoidDuc.value then
				if string.lower(library.pointers.MiscTabCategoryHumanoidHeadSit.value) == string.lower(string.sub(v.Name, 1, #library.pointers.MiscTabCategoryHumanoidHeadSit.value)) or library.pointers.MiscTabCategoryHumanoidAcdn.value and string.lower(library.pointers.MiscTabCategoryHumanoidHeadSit.value) == string.lower(string.sub(v.DisplayName, 1, #library.pointers.MiscTabCategoryHumanoidHeadSit.value)) then
					NameHaveCount += 1
					player = v
				end
			else
				if library.pointers.MiscTabCategoryHumanoidHeadSit.value == string.sub(v.Name, 1, #library.pointers.MiscTabCategoryHumanoidHeadSit.value) or library.pointers.MiscTabCategoryHumanoidAcdn.value and library.pointers.MiscTabCategoryHumanoidHeadSit.value == string.sub(v.DisplayName, 1, #library.pointers.MiscTabCategoryHumanoidHeadSit.value) then
					NameHaveCount += 1
					player = v
				end
			end
		end
		if NameHaveCount > 1 then
			Logs(NameHaveCount .. " players have a similar name", 1)
		else
			if player then
				if player.Character:FindFirstChild("Head") then
					if IsAlive(plr) and GetHRP(plr) then
						plr.Character.Humanoid.Sit = true
						local plrhrp = GetHRP(plr)
						local plhead = player.Character.Head
						local detc
						local rsc
						local ScfotON = false
						if library.pointers.MiscTabCategoryHumanoidScfot.value then
							Camera.CameraSubject = plhead
							ScfotON = true
						end
						rsc = run.RenderStepped:Connect(function()
							plrhrp.CFrame = plhead.CFrame * CFrame.new(0, 0, 0.4)
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
						end)
						detc = plr.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
							if ScfotON then
								Camera.CameraSubject = plr.Character.Humanoid
								ScfotON = false
							end
							rsc:Disconnect()
							detc:Disconnect()
						end)
					end
				else
					Logs("Player head not found", 1)
				end
			else
				Logs("Player not found", 1)
			end
		end
	end
end)

MiscTabCategoryHumanoid:AddToggle("Also check display name", false, "MiscTabCategoryHumanoidAcdn")

MiscTabCategoryHumanoid:AddToggle("Disable uppercase check", false, "MiscTabCategoryHumanoidDuc")

MiscTabCategoryHumanoid:AddToggle("Stabilize camera focus on target", false, "MiscTabCategoryHumanoidScfot")

MiscTabCategoryHumanoid:AddButton("Jump", function()
	if IsAlive(plr) then
		if plr.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
			plr.Character.Humanoid:ChangeState("Jumping")
		end
	end
end)

MiscTabCategoryHumanoid:AddToggle("Jumper", false, "MiscTabCategoryHumanoidJumper", function(val)
	if val then
		rsc = run.RenderStepped:Connect(function()
			if IsAlive(plr) then
				if plr.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
					plr.Character.Humanoid:ChangeState("Jumping")
				end
			end
		end)
	elseif rsc then
		rsc:Disconnect()
	end
end)

local MiscTabCategoryFly = MiscTab:AddCategory("Fly", 2)

MiscTabCategoryFly:AddToggle("Fly", false, "MiscTabCategoryFlyEnabled", function(val)
	if val then
		local Keybind = true
		local function FlyloopCtine()
			Flyloop = run.RenderStepped:Connect(function()
				if IsAlive(plr) then
					print("rstep")
					if not Keybind then
						coroutine.yield()
					end
					local speed = library.pointers.MiscTabCategoryFlySpeed.value or 1
					local velocity = Vector3.new(0, 0, 0)
					if uis:IsKeyDown(Enum.KeyCode.W) then
						velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.lookVector * speed)
					end
					if uis:IsKeyDown(Enum.KeyCode.A) then
						velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.rightVector * -speed)
					end
					if uis:IsKeyDown(Enum.KeyCode.S) then
						velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.lookVector * -speed)
					end
					if uis:IsKeyDown(Enum.KeyCode.D) then
						velocity = velocity + (workspace.CurrentCamera.CoordinateFrame.rightVector * speed)
					end

					plr.Character.HumanoidRootPart.Velocity = velocity + Vector3.new(0, 2.7, 0)
					plr.Character.Humanoid.PlatformStand = true
				end
			end)
		end
		local fct = coroutine.wrap(FlyloopCtine)
		Flybind = uis.InputBegan:Connect(function(input)
			if library.pointers.MiscTabCategoryFlyEnabledKeybind.value and input.KeyCode == library.pointers.MiscTabCategoryFlyEnabledKeybind.value or input.UserInputType == library.pointers.MiscTabCategoryFlyEnabledKeybind.value then
				if Keybind then
					plr.Character.Humanoid.PlatformStand = false
					Keybind = false
				else
					Keybind = true
				end
			end
		end)
		fct()
	elseif Flyloop and Flybind then
		Flyloop:Disconnect()
		plr.Character.Humanoid.PlatformStand = false
		Flybind:Disconnect()
	end
end)

MiscTabCategoryFly:AddKeybind("Fly Keybind", nil, "MiscTabCategoryFlyEnabledKeybind")

MiscTabCategoryFly:AddSlider("Speed", {1, 500, 50, 1, ""}, "MiscTabCategoryFlySpeed")

MiscTabCategoryFly:AddToggle("Air Jump", false, "MiscTabCategoryFlyAirJump", function(val)
	if val then
		local Keybind = true
		local function AirJumpCtine()
			AirJumpConnect = uis.JumpRequest:Connect(function()
				if not Keybind then
					coroutine.yield()
				end
				plr.Character.Humanoid:ChangeState("Jumping")
			end)
		end
		local act = coroutine.wrap(AirJumpCtine)
		AirJumpbind = uis.InputBegan:Connect(function(input)
			if library.pointers.MiscTabCategoryFlyAirJumpKeybind.value and input.KeyCode == library.pointers.MiscTabCategoryFlyAirJumpKeybind.value or input.UserInputType == library.pointers.MiscTabCategoryFlyAirJumpKeybind.value then
				if Keybind then
					plr.Character.Humanoid.PlatformStand = false
					Keybind = false
				else
					Keybind = true
				end
			end
		end)
		act()
	elseif AirJumpConnect and AirJumpbind then
		AirJumpConnect:Disconnect()
		AirJumpbind:Disconnect()
	end
end)

MiscTabCategoryFly:AddKeybind("Air Jump Keybind", nil, "MiscTabCategoryFlyAirJumpKeybind")

MiscTabCategoryFly:AddToggle("No Clip", false, "MiscTabCategoryFlyNoClip", function(val)
	if val then
		local Keybind = true
		local function NoClipCtine()
			NoClipConnect = run.RenderStepped:Connect(function()
				if not Keybind then
					coroutine.yield()
				end
				if plr.Character:FindFirstChild("Head") then
					plr.Character.Head.CanCollide = false
				end
				if plr.Character:FindFirstChild("Torso") then
					plr.Character.Torso.CanCollide = false
				end
			end)
		end
		local nct = coroutine.wrap(NoClipCtine)
		NoClipbind = uis.InputBegan:Connect(function(input)
			if library.pointers.MiscTabCategoryFlyNoClipKeybind.value and input.KeyCode == library.pointers.MiscTabCategoryFlyNoClipKeybind.value or input.UserInputType == library.pointers.MiscTabCategoryFlyNoClipKeybind.value then
				if Keybind then
					Keybind = false
					if plr.Character:FindFirstChild("Head") then
						plr.Character.Head.CanCollide = true
					end
					if plr.Character:FindFirstChild("Torso") then
						plr.Character.Torso.CanCollide = true
					end
				else
					Keybind = true
				end
			end
		end)
		nct()
	elseif NoClipConnect and NoClipbind then
		if plr.Character:FindFirstChild("Head") then
			plr.Character.Head.CanCollide = true
		end
		if plr.Character:FindFirstChild("Torso") then
			plr.Character.Torso.CanCollide = true
		end
		NoClipConnect:Disconnect()
		NoClipbind:Disconnect()
	end
end)

MiscTabCategoryFly:AddKeybind("No Clip Keybind", nil, "MiscTabCategoryFlyNoClipKeybind")

local MiscTabCategoryWorld = MiscTab:AddCategory("World", 2)

MiscTabCategoryWorld:AddSlider("Gravity (196.2)", {0, 1000, 196.2, 0.1, ""}, "MiscTabCategoryWorldGravity", function(val)
	workspace.Gravity = val
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
			print(1234)
			if library.pointers.LegitTabCategoryLegitbotHitchance.value and math.random(1, 100) <= library.pointers.LegitTabCategoryLegitbotHitchance.value then
				print(123)
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