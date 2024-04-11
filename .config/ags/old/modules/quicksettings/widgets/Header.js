import icons from "../../../lib/icons.js"
import { uptime } from "../../../lib/variables.js"
import options from "../../../options.js"
import powermenu from "../../../services/powermenu.js"

const battery = await Service.import("battery")
const { image, size } = options.quicksettings.avatar

function up(up) {
  const h = Math.floor(up / 60)
  const m = Math.floor(up % 60)
  return `${h}h ${m < 10 ? "0" + m : m}m`
}

const Avatar = () => Widget.Box({
  class_name: "avatar",
  css: `
        min-width: ${size}px;
        min-height: ${size}px;
        background-image: url('${image}');
        background-size: cover;
    `,
})

const SysButton = (action) => Widget.Button({
  vpack: "center",
  child: Widget.Icon(icons.powermenu[action]),
  on_clicked: () => powermenu.action(action),
})

export const Header = () => Widget.Box(
  { class_name: "header horizontal" },
  Avatar(),
  Widget.Box({
    vertical: true,
    vpack: "center",
    children: [
      Widget.Box([
        Widget.Icon({ icon: battery.bind("icon_name") }),
        Widget.Label({ label: battery.bind("percent").as(p => `${p}%`) }),
      ]),
      Widget.Box([
        Widget.Icon({ icon: icons.ui.time }),
        Widget.Label({ label: uptime.bind().as(up) }),
      ]),
    ],
  }),
  Widget.Box({ hexpand: true }),
  Widget.Button({
    vpack: "center",
    child: Widget.Icon(icons.ui.settings),
    on_clicked: () => {
      App.closeWindow("quicksettings")
      App.closeWindow("settings-dialog")
      App.openWindow("settings-dialog")
    },
  }),
  SysButton("logout"),
  SysButton("shutdown"),
)
