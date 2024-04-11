import { SimpleToggleButton } from "../ToggleButton.js"
import icons from "../../../lib/icons.js"

let scheme = "dark"

export const DarkModeToggle = () => SimpleToggleButton({
  icon: icons.color[scheme],
  label: scheme === "dark" ? "Dark" : "Light",
  toggle: () => scheme = scheme === "dark" ? "light" : "dark",
})
