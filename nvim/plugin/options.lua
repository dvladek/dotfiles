-- -----------------------------------------
-- Settings
-- -----------------------------------------
local opt = vim.opt

opt.exrc = true                                 -- Load other vrc files.
opt.belloff = "all"                             -- No beeps.
opt.guicursor = nul                             -- Do not change cursor type in INSERT mode.
opt.encoding = "utf-8"                          -- Set default encoding to UTF-8
opt.termguicolors = true                        -- Allow 24-bit colors in GUI.
opt.splitright = true                           -- Split vertical windows right to the current windows.
opt.splitbelow = true                           -- Split horizontal windows below to the current windows.
opt.scrolloff = 10                              -- Keep scrolling to have at least 10 lines in the bottom.

opt.number = true                               -- Show line numbers
opt.relativenumber = true                       -- Show relative line numbers.
opt.showcmd = true                              -- Show me what I'm typing.
opt.colorcolumn = "80"


opt.hlsearch = false                            -- No highlight after searching.
opt.incsearch = true                            -- Shows the match while searching.
opt.ignorecase = true                           -- search cse insensitive...
opt.smartcase = true                            -- ...but not when search pattern contains upper case characters.

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true                          -- Improved indentation.
opt.cindent = true
opt.wrap = false                                -- No wrapping of lines.

opt.hidden = true                               -- Keep other buffers open in background.
opt.swapfile = false                            -- Do not use swap files.
opt.backup = false                              -- Do not create anoying backup files.
opt.undodir = "~/.vim/undodir"                  -- Directory to save undo files.
opt.undofile = true                             -- Create an undo file per buffer file.
opt.autowrite = true                            -- Automatically save before :next, :make, etc.
opt.autoread = true                             -- Automatically read changed files without asking.
opt.updatetime = 50                             -- Increase the updatetime for smoother experience.

-- opt.backspace = "indent,eol,start"              --  Makes backspace key more powerful.
opt.laststatus = 3                              -- Lightline configuration.

opt.pumblend = 17                               -- testing
opt.wildmode = "longest:full"                   -- testing
opt.wildoptions = "pum"                         -- testing


-- -----------------------------------------
-- File Type settings
-- -----------------------------------------

-- Ignore compiled files
opt.wildignore = { "*~", "*.o", "*.pyc", "*pycache*" }
opt.wildignore = opt.wildignore + "**__pycache__/*"
opt.wildignore = opt.wildignore + "**/.cache/*"
opt.wildignore = opt.wildignore + "**/node_modules/*"
opt.wildignore = opt.wildignore + "**/.git/*"
opt.wildignore = opt.wildignore + "**/DS_Store/*"
