local function UpdateESP()
	task.spawn(function()
		UpdateESPFuc = run.Heartbeat:Connect(function()
			for	_, v in pairs(plrs:GetPlayers()) do
				if v == plr then
					if v.Character:FindFirstChild("HumanoidRootPart") then
						local hrp = v.Character.HumanoidRootPart
						if v.Team.Name == "Inmate" then
							if not hrp:FindFirstChild("glow") then
								if tb_ChamsT then
									for _, z in pairs(v.Character:GetChildren()) do
										if z:IsA("MeshPart") then
											if not z:FindFirstChild("Cham") then
												local cham = Instance.new("BoxHandleAdornment")
												cham.Name = "Cham"
												cham.Parent = z
												cham.Adornee = z
												cham.AlwaysOnTop = true
												cham.ZIndex = 10
												cham.Size = z.Size + Vector3.new(0.04, 0.04, 0.04)
												cham.Color3 = Color3.fromRGB(CChamsI[1], CChamsI[2], CChamsI[3])
												cham.Transparency = TChamsI[1]
											end
										end
									end
								end
								if glowing then
									local glowON = Instance.new("Highlight")
									glowON.Name = "glow"
									if tb_OLglowT then
										glowON.OutlineColor = Color3.fromRGB(InmateOColor[1], InmateOColor[2], InmateOColor[3])
										glowON.OutlineTransparency = InmateOTransparency[1]
										if not tb_FglowT then
											glowON.FillTransparency = 1
										end
									end
									if tb_FglowT then
										glowON.FillColor = Color3.fromRGB(InmateFColor[1], InmateFColor[2], InmateFColor[3])
										glowON.FillTransparency = InmateFTransparency[1]
										if not tb_OLglowT then
											glowON.OutlineTransparency = 1
										end
									end
										glowON.Adornee = hrp.Parent
										glowON.Parent = hrp
								end
							end
						elseif v.Team.Name == "Guard" then
							if not hrp:FindFirstChild("glow") then
								local glowON = Instance.new("Highlight")
								glowON.Name = "glow"
								if tb_OLglowT then
									glowON.OutlineColor = Color3.fromRGB(GuardOColor[1], GuardOColor[2], GuardOColor[3])
									glowON.OutlineTransparency = GuardOTransparency[1]
									if not tb_FglowT then
										glowON.FillTransparency = 1
									end
								end
								if tb_FglowT then
									glowON.FillColor = Color3.fromRGB(GuardFColor[1], GuardFColor[2], GuardFColor[3])
									glowON.FillTransparency = GuardFTransparency[1]
									if not tb_OLglowT then
										glowON.OutlineTransparency = 1
									end
								end
								glowON.Adornee = hrp.Parent
								glowON.Parent = hrp
							end
						elseif v.Team.Name == "Criminals" then
							if not hrp:FindFirstChild("glow") then
								local glowON = Instance.new("Highlight")
								glowON.Name = "glow"
								if tb_OLglowT then
									glowON.OutlineColor = Color3.fromRGB(CriminalsOColor[1], CriminalsOColor[2], CriminalsOColor[3])
									glowON.OutlineTransparency = CriminalsOTransparency[1]
									if not tb_FglowT then
										glowON.FillTransparency = 1
									end
								end
								if tb_FglowT then
									glowON.FillColor = Color3.fromRGB(CriminalsFColor[1], CriminalsFColor[2], CriminalsFColor[3])
									glowON.FillTransparency = CriminalsFTransparency[1]
									if not tb_OLglowT then
										glowON.OutlineTransparency = 1
									end
								end
								glowON.Adornee = hrp.Parent
								glowON.Parent = hrp
							end
						end
					end
				end
			end
		end)
	end)
end