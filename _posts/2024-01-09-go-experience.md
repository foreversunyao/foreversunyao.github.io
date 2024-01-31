---
layout: post
title: "go experiences"
date: 2024-01-11 12:25:06
description: go experiences 
tags:
 - code
---

- GO111MODULE

GO111MODULE=off: This value disables the Go module system and uses the legacy GOPATH mode instead. In this mode, dependencies are downloaded and stored in the GOPATH directory, and the go command looks for packages in the directories specified by the GOPATH environment variable.

GO111MODULE=on: This value enables the Go module system and uses modules to manage dependencies. In this mode, the go command looks for the go.mod file in the project directory to determine the required dependencies and their versions. If the file exists, the command downloads the required dependencies and stores them in a local cache, which can be shared between projects.

- data race 
[refer](https://www.sohamkamani.com/golang/data-races/?utm_content=cmp-true)
We don't know which goroutine(main or i=5) will be executed firstly
```
func main() {
	fmt.Println(getNumber())
}

func getNumber() int {
	var i int
	go func() {
		i = 5
	}()
	return i
}
```
- memory allocation
new() function allocates but does not initialize memory, reaults in zeroed storage but returns a memory address

make() function allocates and initializes memory, allocates non-zeroed storage and returns a memory address

Memory is deallocated by garbage collector(GC)

Objects out of scope or set to nil are eligible

- pointer, reference variable
```
import "fmt"
func main() {
  anInt := 42
  var p = &anInt
  fmt.Println("value of p:", *p)

}
```
- receiver
the print() function is a function which can receive a person.
```
type person struct {
	name string
	age int
}

func (p person) print() {
	fmt.Printf("%s is of %d years \n", p.name, p.age)
}

func main() {
	alex := person{
		name: "Alex",
		age: 18,
	}
	alex.print()
}
```
- adding waitgroups
```
func getNumber() int {
	var i int
	// Initialize a waitgroup variable
	var wg sync.WaitGroup
	// `Add(1) signifies that there is 1 task that we need to wait for
	wg.Add(1)
	go func() {
		i = 5
		// Calling `wg.Done` indicates that we are done with the task we are waiting fo
		wg.Done()
	}()
	// `wg.Wait` blocks until `wg.Done` is called the same number of times
	// as the amount of tasks we have (in this case, 1 time)
	wg.Wait()
	return i
}

```

- go-callvis
go-callvis is a development tool to help visualize call graph of a Go program using interactive view.
[refer](https://github.com/ondrajz/go-callvis)
