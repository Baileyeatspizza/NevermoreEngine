--- Lags the camera smoothly behind the position maintaining other components
-- @classmod SmoothPositionCamera

local require = require(game:GetService("ReplicatedStorage"):WaitForChild("Nevermore"))

local CameraState = require("CameraState")
local SummedCamera = require("SummedCamera")
local Spring = require("Spring")

local SmoothPositionCamera = {}
SmoothPositionCamera.ClassName = "SmoothPositionCamera"
SmoothPositionCamera._FocusCamera = nil
SmoothPositionCamera._OriginCamera = nil

function SmoothPositionCamera.new(baseCamera)
	local self = setmetatable({}, SmoothPositionCamera)

	self.Spring = Spring.new(Vector3.new())
	self.BaseCamera = baseCamera or error("Must have BaseCamera")
	self.Speed = 10

	return self
end

function SmoothPositionCamera:__add(other)
	return SummedCamera.new(self, other)
end

function SmoothPositionCamera:__newindex(Index, Value)
	if Index == "BaseCamera" then
		rawset(self, "_" .. Index, Value)
		self.Spring.Target = self.BaseCamera.CameraState.Position
		self.Spring.Position = self.Spring.Target
		self.Spring.Velocity = Vector3.new(0, 0, 0)
	elseif Index == "LastUpdateTime" or Index == "Spring" then
		rawset(self, Index, Value)
	elseif Index == "Speed" or Index == "Damper" or Index == "Velocity" or Index == "Position" then
		self:InternalUpdate()
		self.Spring[Index] = Value
	else
		error(Index .. " is not a valid member of SmoothPositionCamera")
	end
end

function SmoothPositionCamera:InternalUpdate()
	local Delta
	if self.LastUpdateTime then
		Delta = tick() - self.LastUpdateTime
	end

	self.LastUpdateTime = tick()
	self.Spring.Target = self.BaseCameraState.Position

	if Delta then
		self.Spring:TimeSkip(Delta)
	end
end

function SmoothPositionCamera:__index(Index)
	if Index == "State" or Index == "CameraState" or Index == "Camera" then
		local baseCameraState = self.BaseCameraState

		local state = CameraState.new()
		state.FieldOfView = baseCameraState.FieldOfView
		state.CoordinateFrame = baseCameraState.CoordinateFrame
		state.Position = self.Position

		return state
	elseif Index == "Position" then
		self:InternalUpdate()
		return self.Spring.Position
	elseif Index == "Speed" or Index == "Damper" or Index == "Velocity" then
		return self.Spring[Index]
	elseif Index == "Target" then
		return self.BaseCameraState.Position
	elseif Index == "BaseCameraState" then
		return self.BaseCamera.CameraState or self.BaseCamera
	elseif Index == "BaseCamera" then
		return rawget(self, "_" .. Index) or error("Internal error: Index does not exist")
	else
		return SmoothPositionCamera[Index]
	end
end

return SmoothPositionCamera