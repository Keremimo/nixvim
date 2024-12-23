[
  {
    action = "<cmd>Neotree toggle<CR>";
    key = "<C-e>";
    options = {
      silent = true;
    };
  }
  {
    mode = "i";
    key = "<ESC>";
    action = "<CMD>noh<CR><ESC>";
    options.desc = "Normal mode and clear highlight";
  }
  {
    mode = "n";
    key = "<ESC>";
    action = "<CMD>noh<CR><ESC>";
    options.desc = "Normal mode and clear highlight";
  }
  {
    mode = [ "i" ];
    action = "<CMD>noh<CR><ESC>";
    key = "jk";
    options.silent = true;
  }
  {
    mode = "n";
    key = "<leader>e";
    action = "<CMD>Oil<CR>";
    options.desc = "Oil";
  }
  {
    action = "<Cmd>:w<CR>";
    key = "<C-s>";
    options.silent = true;
  }
  {
    action = "<Cmd>:q<CR>";
    key = "<C-q>";
    options.silent = true;
  }
  {
    mode = "n";
    key = "<Enter>";
    action = "<CMD>HopChar2<CR>";
    options.desc = "Hop Char 2";
  }
  {
    mode = "n";
    key = "gd";
    action = "<CMD>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<CR>";
    options.desc = "Goto Definition";
  }
  {
    mode = "n";
    key = "gr";
    action = "<CMD>FzfLua lsp_references jump_to_single_result=true ignore_current_line=true<CR>";
    options.desc = "References";
  }
  {
    mode = "n";
    key = "gI";
    action = "<CMD>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<CR>";
    options.desc = "Goto Implementation";
  }
  {
    mode = "n";
    key = "gy";
    action = "<CMD>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<CR>";
    options.desc = "Goto T[y]pe Definition";
  }
  {
    mode = "n";
    key = "<leader>cd";
    action = "<CMD>lua vim.diagnostic.open_float()<CR>";
    options.desc = "Popup Diagnostics";
  }
  {
    mode = "n";
    key = "<leader>cD";
    action = "<CMD>Trouble diagnostics toggle<CR>";
    options.desc = "List All Diagnostics";
  }
]
