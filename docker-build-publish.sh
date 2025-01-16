#docker buildx create --name mbuilder
#docker buildx use mbuilder
#docker login -u username -p password

# https://pkgs.alpinelinux.org/packages?name=openvpn&branch=edge&repo=&arch=&origin=&flagged=&maintainer=

#export ALPINE_BRANCH="$(cat github-artifact/alpine_branch)"
export OPENVPN_PKG_VERSION="$(cat github-artifact/openvpn_pkg_version | cut -d '-' -f1)"

#--build-arg ALPINE_BRANCH=we \
#--build-arg OPENVPN_PKG_VERSION \

echo $OPENVPN_PKG_VERSION
#exit
docker buildx build \
--push \
--platform linux/arm/v7,linux/arm64/v8,linux/amd64 \
--tag davideciarmi/openvpn-server:$OPENVPN_PKG_VERSION \
.
