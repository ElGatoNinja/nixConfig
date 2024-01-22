{
    description = "My first flake!";
    
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        home-manager = { 
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        #hyprland.url = "github:hyprwm/Hyprland";
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
