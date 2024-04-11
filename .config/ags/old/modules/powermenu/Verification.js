
import PopupWindow from '../PopupWindow.js';
import powermenu from '../../services/powermenu.js';

export default () => PopupWindow({
  name: "verification",
  transition: "crossfade",
  layout: 'center',
  child: Widget.Box({
    class_name: "verification",
    vertical: true,
    homogeneous: false,
    children: [
      Widget.Box({
        class_name: "verification-label",
        vertical: true,
        children: [
          Widget.Label({
            class_name: "desc",
            label: powermenu.bind("title"),
          }),
        ],
      }),
      Widget.Box({
        vexpand: true,
        vpack: "end",
        spacing: 20,
        homogeneous: false,
        children: [
          Widget.Button({
            class_name: "verification-buttonBox verification-buttonBoxFirst",
            child: Widget.Label({
              label: "No",
              hpack: "center",
              vpack: "center",
            }),
            on_clicked: () => App.toggleWindow("verification"),
            setup: self => self.hook(App, (_, name, visible) => {
              if (name === "verification" && visible)
                self.grab_focus()
            }),
          }),
          Widget.Button({
            class_name: "verification-buttonBox verification-buttonBoxLast",
            child: Widget.Label({
              label: "Yes",
              hpack: "center",
              vpack: "center",
            }),
            on_clicked: () => Utils.exec(powermenu.cmd),
          }),
        ],
      }),
    ],
  }),
})


// export default () => Widget.Window({
//   name: 'verification',
//   // transition: 'crossfade',
//   anchor: ['top', 'left', 'right', 'bottom'],
//   exclusivity: 'normal',
//   keymode: 'exclusive',
//   layer: 'top',
//   popup: true,
//   // monitor: 0,
//   visible: false,
//   child: Verification(),
// })
