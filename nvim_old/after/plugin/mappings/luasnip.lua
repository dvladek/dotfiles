local Remap = require("dvd.keymap")
local inoremap = Remap.inoremap
local snoremap = Remap.snoremap

local ls = require("luasnip")

inoremap("<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

snoremap("<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

inoremap("<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

snoremap("<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

inoremap("<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })
