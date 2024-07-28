FROM docker.io/golang:1.22.5 AS build
WORKDIR /build
COPY . .

RUN go get github.com/relekang/coredns-blocklist
RUN go generate
RUN go build

FROM docker.io/fedora:41
COPY --from=build /build/coredns /bin/coredns
CMD ["/bin/coredns"]
