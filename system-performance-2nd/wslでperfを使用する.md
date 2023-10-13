### wsl で perf を使用する

```
# windows
wsl --update
# wsl 2
sudo apt update
sudo apt install flex bison
sudo apt install libdwarf-dev libelf-dev libnuma-dev libunwind-dev \
libnewt-dev libdwarf++0 libelf++0 libdw-dev libbfb0-dev \
systemtap-sdt-dev libssl-dev libperl-dev python-dev-is-python3 \
binutils-dev libiberty-dev libzstd-dev libcap-dev libbabeltrace-dev
git clone https://github.com/microsoft/WSL2-Linux-Kernel --depth 1
cd WSL2-Linux-Kernel/tools/perf
make -j8 # parallel build
sudo cp perf /usr/local/bin
```

使用できるようになったが tracepoint が見つからない

```
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ perf --help

 usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

 The most commonly used perf commands are:
   annotate        Read perf.data (created by perf record) and display annotated code
   archive         Create archive with object files with build-ids found in perf.data file
   bench           General framework for benchmark suites
   buildid-cache   Manage build-id cache.
   buildid-list    List the buildids in a perf.data file
   c2c             Shared Data C2C/HITM Analyzer.
   config          Get and set variables in a configuration file.
   daemon          Run record sessions on background
   data            Data file related processing
   diff            Read perf.data files and display the differential profile
   evlist          List the event names in a perf.data file
   ftrace          simple wrapper for kernel's ftrace functionality
   inject          Filter to augment the events stream with additional information
   iostat          Show I/O performance metrics
   kallsyms        Searches running kernel for symbols
   kmem            Tool to trace/measure kernel memory properties
   kvm             Tool to trace/measure kvm guest os
   list            List all symbolic event types
   lock            Analyze lock events
   mem             Profile memory accesses
   record          Run a command and record its profile into perf.data
   report          Read perf.data (created by perf record) and display the profile
   sched           Tool to trace/measure scheduler properties (latencies)
   script          Read perf.data (created by perf record) and display trace output
   stat            Run a command and gather performance counter statistics
   test            Runs sanity tests.
   timechart       Tool to visualize total system behavior during a workload
   top             System profiling tool.
   version         display the version of perf binary
   probe           Define new dynamic tracepoints
   trace           strace inspired tool

 See 'perf help COMMAND' for more information on a specific command.
masami@DESKTOP-L18OTEK:/mnt/c/Users/user$ perf list tracepoint

List of pre-defined events (to be used in -e):
```

CPU フレームグラフを作りたい場合

```
masami@DESKTOP-L18OTEK /m/c/U/user [100]> git clone https://github.com/brendangregg/FlameGraph
Cloning into 'FlameGraph'...
remote: Enumerating objects: 1217, done.
remote: Counting objects: 100% (646/646), done.
remote: Compressing objects: 100% (123/123), done.
remote: Total 1217 (delta 543), reused 523 (delta 523), pack-reused 571
Receiving objects: 100% (1217/1217), 1.90 MiB | 165.00 KiB/s, done.
Resolving deltas: 100% (720/720), done.
Updating files: 100% (159/159), done.
masami@DESKTOP-L18OTEK /m/c/U/user> cd FlameGraph
masami@DESKTOP-L18OTEK /m/c/U/u/FlameGraph (master) [255]> sudo perf record -F 99 -a -g -- sleep 60
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.597 MB perf.data (4698 samples) ]
masami@DESKTOP-L18OTEK /m/c/U/u/FlameGraph (master)> perf script | ./stackcollapse-perf.pl > out.perf-folded
masami@DESKTOP-L18OTEK /m/c/U/u/FlameGraph (master)> ./flamegraph.pl out.perf-folded > perf-kernel.svg
```
