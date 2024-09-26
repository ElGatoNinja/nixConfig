{ config, ... }:
{
    
    sops.defaultSopsFile = ../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.keyFile = "/home/jaime/.config/sops/age/keys.txt";
    sops.secrets."github/sshkey" = {
      owner = "git-ssh-service"; 
    };

    systemd.services."git-ssh-service" = {
      script = ''
        echo 
        ssh-add - <<< ${config.sops.secrets."github/sshkey".path} ;
      '';
      serviceConfig = {
        User = "git-ssh-service";
        WorkingDirectory = "/var/lib/git-ssh-service";
      };
    };

    users.users."git-ssh-service" = {
      home = "/var/lib/git-ssh-service";
      createHome = true;
      isSystemUser = true;
      group = "git-ssh-service";
    };
    users.groups."git-ssh-service" = {};
}