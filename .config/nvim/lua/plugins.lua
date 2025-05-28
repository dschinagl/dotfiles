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

    "nvim-treesitter/playground",
    "github/copilot.vim",
    "nvim-neotest/nvim-nio",

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
        }
    },

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
            }
        }        
    },

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
    
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    
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

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    },

    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings(true)
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main="ibl",
        opts={
            indent = { char = "▏" },
            scope = {show_start = false, enabled = true},
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    
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
            require("mason-lspconfig").setup {
                ensure_installed = {"pyright", "texlab"}
            }
        end,
    },
    
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig").pyright.setup{}
            require("lspconfig").texlab.setup{}
        end,
    },

    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {},
    },
    
    {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        config = function()
            require('toggle_lsp_diagnostics').init({start_on = false})
        end,
    },

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
                    completeopt = "menu,menuone,noselect",
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
                        })[entry.source.name]
                        return vim_item
                    end
                },
                mapping = {
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                },
            }
        end,
    },
}

local opts = {}

require("lazy").setup(plugins, opt)
