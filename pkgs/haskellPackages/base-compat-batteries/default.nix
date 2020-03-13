{ callPackage, haskell }:
let
  lib = callPackage ../../../lib {};
in
haskell.lib.dontCheck (
  (
    lib.mkHaskell {
      name = "base-compat-batteries";
      path = "base-compat-batteries";
      remote = {
        owner = "haskell-compat";
        repo = "base-compat";
        rev = "4a7e7ee3fd19a0be410e79bb5303c8bd1b53c3b7";
        sha256 = "0q2mq3p1iw1wh27hyc62pan47bl3y5mnbndylwj6vaxzy585fvr0";
      };
    }
  )
)
