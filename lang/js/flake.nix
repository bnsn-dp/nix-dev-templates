{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtime/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs_22
            pkgs.nodePackages.npm

            pkgs.nodePackages.vscode-langservers-extracted

            pkgs.nodePackages.prettier
            pkgs.nodePackages.eslint

            pkgs.python3
            pkgs.gnumake
            pkgs.gcc
          ];

          shellHook = ''
            echo "Node $(node --version) ready"
            export NPM_CONFIG_PREFIX="$PWD/.npm-global"
            export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
          '';
        };
      });
}
