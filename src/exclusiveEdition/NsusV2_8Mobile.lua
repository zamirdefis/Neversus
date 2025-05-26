local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local run = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local TxtService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local SrcSize = Camera.ViewportSize
local Mouse = plr:GetMouse()
local HackSrcGUI = Instance.new("ScreenGui", plr.PlayerGui)
HackSrcGUI.Name = "Nsus"
local BoxesStoragePath = Instance.new("Folder", HackSrcGUI)
BoxesStoragePath.Name = "Boxes"
local TagsPath = Instance.new("Folder", HackSrcGUI)
TagsPath.Name = "Tags"
local BarsPath = Instance.new("Folder", HackSrcGUI)
BarsPath.Name = "Bars"
local TagsRemover = Instance.new("BoolValue", HackSrcGUI)
TagsRemover.Name = "RemoveTags"
local ArmorTagsRemover = Instance.new("BoolValue", HackSrcGUI)
ArmorTagsRemover.Name = "RemoveArmorTags"
local SpecPath = Instance.new("Folder", HackSrcGUI)
SpecPath.Name = "Spectator"
local SpecMainFrame = Instance.new("Frame")
local SpecTextLabel = Instance.new("TextLabel")
local SpecTextButton = Instance.new("TextButton")
SpecMainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
SpecMainFrame.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
SpecMainFrame.BorderColor3 = Color3.fromRGB(43, 43, 43)
SpecMainFrame.BorderSizePixel = 0
SpecMainFrame.Position = UDim2.new(0.5, 0, 0.78, 0)
SpecMainFrame.Size = UDim2.new(0, 120, 0, 30)
SpecMainFrame.Name = "Exit"
SpecTextLabel.BackgroundColor3 = Color3.fromRGB(35, 34, 35)
SpecTextLabel.BorderColor3 = Color3.fromRGB(43, 43, 43)
SpecTextLabel.BorderSizePixel = 2
SpecTextLabel.Position = UDim2.new(0.0375000015, 0, 0.164736941, 0)
SpecTextLabel.Size = UDim2.new(0, 110, 0, 19)
SpecTextLabel.Font = Enum.Font.SourceSans
SpecTextLabel.Text = "Exit"
SpecTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpecTextLabel.TextSize = 16.000
SpecTextLabel.Parent = SpecMainFrame
SpecTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpecTextButton.BackgroundTransparency = 1.000
SpecTextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
SpecTextButton.BorderSizePixel = 0
SpecTextButton.Size = UDim2.new(0, 110, 0, 19)
SpecTextButton.Font = Enum.Font.SourceSans
SpecTextButton.Text = ""
SpecTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SpecTextButton.TextSize = 14.000
SpecTextButton.TextTransparency = 1.000
SpecTextButton.Parent = SpecTextLabel
local RightSpecButton = Instance.new("ImageButton")
local LeftSpecButton = Instance.new("ImageButton")
RightSpecButton.Name = "Right"
RightSpecButton.BackgroundTransparency = 1.000
RightSpecButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
RightSpecButton.BorderSizePixel = 0
RightSpecButton.Position = UDim2.new(0.844772339, 0, 0.453000009, 0)
RightSpecButton.Rotation = 90.000
RightSpecButton.Size = UDim2.new(0, 45, 0, 45)
RightSpecButton.Image = "rbxassetid://278543076"
RightSpecButton.ImageColor3 = Color3.fromRGB(35, 34, 35)
LeftSpecButton.Name = "Left"
LeftSpecButton.BackgroundTransparency = 1.000
LeftSpecButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
LeftSpecButton.BorderSizePixel = 0
LeftSpecButton.Position = UDim2.new(0.108999997, 0, 0.453000009, 0)
LeftSpecButton.Rotation = -90.000
LeftSpecButton.Size = UDim2.new(0, 45, 0, 45)
LeftSpecButton.Image = "rbxassetid://278543076"
LeftSpecButton.ImageColor3 = Color3.fromRGB(35, 34, 35)
SpecMainFrame.Visible = false
LeftSpecButton.Visible = false
RightSpecButton.Visible = false
LeftSpecButton.Parent = SpecPath
RightSpecButton.Parent = SpecPath
SpecMainFrame.Parent = SpecPath
local OffSpecMode = false
local LeftSpecButtonOrigPos = LeftSpecButton.Position
local RightSpecButtonOrigPos = RightSpecButton.Position

-- временные
LegitbotTeamCheck = true
LegitbotAimPart = "Head"
LegitbotDeathCheck = true
--
local SilentAimLegitbot = {target = nil}
local FOVCircle = Drawing.new("Circle")

local Fonts = {"Legacy", "Arial", "ArialBold", "SourceSans", "SourceSansBold", "SourceSansLight", "SourceSansItalic", "Bodoni", "Garamond", "Cartoon", "Code", "Highway", "SciFi", "Arcade", "Fantasy", "Antique", "SourceSansSemibold", "Gotham", "GothamMedium", "GothamBold", "GothamBlack", "AmaticSC", "Bangers", "Creepster", "DenkOne", "Fondamento", "FredokaOne", "GrenzeGotisch", "IndieFlower", "JosefinSans", "Jura", "Kalam", "LuckiestGuy", "Merriweather", "Michroma", "Nunito", "Oswald", "PatrickHand", "PermanentMarker", "Roboto", "RobotoCondensed", "RobotoMono", "Sarpanch", "SpecialElite", "TitilliumWeb", "Ubuntu", "Unknown"}
local Materials = {"Plastic", "SmoothPlastic", "Neon", "Wood", "WoodPlanks", "Marble", "Basalt", "Slate", "CrackedLava", "Concrete", "Limestone", "Granite", "Pavement", "Brick", "Pebble", "Cobblestone", "Rock", "Sandstone", "CorrodedMetal", "DiamondPlate", "Foil", "Metal", "Grass", "LeafyGrass", "Sand", "Fabric", "Snow", "Mud", "Ground", "Asphalt", "Salt", "Ice", "Glacier", "Glass", "ForceField", "Air", "Water", "Cardboard", "Carpet", "CeramicTiles", "ClayRoofTiles", "RoofShingles", "Leather", "Plaster", "Rubber"}
local AccessoryTypes = {"Unknown", "Hat", "Hair", "Face", "Neck", "Shoulder", "Front", "Back", "Waist", "TShirt", "Shirt", "Pants", "Jacket", "Sweater", "Shorts", "LeftShoe", "RightShoe", "DressSkirt", "Eyebrow", "Eyelash"}
local VectorMID = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2  - (game:GetService("GuiService"):GetGuiInset().Y/2))

-- Hexagon UI Library
local TweenService, RunService, UserInputService,gui,dragging,dragInput,dragStart,startPos,cpt,cpf,cppicking,cppickingVal,cppickingAlpha,cphue,cpsat,cpval,focused,highest,focusedBox = game:GetService("TweenService"),game:GetService("RunService"), game:GetService("UserInputService")
local cpalpha = 0

-- Dragging
local function updateDrag(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
end

--color picker
local function updateColorHue(input, obj, hue, sat)
	hue = (obj.AbsoluteSize.X-(input.Position.X-obj.AbsolutePosition.X))/obj.AbsoluteSize.X
	sat = (obj.AbsoluteSize.Y-(input.Position.Y-obj.AbsolutePosition.Y))/obj.AbsoluteSize.Y
	return (input.Position.X-obj.AbsolutePosition.X)/obj.AbsoluteSize.X, (input.Position.Y-obj.AbsolutePosition.Y)/obj.AbsoluteSize.Y, hue, sat
end

local function updateValue(input, obj, val)
	val = (obj.AbsoluteSize.Y-(input.Position.Y-obj.AbsolutePosition.Y))/obj.AbsoluteSize.Y
	return (input.Position.Y-obj.AbsolutePosition.Y)/obj.AbsoluteSize.Y, val
end

local function updateAlpha(input, obj, alpha)
	alpha = (obj.AbsoluteSize.X-(input.Position.X-obj.AbsolutePosition.X))/obj.AbsoluteSize.X
	return (input.Position.X-obj.AbsolutePosition.X)/obj.AbsoluteSize.X, alpha
end

local function rgbToHsv(r, g, b)
	r, g, b = r / 255, g / 255, b / 255
	local max, min = math.max(r, g, b), math.min(r, g, b)
	local h, s, v
	v = max

	local d = max - min
	if max == 0 then
		s = 0
	else
		s = d / max
	end

	if max == min then
		h = 0 -- achromatic
	else
		if max == r then
			h = (g - b) / d
			if g < b then
				h = h + 6
			end
		elseif max == g then
			h = (b - r) / d + 2
		elseif max == b then
			h = (r - g) / d + 4
		end
		h = h / 6
	end

	return h, s, v
end

--drag function and color picker
UserInputService.InputChanged:connect(function(input)
	if input == dragInput and dragging then
		updateDrag(input)
	end
	if input.UserInputType == Enum.UserInputType.MouseMovement then

	end
end)

--slider
local function round(num, bracket)
	bracket = bracket or 1
	return math.floor(num/bracket + math.sign(num) * 0.5) * bracket
end

--zindex stuff
local function focusOnOption(obj)
	if highest then
		highest.ZIndex = highest.ZIndex - 5
		for _,v in next, highest:GetDescendants() do
			pcall(function()
				v.ZIndex = v.ZIndex +- 5
			end)
		end
	end
	highest = obj
	highest.ZIndex = highest.ZIndex + 5
	for _,v in next, highest:GetDescendants() do
		pcall(function()
			v.ZIndex = v.ZIndex + 5
		end)
	end
end

local function focusOnWindow(obj)
	if focused then
		focused.ZIndex = focused.ZIndex - 10
		for _,v in next, focused:GetDescendants() do
			pcall(function()
				v.ZIndex = v.ZIndex - 10
			end)
		end
	end
	focused = obj
	focused.ZIndex = focused.ZIndex + 10
	for _,v in next, focused:GetDescendants() do
		pcall(function()
			v.ZIndex = v.ZIndex + 10
		end)
	end
end

local ddcheck
local extframes = {}
for i=1,4 do
	local frame = Instance.new("Frame")
	frame.ZIndex = 50
	frame.BackgroundTransparency = 1
	frame.Visible = false
	if i == 1 then
		frame.Size = UDim2.new(0,1000,0,-1000)
	elseif i == 2 then
		frame.Size = UDim2.new(0,1000,0,1000)
		frame.Position = UDim2.new(1,0,0,0)
	elseif i == 3 then
		frame.Size = UDim2.new(0,-1000,0,1000)
		frame.Position = UDim2.new(1,0,1,0)
	elseif i == 4 then
		frame.Size = UDim2.new(0,-1000,0,-1000)
		frame.Position = UDim2.new(0,0,1,0)
	end
	table.insert(extframes, frame)
	frame.InputBegan:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			frame.Parent.Visible = false
			if ddcheck then
				ddcheck.arrow.Text = ">"
				ddcheck.closed = not ddcheck.closed
			end
			for _,v in next, extframes do
				v.Visible = false
			end
		end
	end)
end

local function closeWindow(obj)
	for _,v in next, extframes do
		v.Visible = true
		v.Parent = obj
	end
end

local library = {
	windows = {},
	pointers = {},
	settings = {
		guiname = "Neversus",
		title = "Neversus",
		logo = "http://www.roblox.com/asset/?id=12716278310", -- "http://www.roblox.com/asset/?id=6597976562",
		footer = " ",
		modal = true,
		font = Enum.Font.SourceSans,
		textsize = 16,
		textstroke = true
	},
	theme = {
		buttons = Color3.fromRGB(20, 200, 20), -- toggle, sliders colors
		text = Color3.fromRGB(235, 235, 235),
		textboxtext = Color3.fromRGB(145, 145, 145),
		main = Color3.fromRGB(30, 30, 30),
		outline = Color3.fromRGB(60, 60, 60),
		tabholder = Color3.fromRGB(35, 35, 35),
		tabbutton = Color3.fromRGB(30, 30, 30),
		tabselected = Color3.fromRGB(50, 50, 50)
	}
}

function library:create(class, properties)
	local inst = Instance.new(class)
	for property, value in pairs(properties) do
		inst[property] = value
	end
	return inst
end

