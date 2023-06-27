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

local library = loadstring(game:HttpGet("https://pastebin.com/raw/Wcbjw7vH"))()

local function CheckNsusFolder()
	if not isfolder("Neversus") then
		print("creating Neversus folder")
		makefolder("Neversus")
	end
end

local function CheckCSkysFile()
	if not isfile("Neversus/custom_skys.txt") then
		print("creating Neversus custom_skys file")
		writefile("Neversus/custom_skys.txt", "return {}")
		--elseif not (string.sub(readfile("Neversus/custom_skys.txt"), 1, 9) == "return {}" or string.sub(readfile("Neversus/custom_skys.txt"), 1, 9) == "return {" and string.sub(readfile("Neversus/custom_skys.txt"), string.len(readfile("Neversus/custom_skys.txt")), string.len(readfile("Neversus/custom_skys.txt")) == "}")) then
		--	writefile("Neversus/custom_skys.txt", "return {}")
	end
end

local Hitboxes = {
	["Head"] = {"Head"},
	["Chest"] = {"Torso"},
	["Arms"] = {"Left Arm", "Right Arm"},
	["Legs"] = {"Left Leg", "Right Leg"}
}

local Window = library:CreateWindow(Vector2.new(500, 500), Vector2.new((workspace.CurrentCamera.ViewportSize.X/2)-250, (workspace.CurrentCamera.ViewportSize.Y/2)-250))

function OneMoreLen(Table)
	local count = 0
	for _ in pairs(Table) do 
		count = count + 1
		print(count, " col")
		if count > 1 then
			return true
		end
	end
	if count <= 1 then
		return false
	end
	return false
end

function TableLen(Table)
	local count = 0
	for _ in pairs(Table) do count = count + 1 end
	return count
end

local TableToString
TableToString = function(Table)
	local str = ""
	local com = ", "
	local index = true
	for i, v in pairs(Table) do
		if index then
			com = "{"
			index = false
		else
			com = ", "
		end
		if type(i) == "number" then
			if typeof(v) == "number" then
				str ..= com .. v
			elseif typeof(v) == "string" then
				str ..= com .. "\"".. v .."\""
			elseif typeof(v) == "boolean" then
				str ..= com .. (v and "true" or "false")
			elseif typeof(v) == "table" then
				if v[1] then
					str ..= com .. TableToString(v)
				else
					str ..= com .. "{}"
				end
			end
		elseif type(i) == "string" then
			if typeof(v) == "number" then
				str ..= com .. "[\"" .. i .. "\"] = " .. v
			elseif typeof(v) == "string" then
				str ..= com .. "[\"" .. i .. "\"] = " .. "\"" .. v .. "\""
			elseif typeof(v) == "boolean" then
				str ..= com .. "[\"" .. i .. "\"] = " .. (v and "true" or "false")
			elseif typeof(v) == "table" then
				if v[1] then
					str ..= com .. "[\"" .. i .. "\"] = " .. TableToString(v)
				else
					str ..= com .. "[\"" .. i .. "\"] = " .. "{}"
				end
			end
		end
	end
	str ..= "}"
	return str
end

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
					if not library.pointers.LegitTabCategoryLegitbotSilent.value then
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

MiscTabCategoryWorld:AddToggle("Door collision off", false, "MiscTabCategoryWorldDco", function(val)
	if val then
		dc = run.RenderStepped:Connect(function()
			for _, v in ipairs(workspace.Doors:GetDescendants()) do
				if v:IsA("BasePart") and v.CanCollide then
					v.CanCollide = false
					local bv = Instance.new("BoolValue", v)
					bv.Name = "cobh"
				end
			end
		end)
	else
		if dc then
			dc:Disconnect()
		end
		for _, v in ipairs(workspace.Doors:GetDescendants()) do
			if v:IsA("BasePart") and v:FindFirstChild("cobh") then
				v.CanCollide = true
				v.cobh:Destroy()
			end
		end
	end
end)

MiscTabCategoryWorld:AddToggle("Destroy Doors", false, "MiscTabCategoryWorldDestroyDoors", function(val)
	if val then
		doors = workspace.Doors
		doors.Parent = nil
	elseif doors then
		doors.Parent = workspace
	end
end)

local MiscTabCategoryMovement = MiscTab:AddCategory("Movement", 2)

