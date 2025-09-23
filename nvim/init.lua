-- init.lua or in your Neovim configuration file

-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath('data')..'/site/pack/packer/start/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', lazypath
  })
end
-- Set runtime path for lazy.nvim
vim.opt.runtimepath:prepend(lazypath)
-- Setup lazy.nvim to manage your plugins
local plugins = {
  { "chentoast/marks.nvim", event = "VeryLazy", opts = {}, },
  { 'andymass/vim-matchup', opts = { treesitter = { stopline = 500, } } },
  { 'numToStr/Comment.nvim', opts = { } },
  { 'stevearc/oil.nvim', opts = {}, dependencies = { { "echasnovski/mini.icons", opts = {} } }, lazy = false, },
  { 'tpope/vim-sleuth' },
  { 'phaazon/hop.nvim', branch = 'v2', opts = {}, },
}
for _, theme in ipairs({
  "0xstepit/flow.nvim",
  "AlexvZyl/nordic.nvim",
  "Mofiqul/dracula.nvim",
  "Mofiqul/vscode.nvim",
  "datsfilipe/min-theme.nvim",
  "eldritch-theme/eldritch.nvim",
  "folke/tokyonight.nvim",
  "marko-cerovac/material.nvim",
  "navarasu/onedark.nvim",
  "olimorris/onedarkpro.nvim",
  "olivercederborg/poimandres.nvim",
  "rebelot/kanagawa.nvim",
  "ribru17/bamboo.nvim",
  "rmehri01/onenord.nvim",
  "tiagovla/tokyodark.nvim",
}) do
  table.insert(plugins, { theme, lazy = false, priority = 1000, opts = {}, })
end
require('lazy').setup(plugins)

local function includes(list, value)
  for _, v in ipairs(list) do
    if v == value then
      return true
    end
  end
  return false
end
_G.colorschemes = vim.fn.getcompletion('', 'color')
local doNotLike = {
  "bamboo",
  "blue",
  "shine",
  "tokyonight-day",
  "vim",
}
for i, v in ipairs(_G.colorschemes) do
  if includes(doNotLike, v) then
    table.remove(_G.colorschemes, i)
  end
end
_G.pickedColour = math.floor(os.time() / 1.8e6)
local function pickNextColour()
  _G.pickedColour = (_G.pickedColour + 1) % #(_G.colorschemes)
  vim.cmd.colorscheme(_G.colorschemes[_G.pickedColour])
  vim.cmd("colo")
end
pickNextColour()

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '-', pickNextColour, opts)

-- Remap 'jk' and 'kj' to 'Esc'
map('i', 'jk', '<Esc>', opts)
map('i', 'kj', '<Esc>', opts)

map('n', '<CR>', 'O<ESC>j', opts)
map('n', '<Space>', 'i <ESC>l', opts)

-- Remap leader + q to :qa!
map('n', '<Leader>q', ':qa!<CR>', opts)

-- Basic tab commands using <S-Tab> as a prefix
map("n", "<S-Tab>", ":tabe ", { noremap = true }) -- opens `:tabe` and lets you type the filename
map("n", "<S-Tab><Up>", ":tabnew<CR>", opts)
map("n", "<S-Tab><Down>", ":tabclose<CR>", opts)
map("n", "<S-Tab><Left>", ":tabprevious<CR>", opts)
map("n", "<S-Tab><Right>", ":tabnext<CR>", opts)
map("n", "<S-Tab>o", ":tabonly<CR>", opts)

-- Center search matches
map("n", "n", "nzz", opts)
map("n", "N", "Nzz", opts)

-- Window navigation
map("n", "<Leader>;", "<C-w>w", opts)
map("n", "<Leader><Leader>;", "<C-w>W", opts)

