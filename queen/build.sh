#! /bin/sh
gcc -O3 queen-c.c -o queen-c
rustc -O -C opt-level=3 queen-rs.rs -o queen-rs
