FROM alpine:edge
RUN apk --no-cache add dnsmasq

RUN mkdir -p /etc/default/ && echo -e "ENABLED=1\nIGNORE_RESOLVCONF=yes" > /etc/default/dnsmasq

EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq", "-k"]