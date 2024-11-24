# take users and the inputs, returns a list with configurations from the ./users dir and a
# final configuration of home-manager with every user 

{users, args}: 
  map (user : ./users/${user}/${user}.nix) users
  ++ 
  [(
    {...}: {
      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs = args;
        users = builtins.listToAttrs (map (user: {
          name = user; 
          value = import ./users/${user}/home.nix; 
        }) users);
      };
    }
  )]
  
