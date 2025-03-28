# SSE - Host CPU Load Percentage

A demonstration of Server-Sent Events.

This program hosts a webpage that shows the load on the Host CPU's cores in realtime. This is done by repeatedly executing the program `turbostat` in the background.

*N.B. hardcoded to 4 cores*

## How to run

As `turbostat` needs to run with root priviliges, so does this program:

`sudo go run .`

then 

`http://localhost:8090/` in your browser.

## Build dependencies

`go 1.24.1` (older versions down until go 1.22 may work)

## Runtime dependencies

`turbostat`