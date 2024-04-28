-- Make "d", "c" actually delete instead of cut
return {
    "gbprod/cutlass.nvim",
    opts = {
        cut_key = "x",
        override_del = true,
        exclude = {},
        registers = {
            select = "_",
            delete = "_",
            change = "_",
        },
    }
}
