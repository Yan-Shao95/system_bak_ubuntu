-------------------------------------------------
-- ROS2 + Python + C++ 专用 Neovim 配置
-------------------------------------------------

-- ===============================
-- 基础 lazy.nvim 安装
-- ===============================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------
-- 基础设置
-------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-------------------------------------------------
-- 插件
-------------------------------------------------
require("lazy").setup({

  -- LSP
  { "neovim/nvim-lspconfig" },

  -- 自动补全
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },

  -- 语法高亮
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- 格式化 & lint
  { "nvimtools/none-ls.nvim" },

  -- 文件树
  { "nvim-tree/nvim-tree.lua" },

  -- 搜索
  { "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

})

-------------------------------------------------
-- LSP 配置
-------------------------------------------------
vim.lsp.enable("clangd")

-- 启用 pyright
vim.lsp.enable("pyright")

-------------------------------------------------
-- 自动补全配置
-------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }
})

-------------------------------------------------
-- Google 规范格式化
-------------------------------------------------
local null_ls = require("null-ls")

null_ls.setup({
  sources = {

    -- C++ Google Style
    null_ls.builtins.formatting.clang_format.with({
      extra_args = { "--style=Google" }
    }),

    -- Python
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.flake8,

  },
})

-- 保存自动格式化
vim.cmd([[
  augroup FORMAT
    autocmd!
    autocmd BufWritePre *.cpp,*.hpp,*.cc,*.py lua vim.lsp.buf.format()
  augroup END
]])

-------------------------------------------------
-- 快捷键
-------------------------------------------------

-- 文件树
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- 搜索
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")

-- 编译 ROS2
vim.keymap.set("n", "<leader>cb", ":terminal colcon build<CR>")

-------------------------------------------------
-- ROS2 clangd 支持提示
-------------------------------------------------
print("ROS2 Neovim 已加载 🚀")
