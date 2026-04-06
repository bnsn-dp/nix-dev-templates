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
            pkgs.linuxPackages.perf

            pkgs.pkg-config
            pkgs.boost
            pkgs.fmt
            pkgs.catch2
          ];

          shellHook = ''
            echo "GCC $(gcc --version | head -1) ready"
            echo "Clang $(clang --version | head -1) ready"

            # Tell CMake to generate compile_commands.json by default.
            # This is what clangd uses to understand your project.
            export CMAKE_EXPORT_COMPILE_COMMANDS=1
          '';
        };
      });
}
