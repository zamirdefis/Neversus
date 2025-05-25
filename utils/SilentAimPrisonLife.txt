local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local camera = game:GetService("Workspace").CurrentCamera

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
		Args[1][1]["Hit"] = GetClosestPlayer()[2].Character.Head
		return self.FireServer(self, unpack(Args))
	end
	return oldNamecall(self, ...)
end)