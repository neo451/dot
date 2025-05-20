local M = require("_fb")

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

return T
