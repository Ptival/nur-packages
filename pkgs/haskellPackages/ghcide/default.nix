{ callPackage, haskell }:
let
  lib = callPackage ../../../lib {};
in
haskell.lib.dontCheck (lib.mkHaskell {
  name = "ghcide";
  remote = {
    owner = "digital-asset";
    repo = "ghcide";
    rev = "c74e9b51f131df446c8e011ae79f3370c683f12b";
    sha256 = "19m8jgqqgcarr991adxz5cnd2zixvy14v0ima5950jrd8h73nzcm";
  };
})
