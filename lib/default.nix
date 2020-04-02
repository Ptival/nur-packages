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
    { ghcVersion
    , nixpkgsRev
    , nixpkgsArgs # typically, a Haskell overlay
    , pkg         # arguments to callCabal2nix
    }:
    let

      pkgs = import (builtins.fetchGit {
        url = "https://github.com/NixOS/nixpkgs.git";
        rev = nixpkgsRev;
      }) nixpkgsArgs;

      hsPkgs = pkgs.haskell.packages.${ghcVersion};

      pkgDrv = callCabal2nixGitignore pkgs pkg.name pkg.path pkg.args;

      pkgDeps = pkgDrv.getBuildInputs.haskellBuildInputs;

      ghc = hsPkgs.ghcWithHoogle (_: pkgDeps);

    in
      {
        inherit
          ghc
          hsPkgs
          pkgs
        ;
      };

  haskellDevShell =
    { ghcVersion
    , nixpkgsRev
    , nixpkgsArgs # typically, a Haskell overlay
    , pkg         # arguments to callCabal2nix
    }:
    let
      setup = computeHaskellSetup { inherit ghcVersion nixpkgsRev nixpkgsArgs pkg; };
    in

      setup.pkgs.mkShell {

        buildInputs = with setup.hsPkgs; [
          cabal-install
          setup.ghc # NOTE: this is the one with Hoogle set up
          ghcide
          hlint
          stack
        ];

        NIX_GHC_LIBDIR = "${setup.ghc}/lib/ghc-${setup.ghc.version}";

      };

  stackShell =
    { ghcVersion
    , mkBuildInputs
    , nixpkgsRev
    , nixpkgsArgs # typically, a Haskell overlay
    , pkg         # arguments to callCabal2nix
    }:
    let
      setup = computeHaskellSetup { inherit ghcVersion nixpkgsRev nixpkgsArgs pkg; };
    in

      pkgs.haskell.lib.buildStackProject {

        # grab the correct GHC without Hoogle support since stack does not need it
        ghc = setup.pkgs.haskell.compiler.${ghcVersion};

        inherit (pkg) name;

        buildInputs = mkBuildInputs setup.pkgs setup.hsPkgs;

      };

}
