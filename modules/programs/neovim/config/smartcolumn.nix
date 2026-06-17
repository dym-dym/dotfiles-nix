{
  plugins.smartcolumn = {
    settings = {
      colorcolumn = "80";
      custom_colorcolumn = {
        rust = [
          "80"
          "100"
        ];
      };
      disabled_filetypes = [
        "checkhealth"
        "help"
        "lspinfo"
        "markdown"
        "neo-tree"
        "noice"
        "text"
      ];
      scope = "line";
    };
    enable = true;
  };
}
