--!optimize 2
--!strict

local Types = require(script.Parent:FindFirstChild("Types"))

export type Action<Type> = Types.Action<Type>
export type ActionCreator<Type, Action, Args...> = Types.ActionCreator<Type, Action, Args...>

--[=[
	Creates an action creator that you can call to create an action.

	@param name Type -- The name of the action. Will be the `type` of the action.
	@param creator (Args...) -> Payload -- The function that creates the payload of the action.
	@within ReductionUtility
]=]
local function MakeActionCreator<Type, Payload, Args...>(name: Type, creator: (Args...) -> Payload): ActionCreator<Type, Payload, Args...>
	return setmetatable({name = name}, {
		__call = function(_: any, ...: Args...): Payload & Action<Type>
			local result = creator(...)
			assert(type(result) == "table", "Invalid action: An action creator must return a table")

			result.type = name
			table.freeze(result)
			return result
		end;
	})
end

return MakeActionCreator
