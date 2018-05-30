--- Warps the WaitForChild API with a promise
-- @module WaitForChildPromise

local require = require(game:GetService("ReplicatedStorage"):WaitForChild("Nevermore"))

local Promise = require("Promise")

local WaitForChildPromise = {}

--- Wraps the :WaitForChild API with a promise
function WaitForChildPromise.new(parent, childName, timeOut)
	timeOut = timeOut or 5

	return Promise.new(function(resolve, reject)
		local result = parent:WaitForChild(childName, timeOut)
		if result then
			resolve(result)
		else
			reject("Timed out")
		end
	end)
end

return WaitForChildPromise