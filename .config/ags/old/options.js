
const options = {
  recompileSass: true,
  monitorCSS: true,
  theme: {
    PopupTransitionDuration: 400,
    PopupCloseDuration: 300,
  },
  // powermenu: {
  //   sleep: 'systemctl suspend',
  //   lock: 'waylock',
  //   logout: 'hyprctl dispatch exit',
  //   shutdown: 'shutdown now',
  //   reboot: 'reboot',
  // },
  overview: {
    scale: 9,
    workspaces: 8,
    monochromeIcon: false,
  },
  // notifications: {
  //   position: ["top", "right"],
  //   blacklist: ["Spotify"],
  //   width: 440,
  // },
  // transitionDuration: 200,
  // transition: 200,

  // bar: {
  //   flatButtons: true,
  //   position: "bottom",
  //   corners: true,
  //   layout: {
  //     start: [
  //       "launcher",
  //       "workspaces",
  //       "taskbar",
  //       "expander",
  //       // "messages",
  //     ],
  //     center: [
  //       "date",
  //     ],
  //     end: [
  //       "media",
  //       "expander",
  //       "systray",
  //       // "colorpicker",
  //       // "screenrecord",
  //       "system",
  //       "battery",
  //       "powermenu",
  //     ],
  //   },
  //   launcher: {
  //     icon: {
  //       colored: true,
  //       icon: "system-search-symbolic",
  //     },
  //     label: {
  //       colored: false,
  //       label: " Rofi",  // Text that appears with the search icon
  //     },
  //     action: () => Utils.execAsync('bash -c "pkill rofi || rofi -show drun"'),
  //   },
  //   date: {
  //     format: "%H:%M - %A %e.",
  //     action: () => App.toggleWindow("datemenu"),
  //   },
  //   battery: {
  //     bar: "regular",
  //     charging: "#00D787",
  //     percentage: true,
  //     blocks: 10,
  //     width: 70,
  //     low: 30,
  //   },
  //   workspaces: {
  //     workspaces: 7,
  //   },
  //   taskbar: {
  //     monochrome: false,
  //     exclusive: true,
  //   },
  //   messages: {
  //     action: () => App.toggleWindow("datemenu"),
  //   },
  //   systray: {
  //     ignore: [
  //       "KDE Connect Indicator",
  //       "spotify-client",
  //     ],
  //   },
  //   media: {
  //     monochrome: false,
  //     preferred: "spotify",
  //     direction: "right",
  //     length: 40,
  //   },
  //   powermenu: {
  //     monochrome: false,
  //     action: () => App.toggleWindow("powermenu"),
  //   },
  // },
  // osd: {
  //   progress: {
  //     vertical: false,
  //     pack: {
  //       h: "center",
  //       v: "end",
  //     },
  //   },
  //   microphone: {
  //     pack: {
  //       h: "center",
  //       v: "center",
  //     },
  //   },
  // },
  // datemenu: {
  //   position: "center",
  // },

  // quicksettings: {
  //   avatar: {
  //     image: `/var/lib/AccountsService/icons/${Utils.USER}`,
  //     size: 70,
  //   },
  //   width: 380,
  //   position: "right",
  //   networkSettings: "gtk-launch gnome-control-center",
  //   media: {
  //     monochromeIcon: false,
  //     coverSize: 100,
  //   },
  // },
};

export default options;
