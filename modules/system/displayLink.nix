{ pkgs, ... }:

{
  boot.kernelModules = ["evdi"];
  services.xserver.videoDrivers = ["displaylink" "modesetting"];
}