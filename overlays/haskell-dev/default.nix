{ ghcVersion
}:
self: super:
let

  dontCheck = super.haskell.lib.dontCheck;

in
{
  haskell = super.haskell // {
    inherit ghcVersion;

    packages = super.haskell.packages // {
      "${ghcVersion}" = super.haskell.packages.${ghcVersion}.extend (selfH: superH: {

        floskell = dontCheck super.floskell;

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

      });
    };
  };
}
