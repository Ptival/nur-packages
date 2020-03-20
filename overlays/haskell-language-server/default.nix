self: super:
let
  dontCheck = self.haskell.lib.dontCheck;
in
{
  haskellPackages = super.haskellPackages.extend (selfHaskell: superHaskell:
    rec {
      floskell       = dontCheck superHaskell.floskell;
      ghcide         = self.callPackage ../../pkgs/haskellPackages/ghcide      {};
      haskell-lsp    = self.callPackage ../../pkgs/haskellPackages/haskell-lsp {};
      hie-bios       = dontCheck superHaskell.hie-bios;
      monad-dijkstra = dontCheck superHaskell.monad-dijkstra;
    }
  );
}
