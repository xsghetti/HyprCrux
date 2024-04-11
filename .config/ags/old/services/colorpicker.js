import icons from "../lib/icons.js"
import { bash, dependencies } from "../lib/utils.js"

const COLORS_CACHE = Utils.CACHE_DIR + "/colorpicker.json"
const MAX_NUM_COLORS = 10

class ColorPicker extends Service {
  static {
    Service.register(this, {}, {
      "colors": ["jsobject"],
    })
  }

  notifID = 0
  #colors = JSON.parse(Utils.readFile(COLORS_CACHE) || "[]")

  get colors() { return [...this.#colors] }
  set colors(colors) {
    this.#colors = colors
    this.changed("colors")
  }

  // TODO: doesn't work?
  async wlCopy(color) {
    if (dependencies("wl-copy"))
      bash(`wl-copy ${color}`)
  }

  async pick() {
    if (!dependencies("hyprpicker"))
      return

    const color = await bash("hyprpicker -a -r")
    if (!color)
      return

    colorpicker.wlCopy(color)
    const list = colorpicker.colors
    if (!list.includes(color)) {
      list.push(color)
      if (list.length > MAX_NUM_COLORS)
        list.shift()

      colorpicker.colors = list
      Utils.writeFile(JSON.stringify(list, null, 2), COLORS_CACHE)
    }

    colorpicker.notifID = await Utils.notify({
      id: colorpicker.notifID,
      iconName: icons.ui.colorpicker,
      summary: color,
    })
  }
}

const colorpicker = new ColorPicker
export default colorpicker
