{
  description = "Rust flake template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };

      rustToolchain = pkgs.rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
          "clippy"
        ];
        targets = [ "x86_64-unknown-linux-gnu" "wasm32" ];
      };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            rustToolchain
            
            pkgs.pkg-config
            pkgs.openssl.dev 
            pkgs.libiconv

            pkgs.cargo-watch
            pkgs.cargo-expand
            pkgs.cargo-audit
          ];
        
        RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
        PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

        shellHook = ''
          echo "Rust $(rustc --version) ready"
        '';
        };
      }
    );
}
