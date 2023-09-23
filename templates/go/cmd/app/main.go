package main

import (
	"fmt"

	"github.com/dmulholl/modname/internal/testpkg"
)

func main() {
	sum := testpkg.Add(1, 2)
	fmt.Printf("1 + 2 = %d\n", sum)
}
