--- Holds binders
-- @classmod GameBindersServer
-- @author Quenty

local require = require(script.Parent.loader).load(script)

local Binder = require("Binder")
local BinderProvider = require("BinderProvider")
local PlayerHumanoidBinder = require("PlayerHumanoidBinder")

return BinderProvider.new(function(self, serviceBag)
	self:Add(Binder.new("PhysicalButton", require("PhysicalButton"), serviceBag))
	self:Add(PlayerHumanoidBinder.new("LookAtButtons", require("LookAtButtons"), serviceBag))
end)