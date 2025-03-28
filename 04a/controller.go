package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os/exec"
	"strings"
	"time"
)

type Controller struct {
	server        http.Server
	cpuLoadChan   chan CpuLoad
	stopExecution chan bool
}

func (c *Controller) Setup() error {
	c.cpuLoadChan = make(chan CpuLoad)
	c.stopExecution = make(chan bool)

	mux := c.setupRoutes(http.NewServeMux())

	c.server = http.Server{Addr: ":8090", Handler: mux}

	return nil
}

func (c *Controller) setupRoutes(mux *http.ServeMux) *http.ServeMux {
	mux.Handle("/", http.FileServer(http.Dir("./static")))
	mux.HandleFunc("/events", c.eventHandler)

	return mux
}

func (c *Controller) Run() {
	go c.getCpuLoad()

	go func() {
		log.Fatal(c.server.ListenAndServe())
	}()
	log.Printf("HTTP server succesfully started on address: %s.", c.server.Addr)
}

func (c *Controller) Shutdown(timeoutCtx context.Context) {
	c.server.Shutdown(timeoutCtx)
	c.stopExecution <- true
}

func (c *Controller) eventHandler(w http.ResponseWriter, r *http.Request) {
	// https://medium.com/@rian.eka.cahya/server-sent-event-sse-with-go-10592d9c2aa1
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Expose-Headers", "Content-Type")

	w.Header().Set("Content-Type", "text/event-stream")
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Connection", "keep-alive")

	for true {
		select {
		case <-c.stopExecution:
			return
		case cpuLoad := <-c.cpuLoadChan:
			fmt.Fprintf(w, "event: core1\ndata: %s\n\n", cpuLoad.Core1)
			fmt.Fprintf(w, "event: core2\ndata: %s\n\n", cpuLoad.Core2)
			fmt.Fprintf(w, "event: core3\ndata: %s\n\n", cpuLoad.Core3)
			fmt.Fprintf(w, "event: core4\ndata: %s\n\n", cpuLoad.Core4)

			w.(http.Flusher).Flush()
		}
	}
}

func (c *Controller) getCpuLoad() {

	for true {
		select {
		case <-c.stopExecution:
			return
		default:
			stdout := runCommand()

			split := strings.Split(stdout, "\n")

			cpuLoad := CpuLoad{Core1: split[2], Core2: split[3], Core3: split[4], Core4: split[5]}

			c.cpuLoadChan <- cpuLoad

			time.Sleep(500 * time.Millisecond)
		}
	}
}

func runCommand() string {
	program := "turbostat"

	arg0 := "--show"
	arg1 := "Busy%"
	arg2 := "--quiet"
	arg3 := "--interval"
	arg4 := "0.1"
	arg5 := "--num_iteration"
	arg6 := "1"

	cmd := exec.Command(program, arg0, arg1, arg2, arg3, arg4, arg5, arg6)

	stdout, err := cmd.Output()
	if err != nil {
		log.Fatal(err)
	}

	return string(stdout)
}
