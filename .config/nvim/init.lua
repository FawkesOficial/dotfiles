-- ========================================================================== --
-- ==                               IMPORTS                                == --
-- ========================================================================== --

require('keymaps')
require('plugins')
require('impatient')

-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.undodir = vim.fn.expand('$XDG_CACHE_HOME/.vim/undodir')
vim.opt.undofile = true

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
-- vim.cmd('colorscheme nord')

local pywal = require('pywal')

pywal.setup()

---
-- Titus Custom Markdown HUGO Image Insert
---
-- require'clipboard-image'.setup {
--   markdown = {
--    img_dir = {"content/images", "%:p:h:t", "%:t:r"},
--    img_dir_txt = {"/images", "%:p:h:t", "%:t:r"},
--    img_name = function ()
--       vim.fn.inputsave()
--       local name = vim.fn.input('Name: ')
--       vim.fn.inputrestore()

--       if name == nil or name == '' then
--         return os.date('%y-%m-%d-%H-%M-%S')
--       end
--       return name
--     end,
--     img_handler = function ()
--         return function (path)
--             return os.execute(string.format('~/.scripts/tinypng -s -f %s &', path))
--         end
--     end
--   }
-- }

-- LSP and Linting Config
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
    'bashls',
    'luau_lsp',
    'marksman',
    -- 'powershell_es',
  },
	automatic_installation = true,
})

require'lspconfig'.bashls.setup{}
require'lspconfig'.luau_lsp.setup{}
require'lspconfig'.marksman.setup{}
-- require'lspconfig'.powershell_es.setup{
--   bundle_path = '~/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices/',
-- }

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}

require("null-ls").setup({
	sources = {
			require("null-ls").builtins.formatting.stylua,
			require("null-ls").builtins.code_actions.cspell,
			require("null-ls").builtins.diagnostics.codespell,
			require("null-ls").builtins.completion.spell,
			require("null-ls").builtins.code_actions.proselint,
			require("null-ls").builtins.diagnostics.write_good,
	},
})

-- File Explorer nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

--Pretty Status bar
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'pywal-nvim',
		section_separators = '',
		component_separators = '',
	},
}

-- Add Ctrl + X and initialize toggle term 
require("toggleterm").setup {
	open_mapping = [[<c-x>]],
	shade_terminals = false
}

-- Add projects capability to telescope
require('telescope').load_extension('projects')

-- Smarter Indent setup
vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

-- Autosave

require("auto-save").setup {
	enabled = false
}