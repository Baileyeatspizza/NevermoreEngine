--- Provides a basis for binderGroups that can be retrieved anywhere
-- @classmod BinderGroupProvider

local require = require(script.Parent.loader).load(script)

local Promise = require("Promise")

local BinderGroupProvider = {}
BinderGroupProvider.ClassName = "BinderGroupProvider"
BinderGroupProvider.__index = BinderGroupProvider

function BinderGroupProvider.new(initMethod)
	local self = setmetatable({}, BinderGroupProvider)

	self._initMethod = initMethod or error("No initMethod")
	self._groupsAddedPromise = Promise.new()

	self._init = false
	self._binderGroups = {}

	return self
end

function BinderGroupProvider:PromiseGroupsAdded()
	return self._groupsAddedPromise
end

function BinderGroupProvider:Init(...)
	assert(not self._init, "Already initialized")

	self._initMethod(self, ...)
	self._init = true

	self._groupsAddedPromise:Resolve()
end

function BinderGroupProvider:Start()
	-- Do nothing
end

function BinderGroupProvider:__index(index)
	if BinderGroupProvider[index] then
		return BinderGroupProvider[index]
	end

	error(("%q Not a valid index"):format(tostring(index)))
end

function BinderGroupProvider:Get(tagName)
	assert(type(tagName) == "string", "tagName must be a string")
	return rawget(self, tagName)
end

function BinderGroupProvider:Add(groupName, binderGroup)
	assert(type(groupName) == "string", "Bad groupName")
	assert(type(binderGroup) == "table", "Bad binderGroup")
	assert(not self._init, "Already initialized")
	assert(not self:Get(groupName), "Duplicate groupName")

	table.insert(self._binderGroups, binderGroup)
	self[groupName] = binderGroup
end

return BinderGroupProvider