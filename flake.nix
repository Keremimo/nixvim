{
  description = "Kerem's Nixvim Setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { self, nixpkgs, nixvim, flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config;
            extraSpecialArgs = { };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          formatter = pkgs.alejandra;

          packages = {
            default = nvim;
          };
        };

      flake = {
        nixosModules.nixvim = { pkgs, ... }: {
          imports = [ nixvim.nixosModules.nixvim ];
          programs.nixvim = {
            enable = true;
            # Import your configuration
            imports = [ ./config ];
          };
        };

	nixDarwinModules.nixvim = { pkgs, ... }: {
          imports = [ nixvim.nixDarwinModules.nixvim ];
          programs.nixvim = {
            enable = true;
            # Import your configuration
            imports = [ ./config ];
          };
        };

        homeManagerModules.nixvim = { pkgs, ... }: {
          imports = [ nixvim.homeManagerModules.nixvim ];
          programs.nixvim = {
            enable = true;
            # Import your configuration
            imports = [ ./config ];
          };
        };
      };
    };
}
