{
    description = "My first flake!";
    
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable"; #temporary
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager = { 
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.2";
            inputs.nixpkgs.follows="nixpkgs";
        };

        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
        nix-colors.url = "github:misterio77/nix-colors";
        sops-nix.url = "github:Mic92/sops-nix";
        swww.url = "github:LGFae/swww";
    };

    outputs = {self ,nixpkgs, nixpkgs-unstable, ...}@inputs: 
        let 
            system="x86_64-linux";
            pkgs = import nixpkgs {
                inherit system; 
                config.allowUnfree = true;
            };

            pkgsUnstable = import nixpkgs-unstable {
                inherit system; 
                config.allowUnfree = true;
            };

            args = {
                inherit inputs pkgs pkgsUnstable system; 
                hostName = "home";
            };

            specialArgs = {
                inherit inputs pkgsUnstable system;
                hostName = "home";
            };
            
            usersConfig = import ./users.nix; 
        in {
            nixosConfigurations = {
                home = nixpkgs.lib.nixosSystem {
                    inherit specialArgs;
                    modules = [ 
                        ./hosts/home/configuration.nix
                        ./hosts/home/hardware-configuration.nix
                        ./modules/system/hyprland.nix
                        ./modules/system/i18n.nix
                        ./modules/system/networking.nix
                        ./modules/system/audio.nix
                        ./modules/system/swap.nix
                        ./modules/system/virtualisation.nix
                        ./modules/system/displayLink.nix
                        ./modules/fish.nix
                        ./modules/nh.nix
                        ./modules/hardware/bluetooth.nix
                        ./modules/system/sopsSecrets.nix
                        inputs.sops-nix.nixosModules.sops
                        inputs.home-manager.nixosModules.default 
                        inputs.lanzaboote.nixosModules.lanzaboote
                        { nixpkgs.pkgs = pkgs; }
                    ]
                    ++ (usersConfig {
                            users = [ "jaime" ]; 
                            inherit args;
                        });
                };
            };
        };
}
