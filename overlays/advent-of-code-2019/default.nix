self: super:
{
  haskellPackages = super.haskellPackages.extend (selfHaskell: superHaskell:
    rec {
      ghc-tcplugins-extra = self.callPackage ../../pkgs/haskellPackages/ghc-tcplugins-extra {};
      polysemy            = self.callPackage ../../pkgs/haskellPackages/polysemy            {};
    }
  );
}
