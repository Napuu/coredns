FROM docker.io/golang:1.22.5 AS build
WORKDIR /build
COPY . .

RUN go get github.com/relekang/coredns-blocklist
RUN go generate
RUN go build

FROM docker.io/busybox:1.36.1-glibc
COPY --from=build /build/coredns /bin/coredns
CMD ["/bin/coredns"]
