package main

import (
	"context"
	"log"
	"os"
	"os/signal"
	"time"
)

func main() {
	// https://millhouse.dev/posts/graceful-shutdowns-in-golang-with-signal-notify-context
	// source for how to do graceful shutdown

	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt)
	defer stop()

	var controller Controller
	controller.Setup()
	controller.Run()

	<-ctx.Done()

	stop()
	log.Println("Shutting down gracefully. Press Ctrl+C again to force shutdown.")

	timeoutCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	go controller.Shutdown(timeoutCtx)

	select {
	case <-timeoutCtx.Done():
		if timeoutCtx.Err() == context.DeadlineExceeded {
			log.Fatalln("Timeout exceeded. Forcing shutdown.")
		}

		os.Exit(0)
	}
}
