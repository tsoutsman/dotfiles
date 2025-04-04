return {
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
	{
	  'nvim-orgmode/orgmode',
	  event = 'VeryLazy',
	  ft = { 'org' },
	  config = function()
		-- Setup orgmode
		require('orgmode').setup({
		  org_agenda_files = '~/Documents/org/**/*',
		  org_default_notes_file = '~/Documents/org/refile.org',
		  -- org_todo_keywords = {'TODO', 'LECT', 'TUTE', 'ASGN', '|', 'DONE'},
		})

		-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
		-- add ~org~ to ignore_install
		-- require('nvim-treesitter.configs').setup({
		--   ensure_installed = 'all',
		--   ignore_install = { 'org' },
		-- })
	  end,
	}
}

