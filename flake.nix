{
    description = "My first flake!";
    
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        home-manager = { 
            url = "github:nix-community/home-manager/release-24.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.3.0";
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
            
            args = {
                inherit inputs;
                pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                };
                pkgsUnstable = import nixpkgs-unstable{
                    inherit system;
                    config.allowUnfree = true;
                };
                hostName="home"; 
            };
            usersConfig = import ./users.nix; 
        in {
            nixosConfigurations = {
                home = nixpkgs.lib.nixosSystem {
                    specialArgs = args;
                    modules = [ 
                        ./hosts/home/configuration.nix
                        inputs.home-manager.nixosModules.default 
                        inputs.lanzaboote.nixosModules.lanzaboote
                    ]
                    ++ (usersConfig {
                            users = [ "jaime" ]; 
                            inherit args;
                        });
                };
            };
        };
}
