---
layout: post
title: "Linux Perf"
date: 2017-09-21 17:25:06
description: Linux Perf
tags: 
 - linux
---

**Perf Tool**

 - Usage

The most commonly used perf commands are:
     annotate        Read perf.data (created by perf record) and display annotated code
     archive         Create archive with object files with build-ids found in perf.data file
     bench           General framework for benchmark suites
     buildid-cache   Manage build-id cache.
     buildid-list    List the buildids in a perf.data file
     data            Data file related processing
     diff            Read perf.data files and display the differential profile
     evlist          List the event names in a perf.data file
     inject          Filter to augment the events stream with additional information
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
     probe           Define new dynamic tracepoints
     trace           strace inspired tool


 - Event:
Hardware cache event
Hardware event
Kernel PMU event
Raw hardware event descriptor
Software event
Tracepoint event

**Perf Example**
perf stat -d -a -g -- sleep 5

 Performance counter stats for 'system wide':

     213687.051292      task-clock (msec)         #   42.730 CPUs utilized            (3.19%)
            11,088      context-switches          #    0.052 K/sec                    (3.19%)
                62      cpu-migrations            #    0.000 K/sec                    (3.22%)
             6,663      page-faults               #    0.031 K/sec                    (3.27%)
     4,164,015,753      cycles                    #    0.019 GHz                      (3.30%)
   <not supported>      stalled-cycles-frontend
   <not supported>      stalled-cycles-backend
     4,083,498,652      instructions              #    0.98  insns per cycle          (0.32%)
     1,018,073,891      branches                  #    4.764 M/sec                    (0.32%)
        12,445,678      branch-misses             #    1.22% of all branches          (0.33%)
     1,329,661,336      L1-dcache-loads           #    6.222 M/sec                    (0.33%)
        59,291,150      L1-dcache-load-misses     #    4.46% of all L1-dcache hits    (0.28%)
   <not supported>      LLC-loads:HG
   <not supported>      LLC-load-misses:HG

       5.000903836 seconds time elapsed

The key metric here is instructions per cycle (insns per cycle: IPC), which shows on average how many instructions we were completed for each CPU clock cycle. The higher, the better (a simplification).
If your IPC is < 1.0, you are likely memory stalled, and software tuning strategies include reducing memory I/O, and improving CPU caching and memory locality, especially on NUMA systems. Hardware tuning includes using processors with larger CPU caches, and faster memory, busses, and interconnects.
If your IPC is > 1.0, you are likely instruction bound. Look for ways to reduce code execution: eliminate unnecessary work, cache operations, etc. CPU flame graphs are a great tool for this investigation. For hardware tuning, try a faster clock rate, and more cores/hyperthreads.
(refer:http://www.brendangregg.com/blog/2017-05-09/cpu-utilization-is-wrong.html)

task-clock: clock time for running tasks
context-switches: occur when the processor switches from one thread to another
cpu-migrations: happens when your process migrates from one core to another.
page-faults: When a program needs a memory page that is not yet mapped to process virtual memory, a page fault occurs.
cycles: They just happen regularly at a given frequency unless the processor is deliberately set idle.
instructions: number is a blunt count of instruction executed. 
branches: count is the number of branching happened in the whole run.
branch-misses: a number of cases where branch prediction failed to guess the execution path right

**Perf Tools**
https://github.com/brendangregg/perf-tools

