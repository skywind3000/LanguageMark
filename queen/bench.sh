#!/usr/bin/zsh

export PATH=/opt/go/bin:$PATH

CC=clang-10
CFLAGS='-O3 -mllvm -polly'

run() {
	echo "queen.c - non-recursion"
	eval $CC ${CFLAGS} queen.c -o a.out -static && ./a.out ; rm -f a.out
	echo "queen.rs - non-recursion"
	rustc -O -C opt-level=3 queen.rs -o a.out && ./a.out ; rm -f a.out
	echo "queen.go - non-recursion"
	go build -o a.out queen.go && ./a.out ; rm -f a.out
	echo ""
	echo "queen2.c - recursion"
	eval $CC ${CFLAGS} queen2.c -o a.out -static && ./a.out ; rm -f a.out
	echo "queen2.rs - recursion"
	rustc -O -C opt-level=3 queen2.rs -o a.out && ./a.out ; rm -f a.out
	echo "queen2.go - recursion"
	go build -o a.out queen2.go && ./a.out ; rm -f a.out

	echo "queen3.c - long time N=15"
	eval $CC -O3 -mllvm -polly queen3.c -o a.out -static && ./a.out ; rm -f a.out
	echo "queen3.rs - long time N=15"
	rustc -O -C opt-level=3 queen3.rs -o a.out && ./a.out ; rm -f a.out
}

let i=0
while [[ ${i} -lt 3 ]] {
	echo "-------------------------- $((++i)) -----------------------------"
	run
}

