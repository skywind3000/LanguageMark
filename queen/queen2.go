package main

import (
	"flag"
	"fmt"
	"time"
)

var cpuprofile = flag.String("cpuprofile", "", "write cpu profile to file")

func main() {
	/*
		flag.Parse()
		if *cpuprofile != "" {
			f, err := os.Create(*cpuprofile)
			if err != nil {
				log.Fatal(err)
			}
			pprof.StartCPUProfile(f)
			defer pprof.StopCPUProfile()
		}
	*/

	queen()
	ts := time.Now()
	found := queen()
	fmt.Printf("found=%v, time=%v\n", found, time.Now().Sub(ts))
}

const N = 13

func check(q *[N]int, row int) int {
	if row == 0 {
		return 1
	} else {
		x0 := q[row]
		for y := 0; y < row; y++ {
			x := q[y]
			if x == x0 {
				return 0
			} else if x-x0 == row-y {
				return 0
			} else if x0-x == row-y {
				return 0
			}
		}
	}
	return 1
}

func search(q *[N]int, row int) int {
	found := 0
	for i := 0; i < N; i++ {
		q[row] = i
		if check(q, row) > 0 {
			if row == N - 1 {
				found++
			} else {
				found += search(q, row + 1)
			}
		}
	}
	return found
}

func queen() int {
	var q [N]int
	return search(&q, 0)
}
