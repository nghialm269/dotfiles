-- vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

-- local border = {
-- 	{ "🭽", "FloatBorder" },
-- 	{ "▔", "FloatBorder" },
-- 	{ "🭾", "FloatBorder" },
-- 	{ "▕", "FloatBorder" },
-- 	{ "🭿", "FloatBorder" },
-- 	{ "▁", "FloatBorder" },
-- 	{ "🭼", "FloatBorder" },
-- 	{ "▏", "FloatBorder" },
-- }
local border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
    })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border,
    })

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local flags = {
    debounce_text_changes = 150,
}

-- Diagnostics
vim.diagnostic.config({
    float = {
        header = false,
        source = "always",
        border = border,
    },
    update_in_insert = true,
    severity_sort = true,
    virtual_text = true,
    virtual_lines = false,
})

local telescope = require("telescope.builtin")
n.map("n", "<leader>do", vim.diagnostic.open_float, "Diagnostics: open float")
n.map("n", "<leader>dq", vim.diagnostic.setloclist, "Diagnostics: set location list")
n.map("n", "<leader>dd", function()
  telescope.diagnostics({ bufnr = 0 })
end, "Diagnostics: current buffer")
n.map("n", "<leader>dw", telescope.diagnostics, "Diagnostics: all buffers")
n.map("n", "[d", vim.diagnostic.goto_prev, "Next diagnostics")
n.map("n", "]d", vim.diagnostic.goto_next, "Prev diagnostics")

n.map("n", "<Leader>dl", function()
  local value = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({
      virtual_lines = not value,
      update_in_insert = value,
      virtual_text = value,
  })
end, "Diagnostics: Toggle lsp_lines")

local lsp_format = function(bufnr)
  vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "tsserver" and client.name ~= "sumneko_lua" and client.name ~= "sqls"
      end,
      bufnr = bufnr,
  })
end

local lsp_organize_imports = function(client, bufnr)
  local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
  params.context = { only = { "source.organizeImports" } }

  local result = client.request_sync("textDocument/codeAction", params, 3000, bufnr)
  for _, action in pairs(result.result or {}) do
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    end
    if action.command then
      local command = type(action.command) == "table" and action.command or action
      client.request_sync("workspace/executeCommand", command, 3000, bufnr)
    end
  end
end

local augroup_lsp_code_lens = vim.api.nvim_create_augroup("LspCodeLens", {})
local augroup_lsp_format = vim.api.nvim_create_augroup("LspFormat", {})
local augroup_lsp_document_highlight = vim.api.nvim_create_augroup("LspDocumentHighlight", {})

local on_attach = function(client, bufnr)
  n.bufmap(bufnr, "n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  n.bufmap(bufnr, "n", "gd", vim.lsp.buf.definition, "Go to Definition")
  n.bufmap(bufnr, "n", "gr", vim.lsp.buf.references, "Find References")
  n.bufmap(bufnr, "n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  n.bufmap(bufnr, "n", "gT", vim.lsp.buf.type_definition, "Go to Type definition")
  n.bufmap(bufnr, "n", "<localleader>lci", vim.lsp.buf.incoming_calls, "Incoming calls")
  n.bufmap(bufnr, "n", "<localleader>lco", vim.lsp.buf.outgoing_calls, "Outgoing calls")
  n.bufmap(bufnr, "n", "K", vim.lsp.buf.hover, "Hover")
  n.bufmap(bufnr, "ni", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

  -- Refactors
  n.bufmap(bufnr, "n", "<localleader>lrn", vim.lsp.buf.rename, "Rename")
  n.bufmap(bufnr, "niv", { "<localleader>lca", "<M-Enter>" }, vim.lsp.buf.code_action, "Code action")

  -- Workspaces
  n.bufmap(bufnr, "n", "<localleader>lwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  n.bufmap(bufnr, "n", "<localleader>lwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  n.bufmap(bufnr, "n", "<localleader>lwl", function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, "List workspace folder")

  -- Symbols
  n.bufmap(bufnr, "n", "<localleader>lsd", vim.lsp.buf.document_symbol, "Document symbol")
  n.bufmap(bufnr, "n", "<localleader>lsw", vim.lsp.buf.workspace_symbol, "Workspace symbol")

  -- Codelens
  if client.server_capabilities.codeLensProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
        group = augroup_lsp_code_lens,
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
    })
    n.bufmap(bufnr, "n", "<leader>lcl", vim.lsp.codelens.run, "Run codelens")
  end

  -- Formatting
  if client.supports_method("textDocument/formatting") then
    if client.name ~= "gopls" then -- added in go.nvim
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup_lsp_format,
          buffer = bufnr,
          callback = function()
            lsp_format(bufnr)
          end,
      })

      vim.api.nvim_create_user_command("Format", function()
        lsp_format(bufnr)
      end, {})
    end
  end

  -- Highlights
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = augroup_lsp_document_highlight,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = augroup_lsp_document_highlight,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
  end
