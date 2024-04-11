import PopupWindow from "./modules/PopupWindow.js";


export default () => PopupWindow({

  name: "test",
  exclusivity: "ignore",
  // transition: "slide_left", //bar.position === "top" ? "slide_down" : "slide_up",
  // anchor: ["top"],
  layout: "right",
  // anchor: ["right", "bottom", "top"],
  child: Widget.Label({
    label: "No sex",
    css: `background-color: #0e0e0e;
  border: 2px solid #FFFFFF;`,
    // vpack: "fill",
    // hpack: "fill",
    vexpand: true,
    hexpand: true,
  }),
  // vpack: "fill",
  // hpack: "fill",
  vexpand: true,
  hexpand: true,
})
