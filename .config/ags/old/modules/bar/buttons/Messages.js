import icons from "../../../lib/icons.js"
import PanelButton from "../PanelButton.js"
import options from "../../../options.js"

const n = await Service.import("notifications")
const notifs = n.bind("notifications")
const action = options.bar.messages.action

export default () => PanelButton({
  class_name: "messages",
  on_clicked: action,
  visible: notifs.as(n => n.length > 0),
  child: Widget.Box([
    Widget.Icon(icons.notifications.message),
  ]),
})
