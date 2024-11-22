--- @class Vector
--- @field x number
--- @field y number

local vector = {
	--- A standard vector representing a single unit.
	--- @type Vector
	ONE = { x = 1, y = 1 },

	--- A standard vector representing zero units.
	--- @type Vector
	ZERO = { x = 0, y = 0 }
}

--- Returns whether two vectors are equal, component wise.
--- @param a Vector The first operand.
--- @param b Vector The second operand.
--- @return boolean equal Whether the vectors are equal, component wise.
function vector.veceq(a, b)
	return a.x == b.x and a.y == b.y
end

--- Sums two vectors, component wise.
--- @param a Vector The first operand.
--- @param b Vector The second operand.
--- @return Vector added The sum of the two vectors, component wise.
function vector.vecadd(a, b)
	return { x = a.x + b.x, y = a.y + b.y }
end

--- Subtracts two vectors, component wise.
--- @param a Vector The first operand.
--- @param b Vector The second operand.
--- @return Vector subbed The difference of the two vectors, component wise.
function vector.vecsub(a, b)
	return { x = b.x - a.x, y = b.y - a.y }
end

--- Rotates a vector by ninety degrees.
--- @param vec Vector The vector to rotate.
--- @return Vector rotated The rotated vector.
function vector.rotate(vec)
	return { x = -vec.y, y = vec.x }
end

return vector