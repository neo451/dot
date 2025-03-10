return {
   "danymat/neogen",
   config = true,
   keys = {
      {
         "<Leader>nf",
         "<cmd>lua require('neogen').generate()<CR>",
         desc = "Neogen annotaion",
      },
   },
}
