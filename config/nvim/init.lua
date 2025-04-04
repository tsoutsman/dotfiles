vim.wo.nu = true
vim.wo.rnu = true

local TAB_WIDTH = 4
vim.bo.tabstop = TAB_WIDTH
vim.bo.softtabstop = TAB_WIDTH
vim.bo.shiftwidth = TAB_WIDTH
vim.bo.expandtab = true

vim.opt.colorcolumn = "81,101"

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.opt.undofile = true

vim.opt.incsearch = true

-- TODO: What does this do?
vim.opt.updatetime = 50

-- TODO: vim.opt.scrolloff?
vim.opt.scrolloff = 15
--
-- set splitbelow
-- set splitright
vim.opt.splitbelow = true
vim.opt.splitright = true

-- vim.opt.laststatus = 3
-- vim.opt.statusline = "aa"

-- vim.opt.rulerformat = "hello"
-- vim.opt.rulerformat = "%22(%l,%c%V%=%P   %{strftime(\"%I:%M %p\")}%)"
-- vim.opt.statusline = "%<%{strftime(\"%I:%M %p\")}%f %h%m%r%=%-14(%l,%c%V%)%{strftime(\"%I:%M %p\")}"
-- vim.opt.statusline = "%<%f %h%m%r%=%l%=3"
 
-- Key Bindings

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>f", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<esc>")

require("config.lazy")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>h', builtin.find_files, {})
vim.keymap.set('n', '<leader>t', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "julia", "lua", "markdown", "markdown_inline", "matlab", "python", "rust", "latex", "slint", "typst", "ocaml" },
	auto_install = true,
	highlight = {
		enable = true,
	-- Enables TODO highlighting.
		additional_vim_regex_highlighting = true,
	},
})

vim.g.vimtex_quickfix_open_on_warning = 0

local lspconfig = require('lspconfig')

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

lspconfig.rust_analyzer.setup({
  -- settings = {
  --   ['rust-analyzer'] = {
  --       rustfmt = {
  --           overrideCommand = { 'rustfmt', '+nightly' },
  --       }
  --   }
  -- }
})
--require 'lspconfig'.slint_lsp.setup {}
lspconfig.ocamllsp.setup({
    cmd = { "ocamllsp" },
    filetypes = { "ml", "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
    on_attach = on_attach,
	-- root_dir = lsp.util.root_pattern("*.opam", "esy.json", "package.json", ".git", "dune-project", "dune-workspace"),
})

vim.keymap.set("n", "ff", vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action)

vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- vim.api.nvim_create_autocmd('BufEnter', {
--   desc = 'Set filetype for OCaml',
--   pattern = '*.ml',
--   command = 'setlocal filetype=ocaml' 
-- })

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set filetype for Slint files',
  pattern = '*.slint',
  command = 'setlocal filetype=slint | set tabstop=4 | set softtabstop=4 | set shiftwidth=4'
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set filetype for Typst files',
  pattern = '*.typ',
  command = 'setlocal filetype=typst | set tabstop=2 | set softtabstop=2 | set shiftwidth=2'
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set filetype for Nix files',
  pattern = '*.nix',
  command = 'setlocal filetype=nix | set tabstop=2 | set softtabstop=2 | set shiftwidth=2'
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set filetype for Typst files',
  pattern = '*.tex',
  command = 'set tabstop=2 | set softtabstop=2 | set shiftwidth=2'
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set filetype for ocaml files',
  pattern = '*.ml',
  command = 'setlocal filetype=ocaml | set tabstop=2 | set softtabstop=2 | set shiftwidth=2'
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Set filetype for Svelte files',
  pattern = '*.svelte',
  command = 'setlocal filetype=svelte | set tabstop=2 | set softtabstop=2 | set shiftwidth=2'
})

-- TODO: undotree plugin?
-- TODO: git plugin?

vim.cmd("colorscheme vim")
-- vim.cmd("hi clear")
vim.cmd("command! W write")
vim.cmd("command! Q quit")