function library:Notify(title, message, time, buttons, _function)
	local notification = {}

	for i,v in pairs(library.base:GetChildren()) do
		if v.Name == "Notification" then
			v:TweenPosition(UDim2.new(v.Position.X, v.Position.Y - UDim.new(0, 100)), "InOut", "Quart", 0.5)
		end
	end

	notification.settings = {
		title = title or "",
		message = message or "",
		time = time or 5,
		buttons = buttons or {}
	}

	notification.window = library:create("TextLabel", {
		ZIndex = 100,
		Size = UDim2.new(0,220,0,80),
		Position = UDim2.new(0,-300,1,-90),
		BackgroundColor3 = Color3.fromRGB(30,30,30),
		Text = "",
		Name = "Notification",
		Parent = library.base
	})

	notification.title = library:create("TextLabel", {
		ZIndex = 100,
		BackgroundTransparency = 1,
		Size = UDim2.new(1,0,0,18),
		Text = notification.settings.title,
		TextSize = 18,
		TextColor3 = Color3.new(1,1,1),
		Font = "Code",
		TextXAlignment = "Left",
		Name = "Title",
		Parent = notification.window
	})

	notification.message = library:create("TextLabel", {
		ZIndex = 100,
		BackgroundTransparency = 1,
		Size = UDim2.new(1,0,0,18),
		Position = UDim2.new(0,0,0.25,0),
		Text = notification.settings.message,
		TextSize = 14,
		TextColor3 = Color3.new(1,1,1),
		Font = "Code",
		TextXAlignment = "Left",
		Name = "Message",
		Parent = notification.window
	})

	for i,v in pairs(notification.settings.buttons) do
		notification["button"..i] = library:create("TextButton", {
			ZIndex = 100,
			Size = UDim2.new(1/#buttons, 0, 0, 16),
			Position = UDim2.new((i-1)/#buttons, 0,0.8,0),
			BackgroundColor3 = Color3.fromRGB(60,60,60),
			Text = v,
			TextSize = 14,
			TextColor3 = Color3.fromRGB(235, 235, 235),
			Font = "Code",
			TextStrokeColor3 = Color3.new(0,0,0),
			TextStrokeTransparency = 0,
			Name = "Button"..i,
			Parent = notification.window
		}) 

		notification["button"..i].InputBegan:connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				_function(notification["button"..i].Text)
				notification.window:TweenPosition(UDim2.new(notification.window.Position.X - UDim.new(0, 310), notification.window.Position.Y), "InOut", "Quart", 0.5)
				wait(0.5)
				if notification and notification.window then
					notification.window:Remove()
					notification = nil
				end
			end
		end)
	end

	notification.window:TweenPosition(UDim2.new(notification.window.Position.X + UDim.new(0, 310), notification.window.Position.Y), "InOut", "Quart", 0.5)

	wait(notification.settings.time)

	if notification and notification.window then
		notification.window:TweenPosition(UDim2.new(notification.window.Position.X - UDim.new(0, 310), notification.window.Position.Y), "InOut", "Quart", 0.5)
		wait(0.5)
		if notification and notification.window then
			notification.window:Remove()
			notification = nil
		end
	end
end

function library:LoadTheme(theme)

end

function library:LoadConfiguration(cfg)
	table.foreach(cfg, function(a,b)
		if library.pointers[a] then
			spawn(function() library.pointers[a]:Set(b) end)
		else
			warn("Config loading error (Object not found):", a, b)
		end
	end)
end

function library:SaveConfiguration()
	local tbl = {}

	local SpecialCharacters = {
		['\a'] = '\\a',
		['\b'] = '\\b',
		['\f'] = '\\f',
		['\n'] = '\\n',
		['\r'] = '\\r',
		['\t'] = '\\t',
		['\v'] = '\\v',
		['\0'] = '\\0'
	}

	local function SerializeType(Value, Class, Comma)
		local NewValue = ''

		if Class == 'string' then
			NewValue = ('"%s"'):format(Value:gsub('[%c%z]', SpecialCharacters))
		elseif Class == 'Instance' then
			NewValue = Value:GetFullName()
		elseif Class == 'EnumItem' then
			NewValue = tostring(Value)
		elseif type(Value) ~= Class then -- CFrame, Vector3, UDim2, ...
			NewValue = Class .. '.new(' .. tostring(Value) .. ')'
		elseif Class == 'userdata' then
			NewValue = ('[Userdata, Metatable Field: %s]'):format(tostring(not not getmetatable(Value)))
		else -- thread, number, boolean, nil, ...
			NewValue = tostring(Value)
		end

		if Comma == true then
			NewValue = NewValue..","
		end

		return NewValue
	end

	local function TableToString(Table, IgnoredTables, Depth)
		IgnoredTables = IgnoredTables or {}

		if IgnoredTables[Table] then
			return IgnoredTables[Table] == Depth - 1 and '[Parent table]' or '[Cyclic Table]'
		end

		Depth = Depth or 0
		Depth = Depth + 1
		IgnoredTables[Table] = Depth

		local Tab = ('    '):rep(Depth)
		local TrailingTab = ('    '):rep(Depth - 1)
		local Result = '{'
		local LineTab = '\n' .. Tab

		for Key, Value in pairs(Table) do
			local KeyClass, ValueClass = typeof(Key), typeof(Value)

			if KeyClass == 'string' then
				Key = Key:gsub('[%c%z]', SpecialCharacters)

				if Key:match'%s' then
					Key = ('["%s"]'):format(Key)
				end

				Key = '["'..Key..'"]'
			else
				Key = '[' .. (KeyClass == 'table' and TableToString(Key, IgnoredTables, Depth):gsub('^[\n\r%s]*(.-)[\n\r%s]*$', '%1') or SerializeType(Key, KeyClass, false)) .. ']'
			end

			Value = ValueClass == 'table' and TableToString(Value, IgnoredTables, Depth) or SerializeType(Value, ValueClass, true)
			Result = Result .. LineTab .. Key .. ' = ' .. Value
		end

		return Result .. '\n'  .. TrailingTab .. '}' .. ","
	end

	for i,v in pairs(library.pointers) do
		if not table.find({"SettingsTabCategoryPlayersUsername", "SettingsTabCategoryConfigsConfig", "SettingsTabCategoryConfigsName"}, i) then
			tbl[i] = v.value
		end
	end

	return TableToString(tbl):sub(0, -2)
end

function library:CreateWindow(csize, cpos)
	ctitle = library.settings.title

	local window = {xpos = 0, close = true, draggable = true}
	table.insert(self.windows, window)

	self.base = self.base or self:create("ScreenGui", {
		Name = library.settings.guiname,
		Parent = game.Players.LocalPlayer.PlayerGui
	})

	self.pointer = self.pointer or self:create("ImageLabel", {
		ZIndex = 100,
		Size = UDim2.new(0,8,0,8),
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5,0.5),
		Image = "rbxassetid://165689900",
		Name = "Pointer",
		Visible = false,
		Parent = self.base
	})

	window.main = self:create("TextButton", {
		Position = UDim2.new(0,cpos.X,0,cpos.Y),
		Size = UDim2.new(0,csize.X,0,csize.Y),
		BackgroundColor3 = self.theme.main,
		BorderColor3 = self.theme.outline,
		Text = "",
		Name = "Window",
		AutoButtonColor = false,
		Parent = self.base
	})

	window.shade = self:create("ImageLabel", {
		Size = UDim2.new(1,0,0,18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://2916745254",
		ImageColor3 = Color3.fromRGB(25, 25, 25),
		ImageTransparency = 0.2,
		Parent = window.main
	})

	window.logo = self:create("ImageLabel", {
		Size = UDim2.new(0,18,0,18),
		Position = UDim2.new(0,8,0,2),
		BackgroundTransparency = 1,
		Name = "Logo",
		Image = library.settings.logo,
		Parent = window.main
	})

	window.title = self:create("TextLabel", {
		Size = UDim2.new(1,0,0,18),
		Position = UDim2.new(0,32,0,2),
		BackgroundTransparency = 1,
		Name = "TitleLabel",
		Text = ctitle, -- tostring(" "..ctitle) or tostring(" "..self.settings.title),
		TextColor3 = self.theme.text,
		TextStrokeTransparency = self.settings.textstroke and 0 or 1,
		TextXAlignment = "Left",
		Font = self.settings.font,
		TextSize = self.settings.textsize + 2,
		Parent = window.main
	})

	window.title.InputBegan:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and window.draggable then
			gui = window.main
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	window.title.InputChanged:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	window.main.InputBegan:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			focusOnWindow(window.main)
		end
	end)

	local spectators = {}

	spectators.main = library:create("TextButton", {
		Position = UDim2.new(0, (workspace.CurrentCamera.ViewportSize.X/2)-100, 0, (workspace.CurrentCamera.ViewportSize.Y/2)-320),
		Size = UDim2.new(0,200,0,40),
		BackgroundColor3 = self.theme.main,
		BorderColor3 = self.theme.outline,
		Text = "",
		Name = "Spectators",
		AutoButtonColor = false,
		Active = true,
		Draggable = true,
		Selectable = true,
		Visible = false,
		Parent = library.base
	})

	spectators.title = library:create("TextLabel", {
		Size = UDim2.new(1,0,0,18),
		Position = UDim2.new(0,0,0,2),
		BackgroundTransparency = 1,
		Name = "TitleLabel",
		Text = "Spectators",
		TextColor3 = self.theme.text,
		TextStrokeTransparency = self.settings.textstroke and 0 or 1,
		Font = self.settings.font,
		TextSize = self.settings.textsize + 2,
		Parent = spectators.main
	})	

	spectators.frame = library:create("Frame", {
		Position = UDim2.new(0,10,0,25),
		Size = UDim2.new(1,-20,1,-35),
		BackgroundColor3 = library.theme.tabholder,
		BorderColor3 = library.theme.outline,
		Name = "SpectatorsFrame",
		Parent = spectators.main
	})

	spectators.layout = library:create("UIListLayout", {
		Parent = spectators.frame
	})

	spectators.layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		if spectators.layout.AbsoluteContentSize.Y == 0 then
			spectators.main.Size = UDim2.new(0,200,0,40)
		else
			spectators.main.Size = UDim2.new(0,200,0,spectators.layout.AbsoluteContentSize.Y+34)
		end
	end)

	function window:CreateTab(name)
		local tab = {}
		local bounds = game:GetService('TextService'):GetTextSize(name, library.settings.textsize, library.settings.font, Vector2.new(math.huge, math.huge))
		tab.rows = {}

		local function createNewRow()
			tab.row = library:create("Frame", {
				Position = UDim2.new(0,csize.X/2 * #tab.rows - (#tab.rows * 10),0,0),
				Size = UDim2.new(0,csize.X/2 - 10,1,0),
				BackgroundTransparency = 1,
				Parent = tab.main
			})

			tab.layout = library:create("UIListLayout", {
				Padding = UDim.new(0,8),
				Parent = tab.row
			})

			tab.layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if tab.layout.AbsoluteContentSize.Y+20 > tab.main.CanvasSize.Y.Offset then
					tab.main.CanvasSize = UDim2.new(0,0,0,tab.layout.AbsoluteContentSize.Y+20)
				end
			end)

			tab.padding = library:create("UIPadding", {
				PaddingLeft = UDim.new(0,4),
				PaddingRight = UDim.new(0,4),
				PaddingTop = UDim.new(0,12),
				Parent = tab.row
			})

			table.insert(tab.rows, tab)

			if #tab.rows > 2 then
				self.main.Size = self.main.Size + UDim2.new(0,csize.X/2 - 10,0,0)
			end
		end

		local function checkRow()
			if tab.row then
				for _,row in pairs(tab.rows) do
					tab = row
				end
			else
				createNewRow()
			end
		end

		self.tabholder = self.tabholder or library:create("Frame", {
			Position = UDim2.new(0,10,0,25),
			Size = UDim2.new(1,-20,1,-55),
			BackgroundColor3 = library.theme.tabholder,
			BorderColor3 = library.theme.outline,
			Name = "PagesFrame",
			Parent = self.main
		})

		self.footer = self.footer or library:create("TextLabel", {
			Position = UDim2.new(0,0,1,0),
			Size = UDim2.new(1,0,0,-18),
			BackgroundColor3 = library.theme.tabbutton,
			BorderColor3 = library.theme.outline,
			Name = "FooterLabel",
			Text = " "..library.settings.footer,
			TextColor3 = library.theme.text,
			TextStrokeTransparency = library.settings.textstroke and 0 or 1,
			Font = library.settings.font,
			TextSize = library.settings.textsize,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = self.main
		})

		tab.main = library:create("ScrollingFrame", {
			Position = UDim2.new(0,0,0,20),
			Size = UDim2.new(1,0,1,-20),
			BackgroundColor3 = library.theme.tabselected,
			BorderColor3 = library.theme.outline,
			Name = "Frame-"..name, -- "PageFrame",
			ScrollBarThickness = 0,
			ScrollingDirection = "Y",
			TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
			MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
			BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
			Visible = false,
			Parent = self.tabholder
		})

		tab.button = library:create("Frame", {
			Position = UDim2.new(0,self.xpos,0,0),
			Size = UDim2.new(0,bounds.X+8,0,19),
			Name = "Button-"..name,
			BorderColor3 = library.theme.outline,
			Parent = self.tabholder
		})

		tab.buttontop = library:create("Frame", {
			Size = UDim2.new(1,0,1,0),
			BackgroundColor3 = library.theme.tabbutton,
			BorderSizePixel = 0,
			BorderColor3 = library.theme.outline,
			Parent = tab.button
		})

		tab.label = library:create("TextLabel", {
			Size = UDim2.new(1,0,1,0),
			BackgroundTransparency = 1,
			Text = name,
			TextColor3 = library.theme.text,
			TextStrokeTransparency = library.settings.textstroke and 0 or 1,
			Font = library.settings.font,
			TextSize = library.settings.textsize,
			Parent = tab.button
		})

		if self.xpos == 0 then
			self.focused = tab
			self.focused.main.Visible = true
			self.focused.buttontop.Size = self.focused.buttontop.Size + UDim2.new(0,0,0,1)
			tab.buttontop.BackgroundColor3 = library.theme.tabselected
		end

		self.xpos = self.xpos + bounds.X + 8

		tab.label.InputBegan:connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				self.focused.main.Visible = false
				self.focused.buttontop.Size = self.focused.buttontop.Size - UDim2.new(0,0,0,1)
				self.focused.buttontop.BackgroundColor3 = library.theme.tabbutton
				self.focused = tab
				self.focused.main.Visible = true
				self.focused.buttontop.Size = self.focused.buttontop.Size + UDim2.new(0,0,0,1)
				self.focused.buttontop.BackgroundColor3 = library.theme.tabselected
			end
		end)

		function tab:AddCategory(title, side)
			local LocalTab = {order = 0}
			local bounds = game:GetService('TextService'):GetTextSize(title, library.settings.textsize, library.settings.font, Vector2.new(math.huge, math.huge))

			if side and typeof(side) == "number" then
				if tab.rows[side] then
					tab = tab.rows[side]
				else
					repeat
						wait()
						createNewRow()
					until tab.rows[side]
				end
			else
				checkRow()
			end

			LocalTab.main = library:create("Frame", {
				Size = UDim2.new(1,0,0,0),
				BackgroundColor3 = library.theme.tabselected,
				BorderColor3 = library.theme.outline,
				BorderSizePixel = 2,
				BorderMode = "Outline",
				Parent = self.row
			})

			LocalTab.title = library:create("TextLabel", {
				AnchorPoint = Vector2.new(0,0.5),
				Position = UDim2.new(0,12,0,0),
				Size = UDim2.new(0,bounds.X + 8,0,2),
				BackgroundColor3 = library.theme.tabselected,
				BorderSizePixel = 0,
				Text = title,
				TextColor3 = library.theme.text,
				TextStrokeTransparency = library.settings.textstroke and 0 or 1,
				Font = library.settings.font,
				TextSize = library.settings.textsize + 2,
				ZIndex = 12,
				Parent = LocalTab.main
			})

			LocalTab.content = library:create("Frame", {
				Size = UDim2.new(1,0,1,0),
				BackgroundColor3 = Color3.fromRGB(40, 40, 40),
				BackgroundTransparency = 0,
				Parent = LocalTab.main
			})

			LocalTab.layout = library:create("UIListLayout", {
				Padding = UDim.new(0,4),
				SortOrder = Enum.SortOrder.LayoutOrder,
				Parent = LocalTab.content
			})

			LocalTab.padding = library:create("UIPadding", {
				PaddingLeft = UDim.new(0,6),
				PaddingRight = UDim.new(0,6),
				PaddingTop = UDim.new(0,12),
				Parent = LocalTab.content
			})

			function LocalTab:AddLabel(text, pointername)
				local label = {}
				checkRow()
				LocalTab.main.Parent = tab.row

				label.label = library:create("TextLabel", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 2),
					BackgroundTransparency = 1,
					Text = "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = LocalTab.content
				})

				function label:Set(text)
					label.text = text
					label.label.Text = text
				end

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+16)

				label:Set(text)
				if pointername then library.pointers[pointername] = label end

				self.order = self.order + 1

				return label
			end

			function LocalTab:AddButton(text, _function)
				local button = {}
				_function = _function or function() end
				checkRow()
				LocalTab.main.Parent = tab.row

				button.button = library:create("TextButton", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 2),
					BackgroundColor3 = Color3.fromRGB(60, 60, 60),
					BackgroundTransparency = 0,
					Text = tostring(text),
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					TextXAlignment = Enum.TextXAlignment.Center,
					Parent = self.content,
				})

				self.order = self.order + 1

				button.button.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						_function()
					end
				end)

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+16)

				return button
			end

			function LocalTab:AddToggle(text, defVal, pointername, _function)
				local toggle = {value = false}
				_function = _function or function() end
				checkRow()
				LocalTab.main.Parent = tab.row

				toggle.button = library:create("TextButton", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 2),
					BackgroundTransparency = 1,
					Text = tostring(text),
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = self.content,
				})

				toggle.holder = library:create("Frame", {
					AnchorPoint = Vector2.new(0,0.5),
					Position = UDim2.new(1,-1,0.5,0),
					Size = UDim2.new(0,-library.settings.textsize+4,0,library.settings.textsize-4),
					BackgroundColor3 = library.theme.tabholder,
					BorderSizePixel = 2,
					BorderColor3 = library.theme.main,
					Parent = toggle.button,
				})

				toggle.visualize = library:create("Frame", {
					Position = UDim2.new(0,0,0,0),
					Size = UDim2.new(1,0,1,0),
					BackgroundTransparency = 1,
					BackgroundColor3 = library.theme.buttons,
					BorderSizePixel = 0,
					Parent = toggle.holder,
				})

				self.order = self.order + 1

				function toggle:Set(value)
					toggle.value = value
					if toggle.value then
						toggle.visualize.BackgroundTransparency = 0
					else
						toggle.visualize.BackgroundTransparency = 1	
					end
					return _function(toggle.value)
				end

				toggle.button.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						toggle.value = not toggle.value
						toggle:Set(toggle.value)
					end
				end)

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+16)

				toggle:Set(defVal)
				library.pointers[pointername] = toggle

				return toggle
			end

			function LocalTab:AddTextBox(text, txtval, pointername, _function, keep)
				local box = {value = ""}

				if txtval then
					if typeof(txtval) == "function" then
						_function = txtval
						txtval = ""
					elseif typeof(txtval) == "string" then
						box.value = txtval
					end
				end

				if keep then
					if typeof(keep) == "string" then
						keep = false
					end
				end

				_function = _function or function() end
				checkRow()
				LocalTab.main.Parent = tab.row

				box.button = library:create("TextButton", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 22),
					BackgroundTransparency = 1,
					Text = tostring(text),
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					Parent = self.content,
				})

				box.box = library:create("TextBox", {
					Position = UDim2.new(0,0,0,19),
					Size = UDim2.new(1,0,0,17),
					BackgroundTransparency = 0,
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.main,
					Text = txtval,
					TextColor3 = library.theme.text,
					PlaceholderText = text,
					PlaceholderColor3 = library.theme.textboxtext,
					Font = library.settings.font,
					TextSize = library.settings.textsize-2,
					TextWrapped = true,
					Parent = box.button,
				})

				self.order = self.order + 1

				box.button.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						box.box:CaptureFocus()
					end
				end)

				box.box:GetPropertyChangedSignal("Text"):connect(function(ext)
					box.value = box.box.Text
					return _function(box.box.Text, false, ext)
				end)

				box.box.FocusLost:connect(function()
					box.value = box.box.Text
					return _function(box.box.Text, true)
				end)

				UserInputService.InputBegan:connect(function(input)
					if input.KeyCode == Enum.KeyCode.Escape and box.box:IsFocused() then
						box.box:ReleaseFocus()
					end
				end)

				function box:Set(value)
					box.value = value
					box.box.Text = value
					--return _function(box.box.Text, true)
				end

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+18)

				box:Set(txtval)
				library.pointers[pointername] = box

				return box
			end

			function LocalTab:AddDropdown(text, defOptions, defVal, pointername, _function, push)
				_function = _function or function() end

				local dropdown = {order = 0, closed = true, options = defOptions, value = nil}

				dropdown.content = {}
				checkRow()
				LocalTab.main.Parent = tab.row

				dropdown.button = library:create("TextButton", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 22),
					BackgroundTransparency = 1,
					Text = tostring(text),
					TextColor3 = library.theme.text,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					Parent = self.content,
				})

				dropdown.main = library:create("TextButton", {
					Position = UDim2.new(0,0,0,19),
					Size = UDim2.new(1,0,0,17),
					BackgroundTransparency = 0,
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.main,
					Text = dropdown.value,
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					Parent = dropdown.button,
				})

				dropdown.arrow = library:create("TextLabel", {
					Position = UDim2.new(1,0,0,2),
					Size = UDim2.new(0,-16,0,16),
					Rotation = 90,
					BackgroundTransparency = 1,
					Text = ">",
					TextColor3 = library.theme.textboxtext, -- library.theme.tabbutton,
					Font = Enum.Font.Arcade,
					TextSize = 18,
					Parent = dropdown.main,
				})

				dropdown.container = library:create("Frame", {
					ZIndex = 15,
					Position = UDim2.new(0,0,1,3),
					BackgroundTransparency = 1,
					Visible = false,
					Parent = dropdown.main,
				})

				dropdown.contentholder = library:create("ScrollingFrame", {
					ZIndex = 15,
					ClipsDescendants = true,
					Size = UDim2.new(1,0,1,0),
					BackgroundTransparency = 0,
					BorderSizePixel = 1,
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.outline,
					CanvasSize = UDim2.new(0,0,0,0),
					ScrollBarThickness = 0,
					Visible = true,
					Parent = dropdown.container,
				})

				dropdown.layout = library:create("UIListLayout", {
					Padding = UDim.new(0,0),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = dropdown.contentholder
				})

				dropdown.search = library:create("TextBox", {
					ZIndex = dropdown.contentholder.ZIndex,
					LayoutOrder = dropdown.order,
					Size = UDim2.new(1,0,0,18),
					BackgroundTransparency = 0,
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.main,
					Text = "",
					PlaceholderText = "Search",
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					Parent = dropdown.contentholder
				})

				self.order = self.order + 1

				local function addOptions(options)
					if typeof(options[1]) == "function" and typeof(options[2]) == "Instance" then
						options = options[1](options[2])
					end

					for _,value in pairs(options) do
						if typeof(value) ~= "table" then 
							value = tostring(value)
						end

						dropdown.order = dropdown.order + 1

						local option = library:create("TextButton", {
							ZIndex = dropdown.contentholder.ZIndex,
							LayoutOrder = dropdown.order,
							Size = UDim2.new(1,0,0,18),
							BackgroundTransparency = 0,
							BackgroundColor3 = library.theme.tabholder,
							BorderColor3 = library.theme.tabbutton,
							Text = value,
							TextColor3 = library.theme.text,
							Font = library.settings.font,
							TextSize = library.settings.textsize,
							AutoButtonColor = false,
							Parent = dropdown.contentholder,
						})

						option.MouseButton1Click:connect(function()
							dropdown.value = value
							if push then
								for _,v in pairs(dropdown.content) do
									if v.LayoutOrder < option.LayoutOrder then
										v.LayoutOrder = v.LayoutOrder + 1
									end
								end
								option.LayoutOrder = 1
							end
							dropdown.main.Text = dropdown.value
							dropdown.closed = true
							dropdown.arrow.Text = ">"
							dropdown.container.Visible = false
							return _function(dropdown.value)
						end)

						if dropdown.order > 5 then
							dropdown.contentholder.CanvasSize = UDim2.new(0,0,0,dropdown.layout.AbsoluteContentSize.Y)
						else
							dropdown.container.Size = UDim2.new(1,0,0,dropdown.layout.AbsoluteContentSize.Y)
						end

						table.insert(dropdown.content, dropdown.order, option)
					end
				end

				function dropdown:Refresh(options, keep)
					if typeof(options) == "function" then
						options = options()
					end

					if not keep then
						for _,v in pairs(dropdown.contentholder:GetChildren()) do
							if v:IsA"TextButton" then
								v:Destroy()
								dropdown.order = dropdown.order - 1
								dropdown.contentholder.CanvasSize = UDim2.new(0,0,0,dropdown.layout.AbsoluteContentSize.Y)
							end
						end
					end

					addOptions(options)
				end

				function dropdown:Search(text)
					for i,v in pairs(dropdown.content) do
						if v.Text:match(text) then
							v.Visible = true
						else
							v.Visible = false
						end
					end
				end

				dropdown.main.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						focusOnOption(dropdown.container)
						closeWindow(dropdown.container)
						ddcheck = dropdown
						dropdown.closed = not dropdown.closed
						dropdown.container.Visible = not dropdown.container.Visible

						if not dropdown.closed then
							dropdown.arrow.Text = "<"
							dropdown.container.Visible = true
							dropdown:Refresh(dropdown.options)
						end
					end
				end)

				dropdown.search.FocusLost:Connect(function(input)
					dropdown:Search(dropdown.search.Text)
				end)

				function dropdown:Set(value)
					dropdown.value = value
					dropdown.main.Text = dropdown.value or "None"
					return _function(dropdown.value)
				end

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+18)

				dropdown:Refresh(defOptions)
				dropdown:Set(defVal)
				library.pointers[pointername] = dropdown

				return dropdown
			end

			function LocalTab:AddMultiDropdown(text, optionz, defVal, pointername, _function, push)
				_function = _function or function() end

				local dropdown = {order = 0, closed = true, options = optionz, value = defVal}

				dropdown.content = {}
				checkRow()
				LocalTab.main.Parent = tab.row

				dropdown.button = library:create("TextButton", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 22),
					BackgroundTransparency = 1,
					Text = tostring(text),
					TextColor3 = library.theme.text,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					Parent = self.content,
				})

				dropdown.main = library:create("TextButton", {
					Position = UDim2.new(0,0,0,19),
					Size = UDim2.new(1,0,0,17),
					BackgroundTransparency = 0,
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.main,
					Text = "test1",
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					Parent = dropdown.button,
				})

				dropdown.arrow = library:create("TextLabel", {
					Position = UDim2.new(1,0,0,2),
					Size = UDim2.new(0,-16,0,16),
					Rotation = 90,
					BackgroundTransparency = 1,
					Text = ">",
					TextColor3 = library.theme.textboxtext,
					Font = Enum.Font.Arcade,
					TextSize = 18,
					Parent = dropdown.main,
				})

				dropdown.container = library:create("Frame", {
					ZIndex = 15,
					Position = UDim2.new(0,0,1,3),
					BackgroundTransparency = 1,
					Visible = false,
					Parent = dropdown.main,
				})

				dropdown.contentholder = library:create("ScrollingFrame", {
					ZIndex = 15,
					ClipsDescendants = true,
					Size = UDim2.new(1,0,1,0),
					BackgroundTransparency = 0,
					BorderSizePixel = 1,
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.outline,
					CanvasSize = UDim2.new(0,0,0,0),
					ScrollBarThickness = 0,
					Visible = true,
					Parent = dropdown.container,
				})

				dropdown.layout = library:create("UIListLayout", {
					Padding = UDim.new(0,0),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = dropdown.contentholder
				})

				dropdown.search = library:create("TextBox", {
					ZIndex = dropdown.contentholder.ZIndex,
					LayoutOrder = dropdown.order,
					Size = UDim2.new(1,0,0,18),
					BackgroundTransparency = 0,
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.main,
					Text = "",
					PlaceholderText = "Search",
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					Parent = dropdown.contentholder
				})

				self.order = self.order + 1

				local function addOptions(options)
					if typeof(options[1]) == "function" and typeof(options[2]) == "Instance" then
						options = options[1](options[2])
					end

					for index,value in pairs(options) do
						if typeof(value) ~= "table" then 
							value = tostring(value)
						end

						dropdown.order = dropdown.order + 1

						local option = library:create("TextButton", {
							ZIndex = dropdown.contentholder.ZIndex,
							LayoutOrder = dropdown.order,
							Size = UDim2.new(1,0,0,18),
							BackgroundTransparency = 0,
							BackgroundColor3 = library.theme.tabholder,
							BorderColor3 = library.theme.tabbutton,
							Text = value,
							TextColor3 = library.theme.text,
							Font = library.settings.font,
							TextSize = library.settings.textsize,
							AutoButtonColor = false,
							Parent = dropdown.contentholder,
						})

						option.MouseButton1Click:connect(function()
							if option.TextColor3 == library.theme.text then
								table.insert(dropdown.value, value)
								option.TextColor3 = library.theme.buttons
							else
								table.foreach(dropdown.value, function(i,v)
									if v == value then
										return table.remove(dropdown.value, i)
									end
								end)
								option.TextColor3 = library.theme.text
							end

							dropdown:Set(dropdown.value)
						end)

						if dropdown.order > 5 then
							dropdown.contentholder.CanvasSize = UDim2.new(0,0,0,dropdown.layout.AbsoluteContentSize.Y)
						else
							dropdown.container.Size = UDim2.new(1,0,0,dropdown.layout.AbsoluteContentSize.Y)
						end

						if table.find(dropdown.value, option.Text) then
							option.TextColor3 = library.theme.buttons
						end

						table.insert(dropdown.content, dropdown.order, option)
					end
				end

				addOptions(dropdown.options)

				function dropdown:Refresh(options, keep)
					if not keep then
						for _,v in pairs(dropdown.contentholder:GetChildren()) do
							if v:IsA"TextButton" then
								v:Destroy()
								dropdown.order = dropdown.order - 1
								dropdown.contentholder.CanvasSize = UDim2.new(0,0,0,dropdown.layout.AbsoluteContentSize.Y)
							end
						end
					end
					addOptions(options)
				end

				function dropdown:Search(text)
					for i,v in pairs(dropdown.content) do
						if v.Text:match(text) then
							v.Visible = true
						else
							v.Visible = false
						end
					end
				end

				dropdown.main.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						focusOnOption(dropdown.container)
						closeWindow(dropdown.container)
						ddcheck = dropdown
						dropdown.closed = not dropdown.closed
						dropdown.container.Visible = not dropdown.container.Visible

						if dropdown.closed then
							dropdown.arrow.Text = ">"
							dropdown.container.Visible = false
						else
							dropdown.arrow.Text = "<"
							dropdown.container.Visible = true
							dropdown:Refresh(dropdown.options)
						end
					end
				end)

				dropdown.search.FocusLost:Connect(function(input)
					dropdown:Search(dropdown.search.Text)
				end)

				function dropdown:Set(value)
					local val = {}

					for i,v in pairs(dropdown.options) do
						for i2,v2 in pairs(value) do
							if v == v2 then
								table.insert(val, v2)
							end
						end
					end

					dropdown.value = val

					-- generate string from table
					otp = ""

					table.foreach(dropdown.value, function(i,v)
						otp = otp..tostring(v)..", "
					end)

					if string.len(otp) > 25 then
						otp = tostring(otp:sub(1, 25).."...")
					end

					dropdown.main.Text = (otp:sub(1) == "" and "None") or (otp:sub(-2, -2) == "," and otp:sub(0, -3)) or otp

					return _function(dropdown.value)
				end

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+18)

				dropdown:Set(defVal)
				library.pointers[pointername] = dropdown

				return dropdown
			end

			function LocalTab:AddSlider(text, values, pointername, _function, float, incrementalMode)
				if values[3] then
					if typeof(values[3]) == "function" then
						if _function then
							if typeof(_function) == "number" then
								incrementalMode = float
								float = _function
							elseif typeof(_function) == "boolean" then
								incrementalMode = _function
								float = nil
							end
						end
						_function = values[3]
						values[3] = 0
					else
						if float then
							if typeof(float) == "boolean" then
								incrementalMode = float
								float = nil
							end
						end
					end
				end

				if values[3] > values[2] then
					values[3] = values[2]
				end

				_function = _function or function() end
				local slider = {value = values[3]}
				checkRow()
				LocalTab.main.Parent = tab.row

				slider.button = library:create("TextButton", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 22),
					BackgroundTransparency = 1,
					Text = tostring(text),
					TextColor3 = library.theme.text,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					Parent = self.content,
				})

				slider.holder = library:create("Frame", {
					Position = UDim2.new(0,0,0,20),
					Size = UDim2.new(1,0,0,17),
					BackgroundTransparency = 1,
					Parent = slider.button,
				})

				slider.visualize = library:create("TextBox", {
					Position = UDim2.new(0,0,0.5,0),
					Size = UDim2.new(1,0,0.5,0),
					BackgroundTransparency = 1,
					Text = tostring(slider.value),
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize-2,
					TextWrapped = true,
					Parent = slider.holder,
				})

				slider.sliderbar = library:create("Frame", {
					AnchorPoint = Vector2.new(0.5,0.5),
					Position = UDim2.new(0.5,0,0.2,0),
					Size = UDim2.new(1,-6,0,4),
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.main,
					Parent = slider.holder,
				})

				slider.sliderfill = library:create("Frame", {
					Size = UDim2.new(slider.value/values[2],0,1,0),
					BackgroundColor3 = library.theme.buttons,
					BorderSizePixel = 0,
					Parent = slider.sliderbar,
				})

				slider.sliderbox = library:create("Frame", {
					AnchorPoint = Vector2.new(0.5,0.5),
					Position = UDim2.new(slider.value/values[2],0,0.5,0),
					Size = UDim2.new(0,4,0,12),
					BackgroundColor3 = library.theme.main,
					BorderSizePixel = 0,
					Parent = slider.sliderbar,
				})

				self.order = self.order + 1

				local function updateValue()
					slider.value = round(slider.value*values[2], values[4]) -- float)
					if slider.value > values[2] then
						slider.value = values[2]
					end
					if slider.value < values[1] then
						slider.value = values[1]
					end
					if incrementalMode then
						slider.sliderbox.Position = UDim2.new((slider.value-values[1])/(values[2]-values[1]),0,0.5,0)
						slider.sliderfill.Size = UDim2.new((slider.value-values[1])/(values[2]-values[1]),0,1,0)
					else
						slider.sliderbox:TweenPosition(UDim2.new((slider.value-values[1])/(values[2]-values[1]),0,0.5,0), "Out", "Quint", 0.3, true)
						slider.sliderfill:TweenSize(UDim2.new((slider.value-values[1])/(values[2]-values[1]),0,1,0), "Out", "Quint", 0.3, true)
					end
					slider.visualize.Text = slider.value..values[5]
					_function(slider.value, false)
				end

				local function updateSlider(input)
					local relativePos = input.Position.X- slider.sliderbar.AbsolutePosition.X
					if input.Position.X < slider.sliderbar.AbsolutePosition.X then
						relativePos = 0
					end
					if relativePos > slider.sliderbar.AbsoluteSize.X then
						relativePos = slider.sliderbar.AbsoluteSize.X
					end
					slider.value = relativePos/slider.sliderbar.AbsoluteSize.X
					updateValue()
				end

				local sliding
				local modifying

				slider.button.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						sliding = true
						updateSlider(input)
					end
				end)

				slider.visualize.FocusLost:connect(function()
					slider.value = (tonumber(slider.visualize.Text) or 0) / values[2]
					updateValue()
					_function(slider.value, true)
				end)

				slider.button.InputEnded:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						sliding = false
						_function(slider.value, true)
					end
				end)

				UserInputService.InputChanged:connect(function(input)
					if modifying then
						if input == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Space then
							slider.visualize:ReleaseFocus()
						end
					end
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if sliding then
							updateSlider(input)
						end
					end
				end)

				function slider:Set(num)
					slider.value = num/values[2]
					updateValue()
				end

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+18)

				slider:Set(values[3])
				library.pointers[pointername] = slider

				return slider
			end

			function LocalTab:AddKeybind(text, key, pointername, _function)
				_function = _function or function() end
				local bind = {binding = false, holding = false, value = key}
				local bindname = ""

				if key ~= nil then
					bindname = bind.value.Name
				else
					bindname = "None"
					key = nil
				end

				local bounds = game:GetService('TextService'):GetTextSize(bindname, library.settings.textsize, library.settings.font, Vector2.new(math.huge, math.huge))

				checkRow()

				LocalTab.main.Parent = tab.row

				bind.button = library:create("TextButton", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 4),
					BackgroundTransparency = 1,
					Text = tostring(text),
					TextColor3 = library.theme.text,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutoButtonColor = false,
					Parent = self.content,
				})

				bind.label = library:create("TextLabel", {
					Position = UDim2.new(1,0,0,2),
					Size = UDim2.new(0,-bounds.X-8,1,-4),
					BackgroundTransparency = 1,
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.main,
					Text = bindname,
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					Parent = bind.button,
				})

				self.order = self.order + 1

				bind.button.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						bind.label.Text = "..."
						bind.label.Size = UDim2.new(0,-bind.label.TextBounds.X-8,1,-4)
					end
				end)

				bind.button.InputEnded:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if bind.value ~= nil then
							bind:Set(nil)
						else
							bind.binding = true
						end
					end
				end)

				function bind:Set(key)
					if not key then
						bind.value = nil
						bind.label.Text = tostring("[ ".."None".." ]")
						bind.label.Size = UDim2.new(0,-bind.label.TextBounds.X-8,1,-4)
					else
						if key.Name:sub(1,11) == "MouseButton" then
							bind.label.Text = tostring("[ ".."MB"..key.Name:sub(12).." ]")
						else
							bind.label.Text = tostring("[ "..key.Name.." ]")
						end
						bind.value = key
						bind.label.Size = UDim2.new(0,-bind.label.TextBounds.X-8,1,-4)
					end
				end

				local a = tick()

				UserInputService.InputBegan:connect(function(input)
					if bind.binding then
						if table.find({Enum.KeyCode.Backspace, Enum.KeyCode.Escape}, input.KeyCode) then
							bind:Set(nil)
							bind.binding = false
						elseif input.KeyCode and input.KeyCode ~= Enum.KeyCode.Unknown then
							bind:Set(input.KeyCode)
							bind.binding = false
						elseif input.UserInputType and table.find({Enum.UserInputType.MouseButton1,Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3}, input.UserInputType) then
							bind:Set(input.UserInputType)
							bind.binding = false
						end
					elseif input.KeyCode == bind.value or input.UserInputType == bind.value then
						_function(true)
					end
				end)

				UserInputService.InputEnded:connect(function(input)
					if input.KeyCode.Name == bindname then
						bind.holding = false
					end
					if input.UserInputType.Name == bindname then
						bind.holding = false
					end
					if not bind.binding and input.KeyCode == bind.value or input.UserInputType == bind.value then
						_function(false)
					end
				end)

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+16)

				bind:Set(key)
				library.pointers[pointername] = bind

				return bind
			end

			function LocalTab:AddColorPicker(text, color3, pointername, _function)
				_function = _function or function() end

				local color = {value = color3}

				checkRow()

				LocalTab.main.Parent = tab.row

				color.button = library:create("TextButton", {
					LayoutOrder = self.order,
					Size = UDim2.new(1,0,0,library.settings.textsize + 2),
					BackgroundTransparency = 1,
					Text = tostring(text),
					TextColor3 = library.theme.text,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					Parent = self.content,
				})

				color.visualize = library:create("ImageLabel", {
					Position = UDim2.new(1,-3,0,3),
					Size = UDim2.new(0,-22,0,10),
					BorderSizePixel = 2,
					BorderColor3 = library.theme.main,
					ScaleType = Enum.ScaleType.Tile,
					TileSize = UDim2.new(0,8,0,8),
					Name = "ColorVisualize",
					Parent = color.button
				})

				color.colorpicker = library:create("TextButton", {
					ZIndex = 165,
					Position = UDim2.new(0,20,0,20),
					Size = UDim2.new(0,200,0,220),
					BackgroundColor3 = library.theme.tabholder,
					BorderColor3 = library.theme.outline,
					AutoButtonColor = false,
					Visible = false,
					Parent = color.button
				})

				color.hueselector = library:create("ImageLabel", {
					ZIndex = 165,
					Position = UDim2.new(0,5,0,5),
					Size = UDim2.new(0,170,0,170),
					Image = "http://www.roblox.com/asset/?id=4155801252",
					BackgroundColor3 = Color3.new(1,0,0),
					BorderColor3 = library.theme.outline,
					Parent = color.colorpicker
				})

				color.hueselectorpointer = library:create("Frame", {
					ZIndex = 165,
					AnchorPoint = Vector2.new(0.5,0.5),
					Position = UDim2.new(0.5,0,0,0),
					Size = UDim2.new(0,6,0,6),
					Parent = color.rgbselector
				})

				color.colorselector = library:create("TextLabel", {
					ZIndex = 165,
					Position = UDim2.new(0,181,0,5),
					Size = UDim2.new(0,14,0,170),
					BackgroundColor3 = Color3.fromRGB(200,200,200),
					BorderColor3 = library.theme.outline,
					Text = "",
					Parent = color.colorpicker
				})

				color.colorselectorgradient = library:create("UIGradient", {
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0,Color3.new(1,0,0)),
						ColorSequenceKeypoint.new(0.25,Color3.new(1,1,0)),
						ColorSequenceKeypoint.new(0.5,Color3.new(0,1,1)),
						ColorSequenceKeypoint.new(0.75,Color3.new(1,0,1)),
						ColorSequenceKeypoint.new(1,Color3.new(1,0,0))
					}),
					Enabled = true,
					Rotation = 90,
					Parent = color.colorselector
				})

				color.colorselectorpointer = library:create("Frame", {
					ZIndex = 165,
					AnchorPoint = Vector2.new(0.5,0.5),
					Position = UDim2.new(0.5,0,0,0),
					Size = UDim2.new(1,0,0,3),
					Parent = color.colorselector
				})

				color.rgbselector = library:create("TextBox", {
					ZIndex = 165,
					Position = UDim2.new(0,5,0,180),
					Size = UDim2.new(0,170,0,14),
					BackgroundColor3 = library.theme.main,
					BorderColor3 = library.theme.outline,
					Text = "",
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					TextXAlignment = Enum.TextXAlignment.Center,
					Parent = color.colorpicker
				})

				color.hexselector = library:create("TextBox", {
					ZIndex = 165,
					Position = UDim2.new(0,5,0,200),
					Size = UDim2.new(0,170,0,14),
					BackgroundColor3 = library.theme.main,
					BorderColor3 = library.theme.outline,
					Text = "",
					TextColor3 = library.theme.text,
					Font = library.settings.font,
					TextSize = library.settings.textsize,
					TextStrokeTransparency = library.settings.textstroke and 0 or 1,
					TextXAlignment = Enum.TextXAlignment.Center,
					Parent = color.colorpicker
				})

				color.rgbcopy = library:create("ImageLabel", {
					ZIndex = 165,
					Position = UDim2.new(0,181,0,180),
					Size = UDim2.new(0,14,0,14),
					BackgroundColor3 = library.theme.main,
					BorderColor3 = library.theme.outline,
					Image = "http://www.roblox.com/asset/?id=3021120430",
					Parent = color.colorpicker
				})

				color.hexcopy = library:create("ImageLabel", {
					ZIndex = 165,
					Position = UDim2.new(0,181,0,200),
					Size = UDim2.new(0,14,0,14),
					BackgroundColor3 = library.theme.main,
					BorderColor3 = library.theme.outline,
					Image = "http://www.roblox.com/asset/?id=3021120430",
					Parent = color.colorpicker
				})

				color.button.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						function isinregion(point, pos, size)
							if point.X > pos.X and point.X < pos.X  + size.X and point.Y > pos.Y and point.Y < pos.Y + size.Y then
								return true
							end
							return false
						end

						focusOnOption(color.colorpicker)
						closeWindow(color.colorpicker)
						color.colorpicker.Visible = not color.colorpicker.Visible
					end
				end)

				color.colorselector.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						cselheld = true
						listeneer = input.Changed:connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								cselheld = false
								listeneer:Disconnect()
							end
						end)

						repeat 
							wait()

							local mouse = game:GetService("Players").LocalPlayer:GetMouse()
							local obj = color.hueselector
							local pos = (mouse.Y-obj.AbsolutePosition.Y)/obj.AbsoluteSize.Y
							pos = (pos < 0 and 0) or (pos > 1 and 1) or pos
							colorval = pos
							color.colorselectorpointer.Position = UDim2.new(0.5,0,pos,0)
							color.hueselector.BackgroundColor3 = Color3.fromHSV(pos, 1, 1)
						until cselheld == false

						--return _function(color.value)
					end
				end)

				color.hueselector.InputBegan:connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						chueheld = true
						listeneer = input.Changed:connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								chueheld = false
								listeneer:Disconnect()
							end
						end)

						repeat 
							wait()

							local mouse = game:GetService("Players").LocalPlayer:GetMouse()
							local obj = color.hueselector
							local x = (mouse.X-obj.AbsolutePosition.X)/obj.AbsoluteSize.X
							local y = (mouse.Y-obj.AbsolutePosition.Y)/obj.AbsoluteSize.Y

							color.hueselectorpointer.Position = UDim2.new(x,0,y,0)

							new = Color3.fromHSV(colorval, x, 1-y)

							color:Set(new)
						until chueheld == false
					end
				end)

				local function hex2rgb(hex)
					return Color3.fromRGB(tonumber("0x"..hex:sub(2,3)),tonumber("0x"..hex:sub(4,5)),tonumber("0x"..hex:sub(6,7)))
				end

				local function rgb2hex(rgb)
					return string.format("#%02X%02X%02X", rgb.r*255, rgb.g*255, rgb.b*255)
				end

				function color:Set(newColor)
					newColor = Color3.new(math.clamp(newColor.r, 0, 1), math.clamp(newColor.g, 0, 1), math.clamp(newColor.b, 0, 1))

					color.value = newColor
					color.visualize.BackgroundColor3 = newColor
					color.rgbselector.Text = tostring(math.floor(newColor.r*255)..", "..math.floor(newColor.g*255)..", "..math.floor(newColor.b*255))
					color.hexselector.Text = rgb2hex(newColor)
					_function(newColor)
				end

				color.rgbselector.FocusLost:Connect(function()
					new = color.rgbselector.Text:gsub(" ","")
					new = string.split(new, ",")
					table.foreach(new, function(a,b)
						b = tonumber(b)
						if b < 0 then
							new[a] = 0
						elseif b > 255 then
							new[a] = 255
						else
							new[a] = b
						end
					end)
					color:Set(Color3.fromRGB(new[1], new[2], new[3]))
				end)

				color.hexselector.FocusLost:Connect(function()
					new = color.hexselector.Text:gsub(" ","")
					color:Set(hex2rgb(new))
				end)

				LocalTab.main.Size = UDim2.new(1,0,0,self.layout.AbsoluteContentSize.Y+16)

				color:Set(color3)
				library.pointers[pointername] = color

				return color
			end

			return LocalTab
		end

		return tab
	end

	return window
