import { uptime } from "../../lib/variables.js"
import clock from "../../services/clock.js"

function up(up) {
  const h = Math.floor(up / 60)
  const m = Math.floor(up % 60)
  return `uptime: ${h}:${m < 10 ? "0" + m : m}`
}

export default () => Widget.Box({
  vertical: true,
  class_name: "date-column vertical",
  children: [
    Widget.Box({
      class_name: "clock-box",
      vertical: true,
      children: [
        Widget.Label({
          class_name: "clock",
          label: clock.bind('time').as(t => t.format("%H:%M")),
        }),
        Widget.Label({
          class_name: "uptime",
          label: uptime.bind().as(up),
        }),
      ],
    }),
    Widget.Box({
      class_name: "calendar",
      children: [
        Widget.Calendar({
          hexpand: true,
          hpack: "center",
        }),
      ],
    }),
  ],
})
