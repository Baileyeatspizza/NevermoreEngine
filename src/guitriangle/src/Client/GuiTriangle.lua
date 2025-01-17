--- 2D Gui triangle rendering class
-- @classmod GuiTriangle
-- http://wiki.roblox.com/index.php?title=2D_triangles

local GuiTriangle = {}
GuiTriangle.__index = GuiTriangle
GuiTriangle.ClassName = "GuiTriangle"
GuiTriangle.ExtraPixels = 2

function GuiTriangle.new(parent)
	local self = setmetatable({}, GuiTriangle)

	self._ta = Instance.new("ImageLabel")
	self._ta.BackgroundTransparency = 1
	self._ta.BorderSizePixel = 0

	self._tb = self._ta:Clone()

	self:SetParent(parent)
	self._a = UDim2.new()
	self._b = UDim2.new()
	self._c = UDim2.new()

	return self
end

function GuiTriangle:SetParent(parent)
	self._ta.Parent = parent
	self._tb.Parent = parent
end

function GuiTriangle:Show()
	self._ta.Visible = true
	self._tb.Visible = true
end

function GuiTriangle:Set(a, b, c)
	return self:SetA(a)
		:SetB(b)
		:SetC(c)
end

function GuiTriangle:Hide()
	self._ta.Visible = false
	self._tb.Visible = false
end

local function dotv2(a, b)
	return a.x * b.x + a.y * b.y
end

local function rotateV2(vec, angle)
	local x = vec.x * math.cos(angle) + vec.y * math.sin(angle)
	local y = -vec.x * math.sin(angle) + vec.y * math.cos(angle)
	return Vector2.new(x, y)
end

function GuiTriangle:SetA(a)
	self._a = a or error("Expected Vector2")
	return self
end

function GuiTriangle:SetB(b)
	self._b = b or error("Expected Vector2")
	return self
end

function GuiTriangle:SetC(c)
	self._c = c or error("Expected Vector2")
	return self
end

function GuiTriangle:UpdateRender()
	local a, b, c = self._a, self._b, self._c

	local extra = self.ExtraPixels

	local edges = {
		{longest = (c - b), other = (a - b), position = b};
		{longest = (a - c), other = (b - c), position = c};
		{longest = (b - a), other = (c - a), position = a};
	}

	table.sort(edges, function(edge0, edge1)
		return edge0.longest.Magnitude > edge1.longest.Magnitude
	end)

	local edge = edges[1]
	edge.angle = math.acos(dotv2(edge.longest.unit, edge.other.unit))
	edge.x = edge.other.Magnitude * math.cos(edge.angle)
	edge.y = edge.other.Magnitude * math.sin(edge.angle)

	local r = edge.longest.unit * edge.x - edge.other
	local rotation = math.atan2(r.y, r.x) - math.pi/2

	local tp = -edge.other
	local tx = (edge.longest.unit * edge.x) - edge.other
	local nz = tp.x * tx.y - tp.y * tx.x

	local tlc1 = edge.position + edge.other
	local tlc2 = nz > 0 and edge.position + edge.longest - tx or edge.position - tx

	local tasize = Vector2.new((tlc1 - tlc2).Magnitude, edge.y)
	local tbsize = Vector2.new(edge.longest.Magnitude - tasize.x, edge.y)

	local center1 = nz <= 0 and edge.position + ((edge.longest + edge.other)/2) or (edge.position + edge.other/2)
	local center2 = nz > 0 and edge.position + ((edge.longest + edge.other)/2) or (edge.position + edge.other/2)

	tlc1 = center1 + rotateV2(tlc1 - center1, rotation)
	tlc2 = center2 + rotateV2(tlc2 - center2, rotation)

	local ta, tb = self._ta, self._tb
	ta.Image = "rbxassetid://319692171"
	tb.Image = "rbxassetid://319692151"
	ta.Position = UDim2.new(0, tlc1.x, 0, tlc1.y)
	tb.Position = UDim2.new(0, tlc2.x, 0, tlc2.y)
	ta.Size = UDim2.new(0, tbsize.x + extra, 0, tbsize.y + extra)
	tb.Size = UDim2.new(0, tasize.x + extra, 0, tasize.y + extra)
	ta.Rotation = math.deg(rotation)
	tb.Rotation = ta.Rotation
end

function GuiTriangle:Destroy()
	setmetatable(self, nil)

	self._ta:Destroy()
	self._ta = nil

	self._tb:Destroy()
	self._tb = nil
end

return GuiTriangle