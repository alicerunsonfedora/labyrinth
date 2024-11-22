local strf <const> = string.format

--- @enum LogLevel
local LogLevel = { kDebug = 1, kWarning = 2, kError = 3 }

--- @class Logger
--- @field level LogLevel
--- @field facility fun (msg: string)
--- @field debug fun (msg: string, ...) Logs a debug message.
--- @field warn fun (msg: string, ...) Logs a warning message.
--- @field err fun (msg: string, ...) Logs an error message.

--- Creates a logging facility.
--- @param level LogLevel? The level which messages should emit. Defaults to `kWarning`.
--- @param facility function? (msg: string) The facility used to log messages. Defaults to `print`.
--- @return Logger logger
local function logger(level, facility)
	local logging = {
		level = level or LogLevel.kWarning,
		facility = facility or print,
	}

	--- Logs a debug message.
	--- @param format string The message or format to log.
	--- @param ... any Additional parameters to substitute with the message.
	function logging.debug(format, ...)
		if level > LogLevel.kDebug then return end
		logging.facility(strf("[DBG] " .. format, ...))
	end

	--- Logs a warning message.
	--- @param format string The message or format to log.
	--- @param ... any Additional parameters to substitute with the message. 
	function logging.warn(format, ...)
		if level > LogLevel.kWarning then return end
		logging.facility(strf("[WRN] " .. format, ...))
	end

	--- Logs an error message.
	--- @param format string The message or format to log.
	--- @param ... any Additional parameters to substitute with the message.
	function logging.err(format, ...)
		if level > LogLevel.kError then return end
		logging.facility(strf("[ERR] " .. format, ...))
	end

	return logging
end

return logger, LogLevel