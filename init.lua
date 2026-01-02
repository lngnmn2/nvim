-- Set leader BEFORE anything else (prevents plugins from using default \)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- bad idea unless nvum starts in a project directory
-- vim.cmd[[ set path+=** ]]

local options = {
  -- encodings
  encoding='utf-8',
  fileencoding = 'utf-8',
  fileencodings = { 'utf-8', 'latin1' },

  -- Interface
  termguicolors = true,
  mouse = "a",
  number = true,
  relativenumber = true,
  numberwidth = 2,
  signcolumn = "auto",
  showmode = false,
  laststatus = 0,
  modeline = false,
  cmdheight = 1,
  cursorline = true,
  winborder = "rounded",

  -- Behavior
  incsearch = true,
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  gdefault = true,
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  undofile = true,

  spell=false, -- not in prog modes

  wildmenu = true,
  complete = ".,w,b,u,t,i,spell",
  completeopt = { "menu", "menuone", "popup", "noinsert", "preview" },

  -- Tabs & Indent
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,

  -- Visuals
  list = true,
  showcmd = true,
  showmatch = true,
}

for k, v in pairs(options) do vim.opt[k] = v end

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

vim.cmd.filetype("plugin indent on")

-- a simple helper to avoid repetition
local function add(urls, opts)
  opts = opts or {}
  local plugins = type(urls) == "table" and urls or { urls }
  vim.pack.add(plugins, vim.tbl_extend("force", { confirm = false }, opts))
end

-- UI & Icons
add("https://github.com/nvim-lua/plenary.nvim")
add("https://github.com/nvim-tree/nvim-web-devicons")
add("https://github.com/lukas-reineke/indent-blankline.nvim")

-- Themes
add("https://github.com/folke/tokyonight.nvim")
add("https://github.com/catppuccin/nvim", { load = false })
add("https://github.com/ellisonleao/gruvbox.nvim", { load = false })

-- markdown support for LLMs
add("https://github.com/MeanderingProgrammer/render-markdown.nvim")

-- basic LaTeX support
add("https://github.com/lervag/vimtex") -- a filetype plugin

-- Treesitter & Languages
add("https://github.com/nvim-treesitter/nvim-treesitter", { version = 'main' })
add("https://github.com/nvim-treesitter/nvim-treesitter-textobjects", { version = 'main'} )
add("https://github.com/folke/ts-comments.nvim")
add("https://github.com/windwp/nvim-ts-autotag")

-- snippets (to be used with mini-snippets)
add("https://github.com/honza/vim-snippets")
add("https://github.com/rafamadriz/friendly-snippets.git")

-- LSP & Tools
add("https://github.com/neovim/nvim-lspconfig")
add("https://github.com/stevearc/conform.nvim")
add("https://github.com/mfussenegger/nvim-lint")
add("https://github.com/saghen/blink.cmp")
add("https://github.com/j-hui/fidget.nvim")
add("https://github.com/rachartier/tiny-inline-diagnostic.nvim")
add("https://github.com/lewis6991/gitsigns.nvim")
add("https://github.com/RRethy/vim-illuminate")
add("https://github.com/ibhagwan/fzf-lua")

-- Mini Modules (Grouped)
add({
  "https://github.com/nvim-mini/mini.basics",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.completion",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/nvim-mini/mini.doc",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.snippets",
  "https://github.com/nvim-mini/mini.pick",
}, { load = true })

-- Workflow & AI
add("https://github.com/m4xshen/hardtime.nvim")
add("https://github.com/folke/flash.nvim")
add("https://github.com/folke/which-key.nvim")

-- Copilot (without mason)
add("https://github.com/copilotlsp-nvim/copilot-lsp")
add("https://github.com/zbirenbaum/copilot.lua")
add("https://github.com/fang2hou/blink-copilot")

add("https://github.com/kdheepak/panvimdoc")
add("https://github.com/olimorris/codecompanion.nvim")

-- Language Specific Extras
add("https://github.com/neovimhaskell/haskell-vim")
add("https://github.com/tarides/ocaml.nvim")
add("https://github.com/ionide/Ionide-vim")
add("https://github.com/mrcjkb/rustaceanvim")
add("https://github.com/cordx56/rustowl")
add("https://github.com/Saecki/crates.nvim")

-- Testing
add("https://github.com/antoinemadec/FixCursorHold.nvim")
add("https://github.com/nvim-neotest/nvim-nio")
add("https://github.com/nvim-neotest/neotest")
add("https://github.com/nvim-neotest/neotest-plenary")
add("https://github.com/nvim-neotest/neotest-python")
add("https://github.com/rouge8/neotest-rust")
add("https://github.com/alfaix/neotest-gtest")
add("https://github.com/stevanmilic/neotest-scala")
add("https://github.com/mrcjkb/neotest-haskell")
add("https://github.com/nvim-neotest/neotest-vim-test")

-- Treesitter
require("nvim-treesitter").setup({
-- a kludge
  condig = function()
  local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
  parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = { 'src/parser.c', 'src/scanner.c' },
  },
    filetype = 'org',
  }
