{ callPackage, haskell }:
let
  lib = callPackage ../../../lib {};
in
lib.mkHaskell {
  name = "language-ocaml";
  remote = {
    owner = "Ptival";
    repo = "language-ocaml";
    rev = "18564c937bfa3e96c5b410e52cd7c469785536e0";
    sha256 = "0j25qyqqpm2x5ayym13larsz6kcmn9ha7mlkxh1fhnic3c8nyvra";
  };
}
