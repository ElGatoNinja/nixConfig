{pkgs, config, ...}: 
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      yzhang.markdown-all-in-one
      ms-vscode-remote.remote-containers
      mhutchie.git-graph
      pkief.material-icon-theme
      #golf1052.base16-generator
    ];
    userSettings = {
      "window.titleBarStyle"="custom"; #compatibility with hyperland
      
      "workbench.iconTheme" = "material-icon-theme";

      #nix-ide
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        nil = {
          diagnostics = {
            ignored = ["unused_binding" "unused_with"];
          };
          formatting = {
            command= ["nixpkgs-fmt"];
          };
        };
      };
    };
  };
}