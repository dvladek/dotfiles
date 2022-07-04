local Remap = require("dvd.keymap")
local nnoremap = Remap.nnoremap

local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")


daptext.setup()
dapui.setup()

local dappy = require("dap-python")
dap.adapters.python = {
    type = "executable",
    command = os.getenv("HOME") .. "/Development/.pyenvs/debugpy/bin/python",
    args = {
        "-m",
        "debugpy.adapter"
    },
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
    },
}