end

local function GetConfigs()
	cfgs = {}
	for i,v in pairs(listdir("hexhub")) do
		if v:sub(-10) == ".hexhubcfg" then
			table.insert(cfgs, string.split(v, ".")[1]:sub(8))
		end
	end
	return cfgs
end

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

local OnTagsRemove

local function RemoveTags(Reset)
	TagsRemover.Value = not TagsRemover.Value
	if Reset then
		OnTagsRemove(Reset)
	end
end

local function wtsp(Vector_3, DoNotCheckVisible)
	local Vector, OnScreen = Camera:WorldToScreenPoint(Vector_3)
	if OnScreen or DoNotCheckVisible then return Vector2.new(Vector.X, Vector.Y) else return false end
end

--local function StabilizePosition(Box, AnchorPoint)

--end

local function v2u2(Vector_2)
	return UDim2.fromOffset(Vector_2.X, Vector_2.Y)
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

--local MiscTabCategoryItemsGiver = MiscTab:AddCategory("Items Giver", 2)

--MiscTabCategoryItemsGiver:AddButton("Сafeteria", function()
--	Teleport(Vector3.new(919, 100, 2290))
--end)

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
					if plr.Character:FindFirstChild("HumanoidRootPart") then
						plr.Character.HumanoidRootPart.Velocity = velocity + Vector3.new(0, 2.7, 0)
						plr.Character.Humanoid.PlatformStand = true
					end
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

