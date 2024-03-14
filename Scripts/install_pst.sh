#!/bin/bash
#|---/ /+--------------------------------------+---/ /|#
#|--/ /-| Script to apply post install configs |--/ /-|#
#|-/ /--| Prasanth Rangan                      |-/ /--|#
#|/ /---+--------------------------------------+/ /---|#

source global_fn.sh
if [ $? -ne 0 ] ; then
    echo "Error: unable to source global_fn.sh, please execute from $(dirname "$(realpath "$0")")..."
    exit 1
fi

# dolphin
if pkg_installed dolphin && pkg_installed xdg-utils
    then

    echo -e "\033[0;32m[FILEMANAGER]\033[0m detected // dolphin"
    xdg-mime default org.kde.dolphin.desktop inode/directory
    echo -e "\033[0;32m[FILEMANAGER]\033[0m setting" `xdg-mime query default "inode/directory"` "as default file explorer..."
    kmenuPath="$HOME/.local/share/kio/servicemenus"
    mkdir -p "${kmenuPath}"
    echo -e "[Desktop Entry]\nType=Service\nMimeType=image/png;image/jpeg;image/jpg;image/gif\nActions=Menu-Refresh\nX-KDE-Submenu=Set As Wallpaper..." > "${kmenuPath}/hydewallpaper.desktop"
    echo -e "\n[Desktop Action Menu-Refresh]\nName=.: Refresh List :.\nExec=${HyprdotsDir}/scripts/swwwallkon.sh" >> "${kmenuPath}/hydewallpaper.desktop"
    chmod +x "${kmenuPath}/hydewallpaper.desktop"

else
    echo -e "\033[0;33m[WARNING]\033[0m dolphin is not installed..."
fi


# shell
./restore_shl.sh ${getShell}


# flatpak
if ! pkg_installed flatpak
    then

    echo -e "\033[0;32m[FLATPAK]\033[0m flatpak application list..."
    awk -F '#' '$1 != "" {print "["++count"]", $1}' .extra/custom_flat.lst
    prompt_timer 10 "Install these flatpaks? [Y/n]"
    fpkopt=${promptIn,,}

    if [ "${fpkopt}" = "y" ] ; then
        echo -e "\033[0;32m[FLATPAK]\033[0m intalling flatpaks..."
        .extra/install_fpk.sh
    else
        echo -e "\033[0;33m[SKIP]\033[0m intalling flatpaks..."
    fi

else
    echo -e "\033[0;33m[SKIP]\033[0m flatpak is already installed..."
fi

