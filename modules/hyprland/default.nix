{ pkgs, inputs, ... }:{
  # home.packages = with pkgs; [
  #     wofi 
  #     swaybg 
  #     wlsunset 
  #     wl-clipboard 
  #     hyprland
  # ];
  # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;

  wayland.windowManager.hyprland = {
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    enable= true;

    settings = {
      decoration = {
        shadow_offset = "0 5";
        rounding = 10;
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };
      general = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 4;
        gaps_out = 16;
        border_size = 3;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      animations = {
          enabled = "yes";

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
      };

        "$terminal" = "kitty";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";

        "$mod" = "SUPER";

        bind = [ 
          "$mod , T, exec, $terminal"
          "$mod, C, killactive,"
          "$mod, E, exec, $fileManager"
          "$mod, V, togglefloating,"
          "$mod, R, exec, $menu"
          "$mod, P, pseudo," # dwindle
          "$mod, J, togglesplit," # dwindl
        ];

        bindm = [
          # mouse movements
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];
      misc = {
        disable_hyprland_logo = true;
      };
    };
  };
}

# monitor = ",preferred,auto,auto";

#       "$terminal" = "kitty";
#       "$fileManager" = "dolphin";
#       "$menu" = "wofi --show drun";

#       # Some default env vars.
#       env = [
#         "XCURSOR_SIZE,24"
#         "QT_QPA_PLATFORMTHEME,qt5ct" # change to qt6ct if you have that
#       ];

#       input = {
#         kb_layout = "us";
#         kb_variant = "";
#         kb_model = "";
#         kb_options = "";
#         kb_rules = "";
        
#         follow_mouse = 1;
#         touchpad = {
#           natural_scroll = "no";
#         };

#         sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
#       };

#       general = {
#           # See https://wiki.hyprland.org/Configuring/Variables/ for more

#           gaps_in = 5;
#           gaps_out = 20;
#           border_size = 2;
#           "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
#           "col.inactive_border" = "rgba(595959aa)";

#           layout = "dwindle";

#           # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
#           allow_tearing = false;
#       };

#       decoration = {
#           # See https://wiki.hyprland.org/Configuring/Variables/ for more

#           rounding = 10;

#           blur = {
#               enabled = true;
#               size = 3;
#               passes = 1;
#           };

#           drop_shadow = "yes";
#           shadow_range = 4;
#           shadow_render_power = 3;
#           "col.shadow" = "rgba(1a1a1aee)";
#       };

#       animations = {
#           enabled = "yes";

#           # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

#           bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
#           animation = [
#             "windows, 1, 7, myBezier"
#             "windowsOut, 1, 7, default, popin 80%"
#             "border, 1, 10, default"
#             "borderangle, 1, 8, default"
#             "fade, 1, 7, default"
#             "workspaces, 1, 6, default"
#           ];
#       };

#       dwindle = {
#           # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
#           pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
#           preserve_split = "yes"; # you probably want this
#       };

#       master = {
#           # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
#           new_is_master = true;
#       };

#       gestures = {
#           # See https://wiki.hyprland.org/Configuring/Variables/ for more
#           workspace_swipe = false;
#       };

#       misc = {
#           # See https://wiki.hyprland.org/Configuring/Variables/ for more
#           force_default_wallpaper = -1; # Set to 0 to disable the anime mascot wallpapers
#       };

#       # Example per-device config
#       # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
#       "device:epic-mouse-v1" = {
#           sensitivity = -0.5;
#       };

#       # Example windowrule v1
#       # windowrule = float, ^(kitty)$
#       # Example windowrule v2
#       # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
#       # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
#       windowrulev2 = "nomaximizerequest, class:.*"; # You'll probably like this.


#       # See https://wiki.hyprland.org/Configuring/Keywords/ for more
#       "$mainMod" = "SUPER";

#       # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
#       bind = [ 
#         "$mainMod, Q, exec, $terminal"
#         "$mainMod, C, killactive,"
#         "$mainMod, M, exit,"
#         "$mainMod, E, exec, $fileManager"
#         "$mainMod, V, togglefloating,"
#         "$mainMod, R, exec, $menu"
#         "$mainMod, P, pseudo," # dwindle
#         "$mainMod, J, togglesplit," # dwindl

#         # Move focus with mainMod + arrow keys
#         "$mainMod, left, movefocus, l"
#         "$mainMod, right, movefocus, r"
#         "$mainMod, up, movefocus, u"
#         "$mainMod, down, movefocus, d"

#         # Switch workspaces with mainMod + [0-9]
#         "$mainMod, 1, workspace, 1"
#         "$mainMod, 2, workspace, 2"
#         "$mainMod, 3, workspace, 3"
#         "$mainMod, 4, workspace, 4"
#         "$mainMod, 5, workspace, 5"
#         "$mainMod, 6, workspace, 6"
#         "$mainMod, 7, workspace, 7"
#         "$mainMod, 8, workspace, 8"
#         "$mainMod, 9, workspace, 9"
#         "$mainMod, 0, workspace, 10"

#         # Move active window to a workspace with mainMod + SHIFT + [0-9]
#         "$mainMod SHIFT, 1, movetoworkspace, 1"
#         "$mainMod SHIFT, 2, movetoworkspace, 2"
#         "$mainMod SHIFT, 3, movetoworkspace, 3"
#         "$mainMod SHIFT, 4, movetoworkspace, 4"
#         "$mainMod SHIFT, 5, movetoworkspace, 5"
#         "$mainMod SHIFT, 6, movetoworkspace, 6"
#         "$mainMod SHIFT, 7, movetoworkspace, 7"
#         "$mainMod SHIFT, 8, movetoworkspace, 8"
#         "$mainMod SHIFT, 9, movetoworkspace, 9"
#         "$mainMod SHIFT, 0, movetoworkspace, 10"

#         # Example special workspace (scratchpad)
#         "$mainMod, S, togglespecialworkspace, magic"
#         "$mainMod SHIFT, S, movetoworkspace, special:magic"

#         # Scroll through existing workspaces with mainMod + scroll
#         "$mainMod, mouse_down, workspace, e+1"
#         "$mainMod, mouse_up, workspace, e-1"
#       ];

#       bindm = [
#         # Move/resize windows with mainMod + LMB/RMB and dragging
#         "$mainMod, mouse:272, movewindow"
#         "$mainMod, mouse:273, resizewindow"
#       ];