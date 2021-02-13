lua << EOF
local actions = require('telescope.actions')
local sorters = require('telescope.sorters')

require('telescope').setup {
  defaults = {
    prompt_prefix = ' >',

    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    prompt_position = "bottom",
    color_devicons = true,

    file_sorter = sorters.get_fzy_sorter,

    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },

        fzf_writer = {
            use_highlighter = false,
            minimum_grep_characters = 4,
        }
    },

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-s>"] = actions.goto_file_selection_split,
        ["<C-q>"] = actions.send_to_qflist,
      },
    }
  }
}

require('telescope').load_extension('gh')
require('telescope').load_extension('fzy_native')

EOF

nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>

nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>vw :lua require('telescope.builtin').symbols()<CR>