MiscTabCategoryMovement:AddToggle("Bunny Hop", false, "MiscTabCategoryMovementBunnyHop", function(val)
	if val then
		if GetHRP(plr) and IsAlive(plr) then
			Bhopc = run.RenderStepped:Connect(function()
				if library.pointers.MiscCategoryMovementType.value == "Forward" then
					if uis:IsKeyDown(Enum.KeyCode.Space) then
						if plr.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
							plr.Character.Humanoid:ChangeState("Jumping")
						end
						local hrp = GetHRP(plr)
						hrp.Velocity = Vector3.new(hrp.CFrame.LookVector.X, 0, hrp.CFrame.LookVector.Z) * library.pointers.MiscTabCategoryMovementSpeed.value + Vector3.new(0, hrp.Velocity.Y, 0)
					end
				else
					local speed = library.pointers.MiscTabCategoryMovementSpeed.value
					if uis:IsKeyDown(Enum.KeyCode.Space) then
						if plr.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
							plr.Character.Humanoid:ChangeState("Jumping")
						end
						local hrp = GetHRP(plr)
						if uis:IsKeyDown(Enum.KeyCode.D) then
							hrp.Velocity = Vector3.new(game.Players.LocalPlayer.Character.Humanoid.MoveDirection.X*speed,hrp.Velocity.Y,game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Z*speed)
						end
						if uis:IsKeyDown(Enum.KeyCode.A) then
							hrp.Velocity = Vector3.new(game.Players.LocalPlayer.Character.Humanoid.MoveDirection.X*speed,hrp.Velocity.Y + 0,game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Z*speed)
						end
						if uis:IsKeyDown(Enum.KeyCode.S) then
							hrp.Velocity = Vector3.new(game.Players.LocalPlayer.Character.Humanoid.MoveDirection.X*speed,hrp.Velocity.Y + 0,game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Z*speed)
						end
						if uis:IsKeyDown(Enum.KeyCode.W) then
							hrp.Velocity = Vector3.new(game.Players.LocalPlayer.Character.Humanoid.MoveDirection.X*speed,hrp.Velocity.Y + 0,game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Z*speed)
						end
					end
				end
			end)
		end
	elseif Bhopc then
		Bhopc:Disconnect()
	end
end)

MiscTabCategoryMovement:AddDropdown("Type", {"Forward", "Velocity"}, "Forward", "MiscCategoryMovementType")

MiscTabCategoryMovement:AddSlider("Speed", {1, 400, 40, 1, ""}, "MiscTabCategoryMovementSpeed")

local VisualsTab = Window:CreateTab("Visuals")

local VisualsTabCategoryWorld = VisualsTab:AddCategory("World", 1)

local skybox = game.Lighting:FindFirstChildOfClass("Sky")

VisualsTabCategoryWorld:AddToggle("Celestial Bodies Shown", true, "VisualsTabCategoryWorldCelestialBodiesShown", function(val)
	if val then
		skybox.CelestialBodiesShown = true
	else
		skybox.CelestialBodiesShown = false
	end
end)

VisualsTabCategoryWorld:AddSlider("Moon Angular Size", {0, 60, 11, 0.01, ""}, "VisualsTabCategoryWorldMoonAngularSize", function(val)
	skybox.MoonAngularSize = val
end)

VisualsTabCategoryWorld:AddSlider("Sun Angular Size", {0, 60, 21, 0.01, ""}, "VisualsTabCategoryWorldSunAngularSize", function(val)
	skybox.SunAngularSize = val
end)

VisualsTabCategoryWorld:AddSlider("Star Count", {0, 5000, 1334, 0.01, ""}, "VisualsTabCategoryWorldStarCount", function(val)
	skybox.StarCount = val
end)

CheckNsusFolder()
CheckCSkysFile()
local SkyList = {"Default", "Dark Green Sky", "Dark Space", "Hell Planet", "Mountains", "Nebula", "Night Mountains", "Northern Lights", "Pink Sky", "Purple Sky", "Space"}
local sfuc2 = loadstring(readfile("Neversus/custom_skys.txt"))
local asset2 = sfuc2()
for i, v in pairs(asset2) do
	if i then
		table.insert(SkyList, "[C] " .. i)
	else
		break
	end
end

