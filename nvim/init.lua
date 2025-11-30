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
    vim.api.nvim_set_hl(0, "StatusLine",           { fg = colors.lavender, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, "StatusLineNC",         { fg = colors.surface0, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, "StatusLineLeft",       { fg = colors.surface0, bg = colors.blue     })
    vim.api.nvim_set_hl(0, "StatusLineLeftEnd",    { fg = colors.surface0, bg = colors.lavender })
    vim.api.nvim_set_hl(0, "StatusLineDiag",       { fg = colors.surface0, bg = colors.lavender })
    vim.api.nvim_set_hl(0, "StatusLineRight",      { fg = colors.surface0, bg = colors.green    })
    vim.api.nvim_set_hl(0, "StatusLineRightEnd",   { fg = colors.green, bg = colors.lavender    })


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

    -- kdl 
    vim.filetype.add({
        extension = {
            kdl = "kdl",
        },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "kdl",
      callback = function()
        vim.cmd([[
            syntax clear
            syntax enable
            syntax match kdlComment "//.*"
            syntax region kdlString start=/"/ skip=/\\"/ end=/"/
            syntax match kdlNumber "\v[-+]?\d+(\.\d+)?"
            syntax keyword kdlBoolean true false
            syntax match kdlPunct "[{}\[\]()=,]"
            highlight default link kdlComment Comment
            highlight default link kdlString String
            highlight default link kdlNumber Number
            highlight default link kdlBoolean Boolean
            highlight default link kdlPunct Delimiter
            highlight kdlPunct guifg=#89b4fa
        ]])
      end,
    })


    -- custom commands
    vim.api.nvim_create_user_command("Rcfg", function()
        vim.cmd("luafile ~/.config/nvim/init.lua")
        print("🔁 Config reloaded!")
    end, {})


    -- powerline
    local powerline = function()
        local function fileinfo()
          local fname = vim.fn.expand('%:t')
          if fname == '' then fname = '>No Name<' end
          local modified = vim.bo.modified and ' ● ' or ''
          return fname .. modified
        end

        local function diagnostics()
          local errors = vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
          local warns  = vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})
          local e_count = #errors
          local w_count = #warns
          local out = ''
          if e_count > 0 then out = out .. ' E:' .. e_count end
          if w_count > 0 then out = out .. ' W:' .. w_count end
          return out
        end

        function set_powerline()
            local sep_left  = ''
            local sep_right = ''
            local left = '%#StatusLineLeftEnd#' .. sep_left
            local mid = '%#StatusLineDiag# ' .. diagnostics() .. ' '
            local right = '%=' .. '%#StatusLineRightEnd#' .. sep_right .. '%#StatusLineRight# [' .. fileinfo() .. '] %l:%c ' .. sep_right
            vim.opt.statusline = left .. mid .. right
        end

        vim.api.nvim_create_autocmd(
            { "BufEnter", "WinEnter", "InsertLeave", "TextChanged", "TextChangedI", "BufWritePost" },
            { callback = set_powerline }
        )

        set_powerline()

    end

   powerline()

end

rk_config()
