{ flutter-nix, src ? ../. }:
flutter-nix.buildFlutterApp {
  inherit src;
  name = "musly";
  platform = "linux";
}
