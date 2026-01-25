-- Modern Neovim configuration inspired by jdhao/nvim-config
-- Matching GTK dark theme with transparent background
-- Save to: ~/.config/nvim/init.lua

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key must be set before lazy
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- ============================================================================
-- Core settings
-- ============================================================================
local opt = vim.opt

-- Editor behavior
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"
opt.showmode = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 3
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "↪ "

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true

-- Files
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 15
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Performance
opt.updatetime = 300
opt.timeoutlen = 400
opt.redrawtime = 1500
opt.lazyredraw = true

-- Colors
opt.termguicolors = true
opt.background = "dark"

-- File encoding
opt.fileencoding = "utf-8"
opt.fileencodings = "utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1"

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Mouse
opt.mouse = "a"
opt.mousemodel = "popup"

-- Misc
opt.hidden = true
opt.errorbells = false
opt.visualbell = true
opt.history = 2000
opt.synmaxcol = 250
opt.virtualedit = "block"
opt.formatoptions = "1jcroql"

-- ============================================================================
-- Key mappings
-- ============================================================================
local keymap = vim.keymap

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
keymap.set("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>d", ":bdelete<CR>", { desc = "Delete buffer" })

-- Save and quit
keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit window" })
keymap.set("n", "<leader>Q", ":quitall<CR>", { desc = "Quit all" })

-- Clear search highlight
keymap.set("n", "<leader><space>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better paste
keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Toggle options
keymap.set("n", "<F11>", ":set spell!<CR>", { desc = "Toggle spell check" })
keymap.set("n", "<F12>", ":set paste!<CR>", { desc = "Toggle paste mode" })
keymap.set("n", "<leader>cl", ":set cursorcolumn!<CR>", { desc = "Toggle cursor column" })

-- Edit and reload config
keymap.set("n", "<leader>ev", ":tabnew $MYVIMRC<CR>", { desc = "Edit Nvim config" })
keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "Reload Nvim config" })

-- Copy whole buffer
keymap.set("n", "<leader>y", ":%y+<CR>", { desc = "Copy entire buffer" })

-- Change directory
keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { desc = "Change to buffer directory" })

-- Better insert mode navigation
keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Text case conversion
keymap.set("i", "<C-u>", "<Esc>viwUea", { desc = "Uppercase word" })
keymap.set("i", "<C-t>", "<Esc>b~lea", { desc = "Title case word" })

-- ============================================================================
-- Plugin setup
-- ============================================================================
require("lazy").setup({
  -- Transparent background
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "TelescopeNormal",
        "TelescopeBorder",
        "WhichKeyFloat",
        "FzfLuaNormal",
        "FzfLuaBorder",
      },
    },
  },

  -- Gruvbox Material colorscheme
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_better_performance = 1

      vim.g.gruvbox_material_colors_override = {
        bg0 = { "#131519", "234" },
        bg1 = { "#171a1f", "235" },
        bg2 = { "#22262d", "236" },
        bg3 = { "#1a1c22", "237" },
        fg0 = { "#e0e0e0", "223" },
        fg1 = { "#e0e0e0", "223" },
        grey0 = { "#7c7d80", "245" },
        grey1 = { "#b7b8b9", "246" },
        grey2 = { "#7c7d80", "245" },
        aqua = { "#9bbfbf", "108" },
        blue = { "#458588", "109" },
        green = { "#8ec07c", "142" },
        orange = { "#f37329", "208" },
        purple = { "#b16286", "175" },
        red = { "#cd3520", "167" },
        yellow = { "#f9c440", "214" },
      }

      vim.cmd.colorscheme("gruvbox-material")

      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#22262d" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#9bbfbf", bold = true })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#22262d" })
      vim.api.nvim_set_hl(0, "Search", { bg = "#9bbfbf", fg = "#131519" })
      vim.api.nvim_set_hl(0, "IncSearch", { bg = "#f37329", fg = "#131519" })
      vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1a1c22" })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "clangd",
          "bashls",
          "jsonls",
          "yamlls",
          "marksman",
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end

      local servers = { "lua_ls", "pyright", "rust_analyzer", "clangd", "bashls", "jsonls", "yamlls", "marksman" }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "python", "rust", "c", "cpp", "bash",
          "json", "yaml", "toml", "markdown", "markdown_inline", "vim", "vimdoc",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = {
          normal = {
            a = { bg = "#9bbfbf", fg = "#000000", gui = "bold" },
            b = { bg = "#22262d", fg = "#e0e0e0" },
            c = { bg = "NONE", fg = "#e0e0e0" },
          },
          insert = { a = { bg = "#8ec07c", fg = "#000000", gui = "bold" } },
          visual = { a = { bg = "#b16286", fg = "#000000", gui = "bold" } },
          replace = { a = { bg = "#cd3520", fg = "#ffffff", gui = "bold" } },
          command = { a = { bg = "#f9c440", fg = "#000000", gui = "bold" } },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" } },
    opts = {
      view = { width = 35, side = "left" },
      renderer = {
        group_empty = true,
        icons = { show = { git = true, folder = true, file = true, folder_arrow = true } },
      },
      filters = { dotfiles = false, custom = { "^.git$" } },
    },
  },

  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep text" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Find help" },
      { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
    },
    opts = {
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = { border = "rounded", horizontal = "right:50%" },
      },
    },
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { window = { border = "rounded" } },
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      }
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":FzfLua files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":FzfLua oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":FzfLua live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      return dashboard
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },

  -- Notification
  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function() require("notify").dismiss({ silent = true, pending = true }) end,
        desc = "Dismiss notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require("notify")
    end,
  },

  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gw" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
      { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git add" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gpl", "<cmd>Git pull<cr>", desc = "Git pull" },
      { "<leader>gpu", "<cmd>Git push<cr>", desc = "Git push" },
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { lua = { "string" }, javascript = { "template_string" } },
    },
  },

  -- Surround
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  -- Comment
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment line" },
      { "gc", mode = { "n", "o", "x" }, desc = "Comment region" },
    },
    opts = {},
  },

  -- Better escape
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    opts = { mapping = { "jk" }, timeout = 200 },
  },

  -- Hop (fast cursor movement)
  {
    "phaazon/hop.nvim",
    keys = {
      { "s", "<cmd>HopChar2<cr>", desc = "Hop to 2 chars" },
      { "S", "<cmd>HopWord<cr>", desc = "Hop to word" },
    },
    opts = { keys = "etovxqpdygfblzhckisuran" },
  },
}, {
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "gruvbox-material" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
