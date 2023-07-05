#!/bin/bash -e




on_chroot << EOF
        SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_legacy 0
        SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_spi 0
        SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_i2c 0
        SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_rgpio 0
        SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_serial 0
        
       	SUDO_USER="${FIRST_USER_NAME}" sed -i 's/# width = 640/width = 800/'   ${ROOTFS}/etc/uv4l/uv4l-raspicam.conf
       	SUDO_USER="${FIRST_USER_NAME}" sed -i 's/# height = 480/height = 600 /'   ${ROOTFS}/etc/uv4l/uv4l-raspicam.conf
       	SUDO_USER="${FIRST_USER_NAME}" sed -i 's/# framerate = 30/framerate = 15'/   ${ROOTFS}/etc/uv4l/uv4l-raspicam.conf
       	SUDO_USER="${FIRST_USER_NAME}" sed -i 's/# quality = 85/quality = 50/'   ${ROOTFS}/etc/uv4l/uv4l-raspicam.conf
       	SUDO_USER="${FIRST_USER_NAME}" sed -i 's/# hflip = no/hflip = yes/'   ${ROOTFS}/etc/uv4l/uv4l-raspicam.conf
       	SUDO_USER="${FIRST_USER_NAME}" sed -i 's/# vflip = no/vflip = yes/'   ${ROOTFS}/etc/uv4l/uv4l-raspicam.conf
       	
EOF
