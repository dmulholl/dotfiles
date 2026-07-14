package main

import (
	"context"
	"errors"
	"log"
	"os"
	"time"

	"github.com/dmulholl/module-template/internal/httpserver"
	"github.com/dmulholl/module-template/internal/shutdown"
	"github.com/jessevdk/go-flags"
	"golang.org/x/sync/errgroup"
)

type options struct {
	ServerAddress     string            `long:"server-address" env:"SERVER_ADDRESS" default:":8080" description:"Server address"`
	SampleOptionGroup sampleOptionGroup `group:"sample" namespace:"sample" env-namespace:"SAMPLE"`
}

type sampleOptionGroup struct {
	Target   string        `long:"target" env:"TARGET" default:"foobar" description:"Target option"`
	Count    int           `long:"count" env:"COUNT" default:"10" description:"Count option"`
	Duration time.Duration `long:"duration" env:"DURATION" default:"10s" description:"Duration option"`
}

func main() {
	opts := options{}
	parser := flags.NewParser(&opts, flags.HelpFlag|flags.PassDoubleDash)

	if _, err := parser.Parse(); err != nil {
		if flagsErr, ok := err.(*flags.Error); ok && flagsErr.Type == flags.ErrHelp {
			parser.WriteHelp(os.Stdout)
			return
		}
		log.Fatalf("failed to parse flags: %v", err)
	}

	os.Exit(
		run(context.Background(), opts),
	)
}

func run(ctx context.Context, opts options) int {
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	log.Printf("starting service")

	g, ctx := errgroup.WithContext(ctx)
	g.Go(func() error { return shutdown.Listen(ctx) })

	server := httpserver.NewServer(opts.ServerAddress)
	g.Go(func() error { return server.Serve(ctx) })

	err := g.Wait()
	if err != nil {
		if errors.Is(err, shutdown.ErrGracefulShutdown) {
			log.Printf("graceful shutdown")
			return 0
		}
		log.Printf("error: %s", err)
		return 1
	}

	return 0
}
