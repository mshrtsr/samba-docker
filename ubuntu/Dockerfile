FROM ubuntu:16.04
LABEL maintainer "Masaharu TASHIRO <masatsr.kit@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
# Install dependencies
RUN set -x \
    && apt-get -yqq update \
    && apt-get -yqq install acl attr autoconf bind9utils bison build-essential \
    debhelper dnsutils docbook-xml docbook-xsl flex gdb libjansson-dev krb5-user \
    libacl1-dev libaio-dev libarchive-dev libattr1-dev libblkid-dev libbsd-dev \
    libcap-dev libcups2-dev libgnutls28-dev libgpgme11-dev libjson-perl \
    libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl \
    libpopt-dev libreadline-dev nettle-dev perl perl-modules pkg-config \
    python-all-dev python-crypto python-dbg python-dev python-dnspython \
    python3-dnspython python-gpgme python3-gpgme python-markdown python3-markdown \
    python3-dev xsltproc zlib1g-dev liblmdb-dev lmdb-utils \
    wget \
   --no-install-recommends \
    && apt-get -yqq autoremove \
    && apt-get -yqq clean \
    && rm -rf /var/lib/apt/lists* /var/tmp/* /tmp/* 

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
