FROM ubuntu:trusty

RUN apt-get update && \
    apt-get install -y curl build-essential

# install go
RUN curl https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz > go.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz

ENV GOPATH="/work"

# install muscl
RUN curl https://www.musl-libc.org/releases/musl-1.1.15.tar.gz > musl.tar.gz && \
    tar -xvf musl.tar.gz && \
    cd musl-1.1.15 && ./configure && make && make install

ENV CC="/usr/local/musl/bin/musl-gcc" \
    GOFLAGS="-a -v" \
    LDFLAGS="-linkmode external -extldflags '-static'"

ENTRYPOINT ["/usr/local/go/bin/go"]
