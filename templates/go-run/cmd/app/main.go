package main

import (
	"context"
	"fmt"
	"io"
	"os"
	"os/signal"

	"github.com/dmulholl/modname/internal/internalpkg"
	"github.com/dmulholl/modname/pkg/publicpkg"
)

func run(ctx context.Context, w io.Writer, args []string) error {
	ctx, cancel := signal.NotifyContext(ctx, os.Interrupt)
	defer cancel()

	sum1 := internalpkg.Add(ctx, 1, 2)
	fmt.Printf("1 + 2 = %d\n", sum1)

	sum2 := publicpkg.Add(3, 4)
	fmt.Printf("3 + 4 = %d\n", sum2)

	return nil
}

func main() {
	ctx := context.Background()
	if err := run(ctx, os.Stdout, os.Args); err != nil {
		fmt.Fprintf(os.Stderr, "%s\n", err)
		os.Exit(1)
	}
}
