{pkgs, config, ...}:
{
  programs.waybar.enable = true;

  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
  });

  programs.waybar.systemd.enable = true;
  programs.waybar.settings = {
    mainbar = {
      layer = "top";
      position = "top";

      modules-left= [
        "custom/launcher"  
    ];

      modules-center= [
        "hyprland/workspaces"
      ];

      "wlr/workspaces"= {
        active-only= false;
        all-outputs= false;
        disable-scroll= false;
        on-scroll-up= "hyprctl dispatch workspace e-1";
        on-scroll-down= "hyprctl dispatch workspace e+1";
        format = "{name}";
        on-click= "activate";
        format-icons= {
            urgent= "";
            active= "";
            default = "";
            sort-by-number= true;
        };
      };

      modules-right = [
        "tray"
        "network"
        "cpu"
        "memory"
        "temperature"
        "clock"
      ];

      "custom/launcher"= {
        format= "";
        on-click= "pkill rofi || rofi -show drun";
        tooltip= "false";
      };


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

  programs.waybar.style = with config.colorScheme.palette; ''
    ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
    
    * {
        border: none;
        border-radius: 0px;
        font-family: 'FiraCode Nerd Font Mono';
        font-weight: bold;
        font-size: 15px;
        min-height: 0;
    }

    window#waybar {
        background: transparent;
        border-bottom: none;
    }
    #workspaces {
        background: #${base02};
        margin: 5px 5px;
        padding: 8px 12px;
        border-radius: 12px 12px 24px 24px;
        color: #${base0A}
    }
    #workspaces button {
        padding: 0px 5px;
        margin: 0px 3px;
        border-radius: 15px;
        color: #${base06};
        background: #${base08};
        transition: all 0.2s ease-in-out;
    }

    #workspaces button.active {
        background-color: #${base0A};
        color: #${base06};
        border-radius: 15px;
        min-width: 35px;
        background-size: 200% 200%;
        transition: all 0.2s ease-in-out;
    }

    #workspaces button:hover {
        background-color: #b4befe;
        color: #${base06};
        border-radius: 15px;
        background-size: 200% 200%;
    }

    #custom-launcher {
        color: #${base08};
        background: #${base02};
        border-radius: 0px 0px 40px 0px;
        margin: 0px;
        padding: 0px 30px 0px 10px;
        font-size: 28px;
    }

    #tray, #network, #cpu, #memory, #clock {
        background: #${base02};
        font-weight: bold;
        margin: 5px 0px;
    }

    #cpu {
        color: #${base07};
        border-radius: 10px 0px 0px 24px;
        padding-left: 15px;
        padding-right: 9px;
        margin-left: 7px;
    }
    #memory {
        color: #${base07};
        border-radius: 0px 0 0px 0px;      
        padding-left: 9px;
        padding-right: 9px;
    }
    #disk {
        color: #${base07};
        border-radius: 0px 24px 10px 0px;      
        padding-left: 9px;
        padding-right: 15px;
    }

    #tray {
        color: #${base07};
        border-radius: 10px 24px 10px 24px;
        padding: 0 20px;
        margin-left: 7px;
    }

    #network {
        color: #${base07};
        border-radius: 0px 24px 10px 0px;      
        padding-left: 9px;
        padding-right: 15px;
    }
    
    #clock {
        color: #${base07};
        border-radius: 0px 0px 0px 40px;
        padding: 10px 10px 15px 25px;
        margin-left: 7px;
        font-size: 16px;
    }
  '';
}