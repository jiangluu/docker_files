From golang:1.14-alpine

RUN apk update && apk add git

RUN mkdir -p ${GOPATH}/src/golang.org/x && cd ${GOPATH}/src/golang.org/x && git clone https://github.com/golang/sys.git

RUN go env -w GOPROXY=https://goproxy.cn,direct && go env -w GOSUMDB="sum.golang.google.cn"

RUN go get github.com/Monibuca/monica

EXPOSE 8000

CMD ["monica"]