package internalpkg

import (
	"context"
	"testing"
)

func TestAdd(t *testing.T) {
	got := Add(context.Background(), 1, 2)
	want := 3

	if got != want {
		t.Errorf("wanted %d, got %d", want, got)
	}
}

func TestAdd_TableDriven(t *testing.T) {
	testcases := []struct {
		name string
		x    int
		y    int
		want int
	}{
		{
			name: "test 1",
			x:    1,
			y:    2,
			want: 3,
		},
		{
			name: "test 2",
			x:    2,
			y:    3,
			want: 5,
		},
	}

	for _, testcase := range testcases {
		t.Run(testcase.name, func(t *testing.T) {
			got := Add(context.Background(), testcase.x, testcase.y)
			if got != testcase.want {
				t.Errorf("wanted %d, got %d", testcase.want, got)
			}
		})
	}
}
