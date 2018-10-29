--- Holds utilty math functions not yet available on Roblox's math library.
-- @module qMath

local lib = {}

--- Maps a number from one range to another
-- @see http://stackoverflow.com/questions/929103/convert-a-number-range-to-another-range-maintaining-ratio
-- Make sure old range is not 0
function lib.MapNumber(value, min, max, newMin, newMax)
	return (((value - min) * (newMax - newMin)) / (max - min)) + newMin
end

--- Interpolates betweeen two numbers, given an percent
-- @tparam number low A number, the first one, should be less than high
-- @tparam number high A number, the second one, should be greater than high
-- @tparam number percent The percent, a number in the range [0, 1], that will be used to define
--              how interpolated it is between ValueOne And high
-- @treturn number The lerped number.
function lib.LerpNumber(low, high, percent)
	return low + ((high - low) * percent)
end

--- Solving for angle across from C
function lib.LawOfCosines(A, B, C)
	local l = (A*A + B*B - C*C) / (2 * A * B)
	local a = math.acos(l)
	if a ~= a then
		return nil
	end
	return a
end

--- Round the given number to given precision
function lib.Round(number, precision)
	precision = precision or 1
	return (math.floor((number/precision)+0.5)*precision)
end

function lib.RoundUp(number, precision)
	return math.ceil(number/precision) * precision
end

function lib.RoundDown(number, precision)
	return math.floor(number/precision) * precision
end

return lib