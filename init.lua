-- Set leader BEFORE anything else (prevents plugins from using default \)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
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
  hlsearch = true,
  ignorecase = true,
  smartcase = true,
  gdefault = true,
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  undofile = true,
  completeopt = { "fuzzy", "menu", "menuone", "popup", "noinsert", "preview" },

  -- Tabs & Indent
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  autoindent = true,

  -- Visuals
  list = true,
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

-- Treesitter & Languages
add("https://github.com/nvim-treesitter/nvim-treesitter", { version = 'main' })
add("https://github.com/nvim-treesitter/nvim-treesitter-textobjects", { version = 'main'} )
add("https://github.com/folke/ts-comments.nvim")
add("https://github.com/windwp/nvim-ts-autotag")

-- LSP & Tools
add("https://github.com/neovim/nvim-lspconfig")
add("https://github.com/stevearc/conform.nvim")
add("https://github.com/mfussenegger/nvim-lint")
add("https://github.com/saghen/blink.cmp")
add("https://github.com/j-hui/fidget.nvim")
add("https://github.com/rachartier/tiny-inline-diagnostic.nvim")
add("https://github.com/lewis6991/gitsigns.nvim")
add("https://github.com/ibhagwan/fzf-lua")

-- Mini Modules (Grouped)
add({
  "https://github.com/nvim-mini/mini.basics",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.hipatterns",
  "https://github.com/nvim-mini/mini.completion",
  "https://github.com/nvim-mini/mini.doc",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.snippets",
  "https://github.com/nvim-mini/mini.pick",
}, { load = true })

-- Workflow & AI
add("https://github.com/folke/flash.nvim")
add("https://github.com/folke/which-key.nvim")
add("https://github.com/zbirenbaum/copilot.lua")
add("https://github.com/CopilotC-Nvim/CopilotChat.nvim")
add("https://github.com/m4xshen/hardtime.nvim")

-- Language Specific Extras
add("https://github.com/neovimhaskell/haskell-vim")
add("https://github.com/tarides/ocaml.nvim")
add("https://github.com/ionide/Ionide-vim")
add("https://github.com/mrcjkb/rustaceanvim")
add("https://github.com/Saecki/crates.nvim")

-- Treesitter
require("nvim-treesitter").setup({
  ensure_installed = { "sh", "lua", "ocaml", "fsharp", "rust", "cpp", "python", "scala", "haskell" },
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
local mini_modules = { "basics", "ai", "pairs", "hipatterns", "completion", "doc", "pick" }
for _, mod in ipairs(mini_modules) do require("mini." .. mod).setup({}) end

-- mardown support
require('render-markdown').setup({
  ft = { "markdown", "codecompanion" },
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

-- LSP Config & Diagnostics
vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  update_in_insert = false,
  float = { border = "rounded", source = true },
  virtual_text = false,
  inlay_hint = true,
})

-- Blink Completion
require("blink.cmp").setup({
  fuzzy = { implementation = "lua" },
  appearance = { use_nvim_cmp_as_default = true },
  sources = { default = { "lsp", "snippets", "buffer" } },
  completion = { documentation = { auto_show = true } },
  signature = { enabled = true, window = { border = "rounded" } },
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
vim.lsp.enable("hls")

vim.lsp.config["hls"] = { settings = { codelens = { enabled = true } } }

require("fzf-lua").setup({})
require("copilot").setup({})
require("CopilotChat").setup()
require("hardtime").setup({})
require("which-key").setup({})

-- Themes
require("tokyonight").setup({ style = "moon", transparent = true })
vim.cmd.colorscheme("tokyonight")

