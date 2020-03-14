{ callPackage, haskell }:
let
  lib = callPackage ../../../lib {};
in
lib.mkHaskell {
  name = "snap";
  remote = {
    owner = "snapframework";
    repo = "snap";
    rev = "a1c876ba0a72e8c5e052f5f0919caee6c4bcd129"; # 1.1.3.0
    sha256 = "004khck9fappfyzgfkbmdiw9kj2db723scr33l1jc4dac53xvz6f";
  };
}
