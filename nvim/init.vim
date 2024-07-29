nnoremap <Space>ff    :Telescope find_files<CR>
nnoremap <Space>fb    :Telescope buffers<CR>
nnoremap <Space>e     :Lexplore 30<CR>

call plug#begin()

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'williamboman/mason.nvim'

call plug#end()

lua << EOF
  require("mason").setup()

  local capabilities = require('cmp_nvim_lsp')
  	.default_capabilities()

  local lspconfig = require('lspconfig')
  local cmp = require('cmp')

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline({ '/' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  lspconfig['rust_analyzer'].setup { capabilities = capabilities }
  lspconfig['ocamllsp'].setup { capabilities = capabilities }
  lspconfig['clangd'].setup { capabilities = capabilities }
EOF


hi EndOfBuffer guibg=NONE ctermbg=NONE
hi Normal      guibg=NONE ctermbg=NONE
