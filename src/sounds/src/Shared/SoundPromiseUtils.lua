--- Utility functions involving sounds and their state
-- @module SoundPromiseUtils
-- @author Quenty

local require = require(script.Parent.loader).load(script)

local Promise = require("Promise")
local PromiseUtils = require("PromiseUtils")

local SoundPromiseUtils = {}

function SoundPromiseUtils.promiseLoaded(sound)
	if sound.IsLoaded then
		return Promise.resolved()
	end

	local promise = Promise.new()

	local conn

	conn = sound.Loaded:Connect(function()
		if sound.IsLoaded then
			promise:Resolve()
		end
	end)

	promise:Finally(function()
		conn:Disconnect()
	end)

	return promise
end

function SoundPromiseUtils.promiseAllSoundsLoaded(sounds)
	local promises = {}
	for _, sound in pairs(sounds) do
		table.insert(promises, SoundPromiseUtils.promiseLoaded(sound))
	end
	return PromiseUtils.all(promises)
end

return SoundPromiseUtils