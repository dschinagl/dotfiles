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
            }
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
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = false,
                    auto_trigger = true,
                },
                panel = {
                    enalbled = flase,
                },
            })
        end,
    },
    
    -- integrattion of copilot with nvim-cmp
    {
        "zbirenbaum/copilot-cmp",
        config = function ()
            require("copilot_cmp").setup()
        end
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
                    completeopt = "menu,menuone,noinsert",
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
                    { name = 'copilot' },
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
                            copilot = "[CP]",
                        })[entry.source.name]
                        return vim_item
                    end
                },
                mapping = {
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                },
            }
        end,
    },
}

local opts = {}

require("lazy").setup(plugins, opt)
