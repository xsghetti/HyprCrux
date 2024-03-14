<h1 align="center">HyprCrux Dots<br></h1>
<h3 align ="center">Install Script Coming Soon...</h3>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png">
<div align="center">


![GitHub Repo stars](https://img.shields.io/github/stars/xsghetti/dotfiles?style=for-the-badge&logo=github&color=pink)
![GitHub commit activity](https://img.shields.io/github/commit-activity/t/xsghetti/dotfiles?style=for-the-badge&logo=github&color=lightgreen)


</div>

>  [!Caution]
>  This install script is meant for a minimal Arch Install.<br>
>  If you aren't using the script - these are my personal dots and may not work for you.<br>
>  My configs are messy as I'm not a dev, so use at your own risk.


https://github.com/xsghetti/dotfiles/assets/150515748/54886705-d963-45b8-9ce3-1b6d82cf5a98


https://github.com/xsghetti/dotfiles/assets/150515748/e37f75af-a02e-4daf-a652-effecf960f6e

![ss](https://github.com/xsghetti/dotfiles/assets/150515748/0a04d1d5-05ac-4f12-8544-d38917aa3135)

![rofi](https://github.com/xsghetti/dotfiles/assets/150515748/64ca9d2f-571e-409a-97a4-f2fa9bdba498)

![hyprlock](https://github.com/xsghetti/dotfiles/assets/150515748/2eaffb84-d53e-42cb-ac62-0d00836d66fc)

> [!Important]
> After Cloning the Repo - Run these commands separately. There are some prompts during the install so pay attention!

    cd ~/dotfiles/Scripts
<br>

    ./HyprCrux.sh
<br>

    ./install.sh


>
> When loading in for the first time, you will get
an initial error from pywal. Feel free to load
your own wallpapers into .config/wallpapers or 
use one of mine with the wallpaper selector with 
Super + W to select one. Logout & that error
should disappear.


> ## Depenencies <br>
>  [hyprland](https://hyprland.org)<br>
>  [hycov](https://github.com/Ayuei/hycov)<br>
>  [hyprtrails](https://github.com/hyprwm/hyprland-plugins/tree/main/hyprtrails) <br>
>  [hyprlock](https://github.com/hyprwm/hyprlock)<br>
>  [pyprland](https://github.com/hyprland-community/pyprland) <br>
>  [pywal](https://github.com/dylanaraps/pywal) <br>
>
> ```To get cava working with pywal - symlink template to cava/config```

    ln -sf "$HOME/.cache/wal/cava-colors" "$HOME/.config/cava/config" || true

> Hycov Keybindings will be commented out by default
to prevent the error message caused by HyprPM.<br>
HyprTrails is also coded into hyprland.conf but will
not trigger any errors. Feel free to enable them with
the commands below.

    hyprpm update
    
<br>
    
    hyprpm add https://github.com/hyprwm/hyprland-plugins
<br>
    
    hyprpm enable hycov
<br>
    
    hyprpm enable hyprtrails


<table><tr><td>
<code>D</code><br><code>E</code><br><code>T</code><br><code>A</code><br><code>I</code><br><code>L</code><br><code>S</code><br></td><td><table>
    <tr><td>OS</td><td>Arch</td></tr>
    <tr><td>WM</td><td>Hyprland</td></tr>
    <tr><td>Terminal</td><td>Kitty</td></tr>
    <tr><td>Shell</td><td>ZSH</td></tr>
 </table>
</td></tr></table>



