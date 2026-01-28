{
  description = "Drachh's configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ { self, nixpkgs, home-manager, stylix }: 
  let 
    system = "x86_64-linux";

    hostname = "nixOS";
    username = "drachh";
  in
  {
    nixosConfigurations = {
      nixOS = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit hostname username;
        };

        modules = [ 
          ({ ... }: {
            _module.args = { inherit hostname username; };
            home-manager.extraSpecialArgs = { };
          })

          home-manager.nixosModules.default
          ./nixos
          ./home

          stylix.nixosModules.stylix
        ];
      };
    };
  };
}
