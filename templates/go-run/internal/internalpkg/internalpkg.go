package internalpkg

import "context"

// Add returns the sum of two integers.
func Add(ctx context.Context, x, y int) int {
	return x + y
}
