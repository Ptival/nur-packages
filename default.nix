# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> {} }:

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  abc                      = pkgs.callPackage ./pkgs/abc                      {};
  opensmt2                 = pkgs.callPackage ./pkgs/opensmt2                 {};
  meslo-nerd-powerlevel10k = pkgs.callPackage ./pkgs/meslo-nerd-powerlevel10k {};
  sally                    = pkgs.callPackage ./pkgs/sally                    { inherit opensmt2; };

  coqPackages = {
    coq-plugin-lib = pkgs.callPackage ./pkgs/coqPackages/coq-plugin-lib {};
  };
}
