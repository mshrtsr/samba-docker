FROM alpine:3.9
LABEL maintainer "Masaharu TASHIRO <masatsr.kit@gmail.com>"

# Add repository
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main/ >> /etc/apk/repositories

# Install samba
RUN apk add -U --no-cache \
  samba=4.10.2-r0 \
  && rm -rf /var/cache/apk/*

# Execute samba
CMD ["smbd", "-i"]
