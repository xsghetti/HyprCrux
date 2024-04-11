import { createSurfaceFromWidget, icon } from "../../lib/utils.js"
import Gdk from "gi://Gdk"
import Gtk from "gi://Gtk?version=3.0"
import options from "../../options.js"
import icons from "../../lib/icons.js"

const monochrome = options.overview.monochromeIcon
const TARGET = [Gtk.TargetEntry.new("text/plain", Gtk.TargetFlags.SAME_APP, 0)]
const scale = (size) => (options.overview.scale / 100) * size
const hyprland = await Service.import("hyprland")
const apps = await Service.import("applications")
const dispatch = (args) => hyprland.messageAsync(`dispatch ${args}`)


const Icon = (m, c) => {
  const app = apps.list.find(app => app.match(c))
  if (!app)
    return icons.fallback.executable

  return icon(
    app.icon_name + (m ? "-symbolic" : ""),
    icons.fallback.executable,
  )
}

export default ({ address, size: [w, h], class: c, title }) => Widget.Button({
  class_name: "client",
  attribute: { address },
  tooltip_text: `${title}`,
  child: Widget.Icon({
    class_name: "overview-icon",
    css: `
            min-width: ${scale(w)}px;
            min-height: ${scale(h)}px;
        `,
    icon: Icon(monochrome, c),
  }),
  on_secondary_click: () => dispatch(`closewindow address:${address}`),
  on_clicked: () => {
    dispatch(`focuswindow address:${address}`)
    App.closeWindow("overview")
  },
  setup: btn => btn
    .on("drag-data-get", (_w, _c, data) => data.set_text(address, address.length))
    .on("drag-begin", (_, context) => {
      Gtk.drag_set_icon_surface(context, createSurfaceFromWidget(btn))
      btn.toggleClassName("hidden", true)
    })
    .on("drag-end", () => btn.toggleClassName("hidden", false))
    .drag_source_set(Gdk.ModifierType.BUTTON1_MASK, TARGET, Gdk.DragAction.COPY),
})
