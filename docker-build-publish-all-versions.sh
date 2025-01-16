# https://pkgs.alpinelinux.org/packages?name=openvpn&branch=edge&repo=&arch=&origin=&flagged=&maintainer=

echo "v3.16" > github-artifact/alpine_branch
echo "2.5.6-r1" > github-artifact/openvpn_pkg_version
./docker-build-publish.sh

echo "v3.17" > github-artifact/alpine_branch
echo "2.5.10-r1" > github-artifact/openvpn_pkg_version
./docker-build-publish.sh


echo "v3.20" > github-artifact/alpine_branch
echo "2.6.11-r0" > github-artifact/openvpn_pkg_version
./docker-build-publish.sh


echo "v3.21" > github-artifact/alpine_branch
echo "2.6.12-r1" > github-artifact/openvpn_pkg_version
./docker-build-publish.sh

echo "edge" > github-artifact/alpine_branch
echo "2.6.13-r0" > github-artifact/openvpn_pkg_version
./docker-build-publish.sh