let 
  users = ["jaime" "marcos" "antonio" "cristel"];
  inputs = 0;
  usersConfig = import ./users.nix; 
in
  [ 
    ./hosts/home/configuration.nix
  ] 
    ++ (usersConfig {
            users = users; 
            inherit inputs;
        })
  #usersConfig {users= users; inputs=inputs;}
