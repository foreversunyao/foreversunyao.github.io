---
layout: post
title: "Linux Process"
date: 2016-02-02 10:25:06
description: Linux Process Life and Space, systemcall, thread
tags: 
 - linux
---

**Overview**

![img]({{ '/assets/images/linux/Process-Life-cycle.png' | relative_url }}){: .center-image }*(°0°)*

```
D Uninterruptible sleep (usually IO)

R Running or runnable (on run queue)

S Interruptible sleep (waiting for an event to complete)

T Stopped, either by a job control signal or because it is being traced.

W paging (not valid since the 2.6.xx kernel)

X dead (should never be seen)

Z Defunct ("zombie") process, terminated but not reaped by its parent.
```

A process is an executing (i.e., running) instance of a program. Processes are also frequently referred to as tasks.
We already know that process and thread are mostly similar. So, why do we use thread in application? Process with multithread is very useful in great server. Switching between processes is slower than thread. Thread uses very light weight resource and context switching fast. It can share common data without the need of IPC. Two or more threads are communicated to each other without pipe or FIFO. Multithreading technique is helpful to develop effective application.

TASK_RUNNING—The process is runnable; it is either currently running or on a runqueue waiting to run. This is the only possible state for a process executing in user-space; it can also apply to a process in kernel-space that is actively running.

TASK_INTERRUPTIBLE—The process is sleeping (that is, it is blocked), waiting for some condition to exist. When this condition exists, the kernel sets the process's state to TASK_RUNNING. The process also awakes prematurely and becomes runnable if it receives a signal.

TASK_UNINTERRUPTIBLE—This state is identical to TASK_INTERRUPTIBLE except that it does not wake up and become runnable if it receives a signal. This is used in situations where the process must wait without interruption or when the event is expected to occur quite quickly. Because the task does not respond to signals in this state, TASK_UNINTERRUPTIBLE is less often used than TASK_INTERRUPTIBLE6.

TASK_ZOMBIE—The task has terminated, but its parent has not yet issued a wait4() system call. The task's process descriptor must remain in case the parent wants to access it. If the parent calls wait4(), the process descriptor is deallocated.Zombie processes don’t use up any system resources. (Actually, each one uses a very tiny amount of system memory to store its process descriptor.) However, each zombie process retains its process ID (PID).kill -s SIGCHLD pid to ask parent process to execute the wait() system call.

TASK_STOPPED—Process execution has stopped; the task is not running nor is it eligible to run. This occurs if the task receives the SIGSTOP, SIGTSTP, SIGTTIN, or SIGTTOU signal or if it receives any signal while it is being debugged.

Similarity between process and thread are following:
Like process, thread shares CPU
Only one thread is active at a time same as process.
Thread can also create children like process.
One thread is blocked when another thread runs like process.

Difference between process and thread are as follows:
Threads are not independent unlike process
Thread can access only address in task
A process starts another process in two phases. First the process creates a fork of itself, an identical copy. Then the forked process executes an exec to replace the forked process with the target child process.
All threads of a process share its virtual address space and system resources. 

