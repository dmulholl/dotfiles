package main

import (
	"fmt"

	"github.com/dmulholl/module-template/internal/intpkg"
	"github.com/dmulholl/module-template/pkg/pubpkg"
)

func main() {
	sum1 := intpkg.Add(1, 2)
	fmt.Printf("1 + 2 = %d\n", sum1)

	sum2 := pubpkg.Add(3, 4)
	fmt.Printf("3 + 4 = %d\n", sum2)
}
