{pkgs, config, ...}: 
let 
  color = import ../hyprland/palette.nix;
in 
{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window = {
      opacity = 0.8;
      padding ={ 
        x = 10;
        y = 8;
      };
    };
    colors = with config.colorScheme.palette; {
      bright = {
        black = "0x${base00}";
        blue = "0x${base0D}";
        cyan = "0x${base0C}";
        green = "0x${base0B}";
        magenta = "0x${base0E}";
        red = "0x${base08}";
        white = "0x${base06}";
        yellow = "0x${base09}";
      };
      cursor = {
        cursor = "0x${base06}";
        text = "0x${base06}";
      };
      search = {
        matches = {
          foreground="0x${base00}";
          background="0x${base0F}";
        };
        focused_match={
          foreground="0x${base00}";
          background="0x${base0A}";
        };
      };
      normal = {
        black = "0x${base00}";
        blue = "0x${base0D}";
        cyan = "0x${base0C}";
        green = "0x${base0B}";
        magenta = "0x${base0E}";
        red = "0x${base08}";
        white = "0x${base06}";
        yellow = "0x${base0A}";
      };
      primary = {
        background = "0x${color.base0}";
        foreground = "0x${base06}";
      };
    };
  };

  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.settings = with config.colorScheme.palette; 
  let
    section_user = {fg="${base06}"; bg="${base08}";};
    section_dir = {fg="${base06}"; bg="${base09}";};
    section_git_branch = {fg="${base06}"; bg="${base0B}";};
    section_docker = {fg="${base06}"; bg="${base0A}";};
    section_time = {fg="${base06}"; bg="${base02}";};
  in
  {
    format = "[](#${section_user.bg})"
      +"$username"
      +"[](fg:#${section_user.bg} bg:#${section_dir.bg})"
      +"$directory"
      +"[](fg:#${section_dir.bg} bg:#${section_git_branch.bg})"
      +"$git_branch"
      +"$git_status"
      +"[](fg:#${section_git_branch.bg} bg:#${section_docker.bg})"
      +"$docker_context"
      +"[](fg:#${section_docker.bg} bg:#${section_time.bg})"
      +"$time"
      +"[ ](fg:#${section_time.bg})"
      +"$character";

    username = {
      show_always = true;
      style_user = "bg:#${section_user.bg} fg:#${section_user.fg}";
      style_root = "bg:#${section_user.bg} fg:#${section_user.fg}";
      format = "[󱄅 $user]($style)";
    };
    directory = {
      style = "bg:#${section_dir.bg} fg:#${section_dir.fg}";
      format = "[ $path ]($style)";
      truncation_length = 3;
      truncation_symbol = "…/";
      substitutions = {
        Documents = "󰈙 ";
        Downloads = " ";
        Music = "󰝚 ";
        Pictures = " ";
        Developer = "󰲋 ";
        ".flake" = " ";
      };
    };

    # nix_shell = {
    #   symbol = "";
    #   format = "[$symbol$name]($style) ";
    #   style = "bright-purple bold";
    # };
    git_branch = {
      format = "[[ $symbol $branch ](fg:#${section_git_branch.fg} bg:#${section_git_branch.bg})]($style)";
      symbol = "";
      style = "#${base0B}";
    };
    # git_commit = {
    #   only_detached = true;
    #   format = "[ﰖ$hash]($style) ";
    #   style = "bright-yellow bold";
    # };
    # git_state = {
    #   style = "bright-purple bold";
    # };
    git_status = {
      style = "bg:#${section_git_branch.bg}";
      format = "[[($all_status$ahead_behind )](fg:#${section_git_branch.fg} bg:#${section_git_branch.bg})]($style)";
    };

    docker_context = {
      symbol = "";
      style = "bg:${section_docker.bg}";
      format = "[[ $symbol( $context) ](fg:#${section_docker.fg} bg:#${section_docker.bg})]($style)";
    };

    time = {
      disabled = false;
      time_format = "%R";
      style = "bg:${section_time.bg}";
      format = "[[  $time ](fg:#${section_time.fg} bg:#${section_time.bg})]($style)";
    };
    
    # cmd_duration = {
    #   format = "[$duration]($style) ";
    #   style = "#${base0B}";
    # };

    character = {
      success_symbol = "[](bold fg:#${base0D})";
      error_symbol = "[](bold fg:#${base0E})";
    };
  };
}