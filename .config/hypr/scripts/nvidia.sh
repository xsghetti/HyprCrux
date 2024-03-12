#!/bin/bash
#:: script to install arch nvidia drivers ::


#// define functions

nvidiaDetect() {
    vgaCard=$(lspci -k | grep -A 1 -E "(VGA|3D)" | awk -F 'controller: ' '{print $2}')
    if [ $(echo $vgaCard | grep -i nvidia | wc -l) -eq 1 ] ; then
        return 0
    else
        return 1
    fi
}

pkg_installed() {
    local PkgIn=$1

    if pacman -Qi $PkgIn &> /dev/null
    then
        return 0
    else
        return 1
    fi
}


#// detect nvidia

if nvidiaDetect ; then
    echo "nvidia card detected :: ${vgaCard}"
else
    echo "nvidia card not detected :: ${vgaCard}"
    exit 1
fi


#// install drivers

archPkg=($(cat /usr/lib/modules/*/pkgbase | sed 's/$/-headers/'))
archPkg+=("nvidia-dkms nvidia-utils")
sudo pacman -S ${archPkg[@]}


#// configure grub

if pkg_installed grub && [ -f /boot/grub/grub.cfg ] && [ ! -f /etc/default/grub.t2.bkp ] && [ ! -f /boot/grub/grub.t2.bkp ] ; then
    echo "bootloader detected :: grub"
    sudo cp /etc/default/grub /etc/default/grub.t2.bkp
    sudo cp /boot/grub/grub.cfg /boot/grub/grub.t2.bkp
    gcld=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=" "/etc/default/grub" | cut -d'"' -f2 | sed 's/\b nvidia_drm.modeset=.\b//g')
    sudo sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/c\GRUB_CMDLINE_LINUX_DEFAULT=\"${gcld} nvidia_drm.modeset=1\"" /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
fi


#// configure systemd-boot

if [ $(bootctl status | awk '{if ($1 == "Product:") print $2}') == "systemd-boot" ] ; then
    echo "bootloader detected :: systemd-boot"
    if [ $(ls -l /boot/loader/entries/*.conf.t2.bkp 2> /dev/null | wc -l) -ne $(ls -l /boot/loader/entries/*.conf 2> /dev/null | wc -l) ] ; then
        find /boot/loader/entries/ -type f -name "*.conf" | while read imgconf
        do
            sudo cp ${imgconf} ${imgconf}.t2.bkp
            sdopt=$(grep -w "^options" ${imgconf} | sed 's/\b quiet\b//g' | sed 's/\b splash\b//g' | sed 's/\b nvidia_drm.modeset=.\b//g')
            sudo sed -i "/^options/c${sdopt} quiet splash nvidia_drm.modeset=1" ${imgconf}
        done
    fi
fi
