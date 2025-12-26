vim.g.encoding = "utf-8"
vim.g.fileencoding = "utf-8"
vim.g.termencoding = "utf-8"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.opt.mouse = "a"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.signcolumn = "auto"

vim.opt.showmode = false
vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.modeline = false

vim.opt.cursorline = true

vim.opt.hlsearch = true
vim.opt.list = true

vim.opt.autoindent = true
vim.cmd.filetype("plugin indent on")

vim.opt.wrap = false
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

vim.opt.spelllang = "en_gb"

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
vim.opt.undofile = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

vim.lsp.inlay_hint.enable(true)

vim.opt.autocomplete = true
vim.opt.completeopt = { "fuzzy", "menuone", "popup", "noinsert", "preview" }
vim.opt.winborder = "rounded"

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
}, { load = true, confirm = false })

vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
}, { load = true, confirm = false })
require("nvim-web-devicons").setup()

-- vim.pack.add({ "https://github.com/MunifTanjim/nui.nvim", }, { load = false, confirm = false })

vim.pack.add(
  { "https://github.com/lukas-reineke/indent-blankline.nvim.git" },
  { confirm = false }
)
require("ibl").setup({})

-- tree-sitter first
vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
}, { load = true, confirm = false })

vim.pack.add({
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
    version = "main",
  },
}, { load = true, confirm = false })

require("nvim-treesitter").setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      include_surrounding_whitespace = true,
    },
  },
  sync_install = false,
  auto_install = true,
  indent = { enable = true },
  highlight = { enable = true },
  folds = { enable = true },
})
require("nvim-treesitter").install({ "sh", "rust", "c++", "python", "lua" })
require("nvim-treesitter.install").update("all")

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.pack.add(
  { "https://github.com/folke/ts-comments.nvim" },
  { load = true, confirm = false }
)

vim.pack.add(
  { "https://github.com/windwp/nvim-ts-autotag" },
  { load = true, confirm = false }
)
require("nvim-ts-autotag").setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
})

-- selected mini plugins
vim.pack.add({
  "https://github.com/nvim-mini/mini.basics.git",
  "https://github.com/nvim-mini/mini.ai.git",
  "https://github.com/nvim-mini/mini.pairs.git",
  "https://github.com/nvim-mini/mini.hipatterns.git",
  "https://github.com/nvim-mini/mini.completion.git",
  "https://github.com/nvim-mini/mini.doc.git",
  "https://github.com/nvim-mini/mini.snippets.git",
  "https://github.com/nvim-mini/mini.pick.git",
}, { load = true, confirm = false })

require("mini.basics").setup({})
require("mini.pairs").setup({})
require("mini.ai").setup({})
require("mini.hipatterns").setup({})
require("mini.completion").setup({})
require("mini.doc").setup({})
require("mini.pick").setup({})

vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
}, { load = true, confirm = false })

require("tokyonight").setup({
  style = "moon",
  terminal_colors = true,
  transparent = true,
})

vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
}, { load = false, confirm = false })

vim.pack.add({ "https://github.com/catppuccin/nvim" }, { confirm = false })

vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})
require("gitsigns").setup({ signcolumn = false })

-- linting
vim.pack.add(
  { "https://github.com/mfussenegger/nvim-lint" },
  { confirm = false }
)
require("lint").linters_by_ft = {
  sh = { "shellcheck" },
  fish = { "fish" },
  lua = { "selene" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

-- testing
vim.pack.add(
  { "https://github.com/antoinemadec/FixCursorHold.nvim" },
  { load = true, confirm = false }
)
vim.pack.add(
  { "https://github.com/nvim-neotest/nvim-nio" },
  { load = false, confirm = false }
)
vim.pack.add({
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/neotest-plenary",
  "https://github.com/nvim-neotest/neotest-python",
  "https://github.com/rouge8/neotest-rust",
  "https://github.com/alfaix/neotest-gtest",
  "https://github.com/mrcjkb/neotest-haskell",
  "https://github.com/stevanmilic/neotest-scala",
}, { load = false, confirm = false })
require("neotest").setup({
  adapters = {
    require("neotest-plenary"),
    require("neotest-rust"),
    require("neotest-python"),
    require("neotest-gtest").setup({}),
    require("neotest-scala")({
      -- Command line arguments for runner
      -- Can also be a function to return dynamic values
      args = { "--no-color" },
      -- Possibly values bloop|sbt.
      runner = "bloop",
      -- Possibly values utest|munit|scalatest.
      framework = "scalatest",
    }),
  },
})

vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
})
require("fzf-lua").setup({})

