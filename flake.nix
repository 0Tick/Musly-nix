{
  description = "Musly packaged for Nix/NixOS with flutter-nix";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flutter-nix = {
      url = "github:ilkecan/flutter-nix";
      inputs.flake-utils.follows = "flake-utils";
    };
    nixpkgs.follows = "flutter-nix/nixpkgs";
  };

  outputs = { self, flake-utils, flutter-nix, nixpkgs, ... }:
    let
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          overlays = [
            flutter-nix.overlay
            self.overlays.default
          ];
          config.allowUnfree = true;
        };
    in
    {
      overlays.default = import ./overlay.nix { inherit self; };
    }
    // flake-utils.lib.eachSystem flutter-nix.supportedSystems (system:
      let
        pkgs = mkPkgs system;
      in
      {
        packages = {
          musly = pkgs.musly;
          default = pkgs.musly;
        };

        devShells.default = pkgs.flutter-nix.mkShell {
          linux.enable = true;
        };
      });
}
