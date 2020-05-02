{ stdenv, fetchFromGitHub, coq, coq-plugin-lib }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-fix-to-elim";

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "uwplse";
    repo = "fix-to-elim";
    rev = "f8ba682c7399364c082cd9fc4c69050cc090f390";
    sha256 = "1jn2qnik40hsijdsvvj5miyn6r46dpq4fkk4llbwda70cl2y35aj";
  };

  buildInputs = [
    coq
    coq-plugin-lib
  ];

  propagatedBuildInputs = with coq.ocamlPackages; [
    camlp5
    findlib
    ocaml
  ];

  enableParallelBuilding = true;

  preBuild = ''
    cd plugin
    coq_makefile -f _CoqProject -o Makefile
  '';

  installFlags = "COQLIB=$(out)/lib/coq/${coq.coq-version}/";

  passthru = {
    compatibleCoqVersions = v: v == "8.8";
  };
}
