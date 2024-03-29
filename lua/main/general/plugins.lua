local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    print "Installing packer, close and reopon Neovim ..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save plugins.lua
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so won't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- packer popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install plugins
return packer.startup(function(use)
    -- Put all plugins under this line
    -- packer
    use "wbthomason/packer.nvim"
    -- colourscheme, ui
    use "KeitaNakamura/neodark.vim"
    use "goolord/alpha-nvim"
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"
    use "mortepau/codicons.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "MunifTanjim/nui.nvim"
    -- completetion, snippet
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"
    -- lsp
    use "neovim/nvim-lspconfig"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    -- file, fuzzy
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', } -- telescope
    use "nvim-telescope/telescope-file-browser.nvim"
    use "nvim-telescope/telescope-fzf-native.nvim"
    use "kevinhwang91/rnvimr" -- ranger
    use { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", } -- neotree
    -- code editting
    use "windwp/nvim-autopairs" -- autopairs
    use "nvim-treesitter/nvim-treesitter"
    use "Yggdroot/indentLine" -- identLine
    use "stevearc/aerial.nvim"
    use "dag/vim-fish"
    -- buffer, status
    use "nvim-lualine/lualine.nvim" -- lualine
    use "akinsho/bufferline.nvim" -- bufferline
    use "kazhala/close-buffers.nvim"
    use "akinsho/toggleterm.nvim" -- toggleterm
    -- git
    use "tpope/vim-fugitive" -- fugitive
    use "kdheepak/lazygit.nvim" -- lazygit
    -- language
    use "iamcco/markdown-preview.nvim"

    -- Automcatically setup configuration after cloning packer.nvim, put this after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
