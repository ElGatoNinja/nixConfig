{
    description = "My first flake!";
    
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager = { 
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland.url = "github:hyprwm/Hyprland";
        nix-colors.url = "github:misterio77/nix-colors";
    };

    outputs = {self ,nixpkgs, ...}@inputs: 
        let 
            system="x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
            
            usersConfig = import ./users.nix; 
        in {
            nixosConfigurations = {
                home = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs;};
                    modules = [ 
                        ./hosts/home/configuration.nix
                        inputs.home-manager.nixosModules.default 
                    ] 
                    ++ (usersConfig {
                            users = [ "jaime" ]; 
                            inherit inputs;
                        });
                };
            };
        };
}
