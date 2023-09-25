package main

import (
	"fmt"

	"github.com/dmulholl/modname/internal/internalpkg"
	"github.com/dmulholl/modname/pkg/publicpkg"
)

func main() {
	sum1 := internalpkg.Add(1, 2)
	fmt.Printf("1 + 2 = %d\n", sum1)

	sum2 := publicpkg.Add(3, 4)
	fmt.Printf("3 + 4 = %d\n", sum2)
}
