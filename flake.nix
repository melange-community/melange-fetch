{
  description = "melange-fetch Nix Flake";

  inputs.nixpkgs.url = "github:nix-ocaml/nix-overlays";

  outputs =
    { self, nixpkgs }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system:
          let
            pkgs = nixpkgs.legacyPackages.${system}.extend (
              self: super: {
                ocamlPackages = super.ocaml-ng.ocamlPackages_5_5.overrideScope (
                  oself: osuper: {
                    reason = osuper.reason.overrideAttrs (_: {
                      patches = [ ];
                    });
                  }
                );
              }
            );
          in
          f pkgs
        );
    in
    {
      packages = forAllSystems (pkgs: {
        default =
          with pkgs.ocamlPackages;
          buildDunePackage {
            pname = "melange-fetch";
            version = "dev";

            src =
              let
                fs = pkgs.lib.fileset;
              in
              fs.toSource {
                root = ./.;
                fileset = fs.unions [
                  ./dune-project
                  ./melange-fetch.opam
                  ./src
                ];
              };

            nativeBuildInputs = with pkgs.ocamlPackages; [ melange ];
            propagatedBuildInputs = with pkgs.ocamlPackages; [ melange ];
          };
      });

      devShells = forAllSystems (
        pkgs:
        let
          inherit (pkgs) nodejs_24;
          mkShell =
            {
              inputsFrom,
              buildInputs ? [ ],
            }:
            pkgs.mkShell {
              nativeBuildInputs =
                with pkgs;
                [
                  yarn
                  nodejs_24
                ]
                ++ (with pkgs.ocamlPackages; [
                  reason
                  ocamlformat
                  merlin
                ]);
              inherit inputsFrom buildInputs;
            };
        in
        {
          default = mkShell {
            inputsFrom = [ self.packages.${pkgs.stdenv.hostPlatform.system}.default ];
          };
          release = mkShell {
            inputsFrom = [ self.packages.${pkgs.stdenv.hostPlatform.system}.default ];
            buildInputs = with pkgs; [
              cacert
              curl
              ocamlPackages.dune-release
              git
            ];
          };
        }
      );
    };
}
