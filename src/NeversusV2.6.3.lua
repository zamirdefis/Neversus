local plrs = game:GetService("Players")
local run = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local plr = plrs.LocalPlayer
local Camera = workspace.CurrentCamera
local SrcSize = Camera.ViewportSize
local HackSrcGUI = Instance.new("ScreenGui", plr.PlayerGui)
HackSrcGUI.Name = "Nsus"
local BoxesStoragePath = Instance.new("Folder", HackSrcGUI)
BoxesStoragePath.Name = "Boxes"

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

local function wtsp(Vector_3, DoNotCheckVisible)
	local Vector, OnScreen = Camera:WorldToScreenPoint(Vector_3)
	if OnScreen or DoNotCheckVisible then return Vector2.new(Vector.X, Vector.Y) else return false end
end

local function OneMoreLen(Table)
	local count = 0
	for _ in pairs(Table) do 
		count = count + 1
		if count > 1 then
			return true
		end
	end
	if count <= 1 then
		return false
	end
	return false
end

local function TableLen(Table)
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

VisualsTabCategoryWorld:AddDropdown("Sky", {"Default", "Dark Green Sky", "Dark Space", "Hell Planet", "Mountains", "Nebula", "Night Mountains", "Northern Lights", "Pink Sky", "Purple Sky", "Space", "Wednesday", "Dogs"}, "Default", "VisualsTabCategoryWorldSky", function(val)
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
	elseif val == "Wednesday" then
		skybox.SkyboxBk = "rbxassetid://12643121398"
		skybox.SkyboxDn = "rbxassetid://12643121398"
		skybox.SkyboxFt = "rbxassetid://12643121398"
		skybox.SkyboxLf = "rbxassetid://12643121398"
		skybox.SkyboxRt = "rbxassetid://12643121398"
		skybox.SkyboxUp = "rbxassetid://12643121398"
	elseif val == "Dogs" then
		skybox.SkyboxBk = "rbxassetid://7386292998"
		skybox.SkyboxDn = "rbxassetid://6821483979"
		skybox.SkyboxFt = "rbxassetid://12686005287"
		skybox.SkyboxLf = "rbxassetid://6318683143"
		skybox.SkyboxRt = "rbxassetid://6670961654"
		skybox.SkyboxUp = "rbxassetid://6184369449"
	end
end)

