#! /bin/sh
echo "queen.c"
gcc -O3 queen.c -o a.out && sleep 1 && ./a.out && rm -f a.out
echo "queen.rs"
rustc -O -C opt-level=3 queen.rs -o a.out && sleep 1 && ./a.out && rm -rf a.out
