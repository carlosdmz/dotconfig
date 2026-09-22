call plug#begin()
	Plug 'tpope/vim-sensible' " sets some normal standards
	Plug 'sheerun/vim-polyglot' " language packs
	Plug 'vim-syntastic/syntastic' " syntax checkings
	Plug 'ctrlpvim/ctrlp.vim' " file finder
	Plug 'raimondi/delimitmate' " auto closing brackets/quotes/...
	Plug 'vimjas/vim-python-pep8-indent' " python indentation
	Plug 'vim-airline/vim-airline' " status bar
	Plug 'vim-airline/vim-airline-themes' "status bar theme
	Plug 'junegunn/fzf', " Fuzzyfinder
	Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } } " Fuzzyfinder for vim
	Plug 'nvim-lua/plenary.nvim'
	Plug 'neovim/nvim-lspconfig' "Native LSP
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'rmagatti/goto-preview'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
	Plug 'preservim/nerdtree'
	Plug 'xero/evangelion.nvim'
	Plug 'morhetz/gruvbox'
	Plug 'altercation/vim-colors-solarized'
	Plug 'craftzdog/solarized-osaka.nvim'
	Plug 'fcpg/vim-fahrenheit'
	Plug 'catppuccin/nvim'
	Plug 'night-runner/nightrunner.vim'
  Plug 'folke/todo-comments.nvim'
call plug#end()

" Basic VIM configuration
syntax   enable
filetype plugin indent on

set mouse=a
set guicursor=
set nu rnu
set nohlsearch
set hidden

set smarttab
set tabstop=4
set shiftwidth=4
set smartindent

set autoread
set list
set nowrap
set noswapfile
set nobackup
set scrolloff=8
set ruler
set textwidth=150
set colorcolumn=80,120
set nocursorline
set completeopt=

set background=dark
colorscheme gruvbox

" Whitespace detection
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Set tab config for specific filetypes
autocmd Filetype yaml  setlocal tabstop=2 shiftwidth=2
autocmd Filetype json  setlocal tabstop=2 shiftwidth=2
autocmd Filetype js    setlocal tabstop=2 shiftwidth=2
autocmd Filetype ts    setlocal tabstop=2 shiftwidth=2
autocmd Filetype vim   setlocal tabstop=2 shiftwidth=2
autocmd Filetype scala setlocal tabstop=2 shitfwidth=2

" Copilot settings
au BufNewFile,BufRead * let b:copilot_enabled = 0
let g:copilot_node_command = "~/.nvm/versions/node/v20.11.1/bin/node"

let g:mapleader = "\<Space>"

" Ctrl Enter - new line
:nmap <C-cr> i<cr><Esc>

" Normal mode after pressing jk rapidly on input mode
inoremap    jk <ESC>

" Replace a char on the cursor's position
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" cycle through buffers
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>
map <leader>d :bdelete<cr>

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" FZF mappings
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
let g:fzf_nvim_statusline = 0 " disable statusline overwriting
" Search terms in file names
nnoremap <silent> <leader><space> :Files<CR>
" Search terms on buffers
nnoremap <silent> <leader>a :Buffers<CR>
" Search terms on windows
nnoremap <silent> <leader>A :Windows<CR>
" Search terms on lines
nnoremap <silent> <leader>; :BLines<CR>
" Search terms on BTags
nnoremap <silent> <leader>o :BTags<CR>
" Search terms on Tags
nnoremap <silent> <leader>O :Tags<CR>
" Search terms file names on history
nnoremap <silent> <leader>? :History<CR>
" Search terms within files within all files in cwd and recursive
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
" Search terms within the file's directory
nnoremap <silent> <leader>. :AgIn

" Search with FZF bindings
nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>gf :GF?<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

" GOTO declarations bindings
nnoremap <leader>gd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap <leader>gt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap <leader>gi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap <leader>gD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
nnoremap <leader>gp <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap <leader>gr <cmd>lua require('goto-preview').goto_preview_references()<CR>

" Go to tab by number bindings
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

imap <C-x><C-f> <Plug>(fzf-complete-file-ag)
imap <C-x><C-l> <Plug>(fzf-complete-line)

function! SearchWordWithAg()
execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
	let old_reg = getreg('"')
	let old_regtype = getregtype('"')
	let old_clipboard = &clipboard
	set clipboard&
	normal! ""gvy
	let selection = getreg('"')
	call setreg('"', old_reg, old_regtype)
	let &clipboard = old_clipboard
	execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
	call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

lua << EOF
	-- goto preview
	require('goto-preview').setup {
		width = 120, -- Width of the floating window
		height = 15, -- Height of the floating window
		border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}, -- Border characters of the floating window
		default_mappings = false, -- Bind default mappings
		debug = false, -- Print debug information
		opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
		resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
		post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
		post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
		references = { -- Configure the telescope UI for slowing the references cycling window.
			telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
		},
		-- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
		focus_on_open = true, -- Focus the floating window when opening it.
		dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
		force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
		bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
		stack_floating_preview_windows = true, -- Whether to nest floating windows
		preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
		zindex = 1, -- Starting zindex for the stack of floating windows
	}

	local function get_python_path()

		-- Check for .venv directory (common for virtualenv/venv)
		local venv_path = "/.venv/bin/python"
		if vim.fn.executable(venv_path) == 1 then
			return venv_path
		end

		-- Fallback: Use pyenv's global Python
		return vim.fn.system("pyenv which python"):gsub("%s+", "")
	end

	-- todo comments detection
	require("todo-comments").setup {}

	-- Enable some language servers with the additional completion capabilities offered by nvim-cmp

	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	local servers = { 'clangd', 'rust_analyzer', 'gopls', 'metals', 'pyright' }

	for _, server in ipairs(servers) do
		vim.lsp.enable(server)
	end

	vim.lsp.config('pyright', {
		settings = {
			python = {
				-- Use the dynamically detected Python path
				pythonPath = get_python_path(),
				-- Optional: Configure type checking strictness
				analysis = {
					typeCheckingMode = "basic",  -- Options: "off", "basic", "strict"
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
				},
			},
		},
	})

	vim.lsp.config('rust_analyzer', {
		settings = {
			['rust-analyzer'] = {},
		},
	})

	vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Hover shows information about symbol like type
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        -- Diagnostics show the errors only
        vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end
    }
	)

	local cmp = require('cmp')

	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)  -- Use luasnip for snippets
			end,
		},
		window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
		mapping = {
			['<C-Space>'] = cmp.mapping.complete(),  -- Trigger completion
			['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
		},
		sources = {
			{ name = 'nvim_lsp' },  -- Use LSP as a source
			{ name = 'buffer' },
		},
	})

	vim.diagnostic.config({
		virtual_text = true,
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = false,
		float = true,
	})
EOF
