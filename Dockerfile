# Original credit: https://github.com/jpetazzo/dockvpn

# Smallest base image
FROM alpine:latest

LABEL maintainer="Davide Ciarmiello"

#ARG ALPINE_BRANCH
#ARG OPENVPN_PKG_VERSION
#
#ENV ALPINE_BRANCH_VAR=$ALPINE_BRANCH
#ENV OPENVPN_PKG_VERSION_VAR=$OPENVPN_PKG_VERSION
#
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/$ALPINE_BRANCH_VAR/main/" >> /etc/apk/repositories
#RUN apk update
#
#RUN apk add iptables bash easy-rsa
#RUN apk add openvpn=$OPENVPN_PKG_VERSION_VAR openvpn-auth-pam google-authenticator libqrencode


COPY github-artifact variables

RUN echo "http://dl-cdn.alpinelinux.org/alpine/$(cat variables/alpine_branch)/main/" >> /etc/apk/repositories
RUN apk update

RUN apk add iptables bash easy-rsa
RUN apk add openvpn=$(cat variables/openvpn_pkg_version) openvpn-auth-pam google-authenticator libqrencode


RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk update
# Testing: pamtester
RUN apk add pamtester

RUN ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Needed by scripts
ENV OPENVPN=/etc/openvpn
ENV EASYRSA=/usr/share/easy-rsa \
    EASYRSA_CA_EXPIRE=36500 \
    EASYRSA_CERT_EXPIRE=36500 \
    EASYRSA_CRL_DAYS=36500 \
    EASYRSA_PKI=$OPENVPN/pki


VOLUME ["/etc/openvpn"]

# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

CMD ["ovpn_run"]

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# Add support for OTP authentication using a PAM module
ADD ./otp/openvpn /etc/pam.d/
