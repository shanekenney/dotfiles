-- Telescope config
require('telescope').setup{
  defaults = {
    path_display = {"smart"}
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
