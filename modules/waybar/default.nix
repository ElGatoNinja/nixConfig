{pkgs}:
{
  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;
  programs.waybar.settings = {
    layer = "top";
    position = "top";
    "margin-top" = 14; 
    "margin-bottom" = 0;

    "modulse-center" = [
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
      format = "{usage}% ";
      tooltip = false;
    };

    memory = { format = "{}% "; };
    network = {
      interval = 1;
      format-alt = "{ifname}: {ipaddr}/{cidr}";
      format-disconnected = "Disconnected ⚠";
      format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
      format-linked = "{ifname} (No IP) ";
      format-wifi = "{essid} ({signalStrength}%) ";
    };

    temperature = {
      critical-threshold = 80;
      format = "{temperatureC}°C {icon}";
      format-icons = [ "" "" "" ];
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