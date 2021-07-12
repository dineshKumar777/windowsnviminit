-- toggle full screen for neovide
if vim.g.neovide == true then
	vim.api.nvim_set_keymap('n', '<F11>', ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end
