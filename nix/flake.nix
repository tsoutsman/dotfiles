{
  description = "nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nix-darwin,
      self,
      ...
    }:
    {
      darwinConfigurations."darwin-laptop" = nix-darwin.lib.darwinSystem {
        modules = [
          ./shared/default.nix
          ./host/darwin-laptop/default.nix
        ];
        specialArgs = { inherit inputs self; };
      };
    };
}
