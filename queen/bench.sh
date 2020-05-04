#! /bin/sh
CC="clang-9"

echo "queen.c - non-recursion"
$CC -O3 -mllvm -polly queen.c -o a.out -static && sleep 1 && ./a.out && rm -f a.out
echo "queen.rs - non-recursion"
rustc -O -C opt-level=3 queen.rs -o a.out && sleep 1 && ./a.out && rm -f a.out
echo "queen.go - non-recursion"
go build -o a.out queen.go && sleep 1 && ./a.out && rm -f a.out

echo "queen2.c - recursion"
$CC -O3 -mllvm -polly queen2.c -o a.out -static && sleep 1 && ./a.out && rm -f a.out
echo "queen2.rs - recursion"
rustc -O -C opt-level=3 queen2.rs -o a.out && sleep 1 && ./a.out && rm -f a.out

echo "queen3.c - long time N=15"
$CC -O3 -mllvm -polly queen3.c -o a.out -static && sleep 1 && ./a.out && rm -f a.out
echo "queen3.rs - long time N=15"
rustc -O -C opt-level=3 queen3.rs -o a.out && sleep 1 && ./a.out && rm -f a.out
