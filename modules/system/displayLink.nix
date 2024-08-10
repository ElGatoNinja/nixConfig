{ pkgs, ... }:

{
  boot.kernelModules = ["evdi"];
  services.xserver.videoDrivers = [ "amdgpu"];
}