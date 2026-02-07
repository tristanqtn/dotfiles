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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Deactivated
    # Niri window manager
    #niri = {
    #  url = "github:sodiboo/niri-flake";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    # Noctalia shell
    #noctalia = {
    #  url = "github:noctalia-dev/noctalia-shell";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs =
    inputs@{
      nvf,
      self,
      stylix,
      nixpkgs,
      home-manager,
      firefox-addons,

      # Deactivated
      #niri,
      #noctalia,
      ...
    }:
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
            inherit hostname username inputs;
          };

          modules = [
            (
              { ... }:
              {
                _module.args = {
                  inherit
                    hostname
                    username
                    nvf
                    inputs
                    ;
                };
                home-manager.extraSpecialArgs = { inherit firefox-addons inputs; };
              }
            )

            home-manager.nixosModules.default
            ./home
            ./nixos

            stylix.nixosModules.stylix

            # Deactivated
            # Niri module
            #niri.nixosModules.niri

            # Noctalia NixOS module
            #noctalia.nixosModules.default
          ];
        };
      };
    };
}