VisualsTabCategoryWorld:AddDropdown("Sun", {"Default", "Purple Planet", "Rainbow Planet", "Earth", "Astro Mercury", "Basalt Planet", "Moon", "Moon 2", "Moon 3", "Blood Moon", "Purple Moon", "Yellow Moon", "Red Moon", "Sun", "Sun 1", "Sun 2", "Sun 3", "Sun 4", "Sun 5", "Sun 6", "Sun 7", "Sun 8", "Sun 9", "Sun 10", "Sun 11", "Sun 12", "Pixel Sun", "Retro Sun", "Pop Cat WTF????", "USSR POP CAT WTF??????", "POP CAT HEAD?????>?>?>", "CatCatLodg!@?!?12??1 :skull:"}, "Default", "VisualsTabCategoryWorldSun", function(val)
	if val == "Default" then
		skybox.SunTextureId = "rbxasset://sky/sun.jpg"
	elseif val == "Purple Planet" then
		skybox.SunTextureId = "rbxassetid://10286074603"
	elseif val == "Rainbow Planet" then
		skybox.SunTextureId = "http://www.roblox.com/asset/?id=13974500907"
	elseif val == "Earth" then
		skybox.SunTextureId = "http://www.roblox.com/asset/?id=13974531989"
	elseif val == "Astro Mercury" then
		skybox.SunTextureId = "http://www.roblox.com/asset/?id=13974597673"
	elseif val == "Basalt Planet" then
		skybox.SunTextureId = "http://www.roblox.com/asset/?id=13974667948"
	elseif val == "Moon" then
		skybox.SunTextureId = "http://www.roblox.com/asset/?id=13974751717"
	elseif val == "Moon 2" then
		skybox.SunTextureId = "rbxassetid://1521815011"
	elseif val == "Moon 3" then
		skybox.SunTextureId = "rbxassetid://9013498676"
	elseif val == "Blood Moon" then 
		skybox.SunTextureId = "rbxassetid://4778936384"
	elseif val == "Purple Moon" then 
		skybox.SunTextureId = "rbxassetid://7342098842"
	elseif val == "Yellow Moon" then 
		skybox.SunTextureId = "rbxassetid://13513903142"
	elseif val == "Red Moon" then 
		skybox.SunTextureId = "rbxassetid://13713200424"
	elseif val == "Sun" then 
		skybox.SunTextureId = "rbxassetid://330304800"
	elseif val == "Sun 2" then 
		skybox.SunTextureId = "rbxassetid://3272373915"
	elseif val == "Sun 3" then 
		skybox.SunTextureId = "rbxassetid://4173924347"
	elseif val == "Sun 4" then 
		skybox.SunTextureId = "rbxassetid://5897825770"
	elseif val == "Sun 5" then 
		skybox.SunTextureId = "rbxassetid://3272285673"
	elseif val == "Sun 6" then 
		skybox.SunTextureId = "rbxassetid://4999573323"
	elseif val == "Sun 7" then 
		skybox.SunTextureId = "rbxassetid://13040508479"
	elseif val == "Sun 8" then 
		skybox.SunTextureId = "rbxassetid://3568088803"
	elseif val == "Sun 9" then 
		skybox.SunTextureId = "rbxassetid://1614428686"
	elseif val == "Sun 10" then 
		skybox.SunTextureId = "rbxassetid://5012125430"
	elseif val == "Sun 11" then 
		skybox.SunTextureId = "rbxassetid://6608749860"
	elseif val == "Sun 12" then 
		skybox.SunTextureId = "rbxassetid://12994074754"
	elseif val == "Pixel Sun" then 
		skybox.SunTextureId = "rbxassetid://6578308123"
	elseif val == "Retro Sun" then 
		skybox.SunTextureId = "rbxassetid://1168049349"
	elseif val == "Pop Cat WTF????" then 
		skybox.SunTextureId = "rbxassetid://8100227769"
	elseif val == "USSR POP CAT WTF??????" then 
		skybox.SunTextureId = "rbxassetid://11318155149"
	elseif val == "POP CAT HEAD?????>?>?>" then 
		skybox.SunTextureId = "rbxassetid://12595188061"
	elseif val == "CatCatLodg!@?!?12??1 :skull:" then 
		skybox.SunTextureId = "http://www.roblox.com/asset/?id=13975163665"
	end
end)

