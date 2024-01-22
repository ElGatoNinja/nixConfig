{pkgs, ... }:
{
  users.users.jaime = {
    isNormalUser = true;
    initialPassword = "12345";
    description = "handsome user";
    packages = with pkgs; [
      brave
      discord
    #  thunderbird
    ];
  };
}