VisualsTabCategoryWorld:AddColorPicker("Ambient", Color3.new(0.427451, 0.427451, 0.427451), "VisualsTabCategoryWorldAmbient", function(val)
	game.Lighting.Ambient = val
end)

VisualsTabCategoryWorld:AddColorPicker("Outdoor Ambient", Color3.new(0.470588, 0.45098, 0.380392), "VisualsTabCategoryWorldOutdoorAmbient", function(val)
	game.Lighting.OutdoorAmbient = val
end)

VisualsTabCategoryWorld:AddColorPicker("Color Shift_Top", Color3.new(0, 0, 0), "VisualsTabCategoryWorldColorShift_Top", function(val)
	game.Lighting.ColorShift_Top = val
end)

VisualsTabCategoryWorld:AddColorPicker("Color Shift_Bottom", Color3.new(0, 0, 0), "VisualsTabCategoryWorldColorShift_Bottom", function(val)
	game.Lighting.ColorShift_Bottom = val
end)

VisualsTabCategoryWorld:AddSlider("Environment Diffuse Scale", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryWorldEnvironmentDiffuseScale", function(val)
	game.Lighting.EnvironmentDiffuseScale = val
end)

VisualsTabCategoryWorld:AddSlider("Environment Specular Scale", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryWorldEnvironmentSpecularScale", function(val)
	game.Lighting.EnvironmentSpecularScale = val
end)

VisualsTabCategoryWorld:AddSlider("Brightness", {0, 15, 0, 0.01, ""}, "VisualsTabCategoryWorldLBrightness", function(val)
	game.Lighting.Brightness = val
end)

