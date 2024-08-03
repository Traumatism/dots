set shiftwidth=4
set path+=**
set wildmenu

nnoremap <Space>e       :Lexplore 30<CR>
nnoremap <Space>rf      :RustFmt<CR>
nnoremap <Space>rr	:RustRun 
nnoremap <Space>c	:tabnew<CR>
nnoremap <Space>n	:tabnext<CR>
nnoremap <Space>p 	:tabprevious<CR>
nnoremap <Space>f	:find 

colorscheme vim

hi EndOfBuffer guibg=NONE ctermbg=NONE
hi Normal      guibg=NONE ctermbg=NONE

syntax enable

call plug#begin()

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
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
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({{ name = 'nvim_lsp' }})
  })

  lspconfig['rust_analyzer'].setup { capabilities = capabilities }
  lspconfig['ocamllsp'].setup { capabilities = capabilities }
  lspconfig['clangd'].setup { capabilities = capabilities }
EOF