VisualsTabCategoryWorld:AddDropdown("Moon", {"Default", "Purple Planet", "Rainbow Planet", "Earth", "Astro Mercury", "Basalt Planet", "Moon", "Moon 2", "Moon 3", "Blood Moon", "Purple Moon", "Yellow Moon", "Red Moon", "Sun", "Sun 1", "Sun 2", "Sun 3", "Sun 4", "Sun 5", "Sun 6", "Sun 7", "Sun 8", "Sun 9", "Sun 10", "Sun 11", "Sun 12", "Pixel Sun", "Retro Sun", "Pop Cat WTF????", "USSR POP CAT WTF??????", "POP CAT HEAD?????>?>?>", "CatCatLodg!@?!?12??1 :skull:"}, "Default", "VisualsTabCategoryWorldMoon", function(val)
	if val == "Default" then
		skybox.MoonTextureId = "rbxasset://sky/sun.jpg"
	elseif val == "Purple Planet" then
		skybox.MoonTextureId = "rbxassetid://10286074603"
	elseif val == "Rainbow Planet" then
		skybox.MoonTextureId = "http://www.roblox.com/asset/?id=13974500907"
	elseif val == "Earth" then
		skybox.MoonTextureId = "http://www.roblox.com/asset/?id=13974531989"
	elseif val == "Astro Mercury" then
		skybox.MoonTextureId = "http://www.roblox.com/asset/?id=13974597673"
	elseif val == "Basalt Planet" then
		skybox.MoonTextureId = "http://www.roblox.com/asset/?id=13974667948"
	elseif val == "Moon" then
		skybox.MoonTextureId = "http://www.roblox.com/asset/?id=13974751717"
	elseif val == "Moon 2" then
		skybox.MoonTextureId = "rbxassetid://1521815011"
	elseif val == "Moon 3" then
		skybox.MoonTextureId = "rbxassetid://9013498676"
	elseif val == "Blood Moon" then 
		skybox.MoonTextureId = "rbxassetid://4778936384"
	elseif val == "Purple Moon" then 
		skybox.MoonTextureId = "rbxassetid://7342098842"
	elseif val == "Yellow Moon" then 
		skybox.MoonTextureId = "rbxassetid://13513903142"
	elseif val == "Red Moon" then 
		skybox.MoonTextureId = "rbxassetid://13713200424"
	elseif val == "Sun" then 
		skybox.MoonTextureId = "rbxassetid://330304800"
	elseif val == "Sun 2" then 
		skybox.MoonTextureId = "rbxassetid://3272373915"
	elseif val == "Sun 3" then 
		skybox.MoonTextureId = "rbxassetid://4173924347"
	elseif val == "Sun 4" then 
		skybox.MoonTextureId = "rbxassetid://5897825770"
	elseif val == "Sun 5" then 
		skybox.MoonTextureId = "rbxassetid://3272285673"
	elseif val == "Sun 6" then 
		skybox.MoonTextureId = "rbxassetid://4999573323"
	elseif val == "Sun 7" then 
		skybox.MoonTextureId = "rbxassetid://13040508479"
	elseif val == "Sun 8" then 
		skybox.MoonTextureId = "rbxassetid://3568088803"
	elseif val == "Sun 9" then 
		skybox.MoonTextureId = "rbxassetid://1614428686"
	elseif val == "Sun 10" then 
		skybox.MoonTextureId = "rbxassetid://5012125430"
	elseif val == "Sun 11" then 
		skybox.MoonTextureId = "rbxassetid://6608749860"
	elseif val == "Sun 12" then 
		skybox.MoonTextureId = "rbxassetid://12994074754"
	elseif val == "Pixel Sun" then 
		skybox.MoonTextureId = "rbxassetid://6578308123"
	elseif val == "Retro Sun" then 
		skybox.MoonTextureId = "rbxassetid://1168049349"
	elseif val == "Pop Cat WTF????" then 
		skybox.MoonTextureId = "rbxassetid://8100227769"
	elseif val == "USSR POP CAT WTF??????" then 
		skybox.MoonTextureId = "rbxassetid://11318155149"
	elseif val == "POP CAT HEAD?????>?>?>" then 
		skybox.MoonTextureId = "rbxassetid://12595188061"
	elseif val == "CatCatLodg!@?!?12??1 :skull:" then 
		skybox.MoonTextureId = "http://www.roblox.com/asset/?id=13975163665"
	end
end)
--skybox.SkyboxBk = ""
--skybox.SkyboxDn = ""
--skybox.SkyboxFt = ""
--skybox.SkyboxLf = ""
--skybox.SkyboxRt = ""
--skybox.SkyboxUp = ""

local cce = Instance.new("ColorCorrectionEffect", game.Lighting)
cce.Enabled = true

VisualsTabCategoryWorld:AddColorPicker("World Color", Color3.new(1,1,1), "VisualsTabCategoryWorldWorldColor", function(val)
	cce.TintColor = val
end)

VisualsTabCategoryWorld:AddSlider("Geographic Latitude", {0, 360, 1, 0.01, ""}, "VisualsTabCategoryWorldGeographicLatitude", function(val)
	game.Lighting.GeographicLatitude = val
end)

VisualsTabCategoryWorld:AddColorPicker("Fog Color", Color3.new(0.25098, 0.345098, 0.4), "VisualsTabCategoryWorldFogColor", function(val)
	game.Lighting.FogColor = val
end)

VisualsTabCategoryWorld:AddSlider("Fog Start", {0, 100000, 800, 0.01, ""}, "VisualsTabCategoryWorldFogStart", function(val)
	game.Lighting.FogStart = val
end)

VisualsTabCategoryWorld:AddSlider("Fog End", {0, 100000, 1400, 0.01, ""}, "VisualsTabCategoryWorldFogEnd", function(val)
	game.Lighting.FogEnd = val
end)

