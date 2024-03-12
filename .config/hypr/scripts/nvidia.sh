Teez
yungteez
Online

Teez — 01/18/2024 11:41 PM
Do you have any new themes in the works?
nagnar — 01/18/2024 11:41 PM
Nothing as of now... Got busy with work this month with limited access to my pc
But I'm planning to add new mode to switch between classic mode and widget mode on the fly
To port current features as widgets
Teez — 01/18/2024 11:43 PM
Look forward to it!
How long have you been coding and using Linux?
nagnar — 01/18/2024 11:43 PM
Thank you brother!
Teez — 01/18/2024 11:44 PM
Im pretty new to Linux and ricing as a whole but your install script has helped me see different things and how they work
nagnar — 01/18/2024 11:44 PM
I switched to linux from windows last year... So almost 1 year now
nagnar — 01/18/2024 11:45 PM
Don't worry bro... It just takes some time to get used to it
Teez — 01/18/2024 11:45 PM
It’s insane what can be done. Well I appreciate the response! I won’t take any more of your time. Have a great day or night whatever time it is for you
nagnar — 01/18/2024 11:46 PM
Once you get comfortable, youll start messing around and changing everything as you want it to work
Teez — 01/18/2024 11:46 PM
Is that how you learned?
Just messing with other peoples rices or do you have previous background in coding/css
nagnar — 01/18/2024 11:47 PM
Yup, just googling and the wikis... Especially arch wiki
nagnar — 01/18/2024 11:48 PM
I've experience in database development... So I do write SQL code for my day job... And I've use linux servers for work as all databases runs on linux
Teez — 01/18/2024 11:49 PM
That makes sense
nagnar — 01/18/2024 11:50 PM
So my shell scripts are built on very simple and basic commands for file manipulation 
Teez — 01/22/2024 6:33 PM
hey!
Teez — 01/23/2024 7:23 PM
would love to pick your brain whenever your around and have some free time
nagnar — 01/31/2024 9:54 AM
Hey bro... Sorry i missed this
Was kinda busy with travel and exam last week
I'm free from this week 😂
Teez — 01/31/2024 10:39 AM
Hey man no worries
Teez — 01/31/2024 4:52 PM
One thing i wanted to ask was how you got vscode blurred
nagnar — 02/01/2024 3:38 AM
Yup, it's set in .config/hypr/windowrules.conf
Oh sorry that's for transparency
The blur is set in .config/hypr/themes/* file based on your current theme
Teez — 02/01/2024 10:59 AM
hmm im not running any themes folders in /hypr
Teez — 02/01/2024 3:21 PM
the only blur i find in your themes is for waybar
Teez — 03/06/2024 10:32 PM
hey mate
if and when you have some time, I'm looking for a bash script similar to your install script that can auto detect gpus and install the correct drivers and set the paramaters.
if this is something you could write for me i'd be happy to pay you for your time
nagnar — 03/06/2024 11:43 PM
Hey
Ya sure, I'll be free this weekend.. will have a look
My install should work for detecting gpu... So you can repurpose it
Teez — 03/06/2024 11:45 PM
haha i've tried, its just split into multiple scripts
maybe i'll give it another go
nagnar — 03/07/2024 12:57 AM
Ya no worries, just let me know what you want to do with the script
I'll modify it for you...
Teez — 03/07/2024 12:58 AM
just looking for a simple gpu detect, and to install the drivers and set the paramaters required for grub or systemd 
nagnar — 03/07/2024 1:01 AM
Oki cool... I'll rewrite it in a single script.. will try this weekend
Teez — 03/07/2024 1:19 AM
thanks mate
Teez — 03/09/2024 9:23 AM
any progress?
nagnar — 03/09/2024 11:25 AM
Completely forgot bro
I don't have good memory 😂
Will do in a few mins
nagnar — 03/09/2024 12:59 PM
here you go, let me know if it works
#!/bin/bash
#:: script to install arch nvidia drivers ::


#// define functions
Expand
test.txt
3 KB
Teez — 03/09/2024 2:30 PM
will give this a try tonight!
Teez — 03/09/2024 2:58 PM
got a minute, it works! thank you very much
﻿
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

test.txt
3 KB