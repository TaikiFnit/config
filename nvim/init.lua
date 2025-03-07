vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 基本設定
vim.o.number = true         -- 絶対行番号の表示
vim.o.relativenumber = true -- 相対行番号の表示
vim.o.expandtab = true      -- タブをスペースに変換
vim.o.shiftwidth = 2        -- インデント幅
vim.o.tabstop = 2           -- タブ幅
vim.o.smartindent = true    -- 自動インデント
vim.o.termguicolors = true  -- 24bitカラー対応
vim.o.wrap = false          -- 折り返し無効
vim.o.cursorline = true     -- カーソル行のハイライト

vim.g.mapleader = " "  -- leader キーをスペースに設定
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>p", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lg", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- packer.nvim の初期化
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

   -- ファイルエクスプローラー
  use 'kyazdani42/nvim-tree.lua'

  -- カラースキーム
  use 'gruvbox-community/gruvbox'

    -- Telescope（ファジーファインダー）
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Treesitter（構文解析による強調表示など）
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- LSP 設定用プラグイン（Neovim LSP と補完）
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  -- ステータスライン（lualine）
  use 'hoob3rt/lualine.nvim'

  -- lsp関連で入れたやつ
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'github/copilot.vim'

  use 'hashivim/vim-terraform'
end)

-- Ruby 用 LSP（Solargraph）の設定
local lspconfig = require('lspconfig')
lspconfig.solargraph.setup {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" },
  settings = {
    solargraph = {
      diagnostics = true,
      completion = true,
    }
  }
}
lspconfig.terraformls.setup{
  filetypes = { "terraform", "tf", "terraform-vars" },
}

-- Treesitter 設定（Ruby含む）
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"ruby"},
  highlight = { enable = true }
}

-- 補完エンジン nvim-cmp の設定（LSP 連携）
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  })
})

-- ファイル保存時に余分なスペースを自動削除
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd("%s/\\s\\+$//e")
  end
})

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"terraform", "hcl"},
  highlight = { enable = true },
  indent = { enable = true },
}
