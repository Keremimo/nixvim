{ pkgs, lib, ... }: {
  keymaps = [ ] ++ import ./keymaps.nix;

  imports = [
    ./opts.nix
    ./transparent.nix
  ];

  globals = {
    mapleader = " ";
    have_nerd_font = true;
  };
  performance.byteCompileLua = {
    enable = true;
    nvimRuntime = true;
    plugins = true;
  };

  colorschemes.catppuccin.enable = true;

  plugins = {
    lz-n.enable = true;
    web-devicons.enable = true;
    neocord.enable = true;
    noice.enable = true;
    notify.enable = true;
    direnv.enable = true;
    barbar.enable = true;

    rustaceanvim = {
      enable = true;
      settings = {
        dap.adapter = {
          command = "${pkgs.lldb_19}/bin/lldb-dap";
          type = "executable";
        };
        tools.enable_clippy = true;
        server = {
          default_settings = {
            inlayHints = { lifetimeElisionHints = { enable = "always"; }; };
            rust-analyzer = {
              cargo = { allFeatures = true; };
              check = { command = "clippy"; };
            };
          };
        };
      };
    };

    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap = {
      enable = true;
      extensions = { };

      adapters = {
        executables = { lldb = { command = "${pkgs.lldb_19}/bin/lldb-dap"; }; };
      };
    };

    telescope = {
      enable = true;
      keymaps = { "<leader>fg" = "live_grep"; };
    };

    which-key = { enable = true; };

    snacks = {
      enable = true;
      settings = {
        bigfile = { enabled = true; };
        notifier = {
          enabled = true;
          timeout = 3000;
        };
        quickfile = { enabled = false; };
        statuscolumn = { enabled = false; };
        words = {
          debounce = 100;
          enabled = true;
        };
      };
    };

    mini = {
      enable = true;
      modules = {
        comment = {
          mappings = {
            comment = "<leader>/";
            comment_line = "<leader>/";
            comment_visual = "<leader>/";
            textobject = "<leader>/";
          };
        };
        diff = { view = { style = "sign"; }; };
        starter = {
          content_hooks = {
            "__unkeyed-1.adding_bullet" = {
              __raw = "require('mini.starter').gen_hook.adding_bullet()";
            };
            "__unkeyed-2.indexing" = {
              __raw =
                "require('mini.starter').gen_hook.indexing('all', { 'Builtin actions' })";
            };
            "__unkeyed-3.padding" = {
              __raw =
                "require('mini.starter').gen_hook.aligning('center', 'center')";
            };
          };
          evaluate_single = true;
          header = ''
            ██╗  ██╗██╗    ██╗  ██╗███████╗██████╗ ███████╗███╗   ███╗██╗
            ██║  ██║██║    ██║ ██╔╝██╔════╝██╔══██╗██╔════╝████╗ ████║██║
            ███████║██║    █████╔╝ █████╗  ██████╔╝█████╗  ██╔████╔██║██║
            ██╔══██║██║    ██╔═██╗ ██╔══╝  ██╔══██╗██╔══╝  ██║╚██╔╝██║╚═╝
            ██║  ██║██║    ██║  ██╗███████╗██║  ██║███████╗██║ ╚═╝ ██║██╗
            ╚═╝  ╚═╝╚═╝    ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝
          '';
          items = {
            "__unkeyed-1.buildtin_actions" = {
              __raw = "require('mini.starter').sections.builtin_actions()";
            };
            "__unkeyed-2.recent_files_current_directory" = {
              __raw =
                "require('mini.starter').sections.recent_files(10, false)";
            };
            "__unkeyed-3.recent_files" = {
              __raw =
                "require('mini.starter').sections.recent_files(10, true)";
            };
            "__unkeyed-4.sessions" = {
              __raw = "require('mini.starter').sections.sessions(5, true)";
            };
          };
        };
        surround = { };
        indentscope = {
          symbol = "│";
          options = { try_as_border = true; };
        };
      };
    };
    hop.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        keymap = { preset = "super-tab"; };
      };
    };

    lspkind = {
      enable = true;
      symbolMap = { };
      extraOptions = {
        maxwidth = 50;
        ellipsis_char = "...";
      };
    };

    neo-tree = {
      enable = true;
      enableRefreshOnWrite = true;
      closeIfLastWindow = true;
      hideRootNode = true;
      popupBorderStyle = "rounded";

      window.position = "right";
      window.width = 20;
      window.autoExpandWidth = true;

      eventHandlers = {
        before_render = ''
          function (state)
            -- add something to the state that can be used by custom components
          end
        '';

        file_opened = ''
          function(file_path)
            --auto close
            require("neo-tree").close_all()
          end
        '';
      };
    };

    oil = {
      enable = true;
      settings = {
        columns = [
          "icons"
          "permissions"
          "size"
          "mtime"
        ];
        default_file_explorer = true;
        delete_to_trash = true;
        skip_confirmation_for_simple_edits = true;
      };
    };

    cmp = {
      autoEnableSources = true;
      settings.snippet = {
        expand = ''
          function(args)
          require("luasnip").lsp_expand(args.body)
          end
        '';
      };
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        {
          name = "luasnip";
          option = { show_autosnippets = true; };
        }
      ];
    };

    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 2000;
        };
        formatters_by_ft = {
          # ruby = [
          #   "rubocop"
          # ];
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          rust = [ "rustfmt" ];
          cpp = [ "clang_format" ];
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            timeout_ms = 2000;
            stop_after_first = true;
          };
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
        };

        log_level = "warn";
        notify_on_error = false;
        notify_no_formatters = false;
        formatters = {
          prettierd = {
            command = lib.getExe pkgs.prettierd;
          };
          # rubocop = {
          #   command = "rubocop -A";
          # };
          shellcheck = {
            command = lib.getExe pkgs.shellcheck;
          };
          shfmt = {
            command = lib.getExe pkgs.shfmt;
          };
          shellharden = {
            command = lib.getExe pkgs.shellharden;
          };
          squeeze_blanks = {
            command = lib.getExe' pkgs.coreutils "cat";
          };
        };
      };
    };

    luasnip = {
      enable = true;
      settings.enable_autosnippets = true;
    };

    nvim-autopairs.enable = true;
    colorizer.enable = true;

    lualine = {
      enable = true;
      settings.options.globalstatus = true;
    };

    vim-surround.enable = true;

    treesitter = {
      enable = true;
      folding = false;
      settings = {
        indent.enable = false;
        folding = false;
        auto_install = true;
        ensure_installed = [
          "git_config"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
        ];
      };
    };

    friendly-snippets.enable = true;
    lsp = {
      enable = true;
      capabilities = ''
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require'lspconfig'.cssls.setup {
          capabilities = capabilities,
        }
      '';
      inlayHints = true;
      keymaps = {
        diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
        };
      };
      servers = {
        emmet_language_server = {
          enable = true;
          package = pkgs.emmet-language-server;
          filetypes = [
            "html"
            "jsx"
            "tsx"
            "erb"
          ];
        };
        cssls = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
        };
        vtsls = {
          enable = true;
          package = pkgs.vtsls;
        };
        gopls = {
          enable = true;
        };
        nixd = {
          enable = true;
          settings.formatting.command = [ "nixpkgs-fmt" ];
          cmd = [ "nixd" ];
        };
        ruby_lsp = {
          enable = true;
          cmd = [ "bundle" "exec" "ruby-lsp" ];
          filetypes = [
            "ruby"
            "eruby"
          ];
        };
      };
    };

  };
  autoCmd = [
    {
      event = "TextYankPost";
      group = "highlight_yank";
      callback.__raw = "function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 } end";
    }
  ];
  autoGroups.highlight_yank.clear = true;
}
