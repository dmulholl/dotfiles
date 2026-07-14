package shutdown

import (
	"context"
	"errors"
	"os"
	"os/signal"
	"syscall"
)

var ErrGracefulShutdown = errors.New("graceful shutdown")

func Listen(ctx context.Context) error {
	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM, syscall.SIGQUIT)
	defer signal.Stop(sigs)

	select {
	case <-ctx.Done():
		return nil
	case <-sigs:
		return ErrGracefulShutdown
	}
}
