let src = ./zen.linux-x86_64.tar.xz;
in
{ pkgs, stdenv, ... }:
rec {
  zen-pkg = stdenv.mkDerivation {
    name = "zen-browser";
    pname = "zen-browser";
    inherit src;
  
    nativeBuildInputs = with pkgs; [
      wrapGAppsHook3
      autoPatchelfHook
      patchelfUnstable
    ];

    buildInputs = with pkgs; [
      gtk3
      adwaita-icon-theme
      alsa-lib
      dbus-glib
    ];

    runtimeDependencies = with pkgs; [
      libGL
      libpci
    ];

    installPhase =
    ''
      mkdir -p $out/lib
      mkdir -p $out/bin
      cp ./* -r $out/lib
      ln -s $out/lib/zen $out/bin/zen
    '';
  };
}
