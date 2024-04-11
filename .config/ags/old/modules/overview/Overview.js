import PopupWindow from "../PopupWindow.js"
import Workspace from "./Workspace.js"
import options from "../../options.js"
import { range } from "../../lib/utils.js"

const hyprland = await Service.import("hyprland")

const Overview = (ws) => Widget.Box({
  class_name: "overview horizontal",
  // spacing: 10,
  children: ws > 0
    ? range(ws).map(Workspace)
    : hyprland.workspaces
      .map(({ id }) => Workspace(id))
      .sort((a, b) => a.attribute.id - b.attribute.id),

  setup: w => {
    if (ws > 0)
      return

    w.hook(hyprland, (w, id) => {
      if (id === undefined)
        return

      w.children = w.children
        .filter(ch => ch.attribute.id !== Number(id))
    }, "workspace-removed")
    w.hook(hyprland, (w, id) => {
      if (id === undefined)
        return

      w.children = [...w.children, Workspace(Number(id))]
        .sort((a, b) => a.attribute.id - b.attribute.id)
    }, "workspace-added")
  },
})

export default () => PopupWindow({
  name: "overview",
  layout: "center",
  transition: "slide_down",
  child: Overview(options.overview.workspaces),
})
