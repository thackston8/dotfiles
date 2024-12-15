-- User prefs 
vim.opt.number = true -- Number lines
vim.opt.mouse = "a" -- Mouse support
vim.opt.syntax = "on" -- Allow vim.opt.* syntax in this file
-- Spellcheck
vim.opt.spelllang = 'en_us'
vim.opt.spell = true


-- Give feedback during searches
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Indent automatically and with spaces
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 4


-- Install lazy.nvim if needed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  "ellisonleao/gruvbox.nvim", -- Color scheme
  'lewis6991/gitsigns.nvim', dependencies = {'nvim-lua/plenary.nvim'},
  'nvim-lualine/lualine.nvim', -- Bottom Bar
  'nvim-tree/nvim-web-devicons', 
  'romgrk/barbar.nvim', -- Top Bar
  'neovim/nvim-lspconfig', -- LSP
  'nvim-treesitter/nvim-treesitter',
  'hrsh7th/nvim-cmp', -- Completion Plugin
  'hrsh7th/cmp-nvim-lsp', -- LSP Config
  'L3MON4D3/LuaSnip', -- LSP Snips
  'm4xshen/autoclose.nvim', -- Autoclose brackets
  'abecodes/tabout.nvim' -- Tabout
})

-- Theme
options = { theme = 'gruvbox' }
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

require('lualine').setup() -- Start Lualine
require("autoclose").setup() -- Start Autoclose
require('tabout').setup{
    tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
    completion = true,
    tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = '`', close = '`' },
        { open = '(', close = ')' },
        { open = '[', close = ']' },
        { open = '{', close = '}' }
    },
    ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content

}

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require'lspconfig'.rust_analyzer.setup{}

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
