{pkgs, ... }:
{
  users.users.jaime = {
    isNormalUser = true;
    initialPassword = "12345";
    description = "handsome user";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    #  brave
    #  discord
    #  thunderbird
    ];
  };
}