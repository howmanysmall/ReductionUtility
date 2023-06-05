--!optimize 2
--!strict

local CreateReducer = require(script:FindFirstChild("CreateReducer"))
local MakeActionCreator = require(script:FindFirstChild("MakeActionCreator"))
local Types = require(script:FindFirstChild("Types"))

--[=[
	### A utility library for creating reducers.
	@class ReductionUtility
]=]
local ReductionUtility = {
	CreateReducer = CreateReducer;
	MakeActionCreator = MakeActionCreator;
}

export type Action<Type = any> = Types.Action<Type>
export type AnyAction = Types.AnyAction

export type ActionCreator<Type, Payload, Args...> = Types.ActionCreator<Type, Payload, Args...>

export type Reducer<State = any, Action = AnyAction> = Types.Reducer<State, Action>
export type ReducersMapObject<State = any, Action = AnyAction> = Types.ReducersMapObject<State, Action>

table.freeze(ReductionUtility)
return ReductionUtility
