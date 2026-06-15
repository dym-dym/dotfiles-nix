{
  plugins.vimtex = {
    enable = true;
    settings = {
      compiler_method = "pdflatex";

      syntax_enable = 1;
      format_enabled = "1";
      quickfix_mode = 0;

      toc_config = {
        split_pos = "vert topleft";
        split_width = 40;
      };
      view_method = "zathura";
    };
  };
}