VisualsTabCategoryWorld:AddToggle("Global Shadows", true, "VisualsTabCategoryWorldGlobalShadows", function(val)
	if val then
		game.Lighting.GlobalShadows = true
	else
		game.Lighting.GlobalShadows = false
	end
end)

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

local VisualsTabCategoryEsp = VisualsTab:AddCategory("Esp", 2)

local EspList = {Chams = {}, Boxes = {}}
local BoxesConnects = {}
local ChamsConnects = {}

local function ESPCleaner(val)
	if val == 1 then
		if #EspList.Chams > 0 then
			for _, v in ipairs(EspList.Chams) do
				v:Destroy()
			end
			for _, v in ipairs(ChamsConnects) do
				v:Disconnect()
			end
			ChamsConnects = {}
		end
	elseif val == 2 then
		if BoxesStoragePath:FindFirstChildOfClass("Frame") then
			for _, v in ipairs(BoxesStoragePath:GetChildren()) do
				v:Destroy()
			end
			for _, v in ipairs(BoxesConnects) do
				v:Disconnect()
			end
			BoxesConnects = {}
		end
	end
end

local function Chams(c, pl)
	local hum = c:WaitForChild("Humanoid")
	if not hum then return end
	local connect1
	local connect2
	local connect3
	local hl = nil
	local function linkDestroy(hldeleted)
		if connect1 then
			connect1:Disconnect()
			connect1 = nil
		end
		if connect2 then
			connect2:Disconnect()
			connect2 = nil 
		end
		if not hldeleted then
			if hl then
				hl:Destroy()
				hl = nil
			end
		end
		return
	end
	if library.pointers.VisualsTabCategoryEspChams.value then
		if not c:FindFirstChild(string.sub(pl.Team.Name, 1, 1) .. "hl") then 
			hl = Instance.new("Highlight")
			hl.Parent = c
			hl.FillColor = pl.TeamColor.Color
			hl.FillTransparency = library.pointers.VisualsTabCategoryEspFTrans.value
			hl.OutlineTransparency = library.pointers.VisualsTabCategoryEspOTrans.value
			hl.Name = string.sub(pl.Team.Name, 1, 1) .. "_" .. "hl"	
			hl.FillColor = library.pointers["VisualsTabCategoryEspFCC" .. string.sub(pl.Team.Name, 1, 1)].value
			hl.OutlineColor = library.pointers["VisualsTabCategoryEspOCC" .. string.sub(pl.Team.Name, 1, 1)].value
			table.insert(EspList.Chams, hl)
			connect2 = hl.Destroying:Connect(function()
				linkDestroy(true)
			end)
		end
	end
	connect1 = hum.HealthChanged:Connect(function(v)
		if v <= 0 or hum:GetState() == Enum.HumanoidStateType.Dead then
			linkDestroy()
		end
	end)
	connect2 = pl:GetPropertyChangedSignal("Team"):Connect(function()
		if hl then
			hl.Name = string.sub(pl.Team.Name, 1, 1) .. "_" .. "hl"
			hl.FillColor = library.pointers["VisualsTabCategoryEspFCC" .. string.sub(pl.Team.Name, 1, 1)].value
			hl.OutlineColor = library.pointers["VisualsTabCategoryEspOCC" .. string.sub(pl.Team.Name, 1, 1)].value
		end
	end)
end

