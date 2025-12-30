return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      override = {
        css = {
          icon = "",
          color = "#2965f1",
          cterm_color = "27",
          name = "Css",
        },
      },
      default = true,
    })
  end,
}
