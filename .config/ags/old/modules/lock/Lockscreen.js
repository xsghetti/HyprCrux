import GLib from 'gi://GLib'

const time = Widget.Label({
  name: 'lockscreen-time',
  label: GLib.DateTime.new_now_local().format("%H:%M"),
  setup: (self) => self.poll(1000, label => {
    label.label = GLib.DateTime.new_now_local().format("%H:%M");
  }),
  justification: 'left',
  hexpand: true,
  hpack: 'start',
})

const date = Widget.Label({
  name: 'lockscreen-date',
  label: GLib.DateTime.new_now_local().format("%e, %B %A"),
  setup: (self) => self.poll(60000, label => {
    label.label = GLib.DateTime.new_now_local().format("%e, %B %A");
  }),
  justification: 'left',
})

const network = await Service.import('network')
const battery = await Service.import('battery')


const Lockscreen = () => {
  const WifiIndicator = () => Widget.Box({
    child: Widget.Icon({
      icon: network.wifi.bind('icon_name'),
    }),
  })

  const WiredIndicator = () => Widget.Icon({
    icon: network.wired.bind('icon_name'),
  })

  const batPercent = Widget.Revealer({
    revealChild: false,
    transitionDuration: 600,
    transition: 'slide_left',
    child: Widget.Label({
      name: "lockscreen-revealer",
      label: battery.bind('percent').transform(p => "" + p + "%"),
    }),
  })

  const batInfo = Widget.Box({
    "class-name": 'lockscreen-smolbox',
    hexpand: false,
    hpack: 'end',
    children: [
      batPercent,
      Widget.EventBox({
        child: Widget.Box({
          child: Widget.Label({
            label: battery.bind('percent').transform(p => ['', '', '', '', ''][Math.floor(p / 20)]),
            class_name: 'lockscreen-battery',
            hexpand: false,
            setup: icon => icon.hook(battery, () => {
              icon.toggleClassName('lockscreen-charging', battery.charging);
              icon.toggleClassName('lockscreen-charged', battery.charged);
              icon.toggleClassName('lockscreen-low', battery.percent < 30);
            }),
          }),
        }),
        onHover: () => {
          batPercent.reveal_child = true;
          print("revealed");
        },
        onHoverLost: () => {
          batPercent.reveal_child = false;
        }
      })
    ]
  })

  const networkName = Widget.Revealer({
    revealChild: false,
    transitionDuration: 600,
    transition: 'slide_left',
    child: Widget.Label({
      name: "lockscreen-revealer",
      label: network.wifi.bind('ssid')
        .as(ssid => ssid || 'Unknown'),
    }),
  })

  const networkStatus = Widget.Box({
    class_name: "lockscreen-smolbox",
    hexpand: false,
    hpack: 'end',
    children: [
      networkName,
      Widget.EventBox({
        child: Widget.Stack({
          class_name: "lockscreen-network",
          children: {
            'wifi': WifiIndicator(),
            'wired': WiredIndicator()
          },
          shown: network.bind('primary').transform(p => p || 'wifi'),
        }),
        onHover: () => {
          networkName.reveal_child = true;
        },
        onHoverLost: () => {
          networkName.reveal_child = false;
        }
      })
    ]
  })

  const boxRight = Widget.Box({
    homogeneous: false,
    name: "lockscreen-boxRight",
    vertical: true,
    hexpand: false,
    children: [networkStatus, batInfo],
    vpack: 'end',
    hpack: 'end',
  })

  const boxLeft = Widget.Box({
    homogeneous: false,
    vertical: true,
    children: [time, date],
    vpack: 'end',
    hpack: 'start',
  })

  return Widget.Box({
    children: [boxLeft, boxRight],
    vertical: false,
  })
}

function randomImage() {
  const a = Utils.exec(`bash -c "ls ${App.configDir + '/modules/lock/images/'} | shuf -n 1"`);
  const b = `background-image: url("${App.configDir + '/modules/lock/images/' + a}");`;
  print(b);
  return b;

}

export default () => Widget.Window({
  name: 'lockscreen',
  css: randomImage(),
  anchor: ['top', 'left', 'right', 'bottom'],
  exclusivity: 'normal',
  keymode: 'on-demand',
  layer: 'top',
  visible: false,
  monitor: 0,
  child: Lockscreen(),
})
