local function ColorPicker(butt, color, trans, cleanstate, name, part)
	local np = Vector2.new(mouse.X, mouse.Y) / camera.ViewportSize
	colorTaker.Position = UDim2.new(np.X, 0, np.Y, 0)
	colorTaker.color.BackgroundColor3 = butt.BackgroundColor3
	if butt:FindFirstChild("upT") then
		colorTaker.backCFT.BackgroundColor3 = butt.upT.BackgroundColor3
	end
	colorTaker.Visible = true
	local connect, connect2, connect3, connect4, connect5
	connect2 = ctRed.FocusLost:Connect(function()
		colorTaker.color.BackgroundColor3 = Color3.fromRGB(ctRed.Text, ctGreen.Text, ctBlue.Text)
		colorTaker.colorFromT.BackgroundColor3 = Color3.fromRGB(ctRed.Text, ctGreen.Text, ctBlue.Text)
	end)
	connect3 = ctGreen.FocusLost:Connect(function()
		colorTaker.color.BackgroundColor3 = Color3.fromRGB(ctRed.Text, ctGreen.Text, ctBlue.Text)
		colorTaker.colorFromT.BackgroundColor3 = Color3.fromRGB(ctRed.Text, ctGreen.Text, ctBlue.Text)
	end)
	connect4 = ctBlue.FocusLost:Connect(function()
		colorTaker.color.BackgroundColor3 = Color3.fromRGB(ctRed.Text, ctGreen.Text, ctBlue.Text)
		colorTaker.colorFromT.BackgroundColor3 = Color3.fromRGB(ctRed.Text, ctGreen.Text, ctBlue.Text)
	end)
	connect5 = ctTransp.FocusLost:Connect(function()
		if butt:FindFirstChild("upT") then
			if pcall(function()
					ctColorFromT.Transparency = ctTransp.Text / 100
				end) then
				ctColorFromT.Transparency = ctTransp.Text / 100
			end
		end
	end)
	connect = ctCloseButt.MouseButton1Click:Connect(function()
		butt.BackgroundColor3 = Color3.fromRGB(ctRed.Text, ctGreen.Text, ctBlue.Text)
		color[1] = ctRed.Text
		color[2] = ctGreen.Text
		color[3] = ctBlue.Text
		if trans ~= nil then
			if pcall(function()
					if ctTransp.Text / 100 then
					end
				end) then
				trans[1] = ctTransp.Text / 100
			end
		end
		if butt:FindFirstChild("upT") then
			butt.upT.BackgroundColor3 = Color3.fromRGB(ctRed.Text, ctGreen.Text, ctBlue.Text)
			if pcall(function()
					if ctTransp.Text / 100 then
					end
				end) then
				butt.upT.Transparency = ctTransp.Text / 100
			else
				butt.upT.Transparency = 0
			end
		end
		if cleanstate == true then
			Cleaner(name, part)
		end
		colorTaker.Visible = false
		connect2:Disconnect()
		connect3:Disconnect()
		connect4:Disconnect()
		connect5:Disconnect()
		connect:Disconnect()
	end)
end
