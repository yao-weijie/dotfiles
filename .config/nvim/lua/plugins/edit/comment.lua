return {
    "numToStr/Comment.nvim",
    event = { "BUfRead" },
    opts = {
        padding = true,
        sticky = true,
        ignore = "^$",

        toggler = {
            line = "<leader>cc",
            block = "<leader>CC",
        },
        opleader = {
            line = "<leader>c",
            block = "<leader>C",
        },
        extra = {
            above = "<leader>cO",
            below = "<leader>co",
            eol = "<leader>cA",
        },
        mappings = {
            basic = true,
            extra = true,
        },
    },
    config = function(_, opts)
        require("Comment").setup(opts)
        local ft = require("Comment.ft")

        ft({ "c", "cpp", "foam" }, { "//%s", "/*%s*/" })
    end,
}