{ pkgs }:

with pkgs.lib; rec {

  callCabal2nixGitignore = pkgs: name: path: options:
    pkgs.haskell.lib.overrideCabal
      (pkgs.haskellPackages.callCabal2nix name path options)
      (old: {
        src = pkgs.nix-gitignore.gitignoreSource [".git/" "*.nix"] old.src;
      });

  mkHaskell = desc:
    let
      path = desc.path or ".";
    in
    (pkgs.haskellPackages.callCabal2nix
      desc.name
      ((pkgs.fetchFromGitHub desc.remote) + "/${path}")
      { }).overrideDerivation (d: { sourceRoot = path; });

  # inspired by this great post:
  # https://medium.com/purely-functional/nix-setup-for-haskell-with-ghcide-and-hlint-3e268343efed

  computeHaskellSetup =
    { nixpkgsRev
    , nixpkgsArgs # typically, a Haskell overlay
    , pkg         # arguments to callCabal2nix
    }:
    let

      pkgs = import (builtins.fetchGit {
        url = "https://github.com/NixOS/nixpkgs.git";
        rev = nixpkgsRev;
      }) nixpkgsArgs;

      inherit (pkgs.haskell) ghcVersion;

      hsPkgs = pkgs.haskell.packages.${ghcVersion};

      pkgDrv = callCabal2nixGitignore pkgs pkg.name pkg.path pkg.args;

      pkgDeps = pkgDrv.getBuildInputs.haskellBuildInputs;

      ghc = hsPkgs.ghcWithHoogle (_: pkgDeps);

      haskell = {
        inherit ghc;
        # Development tools
        inherit (hsPkgs) cabal-install ghcide hlint stack;
      };

    in
      {
        inherit
          ghc
          hsPkgs
          pkgs
        ;
      };

  haskellDevShell =
    { nixpkgsRev
    , nixpkgsArgs # typically, a Haskell overlay
    , pkg         # arguments to callCabal2nix
    }:
    let
      setup = computeHaskellSetup { inherit nixpkgsRev nixpkgsArgs pkg; };
    in

      setup.pkgs.mkShell {

        buildInputs = with setup.hsPkgs; [
          cabal-install
          ghc
          ghcide
          hlint
          stack
        ];

        NIX_GHC_LIBDIR = "${setup.ghc}/lib/ghc-${setup.ghc.version}";

      };

  stackShell =
    { nixpkgsRev
    , nixpkgsArgs # typically, a Haskell overlay
    , pkg         # arguments to callCabal2nix
    }:
    let
      setup = computeHaskellSetup { inherit nixpkgsRev nixpkgsArgs pkg; };
    in

      pkgs.haskell.lib.buildStackProject {

        inherit (setup) ghc;

        inherit (pkg) name;

        buildInputs = with setup.hsPkgs; [
          # TODO: eventually I might want to add packages here via some argument
        ];

      };

}
