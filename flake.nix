{
  description = "My NixOS configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # farewell :')
    # mango = {
    #   url = "github:DreamMaoMao/mango";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    packages.${system}.default = pkgs.hello;
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { };
      modules = [
        ./system
        # inputs.mango.nixosModules.mango {
        #   programs.mango.enable = true;
        # }
        ({ ... }: {
            programs.niri.enable = true;
        })
      ];
    };

    homeConfigurations.vid = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      specialArgs = {};
      modules = [];
    };
  };
}
