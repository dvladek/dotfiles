ls = require("luasnip")
types = require("luasnip.util.types")

ls.config.set_config {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    enable_autosnippets = true,

    -- Crazy highlights!!
    -- #vid3
    -- ext_opts = nil,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { " <- Current Choice", "NonTest" } },
            },
        },
    },
}

local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local s = ls.snippet

ls.add_snippets("all",
    {
        s("req", fmt("local {} = require('{}')", { i(1, "default"), i(0)})),
    }
)

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")

