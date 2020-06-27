#!/bin/bash

which apt && PKG_CMD="apt"
which yum && PKG_CMD="yum"

case $PKG_CMD in
    apt)
        installer/apt-install.sh
        ;;
    yum)
        installer/yum-install.sh
        ;;
    *)
        echo -en "\nUnSupported Opearating System\n\n"
        exit 1
        ;;
esac

