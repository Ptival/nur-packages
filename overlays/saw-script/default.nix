self: super:
let
  compiler = "ghc865";
  ghc = super.haskell.compiler.${compiler};
  haskellPackages = super.haskell.packages.${compiler};
  utils = self.callPackage ./utils.nix {
    inherit haskellPackages;
  };
  haskellPackageFromGitHub = utils.haskellPackageFromGitHub;
in
{
  cabal-install = haskellPackages.cabal-install; # to make sure everyone uses the correct version
  inherit ghc;
  haskellPackages = self.haskell.packages.${compiler}.extend (selfHaskell: superHaskell:
    rec {
      inherit haskellPackageFromGitHub;
      base-compat           = self.callPackage ../../pkgs/haskellPackages/base-compat           {};
      base-compat-batteries = self.callPackage ../../pkgs/haskellPackages/base-compat-batteries {};
    }
  );
}
