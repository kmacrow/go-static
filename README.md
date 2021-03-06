# go-static

`go-static` is a container for compiling static go binaries for Linux using [musl](https://www.musl-libc.org/). Why a container? So you can use it on MacOS, duh. Also because containers. Containers. Docker.

### Usage
```bash
make
sudo make install

# Try it out...
go-static version

# Build something...
cd /my/project/my-app
go-static build

# Check that it's static...
file my-app
   go-app: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped
```
Use `go-static` anywhere you would use `go` for building your projects.

### Background

Static binaries are nice because you can run them in a container without a Linux distro base (i.e. `FROM scratch`) resulting in super small and minimalist images: fast builds and pulls, fewer headaches (hopefully).

Unfortunately `glibc` is difficult or impossible to statically link, making it hard to build static binaries for anything but the most trivial programs. Enter [musl](https://www.musl-libc.org/), a very small `glibc` compatible `libc` implementation for Linux. Because musl is completely self-contained we can easily link statically against it.

Because we need musl to build our static binaries, and musl is only for Linux, and cross compiling C code is a nightmare, we run `go` in a container with the environment already set up for linking against musl. A shell script runs the `go-static:latest` image with the local `$GOPATH` mounted, making for a near-seamless experience (vs. just using `go`)
