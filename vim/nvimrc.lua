local nvim_lsp = require('lspconfig')

-- Autocomplete setup w/ cmp
local cmp = require('cmp')

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<TAB>'] = cmp.mapping.confirm({ select = true })
  }),
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'nvim_lsp_signature_help'},
    { name = 'nvim_lua', keyword_length = 2},
    { name = 'buffer', keyword_length = 2 },
    { name = 'calc'},
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  }
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- oh yeah we got trouble, right here in river city
require('trouble').setup()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'Q', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  --if vim.fn.filereadable("package.json") then
  --  if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
  --    return true
  --  end
  --end

  return false
end

-- clangd (C, C++)

nvim_lsp.clangd.setup {
  cmd = {"clangd", "--completion-style=detailed", "--clang-tidy"},
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities
}

-- Typescript + eslint setup based on https://phelipetls.github.io/posts/configuring-eslint-to-work-with-neovim-lsp

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "prettier --parser=typescript --stdin-filepath=${INPUT} | eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

nvim_lsp.ts_ls.setup {
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  on_attach = function(client, bufnr)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    --client.server_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities
}

nvim_lsp.efm.setup {
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
    client.server_capabilities.goto_definition = false
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint},
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
  },
  capabilities = capabilities
}

-- Deno setup, triggered by deno.json

nvim_lsp.denols.setup {
  root_dir = nvim_lsp.util.root_pattern("deno.json"),
  on_attach = on_attach,
  init_options = {
    lint = true,
  },
  capabilities = capabilities
}

-- Rust

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- Haskell, provided by haskell-tools.nvim

vim.g.haskell_tools = {
  hls = {
    on_attach = on_attach
  }
}

-- Metals, this config is its own thing (not using nvim_lsp)

local metals = require('metals')
local metals_config = metals.bare_config()
metals_config.settings = {
 showImplicitArguments = true
}
metals_config.capabilities = capabilities
metals_config.on_attach = on_attach

metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = '',
    }
  }
)

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'scala' },
    callback = function()
        vim.opt_global.shortmess:remove("F")
        metals.initialize_or_attach(metals_config)
    end,
})

-- Treesitter (mostly for rust)

require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

-- Format on save

local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

local js_formatters = {
  formatters.if_file_exists({
    pattern = ".eslintrc.*",
    formatter = formatters.eslint_d_fix
  }),
  formatters.if_file_exists({
    pattern = { ".prettierrc", ".prettierrc.*", "prettier.config.*" },
    formatter = formatters.prettierd,
  })
}

format_on_save.setup({
  exclude_path_patterns = {
    "/node_modules/",
    "/vendor/",
    "/thirdparty/",
    "/build/",
    "/out/",
    ".local/share/nvim/lazy",
  },
  formatter_by_ft = {
    css = formatters.lsp,
    html = formatters.lsp,
    java = formatters.lsp,
    json = formatters.lsp,
    lua = formatters.lsp,
    c = formatters.lsp,
    cpp = formatters.lsp,
    markdown = formatters.prettierd,
    python = formatters.black,
    rust = formatters.lsp,
    scala = formatters.lsp,
    scss = formatters.lsp,
    sh = formatters.shfmt,
    yaml = formatters.lsp,

    javascript = js_formatters,
    javascriptreact = js_formatters,
    typescript = js_formatters,
    typescriptreact = js_formatters,
  },

  fallback_formatter = {
    formatters.remove_trailing_whitespace
  },

  experiments = {
    partial_update = 'diff'
  }
})

