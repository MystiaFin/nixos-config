{
  description = "Multi-machine NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      stateVersion = "26.05";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkHost =
        hostName:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs stateVersion; };
          modules = [
            ./modules/hosts/${hostName}/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs stateVersion hostName; };
              home-manager.users.mystiafin = {
                imports = [
                  ./modules/config
                  ./modules/pkgs
                  ./modules/hosts/${hostName}/home
                ];
              };
            }
            ./modules/shared/default.nix
          ];
        };

      mkHome =
        hostName:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs stateVersion hostName; };
          modules = [
            {
              home = {
                username = "mystiafin";
                homeDirectory = "/home/mystiafin";
                inherit stateVersion;
              };
            }
            ./modules/config
            ./modules/pkgs
            ./modules/hosts/${hostName}/home
          ];
        };
    in
    {
      nixosConfigurations = {
        kanade = mkHost "kanade";
        mafuyu = mkHost "mafuyu";
      };
      homeConfigurations = {
        kanade = mkHome "kanade";
        mafuyu = mkHome "mafuyu";
      };
    };
}
