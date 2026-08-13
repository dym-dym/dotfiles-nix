{pkgs, ...}: {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        # Common language servers
        nixd.enable = true;
        ruff.enable = true;

        # LaTeX config
        ltex.enable = true; # autocorrect

        # Packages is set to null to rely on the system wide installed packages
        # this is done to avoid conflicts with the nixpkgs versions.

        prolog_ls = {
          enable = true;
          package = null; # default pkgs.swi-prolog;
        };

        ocamllsp.enable = true;

        agda_ls.enable = true;
        agda_ls.package = null;
        

      };

      keymaps.lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "gt" = "type_definition";
        "gi" = "implementation";
        "K" = "hover";
      };
    };
    rustaceanvim.enable = true;
  };
}
