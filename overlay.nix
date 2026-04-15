{ self }:
final: prev: {
  musly = final.callPackage ./nix/musly.nix {
    src = self;
  };
}