-- lspconfig
vim.pack.add(
  { "https://github.com/neovim/nvim-lspconfig" },
  { confirm = false }
)

vim.diagnostic.config({
  underline = true,
  severity_sort = true,
  update_in_insert = false, -- less flicker
  float = {
    border = "rounded",
    source = true,
  },
  virtual_text = false,
  --virtual_text = { source = "if_many" }
  inlay_hints = { enabled = true },
  folds = { enabled = true },
})

vim.pack.add({ "https://github.com/j-hui/fidget.nvim" }, { confirm = false })
require("fidget").setup({})

vim.pack.add(
  { "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
  { confirm = false }
)
require("tiny-inline-diagnostic").setup({
  preset = "simple",
})

-- Lua first
vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      codeLens = { enabled = true },
    },
  },
}

vim.lsp.enable("lua_ls")

vim.lsp.enable("bashls")

-- blink
vim.pack.add({ "https://github.com/saghen/blink.cmp" }, { confirm = false })
require("blink.cmp").setup({
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "normal",
  },
  sources = {
    default = { "lsp", "snippets", "buffer" },
  },
  signature = {
    enabled = true,
    window = {
      border = "rounded",
    },
  },
  completion = { documentation = { auto_show = true } },
  fuzzy = { implementation = "lua" },
})

-- conform
vim.pack.add(
  { "https://github.com/stevearc/conform.nvim" },
  { confirm = false }
)
require("conform").setup({
  default_format_opts = { lsp_format = "fallback" },
  formatters_by_ft = {
    sh = { "shfmt" },
    lua = { "stylua" },
    python = { "ruff" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
  },
  formatters = { injected = { options = { ignore_errors = true } } },
})

-- Python
vim.lsp.enable("pyright")

-- Rust
vim.pack.add({ "https://github.com/mrcjkb/rustaceanvim" }, { confirm = false })
vim.lsp.config["rust_analyzer"] = {
  settings = {
    codeLens = { enabled = true },
  },
}

vim.lsp.enable("rust_analyzer")

vim.pack.add(
  { "https://github.com/Saecki/crates.nvim.git" },
  { confirm = false }
)
require("crates").setup({})

-- copilot
vim.pack.add(
  { "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
  { load = true, confirm = false }
)
require("CopilotChat").setup()

vim.pack.add(
  { "https://github.com/zbirenbaum/copilot.lua.git" },
  { load = true, confirm = false }
)
require("copilot").setup({})

vim.lsp.enable("copilot")

-- companion
vim.pack.add(
  { "https://github.com/olimorris/codecompanion.nvim.git" },
  { confirm = false }
)

vim.pack.add(
  { "https://github.com/OXY2DEV/markview.nvim" },
  { confirm = false }
)
require("markview").setup({
  preview = {
    filetypes = { "markdown", "codecomanion" },
    ignore_buftypes = {},
  },
})

vim.pack.add({ "https://github.com/folke/flash.nvim" }, { confirm = false })

-- hardtime
vim.pack.add(
  { "https://github.com/m4xshen/hardtime.nvim" },
  { confirm = false }
)
require("hardtime").setup({})

-- probably has to be loaded last (to catch all the key bindings)
vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { confirm = false })
require("which-key").setup({})

vim.cmd.colorscheme("tokyonight")

-- vim.pack.update()