-- Search and replace with confirmation
map("n", "<C-g>", [[:%s//gc<Left><Left><Left>]], opts)
-- Replace word under cursor (normal mode)
map("n", "<C-h>", [[yiw:%s//gc<Left><Left><Left>\(\<<C-r>0\>\)/]], opts)
-- Replace all instances of word under cursor (normal mode)
map("n", "<C-h><C-h>", [[yiw:s//g<Left><Left>\(\<<C-r>0\>\)/]], opts)
-- Search and replace with confirmation
map("n", "<C-g>", [[:%s//gc<Left><Left><Left>]], opts)
-- Replace word under cursor (normal mode)
map("n", "<C-h>", [[yiw:%s//gc<Left><Left><Left>\(\<<C-r>0\>\)/]], opts)
-- Replace all instances of word under cursor (normal mode)
map("n", "<C-h><C-h>", [[yiw:s//g<Left><Left>\(\<<C-r>0\>\)/]], opts)
-- Replace in visual selection
map("v", "<C-h>", [[y:%s//gc<Left><Left><Left>\(<C-r>0\)/]], opts)
map("n", "*", "*N", opts)

-- Center after search
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)

-- Replace in visual selection
vim.keymap.set("v", "<C-h>", [[y:%s//gc<Left><Left><Left>\(<C-r>0\)/]], opts)

-- Center after search
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)

-- Insert mode completions
map("i", "<C-l>", "<C-x><C-l>", opts) -- line completion
map("i", "<C-f>", "<C-x><C-f>", opts) -- file completion

-- Toggle comment on current line
vim.keymap.set("n", "<Leader>c<Space>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment", noremap = true, silent = true })

-- Toggle comment in visual mode
vim.keymap.set("v", "<Leader>c<Space>", function()
  -- Use visual selection to toggle comment
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment", noremap = true, silent = true })

-- hop.nvim
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1()
end, {remap=true})

vim.cmd("cabbrev %% %:h")

vim.opt.mouse = ''
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3

vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.opt.statusline = "%m<%{winnr()}> %f %P:%c"

vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--------------------------------------------------------------------------------

vim.api.nvim_create_augroup("ActiveWindow", { clear = true })
vim.api.nvim_create_autocmd({ "WinEnter", "TabEnter" }, {
  group = "ActiveWindow",
  callback = function()
    vim.wo.relativenumber = true
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "TabLeave" }, {
  group = "ActiveWindow",
  callback = function()
    vim.wo.relativenumber = false
    vim.wo.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter" }, {
  group = "ActiveWindow",
  callback = function()
    vim.wo.cursorline = true
  end,
})

--------------------------------------------------------------------------------

vim.api.nvim_create_user_command("ToNewTab", function()
  vim.cmd("tabe %")
  vim.cmd("tabprevious")
  vim.cmd("quit")
  vim.cmd("tabnext")
end, { desc = "Open current file in new tab and close original window" })
vim.api.nvim_create_user_command("WW", function()
  if vim.wo.wrap then
    vim.wo.wrap = false
  else
    vim.wo.wrap = true
  end
end, { desc = "Toggle line wrapping" })

--------------------------------------------------------------------------------

-- Get the number of lines visible in the window
local function lines_from_top(top)
  if top then
    return vim.fn.winline() - 1
  end
  local start = vim.fn.winline()
  vim.cmd("normal! L")
  local finish = vim.fn.winline()
  vim.cmd("normal! ``")
  return finish - start + 1
end

-- Get the length of the longest line
local function longest_line(scope)
  local start_line, end_line
  if scope == "w" then
    start_line = vim.fn.line("w0")
    end_line = vim.fn.line("w$")
  else
    start_line = 1
    end_line = vim.fn.line("$")
  end

  local lines = vim.fn.getline(start_line, end_line)
  local maxlen = 0
  for _, line in ipairs(lines) do
    local len = vim.fn.strlen(line)
    if len > maxlen then maxlen = len end
  end
  return maxlen
end

-- Resize commands
local function resize_to_longest(scope)
  local len = longest_line(scope)
  local width = vim.o.foldcolumn + vim.o.numberwidth + len + 4
  vim.cmd("vertical resize " .. width)
end

local function resize_to_current_line()
  local len = vim.fn.strlen(vim.fn.getline("."))
  local width = vim.o.foldcolumn + vim.o.numberwidth + len + 4
  vim.cmd("vertical resize " .. width)
end

local function resize_to_selection()
  local lines = math.abs(vim.fn.line("'>") - vim.fn.line("'<")) + 1
  local total = lines + (vim.o.scrolloff * 2)
  vim.cmd("resize " .. total)
  vim.cmd("normal! zt")
end

-- Keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>e', function() resize_to_longest('') end, opts)
vim.keymap.set('n', '<Leader><Leader>e', function() resize_to_longest('w') end, opts)
vim.keymap.set('n', '<Leader>E', resize_to_current_line, opts)
vim.keymap.set('v', '<Leader>r', resize_to_selection, opts)

-- Simple window resizes
vim.keymap.set('n', '<Leader><Up>', '<C-w>+', opts)
vim.keymap.set('n', '<Leader><Down>', '<C-w>-', opts)
vim.keymap.set('n', '<Leader><Right>', '<C-w>>', opts)
vim.keymap.set('n', '<Leader><Left>', '<C-w><', opts)

-- WASD - resize in 50% steps
vim.keymap.set('n', '<Leader>w', function()
  vim.cmd("resize " .. math.floor(vim.fn.winheight(0) * 3 / 2))
end, opts)

vim.keymap.set('n', '<Leader>s', function()
  vim.cmd("resize " .. math.floor(vim.fn.winheight(0) * 2 / 3))
end, opts)

vim.keymap.set('n', '<Leader>d', function()
  vim.cmd("vertical resize " .. math.floor(vim.fn.winwidth(0) * 3 / 2))
end, opts)

vim.keymap.set('n', '<Leader>a', function()
  vim.cmd("vertical resize " .. math.floor(vim.fn.winwidth(0) * 2 / 3))
end, opts)

-- Equalize all windows
vim.keymap.set('n', '<Leader>=', '<C-w>=', opts)

--------------------------------------------------------------------------------

