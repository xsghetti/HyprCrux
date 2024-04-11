import icons from "../../../lib/icons.js"
import PanelButton from "../PanelButton.js"
import options from "../../../options.js"

const { monochrome, action } = options.bar.powermenu

export default () => PanelButton({
  window: "powermenu",
  on_clicked: action,
  child: Widget.Icon(icons.powermenu.shutdown),
  setup: self => {
    self.toggleClassName("colored", !monochrome)
    self.toggleClassName("box")
  },
})
