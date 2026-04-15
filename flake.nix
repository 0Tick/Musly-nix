{
  description = "Musly Flutter app packaged with Nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      overlays.default = final: prev: {
        "musly-player" = final.callPackage ./nix/package.nix { };
        muslyPlayer = final."musly-player";
        musly = final."musly-player";
      };

      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        {
          default = pkgs."musly-player";
          "musly-player" = pkgs."musly-player";
          muslyPlayer = pkgs."musly-player";
          musly = pkgs."musly-player";
        }
      );
    };
}