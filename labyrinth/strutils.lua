local strf <const> = string.format

local strutils = {}

--- Splits a string into components delimited by a separator.
--- @param str string The string to split into components.
--- @param separator string The separator to split by.
--- @return table components The components split up by the separator.
function strutils.split(str, separator)
	local components = {}
	local sep = separator or "%s"
	local pattern = strf("([^%s]+)", sep)
	for match in string.gmatch(str, pattern) do
		components[#components + 1] = match
	end
	return components
end

--- Retrieves an individual character at an index.
--- @param str string The string to retrieve the character of.
--- @param index number The index of the character to retrieve.
--- @return string character The character at the specified index.
function strutils.charAtIndex(str, index)
	return string.sub(str, index, index)
end

--- Joins a series of strings together, separated by a given separator.
--- @param tbl table The table of strings to join together.
--- @param separator string? The separator to separate the strings by. Defaults to a space.
--- @param startIndex number? Where to start joining the strings. Defaults to 1.
--- @param endIndex number? Where to end joining the strings. Defaults to the table's length.
--- @return string joined The joined string.
function strutils.joined(tbl, separator, startIndex, endIndex)
	local joined = ""
	local sep = separator or " "
	local sidx = startIndex or 1
	local eidx = endIndex or #tbl

	for i=sidx, eidx do
		joined = joined .. tbl[i]
		if i < eidx then
			joined = joined .. sep
		end
	end

	return joined
end

--- Returns whether the string starts with a given prefix.
--- @param str string The string to search.
--- @param prefix string The prefix to search for.
--- @return boolean hasPrefix Whether the string has the specified prefix.
function strutils.hasPrefix(str, prefix)
	local slice = string.sub(str, 1, #prefix)
	return slice == prefix
end

--- Returns whether the string ends with a given suffix.
--- @param str string The string to search.
--- @param suffix string The suffix to search for.
--- @return boolean hasSuffix Whether the string has the specified suffix.
function strutils.hasSuffix(str, suffix)
	local suffixOffset = #str - (#suffix - 1)
	local slice = string.sub(str, suffixOffset, #str)
	return slice == suffix
end

strutils.startswith = strutils.hasPrefix
strutils.endswith = strutils.hasSuffix

return strutils