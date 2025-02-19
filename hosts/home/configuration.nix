{ inputs, config, pkgs, pkgsUnstable, lib, hostName,  ... }:

{
  config = {
    networking.hostName = hostName;

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.bootspec.enable = true;

    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    boot.initrd.kernelModules = ["amdgpu"];

    services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      videoDrivers = [ "amdgpu"];
    };

    services.displayManager.sddm = {
        enable = true;
        theme = "${import ../../modules/login/login-theme.nix {inherit pkgs;}}";
    };

    fonts.packages = with pkgs;[
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
    ];

    users.defaultUserShell = pkgs.fish;

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    services.printing.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    environment.systemPackages = with pkgs; [
      nil
      git
      sbctl
      alacritty
      yazi
      fastfetch
      firefox

      sops

      swaybg
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      }))

      rofi-wayland
      xdg-desktop-portal-gtk

      libnotify
      dunst

      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects

      rocmPackages.rocm-smi
      rocmPackages.rocminfo
      rocmPackages.rocm-core

      bambu-studio
    ];

    system.stateVersion = "23.11";
  };
}