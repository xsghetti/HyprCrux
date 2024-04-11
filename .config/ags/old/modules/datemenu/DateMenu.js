import PopupWindow from "../PopupWindow.js"
import DateColumn from "./DateColumn.js"
import options from "../../options.js"

const { bar, datemenu } = options
const pos = bar.position
const layout = `${bar.position}-${datemenu.position}`

const Settings = () => Widget.Box({
  class_name: "datemenu horizontal",
  vexpand: false,
  children: [
    // NotificationColumn(),
    // Widget.Separator({ orientation: 1 }),
    DateColumn(),
  ],
})

const DateMenu = () => PopupWindow({
  name: "datemenu",
  exclusivity: "exclusive",
  transition: pos === "top" ? "slide_down" : "slide_up",
  layout: layout,
  child: Settings(),
})

export function setupDateMenu() {
  App.addWindow(DateMenu())
  // layout.connect("changed", () => {
  //   App.removeWindow("datemenu")
  //   App.addWindow(DateMenu())
  // })
}