VisualsTabCategoryEsp:AddToggle("Chams", false, "VisualsTabCategoryEspChams", function(val)
	if val then
		for i,v in ipairs(plrs:GetPlayers()) do
			if v ~= plr then
				if v.Character then
					Chams(v.Character, v)
				end
				table.insert(ChamsConnects, v.CharacterAdded:Connect(function(chr) Chams(chr, v) end))
			end
		end
	else
		ESPCleaner(1)
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Criminal Fill Color", Color3.new(1, 0, 0.0156863), "VisualsTabCategoryEspFCCC", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			if string.sub(v.Name, 1, 1) == "C" then
				v.FillColor = val
			end
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Inmate Fill Color", Color3.new(1, 0.788235, 0.0352941), "VisualsTabCategoryEspFCCI", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			if string.sub(v.Name, 1, 1) == "I" then
				v.FillColor = val
			end
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Guard Fill Color", Color3.new(0.0666667, 0, 1), "VisualsTabCategoryEspFCCG", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			if string.sub(v.Name, 1, 1) == "G" then
				v.FillColor = val
			end
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Neutral Fill Color", Color3.new(0.713725, 0.713725, 0.713725), "VisualsTabCategoryEspFCCN", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			if string.sub(v.Name, 1, 1) == "N" then
				v.FillColor = val
			end
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Criminal Outline Color", Color3.new(1, 0, 0.0156863), "VisualsTabCategoryEspOCCC", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			if string.sub(v.Name, 1, 1) == "C" then
				v.OutlineColor = val
			end
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Inmate Outline Color", Color3.new(1, 0.788235, 0.0352941), "VisualsTabCategoryEspOCCI", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			if string.sub(v.Name, 1, 1) == "I" then
				v.OutlineColor = val
			end
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Guard Outline Color", Color3.new(0.0666667, 0, 1), "VisualsTabCategoryEspOCCG", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			if string.sub(v.Name, 1, 1) == "G" then
				v.OutlineColor = val
			end
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Neutral Outline Color", Color3.new(0.713725, 0.713725, 0.713725), "VisualsTabCategoryEspOCCN", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			if string.sub(v.Name, 1, 1) == "N" then
				v.OutlineColor = val
			end
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Fill Transparency", {0, 1, 0.7, 0.01, ""}, "VisualsTabCategoryEspFTrans", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			v.FillTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Outline Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspOTrans", function(val)
	if #EspList.Chams > 0 then
		for _, v in ipairs(EspList.Chams) do
			v.OutlineTransparency = val
		end
	end
end)

local function AddBox(Model, IsPlayer, Thickness, Color, LineJoinMode, Transparency, FillColor, FillTransparency)
	local Box = Instance.new("Frame")
	Box.Name = Model.Name
	Box.BackgroundColor3 = FillColor or Color3.fromRGB(255, 255, 255)
	Box.Transparency = FillTransparency or 1
	local Outline = Instance.new("UIStroke")
	Outline.Thickness = Thickness or 1
	Outline.Color = Color or Color3.fromRGB(255, 255, 255)
	Outline.LineJoinMode = LineJoinMode or Enum.LineJoinMode.Round
	Outline.Transparency = Transparency or 0
	Outline.Parent = Box
	Box.Parent = BoxesStoragePath
	local hum = IsPlayer and Model:WaitForChild("Humanoid") or nil
	local pl = IsPlayer and plrs:GetPlayerFromCharacter(Model) or nil
	local hrp = IsPlayer and Model:FindFirstChild("HumanoidRootPart") or nil
	if IsPlayer and not hum then return false end
	if IsPlayer and not pl then return false end
	if IsPlayer and not hrp then return false end
	local connect1
	local connect2
	local connect3
	local connect4
	local function ld(des)
		if connect4 then
			connect4:Disconnect()
			connect4 = nil
		end
		if not des then
			Box:Destroy()
			Box = nil
		end
		if connect3 then
			connect3:Disconnect()
			connect3 = nil
		end
		if connect1 then
			connect1:Disconnect()
			connect1 = nil
		end
		if connect2 then
			connect2:Disconnect()
			connect2 = nil 
		end
		return
	end
	connect3 = run[library.pointers.VisualsTabCategoryEspRenderM.value]:Connect(function()
		if not Model.Parent then ld() return end
		local Cf, Size = Model:GetBoundingBox()
		local Vertex = {
			Cf * CFrame.new(Size.X/2,Size.Y/2,-Size.Z/2),
			Cf * CFrame.new(Size.X/2,Size.Y/2,Size.Z/2),
			Cf * CFrame.new(-Size.X/2,Size.Y/2,-Size.Z/2),
			Cf * CFrame.new(-Size.X/2,Size.Y/2,Size.Z/2),
			Cf * CFrame.new(Size.X/2,-Size.Y/2,-Size.Z/2),
			Cf * CFrame.new(Size.X/2,-Size.Y/2,Size.Z/2),
			Cf * CFrame.new(-Size.X/2,-Size.Y/2,-Size.Z/2),
			Cf * CFrame.new(-Size.X/2,-Size.Y/2,Size.Z/2)
		}
		local DY_G
		local UY_G
		local LX_G
		local RX_G
		do
			local DYm_G = math.huge
			local UYm_G = math.huge
			local LXm_G = math.huge
			local RXm_G = math.huge
			for _, v in ipairs(Vertex) do
				if wtsp(v.Position) and wtsp(Cf.Position) then
					local vec_2 = wtsp(v.Position)
					if vec_2.Y < 0 or vec_2.Y > SrcSize.Y or vec_2.X < 0 or vec_2.X > SrcSize.X then Box.Visible = false return end
					local Cf_2 = wtsp(Cf.Position)
					local DY = Vector2.new(Cf_2.X, SrcSize.Y)
					local UY = Vector2.new(Cf_2.X, 0)
					local LX = Vector2.new(0, Cf_2.Y)
					local RX = Vector2.new(SrcSize.X, Cf_2.Y)
					local DYm = (vec_2 - DY).magnitude
					local UYm = (vec_2 - UY).magnitude
					local LXm = (vec_2 - LX).magnitude
					local RXm = (vec_2 - RX).magnitude
					if UYm < UYm_G then
						UY_G = vec_2.Y
						UYm_G = UYm
					end
					if DYm < DYm_G then
						DY_G = vec_2.Y
						DYm_G = DYm
					end
					if LXm < LXm_G then
						LX_G = vec_2.X
						LXm_G = LXm
					end
					if RXm < RXm_G then
						RX_G = vec_2.X
						RXm_G = RXm
					end
					Box.Visible = true
				else
					Box.Visible = false
					return
				end
			end
		end
		Box.Position = UDim2.fromOffset(LX_G, UY_G)
		Box.Size = UDim2.fromOffset(math.abs(LX_G - RX_G), math.abs(UY_G - DY_G))
	end)
	if IsPlayer then
		connect1 = hum.Died:Connect(function(v)
			ld()
		end)
		connect2 = pl:GetPropertyChangedSignal("Team"):Connect(function()
		end)
	end
	connect4 = Box.Destroying:Connect(function()
		if IsPlayer then
			ld(true)
		end
	end)
