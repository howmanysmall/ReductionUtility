--!optimize 2
--!strict

export type Action<Type = any> = {
	type: Type,
}

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
