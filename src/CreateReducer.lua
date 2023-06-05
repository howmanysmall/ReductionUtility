--!optimize 2

local Locker = require(script.Parent.Parent:FindFirstChild("Locker"))
local Types = require(script.Parent:FindFirstChild("Types"))

type AnyAction = Types.AnyAction
export type Reducer<State = any, Action = AnyAction> = Types.Reducer<State, Action>

--[=[
	Creates a reducer that you can pass into a store or `useReducer`.

	@param initialState State -- The initial state of the reducer. Can be optional.
	@param handlers {[string]: (state: State, action: Action) -> State} -- The functions used for reductions.
	@within ReductionUtility
]=]
local function CreateReducer<State>(initialState, handlers): Reducer<State>
	return function(state: any, action)
		if state == nil then
			state = initialState
		end

		local handler = handlers[action.type]

		if handler then
			return handler(state, action)
		end

		return Locker.DeepLock(state)
	end
end

return CreateReducer
