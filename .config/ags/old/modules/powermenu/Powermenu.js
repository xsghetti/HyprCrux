// import Gtk from 'gi://Gtk';
import { uptime } from '../../lib/variables.js';
import powermenu from '../../services/powermenu.js';
import PopupWindow from "../PopupWindow.js";

const options = [
  {
    label: "lock",
    icon: ""
  },
  {
    label: "sleep",
    icon: ""
  },
  {
    label: "logout",
    icon: ""
  },
  {
    label: "shutdown",
    icon: ""
  },
  {
    label: "reboot",
    icon: ""
  }
];

function buttonCreator(option, flag = 'none') {
  const but = Widget.Button({
    className: 'powermenu-buttonBox',
    child: Widget.Box({
      child: Widget.Label({
        className: 'powermenu-buttonLabel',
        label: option['icon'],
      }),
    }),
    onClicked: () => powermenu.action(option['label']),//Utils.execAsync(option['cmd']),
  })
  if (flag == 'first') {
    but.toggleClassName('powermenu-buttonBoxFirst', true);
  } else if (flag == 'last') {
    but.toggleClassName('powermenu-buttonBoxLast', true);
  }

  return but;
}

const Powermenu = () => {

  let powerbutton = Widget.Box({
    hpack: 'start',
    vpack: 'start',
    className: 'powermenu-powerbutton',
    child: Widget.Label({
      label: "",
      hpack: 'start',
    }),
  })

  const topBox = Widget.Box({
    vertical: false,
    homogeneous: false,
    name: "powermenu-topbox",
    css: `background-image: url('${App.configDir + '/modules/powermenu/imag2.png'}'); background-position: center;`,
    spacing: 0,
    children: [
      Widget.EventBox({
        vexpand: false,
        vpack: 'start',
        child: powerbutton,
        onPrimaryClick: () => {
          App.toggleWindow('powermenu');
        }
      }),
      Widget.Box({
        hpack: 'start',
        vpack: 'start',
        className: 'powermenu-username',
        child: Widget.Label({
          hpack: 'start',
          label: `${Utils.exec('whoami')}`
        })
      })
    ]
  })

  const midBox = Widget.Box({
    hpack: 'fill',
    className: 'powermenu-midbox',
    child: Widget.Label({
      label: uptime.bind().as(value => 'Uptime : ' + Math.floor(value / 60) + ' hours ' + Math.floor(value % 60) + ' minutes'),
      setup: self => self.hook(uptime, () => {
        self.label = uptime.value.toString();
      })
    })
  })

  let bottomBox = Widget.Box({
    vertical: false,
    homogeneous: false,
    name: 'powermenu-bottombox',
    spacing: 20,
    children: [
      buttonCreator(options[0], 'first'),
      buttonCreator(options[1]),
      buttonCreator(options[2]),
      buttonCreator(options[3]),
      buttonCreator(options[4], 'last'),
    ],
  })

  let motherBox = Widget.Box({
    homogeneous: false,
    vertical: true,
    name: 'powermenu-motherbox',
    // hexpand: true,
    // vexpand: false,
    hpack: 'center',
    vpack: 'center',
    children: [topBox, midBox, bottomBox],
  })

  return motherBox;
}

export default () => PopupWindow({
  name: 'powermenu',
  transition: "slide_down",
  child: Powermenu(),
})


// export default () => Widget.Window({
//   name: 'powermenu',
//   anchor: ['top', 'left', 'right', 'bottom'],
//   exclusivity: 'normal',
//   keymode: 'exclusive',
//   layer: 'top',
//   popup: true,
//   // monitor: 0,
//   visible: false,
//   child: Powermenu(),
// })
