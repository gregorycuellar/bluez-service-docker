FROM debian:bookworm-slim

RUN apt-get update -q -y \
 && apt-get install -y --no-install-recommends \
    bluez \
    dbus \
 && \
    apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY ./bluezuser.conf /etc/dbus-1/system.d/

RUN addgroup --system --gid 1888 bluezuser \
 && adduser --system --uid 1888 --no-create-home --home /var/empty --shell /sbin/nologin --ingroup bluezuser bluezuser

USER bluezuser

COPY docker-entrypoint.sh /

CMD ["/docker-entrypoint.sh"]