{
  plugins = {
    treesitter = {
      enable = true;
      nixGrammars = true;
      highlight.disable = [ "latex" ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };
    treesitter-context = {
      enable = true;
      settings = { max_lines = 2; };
    };
    rainbow-delimiters.enable = true;
  };
}
