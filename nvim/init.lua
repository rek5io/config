-- config
local rk_config = function()
    -- tabs
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.smartindent = true


    -- numbering
    vim.opt.number = true
    vim.opt.relativenumber = false
    vim.opt.numberwidth = 4


    -- colors
    vim.cmd("set background=dark")

    vim.o.termguicolors = true

    local colors = {
        base      = "#1e1e2e",
        mantle    = "#181825",
        crust     = "#11111b",
        text      = "#cdd6f4",
        subtext1  = "#bac2de",
        subtext0  = "#a6adc8",
        overlay2  = "#9399b2",
        overlay1  = "#7f849c",
        overlay0  = "#6c7086",
        surface2  = "#585b70",
        surface1  = "#45475a",
        surface0  = "#313244",
        blue      = "#89b4fa",
        lavender  = "#b4befe",
        sapphire  = "#74c7ec",
        sky       = "#89dceb",
        teal      = "#94e2d5",
        green     = "#a6e3a1",
        yellow    = "#f9e2af",
        peach     = "#fab387",
        maroon    = "#eba0ac",
        red       = "#f38ba8",
        mauve     = "#cba6f7",
        pink      = "#f5c2e7",
        flamingo  = "#f2cdcd",
        rosewater = "#f5e0dc",
    }

    vim.api.nvim_set_hl(0, "Normal",               { fg = colors.text, bg = colors.mantle       })
    vim.api.nvim_set_hl(0, "NormalNC",             { fg = colors.text, bg = colors.mantle       })
    vim.api.nvim_set_hl(0, "CursorLine",           { bg = colors.surface0                       })
    vim.api.nvim_set_hl(0, "CursorColumn",         { bg = colors.surface0                       })
    vim.api.nvim_set_hl(0, "LineNr",               { fg = colors.overlay0                       })
    vim.api.nvim_set_hl(0, "CursorLineNr",         { fg = colors.peach                          })
    vim.api.nvim_set_hl(0, "Visual",               { bg = colors.surface2                       })
    vim.api.nvim_set_hl(0, "StatusLine",           { fg = colors.subtext0, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, "StatusLineNC",         { fg = colors.surface1, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, "VertSplit",            { fg = colors.surface2                       })
    vim.api.nvim_set_hl(0, "Pmenu",                { fg = colors.text, bg = colors.surface0     })
    vim.api.nvim_set_hl(0, "PmenuSel",             { fg = colors.base, bg = colors.lavender     })
    vim.api.nvim_set_hl(0, "Comment",              { fg = colors.overlay0, italic = true        })
    vim.api.nvim_set_hl(0, "Keyword",              { fg = colors.mauve                          })
    vim.api.nvim_set_hl(0, "Identifier",           { fg = colors.blue                           })
    vim.api.nvim_set_hl(0, "Function",             { fg = colors.lavender                       })
    vim.api.nvim_set_hl(0, "Statement",            { fg = colors.blue                           })
    vim.api.nvim_set_hl(0, "Type",                 { fg = colors.yellow                         })
    vim.api.nvim_set_hl(0, "String",               { fg = colors.green                          })
    vim.api.nvim_set_hl(0, "Number",               { fg = colors.red                            })
    vim.api.nvim_set_hl(0, "StatusLine",           { fg = colors.lavender                       })
    vim.api.nvim_set_hl(0, "@constant.builtin",    { fg = colors.mauve                          })
    vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors.blue                           })
    vim.api.nvim_set_hl(0, "@boolean",             { fg = colors.red                            })


    -- rust
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
            vim.api.nvim_set_hl(0, "RustCapitalWord", { fg = colors.green })
            vim.fn.matchadd("RustCapitalWord", [[\C\<[A-Z][a-zA-Z0-9_]*\>]])

            vim.api.nvim_set_hl(0, "RustSelf", { fg = colors.red })
            vim.fn.matchadd("RustSelf", [[\<self\>]])
        end,
    })


    -- custom commands
    local tree_buf = nil
    local tree_win = nil

    vim.api.nvim_create_user_command("Rcfg", function()
        if tree_win and vim.api.nvim_win_is_valid(tree_win) then
            vim.api.nvim_win_close(tree_win, true)
            tree_buf = nil
            tree_win = nil
        end

        vim.cmd("luafile ~/.config/nvim/init.lua")
        print("🔁 Config reloaded!")
    end, {})

    vim.api.nvim_create_user_command("Tree", function()
        if tree_win and vim.api.nvim_win_is_valid(tree_win) then
            vim.api.nvim_win_close(tree_win, true)
            tree_buf = nil
            tree_win = nil
            return
        end

        local output = vim.fn.systemlist("tree -L 2")
        output = vim.list_slice(output, 1, #output - 2)

        tree_buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(tree_buf, 0, -1, false, output)

        vim.cmd("vsplit")
        vim.cmd("vertical resize 32")
        tree_win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(tree_win, tree_buf)
        vim.bo[tree_buf].buftype = "nofile"
        vim.bo[tree_buf].bufhidden = "wipe"
        vim.bo[tree_buf].swapfile = false
        vim.bo[tree_buf].modifiable = false
        vim.bo[tree_buf].readonly = true

        vim.api.nvim_win_set_option(tree_win, "number", false)
        vim.api.nvim_win_set_option(tree_win, "relativenumber", false)
    end, {})

    vim.api.nvim_set_keymap('n', 't', ':Tree<CR>', { noremap = true, silent = true })
end

rk_config()
