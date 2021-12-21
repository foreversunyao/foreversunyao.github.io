---
layout: post
title: "Linux Process"
date: 2016-02-02 10:25:06
description: Linux Process Life and Space, systemcall
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
```
Factors for Differentiation	fork()	exec()
Invoking	fork() creates a new duplicate child process of the process that invoked fork()	|| exec() replaces a process that invokes it with a new process provided in its parameter.
Process id	The child process and parent process have unique process id. || 	The new process and the replaced process have the same process id.
Execution	The parent and child process start simultaneous execution from the instruction just after fork(). || 	The currently running process is terminated and the exec() start execution of the new process from its entry point.
Arguments	No arguments are passed to fork() system call. || 	Basically, three or more arguments are passed to the exec() system call.
Format	Pid=fork();	|| exec(cont char *filename, char* const argv[], char* const envp[])
```
