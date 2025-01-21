local el = require("el")

local builtin = require("el.builtin")
local extensions = require("el.extensions")
local subscribe = require("el.subscribe")
local sections = require("el.sections")
local diagnostic = require("el.diagnostic")
local lsp_statusline = require("el.plugins.lsp_status")


local white_space = " "

local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
    local branch = extensions.git_branch(window, buffer)

    if branch then
        return " " .. extensions.git_icon() .. " " .. branch
    end
end)

local git_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, buffer)
    local icon = extensions.file_icon(_, buffer)

    if icon then
        return icon .. " "
    end

    return ""
end)

local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
    return extensions.git_changes(window, buffer)
end)


local diagnostics_formatter = function(window, buffer, counts)
    local items = {}

    if counts.errors > 0 then
        table.insert(items, string.format(" %s", counts.errors))
    end

    if counts.warnings > 0 then
        table.insert(items, string.format(" %s", counts.warnings))
    end

    if counts.infos > 0 then
        table.insert(items, string.format("i %s", counts.infos))
    end

    if counts.hints > 0 then
        table.insert(items, string.format("! %s", counts.hints))
    end

    if next(items) == nil then
        table.insert(items, "")
    end

    return table.concat(items, " ")
end

local diagnostic_display = diagnostic.make_buffer(diagnostics_formatter)


el.setup({
    generator = function(window, buffer)
        local segments = {}

        table.insert(segments, extensions.gen_mode({ format_string = " %s " }))
        table.insert(segments, git_branch)
        table.insert(segments, white_space)
        table.insert(segments, sections.split)
        table.insert(segments, git_icon)
        table.insert(segments, sections.maximum_width(builtin.file_relative, 0.60))
        table.insert(segments, sections.collapse_builtin { { " " }, { builtin.modified_flag } })
        table.insert(segments, sections.split)
        table.insert(segments, lsp_statusline.current_function)
        table.insert(segments, white_space)
        table.insert(segments, diagnostic_display)
        table.insert(segments, white_space)

        return segments
    end
})

require("fidget").setup {
    text = {
        spinner = "dots",
    },

    window = {
        relative = "editor",
    },
}
