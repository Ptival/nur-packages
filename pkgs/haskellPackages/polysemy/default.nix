{ callPackage, haskell }:
let
  lib = callPackage ../../../lib {};
in
lib.mkHaskell {
  name = "polysemy";
  remote = {
    owner = "polysemy-research";
    repo = "polysemy";
    rev = "3c731186cb5ebcfc9319586e0b691b985c6730e2"; # 1.3.0
    sha256 = "0yhr5scws0vm7748nn87rks70cr5wzwaqy9zc0x74g6rjl74x943";
  };
}
