local opts = { noremap = true, silent = true }
-- local opt = { noremap = true, silent = false }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-j>", " ", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)


-- Insert --
-- Press jk fast to exit insert mode 
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "K", ":move '<-2<cr>gv-gv", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<S-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<S-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--C
vim.cmd('autocmd FileType c map <silent><leader>v :w <CR> :!clang % -g -Wall -Wextra -o %< <CR>:TermExec cmd="clear && ./%<"  <CR>')
vim.cmd('autocmd FileType c map <silent><leader>vv :w <CR> :TermExec cmd="clear && ./%<"  <CR>')
vim.cmd('autocmd FileType c map <silent><leader>c :w <CR> :TermExec cmd="clang % -g -Wall -Wextra -o %<"  <CR>')
vim.cmd('autocmd FileType c map <silent><leader>cc :w <CR> :TermExec cmd="clang *.c -g -Wall -Wextra -o main"  <CR>')

--C++
vim.cmd('autocmd FileType cpp map <silent><leader>v :w <CR> :!g++ % -g -Wall -Wextra -o %< <CR>:TermExec cmd="clear && ./%<"  <CR>')
vim.cmd('autocmd FileType cpp map <silent><leader>c :w <CR> :TermExec cmd="g++ % -g -Wall -Wextra -o %<"  <CR>')

vim.cmd('autocmd FileType cpp map <silent><leader>vv :w <CR> :!g++ *.cpp *.cc -g -Wall -Wextra -o main <CR>:TermExec cmd="clear && ./main"  <CR>')
vim.cmd('autocmd FileType cpp map <silent><leader>cc :w <CR> :TermExec cmd="g++ *.cpp *.cc -g -Wall -Wextra -o main"  <CR>')

-- asm
vim.cmd('autocmd FileType asm map <silent><leader>c :w <CR> :TermExec cmd="nasm -f bin % -o %<.com"  <CR>')
vim.cmd('autocmd FileType asm map <silent><leader>v :w <CR> :!/home/yaman/Studium/2.Semster/Hardwarenahe_Programmierung/SBC86_Simulator/sbc86sim_linux_qt5_x86_64_1.2.5/simu86 &<CR>')

--py 
vim.cmd('autocmd FileType python map <silent><leader>c :w <CR> : TermExec cmd="clear && python3 %" <CR>')
vim.cmd('autocmd FileType python map <silent><leader>v :w <CR> :!python3 %& <CR>')

-- keymap("n", "<leader>vv", ":w <CR> :! gcc % -o %< && chmod +x %< <CR>", opts)
-- keymap("n", "<leader>v", ":w <CR> :!gcc % -o %< && chmod +x %< <CR> :vert 70sp <CR> :term ./%<  <CR>", opts)
-- vim.cmd('autocmd FileType c map <leader>c :w <CR> :!gcc % -o %< && chmod +x %< <CR> :vert 70sp <CR> :term ./%<  <CR>')
-- vim.cmd('autocmd FileType c map <leader>cc :w <CR> :! gcc % -o %< && chmod +x %< <CR>')
