let

  haskellOverlay =
    { ghcVersion, makeHaskellPackagesOverlay }:
    self: super:
    let
      haskellPackagesOverlay = makeHaskellPackagesOverlay self super;
    in
      {
        haskellPackages = super.haskellPackages.extend haskellPackagesOverlay;
        haskell = super.haskell // {
          "${ghcVersion}" =
            super.haskell.packages.${ghcVersion}.extend haskellPackagesOverlay;
        };
      };

in

{

  "ghc865" =
    haskellOverlay {
      ghcVersion = "ghc865";
      makeHaskellPackagesOverlay = self: super: selfH: superH:
        let
          dontCheck = super.haskell.lib.dontCheck;
        in
          {
            floskell = dontCheck superH.floskell;

            ghcide = dontCheck superH.ghcide;

            # ghcide-0.1.0 needs 0.19.0, but Hackage has 0.20.0
            haskell-lsp       = selfH.callHackage "haskell-lsp"       "0.19.0.0" {};
            haskell-lsp-types = selfH.callHackage "haskell-lsp-types" "0.19.0.0" {};

            # 1.21.1 as mandated by hlint-2.1.17
            haskell-src-exts = selfH.callHackage "haskell-src-exts" "1.21.1" {};

            haskell-src-meta = dontCheck superH.haskell-src-meta;

            hie-bios = dontCheck superH.hie-bios;

            # 2.1.17 is the last version that will work with GHC 8.6.5
            hlint = selfH.callHackage "hlint" "2.1.17" {};

            # 5.0.17.11 is the last version compatible with haskell-src-exts-1.21.1
            hoogle = selfH.callHackage "hoogle" "5.0.17.11" {};

            # current nixpkgs revision points to 2.4 which is annoying
            Cabal = selfH.callHackage "Cabal" "3.0.0.0" {};

            # 1.9.3, isn't on Hackage for my nixpkgs revision
            time-compat = dontCheck
              (selfH.callCabal2nix
                "time-compat"
                (builtins.fetchGit {
                  url = "https://github.com/phadej/time-compat.git";
                  rev = "0406505ddde5affb39f72070e18352c766ca4eb8";
                })
                {});

          };
    };


  "ghc882" =
    haskellOverlay {
      ghcVersion = "ghc882";
      makeHaskellPackagesOverlay = self: super: selfH: superH:
        let
          dontCheck = super.haskell.lib.dontCheck;
        in
          {

            floskell = dontCheck superH.floskell;

            ghcide = dontCheck superH.ghcide;

            # ghcide-0.1.0 needs 0.19.0, but Hackage has 0.20.0
            haskell-lsp       = selfH.callHackage "haskell-lsp"       "0.19.0.0" {};
            haskell-lsp-types = selfH.callHackage "haskell-lsp-types" "0.19.0.0" {};

            hie-bios = dontCheck superH.hie-bios;

          };
    };
}
