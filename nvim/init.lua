-- 设置 Neovim 运行时路径（环境变量已正确，但为了保险再设置一次）
vim.env.VIMRUNTIME = "/opt/nvim-linux-x86_64/share/nvim/runtime"

-- 添加 Neovim 运行时到 runtimepath
vim.opt.runtimepath:prepend("/opt/nvim-linux-x86_64/share/nvim/runtime")
vim.opt.runtimepath:prepend("/opt/nvim-linux-x86_64/lib/nvim")

-- 设置 Lua 模块路径
package.path = "/opt/nvim-linux-x86_64/share/nvim/runtime/lua/?.lua;" .. package.path
package.cpath = "/opt/nvim-linux-x86_64/lib/nvim/?.so;" .. package.cpath

-- 自动安装 Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
require("config/options")
vim.api.nvim_set_keymap("n", "H", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "L", "<Nop>", { noremap = true })
-- 配置 LazyVim
require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- 添加一些常用的扩展（可选）
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.ui.mini-animate" },
	},
	defaults = {
		lazy = false,
		version = false,
	},
	install = {
		colorscheme = { "tokyonight", "habamax" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
