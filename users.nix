# take users and the inputs, returns a list with configurations from the ./users dir and a
# final configuration of home-manager with every user 

{users, inputs}: 
  map (user : ./users/${user}/${user}.nix) users
  ++ 
  [(
    {...}: {
      home-manager = {
        extraSpecialArgs = { inherit inputs;};
        users = builtins.listToAttrs (map (user: {
          name = user; 
          value = import ./users/${user}/home.nix; 
        }) users);
      };
    }
  )]
  
