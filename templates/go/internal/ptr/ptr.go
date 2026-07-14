package ptr

// Returns a pointer to the argument.
func To[T any](v T) *T {
	return &v
}
