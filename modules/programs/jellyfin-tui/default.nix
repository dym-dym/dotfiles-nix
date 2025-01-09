{ pkgs, lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "jellyfin-tui";
  version = "1.0.4";

  src = fetchFromGitHub {
    owner = "dhonus";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Tcc4e8oz2OZfdO9iNvU+TjJlct2IB5iJ3u2usf9D7iY=";
  };

  cargoHash = "sha256-Jzzp1wsimHehpPnhE0haKgGH/C2HXRnBdfI5OScWaS4=";

  doCheck = false;

  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

  nativeBuildInputs = [
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.mpv
    pkgs.openssl
  ];

  meta = {
    description = "Jellyfin music streaming client for the terminal";
    homepage = "https://github.com/dhonus/jellyfin-tui";
    license = lib.licenses.gpl3;
  };
}
