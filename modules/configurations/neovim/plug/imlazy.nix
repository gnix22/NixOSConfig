{ pkgs, ...}:

with pkgs.vimPlugins;
[
  {
    plugin = vimtex;
    type = "lua";
    config /*lua*/ =
    ''

    '';
  }
  {
    plugin = telescope-nvim;
    type = "lua";
    config /*lua*/ =
      ''
        map('n', '<leader>f', require'telescope.builtin'.find_files)
        map('n', '<leader>g', require'telescope.builtin'.live_grep)
      '';
  }
  {
    plugin = alpha-nvim;
    type = "lua";
    config /*lua*/ =
      ''
        --
        local alpha = require'alpha'
        local dashboard = require'alpha.themes.dashboard'
        local telescope = require'telescope.builtin'

        function find_files_in_dir(dir)
          telescope.find_files({ cwd = dir })
        end

        function show_main_menu()
          dashboard.section.buttons.val = {
            dashboard.button('p', 'Project', show_project_menu),
            dashboard.button('n',' Nix Config', function() find_files_in_dir("/home/gnix/nixos") end),
            dashboard.button('f','󰍉 Find Files', function() telescope.find_files() end),
            dashboard.button('c',' CLI', function() vim.cmd('qa') end),
          }
          alpha.setup(dashboard.config)
          vim.cmd('AlphaRedraw')
        end

        function show_project_menu()
          dashboard.section.buttons.val = {
            dashboard.button('o', 'Open Existing Project', function()
              telescope.find_files({
                cwd = '~/Code',  -- Set to your directory
                prompt_title = "Select Project Directory",
                find_command = { "fd", "--type", "d", "--exact-depth", "2"},  -- Custom find command for directory depth
              })
            end),
            dashboard.button('<BS>', 'Back', show_main_menu),
          }
          alpha.setup(dashboard.config)
          vim.cmd('AlphaRemap')
          vim.cmd('AlphaRedraw')
        end


        dashboard.section.header.val = {
          [[ __  __               _____   ____       ]],
          [[/\ \/\ \  __         /\  __`\/\  _`\     ]],
          [[\ \ `\\ \/\_\   __  _\ \ \/\ \ \,\L\_\   ]],
          [[ \ \ , ` \/\ \ /\ \/'\\ \ \ \ \/_\__ \   ]],
          [[  \ \ \`\ \ \ \\/>  </ \ \ \_\ \/\ \L\ \ ]],
          [[   \ \_\ \_\ \_\/\_/\_\ \ \_____\ `\____\]],
          [[    \/_/\/_/\/_/\//\/_/  \/_____/\/_____/]],
        }

        dashboard.config.layout = {
          { type = 'padding', val = 10 },
          dashboard.section.header,
          { type = 'padding', val = 3 },
          dashboard.section.buttons,
        }

        dashboard.section.header.opts.hl = 'Include'
        dashboard.section.buttons.opts.hl = 'Keyword'

        alpha.setup(dashboard.opts)
        show_main_menu()
      '';
  }
  {
    plugin = nightfox-nvim;
    config = "colorscheme terafox";
  }
  {
    plugin = indent-blankline-nvim;
    type = "lua";
    config /*lua*/ =
      ''
        require'ibl'.setup {
          scope = { enabled = false }
        }
      '';
  }
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp-cmdline
  cmp_luasnip
  {
    plugin = nvim-cmp;
    type = "lua";
    config /*lua*/ =
      ''
        local cmp = require'cmp'

        cmp.setup({
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          snippet = {
            expand = function(args)
            luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert ({
            ['<C-Tab>'] = cmp.mapping.select_next_item(),
            ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources ({
            { name = 'nvim_lsp'},
            { name = 'buffer'},
            { name = 'path'},
            { name = 'luasnip'},
          })
        })
      '';
  }
  {
    plugin = lualine-nvim;
    type = "lua";
    config /*lua*/ =
      ''
        require'lualine'.setup {
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'filetype' },
            lualine_y = { 'lsp_status' },
            lualine_z = { 'selectioncount', 'location' }
          }
        }
      '';
  }
  nvim-web-devicons
  {
    plugin = nvim-lspconfig;
    type = "lua";
    config /*lua*/ =
      ''
        vim.lsp.enable('clangd')
        vim.lsp.enable('jdtls')
        vim.lsp.enable('nixd')
        vim.lsp.enable('pyright')
        vim.lsp.enable('rust_analyzer')

        map('n', '<leader>d', function()
          vim.diagnostics.open_float(nil, { focusable = false })
        end)
      '';
  }
  {
    plugin = (
      nvim-treesitter.withPlugins (p: [
        p.tree-sitter-bash
        p.tree-sitter-cpp
        p.tree-sitter-java
        p.tree-sitter-json
        p.tree-sitter-latex
        p.tree-sitter-lua
        p.tree-sitter-nix
        p.tree-sitter-python
        p.tree-sitter-rust
        p.tree-sitter-sql
        p.tree-sitter-vim
      ])
    );
    type = "lua";
    config /*lua*/ =
      ''
        require('nvim-treesitter.configs').setup {
          ensure_installed = {},
          auto_install = false,
          highlight = { enable = true },
        }
      '';
  }
  #{
  #  plugin = ultisnips;
  #  type = "lua";
  #  config /*lua*/ =
  #  ''
  #    vim.g.UltiSnipsSnippetDirectories={'/home/gnix/nixos/modules/configurations/snippets/'}
  #    vim.g.UltiSnipsExpandTrigger = '<tab>'
  #    vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
  #    vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
  #  '';
  #}
  {
    plugin = vim-visual-increment;
    type = "lua";
    config /*lua*/ =
    ''
      vim.cmd('set nrformats=alpha,octal,hex')
    '';
  }
]