end

require("trouble").setup({
    auto_open = false,
    auto_close = true,
})

local lspconfig = require("lspconfig")
lspconfig.gopls.setup({
    cmd = { "gopls", "serve" },
    -- cmd = { "gopls", "-remote=auto" },
    settings = {
        gopls = {
            ["env"] = {
                GOFLAGS = "-tags=integration",
            },
            ["formatting.local"] = "github.com/koinworks/asgard-koinneo",
            ["formatting.gofumpt"] = true,
            ["ui.semanticTokens"] = true,
            ["ui.completion.usePlaceholders"] = true,
            ["ui.completion.matcher"] = "Fuzzy",
            ["ui.diagnostic.staticcheck"] = true,
            ["ui.diagnostic.analyses"] = {
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.clangd.setup({
    cmd = { "clangd", "-clang-tidy", "-cross-file-rename" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    init_options = {
        clangdFileStatus = true,
    },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

require("flutter-tools").setup({
    experimental = {
        lsp_derive_paths = true,
    },
    flutter_lookup_cmd = "asdf where flutter",
    widget_guides = {
        -- highlight = "NonText",
        enabled = true,
    },
    closing_tags = {
        highlight = "Comment",
        prefix = "-- ",
    },
    dev_log = {
        open_cmd = "10new",
    },
    outline = {
        open_cmd = "35vnew",
    },
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = flags,
        settings = {
            dart = {
                enableSdkFormatter = true,
                lineLength = 80,
                completeFunctionCalls = true,
                showTodos = true,
                renameFilesWithClasses = "prompt",
            },
        },
    },
    debugger = {
        enabled = true,
    },
})

local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(client, bufnr)
          on_attach(client, bufnr)

          n.bufmap(bufnr, "n", "K", rt.hover_actions.hover_actions, "Rust: Hover actions")

          n.bufmap(
              bufnr,
              "nv",
              { "<localleader>lca", "<M-Enter>" },
              rt.code_action_group.code_action_group,
              "Rust: Code action groups"
          )
        end,
        standalone = true,
        flags = flags,
    },
})

-- lspconfig.sqls.setup({
-- 	on_attach = function(client, bufnr)
-- 		require("sqls").on_attach(client, bufnr)
-- 		on_attach(client, bufnr)
-- 	end,
-- })

local null = require("null-ls")
local lsputil = require("lspconfig.util")

local prettierd_args = function(params)
  local root = lsputil.root_pattern("package.json")(params.bufname)
  -- replace with your preferred config file format and fallback path
  return lsputil.path.exists(lsputil.path.join(root, ".prettierrc")) and {}
      or { "--config", vim.fn.expand("~/.config/.prettierrc") }
end

local package_info_source = {
    name = "package-info",
    method = null.methods.CODE_ACTION,
    filetypes = { "json" },
    generator = {
        fn = function(_)
          local actions = {}

          if require("package-info.state").is_loaded then
            return actions
          end

          table.insert(actions, {
              title = "Show package versions",
              action = function()
                require("package-info").show()
              end,
          })
          table.insert(actions, {
              title = "Hide package versions",
              action = function()
                require("package-info").hide()
              end,
          })
          table.insert(actions, {
              title = "Install a new package",
              action = function()
                require("package-info").install()
              end,
          })
          table.insert(actions, {
              title = "Reinstall dependencies",
              action = function()
                require("package-info").reinstall()
              end,
          })

          if require("package-info.helpers.get_dependency_name_from_current_line")() == nil then
            return actions
          end

          table.insert(actions, {
              title = "Update this package",
              action = function()
                require("package-info").update()
              end,
          })

          table.insert(actions, {
              title = "Delete this package",
              action = function()
                require("package-info").delete()
              end,
          })

          table.insert(actions, {
              title = "Change this package version",
              action = function()
                require("package-info").change_version()
              end,
          })

          return actions
        end,
    },
}

local formatters = null.builtins.formatting
local linters = null.builtins.diagnostics
local code_actions = null.builtins.code_actions

local sources = {
    formatters.stylua,
    formatters.black,
    formatters.isort,
    formatters.prettierd.with({
        -- prefer_local = "node_modules/.bin",
        -- extra_args = prettierd_args,
    }),
    linters.golangci_lint,
    -- linters.sqlfluff.with({
    -- 	extra_args = { "--dialect", "postgres" },
    -- }),
    -- formatters.sqlfluff.with({
    -- 	extra_args = { "--dialect", "postgres" },
    -- }),
    -- code_actions.gomodifytags,
    code_actions.refactoring,
    code_actions.gitsigns,
    code_actions.gitrebase,
    package_info_source,
}

null.setup({
    sources = sources,
    on_attach = on_attach,
})

lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
      local ts_utils = require("nvim-lsp-ts-utils")

      ts_utils.setup({
          debug = false,
          disable_commands = false,
          enable_import_on_completion = true,
          -- import all
          import_all_timeout = 5000, -- ms
          -- lower numbers = higher priority
          import_all_priorities = {
              same_file = 1, -- add to existing import statement
              local_files = 2, -- git files or files with relative path markers
              buffer_content = 3, -- loaded buffer content
              buffers = 4, -- loaded buffer names
          },
          import_all_scan_buffers = 100,
          import_all_select_source = false,
          -- filter diagnostics
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = {},
          -- inlay hints
          auto_inlay_hints = true,
          inlay_hints_highlight = "Comment",
          -- update imports on file move
          update_imports_on_move = false,
          require_confirmation_on_move = false,
          watch_dir = nil,
      })

      -- required to fix code action ranges
      ts_utils.setup_client(client)

      -- no default maps, so you may want to define some here
      vim.api.nvim_buf_set_keymap(bufnr, "n", "go", ":TSLspOrganize<CR>", { silent = true })
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gR", ":TSLspRenameFile<CR>", { silent = true })
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", { silent = true })

      vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])

      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.eslint.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.emmet_ls.setup({
    root_dir = function(fname)
      return lsputil.root_pattern("package.json", ".git")(fname) or lsputil.path.dirname(fname)
    end,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

local path = lsputil.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end

  -- If no standard venv found look for poetry
  local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
  -- TODO: This could throw errors, should be handled
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system("poetry env info -p"))
    return path.join(venv, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.exepath("python3") or vim.exepath("python") or "python"
end

lspconfig.pyright.setup({
    before_init = function(_, config)
      config.settings.python.pythonPath = get_python_path(config.root_dir)
    end,
    cmd = { "pyright-langserver", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.jsonls.setup({
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.yamlls.setup({
    settings = {
        yaml = {
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

lspconfig.vimls.setup({
    root_dir = function(fname)
      return lsputil.root_pattern("init.lua")(fname)
          or lsputil.root_pattern("init.vim")(fname)
          or lsputil.find_git_ancestor(fname)
    end,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lspconfig.lua_ls.setup({
    cmd = { "lua-language-server" },
    root_dir = function(fname)
      return lsputil.root_pattern("init.lua")(fname)
          or lsputil.root_pattern("init.vim")(fname)
          or lsputil.find_git_ancestor(fname)
    end,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path,
            },
            diagnostics = {
                globals = {
                    "vim",
                },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

-- vim: ts=2 sts=2 sw=2 et
