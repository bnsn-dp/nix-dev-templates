{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.lib.eachDefaultSystem.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs_22
            pkgs.nodePackages.npm

            pkgs.nodePackages.typescript
            pkgs.nodePackages.typescript-language-server

            pkgs.nodePackages.prettier
            pkgs.nodePackages.eslint

            pkgs.python3
            pkgs.gnumake
            pkgs.gcc
          ];

        shellHook = ''
          echo "Node $(node --version) | TypeScript $(tsc --version) ready"
          export NPM_CONFIG_PREFIX="$PWD/.npm-global"
          export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
        '';
        };
      }
    );
}
