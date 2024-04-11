
// import hyprland from "./hyprland.js"
// import tmux from "./tmux"
// import gtk from "./gtk"
import lowBattery from "./battery.js"
// import swww from "./swww"

export async function init() {
  try {
    // gtk()
    // tmux()
    lowBattery()
    // hyprland()
    // css()
    // swww()
  } catch (error) {
    logError(error)
  }
}
