{config,...}: {
  programs.chromium.enable = true;
  programs.chromium.extraOpts.BrowserThemeColor = config.colorScheme.colors.base00;
}