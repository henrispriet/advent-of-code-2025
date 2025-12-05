
EXE := "dist-newstyle/build/x86_64-linux/ghc-*/advent-of-code2025-*/x/advent-of-code2025/build/advent-of-code2025/advent-of-code2025"
BROWSER := "librewolf"

default:
  just --list

# make sure day has leading 0 if <10
new-part1 day:
    mkdir -p src/Day{{day}}
    cp src/Template.hs src/Day{{day}}/Part1.hs

    sed -re 's/-- (module Day)XX(\.Part)X/\1{{day}}\21/' -i src/Day{{day}}/Part1.hs
    sed 's/module Template.*//' -i src/Day{{day}}/Part1.hs

    sed -re 's/(day)xx-(part)x(\.txt)/\1{{day}}\21\3/' -i src/Day{{day}}/Part1.hs
    sed -re 's/(Day)..(\.Part)./\1{{day}}\21/' -i src/Main.hs

# make sure day has leading 0 if <10
new-part2 day:
    cp src/Day{{day}}/Part1.hs src/Day{{day}}/Part2.hs

    sed -re 's/(Day)..(\.Part)./\1{{day}}\22/' -i src/Day{{day}}/Part2.hs
    sed -re 's/(Day)..(\.Part)./\1{{day}}\22/' -i src/Main.hs

run:
    cabal run

test:
    cabal test

time:
    cabal build && time {{EXE}}

flamegraph:
    cabal build --ghc-options="-prof -fprof-late"
    {{EXE}} +RTS -p
    ghc-prof-flamegraph ./advent-of-code2025.prof
    {{BROWSER}} ./advent-of-code2025.svg
