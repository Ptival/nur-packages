{ haskell
}:

            time-compat = dontCheck
              (selfH.callCabal2nix
                "time-compat"
                (builtins.fetchGit {
                  url = "https://github.com/phadej/time-compat.git";
                  rev = "0406505ddde5affb39f72070e18352c766ca4eb8";
                })
                {});


haskell.callHackage "haske"
stdenv.mkDerivation rec {

  name = "haskell-language-server-${version}";
  version = "20200525";

  src = fetchFromGitHub {
    owner  = "haskell";
    repo   = "haskell-language-server";
    rev    = "28150bc867f2e5010173a4af05363eb48bfc35f2";
    sha256 = "sha256:1152gsy4cd6i75i49in6jgijlv0xxszkhb7cwpkqv771432ligva";
  };

  buildInputs = [  ];

  nativeBuildInputs = [
  ];

  meta = {
    description = "TODO";
    homepage    = "TODO";
    license     = stdenv.lib.licenses.asl20;
    maintainers = [ stdenv.lib.maintainers.ptival ];
  };

}
