return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "basedpyright", "ts_ls",},
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Enable inline diagnostics
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", -- Symbol for virtual text (e.g., ● for errors/warnings)
          source = "always", -- Show diagnostic source (e.g., lua_ls)
        },
        signs = true, -- Show signs in the gutter (e.g., E for errors)
        underline = true, -- Underline problematic code
        update_in_insert = false, -- Don't update diagnostics while typing
        severity_sort = true, -- Show errors before warnings
        float = {
          border = "rounded", -- Rounded border for diagnostic popups
          source = "always", -- Show source in popup
        },
      })

      -- ✅ Define LSP configurations (new API)
      local lsp = vim.lsp

      lsp.config["lua_ls"] = {
        cmd = { "lua-language-server" },
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      lsp.config["basedpyright"] = {
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
      }

      lsp.config["ts_ls"] = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      }

      lsp.config["intelephense"] = {
        cmd = { "intelephense", "--stdio" },
        filetypes = { "php" },
        root_markers = { "composer.json", "artisan" },
        settings = {
          intelephense = {
            environment = {
              includePaths = { "vendor" },
            },
            files = { maxSize = 1000000 },
          },
        },
      }

      -- ✅ Auto-start servers when filetype matches
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "python", "javascript", "typescript", "php" },
        callback = function()
          local ft = vim.bo.filetype
          local config = lsp.config[ft == "javascript" and "ts_ls" or ft]
          if config then lsp.start(config) end
        end,
      })

      -- Keybindings
      local map = vim.keymap.set
      map("n", "K", vim.lsp.buf.hover, { desc = "Show hover info" })
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic details" })
    end,
  },
}
