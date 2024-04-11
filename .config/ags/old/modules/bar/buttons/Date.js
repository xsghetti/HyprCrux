import clock from "../../../services/clock.js"
import PanelButton from "../PanelButton.js"
import options from "../../../options.js"

const { format, action } = options.bar.date
// const time = Utils.derive([clock], (c) => {
//   c.format(format) || ""
// })


// const time = Variable('', {
//   poll: [1000, `date "+${format}"`],
// });

export default () => PanelButton({
  window: "dashboard",
  on_clicked: action,
  child: Widget.Label({ label: clock.bind('time').as(t => `${t.format(format)}`) }),
})