**create and terminate a process**
[refer](https://www.tutorialspoint.com/process-creation-vs-process-termination-in-operating-system)

![img]({{ '/assets/images/linux/linux_fork.png' | relative_url }}){: .center-image }*(°0°)*
**Address Space**

![img]({{ '/assets/images/linux/Process-address-space.jpg' | relative_url }}){: .center-image }*(°0°)*

Text code. This part of the virtual address space contains the machine code instructions to be executed by the processor. It is often write protected and shared among processes that use the same main program or the same shared libraries.

Static data. This part of the virtual address space contains the statically allocated variables to be used by the process.

Heap. This part of the virtual address space contains the dynamically allocated variables to be used by the process.

Stack. This part of the virtual address space contains the stack to be used by the process for storing items such as return addresses, procedure arguments, temporarily saved registers or locally allocated variables.

**Priority**

![img]({{ '/assets/images/linux/Linux-priority.png' | relative_url }}){: .center-image }*(°0°)*


**runlevel**
ID      Name                Description
---------------------------------------
0       Halt                Shuts down the system.
1       Single-user Mode    Mode for administrative tasks.
2       Multi-user Mode     Does not configure network interfaces and does not export networks services.
3       Multi-user Mode with Networking     Starts the system normally.
4       Not used/User-definable     For special purposes.
5       Start the system normally with appropriate display manager. (with GUI)  Same as runlevel 3 + display manager.
6       Reboot              Reboots the system.


**system call**
- Process Control
1. fork(), used for creating process, it does it by cloning the calling process but with a new pid and other resources 
2. exit(), The operating system reclaims resources that were used by the process after the exit() system call.
3. exec(), any process may call exec() at any time. The currently running program is immediately terminated, and the new program starts executing in the context of the existing process.
- File Management
1. open()
2. read()
3. write()
4. close()
- Device Management
1. ioctl(), device manipulation like reading from device buffers, writing into device buffers, etc. 
- Information Maintenance
It handles information and its transfer between the OS and the user program. In addition, OS keeps the information about all its processes and system calls are used to access this information. 
1. getpid()
2. alarm(), This system call sets an alarm clock for the delivery of a signal that when it has to be reached.
3. sleep(), This System call suspends the execution of the currently running process for some interval of time
- Communication
Message Passing(processes exchange messages with one another)
Shared memory(processes share memory region to communicate)
1. pipe()
2. shmget()
3. mmap()

**fork() vs exec()**
Factors for Differentiation	fork()	exec()
Invoking	fork() creates a new duplicate child process of the process that invoked fork()	|| exec() replaces a process that invokes it with a new process provided in its parameter.
Process id	The child process and parent process have unique process id. || 	The new process and the replaced process have the same process id.
Execution	The parent and child process start simultaneous execution from the instruction just after fork(). || 	The currently running process is terminated and the exec() start execution of the new process from its entry point.
Arguments	No arguments are passed to fork() system call. || 	Basically, three or more arguments are passed to the exec() system call.
Format	Pid=fork();	|| exec(cont char * filename, char* const argv[], char* const envp[])
1. example
```
 strace -f -etrace=execve,clone bash -c '{ ls; }'
execve("/usr/bin/bash", ["bash", "-c", "{ ls; }"], 0x7fff153d0ed0 /* 36 vars */) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLDstrace: Process 115538 attached
, child_tidptr=0x7fe8b4f10a10) = 115538
[pid 115538] execve("/usr/bin/ls", ["ls"], 0x55eed8e42be0 /* 36 vars */) = 0
Desktop  Documents  Downloads  Dropbox	IdeaProjects  Music  Pictures  Public  Templates  Videos  revision  soft
[pid 115538] +++ exited with 0 +++
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=115538, si_uid=1000, si_status=0, si_utime=0, si_stime=0} ---
+++ exited with 0 +++
```
it takes two steps to create a process:

The clone system call creates the process as a clone of the bash process
The execve system call then replaces the executable in the process with the ls command binary

2. parent process creates every process in Linux except the PID 1 (INIT process). 
pstree

**THREAD**
1. A process is a computer program under execution. Linux processes are isolated and do not interrupt each other’s execution. Process context switching is expensive because the kernel has to save old registers and load current registers, memory maps, and other resources.
2. Thread, A process can do more than one unit of work concurrently by creating one or more threads. 
```
ps -eLf
UID          PID    PPID     LWP  C NLWP STIME TTY          TIME CMD
root           1       0       1  0    1 Jun28 ?        00:00:16 /usr/lib/systemd/systemd --switched-root --system --deserialize 31
root           2       0       2  0    1 Jun28 ?        00:00:00 [kthreadd]
root           3       2       3  0    1 Jun28 ?        00:00:00 [rcu_gp]
root           4       2       4  0    1 Jun28 ?        00:00:00 [rcu_par_gp]
root           6       2       6  0    1 Jun28 ?        00:00:05 [kworker/0:0H-acpi_thermal_pm]
root           8       2       8  0    1 Jun28 ?        00:00:00 [mm_percpu_wq]
root          12       2      12  0    1 Jun28 ?        00:00:11 [ksoftirqd/0]
root          13       2      13  0    1 Jun28 ?        00:01:30 [rcu_sched]
root          14       2      14  0    1 Jun28 ?        00:00:00 [migration/0]
root         690       1     690  0    2 Jun28 ?        00:00:00 /sbin/auditd
root         690       1     691  0    2 Jun28 ?        00:00:00 /sbin/auditd
root         709       1     709  0    4 Jun28 ?        00:00:00 /usr/sbin/ModemManager
root         709       1     728  0    4 Jun28 ?        00:00:00 /usr/sbin/ModemManager
root         709       1     729  0    4 Jun28 ?        00:00:00 /usr/sbin/ModemManager
root         709       1     742  0    4 Jun28 ?        00:00:00 /usr/sbin/ModemManager

PID: Unique process identifier
LWP: Unique thread identifier inside a process
NLWP: Number of threads for a given process
```
3. thread shares the same address space of the process. Therefore, spawning a new thread within a process becomes cheap. Internally, the thread has only a stack in the memory, and they share the heap (process memory) with the parent process.
4. We use fork (or clone) and execve system calls for creating a process in Linux. Here, the fork system call creates a child process equivalent to the parent process. The execve system call replaces the executable of the child process. In modern implementations, the fork system call internally uses the clone system call.
5. Linux creates every process using a data structure in C called task_struct. The Linux kernel holds them in a dynamic list to represent all the running processes called tasklist. In this tasklist, each element is of task_struct type, which depicts a Linux process. it has  scheduling parameters, memory image, signals, machine registers, system calls state, file descriptors, kernel stack
