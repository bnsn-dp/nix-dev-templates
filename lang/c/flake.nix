{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.gcc
            pkgs.clang
            pkgs.clang-tools

            pkgs.cmake
            pkgs.ninja
            pkgs.gnumake

            pkgs.gdb
            pkgs.valgrind

            pkgs.pkg-config

            pkgs.check
            pkgs.cppcheck
            pkgs.splint

            pkgs.libevent
            pkgs.openssl
            pkgs.zlib
          ];

          shellHook = ''
            echo "GCC $(gcc --version | head -1) ready"
            export CMAKE_EXPORT_COMPILE_COMMANDS=1
          '';
        };
      });
}
