local cmds
cmds = {
   backgroud = {
      current = 1,
      choices = { "light", "dark" },
      on_choice = function()
         cmds.backgroud.current = math.fmod(cmds.backgroud.current, 2) + 1
         vim.o.background = cmds.backgroud.choices[cmds.backgroud.current]
      end,
   },
}

vim.api.nvim_create_user_command("T", function(_)
   vim.ui.select({ "backgroud" }, { prompt = "Toggle" }, function(selected)
      cmds[selected].on_choice()
   end)
end, {})
