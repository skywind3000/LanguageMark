#! /bin/sh
CC="clang-9"

echo "queen.c - non-recursion"
$CC -O3 queen.c -o a.out -static && sleep 1 && ./a.out && rm -f a.out
echo "queen.rs - non-recursion"
rustc -O -C opt-level=3 queen.rs -o a.out && sleep 1 && ./a.out && rm -f a.out
echo "queen.go - non-recursion"
go build -o a.out queen.go && sleep 1 && ./a.out && rm -f a.out
echo "queen2.c - recursion"
$CC -O3 queen2.c -o a.out -static && sleep 1 && ./a.out && rm -f a.out
echo "queen2.rs - recursion"
rustc -O -C opt-level=3 queen2.rs -o a.out && sleep 1 && ./a.out && rm -f a.out
