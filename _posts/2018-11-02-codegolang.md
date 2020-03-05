---
layout: post
title: "golang"
date: 2020-02-13 10:25:06
description: golang
tags:
 - code
---

**beginner**
[beginner](https://learnxinyminutes.com/docs/go/)
[playground](https://tour.golang.org/welcome/4)

**GOROOT,GOPATH,workspace**
$GOROOT is where Go’s code, compiler, and tooling lives, something like
/usr/local/go
$GOPATH environment variable lists places for Go to look for Go Workspaces
A Go Workspace is how Go manages our source files, compiled binaries, and cached objects used for faster compilation later.

**workspace**
```
.
├── bin
├── pkg
└── src
  └── github.com/foo/bar
    └── bar.go
```
The $GOPATH/bin directory is where Go places binaries that go install compiles.
The $GOPATH/pkg directory is where Go stores pre-compiled object files to speed up subsequent compiling of programs.(can be deleted and rebuilt)
The src directory is where all of our .go files, or source code, must be located. 

**module,packages**
- packages
[packages](https://www.callicoder.com/golang-packages/)

- module
Go Modules is deemed to be the official attempt at a solution for handling dependencies within your Go applications going forward. The main reasoning for this piece of work was to essentially allow Go developers to use semantic versioning for their Go packages. v1.2.3, where 1 would be the major version of your application, 2 would be the minor version, and 3 would be the patch version.
[why module](https://medium.com/rungo/anatomy-of-modules-in-go-c8274d215c16)


**layout**
- /cmd
Main applications for this project.
- /internal
Private application and library code. This is the code you don't want others importing in their applications or libraries
- /pkg
Library code that's ok to use by external applications
- /init
System init (systemd, upstart, sysv) and process manager/supervisor (runit, supervisord) configs. 
- /configs
Configuration file templates or default configs
- /build
Packaging and Continuous Integration.


[layout](https://github.com/golang-standards/project-layout)

**command**
```
> go --help
Go is a tool for managing Go source code.

Usage:

	go <command> [arguments]

The commands are:

	bug         start a bug report
	build       compile packages and dependencies
	clean       remove object files and cached files
	doc         show documentation for package or symbol
	env         print Go environment information
	fix         update packages to use new APIs
	fmt         gofmt (reformat) package sources
	generate    generate Go files by processing source
	get         add dependencies to current module and install them
	install     compile and install packages and dependencies
	list        list packages or modules
	mod         module maintenance
	run         compile and run Go program
	test        test packages
	tool        run specified go tool
	version     print Go version
	vet         report likely mistakes in packages
```

**debug**
GOTRACEBACK
