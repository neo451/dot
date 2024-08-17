require("luasnip.session.snippet_collection").clear_snippets("zig")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local postfix = require("luasnip.extras.postfix").postfix

ls.add_snippets("zig", {
   s("std", {
      t({ 'const std = @import("std");', "" }),
      t({ "const print = std.debug.print;", "" }),
   }),
   s("allo", {
      t({ "var gpa = std.heap.GeneralPurposeAllocator(.{}){};", "" }),
      t({ "const Allocator = std.mem.Allocator;", "" }),
   }),
   s("allo2", {
      t({ "var gpa = std.heap.GeneralPurposeAllocator(.{}){};", "" }),
      t({ "const Allocator = std.mem.Allocator;", "" }),
      t({ "defer _ = gpa.deinit();", "" }),
   }),
})
