local collections = {}

--- Returns the number of items that match a given predicate.
--- @param tbl table The table to search.
--- @param predicate fun (val: any): boolean The predicate for items to match against.
--- @return number count The number of items that match the given predicate.
function collections.count(tbl, predicate)
	local instances = 0
	for _,v in pairs(tbl) do
		if predicate(v) then
			instances = instances + 1
		end
	end
	return instances
end

--- Returns whether a table contains a specific value.
--- @param tbl table The table to search.
--- @param val any The value to search for.
--- @return boolean contained Whether the table contains the value.
function collections.contains(tbl, val)
	for _,v in pairs(tbl) do
		if v == val then return true end
	end
	return false
end

--- Returns whether a table has a specific key.
--- @param tbl table The table to search.
--- @param key any The key to search for.
--- @return boolean contained Whether the table contains the key.
function collections.containsKey(tbl, key)
	for k,_ in pairs(tbl) do
		if k == key then return true end
	end
	return false
end

--- Returns the first item in a table matching a given predicate.
--- @param tbl table The table to search.
--- @param wherePredicate fun (val: any): boolean The predicate that determines what the first value must have.
--- @return any? firstInstance The first item that matches the predicate.
function collections.first(tbl, wherePredicate)
	for _,val in pairs(tbl) do
		if wherePredicate(val) then return val end
	end
	return nil
end

--- Returns the index of the first instance of a specified value in a table.
--- @param tbl table The table to search.
--- @param val any The value to search for.
--- @return number index The index of the first instance of the value, or `-1` if the value cannot be found.
function collections.firstIndex(tbl, val)
	for i=1, #tbl do
		if tbl[i] == val then return i end
	end
	return -1
end

--- Returns the last item in a table matching a given predicate.
--- @param tbl table The table to search.
--- @param wherePredicate fun (val: any): boolean The predicate that determines what the last value must have.
--- @return any? lastInstance The last item that matches the predicate.
function collections.last(tbl, wherePredicate)
	local lastVal = nil
	for _,val in pairs(tbl) do
		if wherePredicate(val) then
			lastVal = val
		end
	end
	return lastVal
end

--- Returns the index of the last instance of a specified value in a table.
--- @param tbl table The table to search.
--- @param val any The value to search for.
--- @return number The index of the last instance of the value, or `-1` if the value cannot be found.
function collections.lastIndex(tbl, val)
	local lastValue = -1
	for i=1, #tbl do
		if tbl[i] == val then lastValue = i end
	end
	return lastValue
end

--- Returns whether all the items in a table meet a given predicate.
--- @param tbl table The table to search.
--- @param predicate fun (val: any): boolean The predicate the items in the table must meet.
--- @return boolean matched Whether all items satisfy the predicate.
function collections.allSatisfy(tbl, predicate)
	for _,v in pairs(tbl) do
		if not predicate(v) then return false end
	end
	return true
end

--- A shorthand version of `collections.allSatisfy` that returns whether all the items in a table match a specific value.
--- @param tbl table The table to search.
--- @param val any The value to match against.
--- @return boolean matched Whether all items in the table match the given value.
function collections.allMatchValue(tbl, val)
	return collections.allSatisfy(tbl, function (v)
		return v == val
	end)
end

--- Reverses the items in a table.
--- @param tbl table The table to reverse.
--- @return table reversed The reversed table.
function collections.reversed(tbl)
	local reversed = {}
	for i=#tbl, 1, -1 do
		reversed[#reversed + 1] = tbl[i]
	end
	return reversed
end

--- Returns a table with a transform function applied to each item.
--- @param tbl table The table to transform all items.
--- @param transform fun (val: any): any The function used to transform each item.
--- @return table transformed A table with each of its items transformed.
function collections.map(tbl, transform)
	local newTable = {}
	for i=1, #tbl do
		newTable[#newTable + 1] = transform(tbl[i])
	end
	return newTable
end

--- Returns a table with a transform function applied to each item, taking keys into account.
--- @param tbl table The table to transform all items.
--- @param transform fun (key: any, val: any): any The function used to transform each item.
--- @return table transformed A table with each of its items transformed.
function collections.mapKeyed(tbl, transform)
	local newTable = {}
	for key, val in pairs(tbl) do
		newTable[key] = transform(key, val)
	end
	return newTable
end

--- Returns a table of items that satisfy a given predicate.
--- @param tbl table The table to filter.
--- @param predicate fun (val: any): boolean The predicate used to filter items.
--- @return table filtered A table containing items that satisfy the predicate.
function collections.filter(tbl, predicate)
	local newTable = {}
	for i=1, #tbl do
		local val = tbl[i]
		if predicate(val) then
			newTable[#newTable + 1] = val
		end
	end
	return newTable
end

--- Returns a table of items that satisfy a given predicate, taking keys into account.
--- @param tbl table The table to filter.
--- @param predicate fun (key: any, val: any): boolean The predicate used to filter items.
--- @return table filtered A table containing items that satisfy the predicate.
function collections.filterKeyed(tbl, predicate)
	local newTable = {}
	for k,v in pairs(tbl) do
		if predicate(k, v) then
			newTable[k] = v
		end
	end
	return newTable
end

--- Folds the items in a table into a single reduced value, from left to right.
--- @param tbl table The table to fold the items.
--- @param initVal any The initial value for the fold.
--- @param reducer fun (accum: any, current: any): any The function that will fold the items.
--- @return any reduced The reduced value.
function collections.foldLeft(tbl, initVal, reducer)
	local reduced = initVal
	for i=1, #tbl do
		reduced = reducer(reduced, tbl[i])
	end
	return reduced
end

--- Folds the items in a table into a single reduced value, from right to left.
--- @param tbl table The table to fold the items.
--- @param initVal any The initial value for the fold.
--- @param reducer fun (current: any, accum: any): any The function that will fold the items.
--- @return any reduced The reduced value.
function collections.foldRight(tbl, initVal, reducer)
	local reduced = initVal
	for i=#tbl, 1, -1 do
		reduced = reducer(reduced, tbl[i])
	end
	return reduced
end

--- Folds the items in a table into a single reduced value, from left to right, taking keys into account.
--- @param tbl table The table to fold the items.
--- @param initVal any The initial value for the fold.
--- @param reducer fun (current: any, accumKey: any, accumVal: any): any The function that will fold the items.
--- @return any reduced The reduced value.
function collections.foldLeftKeyed(tbl, initVal, reducer)
	local reduced = initVal
	for k,v in pairs(tbl) do
		reduced = reducer(reduced, k, v)
	end
	return reduced
end

--- Folds the items in a table into a single reduced value, from right to left, taking keys into account.
--- @param tbl table The table to fold the items.
--- @param initVal any The initial value for the fold.
--- @param reducer fun (current: any, accumKey: any, accumVal: any): any The function that will fold the items.
--- @return any reduced The reduced value.
function collections.foldRightKeyed(tbl, initVal, reducer)
	local reduced = initVal
	for k,v in pairs(tbl) do
		reduced = reducer(reduced, k, v)
	end
	return reduced
end

--- Returns a table where the keys are replaced with indices.
--- @param tbl table The table with keys to strip.
--- @return table stripped The table with keys stripped.
function collections.strippedKeys(tbl)
	local stripped = {}
	for _,v in pairs(tbl) do
		stripped[#stripped + 1] = v
	end
	return stripped
end

collections.reduce = collections.foldLeft
collections.reduceKeyed = collections.foldLeftKeyed

return collections