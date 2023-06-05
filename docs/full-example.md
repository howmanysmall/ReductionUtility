---
sidebar_position: 3
---

# Full Example

Here's a full example of using ReductionUtility as I do in my own projects.

```lua
--!optimize 2
-- I do not recommend strict mode, since it does not behave well.
local ReductionUtility = require("ReductionUtility")

local Reduction = {}

export type IncrementNumber = ReductionUtility.Action<"IncrementNumber"> & {Value: number}
Reduction.IncrementNumber = ReductionUtility.MakeActionCreator("IncrementNumber", function(value: number)
	return {
		Value = value,
	}
end)

export type SetNumber = ReductionUtility.Action<"SetNumber"> & {Value: number}
Reduction.SetNumber = ReductionUtility.MakeActionCreator("SetNumber", function(value: number)
	return {
		Value = value,
	}
end)

export type SetString = ReductionUtility.Action<"SetString"> & {Value: string}
Reduction.SetString = ReductionUtility.MakeActionCreator("SetString", function(value: string)
	return {
		Value = value,
	}
end)

export type UppercaseString = ReductionUtility.Action<"UppercaseString">
Reduction.UppercaseString = ReductionUtility.MakeActionCreator("UppercaseString", function()
	return {}
end)

export type IState = {
	Number: number,
	String: string,
}

local INITIAL_STATE: IState = table.freeze({
	Number = 0,
	String = "",
})
Reduction.InitialState = INITIAL_STATE

Reduction.Reducer = ReductionUtility.CreateReducer(INITIAL_STATE, {
	[Reduction.IncrementNumber.name] = function(state: IState, action: IncrementNumber)
		local new = table.clone(state)
		state.Number += action.Value
		return new
	end,

	[Reduction.SetNumber.name] = function(state: IState, action: SetNumber)
		local new = table.clone(state)
		state.Number = action.Value
		return new
	end,

	[Reduction.SetString.name] = function(state: IState, action: SetString)
		local new = table.clone(state)
		state.String = action.Value
		return new
	end,

	[Reduction.UppercaseString.name] = function(state: IState)
		local new = table.clone(state)
		state.String = string.upper(state.String)
		return new
	end,
})

table.freeze(Reduction)
return Reduction
```

Then you can pass the reducer to wherever you need it!