{
  description = "melange-relay Nix Flake";

  inputs.nix-filter.url = "github:numtide/nix-filter";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs = {
    url = "github:nix-ocaml/nix-overlays";
    inputs.flake-utils.follows = "flake-utils";
  };
  inputs.melange-src = {
    url = "github:melange-re/melange";
    inputs.nix-filter.follows = "nix-filter";
    inputs.flake-utils.follows = "flake-utils";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, nix-filter, melange-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}".appendOverlays [
          (self: super: {
            ocamlPackages = super.ocaml-ng.ocamlPackages_5_1;
          })
          melange-src.overlays.default
        ];
        inherit (pkgs) nodejs_latest lib stdenv darwin;
      in
      rec {
        packages = {
          default = with pkgs.ocamlPackages; buildDunePackage {
            pname = "melange-fetch";
            version = "dev";

            src = ./.;
            nativeBuildInputs = with pkgs.ocamlPackages; [ melange ];
            propagatedBuildInputs = with pkgs.ocamlPackages; [ melange ];
          };
        };
        devShells.default = pkgs.mkShell {
          inputsFrom = [ packages.default ];
          nativeBuildInputs = with pkgs; [
            yarn
            nodejs_latest
          ] ++ (with pkgs.ocamlPackages; [
            ocamlformat
            merlin
          ]);
        };
      });
}