end,
  ensure_installed = { "org", "markdown", "toml", "json", "bash", "make", "lua", "ocaml", "fsharp", "rust", "c", "cmake", "cpp", "python", "scala", "haskell" },
  highlight = { enable = true },
  indent = { enable = true },
  auto_install = true,
  textobjects = {
    select = { enable = true, lookahead = true, include_surrounding_whitespace = true },
  },
})
vim.opt.foldmethod, vim.opt.foldexpr, vim.opt.foldlevel = "expr", "nvim_treesitter#foldexpr()", 99

-- UI Modules
require("nvim-web-devicons").setup()
require("ibl").setup({})
require("gitsigns").setup({ signcolumn = false })
require("fidget").setup({})

-- proper diagnostics
require("tiny-inline-diagnostic").setup({ preset = "simple" })

-- Mini.nvim
local mini_modules = { "basics", "icons", "ai", "pairs", "hipatterns", "completion", "diff", "doc", "snippets", "pick" }
for _, mod in ipairs(mini_modules) do require("mini." .. mod).setup({}) end

-- where to find snippets
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

require("fzf-lua").setup({})

-- mardown support
require('render-markdown').setup({
  -- ft = { "markdown", "codecompanion" },
  preset = 'lazy',
  code = {
    enabled = true,
    sign = false,
    width = "block",
    right_pad = 1
  },
  heading = {
    sign = false,
  },
  checkbox = {
    enabled = false,
  },
  restart_highlighter = true,
  completions = { lsp = { enabled = true } },
})

-- a kludge
vim.opt.encoding='utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = { 'utf-8', 'latin1' }

vim.lsp.config('*', { capabilities = {
  general = {
      positionEncodings = { 'utf-16', 'utf-8' }, -- the prefered order
  },},})

-- LSP Config & Diagnostics
vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = true },
  virtual_text = false,
  inlay_hint = true,
})

-- Copilot first
require('copilot-lsp').setup({})
require("copilot").setup({})
require('blink-copilot').setup({})

-- Blink Completion
require("blink.cmp").setup({
  sources = {
     default = { "lsp", "buffer", "omni", "copilot", "codecompanion", "snippets" },
     providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          async = true,
        },
     },
  },
  snippets = { preset = "mini_snippets" },
  fuzzy = { implementation = "lua" },
  appearance = { use_nvim_cmp_as_default = false },
  cmdline = { sources = { "cmdline" } },
  completion = { documentation = { auto_show = true } },
  signature = { enabled = true, window = { border = "rounded" } },
})

-- Testing
require("neotest").setup({
  adapters = {
    require("neotest-plenary"),
    require("neotest-python"),
    require("neotest-rust"),
    require("neotest-gtest").setup({}),
    require("neotest-scala")({
      args = "--no-color",
      runner = "bloop",
      framework = "scalatest",
    }),
    require("neotest-haskell"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})
-- Formatter & Linter
require("conform").setup({
  default_format_opts = { lsp_format = "fallback" },
  formatters_by_ft = {
    sh = { "shfmt" },
    lua = { "stylua" },
    python = { "ruff" },
    rust = { "rustfmt" },
    ocaml = { "ocamlformat" },
    fsharp = { "fantomas" },
    javascript = { "prettierd", stop_after_first = true },
  },
})

require("lint").linters_by_ft = { sh = { "shellcheck" }, lua = { "selene" } }
vim.api.nvim_create_autocmd("BufWritePost", { callback = function() require("lint").try_lint() end })

-- LSP Servers (0.12 optimized)
local servers = { "bashls", "pyright", "ccls", "ocamllsp", "fsautocomplete", "copilot" }
for _, srv in ipairs(servers) do vim.lsp.enable(srv) end

vim.lsp.inlay_hint.enable(true)

vim.lsp.config["lua_ls"] = {
  settings = { Lua = {
    diagnostics = { globals = { "vim" } },
    workspace = {
      checkThirdParty = false,
      library = vim.api.nvim_get_runtime_file("", true),
  } },
    codelens = { enabled = true } }
}
vim.lsp.enable("lua_ls")

vim.lsp.config["rust_analyzer"] = { settings = { codelens = { enabled = true } } }
vim.lsp.enable("rust_analyzer")

require("crates").setup({})
require('rustowl').setup()

vim.lsp.config["hls"] = { settings = { codelens = { enabled = true } } }
vim.lsp.enable("hls")

vim.lsp.enable("markdown_oxide")

-- LaTeX
vim.lsp.enable("texlab")

-- AI
require("codecompanion").setup({
  interactions = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "copilot",
    },
    cmd = {
      adapter = "gemini",
      model = "gemini-3-pro",
    }
  },
})

-- Keys
require("hardtime").setup({})
require("which-key").setup({})

-- Themes
require("tokyonight").setup({ style = "moon", transparent = true })
vim.cmd.colorscheme("tokyonight")

