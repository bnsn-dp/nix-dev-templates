{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        pythonEnv = pkgs.python312.withPackages (ps: with ps; [
          pip
          setuptools
          wheel

          pytest
          pytest-cov
          black
          isort
          mypy
          ruff

          requests
          pydantic
        ]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pythonEnv

            pkgs.pyright

            pkgs.zlib
            pkgs.libffi
          ];

        shellHook = ''
          echo "Python $(python --version) ready"
        '';
        };
      }
    );
}
