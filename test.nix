let 
  users = ["jaime" "marcos" "antonio" "cristel"];
  args = {a= 0; b=2;};
  usersConfig = import ./users.nix; 
in
  [ 
    ./hosts/home/configuration.nix
  ] 
    ++ (usersConfig {
            users = users; 
            inherit args;
        })
  #usersConfig {users= users; inputs=inputs;}
