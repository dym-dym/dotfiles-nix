{pkgs, ...}: let
  system = "x86_64-linux";
in {
  home = {
    packages = with pkgs; [
      atuin
      signal-desktop
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      font-awesome
      nerd-fonts.noto
      noto-fonts
      noto-fonts-color-emoji
      ueberzugpp
      ffmpegthumbnailer
      unar
      coq
      # coqPackages.coq-lsp
      neovim-remote
    ];
  };

  programs = {
    # home-manager.enable = true;
    eza.enable = true;
    ripgrep.enable = true;

    git = {
      enable = true;
      settings = {
        user = {
          name = "Dylan Bettendroffer";
          email = "dylan.bettendroffer@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
