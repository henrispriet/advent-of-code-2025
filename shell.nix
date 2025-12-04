let
  sources = {
    nixpkgs = <nixpkgs>;
  };
in
{
  pkgs ? import sources.nixpkgs {
    config = { };
    overlays = [ ];
  },
}:
pkgs.mkShell {
  packages = with pkgs; [
    cabal-install
    ghc
    haskell-language-server
    ormolu

    # flamegraph
    perf
    haskellPackages.ghc-prof-flamegraph
  ];
}
