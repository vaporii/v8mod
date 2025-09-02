{
  description = "v8mod flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, nixpkgs, zig }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      name = "v8mod";
      nativeBuildInputs = [ zig.packages.x86_64-linux."0.14.0" pkgs.sdl3 ];
      buildInputs = [ pkgs.sdl3 ];
    };

    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        zig.packages.x86_64-linux."0.14.0"
        zls
        sdl3
      ];
    };
  };
}