VisualsTabCategoryWorld:AddSlider("Geographic Latitude", {0, 360, 40, 0.01, ""}, "VisualsTabCategoryWorldGeographicLatitude", function(val)
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

TWallsList = {}

local function ResetTWalls()
	for _, v in ipairs(TWallsList) do
		v.Transparency = 0
	end
	table.clear(TWallsList)
end

local function SetTWalls(TVal)
	local TVal = library.pointers.VisualsTabCategoryWorldAsusWallsS and library.pointers.VisualsTabCategoryWorldAsusWallsS.value or 0
	for _, v in ipairs(workspace.Doors:GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency <= 0 then
			table.insert(TWallsList, v)
			v.Transparency = TVal 
		end
	end
	for _, v in ipairs(workspace.Prison_Fences:GetDescendants()) do
		if v:IsA("BasePart") and v.Transparency <= 0 then
			table.insert(TWallsList, v)
			v.Transparency = TVal
		end
	end
	for _, v in ipairs(workspace:GetChildren()) do
		if not v:FindFirstChild("Humanoid") then
			for _, z in ipairs(v:GetDescendants()) do
				if z:IsA("BasePart") and z.Transparency <= 0 then
					table.insert(TWallsList, z)
					z.Transparency = TVal
				end
			end
		end
	end
end

VisualsTabCategoryWorld:AddToggle("AsusWalls", false, "VisualsTabCategoryWorldAsusWalls", function(val)
	if val then
		ResetTWalls()
		SetTWalls(library.pointers.VisualsTabCategoryWorldAsusWallsS and library.pointers.VisualsTabCategoryWorldAsusWallsS.value or 0)
	else
		ResetTWalls()
	end
end)

VisualsTabCategoryWorld:AddSlider("Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryWorldAsusWallsS", function(val)
	if library.pointers.VisualsTabCategoryWorldAsusWalls.value then
		ResetTWalls()
		SetTWalls(val)
	end
end)

local VisualsTabCategoryCamera = VisualsTab:AddCategory("Camera", 1)

VisualsTabCategoryCamera:AddSlider("Field Of View", {1, 120, 70, 0.01, ""}, "VisualsTabCategoryCameraFOV", function(val)
	Camera.FieldOfView = val
end)

VisualsTabCategoryCamera:AddSlider("Camera Min Zoom Distance", {0.1, 10000, 0.5, 0.01, ""}, "VisualsTabCategoryCameraCameraMaxZoomDistance", function(val)
	plr.CameraMinZoomDistance = val
end)

VisualsTabCategoryCamera:AddSlider("Camera Max Zoom Distance", {0.1, 10000, 40, 0.01, ""}, "VisualsTabCategoryCameraCameraMaxZoomDistance", function(val)
	plr.CameraMaxZoomDistance = val
end)

VisualsTabCategoryCamera:AddToggle("Camera Manipulation", false, "VisualsTabCategoryCameraCamMan", function(val)
	if val then
		CamManConnect = run.RenderStepped:Connect(function()
			Camera.CFrame *= CFrame.new(0, 0, 0, library.pointers.VisualsTabCategoryCameraAspRatX.value, 0, 0, library.pointers.VisualsTabCategoryCameraCurvature.value, library.pointers.VisualsTabCategoryCameraAspRatY.value, 0, 0, 0, 1)
		end)
	else
		if CamManConnect then
			CamManConnect:Disconnect()
			CamManConnect = nil
		end
	end
end)

VisualsTabCategoryCamera:AddSlider("Aspect Ratio X", {-1.2, 1.2, 1, 0.01, ""}, "VisualsTabCategoryCameraAspRatX")

VisualsTabCategoryCamera:AddSlider("Aspect Ratio Y", {-1.2, 1.2, 1, 0.01, ""}, "VisualsTabCategoryCameraAspRatY")

VisualsTabCategoryCamera:AddSlider("Сurvature", {-1.2, 1.2, 0, 0.01, ""}, "VisualsTabCategoryCameraCurvature")

VisualsTabCategoryCamera:AddDropdown("Camera Type", {"Custom", "Fixed", "Follow", "Orbital", "Watch"}, "Custom", "VisualsTabCategoryCameraType", function(val)
	Camera.CameraType = Enum.CameraType[val]
end)

VisualsTabCategoryCamera:AddToggle("Lock First Person", false, "VisualsTabCategoryCameraLockFirstPerson", function(val)
	if val then
		plr.CameraMode = Enum.CameraMode.LockFirstPerson
	else
		plr.CameraMode = Enum.CameraMode.Classic
	end
end)

VisualsTabCategoryCamera:AddToggle("Invisicam", false, "VisualsTabCategoryCameraInvisicam", function(val)
	if val then
		plr.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
	else
		plr.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
	end
end)

VisualsTabCategoryCamera:AddToggle("Freecam", false, "VisualsTabCategoryCameraFreecam", function(val)
	local Control = require(plr.PlayerScripts.PlayerModule):GetControls()
	local z = Instance.new('Part', game.Workspace)
	z.Anchored = true
	z.CanCollide = false
	z.CanTouch = false
	z.CanQuery = false
	z.Transparency = 1
	if val then
		OldCamType = Camera.CameraType
		OldCamMode = plr.CameraMode
		OldCamZoom = (Camera.CFrame.Position - Camera.Focus.Position).Magnitude
		OldCamMinZoom = plr.CameraMinZoomDistance
		OldCamMaxZoom = plr.CameraMaxZoomDistance
		Control:Disable()
		z.CFrame = Camera.CFrame
		Camera.CameraSubject = z
		Camera.CameraType = Enum.CameraType.Custom
		plr.CameraMode = Enum.CameraMode.LockFirstPerson 

		local xd = 0
		local zd = 0

		FCconnect1 = run.RenderStepped:Connect(function()
			z.CFrame = (Camera.CFrame - Camera.CFrame.p + z.CFrame.p)
			xd = 0
			zd = 0
			if uis:IsKeyDown(Enum.KeyCode.A) then
				xd = -library.pointers.VisualsTabCategoryCameraFcSpeed.value
			end
			if uis:IsKeyDown(Enum.KeyCode.D) then
				xd = library.pointers.VisualsTabCategoryCameraFcSpeed.value
			end
			if uis:IsKeyDown(Enum.KeyCode.W) then
				zd = -library.pointers.VisualsTabCategoryCameraFcSpeed.value
			end
			if uis:IsKeyDown(Enum.KeyCode.S) then
				zd = library.pointers.VisualsTabCategoryCameraFcSpeed.value
			end
			z.CFrame = z.CFrame * CFrame.new(xd, 0, zd)
		end)
	else
		if FCconnect1 then
			FCconnect1:Disconnect()
			FCconnect1 = nil
		end
		if OldCamType then
			Camera.CameraType = OldCamType
			plr.CameraMode = OldCamMode 
			Control:Enable()
			Camera.CameraSubject = plr.Character.Humanoid
			plr.CameraMaxZoomDistance = OldCamZoom
			plr.CameraMinZoomDistance = OldCamZoom
			plr.CameraMaxZoomDistance = OldCamMaxZoom
			plr.CameraMinZoomDistance = OldCamMinZoom
		end
		OldCamType = nil
		OldCamMode = nil
		OldCamZoom = nil
		OldCamMaxZoom = nil
		OldCamMinZoom = nil
		z:Destroy()
	end
end)

VisualsTabCategoryCamera:AddSlider("Freecam Speed", {0.1, 15, 1.5, 0.01, ""}, "VisualsTabCategoryCameraFcSpeed")

VisualsTabCategoryCamera:AddKeybind("Freecam Keybind", nil, "VisualsTabCategoryFcKeybind", function(val)
	if val == true and uis:GetFocusedTextBox() == nil then library.pointers.VisualsTabCategoryCameraFreecam:Set(not library.pointers.VisualsTabCategoryCameraFreecam.value) end
end)

local function GetClosest()
	local Character = plr.Character
	local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not (Character or HumanoidRootPart) then return end
	local TargetDistance = math.huge
	local Target
	for _, v in ipairs(plrs:GetPlayers()) do
		if v ~= plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			if v.Character.Humanoid.Health > 0 then
				local vectorOBJ = wtsp(v.Character.HumanoidRootPart.Position)
				if vectorOBJ then
					local vectorC = Vector2.new(Mouse.X, Mouse.Y)
					local mag = (vectorC - vectorOBJ).magnitude
					if mag < TargetDistance then
						TargetDistance = mag
						Target = v
					end
				end
			end
		end
	end
	return Target
end
local il
local CamSubS
local SpecConnect
local OffSpecMode = true
local SpecingNow = false
local SpecPlayer = 0
uis.InputBegan:Connect(function(key)
	if library.pointers.VisualsTabCategorySpecModeKB and library.pointers.VisualsTabCategorySpecModeKB.value and key.KeyCode == library.pointers.VisualsTabCategorySpecModeKB.value then
		OffSpecMode = false
		il = Instance.new("ImageLabel")
		il.Image = "http://www.roblox.com/asset/?id=14470026375"
		il.Size = UDim2.fromOffset(72, 43)
		il.AnchorPoint = Vector2.new(0.5, 0.5)
		il.BackgroundTransparency = 1
		il.ImageColor3 = Color3.fromRGB(68, 68, 68)
		il.Position = UDim2.fromOffset(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y + il.Size.Y.Offset + 10)
		il.Parent = SpecPath
		SpecConnect = run.RenderStepped:Connect(function()
			local cp = GetClosest()
			if cp then
				il.Visible = true
				local vec_2 = wtsp(cp.Character.HumanoidRootPart.Position) or plrs:FindFirstChildOfClass("Player")
				CamSubS = cp.Character.Humanoid or cp.Character.HumanoidRootPart
				local Goal = {}
				Goal.Position = UDim2.fromOffset(vec_2.X, vec_2.Y)
				local Tweeninfo = TweenInfo.new(0.3)
				local Tween = TweenService:Create(il, Tweeninfo, Goal)
				Tween:Play()
			else
				il.Visible = false
			end
		end)
		while wait() do 
			for i = 1, 36 do
				if OffSpecMode then
					break
				else
					if il then
						il.Rotation = i * 10
					else
						break
					end
					wait()
				end
			end
		end
	end
end)

uis.InputEnded:Connect(function(key)
	if library.pointers.VisualsTabCategorySpecModeKB and library.pointers.VisualsTabCategorySpecModeKB.value and key.KeyCode == library.pointers.VisualsTabCategorySpecModeKB.value then
		for i, v in ipairs(plrs:GetPlayers()) do
			if v.Name == CamSubS.Parent.Name then
				SpecPlayer = i
				print(i)
			end
		end
		if il and not SpecMainFrame.Visible then
			SpecMainFrame.Visible = true
			LeftSpecButton.Visible = true
			RightSpecButton.Visible = true
			il:Destroy()
			il = nil
			if SpecConnect then
				SpecConnect:Disconnect()
				SpecConnect = nil
			end
			Camera.CameraSubject = CamSubS
			local connect
			local connect2
			local connect3
			connect2 = LeftSpecButton.MouseButton1Up:Connect(function()
				if (SpecPlayer - 1) >= 1 then
					SpecPlayer -= 1
					for i, v in pairs(plrs:GetPlayers()) do
						if v ~= plr and i == SpecPlayer then
							Camera.CameraSubject = v.Character:FindFirstChild("Humanoid") or v.Character.HumanoidRootPart
							CamSubS = Camera.CameraSubject
						end
					end
				end
				for i = 1, 2 do
					local Goal = {}
					Goal.ImageColor3 = (i == 1) and Color3.fromRGB(79, 78, 79) or Color3.fromRGB(35, 34, 35)
					Goal.Position = UDim2.new(((i == 1) and LeftSpecButton.Position.X.Scale - (LeftSpecButton.Position.X.Scale / 50) or LeftSpecButtonOrigPos.X.Scale), 0, LeftSpecButton.Position.Y.Scale, 0)
					local Tweeninfo = TweenInfo.new((i == 1) and 0.1 or 0.3)
					local Tween = TweenService:Create(LeftSpecButton, Tweeninfo, Goal)
					Tween:Play()
					wait(0.1)
				end
			end)
			connect3 = RightSpecButton.MouseButton1Up:Connect(function()
				if (SpecPlayer + 1) <= #plrs:GetPlayers() then
					SpecPlayer += 1
					for i, v in pairs(plrs:GetPlayers()) do
						if v ~= plr and i == SpecPlayer then
							Camera.CameraSubject = v.Character:FindFirstChild("Humanoid") or v.Character.HumanoidRootPart
							CamSubS = Camera.CameraSubject
						end
					end
				end
				for i = 1, 2 do
					local Goal = {}
					Goal.ImageColor3 = (i == 1) and Color3.fromRGB(79, 78, 79) or Color3.fromRGB(35, 34, 35)
					Goal.Position = UDim2.new(((i == 1) and RightSpecButton.Position.X.Scale + (LeftSpecButton.Position.X.Scale / 50) or RightSpecButtonOrigPos.X.Scale), 0, RightSpecButton.Position.Y.Scale, 0)
					local Tweeninfo = TweenInfo.new((i == 1) and 0.1 or 0.3)
					local Tween = TweenService:Create(RightSpecButton, Tweeninfo, Goal)
					Tween:Play()
					wait(0.1)
				end
			end)
			connect = SpecTextButton.MouseButton1Up:Connect(function()
				SpecMainFrame.Visible = false
				LeftSpecButton.Visible = false
				RightSpecButton.Visible = false
				Camera.CameraSubject = plr.Character:FindFirstChild("Humanoid") or Camera.CameraSubject
				connect:Disconnect()
				connect = nil
				connect2:Disconnect()
				connect2 = nil
				connect3:Disconnect()
				connect3 = nil
			end)
		elseif SpecMainFrame.Visible and il then
			if SpecConnect then
				SpecConnect:Disconnect()
				SpecConnect = nil
			end
			il:Destroy()
			il = nil
			Camera.CameraSubject = CamSubS
		end
	end
end)

VisualsTabCategoryCamera:AddKeybind("Spectator Mode", Enum.KeyCode.B, "VisualsTabCategorySpecModeKB")

local VisualsTabCategorySelf = VisualsTab:AddCategory("Self", 1)

local function SetWeaponChams(Tool)
	if library.pointers.VisualsTabCategorySelfWC and library.pointers.VisualsTabCategorySelfWC.value then
		for _, v in ipairs(Tool:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Color = library.pointers.VisualsTabCategorySelfWCColor.value
			end
		end
	end
	if library.pointers.VisualsTabCategorySelfWM and library.pointers.VisualsTabCategorySelfWM.value then
		for _, v in ipairs(Tool:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Material = Enum.Material[library.pointers.VisualsTabCategorySelfWMM.value]
			end
		end
	end
	if library.pointers.VisualsTabCategorySelfWT and library.pointers.VisualsTabCategorySelfWT.value then
		for _, v in ipairs(Tool:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Transparency = library.pointers.VisualsTabCategorySelfWTT.value
			end
		end
	end
end

local function SetSelfChams(Character)
	if library.pointers.VisualsTabCategorySelfSChams and library.pointers.VisualsTabCategorySelfSChams.value then
		for _, v in ipairs(Character:GetChildren()) do
			if not v:IsA("Tool") then
				if v:IsA("BasePart") and string.sub(v.Name, 1, 3) ~= "CDC" then v.Material = Enum.Material.ForceField end
				if #v:GetDescendants() > 0 then
					for _, z in ipairs(v:GetDescendants()) do
						if z:IsA("BasePart") and string.sub(z.Name, 1, 3) ~= "CDC" then
							z.Material = Enum.Material.ForceField
						end
					end
				end
			end
		end
	end
	if library.pointers.VisualsTabCategorySelfSCCColor and library.pointers.VisualsTabCategorySelfSCCColor.value then
		for _, v in ipairs(Character:GetChildren()) do
			if v:IsA("CharacterMesh") then
				v.OverlayTextureId = nil
			end
		end
		for _, v in ipairs(Character:GetChildren()) do
			if not v:IsA("Tool") then
				if v:IsA("BasePart") and string.sub(v.Name, 1, 3) ~= "CDC" then v.Color = library.pointers.VisualsTabCategorySelfSCColor.value end
				if #v:GetDescendants() > 0 then
					for _, z in ipairs(v:GetDescendants()) do
						if z:IsA("BasePart") and string.sub(z.Name, 1, 3) ~= "CDC" then
							z.Color = library.pointers.VisualsTabCategorySelfSCColor.value
						end
					end
				end
			end
		end
	end
	if library.pointers.VisualsTabCategorySelfSCCTransparency and library.pointers.VisualsTabCategorySelfSCCTransparency.value then
		for _, v in ipairs(Character:GetChildren()) do
			if not v:IsA("Tool") then
				if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and string.sub(v.Name, 1, 3) ~= "CDC" then v.Transparency = library.pointers.VisualsTabCategorySelfSCTransparency.value end
				if #v:GetDescendants() > 0 then
					for _, z in ipairs(v:GetDescendants()) do
						if z:IsA("BasePart") and string.sub(z.Name, 1, 3) ~= "CDC" then
							z.Transparency = library.pointers.VisualsTabCategorySelfSCTransparency.value
						end
					end
				end
			end
		end
	end
end

local function SetHat(Character)
	if library.pointers.VisualsTabCategorySelfChHat.value then
		if Character:FindFirstChild("Head") and not Character:FindFirstChild("Head"):FindFirstChild("CDC_CHat") then
			local head = Character.Head
			local weld = Instance.new("Weld") 
			local conemesh = Instance.new("SpecialMesh")
			if library.pointers.VisualsTabCategorySelfChHatUCM.value then
				conemesh.MeshId = "rbxassetid://" .. library.pointers.VisualsTabCategorySelfChHatMeshId.value
			else
				conemesh.MeshId = "rbxassetid://10625937447"
			end
			if library.pointers.VisualsTabCategorySelfChHatUTI.value then
				conemesh.TextureId = "rbxassetid://" .. library.pointers.VisualsTabCategorySelfChHatTextureId.value
			else
				conemesh.TextureId = 1
			end
			conemesh.Scale = Vector3.new(library.pointers.VisualsTabCategorySelfChHatScaleX.value, library.pointers.VisualsTabCategorySelfChHatScaleY.value, library.pointers.VisualsTabCategorySelfChHatScaleZ.value)
			local conepart = Instance.new("Part")
			conemesh.Parent = conepart
			if library.pointers.VisualsTabCategorySelfChHatFF.value then
				conepart.Material = Enum.Material.ForceField
			end
			conepart.Color = library.pointers.VisualsTabCategorySelfChHatColor.value
			conemesh.VertexColor = Vector3.new(library.pointers.VisualsTabCategorySelfChHatColor.value.R, library.pointers.VisualsTabCategorySelfChHatColor.value.G, library.pointers.VisualsTabCategorySelfChHatColor.value.B)
			conepart.Transparency = library.pointers.VisualsTabCategorySelfChHatTrans.value
			conepart.Anchored = false
			conepart.CanCollide = false
			conepart.CanQuery = false
			conepart.CanTouch = false
			weld.Parent = head
			weld.C1 *= CFrame.new(library.pointers.VisualsTabCategorySelfChHatOffsetX.value, head.Size.Y / 2 + conemesh.Scale.Y + library.pointers.VisualsTabCategorySelfChHatOffsetY.value, library.pointers.VisualsTabCategorySelfChHatOffsetZ.value)
			weld.Part1 = head
			weld.Part0 = conepart
			conemesh.Name = "CDC_CHat"
			conepart.Name = "CDC_CHat"
			conepart.Parent = Character.Head
		end
	end
end

local function DelHat(Character)
	if Character:FindFirstChild("Head") and Character:FindFirstChild("Head"):FindFirstChild("CDC_CHat") then
		for _, v in ipairs(Character.Head:GetChildren()) do
			if v.Name == "CDC_CHat" then
				v:Destroy()
			end
		end
	end
end

local function DelAcc(Character, TypesList)
	if library.pointers.VisualsTabCategorySelfRemAcc.value then
		for _, v in ipairs(Character:GetDescendants()) do
			if v:IsA("Accessory") then
				for _, z in ipairs(TypesList) do
					if v.AccessoryType.Name == z then
						v:Destroy()
					end
				end
			end
		end
	end
end

local function DelPants(Character)
	if library.pointers.VisualsTabCategorySelfRemPan.value then
		for _, v in ipairs(Character:GetDescendants()) do
			if v:IsA("Pants") then
				v:Destroy()
			end
		end
	end
end

local function DelShirt(Character)
	if library.pointers.VisualsTabCategorySelfRemShi.value then
		for _, v in ipairs(Character:GetDescendants()) do
			if v:IsA("Shirt") then
				v:Destroy()
			end
		end
	end
end

local function DelFace(Character)
	if library.pointers.VisualsTabCategorySelfRemFac.value then
		for _, v in ipairs(Character:GetDescendants()) do
			if v:IsA("Decal") and v.Name == "face" then
				v:Destroy()
			end
		end
	end
end

local function SetTrail(Character)
	if library.pointers.VisualsTabCategorySelfTrail.value then
		if Character:FindFirstChild("HumanoidRootPart") then
			local hrp = Character.HumanoidRootPart
			local weld = Instance.new("Weld")
			weld.Part0 = hrp
			local part = Instance.new("Part")
			part.CanCollide = false
			part.CanQuery = false
			part.CanTouch = false
			weld.Part1 = part
			weld.Parent = part
			part.Size = Vector3.new(1, 1, 1)
			part.Shape = Enum.PartType.Ball
			part.Transparency = 1
			part.Name = "CDC_TrailPart"
			local att0 = Instance.new("Attachment")
			local att1 = Instance.new("Attachment")
			att0.Position = Vector3.new(library.pointers.VisualsTabCategorySelfTAtt0OffsetX.value, library.pointers.VisualsTabCategorySelfTAtt0OffsetY.value, library.pointers.VisualsTabCategorySelfTAtt0OffsetZ.value)
			att1.Position = Vector3.new(library.pointers.VisualsTabCategorySelfTAtt1OffsetX.value, library.pointers.VisualsTabCategorySelfTAtt1OffsetY.value, library.pointers.VisualsTabCategorySelfTAtt1OffsetZ.value)
			att0.Parent = part
			att1.Parent = part
			local trail = Instance.new("Trail")
			trail.Name = "CDC_Trail"
			trail.Attachment0 = att0
			trail.Attachment1 = att1
			trail.TextureLength = library.pointers.VisualsTabCategorySelfTrailTextureLength.value
			trail.TextureMode = Enum.TextureMode[library.pointers.VisualsTabCategorySelfTrailTextureMode.value]
			trail.Texture = "rbxassetid://" .. (library.pointers.VisualsTabCategorySelfTrailUTI.value and library.pointers.VisualsTabCategorySelfTrailTextureId.value or "0")
			trail.LightInfluence = library.pointers.VisualsTabCategorySelfTrailLightInfluence.value
			trail.LightEmission = library.pointers.VisualsTabCategorySelfTrailLightEmission.value
			trail.Transparency = NumberSequence.new(library.pointers.VisualsTabCategorySelfTrailTransparency.value)
			trail.Brightness = library.pointers.VisualsTabCategorySelfTrailBrightness.value
			trail.FaceCamera = library.pointers.VisualsTabCategorySelfTrailFaceCam.value
			trail.MinLength = library.pointers.VisualsTabCategorySelfTrailMinLen.value
			trail.MaxLength = library.pointers.VisualsTabCategorySelfTrailMaxLen.value
			trail.Lifetime = library.pointers.VisualsTabCategorySelfTrailLifeTime.value
			trail.Color = ColorSequence.new(library.pointers.VisualsTabCategorySelfTrailSColor.value, library.pointers.VisualsTabCategorySelfTrailEColor.value)
			trail.Parent = part
			part.Parent = hrp
		end
	end
end

local function DelTrail(Character)
	if Character:FindFirstChild("HumanoidRootPart") and Character.HumanoidRootPart:FindFirstChild("CDC_TrailPart") then
		for _, v in ipairs(Character.HumanoidRootPart:GetChildren()) do
			if v.Name == "CDC_TrailPart" then
				v:Destroy()
			end
		end
	end
end

local function SetParticle(Character)
	if library.pointers.VisualsTabCategorySelfParticle.value then
		if Character:FindFirstChild("HumanoidRootPart") and not Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("CDC_Particle") then
			local PE = Instance.new("ParticleEmitter")
			PE.Color = ColorSequence.new(library.pointers.VisualsTabCategorySelfParticleColor.value)
			PE.LightEmission = library.pointers.VisualsTabCategorySelfParticleLightEmission.value
			PE.LightInfluence = library.pointers.VisualsTabCategorySelfParticleLightInfluence.value
			PE.Orientation = Enum.ParticleOrientation[library.pointers.VisualsTabCategorySelfParticleOrientation.value]
			PE.Size = NumberSequence.new(library.pointers.VisualsTabCategorySelfParticleSize.value)
			PE.Squash = NumberSequence.new(library.pointers.VisualsTabCategorySelfParticleSquash1.value, library.pointers.VisualsTabCategorySelfParticleSquash2.value)
			PE.Texture = library.pointers.VisualsTabCategorySelfParticleUCT.value and "rbxassetid://" .. library.pointers.VisualsTabCategorySelfParticleTexture.value or "rbxasset://textures/particles/sparkles_main.dds"
			PE.Transparency = NumberSequence.new(library.pointers.VisualsTabCategorySelfParticleTransparency.value)
			PE.ZOffset = 0
			PE.EmissionDirection = Enum.NormalId[library.pointers.VisualsTabCategorySelfParticleEmissionDirection.value]
			PE.Lifetime = NumberRange.new(library.pointers.VisualsTabCategorySelfParticleLifetimeMin.value, library.pointers.VisualsTabCategorySelfParticleLifetimeMax.value)
			PE.Rate = library.pointers.VisualsTabCategorySelfParticleRate.value
			PE.Rotation = NumberRange.new(library.pointers.VisualsTabCategorySelfParticleRotation.value, library.pointers.VisualsTabCategorySelfParticleRotation.value)
			PE.RotSpeed = NumberRange.new(library.pointers.VisualsTabCategorySelfParticleRotSpeed.value)
			PE.Speed = NumberRange.new(library.pointers.VisualsTabCategorySelfParticleSpeed.value)
			PE.SpreadAngle = Vector2.new(library.pointers.VisualsTabCategorySelfParticleSpreadAngleX.value, library.pointers.VisualsTabCategorySelfParticleSpreadAngleY.value)
			PE.Shape = Enum.ParticleEmitterShape[library.pointers.VisualsTabCategorySelfParticleShape.value]
			PE.ShapeInOut = Enum.ParticleEmitterShapeInOut[library.pointers.VisualsTabCategorySelfParticleShapeInOut.value]
			if Enum.ParticleEmitterShape[library.pointers.VisualsTabCategorySelfParticleShape.value] ~= Enum.ParticleEmitterShape.Box then
				PE.ShapePartial = library.pointers.VisualsTabCategorySelfParticleShapePartial.value
			end
			PE.ShapeStyle = Enum.ParticleEmitterShapeStyle[library.pointers.VisualsTabCategorySelfParticleShapeStyle.value]
			PE.FlipbookLayout = Enum.ParticleFlipbookLayout[library.pointers.VisualsTabCategorySelfParticleFlipbookLayout.value]
			if Enum.ParticleFlipbookLayout[library.pointers.VisualsTabCategorySelfParticleFlipbookLayout.value] ~= Enum.ParticleFlipbookLayout.None then
				PE.FlipbookFramerate = NumberRange.new(library.pointers.VisualsTabCategorySelfParticleFlipbookFramerateMin.value, library.pointers.VisualsTabCategorySelfParticleFlipbookFramerateMax.value)
				PE.FlipbookMode = Enum.ParticleFlipbookMode[library.pointers.VisualsTabCategorySelfParticleFlipbookMode.value]
				PE.FlipbookStartRandom = library.pointers.VisualsTabCategorySelfParticleFlipbookStartRandom.value --true / false
			end
			PE.Acceleration = Vector3.new(library.pointers.VisualsTabCategorySelfParticleAccelerationX.value, library.pointers.VisualsTabCategorySelfParticleAccelerationY.value, library.pointers.VisualsTabCategorySelfParticleAccelerationZ.value)
			PE.Drag = library.pointers.VisualsTabCategorySelfParticleDrag.value
			PE.LockedToPart = library.pointers.VisualsTabCategorySelfParticleLockedToPart.value -- t/f
			PE.TimeScale = library.pointers.VisualsTabCategorySelfParticleTimeScale.value
			PE.VelocityInheritance = library.pointers.VisualsTabCategorySelfParticleVelocityInheritance.value
			PE.WindAffectsDrag = library.pointers.VisualsTabCategorySelfParticleWindAffectsDrag.value --t/f
			PE.Name = "CDC_Particle"
			PE.Parent = Character.HumanoidRootPart
		end
	end
end

local function DelParticle(Character)
	if Character:FindFirstChild("HumanoidRootPart") and Character.HumanoidRootPart:FindFirstChild("CDC_Particle") then
		for _, v in ipairs(Character.HumanoidRootPart:GetChildren()) do
			if v.Name == "CDC_Particle" then
				v:Destroy()
			end
		end
	end
end

VisualsTabCategorySelf:AddMultiDropdown("Accessory Type", AccessoryTypes, {"Hair"}, "VisualsTabCategorySelfATypes", function(val)
	if library.pointers.VisualsTabCategorySelfRemAcc and library.pointers.VisualsTabCategorySelfRemAcc.value then
		DelAcc(plr.Character, val)
	end
end)

VisualsTabCategorySelf:AddToggle("Remove Accessories", false, "VisualsTabCategorySelfRemAcc", function(val)
	if val then
		DelAcc(plr.Character, library.pointers.VisualsTabCategorySelfATypes.value)
	end
end)

VisualsTabCategorySelf:AddToggle("Remove Pants", false, "VisualsTabCategorySelfRemPan", function(val)
	if val then
		DelPants(plr.Character)
	end
end)

VisualsTabCategorySelf:AddToggle("Remove Shirt", false, "VisualsTabCategorySelfRemShi", function(val)
	if val then
		DelShirt(plr.Character)
	end
end)

VisualsTabCategorySelf:AddToggle("Remove Face", false, "VisualsTabCategorySelfRemFac", function(val)
	if val then
		DelFace(plr.Character)
	end
end)

VisualsTabCategorySelf:AddToggle("Self Chams", false, "VisualsTabCategorySelfSChams", function(val)
	if val then
		SetSelfChams(plr.Character)
	else
		for _, v in ipairs(plr.Character:GetDescendants()) do
			if v:IsA("BasePart") and string.sub(v.Name, 1, 3) ~= "CDC" then
				v.Material = Enum.Material.SmoothPlastic
			end
		end
	end
end)

VisualsTabCategorySelf:AddToggle("Custom Color", false, "VisualsTabCategorySelfSCCColor", function(val)
	if val then
		SetSelfChams(plr.Character)
	end
end)

VisualsTabCategorySelf:AddColorPicker("Color", Color3.new(0.886275, 0.0235294, 1), "VisualsTabCategorySelfSCColor", function() SetSelfChams(plr.Character) end)

VisualsTabCategorySelf:AddToggle("Custom Transparency", false, "VisualsTabCategorySelfSCCTransparency", function(val)
	if val then
		SetSelfChams(plr.Character)
	end
end)

VisualsTabCategorySelf:AddSlider("Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfSCTransparency", function() SetSelfChams(plr.Character) end)

local function EzWeaponChams(Character)
	for _, v in ipairs(Character:GetChildren()) do
		if v:IsA("Tool") then
			SetWeaponChams(v)
		end
	end
end

VisualsTabCategorySelf:AddToggle("Weapon Color", false, "VisualsTabCategorySelfWC", function(val)
	if val then
		EzWeaponChams(plr.Character)
	end
end)

VisualsTabCategorySelf:AddColorPicker("Color", Color3.new(0.886275, 0.0235294, 1), "VisualsTabCategorySelfWCColor", function()
	EzWeaponChams(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Weapon Material", false, "VisualsTabCategorySelfWM", function(val)
	if val then
		EzWeaponChams(plr.Character)
	end
end)

VisualsTabCategorySelf:AddDropdown("Material", Materials, "Glass", "VisualsTabCategorySelfWMM", function()
	EzWeaponChams(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Weapon Transparency", false, "VisualsTabCategorySelfWT", function(val)
	if val then
		EzWeaponChams(plr.Character)
	end
end)

VisualsTabCategorySelf:AddSlider("Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfWTT", function()
	EzWeaponChams(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Weapon Transparency", false, "VisualsTabCategorySelfWT", function(val)
	if val then
		EzWeaponChams(plr.Character)
	end
end)

VisualsTabCategorySelf:AddToggle("Chinese Hat", false, "VisualsTabCategorySelfChHat", function(val)
	if val then
		DelHat(plr.Character)
		SetHat(plr.Character)
	else
		DelHat(plr.Character)
	end
end)

VisualsTabCategorySelf:AddToggle("Force Field", false, "VisualsTabCategorySelfChHatFF", function(val)
	if val then
		DelHat(plr.Character)
		SetHat(plr.Character)
	else
		DelHat(plr.Character)
		SetHat(plr.Character)
	end
end)

VisualsTabCategorySelf:AddColorPicker("Color", Color3.new(1, 0.490196, 0.14902), "VisualsTabCategorySelfChHatColor", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfChHatTrans", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Scale X", {0.01, 35, 1.75, 0.01, ""}, "VisualsTabCategorySelfChHatScaleX", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Scale Y", {0.01, 35, 0.7, 0.01, ""}, "VisualsTabCategorySelfChHatScaleY", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Scale Z", {0.01, 35, 1.75, 0.01, ""}, "VisualsTabCategorySelfChHatScaleZ", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Offset X", {-70, 70, 0, 0.01, ""}, "VisualsTabCategorySelfChHatOffsetX", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Offset Y", {-70, 70, -0.1, 0.01, ""}, "VisualsTabCategorySelfChHatOffsetY", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Offset Z", {-70, 70, 0, 0.01, ""}, "VisualsTabCategorySelfChHatOffsetZ", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Use Custom Mesh", false, "VisualsTabCategorySelfChHatUCM", function(val)
	if val then
		DelHat(plr.Character)
		SetHat(plr.Character)
	else
		DelHat(plr.Character)
		SetHat(plr.Character)
	end
end)

VisualsTabCategorySelf:AddTextBox("Mesh Id", "MeshId", "VisualsTabCategorySelfChHatMeshId", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Use Custom Texture", false, "VisualsTabCategorySelfChHatUTI", function(val)
	if val then
		DelHat(plr.Character)
		SetHat(plr.Character)
	else
		DelHat(plr.Character)
		SetHat(plr.Character)
	end
end)

VisualsTabCategorySelf:AddTextBox("Texture Id", "TextureId", "VisualsTabCategorySelfChHatTextureId", function()
	DelHat(plr.Character)
	SetHat(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Trail", false, "VisualsTabCategorySelfTrail", function(val)
	if val then
		DelTrail(plr.Character)
		SetTrail(plr.Character)
	else
		DelTrail(plr.Character)
	end
end)

VisualsTabCategorySelf:AddColorPicker("Start Color", Color3.new(0, 0.101961, 1), "VisualsTabCategorySelfTrailSColor", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddColorPicker("End Color", Color3.new(0.701961, 0, 1), "VisualsTabCategorySelfTrailEColor", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Attachment0 Offset X", {-70, 70, 0, 0.01, ""}, "VisualsTabCategorySelfTAtt0OffsetX", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Attachment0 Offset Y", {-70, 70, 1, 0.01, ""}, "VisualsTabCategorySelfTAtt0OffsetY", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Attachment0 Offset Z", {-70, 70, 0, 0.01, ""}, "VisualsTabCategorySelfTAtt0OffsetZ", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Attachment1 Offset X", {-70, 70, 0, 0.01, ""}, "VisualsTabCategorySelfTAtt1OffsetX", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Attachment1 Offset Y", {-70, 70, -1, 0.01, ""}, "VisualsTabCategorySelfTAtt1OffsetY", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Attachment1 Offset Z", {-70, 70, 0, 0.01, ""}, "VisualsTabCategorySelfTAtt1OffsetZ", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Min Length", {0, 500, 0, 0.01, ""}, "VisualsTabCategorySelfTrailMinLen", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Max Length", {0, 500, 0, 0.01, ""}, "VisualsTabCategorySelfTrailMaxLen", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Width Scale", {0, 500, 0, 0.01, ""}, "VisualsTabCategorySelfTrailWidthScale", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Life Time", {0, 20, 5, 0.01, ""}, "VisualsTabCategorySelfTrailLifeTime", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Brightness", {0, 10, 1, 0.01, ""}, "VisualsTabCategorySelfTrailBrightness", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfTrailTransparency", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Light Emission", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfTrailLightEmission", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Light Influence", {0, 1, 0.5, 0.01, ""}, "VisualsTabCategorySelfTrailLightInfluence", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Face Camera", false, "VisualsTabCategorySelfTrailFaceCam", function(val)
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Use Custom Texture", false, "VisualsTabCategorySelfTrailUTI", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddTextBox("Texture Id", "Texture Id", "VisualsTabCategorySelfTrailTextureId", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddDropdown("Texture Mode", {"Wrap", "Static", "Stretch"}, "Wrap", "VisualsTabCategorySelfTrailTextureMode", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Texture Length", {0, 100, 1, 0.01, ""}, "VisualsTabCategorySelfTrailTextureLength", function()
	DelTrail(plr.Character)
	SetTrail(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Particle", false, "VisualsTabCategorySelfParticle", function(val)
	if val then
		DelParticle(plr.Character)
		SetParticle(plr.Character)
	else
		DelParticle(plr.Character)
	end
end)

VisualsTabCategorySelf:AddColorPicker("Color", Color3.new(1, 0, 0.0156863), "VisualsTabCategorySelfParticleColor", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Light Emission", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfParticleLightEmission", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Light Influence", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfParticleLightInfluence", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddDropdown("Orientation", {"FacingCamera", "VelocityParallel", "FacingCameraWorldUp", "VelocityPerpendicular"}, "FacingCamera", "VisualsTabCategorySelfParticleOrientation", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Size", {0, 50, 1, 0.01, ""}, "VisualsTabCategorySelfParticleSize", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Squash1", {0, 10, 0, 0.01, ""}, "VisualsTabCategorySelfParticleSquash1", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Squash2", {0, 10, 0, 0.01, ""}, "VisualsTabCategorySelfParticleSquash2", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Use Custom Texture", false, "VisualsTabCategorySelfParticleUCT", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddTextBox("Texture Id", "Texture Id", "VisualsTabCategorySelfParticleTexture", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfParticleTransparency", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddDropdown("Emission Direction", {"Left", "Right", "Top", "Back", "Front", "Bottom"}, "Top", "VisualsTabCategorySelfParticleEmissionDirection", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Life Time Min", {0, 100, 5, 0.01, ""}, "VisualsTabCategorySelfParticleLifetimeMin", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Life Time Max", {0, 100, 10, 0.01, ""}, "VisualsTabCategorySelfParticleLifetimeMax", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Rate", {0, 500, 10, 0.01, ""}, "VisualsTabCategorySelfParticleRate", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Rotation", {-180, 180, 0, 0.01, ""}, "VisualsTabCategorySelfParticleRotation", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Rot Speed", {-360, 360, 0, 0.01, ""}, "VisualsTabCategorySelfParticleRotSpeed", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Speed", {0, 350, 20, 0.01, ""}, "VisualsTabCategorySelfParticleSpeed", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Spread Angle X", {0, 90, 0, 0.01, ""}, "VisualsTabCategorySelfParticleSpreadAngleX", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Spread Angle Y", {0, 90, 0, 0.01, ""}, "VisualsTabCategorySelfParticleSpreadAngleY", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddDropdown("Shape", {"Box", "Disc", "Sphere", "Cylinder"}, "Box", "VisualsTabCategorySelfParticleShape", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddDropdown("Shape In Out", {"Outward", "Inward", "InAndOut"}, "Outward", "VisualsTabCategorySelfParticleShapeInOut", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Shape Partial", {0, 1, 1, 0.01, ""}, "VisualsTabCategorySelfParticleShapePartial", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddDropdown("Shape Style", {"Volume", "Surface"}, "Volume", "VisualsTabCategorySelfParticleShapeStyle", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddDropdown("Flipbook Layout", {"None", "Grid2x2", "Grid4x4", "Grid8x8"}, "None", "VisualsTabCategorySelfParticleFlipbookLayout", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Flipbook Framerate Min", {0, 30, 30, 0.01, ""}, "VisualsTabCategorySelfParticleFlipbookFramerateMin", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Flipbook Framerate Max", {0, 30, 30, 0.01, ""}, "VisualsTabCategorySelfParticleFlipbookFramerateMax", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddDropdown("Flipbook Mode", {"Random", "Loop", "PingPong", "OneShot"}, "OneShot", "VisualsTabCategorySelfParticleFlipbookMode", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Flipbook Start Random", false, "VisualsTabCategorySelfParticleFlipbookStartRandom", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Acceleration X", {0, 500, 0, 0.01, ""}, "VisualsTabCategorySelfParticleAccelerationX", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Acceleration Y", {0, 500, 0, 0.01, ""}, "VisualsTabCategorySelfParticleAccelerationY", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Acceleration Z", {0, 500, 0, 0.01, ""}, "VisualsTabCategorySelfParticleAccelerationZ", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Drag", {0, 10, 0, 0.01, ""}, "VisualsTabCategorySelfParticleDrag", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Locked To Part", false, "VisualsTabCategorySelfParticleLockedToPart", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Time Scale", {0, 1, 1, 0.01, ""}, "VisualsTabCategorySelfParticleTimeScale", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddSlider("Velocity Inheritance", {0, 1, 0, 0.01, ""}, "VisualsTabCategorySelfParticleVelocityInheritance", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

VisualsTabCategorySelf:AddToggle("Wind Affects Drag", false, "VisualsTabCategorySelfParticleWindAffectsDrag", function()
	DelParticle(plr.Character)
	SetParticle(plr.Character)
end)

local function CABody(ch)
	local connect
	local connect2
	local connect3
	connect = plr.CharacterAppearanceLoaded:Connect(function()
		SetParticle(ch)
		SetTrail(ch)
		DelFace(ch)
		DelPants(ch)
		DelShirt(ch)
		DelAcc(ch, library.pointers.VisualsTabCategorySelfATypes.value)
		SetHat(ch)
		SetSelfChams(ch)
		connect:Disconnect()
	end)
	connect2 = ch.ChildAdded:Connect(function(Inst)
		EzWeaponChams(ch)
	end)
	connect3 = ch:GetPropertyChangedSignal("Parent"):Connect(function()
		if connect2 then
			connect2:Disconnect()
			connect2 = nil
		end
		if connect3 then
			connect3:Disconnect()
			connect3 = nil
		end
	end)
end

if plr.Character then
	CABody(plr.Character)
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(ch)
	CABody(ch)
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

local OnBoxAdd

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
	OnBoxAdd(Box)
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
	AddBox(Character, true, library.pointers.VisualsTabCategoryEspBThickness.value, library.pointers.VisualsTabCategoryEspBOC.value, library.pointers.VisualsTabCategoryEspBLJM.value, library.pointers.VisualsTabCategoryEspBTransparency.value, library.pointers.VisualsTabCategoryEspBFC.value, library.pointers.VisualsTabCategoryEspBFillTransparency.value)
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

VisualsTabCategoryEsp:AddDropdown("Line Join Mode", {"Miter", "Round", "Bevel"}, "Miter", "VisualsTabCategoryEspBLJM", function(val)
	if BoxesStoragePath:FindFirstChildOfClass("Frame") then
		for _, v in ipairs(BoxesStoragePath:GetChildren()) do
			v:FindFirstChildOfClass("UIStroke").LineJoinMode = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Outline Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspBOC", function(val)
	if BoxesStoragePath:FindFirstChildOfClass("Frame") then
		for _, v in ipairs(BoxesStoragePath:GetChildren()) do
			v:FindFirstChildOfClass("UIStroke").Color = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Fill Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspBFC", function(val)
	if BoxesStoragePath:FindFirstChildOfClass("Frame") then
		for _, v in ipairs(BoxesStoragePath:GetChildren()) do
			v.BackgroundColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Thickness", {0.45, 12, 2, 0.01, ""}, "VisualsTabCategoryEspBThickness", function(val)
	if BoxesStoragePath:FindFirstChildOfClass("Frame") then
		for _, v in ipairs(BoxesStoragePath:GetChildren()) do
			v:FindFirstChildOfClass("UIStroke").Thickness = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Outline Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspBTransparency", function(val)
	if BoxesStoragePath:FindFirstChildOfClass("Frame") then
		for _, v in ipairs(BoxesStoragePath:GetChildren()) do
			v:FindFirstChildOfClass("UIStroke").Transparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Fill Transparency", {0, 1, 0.9, 0.01, ""}, "VisualsTabCategoryEspBFillTransparency", function(val)
	if BoxesStoragePath:FindFirstChildOfClass("Frame") then
		for _, v in ipairs(BoxesStoragePath:GetChildren()) do
			v.Transparency = val
		end
	end
end)

local Offsetter = 0
local TagsLeftGlobalOffset = 0
local TagsRightGlobalOffset = 0
local TagsUpGlobalOffset = 0
local TagsDownGlobalOffset = 0

local BarsGlobalOffset = 1

local function AddBarToBox(Box, Place, Color, BgColor, Size)
	local Bg = Instance.new("Frame")
	local Bar = Instance.new("Frame")
	Bg.ZIndex = 1
	Bar.ZIndex = 0
	Bar.BorderSizePixel = 0
	Bg.BorderSizePixel = 0
	Bar.BackgroundColor3 = Color3.fromRGB(13, 255, 0)
	Bar.Parent = Bg
	local OL = nil
	if Box:FindFirstChildOfClass("UIStroke") then
		OL = Box:FindFirstChildOfClass("UIStroke")
	end
	local GetOffset
	if string.lower(Place) == "up" then
		Bar.AnchorPoint = Vector2.new(0, 0.5)
		Bg.Size = UDim2.fromOffset(Box.Size.X.Offset + ((OL and OL.Thickness or 0) * 2), Size or 2)
		Bg.AnchorPoint = Vector2.new(0.5, 1)
		Bar.Position = UDim2.fromOffset(0, Bg.Size.Y.Offset / 2)
		GetOffset = function()
			return UDim2.fromOffset(Box.Size.X.Offset / 2 - (Box.Size.X.Offset * Box.AnchorPoint.X), -(Box.Size.Y.Offset / 2 + (OL and OL.Thickness or 0) + Offsetter + BarsGlobalOffset - (Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset * Box.AnchorPoint.Y))))
		end
		TagsUpGlobalOffset += Bg.Size.Y.Offset
	elseif string.lower(Place) == "down" then
		Bar.AnchorPoint = Vector2.new(0, 0.5)
		Bg.Size = UDim2.fromOffset(Box.Size.X.Offset + ((OL and OL.Thickness or 0) * 2), Size or 2)
		Bg.AnchorPoint = Vector2.new(0.5, 0)
		Bar.Position = UDim2.fromOffset(0, Bg.Size.Y.Offset / 2)
		GetOffset = function()
			return UDim2.fromOffset(Box.Size.X.Offset / 2 - (Box.Size.X.Offset * Box.AnchorPoint.X), Box.Size.Y.Offset / 2 + (OL and OL.Thickness or 0) + Offsetter + BarsGlobalOffset + (Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset * Box.AnchorPoint.Y)))
		end
		TagsDownGlobalOffset += Bg.Size.Y.Offset
	elseif string.lower(Place) == "right" then
		Bar.AnchorPoint = Vector2.new(0.5, 1)
		Bg.Size = UDim2.fromOffset(Size or 2, Box.Size.Y.Offset + ((OL and OL.Thickness or 0) * 2))
		Bg.AnchorPoint = Vector2.new(0, 0.5)
		Bar.Position = UDim2.fromOffset(Bg.Size.X.Offset / 2, Bg.Size.Y.Offset)
		GetOffset = function()
			return UDim2.fromOffset(Box.Size.X.Offset / 2 + (OL and OL.Thickness or 0) + Offsetter + BarsGlobalOffset + (Box.Size.X.Offset / 2 - (Box.Size.X.Offset * Box.AnchorPoint.X)), Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset * Box.AnchorPoint.Y))
		end
		TagsRightGlobalOffset += Bg.Size.X.Offset
	else
		Bar.AnchorPoint = Vector2.new(0.5, 1)
		Bg.Size = UDim2.fromOffset(Size or 2, Box.Size.Y.Offset + ((OL and OL.Thickness or 0) * 2))
		Bg.AnchorPoint = Vector2.new(1, 0.5)
		Bar.Position = UDim2.fromOffset(Bg.Size.X.Offset / 2, Bg.Size.Y.Offset)
		GetOffset = function()
			return UDim2.fromOffset(-(Box.Size.X.Offset / 2 + (OL and OL.Thickness or 0) + Offsetter + BarsGlobalOffset - (Box.Size.X.Offset / 2 - (Box.Size.X.Offset * Box.AnchorPoint.X))), Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset * Box.AnchorPoint.Y))
		end
		TagsLeftGlobalOffset += Bg.Size.X.Offset
	end
	Bar.Size = Bg.Size
	run.RenderStepped:Connect(function()
		Bg.Position = Box.Position + GetOffset()
	end)
	Bg.Parent = BarsPath
	return Bar
end

local TagsClusters = {}

local function AddTagToBox(Box, Place, Text, Color, font, Size, TextTransparency, TextStrokeTransparency, TextStrokeColor) -- Place: Up, Down, Left, Right
	local Tag = Instance.new("TextLabel")
	Tag.Visible = Box.Visible
	Tag.AutoLocalize = false
	Tag.BackgroundTransparency = 1
	Tag.TextStrokeTransparency = TextStrokeTransparency or 1
	Tag.TextTransparency = TextTransparency or 0
	Tag.Font = font or Enum.Font.SourceSans
	Tag.TextSize = Size or 15
	Tag.Text = Text or "NIL"
	Tag.Name = Box.Name
	Tag.TextColor3 = Color or Color3.fromRGB(255, 255, 255)
	Tag.TextStrokeColor3 = TextStrokeColor or Color3.fromRGB(255, 255, 255)
	Tag.Size = v2u2(TxtService:GetTextSize(Text, Tag.TextSize, Tag.Font, Vector2.new(math.huge, math.huge)))
	local OL = nil
	if Box:FindFirstChildOfClass("UIStroke") then
		OL = Box:FindFirstChildOfClass("UIStroke")
	end
	if not TagsClusters[Box] then
		TagsClusters[Box] = {}
	end
	local TBP_L = 0
	if not TagsClusters[Box][Place] then
		TagsClusters[Box][Place] = Tag.Size.Y.Offset
	else
		TBP_L = TagsClusters[Box][Place]
		TagsClusters[Box][Place] += Tag.Size.Y.Offset
	end
	local GetOffset
	if string.lower(Place) == "up" then
		Tag.AnchorPoint = Vector2.new(0.5, 1)
		GetOffset = function()
			return UDim2.fromOffset(Box.Size.X.Offset / 2 - (Box.Size.X.Offset * Box.AnchorPoint.X),  -(Box.Size.Y.Offset / 2 + (OL and OL.Thickness or 0) + Offsetter + TagsUpGlobalOffset - (Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset * Box.AnchorPoint.Y))) - TBP_L)
		end
	elseif string.lower(Place) == "down" then
		Tag.AnchorPoint = Vector2.new(0.5, 0)
		GetOffset = function()
			return UDim2.fromOffset(Box.Size.X.Offset / 2 - (Box.Size.X.Offset * Box.AnchorPoint.X), Box.Size.Y.Offset / 2 + (OL and OL.Thickness or 0) + Offsetter + TagsDownGlobalOffset + (Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset * Box.AnchorPoint.Y)) + TBP_L)
		end
	elseif string.lower(Place) == "right" then
		Tag.TextXAlignment = Enum.TextXAlignment.Left
		Tag.AnchorPoint = Vector2.new(0, 0.5)
		GetOffset = function()
			return UDim2.fromOffset(Box.Size.X.Offset / 2 + (OL and OL.Thickness or 0) + Offsetter + TagsRightGlobalOffset + (Box.Size.X.Offset / 2 - (Box.Size.X.Offset * Box.AnchorPoint.X)), -(Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset * Box.AnchorPoint.Y))) + TBP_L)
		end
	else
		Tag.TextXAlignment = Enum.TextXAlignment.Right
		Tag.AnchorPoint = Vector2.new(1, 0.5)
		GetOffset = function()
			return UDim2.fromOffset(-(Box.Size.X.Offset / 2 + (OL and OL.Thickness or 0) + Offsetter + TagsLeftGlobalOffset - (Box.Size.X.Offset / 2 - (Box.Size.X.Offset * Box.AnchorPoint.X))), -(Box.Size.Y.Offset / 2 - Tag.Size.Y.Offset / 2 - (Box.Size.Y.Offset / 2 - (Box.Size.Y.Offset * Box.AnchorPoint.Y))) + TBP_L)
		end
	end
	local connect1
	local connect2
	local connect3
	local connect4
	local connect5
	local connect6
	local function ld()
		if connect4 then
			connect4:Disconnect()
			connect4 = nil
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
		if connect5 then	
			connect5:Disconnect()
			connect5 = nil
		end
		if connect6 then
			connect6:Disconnect()
			connect6 = nil
		end
		Tag:Destroy()
		return
	end
	connect1 = run.RenderStepped:Connect(function()
		Tag.Position = Box.Position + GetOffset()
	end)
	Tag.Parent = TagsPath
	connect2 = Tag:GetPropertyChangedSignal("Parent"):Connect(function()
		ld()
	end)
	connect3 = Box:GetPropertyChangedSignal("Parent"):Connect(function()
		if TagsClusters[Box] then
			table.clear(TagsClusters[Box])
			TagsClusters[Box] = nil
		end
		ld()
	end)
	connect4 = Tag:GetPropertyChangedSignal("Text"):Connect(function()
		Tag.Size = v2u2(TxtService:GetTextSize(Text, Tag.TextSize, Tag.Font, Vector2.new(math.huge, math.huge)))
	end)
	connect5 = Box:GetPropertyChangedSignal("Visible"):Connect(function()
		Tag.Visible = Box.Visible
	end)
	connect6 = TagsRemover:GetPropertyChangedSignal("Value"):Connect(function()
		ld()
	end)
	return Tag
end

local function GetFrineds(UserId)
	local Friends = {}
	local FriendsCount = 0
	local FriendsOnlineCount = 0
	local Page = plrs:GetFriendsAsync(UserId)
	repeat
		local Info  = Page:GetCurrentPage()
		for _, v in pairs(Info) do
			table.insert(Friends, v)
			FriendsCount += 1
			if v["IsOnline"] then
				FriendsOnlineCount += 1
			end
		end
		if not Page.IsFinished then
			Page:AdvanceToNextPageAsync()
		end
	until Page.IsFinished
	return FriendsCount, FriendsOnlineCount
end

local TNames = {}
local TDNames = {}
local AAge = {}
local UserId = {}
local Dis = {}
local TArmor = {}
local THealth = {}

local AAgePfx = ""
local DisPfx = ""

local MHealth = 50

OnBoxAdd = function(Box)
	if library.pointers.VisualsTabCategoryEspNames.value then
		table.insert(TNames, AddTagToBox(Box, "up", Box.Name, library.pointers.VisualsTabCategoryEspNamesC.value, Enum.Font[library.pointers.VisualsTabCategoryEspNamesFont.value], library.pointers.VisualsTabCategoryEspNamesS.value, library.pointers.VisualsTabCategoryEspNamesTT.value, library.pointers.VisualsTabCategoryEspNamesTST.value, library.pointers.VisualsTabCategoryEspNamesSC.value))
	end
	if library.pointers.VisualsTabCategoryEspDNames and library.pointers.VisualsTabCategoryEspDNames.value then
		if not library.pointers.VisualsTabCategoryEspDNDNDIM.value or Box.Name ~= plrs[Box.Name].DisplayName then 
			table.insert(TDNames, AddTagToBox(Box, "up", plrs[Box.Name].DisplayName, library.pointers.VisualsTabCategoryEspDNamesC.value, Enum.Font[library.pointers.VisualsTabCategoryEspDNamesFont.value], library.pointers.VisualsTabCategoryEspDNamesS.value, library.pointers.VisualsTabCategoryEspDNamesTT.value, library.pointers.VisualsTabCategoryEspDNamesTST.value, library.pointers.VisualsTabCategoryEspDNamesSC.value))
		end
	end
	if library.pointers.VisualsTabCategoryEspAAge and library.pointers.VisualsTabCategoryEspAAge.value then
		table.insert(AAge, AddTagToBox(Box, "up", plrs[Box.Name].AccountAge .. AAgePfx, library.pointers.VisualsTabCategoryEspAAgeC.value, Enum.Font[library.pointers.VisualsTabCategoryEspAAgeFont.value], library.pointers.VisualsTabCategoryEspAAgeS.value, library.pointers.VisualsTabCategoryEspAAgeTT.value, library.pointers.VisualsTabCategoryEspAAgeTST.value, library.pointers.VisualsTabCategoryEspAAgeSC.value))
	end
	if library.pointers.VisualsTabCategoryEspUserId and library.pointers.VisualsTabCategoryEspUserId.value then
		table.insert(UserId, AddTagToBox(Box, "up", plrs[Box.Name].UserId, library.pointers.VisualsTabCategoryEspUserIdC.value, Enum.Font[library.pointers.VisualsTabCategoryEspUserIdFont.value], library.pointers.VisualsTabCategoryEspUserIdS.value, library.pointers.VisualsTabCategoryEspUserIdTT.value, library.pointers.VisualsTabCategoryEspUserIdTST.value, library.pointers.VisualsTabCategoryEspUserIdSC.value))
	end
	if library.pointers.VisualsTabCategoryEspDis and library.pointers.VisualsTabCategoryEspDis.value then
		local Character = plrs[Box.Name].Character
		if Character:WaitForChild("HumanoidRootPart") then
			local HRP = Character.HumanoidRootPart
			local CHRP = plr.Character.HumanoidRootPart
			local Tag = AddTagToBox(Box, "up", math.floor((HRP.Position - CHRP.Position).magnitude) .. DisPfx, library.pointers.VisualsTabCategoryEspDisC.value, Enum.Font[library.pointers.VisualsTabCategoryEspDisFont.value], library.pointers.VisualsTabCategoryEspDisS.value, library.pointers.VisualsTabCategoryEspDisTT.value, library.pointers.VisualsTabCategoryEspDisTST.value, library.pointers.VisualsTabCategoryEspDisSC.value)
			table.insert(Dis, Tag)
			local connect1
			local connect2
			connect1 = run.Heartbeat:Connect(function()
				local n, r = pcall(function() return math.floor((HRP.Position - CHRP.Position).magnitude) .. DisPfx end)
				Tag.Text = n and r or "???"
			end)
			connect2 = Tag:GetPropertyChangedSignal("Parent"):Connect(function()
				connect1:Disconnect()
				connect2:Disconnect()
				return
			end)
		end
	end
	if library.pointers.VisualsTabCategoryEspHealth and library.pointers.VisualsTabCategoryEspHealth.value then
		if plrs[Box.Name] then
			local Hum = plrs[Box.Name].Character:WaitForChild("Humanoid")
			local Tag = AddTagToBox(Box, "right", math.ceil(Hum.Health) .. (library.pointers.VisualsTabCategoryEspHealthMinify.value and "" or "/" .. Hum.MaxHealth), library.pointers.VisualsTabCategoryEspArmorC.value, Enum.Font[library.pointers.VisualsTabCategoryEspHealthFont.value], library.pointers.VisualsTabCategoryEspHealthS.value, library.pointers.VisualsTabCategoryEspHealthTT.value, library.pointers.VisualsTabCategoryEspHealthTST.value, library.pointers.VisualsTabCategoryEspHealthSC.value)
			table.insert(THealth, Tag)
			local connect1
			local connect3
			connect1 = Hum:GetPropertyChangedSignal("Health"):Connect(function()
				Tag.Text = math.ceil(Hum.Health) .. (library.pointers.VisualsTabCategoryEspHealthMinify.value and "" or "/" .. Hum.MaxHealth)
			end)
			connect3 = Tag:GetPropertyChangedSignal("Parent"):Connect(function()
				connect1:Disconnect()
				connect3:Disconnect()
				return
			end)
		end
	end
	if library.pointers.VisualsTabCategoryEspArmor and library.pointers.VisualsTabCategoryEspArmor.value then
		if plrs[Box.Name] then
			local Hum = plrs[Box.Name].Character:WaitForChild("Humanoid")
			local function ShowTag()
				local Tag = AddTagToBox(Box, "right", "HK", library.pointers.VisualsTabCategoryEspArmorC.value, Enum.Font[library.pointers.VisualsTabCategoryEspArmorFont.value], library.pointers.VisualsTabCategoryEspArmorS.value, library.pointers.VisualsTabCategoryEspArmorTT.value, library.pointers.VisualsTabCategoryEspArmorTST.value, library.pointers.VisualsTabCategoryEspArmorSC.value)
				table.insert(TArmor, Tag)
				if library.pointers.VisualsTabCategoryEspArmorCCWAIB.value then
					local function ChengeColor()
						if Hum.Health <= MHealth then
							Tag.TextColor3 = library.pointers.VisualsTabCategoryEspACCWAIBColor.value
							Tag.TextStrokeColor3 =  library.pointers.VisualsTabCategoryEspACCWAIBSColor.value
						else
							Tag.TextColor3 = library.pointers.VisualsTabCategoryEspArmorC.value
							Tag.TextStrokeColor3 =  library.pointers.VisualsTabCategoryEspArmorSC.value
						end
					end
					ChengeColor()
					local connect1
					local connect2
					local connect3
					local connect4
					connect1 = Hum:GetPropertyChangedSignal("Health"):Connect(function()
						ChengeColor()
					end)
					connect4 = Tag:GetPropertyChangedSignal("TextColor3"):Connect(function()
						ChengeColor()
					end)
					connect2 = Tag:GetPropertyChangedSignal("TextStrokeColor3"):Connect(function()
						ChengeColor()
					end)
					connect3 = Tag:GetPropertyChangedSignal("Parent"):Connect(function()
						connect1:Disconnect()
						connect2:Disconnect()
						connect4:Disconnect()
						connect3:Disconnect()
						return
					end)
				end
			end
			if Hum.MaxHealth > MHealth then
				ShowTag()
			else
				local connect1
				local connect2
				local connect3
				connect1 = Hum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
					if Hum.MaxHealth > MHealth then
						if connect2 then
							connect2:Disconnect()
						end
						ShowTag()
						connect1:Disconnect()
						return
					end
				end)
				connect3 = ArmorTagsRemover:GetPropertyChangedSignal("Value"):Connect(function()
					connect1:Disconnect()
					connect2:Disconnect()
					connect3:Disconnect()
					return
				end)
				connect2 = Hum.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
					connect1:Disconnect()
					connect3:Disconnect()
					connect2:Disconnect()
					return
				end)
			end
		end
	end
end

OnTagsRemove = function(Reset)
	table.clear(TagsClusters)
	table.clear(TNames)
	table.clear(TDNames)
	table.clear(AAge)
	table.clear(UserId)
	table.clear(Dis)
	table.clear(TArmor)
	table.clear(THealth)
	ArmorTagsRemover.Value = not ArmorTagsRemover.Value
	if Reset then
		if library.pointers.VisualsTabCategoryEspNames and library.pointers.VisualsTabCategoryEspNames.value then
			for _, v in ipairs(BoxesStoragePath:GetChildren()) do
				table.insert(TNames, AddTagToBox(v, "up", v.Name, library.pointers.VisualsTabCategoryEspNamesC.value, Enum.Font[library.pointers.VisualsTabCategoryEspNamesFont.value], library.pointers.VisualsTabCategoryEspNamesS.value, library.pointers.VisualsTabCategoryEspNamesTT.value, library.pointers.VisualsTabCategoryEspNamesTST.value, library.pointers.VisualsTabCategoryEspNamesSC.value))
			end
		end
		if library.pointers.VisualsTabCategoryEspDNames and library.pointers.VisualsTabCategoryEspDNames.value then
			for _, v in ipairs(BoxesStoragePath:GetChildren()) do
				if not library.pointers.VisualsTabCategoryEspDNDNDIM.value or v.Name ~= plrs[v.Name].DisplayName then 
					table.insert(TDNames, AddTagToBox(v, "up", plrs[v.Name].DisplayName, library.pointers.VisualsTabCategoryEspDNamesC.value, Enum.Font[library.pointers.VisualsTabCategoryEspDNamesFont.value], library.pointers.VisualsTabCategoryEspDNamesS.value, library.pointers.VisualsTabCategoryEspDNamesTT.value, library.pointers.VisualsTabCategoryEspDNamesTST.value, library.pointers.VisualsTabCategoryEspDNamesSC.value))
				end
			end
		end
		if library.pointers.VisualsTabCategoryEspUserId and library.pointers.VisualsTabCategoryEspUserId.value then
			for _, v in ipairs(BoxesStoragePath:GetChildren()) do
				table.insert(UserId, AddTagToBox(v, "up", plrs[v.Name].UserId, library.pointers.VisualsTabCategoryEspUserIdC.value, Enum.Font[library.pointers.VisualsTabCategoryEspUserIdFont.value], library.pointers.VisualsTabCategoryEspUserIdS.value, library.pointers.VisualsTabCategoryEspUserIdTT.value, library.pointers.VisualsTabCategoryEspUserIdTST.value, library.pointers.VisualsTabCategoryEspUserIdSC.value))
			end
		end
		if library.pointers.VisualsTabCategoryEspAAge and library.pointers.VisualsTabCategoryEspAAge.value then
			for _, v in ipairs(BoxesStoragePath:GetChildren()) do
				table.insert(AAge, AddTagToBox(v, "up", plrs[v.Name].AccountAge .. AAgePfx, library.pointers.VisualsTabCategoryEspAAgeC.value, Enum.Font[library.pointers.VisualsTabCategoryEspAAgeFont.value], library.pointers.VisualsTabCategoryEspAAgeS.value, library.pointers.VisualsTabCategoryEspAAgeTT.value, library.pointers.VisualsTabCategoryEspAAgeTST.value, library.pointers.VisualsTabCategoryEspAAgeSC.value))
			end
		end
		if library.pointers.VisualsTabCategoryEspDis and library.pointers.VisualsTabCategoryEspDis.value then
			for _, v in ipairs(BoxesStoragePath:GetChildren()) do
				if plrs[v.Name] then
					local Character = plrs[v.Name].Character
					if Character:WaitForChild("HumanoidRootPart") then
						local HRP = Character.HumanoidRootPart
						local CHRP = plr.Character.HumanoidRootPart
						local Tag = AddTagToBox(v, "up", math.floor((HRP.Position - CHRP.Position).magnitude) .. DisPfx, library.pointers.VisualsTabCategoryEspDisC.value, Enum.Font[library.pointers.VisualsTabCategoryEspDisFont.value], library.pointers.VisualsTabCategoryEspDisS.value, library.pointers.VisualsTabCategoryEspDisTT.value, library.pointers.VisualsTabCategoryEspDisTST.value, library.pointers.VisualsTabCategoryEspDisSC.value)
						table.insert(Dis, Tag)
						local connect1
						local connect2
						connect1 = run.Heartbeat:Connect(function()
							local n, r = pcall(function() return math.floor((HRP.Position - CHRP.Position).magnitude) .. DisPfx end)
							Tag.Text = n and r or "???"
						end)
						connect2 = Tag:GetPropertyChangedSignal("Parent"):Connect(function()
							connect1:Disconnect()
							connect2:Disconnect()
							return
						end)
					end
				end
			end
		end
		if library.pointers.VisualsTabCategoryEspHealth and library.pointers.VisualsTabCategoryEspHealth.value then
			for _, v in ipairs(BoxesStoragePath:GetChildren()) do
				if plrs[v.Name] then
					local Hum = plrs[v.Name].Character:WaitForChild("Humanoid")
					local Tag = AddTagToBox(v, "right", math.ceil(Hum.Health) .. (library.pointers.VisualsTabCategoryEspHealthMinify.value and "" or "/" .. Hum.MaxHealth), library.pointers.VisualsTabCategoryEspArmorC.value, Enum.Font[library.pointers.VisualsTabCategoryEspHealthFont.value], library.pointers.VisualsTabCategoryEspHealthS.value, library.pointers.VisualsTabCategoryEspHealthTT.value, library.pointers.VisualsTabCategoryEspHealthTST.value, library.pointers.VisualsTabCategoryEspHealthSC.value)
					table.insert(THealth, Tag)
					local connect1
					local connect3
					connect1 = Hum:GetPropertyChangedSignal("Health"):Connect(function()
						Tag.Text = math.ceil(Hum.Health) .. (library.pointers.VisualsTabCategoryEspHealthMinify.value and "" or "/" .. Hum.MaxHealth)
					end)
					connect3 = Tag:GetPropertyChangedSignal("Parent"):Connect(function()
						connect1:Disconnect()
						connect3:Disconnect()
						return
					end)
				end
			end
		end
		if library.pointers.VisualsTabCategoryEspArmor and library.pointers.VisualsTabCategoryEspArmor.value then
			for _, v in ipairs(BoxesStoragePath:GetChildren()) do
				if plrs[v.Name] then
					local Hum = plrs[v.Name].Character:WaitForChild("Humanoid")
					local function ShowTag()
						local Tag = AddTagToBox(v, "right", "HK", library.pointers.VisualsTabCategoryEspArmorC.value, Enum.Font[library.pointers.VisualsTabCategoryEspArmorFont.value], library.pointers.VisualsTabCategoryEspArmorS.value, library.pointers.VisualsTabCategoryEspArmorTT.value, library.pointers.VisualsTabCategoryEspArmorTST.value, library.pointers.VisualsTabCategoryEspArmorSC.value)
						table.insert(TArmor, Tag)
						if library.pointers.VisualsTabCategoryEspArmorCCWAIB.value then
							local function ChengeColor()
								if Hum.Health <= MHealth then
									Tag.TextColor3 = library.pointers.VisualsTabCategoryEspACCWAIBColor.value
									Tag.TextStrokeColor3 =  library.pointers.VisualsTabCategoryEspACCWAIBSColor.value
								else
									Tag.TextColor3 = library.pointers.VisualsTabCategoryEspArmorC.value
									Tag.TextStrokeColor3 =  library.pointers.VisualsTabCategoryEspArmorSC.value
								end
							end
							ChengeColor()
							local connect1
							local connect2
							local connect3
							local connect4
							connect1 = Hum:GetPropertyChangedSignal("Health"):Connect(function()
								ChengeColor()
							end)
							connect4 = Tag:GetPropertyChangedSignal("TextColor3"):Connect(function()
								ChengeColor()
							end)
							connect2 = Tag:GetPropertyChangedSignal("TextStrokeColor3"):Connect(function()
								ChengeColor()
							end)
							connect3 = Tag:GetPropertyChangedSignal("Parent"):Connect(function()
								connect1:Disconnect()
								connect2:Disconnect()
								connect4:Disconnect()
								connect3:Disconnect()
								return
							end)
						end
					end
					if Hum.MaxHealth > MHealth then
						ShowTag()
					else
						local connect1
						local connect2
						local connect3
						connect1 = Hum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
							if Hum.MaxHealth > MHealth then
								if connect2 then
									connect2:Disconnect()
								end
								ShowTag()
								connect1:Disconnect()
								return
							end
						end)
						connect3 = ArmorTagsRemover:GetPropertyChangedSignal("Value"):Connect(function()
							connect1:Disconnect()
							connect2:Disconnect()
							connect3:Disconnect()
							return
						end)
						connect2 = Hum.Parent:GetPropertyChangedSignal("Parent"):Connect(function()
							connect1:Disconnect()
							connect3:Disconnect()
							connect2:Disconnect()
							return
						end)
					end
				end
			end
		end
	end
end

VisualsTabCategoryEsp:AddToggle("Names", false, "VisualsTabCategoryEspNames", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddToggle("Display Names", false, "VisualsTabCategoryEspDNames", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddToggle("Do Not Display If Matched", false, "VisualsTabCategoryEspDNDNDIM", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddToggle("Account Age", false, "VisualsTabCategoryEspAAge", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddDropdown("Postfix Type", {"Without Postfix", "Simple Postfix", "Full Postfix"}, "Full Postfix", "VisualsTabCategoryEspAAgePfx", function(val)
	if val == "Without Postfix" then
		AAgePfx = ""
	elseif val == "Simple Postfix" then
		AAgePfx = "d"
	else
		AAgePfx = "days"
	end
	RemoveTags(true)
end)


VisualsTabCategoryEsp:AddToggle("User Id", false, "VisualsTabCategoryEspUserId", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddToggle("Distance", false, "VisualsTabCategoryEspDis", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddDropdown("Postfix Type", {"Without Postfix", "Simple Postfix", "Full Postfix"}, "Full Postfix", "VisualsTabCategoryEspDisPfx", function(val)
	if val == "Without Postfix" then
		DisPfx = ""
	elseif val == "Simple Postfix" then
		DisPfx = "s"
	else
		DisPfx = "studs"
	end
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddToggle("Armor", false, "VisualsTabCategoryEspArmor", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddToggle("Change Color When Armor Is Broken", false, "VisualsTabCategoryEspArmorCCWAIB", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddColorPicker("CCWAIB Text Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspACCWAIBColor")

VisualsTabCategoryEsp:AddColorPicker("CCWAIB Text Stroke Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspACCWAIBSColor")

VisualsTabCategoryEsp:AddToggle("Health", false, "VisualsTabCategoryEspHealth", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddToggle("Minify", false, "VisualsTabCategoryEspHealthMinify", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddColorPicker("Names Text Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspNamesC", function(val)
	if #TNames > 0 then
		for _, v in ipairs(TNames) do
			v.TextColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Display Names Text Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspDNamesC", function(val)
	if #TDNames > 0 then
		for _, v in ipairs(TDNames) do
			v.TextColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Account Age Text Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspAAgeC", function(val)
	if #AAge > 0 then
		for _, v in ipairs(AAge) do
			v.TextColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("User Id Text Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspUserIdC", function(val)
	if #UserId > 0 then
		for _, v in ipairs(UserId) do
			v.TextColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Distance Text Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspDisC", function(val)
	if #Dis > 0 then
		for _, v in ipairs(Dis) do
			v.TextColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Armor Text Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspArmorC", function(val)
	if #TArmor > 0 then
		for _, v in ipairs(TArmor) do
			v.TextColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Health Text Color", Color3.new(1, 1, 1), "VisualsTabCategoryEspHealthC", function(val)
	if #THealth > 0 then
		for _, v in ipairs(THealth) do
			v.TextColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddDropdown("Names Font", Fonts, "Code", "VisualsTabCategoryEspNamesFont", function(val)
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddDropdown("Display Names Font", Fonts, "Code", "VisualsTabCategoryEspDNamesFont", function(val)
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddDropdown("Account Age Font", Fonts, "Code", "VisualsTabCategoryEspAAgeFont", function(val)
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddDropdown("User Id Font", Fonts, "Code", "VisualsTabCategoryEspUserIdFont", function(val)
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddDropdown("Distance Font", Fonts, "Code", "VisualsTabCategoryEspDisFont", function(val)
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddDropdown("Armor Font", Fonts, "Code", "VisualsTabCategoryEspArmorFont", function(val)
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddDropdown("Health Font", Fonts, "Code", "VisualsTabCategoryEspHealthFont", function(val)
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddColorPicker("Names Text Stroke Color", Color3.new(0, 0, 0), "VisualsTabCategoryEspNamesSC", function(val)
	if #TNames > 0 then
		for _, v in ipairs(TNames) do
			v.TextStrokeColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Display Names Text Stroke Color", Color3.new(0, 0, 0), "VisualsTabCategoryEspDNamesSC", function(val)
	if #TDNames > 0 then
		for _, v in ipairs(TDNames) do
			v.TextStrokeColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Account Age Text Stroke Color", Color3.new(0, 0, 0), "VisualsTabCategoryEspAAgeSC", function(val)
	if #AAge > 0 then
		for _, v in ipairs(AAge) do
			v.TextStrokeColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("User Id Text Stroke Color", Color3.new(0, 0, 0), "VisualsTabCategoryEspUserIdSC", function(val)
	if #UserId > 0 then
		for _, v in ipairs(UserId) do
			v.TextStrokeColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Distance Text Stroke Color", Color3.new(0, 0, 0), "VisualsTabCategoryEspDisSC", function(val)
	if #Dis > 0 then
		for _, v in ipairs(Dis) do
			v.TextStrokeColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Armor Text Stroke Color", Color3.new(0, 0, 0), "VisualsTabCategoryEspArmorSC", function(val)
	if #TArmor > 0 then
		for _, v in ipairs(TArmor) do
			v.TextStrokeColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddColorPicker("Health Text Stroke Color", Color3.new(0, 0, 0), "VisualsTabCategoryEspHealthSC", function(val)
	if #THealth > 0 then
		for _, v in ipairs(THealth) do
			v.TextStrokeColor3 = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Names Text Size", {0, 50, 15, 0.01, ""}, "VisualsTabCategoryEspNamesS", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddSlider("Display Names Text Size", {0, 50, 15, 0.01, ""}, "VisualsTabCategoryEspDNamesS", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddSlider("Account Age Text Size", {0, 50, 15, 0.01, ""}, "VisualsTabCategoryEspAAgeS", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddSlider("User Id Text Size", {0, 50, 15, 0.01, ""}, "VisualsTabCategoryEspUserIdS", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddSlider("Distance Text Size", {0, 50, 15, 0.01, ""}, "VisualsTabCategoryEspDisS", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddSlider("Armor Text Size", {0, 50, 15, 0.01, ""}, "VisualsTabCategoryEspArmorS", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddSlider("Health Text Size", {0, 50, 15, 0.01, ""}, "VisualsTabCategoryEspHealthS", function()
	RemoveTags(true)
end)

VisualsTabCategoryEsp:AddSlider("Names Text Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspNamesTT", function(val)
	if #TNames > 0 then
		for _, v in ipairs(TNames) do
			v.TextTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Display Names Text Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspDNamesTT", function(val)
	if #TDNames > 0 then
		for _, v in ipairs(TDNames) do
			v.TextTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Account Age Text Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspAAgeTT", function(val)
	if #AAge > 0 then
		for _, v in ipairs(AAge) do
			v.TextTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("User Id Text Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspUserIdTT", function(val)
	if #UserId > 0 then
		for _, v in ipairs(UserId) do
			v.TextTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Distance Text Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspDisTT", function(val)
	if #Dis > 0 then
		for _, v in ipairs(Dis) do
			v.TextTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Armor Text Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspArmorTT", function(val)
	if #TArmor > 0 then
		for _, v in ipairs(TArmor) do
			v.TextTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Health Text Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspHealthTT", function(val)
	if #THealth > 0 then
		for _, v in ipairs(THealth) do
			v.TextTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Names Text Stroke Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspNamesTST", function(val)
	if #TNames > 0 then
		for _, v in ipairs(TNames) do
			v.TextStrokeTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Display Names Text Stroke Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspDNamesTST", function(val)
	if #TDNames > 0 then
		for _, v in ipairs(TDNames) do
			v.TextStrokeTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Account Age Text Stroke Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspAAgeTST", function(val)
	if #AAge > 0 then
		for _, v in ipairs(AAge) do
			v.TextStrokeTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("User Id Text Stroke Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspUserIdTST", function(val)
	if #UserId > 0 then
		for _, v in ipairs(UserId) do
			v.TextStrokeTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Distance Text Stroke Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspDisTST", function(val)
	if #Dis > 0 then
		for _, v in ipairs(Dis) do
			v.TextStrokeTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Armor Text Stroke Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspArmorTST", function(val)
	if #TArmor > 0 then
		for _, v in ipairs(TArmor) do
			v.TextStrokeTransparency = val
		end
	end
end)

VisualsTabCategoryEsp:AddSlider("Health Text Stroke Transparency", {0, 1, 0, 0.01, ""}, "VisualsTabCategoryEspHealthTST", function(val)
	if #THealth > 0 then
		for _, v in ipairs(THealth) do
			v.TextStrokeTransparency = val
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
