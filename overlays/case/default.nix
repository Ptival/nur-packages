self: super:
{
  haskellPackages = super.haskellPackages.extend (selfHaskell: superHaskell:
    rec {
      language-lustre = self.callPackage ../../pkgs/haskellPackages/language-lustre {};
    }
  );
}
