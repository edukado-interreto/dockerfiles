FROM busybox

ARG PORT=8080
ENV PORT=$PORT

COPY --from=twinproduction/gatus /gatus /usr/local/bin/gatus
COPY --from=twinproduction/gatus /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY healthcheck.sh /usr/local/bin/

HEALTHCHECK --start-period=2s CMD /usr/local/bin/healthcheck.sh

EXPOSE $PORT

CMD ["gatus"]
