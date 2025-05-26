local M = require("lemon")

local eq = MiniTest.expect.equality

local new_set = MiniTest.new_set

T = new_set()

T["find_parent"] = function()
  local parents = M._find_parent({
    "dir1/",
    "dir2/",
    "  file1",
    "  dir3/",
    "    cursor_file",
  }, 2)
  eq({ "dir2", "dir3" }, parents)
end

T["count_indent"] = function()
  eq(3, M._count_indent("      hello world"))
end

T["get_diff"] = new_set()

T["get_diff"]["add"] = function()
  local set = {
    [[hi.lua
world.lua
]],
    [[hi.lua
world.lua
hello.lua
]],
  }
  local expect = { {
    type = "add",
    line = 2,
    text = "hello.lua",
  } }
  eq(expect, M._get_diff(unpack(set)))
end

T["get_diff"]["delete"] = function()
  local set = {
    [[hi.lua
world.lua
hello.lua
]],
    [[hi.lua
world.lua
]],
  }
  local expect = { {
    type = "delete",
    line = 2,
    text = "hello.lua",
  } }
  eq(expect, M._get_diff(unpack(set)))
end

return T
