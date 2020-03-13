{ pkgs }:

with pkgs.lib; {

  mkHaskell = desc:
    let
      path = desc.path or ".";
    in
    (pkgs.haskellPackages.callCabal2nix
      desc.name
      ((pkgs.fetchFromGitHub desc.remote) + "/${path}")
      { }).overrideDerivation (d: { sourceRoot = path; });

}
