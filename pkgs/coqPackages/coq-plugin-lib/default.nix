{ stdenv, fetchFromGitHub, coq }:
let
  sources = import ../nix/sources.nix;
in
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-coq-plugin-lib";

  src = fetchFromGitHub {
    inherit (sources.coq-plugin-lib) owner repo rev sha256;
  };

  buildInputs = [ coq ];
  propagatedBuildInputs = with coq.ocamlPackages;
    [
      camlp5
      findlib
      ocaml
    ];

  enableParallelBuilding = true;

  preBuild = "coq_makefile -f _CoqProject -o Makefile";

  installFlags = "COQLIB=$(out)/lib/coq/${coq.coq-version}/";

  passthru = {
    compatibleCoqVersions = v: v == "8.8";
  };
}
