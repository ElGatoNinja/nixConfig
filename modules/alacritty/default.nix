{pkgs, config, ...}: 
{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window = {
      padding ={ 
        x = 5;
        y = 5;
      };
    };
    colors = with config.colorScheme.colors; {
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
        background = "0x${base00}";
        foreground = "0x${base06}";
      };
    };
  };
}