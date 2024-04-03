![Hyprcrux](https://github.com/xsghetti/dotfiles/assets/150515748/a47a8060-0bdd-45de-8e01-2f907a789b7e)

<h4 align="center">Dynamically Colored by Pywal</h4>
<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png">



<div align="center">
    
![GitHub Repo stars](https://img.shields.io/github/stars/xsghetti/dotfiles?style=for-the-badge&logo=github&color=pink)
![GitHub commit activity](https://img.shields.io/github/commit-activity/t/xsghetti/dotfiles?style=for-the-badge&logo=github&color=lightgreen)
![Static Badge](https://img.shields.io/badge/hypr-crux-lightblue?style=for-the-badge)

</div>

>  [!Warning]
>  these are my personal dots and may not work for you.<br>
>  My configs are messy as I'm not a dev, so use at your own risk.

![240324_20h17m04s_screenshot](https://github.com/xsghetti/dotfiles/assets/150515748/bf1ec92c-45ee-4c93-9270-a08a90e98c9b)
![home](https://github.com/xsghetti/dotfiles/assets/150515748/554d17b3-393d-4970-85c6-9b83fa1ecfff)
![rofi](https://github.com/xsghetti/dotfiles/assets/150515748/593456f2-b3aa-4943-8578-53b59d106814)
![wallpaperselector](https://github.com/xsghetti/dotfiles/assets/150515748/f622a625-630c-4eda-bc3e-5298dac5ce99)
![swaync](https://github.com/xsghetti/dotfiles/assets/150515748/d0a9d774-8686-43d1-9d8f-f7c5c88bb047)
![cava](https://github.com/xsghetti/dotfiles/assets/150515748/f65aefcd-4597-4600-bbba-10bf1274cedc)
![hyprlock](https://github.com/xsghetti/dotfiles/assets/150515748/2eaffb84-d53e-42cb-ac62-0d00836d66fc)

## Depenencies <br>
>  [hyprland](https://hyprland.org)<br>
>  [hyprlock](https://github.com/hyprwm/hyprlock)<br>
>  [pywal](https://github.com/dylanaraps/pywal) <br>
>  [swaync](https://github.com/ErikReider/SwayNotificationCenter)<br>
>  [rofi](https://github.com/davatorium/rofi)
## Plugins <br>
>  [hycov](https://github.com/Ayuei/hycov)<br>
>  [hyprtrails](https://github.com/hyprwm/hyprland-plugins/tree/main/hyprtrails) <br>
>  [pyprland](https://github.com/hyprland-community/pyprland) <br>

>[!Note]
>To get cava working with pywal - symlink template to cava/config

    ln -sf "$HOME/.cache/wal/cava-colors" "$HOME/.config/cava/config" || true
>[!Note]
> Hycov Keybindings will be commented out by default
to prevent the error message caused by HyprPM.<br>
HyprTrails is also coded into hyprland.conf but will
not trigger any errors. Feel free to enable them with
the commands below.

    hyprpm update
    
<br>
    
    hyprpm add https://github.com/hyprwm/hyprland-plugins
<br>
    
    hyprpm add https://github.com/Ayuei/hycov
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

<div id="footer" align="center">
    <img alt ="cat decoration" src="./src/footer_cat.svg">
</div>

