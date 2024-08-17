require("luasnip.session.snippet_collection").clear_snippets("norg")

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

ls.add_snippets("norg", {
   s("code", fmt("@code {}", { i(1) })),
   s("end", t("@end")),
})