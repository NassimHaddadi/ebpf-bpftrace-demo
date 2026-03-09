# eBPF / bpftrace Demo

This project demonstrates Linux kernel tracing using eBPF and bpftrace.

## Demo 1 : execsnoop

Trace all programs executed in the system.

Run:

sudo bpftrace /usr/sbin/execsnoop.bt

In another terminal run:

ls
whoami
nano test.txt

You will see the processes appearing in real time.


## Demo 2 : opensnoop

Trace files opened by programs.

Run:

sudo bpftrace /usr/sbin/opensnoop.bt

In another terminal run:

nano demo.txt
cat /etc/passwd

The opened files will appear live.


## Demo 3 : tcpconnect

Trace network connections made by programs.

Run:

sudo bpftrace /usr/sbin/tcpconnect.bt

In another terminal run:

ping -c 4 google.com
curl http://example.com

You will see which program connects to which IP.



























