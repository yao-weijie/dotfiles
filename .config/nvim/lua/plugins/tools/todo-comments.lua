-- 得要有个:才行, 比如(大写) todo:
return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "VeryLazy" },
    keys = {
        { "<leader>D", "<cmd>TodoTelescope<CR>", desc = "todo comments" },
    },
    config = true,
}