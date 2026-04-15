# Nix Packaging Notes

This repository packages Musly as an unfree package (`CC BY-NC-SA 4.0`).
To install it with Nix, allow this package explicitly via `allowUnfreePredicate`.

## Flake usage

Build/run directly from this repo:

```bash
nix build .#musly-player --impure
nix run .#musly-player --impure
```

> `--impure` is needed only if you rely on environment variables like `NIXPKGS_ALLOW_UNFREE=1`.

## NixOS (`configuration.nix`)

If you import this flake as an input and use its overlay:

```nix
{
  nixpkgs.overlays = [ inputs.musly.overlays.default ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "musly-player"
    ];

  environment.systemPackages = [ pkgs.muslyPlayer ];
}
```

## Home Manager

When using Home Manager with `pkgs.muslyPlayer`:

```nix
{
  nixpkgs.overlays = [ inputs.musly.overlays.default ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (pkgs.lib.getName pkg) [
      "musly-player"
    ];

  home.packages = [ pkgs.muslyPlayer ];
}
```

## Temporary CLI override

For one-off builds/runs without changing config:

```bash
NIXPKGS_ALLOW_UNFREE=1 nix build .#musly-player --impure
NIXPKGS_ALLOW_UNFREE=1 nix run .#musly-player --impure
```

## Non-flake (`default.nix`)

This repo also provides `default.nix`:

```bash
NIXPKGS_ALLOW_UNFREE=1 nix-build
```
