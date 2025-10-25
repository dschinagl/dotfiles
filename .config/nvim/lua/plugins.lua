-- Lazy Plugin Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- PLUGINS
local plugins = {
    
    -----------------------------------------------------------------
    ---------------------------- General ----------------------------
    -----------------------------------------------------------------
    
    -- asynchronous I/O operations in Neovim.
    "nvim-neotest/nvim-nio",
    

    -----------------------------------------------------------------
    ---------------------------- UI ---------------------------------

    
    -- File Explorer
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            renderer = {
                highlight_modified = "icon"
            },
            git = {
                ignore = false
            },
            filters = {
                custom = { "__pycache__", ".DS_Store", ".git" },
            },
        }        
    },
    
    -- Bottom Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                theme = "OceanicNext",
                component_separators = '|',
                section_separators = '',
            }
        }
    },
    
    -- helper to visualize key mappings
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },


    -----------------------------------------------------------------
    ---------------------- Search / Navigate-------------------------
    -----------------------------------------------------------------
    
    -- Fuzzy Finder over Lists
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    
    -- Flash for fast searching 
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        },
    },

    -----------------------------------------------------------------
    -------- Syntax / Parsing / Code Intelligence -------------------
    -----------------------------------------------------------------

    -- Parsing library to create syntax tree
    {
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "python", "lua", "latex", "bibtex", "bash", "dockerfile", "markdown"},
                sync_install = false,
                auto_install = true,
                highlight = { 
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { 
                    enable = true
                },
            }
        end
    },
    
    -- show lines for indent visualization
    {
        "lukas-reineke/indent-blankline.nvim",
        main="ibl",
        opts={
            indent = { char = "▏" },
            scope = {show_start = false, enabled = true},
        },
    },
    
    -- Helper for fast commenting
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup {
                mappings = {
                    basic = true,
                    extra = false 
                }
            }
        end
    },


    -----------------------------------------------------------------
    ----------------------- Git Integration -------------------------
    -----------------------------------------------------------------
    
    -- Buffer Integration
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },
    

    -----------------------------------------------------------------
    ----------------------------- LSP--- ----------------------------
    -----------------------------------------------------------------
    
    -- LSP server installing and management 
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup {
                ensure_installed = {"debugpy"}
            }
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"pyright", "texlab"}
            })
        
            -- Optional: capabilities from nvim-cmp if present
            local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
            if ok then
                vim.lsp.config("*", {
                    capabilities = cmp_lsp.default_capabilities(),
                })
            end

            vim.lsp.enable({ "pyright", "texlab" })
        end,
    },
    {
        "neovim/nvim-lspconfig",
    },
    
    -- LSP status notifications
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {},
    },
    

    -----------------------------------------------------------------
    -------------------------- Autocompletion -----------------------
    -----------------------------------------------------------------
    
    -- copilot plugin
    {
        "github/copilot.vim",
        event = "BufEnter",
        autoStart = true,
        config = function()
            vim.keymap.set("i", "<C-j>", function()
            return vim.fn["copilot#Accept"]("<CR>")
            end, { expr = true, silent = true, noremap = true, replace_keycodes = false })
            vim.g.copilot_no_tab_map = true
        end,
    },

    -- vimtex
    {
        "lervag/vimtex",
        ft = { "tex", "plaintex", "latex" },
        init = function()
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_view_skim_sync = 1
        vim.g.vimtex_view_skim_activate = 1
        vim.g.vimtex_view_skim_reading_bar = 1
        vim.g.vimtex_compiler_method = "latexmk"
        end,
    },
    
    -- nvim-cmp for autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = 'InsertEnter',
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            'hrsh7th/cmp-cmdline',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp-signature-help'
        },
        config = function()
            local cmp = require("cmp")
            require("cmp").setup {
                completion = {
                    completeopt = "menu,noinsert",
                },
                window = {
                    completion = {
                        border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
                        winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                    },
                    documentation = {
                        border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
                        winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                    },
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = 'nvim_lsp_signature_help'}
                },
                formatting = {
                    format = function(entry, vim_item)
                        -- Source
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Lua]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<CR>"] = cmp.mapping.confirm({ select = true})
                },
            }
        end,
    },
}

local opts = {}

require("lazy").setup(plugins, opts)


