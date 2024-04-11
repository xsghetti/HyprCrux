import BatteryBar from "./buttons/BatteryBar.js"
import ColorPicker from "./buttons/ColorPicker.js"
import Date from "./buttons/Date.js"
import Launcher from "./buttons/Launcher.js"
import Media from "./buttons/Media.js"
import PowerMenu from "./buttons/PowerMenu.js"
import SysTray from "./buttons/SysTray.js"
import SystemIndicators from "./buttons/SystemIndicators.js"
import Taskbar from "./buttons/Taskbar.js"
import Workspaces from "./buttons/Workspaces.js"
import ScreenRecord from "./buttons/ScreenRecord.js"
import Messages from "./buttons/Messages.js"
import options from "../../options.js"

const { start, center, end } = options.bar.layout
const pos = options.bar.position

const widget = {
  battery: BatteryBar,
  colorpicker: ColorPicker,
  date: Date,
  launcher: Launcher,
  media: Media,
  powermenu: PowerMenu,
  systray: SysTray,
  system: SystemIndicators,
  taskbar: Taskbar,
  workspaces: Workspaces,
  screenrecord: ScreenRecord,
  messages: Messages,
  expander: () => Widget.Box({ expand: true }),
}

export default (monitor) => Widget.Window({
  monitor,
  class_name: "bar",
  name: `bar${monitor}`,
  exclusivity: "exclusive",
  layer: "top",
  anchor: [pos, "right", "left"],
  child: Widget.CenterBox({
    css: "min-width: 2px; min-height: 2px;",
    startWidget: Widget.Box({
      hexpand: true,
      children: start.map(w => widget[w]()),
    }),
    centerWidget: Widget.Box({
      hpack: "center",
      children: center.map(w => widget[w]()),
    }),
    endWidget: Widget.Box({
      hexpand: true,
      children: end.map(w => widget[w]()),
    }),
  }),
})
