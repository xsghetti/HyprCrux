import { ProfileSelector, ProfileToggle } from "./widgets/AsusProfile.js"
// import { Header } from "./widgets/Header.js"
import { Volume, Microhone, SinkSelector, AppMixer } from "./widgets/Volume.js"
import { Brightness } from "./widgets/Brightness.js"
import { NetworkToggle, WifiSelection } from "./widgets/Network.js"
import { BluetoothToggle, BluetoothDevices } from "./widgets/Bluetooth.js"
import { DND } from "./widgets/DND.js"
// import { DarkModeToggle } from "./widgets/DarkMode.js"
import { MicMute } from "./widgets/MicMute.js"
import { Media } from "./widgets/Media.js"
import PopupWindow from "../PopupWindow.js"
import NotificationColumn from "./NotificationColumn.js"
import options from "../../options.js"

const { bar, quicksettings } = options
const media = (await Service.import("mpris")).bind("players")
const layout = `${quicksettings.position}`


const Row = (
  toggles = [],
  menus = [],
) => Widget.Box({
  vertical: true,
  children: [
    Widget.Box({
      homogeneous: true,
      class_name: "row horizontal",
      children: toggles.map(w => w()),
    }),
    ...menus.map(w => w()),
  ],
})

const Settings = () => Widget.Box({
  vertical: true,
  vexpand: true,
  vpack: "fill",
  class_name: "quicksettings vertical",
  css: `min-width: ${quicksettings.width}px;`,
  children: [
    // Header(),
    Widget.Box({
      class_name: "sliders-box vertical",
      vertical: true,
      children: [
        Row(
          [Volume],
          [SinkSelector, AppMixer],
        ),
        Microhone(),
        Brightness(),
      ],
    }),
    Row(
      [NetworkToggle, BluetoothToggle],
      [WifiSelection, BluetoothDevices],
    ),
    Row(
      [ProfileToggle],
      [ProfileSelector],
    ),
    Row([MicMute, DND]),
    Widget.Box({
      visible: media.as(l => l.length > 0),
      child: Media(),
    }),
    NotificationColumn(),
  ],
})

const QuickSettings = () => PopupWindow({
  name: "quicksettings",
  transition: "slide_left", //bar.position === "top" ? "slide_down" : "slide_up",
  // anchor: ["right", "top"],
  keymode: 'on-demand',
  layout: layout,
  child: Settings(),
  vpack: "fill",
  // hpack: "fill",
  vexpand: true,
  // hexpand: true,
})

export function setupQuickSettings() {
  App.addWindow(QuickSettings())
}
