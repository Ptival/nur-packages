self: super:
{
  haskellPackages = super.haskellPackages.extend (selfHaskell: superHaskell:
    rec {
      ghc-tcplugins-extra = self.callPackage ../../pkgs/haskellPackages/ghc-tcplugins-extra {};
      language-ocaml      = self.callPackage ../../pkgs/haskellPackages/language-ocaml      {};
      polysemy            = self.callPackage ../../pkgs/haskellPackages/polysemy            {};
      snap                = self.callPackage ../../pkgs/haskellPackages/snap                {};
    }
  );
}
