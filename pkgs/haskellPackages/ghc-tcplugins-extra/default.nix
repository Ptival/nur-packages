{ callPackage, haskell }:
let
  lib = callPackage ../../../lib {};
in
lib.mkHaskell {
  name = "ghc-tcplugins-extra";
  remote = {
    owner = "clash-lang";
    repo = "ghc-tcplugins-extra";
    rev = "eda51dccd47522cd26c5cef7c5bf56a52976864b"; # 0.3.2
    sha256 = "1py5wh8vnc07kwdfjppppsphqncvdxfilqfw201jdm918pmhp32j";
  };
}
