{
  description = "";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          wavebg = pkgs.stdenv.mkDerivation {
            name = "wavebg";
            src = ./.;

            depsBuildBuild = with pkgs; [pkg-config];
            nativeBuildInputs = with pkgs; [meson ninja pkg-config scdoc wayland-scanner];
            buildInputs = with pkgs; [wayland wayland-protocols cairo gdk-pixbuf];
          };
          default = wavebg;
        };
      }
    );
}
