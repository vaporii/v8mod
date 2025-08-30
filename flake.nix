{
  description = "v8mod flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      name = "v8mod";
      nativeBuildInputs = [ pkgs.cmake ];
      buildInputs = [ pkgs.sdl3 ];
    };

    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        gcc
      ];
    };
  };
}
