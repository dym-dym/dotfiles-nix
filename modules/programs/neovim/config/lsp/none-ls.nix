{
  plugins.none-ls = {
    enable = true;
    sources = {
      diagnostics = {
        credo.enable = true; # requires credo to be defined in the mix file
        statix.enable = true;
      };
      formatting = {
        fantomas.enable = true;
        nixfmt.enable = true;
        markdownlint.enable = true;
      };
    };
  };
}
