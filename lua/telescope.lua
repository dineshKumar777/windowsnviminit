local utils = require('telescope.utils')
local M = {}

M.project_files = function()
    local _, ret, _ = utils.get_os_command_output({
        'git', 'rev-parse', '--is-inside-work-tree'
    })
    local gopts = {}
    gopts.prompt_title = ' Git Files'
    gopts.prompt_prefix = '  '
    if ret == 0 then
        require'telescope.builtin'.git_files(gopts)
    else
        require'telescope.builtin'.find_files()
    end
end

vim.api.nvim_set_keymap( "n", "<leader>;", ":Telescope oldfiles <CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap( "n", "<leader>b", ":Telescope buffers <CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap( "n", "<leader>f", ":lua require(\'telescope\').project_files()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap( "n", "<leader>/", ":Telescope current_buffer_fuzzy_find <CR>", {noremap = true, silent = true})

return M
