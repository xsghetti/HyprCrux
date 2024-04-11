// import Gtk from 'gi://Gtk';

/** @param {string} windowName */
const Padding = windowName => Widget.EventBox({
  class_name: 'padding',
  hexpand: true,
  vexpand: true,
  setup: w => w.on('button-press-event', () => App.toggleWindow(windowName)),
});

const Dock = () => {
  return Widget.Box({
    name: 'dock-box',
    child: Widget.Label({
      label: "Yo Yo YO YO bfbhgjhdfvbfb",
    })
  })
}


export default () => Widget.Window({
  name: 'dock',
  anchor: ['bottom'],
  exclusivity: 'normal',
  keymode: 'on-demand',
  layer: 'background',
  // popup: true,
  // monitor: 0,
  visible: true,
  child: Dock(),
})
