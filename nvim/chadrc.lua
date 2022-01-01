local M = {
  options = {
  },
  mappings = {
    misc = {
      save_file = "<leader>s"
    },
    plugins = { }
  }
}

M.options = {
  nvChad = {
    insert_nav = false
  },
}

M.mappings.plugins = {
  telescope = {
    buffers = "<leader>b",
    find_files = "<leader>p",
    live_grep = "<leader>g"
  },
  bufferline = {
    next_buffer = "[b",
    prev_buffer = "]b",
  },
  nvimtree = {
    toggle = "<leader><leader>",
    focus = "<C-m>"
  },

}

return M
