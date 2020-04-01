{

  "ghc865" =
    let ghcVersion = "ghc865";
    in self: super:
      let
        dontCheck = super.haskell.lib.dontCheck;
      in
        {
          haskell = super.haskell // {
            inherit ghcVersion;

            packages = super.haskell.packages // {
              "${ghcVersion}" = super.haskell.packages.${ghcVersion}.extend (selfH: superH: {

                # older version needed by stack-4.17.1
                call-stack = selfH.callHackage "call-stack" "0.1.0" {};

                floskell = dontCheck superH.floskell;

                # 0.1.0
                ghcide = dontCheck
                  (selfH.callCabal2nix
                    "ghcide"
                    (builtins.fetchGit {
                      url = "https://github.com/digital-asset/ghcide.git";
                      rev = "209be0b162bd80f9b0f62c5c1e93a6ed65b89b61";
                    })
                    {});

                # 0.3.2
                ghc-tcplugins-extra =
                  (selfH.callCabal2nix
                    "ghc-tcplugins-extra"
                    (builtins.fetchGit {
                      url = "https://github.com/clash-lang/ghc-tcplugins-extra.git";
                      rev = "eda51dccd47522cd26c5cef7c5bf56a52976864b";
                    })
                    {});

                # 1.2.7.0 because lens-4.17.1 requires < 1.3
                hashable = selfH.callHackage "hashable" "1.2.7.0" {};

                # 0.1.0
                # haskell-language-server = dontCheck
                #   (selfH.callCabal2nix
                #     "haskell-language-server"
                #     (builtins.fetchGit {
                #       url = "https://github.com/haskell/haskell-language-server.git";
                #       rev = "d7e8c879c1c30119dc775f6237f49edf6998db75";
                #     })
                #     {});

                # 0.20.0
                # haskell-lsp =
                #   (selfH.callCabal2nix
                #     "haskell-lsp"
                #     (builtins.fetchGit {
                #       url = "https://github.com/alanz/haskell-lsp.git";
                #       rev = "30ac5301883bd0f36cadad95f27ae133f0d798de";
                #     })
                #     {});

                # 0.20.0
                # haskell-lsp-types =
                #   (selfH.callCabal2nix
                #     "haskell-lsp-types"
                #     (builtins.fetchGit {
                #       url = "https://github.com/alanz/haskell-lsp.git";
                #       rev = "30ac5301883bd0f36cadad95f27ae133f0d798de";
                #     } + "/haskell-lsp-types")
                #     {});

                # 1.21.1 as mandated by hlint-2.1.17
                haskell-src-exts =
                  selfH.callCabal2nix
                    "haskell-src-exts"
                    (builtins.fetchGit {
                      url = "https://github.com/haskell-suite/haskell-src-exts.git";
                      rev = "d24b20323a4fe20ce476c4914e19c6ebb2c46cb3";
                    })
                    {};

                haskell-src-meta = dontCheck superH.haskell-src-meta;

                hie-bios = dontCheck superH.hie-bios;

                # 2.1.17 is the last version that will work with GHC 8.6.5
                hlint =
                  selfH.callCabal2nix
                    "hlint"
                    (builtins.fetchGit {
                      url = "https://github.com/ndmitchell/hlint.git";
                      rev = "92e3b864a29f8aab3c82b908e328e3d9b9cb36b4";
                    })
                    {};

                # 5.0.17.11 is the last version compatible with haskell-src-exts-1.21.1
                hoogle = selfH.callHackage "hoogle" "5.0.17.11" {};

                # 4.17.1 since 4.18.1 is not compatible
                lens =
                  selfH.callCabal2nix
                    "lens"
                    (builtins.fetchGit {
                      url = "https://github.com/ekmett/lens.git";
                      rev = "867f1ff48d2576b4d7cf50d1f971ce5496650a47";
                    })
                    {};

                # pantry = selfH.callHackage "pantry" "0.1.0.0" {};

                # TODO: try 3.2.0.0
                Cabal = selfH.callHackage "Cabal" "3.0.0.0" {};

                # stack = selfH.callHackage "stack" "2.1.3" {};

                selective = dontCheck superH.selective;

                # 1.9.3
                time-compat = dontCheck
                  (selfH.callCabal2nix
                    "time-compat"
                    (builtins.fetchGit {
                      url = "https://github.com/phadej/time-compat.git";
                      rev = "0406505ddde5affb39f72070e18352c766ca4eb8";
                    })
                    {});

              });
            };
          };
        };

  "ghc882" =
    let ghcVersion = "ghc882";
    in self: super:
      let
        dontCheck = super.haskell.lib.dontCheck;
      in
        {
          haskell = super.haskell // {
            inherit ghcVersion;

            packages = super.haskell.packages // {
              "${ghcVersion}" = super.haskell.packages.${ghcVersion}.extend (selfH: superH: {

                floskell = dontCheck superH.floskell;

                # 0.1.0
                ghcide = dontCheck
                  (selfH.callCabal2nix
                    "ghcide"
                    (builtins.fetchGit {
                      url = "https://github.com/digital-asset/ghcide.git";
                      rev = "209be0b162bd80f9b0f62c5c1e93a6ed65b89b61";
                    })
                    {});

                # 0.3.2
                ghc-tcplugins-extra =
                  (selfH.callCabal2nix
                    "ghc-tcplugins-extra"
                    (builtins.fetchGit {
                      url = "https://github.com/clash-lang/ghc-tcplugins-extra.git";
                      rev = "eda51dccd47522cd26c5cef7c5bf56a52976864b";
                    })
                    {});

                # 0.1.0
                # haskell-language-server = dontCheck
                #   (selfH.callCabal2nix
                #     "haskell-language-server"
                #     (builtins.fetchGit {
                #       url = "https://github.com/haskell/haskell-language-server.git";
                #       rev = "d7e8c879c1c30119dc775f6237f49edf6998db75";
                #     })
                #     {});

                # 0.20.0
                # haskell-lsp =
                #   (selfH.callCabal2nix
                #     "haskell-lsp"
                #     (builtins.fetchGit {
                #       url = "https://github.com/alanz/haskell-lsp.git";
                #       rev = "30ac5301883bd0f36cadad95f27ae133f0d798de";
                #     })
                #     {});

                # 0.20.0
                # haskell-lsp-types =
                #   (selfH.callCabal2nix
                #     "haskell-lsp-types"
                #     (builtins.fetchGit {
                #       url = "https://github.com/alanz/haskell-lsp.git";
                #       rev = "30ac5301883bd0f36cadad95f27ae133f0d798de";
                #     } + "/haskell-lsp-types")
                #     {});

                hie-bios = dontCheck superH.hie-bios;

                # 2.1.17 is the last version that will work with GHC 8.6.5
                hlint =
                  selfH.callCabal2nix
                    "hlint"
                    (builtins.fetchGit {
                      url = "https://github.com/ndmitchell/hlint.git";
                      rev = "92e3b864a29f8aab3c82b908e328e3d9b9cb36b4";
                    })
                    {};

              });
            };
          };
        };

}
