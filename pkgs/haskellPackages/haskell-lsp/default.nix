{ callPackage, haskell }:
let
  lib = callPackage ../../../lib {};
in
lib.mkHaskell {
  name = "haskell-lsp";
  remote = {
    owner = "alanz";
    repo = "haskell-lsp";
    rev = "30ac5301883bd0f36cadad95f27ae133f0d798de";
    sha256 = "1dzdcg1js3xnplnfwb1r3n54xi7ryqfv7sgkhh7jyskqjcmlfy71";
  };
}
