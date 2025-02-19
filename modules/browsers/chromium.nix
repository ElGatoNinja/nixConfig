{config,...}: {
  programs.chromium.enable = false;
  programs.chromium.extensions = [
    "cjpalhdlnbpafiamejdnhcphjbkeiagm" #ublock
  ];
}