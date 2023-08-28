return {
    {
        'voldikss/vim-floaterm',
        config = function()
            vim.g.floaterm_keymap_toggle = '<F1>'
            vim.g.floaterm_keymap_next = '<F2>'
            vim.g.floaterm_keymap_prev = '<F3>'
            vim.keymap.set("n", "<leader><leader>tm", ":FloatermNew<cr>", {desc="[N]ew floaterm window"})
            vim.cmd[[tnoremap <S-n> <C-\><C-n>:FloatermKill<CR>]]

            -- floaterm size configuration
            vim.g.floaterm_gitcommit = "floaterm"
            vim.g.floaterm_autoinsert = 1
            vim.g.floaterm_width = 0.8
            vim.g.floaterm_height = 0.8
            vim.g.floaterm_wintitle = 0
            vim.g.floaterm_autoclose = 1
        end
    },
}
