{ stdenv, fetchFromGitHub, coq, coq-plugin-lib, fix-to-elim, ornamental-search
}:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-PUMPKIN-PATCH";

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "uwplse";
    repo = "PUMPKIN-PATCH";
    rev = "51746d9045e1ad4350ccd437369cd4a12a2c70f6";
    sha256 = "11jcqiy52dvg4lp51pvjg6w7n7w59qkyray54wkpzr4s8bga4142";
  };

  buildInputs = [
    coq
    coq-plugin-lib
    fix-to-elim
    ornamental-search
  ];

  propagatedBuildInputs = with coq.ocamlPackages;
    [
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
