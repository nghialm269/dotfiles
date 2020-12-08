-- vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end

require("lsp-status").register_progress()

local register_server = function(server, config)
  local lsp_status = require("lsp-status")
  -- local completion = require("completion")

  config = config or {}

  config.on_attach = function(client, bufnr)
    -- completion.on_attach(client)
    lsp_status.on_attach(client)
    local mapper = function(mode, key, result)
      vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap=true, silent=true})
    end

    mapper('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    mapper('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
    mapper('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')

    -- mapper('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    mapper('n', 'K', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]])

    mapper('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    mapper('n', 'gT', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    -- mapper('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    mapper('n', 'gr', [[<cmd>lua require'telescope.builtin'.lsp_references{}<CR>]])

    -- mapper('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
    -- mapper('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
    mapper('n', '[d', [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>]])
    mapper('n', ']d', [[<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>]])

    -- mapper('n', '<M-Return>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    -- mapper('n', '<M-Return>', [[<cmd>lua require'telescope.builtin'.lsp_code_actions(require('telescope.themes').get_dropdown({ winblend = 10 }))<CR>]])
    -- mapper('n', '<leader>lca', [[<cmd>lua require'telescope.builtin'.lsp_code_actions(require('telescope.themes').get_dropdown({ winblend = 10 }))<CR>]])
    -- mapper('x', '<M-Return>', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
    -- mapper('x', '<leader>lca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
    -- mapper('x', '<M-Return>', [[<cmd>lua require'telescope.builtin'.lsp_range_code_actions(require('telescope.themes').get_dropdown({ winblend = 10 }))<CR>]])

    mapper('n', '<leader>lf', [[<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]])

    mapper('n', '<leader>lp', [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]])

    mapper('n', '<leader>lca', [[<cmd>lua require('lspsaga.codeaction').code_action()<CR>]])
    mapper('x', '<leader>lca', [[<cmd>lua require('lspsaga.codeaction').range_code_action()<CR>]])


    mapper('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    mapper('n', '<leader>lrn', [[<cmd>lua require('lspsaga.rename').rename()<CR>]])

    -- mapper('i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    -- mapper('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    mapper('i', '<C-s>', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]])
    mapper('n', '<C-s>', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]])
    mapper('n', '<C-s>', [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]])

    -- mapper('n', '<C-s>', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>')
    mapper('n', '<M-s>', [[<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>]])
    mapper('n', '<M-S>', [[<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>]])

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- vim.api.nvim_command [[autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]]
    vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua require('lspsaga.signaturehelp').signature_help()]]
    vim.api.nvim_command [[autocmd CursorHold,CursorHoldI <buffer> lua require'nvim-lightbulb'.update_lightbulb{sign = {enabled=false}, float={enabled=true, text="ﯧ"}}]]

    if client.resolved_capabilities.document_highlight == true then
      vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end
    if client.resolved_capabilities.document_formatting == true then
      vim.cmd [[ command! -nargs=0 Format lua vim.lsp.buf.formatting() ]]
    end
  end

  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)
  config.capabilities.textDocument.completion.completionItem.snippetSupport = true

  config = vim.tbl_extend("keep", config, server.document_config.default_config)

  server.setup(config)
end

local lspconfig = require('lspconfig')
require('lspsaga').init_lsp_saga()

--[[
register_server(nvim_lsp.solargraph, {
  settings = {
    solargraph = {
      autoformat = true,
      diagnostics = true,
      formatting = true,
      transport = "stdio"
    }
  }
})
--]]

register_server(lspconfig.gopls, {
  -- cmd = {"gopls", "serve"},
  cmd = {"gopls", "-remote=auto"},
  settings = {
    gopls = {
      -- Build
      -- Formatting
      gofumpt = true,
      -- Completion
      usePlaceholders = true,
      matcher = "Fuzzy",
      -- Diagnostic
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      -- Documentation
      -- Navigation
    }
  }
})

register_server(lspconfig.clangd, {
  cmd = {"clangd", "-clang-tidy", "-cross-file-rename"}
})

register_server(lspconfig.rust_analyzer)

register_server(lspconfig.pyright, {
  cmd = { "poetry", "run", "pyright-langserver", "--stdio" }
})

local flutter = require('flutter-tools')
register_server(lspconfig.dartls, {
  cmd = { "dart", "/home/nghialm/.asdf/installs/flutter/1.22.5-stable/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
  flags = {allow_incremental_sync = true},
  init_options = {
    closingLabels = true,
    outline = true,
    flutterOutline = true
  },
  handlers = {
    ['dart/textDocument/publishClosingLabels'] = flutter.closing_tags,
    ['dart/textDocument/publishOutline'] = flutter.outline
  }
})

register_server(lspconfig.efm)

register_server(lspconfig.html, {
  settings = {
    html = {
      suggest = {
        angular1 = false,
        ionic = false,
        html5 = true,
      },
      autoClosingTags = true,
    }
  }
})
register_server(lspconfig.cssls)

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig/configs'.emmet_ls = {
  default_config = {
    cmd = {'emmet-ls', '--stdio'};
    filetypes = {'html', 'css'};
    root_dir = function()
      return vim.loop.cwd()
    end;
    settings = {};
  };
}
register_server(lspconfig.emmet_ls)


register_server(lspconfig.jsonls, {
  cmd = { "json-languageserver", "--stdio" }
})
register_server(lspconfig.yamlls, {
  settings = {
    yaml = {
      schemas = {
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
        ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
      }
    }
  }
})
-- register_server(nvim_lsp.tsserver)

register_server(lspconfig.bashls)

register_server(lspconfig.vimls)
register_server(lspconfig.sumneko_lua, {
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        enable = true,
        globals = {
          -- Neovim
          "vim",
          -- Busted
          "describe", "it", "before_each", "after_each"
        },
      },
      workspace = {
        library = vim.list_extend({
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        }, {}),
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
