package q103

import (
	"fmt"
	"strconv"
)

func joinInt(a []int, sep string) string {
	r := ""
	for _, v := range a {
		if r != "" {
			r += sep
		}
		r += fmt.Sprint(v)
	}
	return r
}

func solve(ssrc string) string {
	src64, err := strconv.ParseInt(ssrc, 16, 32)
	if err != nil {
		panic(err)
	}
	src := int(src64)
	ary := make([]int, 0, src)
	for i := 1; i <= src; i++ {
		if (i & src) == i {
			ary = append(ary, i)
		}
	}
	if 15 < len(ary) {
		h := joinInt(ary[0:13], ",")
		t := joinInt(ary[len(ary)-2:len(ary)], ",")
		return h + ",...," + t
	} else {
		return joinInt(ary, ",")
	}
}
