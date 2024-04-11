import PanelButton from "../PanelButton.js"
import options from "../../../options.js"

const { icon, label, action } = options.bar.launcher

export default () => PanelButton({
  window: "launcher",
  on_clicked: action,
  child: Widget.Box([
    Widget.Icon({
      class_name: icon.colored ? "colored" : "",
      visible: !!icon.icon,
      icon: icon.icon,
    }),
    Widget.Label({
      class_name: label.colored ? "colored" : "",
      visible: !!label.label,
      label: label.label,
    }),
  ]),
})
