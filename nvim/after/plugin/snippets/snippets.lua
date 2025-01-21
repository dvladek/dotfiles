local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node

ls.add_snippets("all", {
  s(
    "todo",
    c(1, {
      t "TODO(dvladek): ",
      t "FIXME(dvladek): ",
      t "NOTE(dvladek): "
    })
  ),
  s(
    "fixme",
    c(1, {
      t "FIXME(dvladek): ",
      t "NOTE(dvladek): ",
      t "TODO(dvladek): "
    })
  ),
  s(
    "note",
    c(1, {
      t "NOTE(dvladek): ",
      t "TODO(dvladek): ",
      t "FIXME(dvladek): "
    })
  )
})

ls.add_snippets("python", {
  s(
    "mn",
    fmt(
      [[
            def main({}):
                {}

            if __name__ == '__main__':
                main({})
            ]],
      {
        f(function(import_args)
          local parts = vim.split(import_args[1][1], ".", true)
          return (parts[#parts] or "")
        end, { 1 }),
        i(0),
        c(1, { t "sys.argv", t "" }),
      }
    )
  )
})
