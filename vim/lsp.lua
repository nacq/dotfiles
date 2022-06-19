local cmp = require "cmp"

cmp.setup {
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-y>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
  sources = {
    { name = "nvim_lsp" },
  },
  -- don't quite like having this and `vim/plugins.vim:37` but it seems required by the autocompletion to work
  -- properly in some cases (error "snippet engine is not configured")
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
}

vim.diagnostic.config({ virtual_text = false })

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#show-line-diagnostics-automatically-in-hover-window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

local servers = {
  'gopls',
  'tsserver',
  -- to get this working, `npm i -g vscode-langservers-extracted`
  -- ref: https://github.com/neovim/nvim-lspconfig/pull/1273/files#diff-abae925898033611bb8a6fe94b196d364c64999f6e6a12bb553486d88c62158dR108
  -- note: it requires node 14+
  'eslint',
}

for _, lsp in pairs(servers) do
  require'lspconfig'[lsp].setup{
    on_attach = function()
      -- nvim_buf_set_keymap({buffer}, {mode}, {lhs}, {rhs}, {*opts})
      vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>dd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>hdd', '<cmd>split | lua vim.lsp.buf.definition()<CR>', {noremap = true})
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>vdd', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', {noremap = true})
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rr', '<cmd>lua vim.lsp.buf.references()<CR>', {noremap = true})
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ii', '<cmd>lua vim.lsp.buf.implementation()<CR>', {noremap = true})
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>R', '<cmd>lua vim.lsp.buf.rename()<CR>', {noremap = true})
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>ff', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})
    end
  }
end
