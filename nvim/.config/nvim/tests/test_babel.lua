local M = require("babel")

local eq = MiniTest.expect.equality

local new_set = MiniTest.new_set

T = new_set()

T["get_code_block"] = function()
  local code, lang = M.parse_block([[```lua
print(1)
```]])

  eq("print(1)", code)
  eq("lua", lang)
end

return T
