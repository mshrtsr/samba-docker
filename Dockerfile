FROM alpine:3.9
LABEL maintainer "Masaharu TASHIRO <masatsr.kit@gmail.com>"

# Install dependencies
RUN apk add -U --no-cache \
  alpine-sdk perl python3 python3-dev jansson-dev \
  libarchive-dev acl-dev openldap-dev linux-pam-dev \
  rpcgen \
  && rm -rf /var/cache/apk/*

# Copy samba source
ENV samba_version="4.10.3"
WORKDIR /
RUN wget -O - https://download.samba.org/pub/samba/stable/samba-${samba_version}.tar.gz | tar zxvf -

# Configure samba
WORKDIR /samba-${samba_version}
RUN ./configure --systemd-install-services --with-systemd \
  --without-ad-dc --enable-fhs --prefix=/usr/local --sysconfdir=/etc --localstatedir=/var

# Build samba
RUN make

# Install samba
RUN make install
