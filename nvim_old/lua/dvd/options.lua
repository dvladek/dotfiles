local opt = vim.opt

opt.guicursor = ""                                  -- Do not change cursor type in INSERT mode.

opt.belloff = "all"                                 -- No beeps.
opt.termguicolors = true                            -- Allow 24-bit colors in GUI.
opt.splitright = true                               -- Split vertical windows right to the current windows.
opt.splitbelow = true                               -- Split horizontal windows below to the current windows.
opt.laststatus = 3                                  -- Lightline configuration.
opt.winbar = "%f"                                   -- Sticky top filename.
opt.scrolloff = 10                                  -- Keep scrolling to have at least 10 lines in the bottom.
opt.cmdheight = 1                                   -- Give more space for displaying messages.

opt.nu = true                                       -- Show line numbers.
opt.relativenumber = true                           -- Show relative line numbers.
opt.cc = "80"

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true                              -- Improved identation.
opt.cindent = true				                    -- Improved C-like identation.
opt.wrap = false                                    -- No wrapping of lines.

opt.hidden = true                                   -- Keep other buffers open in background.
opt.swapfile = false                                -- Do not use swap files.
opt.backup = false                                  -- Do not create anoying backup files.
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Directory to save undo files.
opt.undofile = true                                 -- Create an undo file per buffer file.
opt.autowrite = true                                -- Automatically save before :next, :make, etc.
opt.autoread = true                                 -- Automatically read changed files without asking.
opt.updatetime = 50                                 -- Increase the updatetime for smoother experience.

opt.hlsearch = false                                -- Do not highlight search patterns.

-- opt.pumblend = 17                                   -- testing
-- opt.wildmode = "longest:full"                       -- testing
-- opt.wildoptions = "pum"                             -- testing

opt.wildignore = { "*~", "*.o", "*.pyc", "*pycache*" }
opt.wildignore = opt.wildignore + "**__pycache__/*"
opt.wildignore = opt.wildignore + "**/.cache/*"
opt.wildignore = opt.wildignore + "**/node_modules/*"
opt.wildignore = opt.wildignore + "**/.git/*"
opt.wildignore = opt.wildignore + "**/DS_Store/*"
