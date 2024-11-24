# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, hostName, ... }:

{
  networking.hostName = hostName;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/system/hyprland.nix
      ../../modules/system/i18n.nix
      ../../modules/system/networking.nix
      ../../modules/system/audio.nix
      ../../modules/system/swap.nix
      ../../modules/system/virtualisation.nix
      ../../modules/system/displayLink.nix
      ../../modules/nh.nix
      ../../modules/nh.nix

      ../../modules/hardware/bluetooth.nix

      ../../modules/system/sopsSecrets.nix
      inputs.sops-nix.nixosModules.sops
    ];
  

  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   extraPackages = [
  #     pkgs.rocmPackages.clr.icd
  #     pkgs.amdvlk
  #   ];
  # };

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_latest;                     
  boot.loader.efi.canTouchEfiVariables = true;
  boot.bootspec.enable = true;

  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
  
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    videoDrivers = [ "amdgpu"];
    # desktopManager.plasma5.enable = true;
  };

  services.displayManager.sddm = {
      enable = true;
      theme = "${import ../../modules/login/login-theme.nix {inherit pkgs;}}";
  };

  # starship dependency
  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
    

  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    set fish_greeting # Disable greeting

    starship init fish | source

    function y
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      set cwd (command cat -- "$tmp")
      if [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
      end
      rm -f -- "$tmp"
    end
  '';

  users.defaultUserShell = pkgs.fish;

  # XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nil
    git
    sbctl #boot info
    alacritty
    yazi #terminal file manager
    fastfetch

    sops

    # #hyprland shits
    swaybg
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    }))



    rofi-wayland #app
    xdg-desktop-portal-gtk

    libnotify #notification
    dunst #notification

    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects

    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    rocmPackages.rocm-core

  ];



  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
