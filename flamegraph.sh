#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"

EXE=dist-newstyle/build/x86_64-linux/ghc-*/advent-of-code2025-*/x/advent-of-code2025/build/advent-of-code2025/advent-of-code2025
BROWSER=librewolf

cabal build --ghc-options="-prof -fprof-late"
$EXE +RTS -p
ghc-prof-flamegraph ./advent-of-code2025.prof
$BROWSER ./advent-of-code2025.svg