end

local function EzBox(Character)
	AddBox(Character, true, library.pointers.VisualsTabCategoryEspBThickness.value, _, _, library.pointers.VisualsTabCategoryEspBTransparency.value)
end

VisualsTabCategoryEsp:AddToggle("Boxes", false, "VisualsTabCategoryEspBoxes", function(val)
	if val then
		for i,v in ipairs(plrs:GetPlayers()) do
			if v ~= plr then
				if v.Character then
					EzBox(v.Character)
				end
				table.insert(BoxesConnects, v.CharacterAdded:Connect(function(chr) EzBox(chr) end))
			end
		end
	else
		ESPCleaner(2)
	end
end)

plrs.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(chr)
		if library.pointers.VisualsTabCategoryEspChams.value then
			Chams(chr, player)
		end
		if library.pointers.VisualsTabCategoryEspBoxes.value then
			EzBox(chr)
		end
	end)  
end)

VisualsTabCategoryEsp:AddDropdown("Render Method", {"Heartbeat", "RenderStepped"}, "RenderStepped", "VisualsTabCategoryEspRenderM", function()
	ESPCleaner(2) 
	if library.pointers.VisualsTabCategoryEspBoxes.value then
		for i,v in ipairs(plrs:GetPlayers()) do
			if v ~= plr then
				if v.Character then
					EzBox(v.Character)
				end
				table.insert(BoxesConnects, v.CharacterAdded:Connect(function(chr) EzBox(chr) end))
			end
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Thickness", {0.45, 5, 0.45, 0.01, ""}, "VisualsTabCategoryEspBThickness", function(val)
	if BoxesStoragePath:FindFirstChildOfClass("Frame") then
		for _, v in ipairs(BoxesStoragePath:GetChildren()) do
			v:FindFirstChildOfClass("UIStroke").Thickness = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspBTransparency", function(val)
	if BoxesStoragePath:FindFirstChildOfClass("Frame") then
		for _, v in ipairs(BoxesStoragePath:GetChildren()) do
			v:FindFirstChildOfClass("UIStroke").Transparency = val
		end
	end
end)

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