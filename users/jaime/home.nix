{ config, pkgs, pkgsUnstable, inputs, ... }:
{
  home.username = "jaime";
  home.homeDirectory = "/home/jaime";

  imports = [
    ../../modules/alacritty
    ../../modules/vscode
    ../../modules/browsers/chromium.nix
    ../../modules/fish.nix
    
    inputs.nix-colors.homeManagerModules.default
  ];

  #colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-soft;
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-soft;


  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaDark;
    name = "Catppuccin-Mocha-Dark-Cursors";
    size = 40;
    gtk.enable = true;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.git = {
    enable = true;
    userName = "ElGatoNinja";
    userEmail = "JaimeGAlonso@outlook.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "*";
    };
  };


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jaime/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
