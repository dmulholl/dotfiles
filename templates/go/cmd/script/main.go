package main

import (
	"fmt"

	"github.com/dmulholl/module-template/pkg/sample"
)

func main() {
	sum := sample.Add(1, 2)
	fmt.Printf("1 + 2 = %d\n", sum)
}