VisualsTabCategoryWorld:AddDropdown("Sky", SkyList, "Default", "VisualsTabCategoryWorldSky", function(val)
	if val == "Default" then
		skybox.SkyboxBk = "rbxassetid://150553096"
		skybox.SkyboxDn = "rbxassetid://150553062"
		skybox.SkyboxFt = "rbxassetid://150553119"
		skybox.SkyboxLf = "rbxassetid://150553049"
		skybox.SkyboxRt = "rbxassetid://150553079"
		skybox.SkyboxUp = "rbxassetid://150553131"
	elseif val == "Dark Green Sky" then
		skybox.SkyboxBk = "rbxassetid://566611187"
		skybox.SkyboxDn = "rbxassetid://566613198"
		skybox.SkyboxFt = "rbxassetid://566611142"
		skybox.SkyboxLf = "rbxassetid://566611266"
		skybox.SkyboxRt = "rbxassetid://566611300"
		skybox.SkyboxUp = "rbxassetid://566611218"
	elseif val == "Dark Space" then
		skybox.SkyboxBk = "http://www.roblox.com/asset/?id=155441936"
		skybox.SkyboxDn = "http://www.roblox.com/asset/?id=155441802"
		skybox.SkyboxFt = "http://www.roblox.com/asset/?id=155441818"
		skybox.SkyboxLf = "http://www.roblox.com/asset/?id=155441777"
		skybox.SkyboxRt = "http://www.roblox.com/asset/?id=155441874"
		skybox.SkyboxUp = "http://www.roblox.com/asset/?id=155441905"
	elseif val == "Hell Planet" then
		skybox.SkyboxBk = "rbxassetid://11730840088"
		skybox.SkyboxDn = "rbxassetid://11730842997"
		skybox.SkyboxFt = "rbxassetid://11730849615"
		skybox.SkyboxLf = "rbxassetid://11730852920"
		skybox.SkyboxRt = "rbxassetid://11730855491"
		skybox.SkyboxUp = "rbxassetid://11730857150"
	elseif val == "Mountains" then
		skybox.SkyboxBk = "http://www.roblox.com/asset/?id=368385273"
		skybox.SkyboxDn = "http://www.roblox.com/asset/?id=48015300"
		skybox.SkyboxFt = "http://www.roblox.com/asset/?id=368388290"
		skybox.SkyboxLf = "http://www.roblox.com/asset/?id=368390615"
		skybox.SkyboxRt = "http://www.roblox.com/asset/?id=368385190"
		skybox.SkyboxUp = "http://www.roblox.com/asset/?id=48015387"
	elseif val == "Nebula" then
		skybox.SkyboxBk = "http://www.roblox.com/asset/?id=159454299"
		skybox.SkyboxDn = "http://www.roblox.com/asset/?id=159454296"
		skybox.SkyboxFt = "http://www.roblox.com/asset/?id=159454293"
		skybox.SkyboxLf = "http://www.roblox.com/asset/?id=159454286"
		skybox.SkyboxRt = "http://www.roblox.com/asset/?id=159454300"
		skybox.SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
	elseif val == "Night Mountains" then
		skybox.SkyboxBk = "http://www.roblox.com/Asset/?ID=12064107"
		skybox.SkyboxDn = "http://www.roblox.com/Asset/?ID=12064152"
		skybox.SkyboxFt = "http://www.roblox.com/Asset/?ID=12064121"
		skybox.SkyboxLf = "http://www.roblox.com/Asset/?ID=12063984"
		skybox.SkyboxRt = "http://www.roblox.com/Asset/?ID=12064115"
		skybox.SkyboxUp = "http://www.roblox.com/Asset/?ID=12064131"
	elseif val == "Northern Lights" then
		skybox.SkyboxBk = "http://www.roblox.com/asset/?id=5260808177"
		skybox.SkyboxDn = "http://www.roblox.com/asset/?id=5260653793"
		skybox.SkyboxFt = "http://www.roblox.com/asset/?id=5260817288"
		skybox.SkyboxLf = "http://www.roblox.com/asset/?id=5260800833"
		skybox.SkyboxRt = "http://www.roblox.com/asset/?id=5260811073"
		skybox.SkyboxUp = "http://www.roblox.com/asset/?id=5260824661"
	elseif val == "Pink Sky" then
		skybox.SkyboxBk = "http://www.roblox.com/asset/?id=271042516"
		skybox.SkyboxDn = "http://www.roblox.com/asset/?id=271077243"
		skybox.SkyboxFt = "http://www.roblox.com/asset/?id=271042556"
		skybox.SkyboxLf = "http://www.roblox.com/asset/?id=271042310"
		skybox.SkyboxRt = "http://www.roblox.com/asset/?id=271042467"
		skybox.SkyboxUp = "http://www.roblox.com/asset/?id=271077958"
	elseif val == "Purple Sky" then
		skybox.SkyboxBk = "http://www.roblox.com/asset/?id=570557514"
		skybox.SkyboxDn = "http://www.roblox.com/asset/?id=570557775"
		skybox.SkyboxFt = "http://www.roblox.com/asset/?id=570557559"
		skybox.SkyboxLf = "http://www.roblox.com/asset/?id=570557620"
		skybox.SkyboxRt = "http://www.roblox.com/asset/?id=570557672"
		skybox.SkyboxUp = "http://www.roblox.com/asset/?id=570557727"
	elseif val == "Space" then
		skybox.SkyboxBk = "http://www.roblox.com/asset/?id=166509999"
		skybox.SkyboxDn = "http://www.roblox.com/asset/?id=166510057"
		skybox.SkyboxFt = "http://www.roblox.com/asset/?id=166510116"
		skybox.SkyboxLf = "http://www.roblox.com/asset/?id=166510092"
		skybox.SkyboxRt = "http://www.roblox.com/asset/?id=166510131"
		skybox.SkyboxUp = "http://www.roblox.com/asset/?id=166510114"
	else
		val = string.sub(val, 5, #val)
		for i, v in ipairs(asset2[val]) do
			if not tonumber(v) then
				if not (pcall(function() game:GetService("MarketplaceService"):GetProductInfo(asset2[val][i]) end)) then
					asset2[val][i] = "rbxassetid://13869102785"
				end
			else
				asset2[val][i] = "rbxassetid://" .. tostring(v)
				if not (pcall(function() game:GetService("MarketplaceService"):GetProductInfo(asset2[val][i]) end)) then
					asset2[val][i] = "rbxassetid://13869102785"
				end
			end
		end
		print(asset2)
		skybox.SkyboxBk = asset2[val][1]
		skybox.SkyboxDn = asset2[val][2]
		skybox.SkyboxFt = asset2[val][3]
		skybox.SkyboxLf = asset2[val][4]
		skybox.SkyboxRt = asset2[val][5]
		skybox.SkyboxUp = asset2[val][6]
	end
end)

--skybox.SkyboxBk = ""
--skybox.SkyboxDn = ""
--skybox.SkyboxFt = ""
--skybox.SkyboxLf = ""
--skybox.SkyboxRt = ""
--skybox.SkyboxUp = ""
VisualsTabCategoryWorld:AddLabel("adding a custom sky box, to save and")
VisualsTabCategoryWorld:AddLabel("use it, you need to fill in the")
VisualsTabCategoryWorld:AddLabel("fields below and click the \"save\"")
VisualsTabCategoryWorld:AddLabel("button, then re-run the script, and")
VisualsTabCategoryWorld:AddLabel("it will appear in the sky drop-down list.")
VisualsTabCategoryWorld:AddTextBox("Sky Name", "", "VisualsTabCategoryWorldSkyName")
VisualsTabCategoryWorld:AddTextBox("SkyboxBk", "Asset Number", "VisualsTabCategoryWorldSkyboxBk")
VisualsTabCategoryWorld:AddTextBox("SkyboxDn", "Asset Number", "VisualsTabCategoryWorldSkyboxDn")
VisualsTabCategoryWorld:AddTextBox("SkyboxFt", "Asset Number", "VisualsTabCategoryWorldSkyboxFt")
VisualsTabCategoryWorld:AddTextBox("SkyboxLf", "Asset Number", "VisualsTabCategoryWorldSkyboxLf")
VisualsTabCategoryWorld:AddTextBox("SkyboxRt", "Asset Number", "VisualsTabCategoryWorldSkyboxRt")
VisualsTabCategoryWorld:AddTextBox("SkyboxUp", "Asset Number", "VisualsTabCategoryWorldSkyboxUp")
VisualsTabCategoryWorld:AddButton("Save", function()
	CheckNsusFolder()
	CheckCSkysFile()
	local name
	if not library.pointers.VisualsTabCategoryWorldSkyName.value or library.pointers.VisualsTabCategoryWorldSkyName.value == "" then
		name = "Unnamed"
	else
		name = library.pointers.VisualsTabCategoryWorldSkyName.value
	end
	local sfuc = loadstring(readfile("Neversus/custom_skys.txt"))
	local asset = sfuc()
	local urindex = 1
	local doname = name
	while wait() do
		if asset[doname] then
			doname = name .. " " .. urindex
			urindex += 1
		else
			name = doname
			print(name, doname)
			break
		end
	end
	asset[name] = {
		library.pointers.VisualsTabCategoryWorldSkyboxBk.value,
		library.pointers.VisualsTabCategoryWorldSkyboxDn.value,
		library.pointers.VisualsTabCategoryWorldSkyboxFt.value,
		library.pointers.VisualsTabCategoryWorldSkyboxLf.value,
		library.pointers.VisualsTabCategoryWorldSkyboxRt.value,
		library.pointers.VisualsTabCategoryWorldSkyboxUp.value
	}
	writefile("Neversus/custom_skys.txt", "return " .. TableToString(asset))
end)

VisualsTabCategoryWorld:AddTextBox("RemoveSky", "Sky Name", "VisualsTabCategoryWorldRemoveSky")

VisualsTabCategoryWorld:AddButton("Remove", function()
	local sfuc = loadstring(readfile("Neversus/custom_skys.txt"))
	local asset = sfuc()
	local tts = TableToString(asset)
	if library.pointers.VisualsTabCategoryWorldRemoveSky.value and library.pointers.VisualsTabCategoryWorldRemoveSky.value ~= "" then
		if OneMoreLen(asset) then
			asset[library.pointers.VisualsTabCategoryWorldRemoveSky.value] = nil
			writefile("Neversus/custom_skys.txt", "return " .. TableToString(asset))
		else
			writefile("Neversus/custom_skys.txt", "return {}")
		end
	end
end)

local cce = Instance.new("ColorCorrectionEffect", game.Lighting)
cce.Enabled = false
local sre = Instance.new("SunRaysEffect", game.Lighting)
sre.Enabled = false
local atm = Instance.new("Atmosphere", game.Lighting)
local ble = Instance.new("BloomEffect", game.Lighting)
ble.Enabled = false
local blu = Instance.new("BlurEffect", game.Lighting)
blu.Enabled = false
VisualsTabCategoryWorld:AddToggle("Color Correction Enabled", false, "VisualsTabCategoryWorldCce", function(val)
	if val then
		cce.Enabled = true
	else
		cce.Enabled = false
	end
end)

VisualsTabCategoryWorld:AddSlider("Brightness", {-1.18, 3, 0, 0.01, ""}, "VisualsTabCategoryWorldBr", function(val)
	cce.Brightness = val
end)

VisualsTabCategoryWorld:AddSlider("Contrast", {-10000, 10000, 0, 0.01, ""}, "VisualsTabCategoryWorldCo", function(val)
	cce.Contrast = val
end)

VisualsTabCategoryWorld:AddSlider("Saturation", {-100, 220, 0, 0.01, ""}, "VisualsTabCategoryWorldSa", function(val)
	cce.Saturation = val
end)

VisualsTabCategoryWorld:AddColorPicker("Tint Color", Color3.new(1,1,1), "VisualsTabCategoryWorldTc", function(val)
	cce.TintColor = val
end)

VisualsTabCategoryWorld:AddToggle("Sun Rays Enabled", false, "VisualsTabCategoryWorldSr", function(val)
	if val then
		sre.Enabled = true
	else
		sre.Enabled = false
	end
end)

VisualsTabCategoryWorld:AddSlider("Intensity", {0, 50, 0, 0.01, ""}, "VisualsTabCategoryWorldIn", function(val)
	sre.Intensity = val
end)

VisualsTabCategoryWorld:AddSlider("Spread", {0, 4.9, 0, 0.01, ""}, "VisualsTabCategoryWorldSpread", function(val)
	sre.Spread = val
end)

VisualsTabCategoryWorld:AddToggle("Atmosphere", false, "VisualsTabCategoryWorldAtmosphere", function(val)
	if val then
		atm.Parent = game.Lighting
	else
		atm.Parent = nil
	end
end)

VisualsTabCategoryWorld:AddColorPicker("Color", Color3.new(0.780392, 0.666667, 0.419608), "VisualsTabCategoryWorldAtmColor", function(val)
	atm.Color = val
end)

VisualsTabCategoryWorld:AddColorPicker("Decay", Color3.new(0.360784, 0.235294, 0.0509804), "VisualsTabCategoryWorldAtmDecay", function(val)
	atm.Decay = val
end)

VisualsTabCategoryWorld:AddSlider("Glare", {0, 10, 0, 0.01, ""}, "VisualsTabCategoryWorldGlare", function(val)
	atm.Glare = val
end)

VisualsTabCategoryWorld:AddSlider("Haze", {0, 10, 0, 0.01, ""}, "VisualsTabCategoryWorldHaze", function(val)
	atm.Haze = val
end)

VisualsTabCategoryWorld:AddSlider("Offset", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryWorldOffset", function(val)
	atm.Offset = val
end)

VisualsTabCategoryWorld:AddSlider("Density", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryWorldDensity", function(val)
	atm.Density = val
end)

VisualsTabCategoryWorld:AddToggle("Bloom", false, "VisualsTabCategoryWorldBloom", function(val)
	if val then
		ble.Enabled = true
	else
		ble.Enabled = false
	end
end)

VisualsTabCategoryWorld:AddSlider("Intensity", {0, 100, 0, 0.01, ""}, "VisualsTabCategoryWorldBleIntensity", function(val)
	ble.Intensity = val
end)

VisualsTabCategoryWorld:AddSlider("Size", {0, 100, 0, 0.01, ""}, "VisualsTabCategoryWorldBleSize", function(val)
	ble.Size = val
end)

VisualsTabCategoryWorld:AddSlider("Threshold", {0, 4, 0, 0.01, ""}, "VisualsTabCategoryWorldHaze", function(val)
	ble.Threshold = val
end)

VisualsTabCategoryWorld:AddToggle("Blur", false, "VisualsTabCategoryWorldBlur", function(val)
	if val then
		blu.Enabled = true
	else
		blu.Enabled = false
	end
end)

VisualsTabCategoryWorld:AddSlider("Size", {0, 56, 0, 0.01, ""}, "VisualsTabCategoryWorldBluSize", function(val)
	blu.Size = val
end)

VisualsTabCategoryWorld:AddColorPicker("Ambient", Color3.new(0.27451, 0.27451, 0.27451), "VisualsTabCategoryWorldAmbient", function(val)
	game.Lighting.Ambient = val
end)

VisualsTabCategoryWorld:AddColorPicker("Outdoor Ambient", Color3.new(0.27451, 0.27451, 0.27451), "VisualsTabCategoryWorldOutdoorAmbient", function(val)
	game.Lighting.OutdoorAmbient = val
end)

VisualsTabCategoryWorld:AddColorPicker("Color Shift_Top", Color3.new(0, 0, 0), "VisualsTabCategoryWorldColorShift_Top", function(val)
	game.Lighting.ColorShift_Top = val
end)

VisualsTabCategoryWorld:AddColorPicker("Color Shift_Bottom", Color3.new(0, 0, 0), "VisualsTabCategoryWorldColorShift_Bottom", function(val)
	game.Lighting.ColorShift_Bottom = val
end)

VisualsTabCategoryWorld:AddSlider("Environment Diffuse Scale", {0, 1, 1, 0.01, ""}, "VisualsTabCategoryWorldEnvironmentDiffuseScale", function(val)
	game.Lighting.EnvironmentDiffuseScale = val
end)

VisualsTabCategoryWorld:AddSlider("Environment Specular Scale", {0, 1, 1, 0.01, ""}, "VisualsTabCategoryWorldEnvironmentSpecularScale", function(val)
	game.Lighting.EnvironmentSpecularScale = val
end)

VisualsTabCategoryWorld:AddSlider("Brightness", {0, 100, 1, 0.01, ""}, "VisualsTabCategoryWorldLBrightness", function(val)
	game.Lighting.Brightness = val
end)

VisualsTabCategoryWorld:AddSlider("Geographic Latitude", {0, 360, 1, 0.01, ""}, "VisualsTabCategoryWorldGeographicLatitude", function(val)
	game.Lighting.GeographicLatitude = val
end)

VisualsTabCategoryWorld:AddToggle("Spin GL", false, "VisualsTabCategoryWorldSpinGL", function(val)
	if val then
		local spinv = library.pointers.VisualsTabCategoryWorldGeographicLatitude.value
		repeat
			wait(library.pointers.VisualsTabCategoryWorldSpinDelay.value)
			if spinv < 360 then
				game.Lighting.GeographicLatitude = spinv
				spinv += library.pointers.VisualsTabCategoryWorldSpinStep.value
			else
				spinv = 0
			end
		until not library.pointers.VisualsTabCategoryWorldSpinGL.value
	else
		game.Lighting.GeographicLatitude = library.pointers.VisualsTabCategoryWorldGeographicLatitude.value
	end
end)

VisualsTabCategoryWorld:AddSlider("Spin Delay", {0, 10, 0, 0.01, ""}, "VisualsTabCategoryWorldSpinDelay")

VisualsTabCategoryWorld:AddSlider("Spin Step", {0, 360, 1, 0.01, ""}, "VisualsTabCategoryWorldSpinStep")

VisualsTabCategoryWorld:AddColorPicker("Fog Color (if atmosphere off)", Color3.new(0.25098, 0.345098, 0.4), "VisualsTabCategoryWorldFogColor", function(val)
	game.Lighting.FogColor = val
end)

VisualsTabCategoryWorld:AddSlider("Fog Start (if atmosphere off)", {0, 100000, 800, 0.01, ""}, "VisualsTabCategoryWorldFogStart", function(val)
	game.Lighting.FogStart = val
end)

VisualsTabCategoryWorld:AddSlider("Fog End (if atmosphere off)", {0, 100000, 1400, 0.01, ""}, "VisualsTabCategoryWorldFogEnd", function(val)
	game.Lighting.FogEnd = val
end)

VisualsTabCategoryWorld:AddToggle("Global Shadows", true, "VisualsTabCategoryWorldGlobalShadows", function(val)
	if val then
		game.Lighting.GlobalShadows = true
	else
		game.Lighting.GlobalShadows = false
	end
end)

local whl = Instance.new("Highlight", workspace)
whl.Enabled = false

VisualsTabCategoryWorld:AddToggle("Workspace Highlight", false, "VisualsTabCategoryWorldWorkspaceHighlight", function(val)
	if val then
		whl.Enabled = true
	else
		whl.Enabled = false
	end
end)

VisualsTabCategoryWorld:AddColorPicker("Fill Color", Color3.new(1, 1, 1), "VisualsTabCategoryWorldFillColor", function(val)
	whl.FillColor = val
end)

VisualsTabCategoryWorld:AddColorPicker("Outline Color", Color3.new(1, 1, 1), "VisualsTabCategoryWorldOutlineColor", function(val)
	whl.OutlineColor = val
end)

VisualsTabCategoryWorld:AddSlider("Fill Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryWorldFillTransparency", function(val)
	whl.FillTransparency = val
end)

VisualsTabCategoryWorld:AddSlider("Outline Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryWorldOutlineTransparency", function(val)
	whl.OutlineTransparency = val
end)

MiscTabCategoryHumanoid:AddTextBox("Sit on the player head", "Target player name...", "MiscTabCategoryHumanoidHeadSit")

--VisualsTabCategoryWorld:AddDropdown("Hitbox Priority", {"FOV", "Distance"}, "FOV", "LegitTabCategoryLegitbotHitboxPriority")

local SettingsTab = Window:CreateTab("Settings")

local SettingsTabCategoryMain = SettingsTab:AddCategory("Main", 1)

SettingsTabCategoryMain:AddKeybind("UI Toggle Keybind", Enum.KeyCode.RightShift, "SettingsTabCategoryUIToggleKeybind")

uis.InputBegan:Connect(function(input)
	if input.KeyCode == library.pointers.SettingsTabCategoryUIToggleKeybind.value or input.UserInputType == library.pointers.SettingsTabCategoryUIToggleKeybind.value then
		library.base.Window.Visible = not library.base.Window.Visible
	end
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
					Logs("miss due to \"Hitchance\"", 1)
				end
			end
		end
		return self.FireServer(self, unpack(Args))
	end
	return oldNamecall(self, ...)
end)