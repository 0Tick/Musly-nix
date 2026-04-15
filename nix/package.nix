{
  lib,
  alsa-lib,
  copyDesktopItems,
  flutter,
  makeDesktopItem,
  mpv,
}:

flutter.buildFlutterApplication rec {
  pname = "musly-player";
  version = "1.0.8+1";

  src = lib.cleanSource ../.;
  pubspecLock = lib.importJSON ./pubspec.lock.json;

  nativeBuildInputs = [
    copyDesktopItems
  ];

  buildInputs = [
    alsa-lib
    mpv
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "musly-player";
      exec = "musly";
      icon = "musly-player";
      desktopName = "Musly Player";
      genericName = "Music Player";
      comment = "Cross-platform Navidrome/Subsonic client and music player";
      categories = [
        "Audio"
        "AudioVideo"
        "Player"
      ];
      terminal = false;
      startupNotify = true;
    })
  ];

  postInstall = ''
    install -Dm644 assets/logo.png $out/share/pixmaps/musly-player.png
  '';

  extraWrapProgramArgs = ''
    --prefix LD_LIBRARY_PATH : $out/app/${pname}/lib:${lib.makeLibraryPath [ mpv ]}
  '';

  meta = {
    description = "Cross-platform Navidrome/Subsonic client and music player";
    homepage = "https://github.com/0Tick/Musly-nix";
    license = lib.licenses.cc-by-nc-sa-40;
    mainProgram = "musly";
    platforms = lib.platforms.linux;
  };
}