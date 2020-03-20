{ pkgs }:

with pkgs.lib; {

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

}
