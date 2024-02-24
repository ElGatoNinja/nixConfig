{pkgs,...}:
{
  programs.waybar.enable = true;
  programs.waybar.package = pkgs.waybar;
  programs.waybar.systemd.enable = true;
  programs.waybar.settings = {
    mainbar = {
      layer = "top";
      position = "top";
      "margin-top" = 14; 
      "margin-bottom" = 0;

      "modules-center" = [
        "hyprland/workspaces"
      ];

      "modules-right" = [
        "network"
        "cpu"
        "memory"
        "temperature"
        "clock"
      ];

      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };

      cpu = {
        format = "{usage}% ";
        tooltip = true;
      };

      memory = { format = "{}% "; };
      network = {
        interval = 1;
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "󰈁 󰕒 {bandwidthUpBits}  󰇚 {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
      };

      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
    };
  };

  programs.waybar.style = ''
    ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
    window#waybar {
      background: transparent;
      border-bottom: none;
    }
  '';
}