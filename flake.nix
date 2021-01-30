{
  description = "A selenium starter project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        myProgram = pkgs.stdenv.mkDerivation rec {
          name = "selenium-starter";
          python = (pkgs.python3.withPackages (pythonPackages:
            with pythonPackages;
            [ robotframework-seleniumlibrary ]));
          buildInputs = [ python pkgs.chromedriver pkgs.makeWrapper ];
          src = self;
          installPhase = ''
            mkdir -p $out/bin
            cp main.py $out/bin/
            echo "#! ${pkgs.runtimeShell}" > $out/bin/selenium-starter
            echo "exec ${python}/bin/python $out/bin/main.py" >> $out/bin/selenium-starter
            chmod +x $out/bin/selenium-starter
            wrapProgram $out/bin/selenium-starter --set PATH ${
              pkgs.lib.makeBinPath [ pkgs.chromedriver pkgs.chromium ]
            }
          '';
        };
      in {
        devShell = myProgram;
        defaultPackage = myProgram;
        defaultApp = {
          type = "app";
          program = "${myProgram}/bin/selenium-starter";
        };
      });
}
