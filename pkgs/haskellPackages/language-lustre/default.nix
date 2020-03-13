{ callPackage }:
let
  lib = callPackage ../../../lib {};
in
lib.mkHaskell {
  name = "language-lustre";
  remote = {
    owner = "GaloisInc";
    repo = "lustre/";
    rev = "13b0345c83328aedaf241fe426dcacbd9f41ef3f";
    sha256 = "0j1isralci02jra4xg3h4rz6ivfwk5n7yvjspnx2czx976pmy9y6";
  };
}
