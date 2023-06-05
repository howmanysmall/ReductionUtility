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

--[=[
	A callable action creator type.
	@interface ActionCreator<Type,Payload,Args...>
	.name Type -- The name of the action.
	.__call (Args...) -> (Payload & Action<Type>) -- The function that creates the action.
	@within Types
]=]
export type ActionCreator<Type, Payload, Args...> = typeof(setmetatable(
	{} :: {name: Type},
	{} :: {__call: (any, Args...) -> (Payload & Action<Type>)}
))

--[=[
	A reducer type with Action. This isn't actually exported, it's just called `Reducer` and has the same arguments as this.
	@type ReducerWithAction<State,Action> (state: State?, action: Action) -> State
	@within Types
]=]

--[=[
	A reducer type.
	@type Reducer<State> (state: State?, action: AnyAction) -> State
	@within Types
]=]

export type Reducer<State = any, Action = AnyAction> = (state: State?, action: Action) -> State
export type ReducersMapObject<State = any, Action = AnyAction> = {
	[string]: Reducer<State, Action>,
}

return false
