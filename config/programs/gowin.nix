{ stdenv, ... }:
stdenv.mkDerivation {
	src = ./Gowin_V1.9.10.03_Education_linux.tar.gz;
	installPhase = "mv ./* $out";
}
