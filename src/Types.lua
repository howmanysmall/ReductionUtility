--!optimize 2
--!strict

--[=[
	The types exported by this library.
	@class Types
]=]

--[=[
	An action type.

	You can use it as such:
	```lua
	local ReductionUtility = require("ReductionUtility")
	type PassesString = ReductionUtility.Action<"PassesString"> & {Value: string}
	```

	@interface Action<Type = any>
	.Type Type -- The type of the action.
	@within Types
]=]
export type Action<Type = any> = {
	type: Type,
}

--[=[
	A generic action type.
	@type AnyAction {[string]: any, Type: any}
	@within Types
]=]
export type AnyAction = {[string]: any} & Action

export type ActionCreator<Type, Payload, Args...> = typeof(setmetatable(
	{} :: {name: Type},
	{} :: {__call: (any, Args...) -> (Payload & Action<Type>)}
))

export type Reducer<State = any, Action = AnyAction> = (state: State?, action: Action) -> State
export type ReducersMapObject<State = any, Action = AnyAction> = {
	[string]: Reducer<State, Action>,
}

return false
