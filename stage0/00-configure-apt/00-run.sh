#!/bin/bash -e

install -m 644 files/sources.list "${ROOTFS_DIR}/etc/apt/"
install -m 644 files/raspi.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list"
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/raspi.list"

if [ -n "$APT_PROXY" ]; then
	install -m 644 files/51cache "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache"
	sed "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache" -i -e "s|APT_PROXY|${APT_PROXY}|"
else
	rm -f "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache"
fi

cat files/raspberrypi.gpg.key | gpg --dearmor > "${STAGE_WORK_DIR}/raspberrypi-archive-stable.gpg"
cat files/uv4l.gpg.key | gpg --dearmor > "${STAGE_WORK_DIR}/uv4l.gpg"
cat files/uv4l-2.gpg.key | gpg --dearmor > "${STAGE_WORK_DIR}/uv4l-2.gpg"

install -m 644 "${STAGE_WORK_DIR}/raspberrypi-archive-stable.gpg" "${ROOTFS_DIR}/etc/apt/trusted.gpg.d/"
install -m 644 "${STAGE_WORK_DIR}/uv4l.gpg" "${ROOTFS_DIR}/etc/apt/trusted.gpg.d/"
install -m 644 "${STAGE_WORK_DIR}/uv4l-2.gpg" "${ROOTFS_DIR}/etc/apt/trusted.gpg.d/"
on_chroot << EOF
apt-get update
apt-get dist-upgrade -y
EOF
