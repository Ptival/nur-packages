{ stdenv, fetchFromGitHub, coq }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-coq-plugin-lib";

  src = fetchFromGitHub {
    owner = "uwplse";
    repo = "coq-plugin-lib";
    rev = "21940010a40c77de6f00c2b5b2e810b685502d1d";
    sha256 = "1g21kcp5h6r5rxs0kkmnm6d5pzl3izw5i02lir1jfi87a9rb1xpm";
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
