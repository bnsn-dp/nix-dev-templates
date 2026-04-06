{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        jdk = pkgs.jdk21;
      in {
        devshells.default = pkgs.mkShell {
          buildInputs = [
            jdk 
            pkgs.maven
            pkgs.jdt-language-server
            pkgs.google-java-format
          ];

          JAVA_HOME = "${jdk}";

          shellHook = ''
            echo "Java $(java --version | head -1) ready"
            # Maven local repo: keep it project-adjacent for isolation
            # (optional - Maven defaults to ~/.m2 which is fine for most uses)
            # export MAVEN_OPTS="-Dmaven.repo.local=$PWD/.m2"
          '';
        };
      });

}
