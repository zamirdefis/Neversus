local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local camera = game:GetService("Workspace").CurrentCamera
local bulletimpact = true
local silentaim = true
local HitSoundEnabled = true
local infRangeEnabled = true

local function _ESP(c, pl)
	if not c:FindFirstChild("hl") then
		local hum = c:WaitForChild("Humanoid")
		if not hum then return end
		print("123")
		local connect1
		local connect2
		local function linkDestroy()
			if connect1 then
				connect1:Disconnect()
				connect1 = nil
			end
			if connect2 then
				connect2:Disconnect()
				connect2 = nil 
			end
		end
		connect1 = hum.HealthChanged:Connect(function(v)
			if v <= 0 or hum:GetState() == Enum.HumanoidStateType.Dead then
				linkDestroy()
			end
		end)
		local hl
		local function hlinstnew()
			hl = Instance.new("Highlight")
			hl.Parent = c
			hl.FillColor = pl.TeamColor.Color
			hl.FillTransparency = 0.9
			hl.OutlineColor = pl.TeamColor.Color
			hl.Name = "hl"
		end
		hlinstnew()
		connect2 = pl:GetPropertyChangedSignal("Team"):Connect(function()
			hl:Destroy()
			hlinstnew()
		end)
	end
end
local function ESP()
	for i,v in ipairs(plrs:GetPlayers()) do
		if v ~= plr then
			if v.Character then
				_ESP(v.Character, v)
			end
			v.CharacterAdded:Connect(function(chr)
				_ESP(chr, v)
			end)
		end
	end
	plrs.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function(chr)
			_ESP(chr, player)
		end)  
	end)
end
ESP()

local function bulletimpactshow(fpos)
	if plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Muzzle") then
		local firepart = plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Muzzle")
		local distance = (firepart.Position - fpos).Magnitude
		local b = Instance.new("Part")
		b.Size = Vector3.new(0.3, 0.3, distance)
		b.CFrame = CFrame.new(firepart.Position, fpos) *  CFrame.new(0, 0, -distance / 2)
		b.CanCollide = false
		b.CanQuery = false
		b.Anchored = true
		b.Parent = workspace
		task.delay(0.1, function()
			for i = 0, 10 do
				task.wait(0.1)
				b.Transparency = i / 10
			end
			b:Destroy()
		end)
	end
end

local function HitPartType(part)
	if not part then	
		return false
	elseif part.Parent:FindFirstChild("Humanoid") or part.Parent.Parent:FindFirstChild("Humanoid") then
		return 2
	else
		return 1
	end
end

local function HitSound(infr, orig, endd, tool)
	if infr or orig and endd and tool then
		if infr or (orig.Position - endd).Magnitude < require(tool.GunStates).Range then
			local sound = Instance.new("Sound", game.ReplicatedStorage)
			sound.SoundId = "rbxassetid://4817809188"
			sound:Play()
			task.delay(0.1, function()
				task.wait(2)
				sound:Destroy()
			end)
		end
	end
end

local function GetClosestPlayer()
	local Closest = {nil, nil}
	local MousePos = Vector2.new(mouse.X, mouse.Y)
	for _, Player in pairs(game.Players:GetPlayers()) do
		if Player == game.Players.LocalPlayer then continue end
		if Player.Team.Name == plr.Team.Name then continue end
		local Character = Player.Character
		if Character then
			local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart then
				local vector, onScreen = camera:WorldToScreenPoint(HumanoidRootPart.Position)
				if onScreen then
					local Distance = (MousePos - Vector2.new(vector.X, vector.Y)).Magnitude
					if Closest[1] == nil then Closest = {Distance, Player} continue end
					if  Distance < Closest[1] then
						Closest = {Distance, Player}
					end
				end
			end
		end
	end
	return Closest
end

--> Hooking to the remote <--
local gmt = getrawmetatable(game)
setreadonly(gmt, false)
local oldNamecall = gmt.__namecall

gmt.__namecall = newcclosure(function(self, ...)
	local Args = {...}
	local method = getnamecallmethod()
	if tostring(self) == "ShootEvent" and tostring(method) == "FireServer" then
		if silentaim then
			if GetClosestPlayer()[2] then
				local clplr = GetClosestPlayer()[2].Character.Head
				Args[1][1]["Hit"] = clplr
				if Args[1][2] then
					for i in ipairs(Args[1]) do
						Args[1][i]["Hit"] = clplr
					end
				end
			end
		end
		local HitPartTypeV = HitPartType(Args[1][1]["Hit"])
		if bulletimpact then
			if HitPartTypeV == 2 then
				bulletimpactshow(Args[1][1]["Hit"].Position)
			else
				bulletimpactshow(mouse.Hit.Position)
			end
		end
		if HitSoundEnabled then
			if HitPartType then
				local endpos
				if HitPartTypeV == 2 then
					endpos = Args[1][1]["Hit"].Position
				else
					endpos = false
				end
				if not infRangeEnabled then
					HitSound(false, plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild("Muzzle") or plr.Character:FindFirstChild("HumanoidRootPart") or false, endpos, plr.Character:FindFirstChildOfClass("Tool") or false)
				elseif endpos then
					HitSound(true)
				end
			end
		end
		return self.FireServer(self, unpack(Args))
	end
	return oldNamecall(self, ...)
end)