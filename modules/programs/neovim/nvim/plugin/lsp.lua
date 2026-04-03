local on_attach = function(_, bufnr)

  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- require('neodev').setup()

-- lspconfig = require('lspconfig')
lspconfig = vim.lsp.config

-- lspconfig.nil_ls.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
vim.lsp.config('nil_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable('nil_ls')

-- lspconfig.rust_analyzer.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }
vim.lsp.config('rust_analyzer', {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable('rust_analyzer')

-- lspconfig.ocamllsp.setup{
--     on_attach = on_attach,
--     capabilities = capabilities,
-- }

vim.lsp.config('ocamllsp', {
    on_attach = on_attach,
    capabilities = capabilities,
})
vim.lsp.enable('ocamllsp')

vim.lsp.config('texlab', {})
vim.lsp.enable('texlab')

require('coq-lsp').setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
