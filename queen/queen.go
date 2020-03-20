package main

import (
	"flag"
	"log"
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
	log.Printf("found=%v, time=%v\n", found, time.Now().Sub(ts))
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

func queen() int {
	var q [N]int
	found := 0
	row := 0
	done := 0

	for done == 0 {
		if check(&q, row) > 0 {
			if row == N-1 {
				found++
			} else {
				row++
				q[row] = 0
				continue
			}
		}
		q[row] += 1
		for q[row] >= N {
			row--
			if row >= 0 {
				q[row]++
			} else {
				done = 1
				break
			}
		}
	}
	return found
}
