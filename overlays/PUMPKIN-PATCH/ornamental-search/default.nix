{ stdenv, fetchFromGitHub, coq, fix-to-elim }:
stdenv.mkDerivation rec {
  name = "coq${coq.coq-version}-ornamental-search";

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = "uwplse";
    repo = "ornamental-search";
    rev = "cb27d5773bc06cf6fb95d56ed278e2fa92081e28";
    sha256 = "0fdi8ykfwks6w3knwajn1b7ra448db8b5np0yqn62jlf0ynkmrhr";
  };

  buildInputs = [
    coq
    fix-to-elim
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
