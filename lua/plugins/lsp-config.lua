return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- 1. Initialize Mason
      require("mason").setup()

      -- 2. Initialize Mason-LSPConfig (Ensures your tools are downloaded)
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "basedpyright", "ts_ls", "intelephense", "ruff" },
      })

      -- 3. Set up beautiful Nerd Font diagnostics
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = "▎", -- Sleek vertical bar
          source = "always",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- 4. Setup LSPs (The Neovim 0.11+ Native Way!)
      -- Notice we completely deleted `require("lspconfig")` here
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local servers = {
        basedpyright = {},
        ts_ls = {},
        ruff = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
        intelephense = {
          settings = {
            intelephense = {
              environment = { includePaths = { "vendor" } },
              files = { maxSize = 1000000 },
            },
          },
        },
      }

      -- Loop through the servers and use the new native API
      for server_name, config in pairs(servers) do
        -- Inject the capabilities into the config
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})

        -- Apply the config to Neovim's native core
        vim.lsp.config(server_name, config)

        -- Enable the server!
        vim.lsp.enable(server_name)
      end

      -- 5. Keybindings (Only attach when LSP is running)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = vim.keymap.set
          map("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show hover info" })
          map("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
          map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
          map(
            "n",
            "<leader>e",
            vim.diagnostic.open_float,
            { buffer = ev.buf, desc = "Show diagnostic details" }
          )
        end,
      })
    end,
  },
}
