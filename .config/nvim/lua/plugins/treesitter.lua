local opts = {
    ensure_installed = { "help", "c", "cpp", "vim", "lua" },
    sync_install = true, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "foam" },
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local lang_backlist = {
                "latex",
                "foam",
            }
            if vim.tbl_contains(lang_backlist, lang) then
                return true
            end

            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
    },

    indent = { enable = false },
    -- Wisely add "end" in Ruby, Vimscript, Lua, etc.
    -- https://github.com/RRethy/nvim-treesitter-endwise
    endwise = { enable = true },

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    textobjects = {
        swap = { enable = false },
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "prev func start" },
                ["[c"] = { query = "@class.outer", desc = "prev class start" },
            },
            goto_previous_end = {
                ["[F"] = { query = "@function.outer", desc = "prev func end" },
                ["[C"] = { query = "@class.outer", desc = "prev class end" },
            },
            goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "next func start" },
                ["]c"] = { query = "@class.outer", desc = "next class start" },
            },
            goto_next_end = {
                ["]F"] = { query = "@function.outer", desc = "next func end" },
                ["]C"] = { query = "@class.outer", desc = "next class end" },
            },
        },
        lsp_interop = { enable = false },
    },

    -- https://github.com/p00f/nvim-ts-rainbow2
    rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = nil,
    },
}

return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "HiPhish/nvim-ts-rainbow2",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "RRethy/nvim-treesitter-endwise",
    },
    build = ":TSUpdate",
    event = { "BufRead" },
    config = function()
        require("nvim-treesitter.configs").setup(opts)
    end,
}